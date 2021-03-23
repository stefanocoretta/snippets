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
#' @param labels_times If `TRUE`, get start and end time of all levels (default
#'   is `FALSE`).
#' @param get_meta If `TRUE`, get emuR metadata (default is `FALSE`).
#' @param ... Further arguments passed to \link[emuR]{query}.
#'
#' @return A tibble.
#' @importFrom magrittr %>%
#' @name %>%
#' @rdname pipe
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
query_hier <- function(emuDBhandle, query, labels_from = NULL, labels_times = FALSE, get_meta = FALSE, ...) {
  que <- emuR::query(emuDBhandle, query, ...)
  
  level_name <- que$level[1]
  
  if (!is.null(labels_from)) {
    que_labs <- que
    for (level in labels_from) {
      if (labels_times) {
        reque <- emuR::requery_hier(emuDBhandle, que, level, calcTimes = T) %>%
          dplyr::select(
            !!rlang::sym(level) := labels,
            !!rlang::sym(paste0(level, "_start")) := start,
            !!rlang::sym(paste0(level, "_end")) := end
          )
      } else {
        reque <- emuR::requery_hier(emuDBhandle, que, level, calcTimes = F) %>%
          dplyr::select(!!rlang::sym(level) := labels)
      }
      que_labs <- dplyr::bind_cols(que_labs, reque)
    }
    que <- que_labs
  }
  
  que <- que %>%
    rename(
      !!rlang::sym(level_name) := labels,
      !!rlang::sym(paste0(level_name, "_start")) := start,
      !!rlang::sym(paste0(level_name, "_end")) := end
    ) %>%
    select(-level) %>%
    relocate(session, bundle, attribute, type)
  
  if (!get_meta) {
    que <- que %>%
      select(-db_uuid, -matches("_idx?$"), -starts_with("sample_"))
  }
  
  return(que)
}
