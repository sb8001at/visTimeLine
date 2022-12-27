# dataframe (schedule_v)を更新するために，各列の要素をreactiveでとらえる
event_name <- reactive({input$eventName})
event_group <- reactive({input$eventGroup})
start_date <- reactive({input$startDate})
end_date <- reactive({input$endDate})  
selectedColor <- reactive({input$colorEvent})

# 削除行の要素もreactiveでとらえる
deleteLineN <- reactive({input$deleteLineNumber %>% as.numeric})

# 要素の更新にはreactiveValが必要なので，各列の要素を保存するベクターはreactiveValで形を変えておく
en_rv <- reactiveVal(event_name_v)  
eg_rv <- reactiveVal(event_group_v)  
sd_rv <- reactiveVal(start_date_v)  
ed_rv <- reactiveVal(end_date_v) 
scc_rv <- reactiveVal(selectedColor_v)
scd_rv <- reactiveVal(schedule_d)