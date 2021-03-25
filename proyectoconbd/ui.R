#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(

    pageWithSidebar(
        headerPanel("Conectanod con MYSQL Server con R-studio-shinny"),
        sidebarPanel(
            textInput("Id", "Enter ID bellow", "Encuesta UT")
        ),
        mainPanel(
            tabsetPanel(
                tabPanel("Data", tableOutput("tbTable")),
                tabPanel("BARRAS" , 
                         titlePanel("Dificultades"),
                         plotOutput("grafico1")),
                tabPanel("Grafico 3", tableOutput("tbTables"))
                
            )
        )
        
    )
    
)
