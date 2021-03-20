#' Query an emuDB and return labels
#'
#'
#'
#' @param emuDBhandle The emuDB handle object (see \link[emuR]{load_emuDB}).
#' @param query Query expression as a string (see \code{vignette("EQL", package
#'   = "emuR")})
#' @param labels_from Names of levels whose labels should be returned. The level
#'   returned by the query expression is returned by default in the column
#'   `labels`.
#' @param ... Further arguments passed to \link[emuR]{query}.
#'
#' @return A tibble.
#' @export
#'
#' @examples
#' library(tidyverse)
#' library(emuR)
#' 
#' create_emuRdemoData(dir = tempdir())
#' # build base path to demo emuDB
#' demoDatabaseDir = file.path(tempdir(), "emuR_demoData", "ae_emuDB")
#' 
#' # load demo emuDB
#' ae = load_emuDB(demoDatabaseDir)
#' 
#' query_hier(ae, "Phonetic == S", c("Word", "Syllable"))
query_hier <- function(emuDBhandle, query, labels_from = NULL, ...) {
  que <- emuR::query(emuDBhandle, query, ...)
  
  if (!is.null(labels_from)) {
    que_labs <- que
    for (level in labels_from) {
      reque <- emuR::requery_hier(emuDBhandle, que, level, calcTimes = F) %>%
        dplyr::select(!!rlang::sym(level) := labels)
      que_labs <- dplyr::bind_cols(que_labs, reque)
    }
    return(que_labs)
  } else {
    return(que)
  }
}
