library(shiny)
library(RODBC)
library(RMySQL)

serverfun <- function(input, output){
    
    mydata <- reactive({
        #conexion con la bd
        conn <- odbcConnect("PRoyectoRStudio", uid="sa", pwd="")
        #consulta a las columnas
        qr <- sqlQuery(conn, "select ID from [dbo].[peticion_ID]")
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
        barplot(table(mydata()))
        
    })
    
    Datos <- reactive({
        #abrir conexion con la bd
        conns <- dbConnect("encuesta",
                              uid = "sa", pwd = "")
        #consulta a query
        qr <- sqlQuery(conns,"select * from[dbo].[peticion_ID]" )
        
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