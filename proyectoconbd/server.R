library(shiny)
library(RODBC)
library(RMySQL)
library(graphics)

serverfun <- function(input, output){
    
    mydata <- reactive({
        #conexion con la bd
        conn <- odbcConnect("encuesta", uid="root", pwd="1234")
        #consulta a las columnas
        #qr <- sqlFetch(conn,"que_dificultades$")
        qr <- sqlQuery(conn, "select Cuál_es_tu_nivel from [dbo].[cual_es_tu_nivel$]")
        te <- input$variable
        qr <- sqlQuery(conn, te)

    })
    

    
    output$tbtable <- renderTable({
        #revisar si la tabla no esta vacia
        if(is.null(mydata())){
            return()
        }
        mydata()
    })
    
    
    ################## primera grafica de barras ################33
    output$grafico1 <- renderPlot({
        
        #revisar si la mydata no esta vacia
        if(is.null(mydata())){
            return()
        }
        
         barplot(table(mydata()),
                 main = "¿Que dificultades se te han presentado con la nueva modalidad de clases ?",
                 xlab = "Preguntas",
                 ylab = "Total Respuestas")
         
        #hist(table(mydata()) )
    })
    
    ################grafica de pastel ##############################
    
    data_table3 <- reactive({
        conn2 <- odbcConnect("encuesta", uid="root", pwd="1234")
        
        te2 <- input$variable
        qr2 <- sqlQuery(conn2, te2)
        
    })
    
    output$grafico <- renderPlot({
        
        #revisar si la mydata no esta vacia
        if(is.null(data_table3())){
            return()
        }
        
        #hist(table(data_table3()) )
        pie(table(data_table3()), clockwise = TRUE, main = "Grafica Pastel"  )
    })
    
    
    #############################Histograma###################33
    
    data_table4 <- reactive({
        conn3 <- odbcConnect("encuesta", uid="root", pwd="1234")

        te3 <- input$variable
        qr3 <- sqlQuery(conn3, te3)

    })

    output$tabla_his <- renderTable({
        #revisar si la tabla no esta vacia
        if(is.null(data_table4())){
            return()
        }
        data_table4()
    })

    output$histo <- renderPlot({

        #revisar si la mydata no esta vacia
        if(is.null(data_table4())){
            return()
        }

        hist(table(data_table4()) ) #funcion para hacer histograma
        #pie(table(data_table4()), clockwise = TRUE, main = "Grafica Pastel"  )
    })
    
}