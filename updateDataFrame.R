# reactiveValの出力を更新
en_rv(new_en_v)    
eg_rv(new_eg_v)    
sd_rv(new_sd_v)    
ed_rv(new_ed_v)    
scc_rv(new_scc_v)

# reactiveValの出力をベクターとして再入力（なぜか必要）
event_name_v <<- en_rv()    
event_group_v <<- eg_rv()    
start_date_v <<- sd_rv()    
end_date_v <<- ed_rv()    
selectedColor_v <<- scc_rv()

# データフレームを作成（毎度ベクターから作る，こうしないとDateなどの型を保持できない）
if(length(event_name_v) != 0){
  new_scd <- data.frame(event_name_v, event_group_v, start_date_v, end_date_v, selectedColor_v) %>% distinct
} else {
  new_scd <- data.frame()
}
scd_rv(new_scd)
schedule_d <- scd_rv()
