#!/usr/bin/env littler

if (is.null(argv) | length(argv)<1) {
  cat("Usage: installr.r pkg1 [pkg2 pkg3 ...]\n")
  q()
}

## adjust as necessary, see help('download.packages')
repos <- "http://cran.rstudio.com"

## this makes sense on Debian where no packages touch /usr/local
lib.loc <- "~/Rlibs/"

install.packages(argv, lib.loc, repos)
