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
        headerPanel("Conectando con SQL Server con R-studio-shinny"),
        sidebarPanel(
            selectInput("variable", "Tabla a buscar:",
                        c("Cual es tu nivel" = "select Cuál_es_tu_nivel from [dbo].[cual_es_tu_nivel$]",
                          "Que cambiarias" = "select Qué_cambiarías from [dbo].[que_cambiarias$]",
                          "Que dificultades" = "select Qué_dificultades from [dbo].[que_dificultades$]",
                          "Te sientes Stidfecho" = "select Te_sientes_satisfecho from [dbo].[te_sientes_satisfecho$]"))
        ),
        mainPanel(
            tabsetPanel(
                tabPanel("BARRAS" , 
                         titlePanel("Dificultades"),
                         plotOutput("grafico1")),
                tabPanel("Grafica de Pastel", plotOutput("grafico")),
                tabPanel("Histograma", plotOutput("histo"))
               
            
        )
        
    )
    
)
)
