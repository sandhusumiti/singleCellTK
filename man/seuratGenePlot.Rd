% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/seuratFunctions.R
\name{seuratGenePlot}
\alias{seuratGenePlot}
\title{Compute and plot visualizations for marker genes}
\usage{
seuratGenePlot(
  inSCE,
  scaledAssayName = "seuratScaledData",
  plotType,
  features,
  groupVariable,
  ncol
)
}
\arguments{
\item{inSCE}{Input \code{SingleCellExperiment} object.}

\item{scaledAssayName}{Specify the name of the scaled assay stored in the input object.}

\item{plotType}{Specify the type of the plot to compute. Options are limited to "ridge", "violing", "feature", "dot" and "heatmap".}

\item{features}{Specify the features to compute the plot against.}

\item{groupVariable}{Specify the column name from the colData slot that should be used as grouping variable.}

\item{ncol}{Visualizations will be adjusted in "ncol" number of columns.}
}
\value{
Plot object
}
\description{
Compute and plot visualizations for marker genes
}
