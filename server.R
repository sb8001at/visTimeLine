shinyServer(function(input, output) {
  
  source("EventreactiveParams.R", local=TRUE)
  
  # カラーバーを表示する
  output$colorbar <- renderPlot({
    ggplot(
      data.frame(x=1, y=1),
      aes(x=x, y=y, fill=selectedColor()))+
        geom_bar(stat="identity") +
        scale_fill_manual(values = selectedColor()) +
        theme_void() + 
        theme(legend.position="none")
  })
  
  # スケジュールを追加のボタンを押すと以下が走る
  observeEvent(input$scheduleFileAddButton, {
    # 各列のベクターに入力項目を追加
    new_en_v <- c(en_rv(), event_name())
    new_eg_v <- c(eg_rv(), event_group())
    new_sd_v <- c(sd_rv(), start_date())
    new_ed_v <- c(ed_rv(), end_date())
    new_scc_v <- c(scc_rv(), selectedColor())
    
    source("updateDataFrame.R", local=TRUE)
    source("showScheduleAsDataTable.R", local = TRUE)
  })
  
  # スケジュールを1行削除する
  observeEvent(input$DeleteLineButton,{
    if(length(event_name_v) > 0 & deleteLineN() <= length(event_name_v)){
      # 各列のベクターを空にする
      dL <- deleteLineN()
      
      if(event_name_v %>% length <= 1){
        new_en_v <- c() %>% as.character()
        new_eg_v <- c() %>% as.character()
        new_sd_v <- c() %>% as.Date()
        new_ed_v <- c() %>% as.Date()
        new_scc_v <- c() %>% as.character()
      } else {
        new_en_v <- event_name_v[-dL]
        new_eg_v <- event_group_v[-dL]
        new_sd_v <- start_date_v[-dL]
        new_ed_v <- end_date_v[-dL]
        new_scc_v <- selectedColor_v[-dL]
      }
    source("updateDataFrame.R", local=TRUE)
    source("showScheduleAsDataTable.R", local = TRUE)
    }
  })
  
  # データを全削除する
  observeEvent(input$deleteAllButton,{
    # 各列のベクターを空にする
    new_en_v <- c() %>% as.character()
    new_eg_v <- c() %>% as.character()
    new_sd_v <- c() %>% as.Date()
    new_ed_v <- c() %>% as.Date()
    new_scc_v <- c() %>% as.character()
    
    source("updateDataFrame.R", local=TRUE)
    source("showScheduleAsDataTable.R", local = TRUE)
  })
  
  # データをダウンロードする
  output$downloadData <- downloadHandler(
    filename = function(){paste0("スケジュール", today(), ".csv")},
    content = function(file){
      new_en_v <- en_rv()
      new_eg_v <- eg_rv()
      new_sd_v <- sd_rv()
      new_ed_v <- ed_rv()
      new_scc_v <- scc_rv()
      source("updateDataFrame.R", local=TRUE)
      write.csv(schedule_d, file, row.names = FALSE, fileEncoding="UTF-8")
      }
  )
  
  # タイムラインを表示する
  observeEvent(input$runPloting,{
    new_en_v <- en_rv()
    new_eg_v <- eg_rv()
    new_sd_v <- sd_rv()
    new_ed_v <- ed_rv()
    new_scc_v <- scc_rv()
    source("updateDataFrame.R", local=TRUE)
    
    
    
    if(schedule_d %>% nrow != 0){
      output$timeLine <- renderPlotly({
        vistime(schedule_d,
                col.event="event_name_v",
                col.group="event_group_v",
                col.start="start_date_v",
                col.end="end_date_v",
                col.color="selectedColor_v"
        )
      })
    }
  })
  
  # データをアップロードする
  observeEvent(input$scheduleFileShowButton, {
               temp <- reactive({read.csv(input$scheduleFile$datapath, fileEncoding="UTF-8")})
               new_en_v <- temp()[,1]
               new_eg_v <- temp()[,2]
               new_sd_v <- temp()[,3]
               new_ed_v <- temp()[,4]
               new_scc_v <- temp()[,5]
               source("updateDataFrame.R", local=TRUE)
               schedule_d$colorname <- colorChoices[schedule_d$selectedColor_v]
               source("showScheduleAsDataTable.R", local = TRUE)
               })
  
})


