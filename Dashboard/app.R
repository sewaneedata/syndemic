
library(shiny)
library(shinydashboard)
library(shinythemes)

# Start of ui section
ui <- dashboardPage(skin = "black",
                    dashboardHeader(),
                    dashboardSidebar(),
                    dashboardBody()
)

# Start of server section
server <- function(input, output) { }

shinyApp(ui, server)