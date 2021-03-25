library(shiny)
library(RODBC)
library(RMySQL)

serverfun <- function(input, output){
    
    mydata <- reactive({
        #conexion con la bd
        conn <- odbcConnect("encuesta", uid="root", pwd="1234")
        #consulta a las columnas
        qr <- sqlFetch(conn, "que_dificultades")
    })
    
    output$tbtable <- renderTable({
        #revisar si la tabla no esta vacia
        if(is.null(mydata())){
            return()
        }
        mydata()
    })
    
    output$grafico1 <-renderPlot({
        
        #revisar si la mydata no esta vacia
        if(is.null(mydata())){
            return()
        }
        barplot(table(mydata()),
                main = "¿Que dificultades se te han presentado con la nueva modalidad de clases ?",
                xlab = "Preguntas",
                ylab = "Total Respuestas")
        
    })
    
    Datos <- reactive({
        #abrir conexion con la bd
        conns <- dbConnect("encuesta", uid="root", pwd="1234")
        #consulta a query
        qr <- sqlQuery(conns,"select * from[dbo].[Respuestas]" )
        
    })
    
    output$tbtables <- renderPlot({
        if(is.null(Datos())){
            return()
        }
        Datos()
    })
    
    output$grafico2 <- renderPlot({
        if(is.null(Datos())){
            return()
        }
        barplot(table(Datos()))
    })
}