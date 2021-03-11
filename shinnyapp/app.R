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
                 
        ))
        
    ),
    
    
    
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)
        
        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
    
    output$graficoTabla <- renderTable ({
        #   #Primero obtenemos el archivo desde la interfaz
        archivo1 <- input$archivox
        #checamos que no este vacio
        if(is.null(archivo1))
            return(NULL)
        
        #Leemos el archivo como un excel
        tabla <- read_excel(archivo1$datapath, 1)
        
        
        
        
        #Con la función which buscamos en la fila de tipo de usuario aquellos que son mayores
        #which nos retorna un vector lógico, calculando su tamaño sabemos cuántos registros cumplen la condición dada
        
        
        
        
        #   #Procesamos el archivo
    })#ctrl+shift+c
    
    output$primeragrafica <- renderPlot({
        
        archivo1 <- input$archivox
        #checamos que no este vacio
        if(is.null(archivo1))
            return(NULL)
        
        #Leemos el archivo como un excel
        tabla <- read_excel(archivo1$datapath, 1)
        hist(tabla[,3], col=colors, main="HISTOGRAMA DE SALARIOS", 
             xlab="SALARIO",  col.sub="darkblue", cex.sub=0.6);
        # 
        # texto <- input$texto_a_buscar
        # opciong1 <-length(which(tabla[,3]== texto ))
        # 
        # registrotexto <-data.frame(tabla[which(tabla[,3]== texto),])
        # 
        # datos = data.frame(Opcion = c("Sí","No"),
        #                    numRespuestas = c(registrotexto))
        
    })
    
    
    #hola2
    
    
}

# Run the application 
shinyApp(ui = ui, server = server)