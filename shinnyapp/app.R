library(shiny)
library(readxl)
library(ggplot2)
library(plotly)

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    fluidPage( tabsetPanel(
        tabPanel("Cargar Archivo", 
                 fileInput('archivox', 'Seleccione un archivo xlsx'
                           ,accept=c(".xlsx")),
                 #visualizamos el archivo
                 tableOutput("graficoTabla")
                 
        ),
        tabPanel("Tabla 1",
                 textInput("texto_a_buscar", "Texto A buscar", "Sí"),
                 plot_ly(datos, x = ~Examen, y = ~numeroExamenes, 
                         type = "bar", color = I("light blue"))
                
                 
        ))
        
    ),

)

# Define server logic required to draw a histogram
server <- function(input, output) {
    source('each_session.R', local = TRUE)
    output$graficoTabla <- renderTable ({
        source('each_call.R', local = TRUE)
        #   #Primero obtenemos el archivo desde la interfaz
        archivo1 <- input$archivox
        #checamos que no este vacio
        if(is.null(archivo1))
            return(NULL)
        
        #Leemos el archivo como un excel
        tabla <- read_excel(archivo1$datapath, 1)
        #texto <- input$texto_a_buscar
        opciong1 <-length(which(tabla[,3]== "Sí" ))
        opciong2 <-length(which(tabla[,3]== "No" ))
        
        registrossi<-data.frame(tabla[which(tabla[,3]=="Sí"),])
        
         datos = data.frame(Examen = c("Sí","No"),
                           numeroExamenes = c(opciong1,opciong2))
        
        
        return(tabla)
        
        
        
        
        #Con la función which buscamos en la fila de tipo de usuario aquellos que son mayores
        #which nos retorna un vector lógico, calculando su tamaño sabemos cuántos registros cumplen la condición dada
        
        
        
        
        #   #Procesamos el archivo
    })#ctrl+shift+c
    
    # output$primeragrafica <- renderPlot({
    #     
    #     archivo1 <- input$archivox
    #     #checamos que no este vacio
    #     if(is.null(archivo1))
    #         return(NULL)
    #     
    #     #Leemos el archivo como un excel
    #     tabla <- read_excel(archivo1$datapath, 1)
    #     # hist(tabla[,3], col=colors, main="HISTOGRAMA DE SALARIOS", 
    #     #      xlab="SALARIO",  col.sub="darkblue", cex.sub=0.6);
    #     # 
    #      
    #      
    #      registrotexto <-data.frame(tabla[which(tabla[,3]== texto),])
    #      
    #      datos = data.frame(Opcion = c("Sí","No"),
    #                         numRespuestas = c(registrotexto))
    #     
    # })
    
    
    #hola2
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)