shinyServer(function(input, output) {

  
  default.data <-
    read.csv(
      "http://paulcbauer.eu/wp-content/uploads/2015/11/ess_ch.csv", header = TRUE, sep =
        ","
      )

  # MAKE UI REACTIVE
  output$selectUI <- renderUI({
    # Import data
    inFile <- input$file1
    if (is.null(inFile)) {
      x <- default.data
      selectInput(
        "variablename", "Select variable:", choices = names(x) , selected = 2
      )
    } else {
      x <- read.csv(
        inFile$datapath, header = input$header, sep = input$sep,
        quote = input$quote
      )
      selectInput(
        "variablename", "Select variable:", choices = names(x) , selected = 2
      )
    }
  })
  
  
  
  output$table <- renderDataTable({
    inFile <- input$file1
    if (is.null(inFile)) {
      default.data
    } else {
      read.csv(
        inFile$datapath, header = input$header, sep = input$sep,
        quote = input$quote
      )
    }
  })
  
  
  
  
  
  

  
  
  
  
  
  output$plot <- renderPlot({
    # Either use default file or uploaded file
    inFile <- input$file1
    if (is.null(inFile)) {
      x <- default.data
    } else {
      x <- read.csv(
        inFile$datapath, header = input$header, sep = input$sep,
        quote = input$quote
      )
    }
    x <- x[, input$variablename]
    
    
    
    if (input$type == "Frequency distribution") {
      type <- TRUE
      table.x <- table(x)
      par(mar = c(5,5,2,1))
      breaks <-
        c(as.numeric(names(table.x)) - 0.5, max(x, na.rm = T) + 0.5)
      hist(
        x, xlab = input$variablename, main = paste(paste(input$type), " of ", input$variablename, sep =
                                                     ""), freq = type, breaks = breaks, xaxt = "n", range(breaks), cex.axis =
          2, cex.lab = 2, cex.main = 2
      )
      if (input$variablename != "party.voted.last") {
        axis(
          1, at = as.numeric(names(table.x)), labels = names(table.x), cex.axis =
            2
        )
      }
      if (input$variablename == "party.voted.last") {
        axis(
          1, at = as.numeric(names(table.x)), labels = c(
            "SVP", "SPS", "FDP", "CVP", "Grüne", "Grünliberale", "BDP", "Other"
          ), cex.axis = 2
        )
      }
      if (input$type == "Frequency distribution") {
        abline(h = seq(0,1500,100), col = "grey", lty = 2)
      }
      if (input$type == "Relative frequency distribution") {
        abline(h = seq(0,1,0.05), col = "grey", lty = 2)
      }
    }
    
    
    if (input$type == "Relative frequency distribution") {
      type <- FALSE
      table.x <- table(x)
      par(mar = c(5,5,2,1))
      breaks <-
        c(as.numeric(names(table.x)) - 0.5, max(x, na.rm = T) + 0.5)
      hist(
        x, xlab = input$variablename, main = paste(paste(input$type), " of ", input$variablename, sep =
                                                     ""), freq = type, breaks = breaks, xaxt = "n", range(breaks), cex.axis =
          2, cex.lab = 2, cex.main = 2
      )
      
      if (input$variablename != "party.voted.last") {
        axis(
          1, at = as.numeric(names(table.x)), labels = names(table.x), cex.axis =
            2
        )
      }
      if (input$variablename == "party.voted.last") {
        axis(
          1, at = as.numeric(names(table.x)), labels = c(
            "SVP", "SPS", "FDP", "CVP", "Grüne", "Grünliberale", "BDP", "Other"
          ), cex.axis = 2
        )
      }
      if (input$type == "Frequency distribution") {
        abline(h = seq(0,1500,100), col = "grey", lty = 2)
      }
      if (input$type == "Relative frequency distribution") {
        abline(h = seq(0,1,0.05), col = "grey", lty = 2)
      }
    }
    
  }, height = 400)
  
  
  
  
  
  
  
  output$plot2 <- renderPlot({
    # Either use default file or uploaded file
    inFile <- input$file1
    if (is.null(inFile)) {
      x <- default.data
    } else {
      x <- read.csv(
        inFile$datapath, header = input$header, sep = input$sep,
        quote = input$quote
      )
    }
    x <- x[, input$variablename]
    
    
    if (input$type == "Relative frequency distribution") {
      # x <- ess.ch[, input$variablename]
      forgraph <- as.matrix(prop.table(table(x)))
      dimnames(forgraph)[[2]] <- c("\n")
    }
    
    if (input$type == "Frequency distribution") {
      # x <- ess.ch[, input$variablename]
      forgraph <- as.matrix(table(x))
      dimnames(forgraph)[[2]] <- c("\n")
    }
    
    
    
    z.scale <- input$z.scale
    x.scale <- input$x.scale
    variablename <- input$variablename
    
    cloud(
      forgraph, panel.3d.cloud = panel.3dbars,
      xbase = 0.4, ybase = 0.4, zlim = c(0, max(forgraph)),
      scales = list(arrows = FALSE, just = "right"), zlab = NULL,
      xlab = variablename,
      ylab =  "\n",
      col.facet = level.colors(
        forgraph, at = do.breaks(range(forgraph), 20),
        col.regions = gray.colors,
        colors = TRUE
      ),
      colorkey = list(col = gray.colors, at = do.breaks(range(forgraph), 20))
      ,screen = list(z = z.scale, x = x.scale)
    )
    
    
  }, height = 400)
  
  

})
