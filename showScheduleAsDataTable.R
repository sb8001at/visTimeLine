# スケジュールを表で表示
output$scheduleDT <- renderDataTable({
  if(nrow(schedule_d != 0)){
  schedule_d$colorname <- colorChoices[schedule_d$selectedColor_v]
  datatable(schedule_d)
  }
})