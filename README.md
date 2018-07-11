# Getting-and-Cleaning-Data-Week-4-Project

## run_analysis.R
This file is the script which does the work of downloading the data to the current working directory, unzips the file, reads all of the relevant files into R, combines and merges all the files, reorganizes, subsets, etc.

There are comments before each R command or set of commands within the file which are quite descriptive and makes the code easy to follow and understand my logic and decisions. There are more than likely places in the code where I could have used a better method or maybe even used fewer lines, but the outcome is more or less the same.

The code produces a file called "tidydata.txt" in the working directory which is avaiable for viewing on my Coursera submission. It is, indeed, "tidy data" as described by the lectures and assignment instructions.

## codebok.md
This file contains the codebook which is actually a modified version of the "features_info.txt" that came with the original download of the files. I made this decision because with 66 different variables, it would have been too time consuming to retype them all and provide a description for each x,y,z mean and standard deviation. This way, it is more concise and easier to understand for both the writer and the reader.
