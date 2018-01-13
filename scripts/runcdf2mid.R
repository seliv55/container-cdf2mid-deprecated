#!/usr/bin/env Rscript

suppressPackageStartupMessages(library(optparse))

options_list<-list(
  make_option(c("--input","-i"),help="Input path"),
  make_option(c("--output","-o"),help="ouput full path name, directories and files will be created here"),
  make_option(c("--cdfdir","-z"),help="directory containing .CDFs")
)

parser = OptionParser(option_list = options_list)
opt<-parse_args(parser,positional_arguments = FALSE)

if(!("input" %in% names(opt)) || !("output" %in% names(opt)) ) {
  print("no argument given!")
  print_help(parser)
  q(status = 1,save = "no")
}

library("cdf2mid")

library(ncdf4) # library reading cdf   inFile=opt$input,

source(opt$input)

metan( outfile=opt$output, cdfzip=opt$cdfdir)

