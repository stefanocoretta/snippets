# get_maus.R
#
# Stefano Coretta
# 2020/08/07
#
# Get MAUS segmentation from .wav and .txt files

library(tidyverse)
library(httr)
library(XML)
library(parallel)

# List of .txt files with spelling (audio files should have the same name as the
# .txt files)
files <- list.files(
  "./data/audio", pattern = "*.txt", full.names = TRUE, recursive = TRUE
)

# Initiate cluster
cl <- makeCluster(8, type = "FORK")

# Parallel loop through the files.
# Change the LANGUAGE parameter to suit your needs.
parLapply(
  cl,
  files,
  function(text) {
    name <- str_sub(text, 1, -5)
    wav <- paste0(str_sub(text, 1, -5), ".wav")

    cat(name, sep = "\n")

    curl_params <- list(
      LANGUAGE = "eng",
      PIPE = "G2P_CHUNKER_MAUS",
      TEXT = httr::upload_file(text),
      SIGNAL = httr::upload_file(wav),
      OUTFORMAT = "TextGrid"
    )

    res <- httr::POST(
      url = paste0(
        "https://clarin.phonetik.uni-muenchen.de/BASWebServices/services/",
        "runPipeline"
      ),
      body = curl_params
    )

    res_content <- xmlToList(xmlParse(rawToChar(res$content)))

    if (res_content$success == "true") {
      get_res <- GET(
        res_content$downloadLink,
        write_disk(
          paste0(str_sub(text, 1, -5), "_maus.TextGrid"), overwrite = TRUE
        )
      )
    } else {
      cat(name, " no success!\n")
    }
  }
)