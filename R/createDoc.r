# Create Documentation file section arguments from .r-source
# Berry Boessenkool, June + Dec 2014
# This assumes the following structure of source code:

# MyFun <- function(
# arg1, # Explanation of this item
# arg2=TRUE, # Ditto, with default
# arg3)
# {

# PS: Roxygen doesn't really get this structure, as far as I know.

createDoc <- function(
  fun, # Character string. Function (== filename) with correct structure in source code.
  path="S:/Dropbox/Public/berryFunctions" # Path to package in development containing folders "R" and 'man'.
  )
{
fun <- deparse(substitute(fun))
fun <- gsub("\"", "", fun, fixed=TRUE)
if(length(fun) >1) stop("'fun' must be a single function name.")
if(length(path)>1) stop("'path' must be a single character string.")
# work PC path change:
if(!file.exists(path)) substr(path, 1,1) <- "D"
# laptop linux path change:
if(!file.exists(path)) { substr(path, 1,1) <- "~" ; substr(path, 2,2) <- "" }
# path control
if(!file.exists(path)) stop("path does not exist.", path)
owd <- setwd(path)
#
rfilename <- paste0("R/",fun,".r")
if(!file.exists(rfilename)) rfilename <- paste0("R/",fun,".R")
if(!file.exists(rfilename)) stop("File ", path, "/", rfilename, " does not exist")
# case control Windows:
if(!any(dir("R")==paste0(fun,".r")|dir("R")==paste0(fun,".R"))) stop("'", fun,
   "' does not match capitalization of files in ", path, "/R")
# read file
rfile <- readLines(rfilename)
rfile <- rfile[removeSpace(rfile)!=""]
anf <- grep("<- function", rfile)[1]
end <- which(removeSpace(rfile)=="{")[1]
if (end < anf) stop("Argument section was not correctly identified!")
#
rdfile <- paste0("man/",fun,".Rd")
# File name check (fnc):
Newfilecreated <- FALSE
for(fnc in 1:99) 
  if(file.exists(rdfile))
    {
    rdfile <- paste0("man/",fun,"_", fnc,".Rd")
    Newfilecreated <- TRUE
    }
if(Newfilecreated) warning("File already existed. Created the file ", path, "/", rdfile)
# HEADER
cat(paste0("\\name{", fun, "}\n\\alias{", fun, "}\n"), file=rdfile)
cat(paste0("\\title{}\n\\description{}\n\\usage{", fun , "("), file=rdfile, append=TRUE)
# USAGE
# ignore comments:
usage <- sapply(strsplit(rfile[(anf+1):(end-1) ], "#"), "[", 1)
# Remove leading and trailing white spaces:
usage <- sub("^[[:space:]]*(.*?)[[:space:]]*$", "\\1", usage, perl=TRUE)
# ignore empty lines:
usage <- usage[usage!=""]
# double the backslashes:
usage <- gsub("\\n", "\\\\n", usage, fixed=TRUE)
usage <- gsub("\\t", "\\\\t", usage, fixed=TRUE)
# write section:
cat(paste(usage, collapse=" "), file=rdfile, append=TRUE)
# ARGUMENTS
cat(paste0("}\n\\arguments{\n"), file=rdfile, append=TRUE)
for(i in (anf+1):(end-1) )
  {
  # Split argument and explanation:
  arg_expl <- strsplit(rfile[i], "#")[[1]]
  # Remove leading and trailing white spaces:
  arg_expl <- sub("^[[:space:]]*(.*?)[[:space:]]*$", "\\1", arg_expl, perl=TRUE)
  # double the backslashes:
  arg_expl <- gsub("\\n", "\\\\n", arg_expl, fixed=TRUE)
  arg_expl <- gsub("\\t", "\\\\t", arg_expl, fixed=TRUE)
  #arg_expl <- gsub("\\", "\\\\", arg_expl, fixed=TRUE)
  # remove trailing comma in Argument:
  if(grepl("[,]$", arg_expl[1]))
     arg_expl[1] <- substring(arg_expl[1], 1, nchar(arg_expl[1])-1)
  # split arg name and default value:
  if(grepl("=", arg_expl[1]))
     arg_expl[c(1,3)] <- strsplit(
       sub("=", "firstEqualSplit", arg_expl[1]), "firstEqualSplit")[[1]]
  # Dots:
  if(grepl("...", arg_expl[1], fixed=TRUE)) arg_expl[1] <- "\\dots"
  # Write to Rd-File:
  if( arg_expl[1] != ")" )
    {
    # write arg name and explanation
    cat(paste0("  \\item{",arg_expl[1],"}{",arg_expl[2]), file=rdfile, append=TRUE)
    # write default value:
    if(length(arg_expl)==3 & !grepl("default:", arg_expl[2], ignore.case=TRUE) )
      cat(paste0(if(!grepl("[.?!]$", arg_expl[2]))".", " DEFAULT: ", arg_expl[3]),
          file=rdfile, append=TRUE)
    #
    cat("}\n", file=rdfile, append=TRUE)
    }
  } # End Loop
# FOOTER
cat(paste0("}
\\details{}
\\value{}
\\section{Warning}{}
\\note{}
\\author{Berry Boessenkool, \\email{berry-b@gmx.de}, 2015}
\\references{}
\\seealso{\\code{\\link{help}} }
\\examples{

}
\\keyword{}
\\keyword{}
"), file=rdfile, append=TRUE)
# warning if there are less argument lines than arguments themselves:
if(removeSpace(rfile[end-1]) ==")") end <- end-1
source(rfilename)
n_missing <- length(formals(fun))  -  (end-anf-1)
if(n_missing != 0) warning(n_missing, " items are missing in the arguments section.
There probably are several arguments on one line in ", path, "/", rfilename,
"\nMost likely, the 'DEFAULT: ' at the line end is corrupted as well.")
# file location:
if(!Newfilecreated) message("Created the file ", path, "/", rdfile)
# set wd back to old working directory:
setwd(owd)
} # End of Function
