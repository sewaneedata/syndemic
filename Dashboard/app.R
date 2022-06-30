
library(shiny)
library(shinydashboard)
library(shinythemes)

ui <- dashboardPage(skin = "black",
                    dashboardHeader(),
                    dashboardSidebar(),
                    dashboardBody()
)

server <- function(input, output) { }

shinyApp(ui, server)