shinyPanelFS_DimRed <- fluidPage(
  tabsetPanel(
    tabPanel("Feature Selection",
        fluidRow(
                    column(4,
                        fluidRow(
                            column(12,
                                panel(heading = "Compute HVG",
                                    selectInput(
                                        inputId = "hvgMethodFS",
                                        label = "Select HVG method: ",
                                        choices = c(
                                        "Seurat - vst" = "vst", 
                                        "Seurat - mean.var.plot" = "mean.var.plot", 
                                        "Seurat - dispersion" = "dispersion",
                                        "Scran - modelGeneVar" = "modelGeneVar")),
                                    selectInput(
                                        inputId = "assaySelectFS",
                                        label = "Select assay:",
                                        choices = currassays),
                                    textInput(
                                        inputId = "hvgNoFeaturesFS",
                                        label = "Select number of features to find: ",
                                        value = "2000"),
                                    actionButton(
                                        inputId = "findHvgButtonFS",
                                        label = "Find HVG")
                                     )
                                  )
                                ),
                        br(),
                        fluidRow(
                            column(12,
                                panel(heading = "Display HVG",
                                    textInput(
                                        inputId = "hvgNoFeaturesViewFS",
                                        label = "Select number of features to display: ",
                                        value = "100"),
                                    verbatimTextOutput(
                                        outputId = "hvgOutputFS",
                                        placeholder = TRUE)
                                     )
                                  )
                                )
                          ),
                     column(8,
                        fluidRow(
                            column(12,
                                panel(heading = "Plot",
                                    plotOutput(
                                        outputId = "plotFS")
                                     )
                                  )
                                )
                           )
                    )
    ),
    tabPanel("Run New Dimensional Reduction",
      # SHINYJS COLLAPSE --------------------------
      # Section 1 - Assay Settings
      # open by default
      tags$div(id = "dimred",
               wellPanel(
                 fluidRow(
                   column(8,
                          wellPanel(
                            fluidRow(
                              column(6,
                                     tags$h4("Select:"),
                                     selectInput("dimRedAssaySelect", "Assay:", currassays),
                                     # Note: Removed "Dendrogram" option from method select to disable conditionalPanels.
                                     selectInput("dimRedPlotMethod", "Method:", c("PCA", "tSNE", "UMAP")),
                                     tags$br(),
                                     withBusyIndicatorUI(actionButton("runDimred", "Run"))
                              ),
                              column(6,
                                     tags$h4("DR Options:"),
                                     textInput("dimRedNameInput", "reducedDim Name:", ""),
                                     tags$br(),
                                     HTML('<button type="button" class="btn btn-default btn-block"
                                          data-toggle="collapse" data-target="#c-collapse-run-options">
                                          View More Options</button>'
                                     ),
                                     tags$div(
                                       id = "c-collapse-run-options", class = "collapse",
                                       conditionalPanel(
                                         condition = sprintf("input['%s'] == 'UMAP'", "dimRedPlotMethod"),
                                         sliderInput("iterUMAP", "# of iterations", min = 50, max = 500, value = 200),
                                         sliderInput("neighborsUMAP", "# of nearest neighbors", min = 2, max = 100, value = 5),
                                         numericInput("alphaUMAP", "learning rate(alpha)", value = 1)
                                       ),
                                       conditionalPanel(
                                         condition = sprintf("input['%s'] == 'tSNE'", "dimRedPlotMethod"),
                                         sliderInput("iterTSNE", "# of iterations", min = 100, max = 2000, value = 1000),
                                         sliderInput("perplexityTSNE", "Perplexity paramter", min = 5, max = 50, value = 5)
                                       )
                                     )
                              )
                            )
                          )
                   ),
                   column(4,
                          wellPanel(
                            h4("Available Reduced Dims:"),
                            tableOutput("reducedDimsList"),
                            tags$hr(),
                            h4("Remove a reducedDim:"),
                            fluidRow(
                              column(8,
                                     selectInput("delRedDimType", label = NULL, currreddim)
                              ),
                              column(4,
                                     withBusyIndicatorUI(actionButton("delRedDim", "Delete"))
                              )
                            )
                          )
                   )
                 )
               )
      )
    )
  )
)