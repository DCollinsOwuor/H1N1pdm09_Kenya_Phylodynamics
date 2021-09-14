# Script for re-estimating the number of A(H1N1)pdm09 virus introductions into Kenya
# Author:   Nicola F. Müller
# Last updated:   10-April-2021
# 1.Clear data in memory, load packages, set working directory, and load dataset

if (!requireNamespace("ggplot2", quietly = TRUE))
  install.packages("ggplot2")

# clear workspace
rm(list = ls())

# Add up down scaler, change time steps, and sampling proportion to be the same over the entire period

# Set the directory to the directory of the file
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

# Read metadata and transmission clusters
t = read.table("./data/h1n1pdm09_metadata.tsv", sep="\t", header=T, na.strings="")

pdf("Introductions.pdf", width = 10, height = 7)

dat = data.frame()
for (i in seq(2,length(t$cluster), 10)){
  print(i)
  dat.loc = data.frame()
  for (r in seq(1,100)){
    u = unique(sample(t$cluster, i, replace = FALSE, prob = NULL))
    dat = rbind(dat, data.frame(x=i, y=length(u)))
  }
}

require("ggplot2")
ggplot(dat, aes(x=x, y=y)) + geom_count() +
  xlab("Number of samples") +
  ylab("Number of sampled introductions")

dev.off()
