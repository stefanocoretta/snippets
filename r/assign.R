# List all the wordlist files in the WD and save it in "files"
files <- list.files()

# Loop for randomize and sample each wordlists in "files"
for (i in 1:length(files)) {
  # Load wordlists one by one as listed in "files"
  for (i in 1:length(files)) {
    file.name <- files[i] # save wordlist file name
    assign(file.name, read.delim(files[i], header=FALSE))
  }
}