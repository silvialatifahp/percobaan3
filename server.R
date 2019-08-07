library(shiny)
library(shinydashboard)
library(cluster)
library(dplyr)



shinyServer(
  function(input, output, session) {
  df_raw <- reactive({
    req(input$path_df_raw)
    read_excel(input$path_df_raw$datapath)
  }) #input file
  
  output$df_raw <- DT::renderDataTable({
    datatable(df_raw(),
              options = list(scrollx = TRUE)
    )
  }) #tampilkan datatable
  
  observe({
    updateSelectInput(
      session = session,
      inputId = "var1",
      choices = colnames(df_raw())
    )
    
    updateSelectInput(
      session = session,
      inputId = "var2",
      choices = colnames(df_raw())
    )
  }) #variabel x dan y
  
  res_clusters <- eventReactive(input$analyse, {
    req(
      df_raw(),
      input$var1, input$var2,
      input$n_clusters
    )
    
    res_kmeans <- kmeans(df_raw()[, c(input$var1, input$var2),
                                  drop=FALSE], centers=input$n_clusters
    )
    list(cluster = res_kmeans$cluster,
         centroid = res_kmeans$centers)
  })
  
  df_cluster <- reactive({
    cbind(df_raw()[, c(input$var1, input$var2), drop=FALSE],
          Klaster = as.character(res_clusters()$cluster)
    )
  })
  
  plot_kmeans <- reactive({
    req(df_cluster())
    
    ggplot() +
      geom_point(data = df_cluster(),
                 mapping = aes_string(x = input$var1, y = input$var2, colour = "Klaster")) +
      geom_point(mapping = aes_string(x = res_clusters()$centroid[, input$var1], 
                                      y = res_clusters()$centroid[, input$var2]),
                 size = 4, color = "red") +
      scale_colour_manual(values = c(
        "#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
        "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"
      )) +
      theme_light()
  })
  output$plot_kmeans <- renderPlot({
    plot_kmeans()
  })
  output$df_kmeans <- DT::renderDataTable({
    req(df_cluster())
    
    datatable(df_cluster()[order(df_cluster()$Klaster),],
              rownames = FALSE)
  })
  
  output$download_plot <- downloadHandler (
    filename = "plot_kmeans.png", content = function(file) {
      ggsave(file, plot_kmeans())
    }, contentType = "image/png")
  
  output$tableexplore<- renderPrint({
    dataexp <- read_excel(input$path_df_raw$datapath)
    res_clusters <- eventReactive(input$analyse, {
      req(
        df_raw(),
        input$var1, input$var2,
        input$n_clusters
        )
      res_kmeans <- kmeans(df_raw()[, c(input$var1, input$var2),
                                    drop=FALSE], centers=input$n_clusters
                           )
      list(cluster = res_kmeans$cluster,
           centroid = res_kmeans$centers)
    group_by(cluster)
    summarise_all("mean")
    summary(res_clusters)})
    })
}
)
