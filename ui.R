fluidPage(
  theme = bs_theme(version = 5, bootswatch = "united"),
  nav_bar_fixed = TRUE,
  navbarPage("タイムライン表示 Shinyアプリのサンプル",
             tabPanel(
               "", sidebarLayout(
                 sidebarPanel(
                   width = 3,
                   textInput("eventName", "イベント名"),
                   textInput("eventGroup", "イベントのカテゴリ"),
                   dateInput("startDate", "開始日", value = today()),
                   dateInput("endDate", "終了日", value = today()),
                   selectInput(
                     "colorEvent",
                     "イベントの表示色",
                     choices = c(
                       "青" = "#0d6efd",
                       "インディゴ" = "#6610f2",
                       "紫" = "#6f42c1",
                       "ピンク" = "#d63384",
                       "赤" = "#dc3545",
                       "オレンジ" = "#df7e14",
                       "黄" = "#ffc107",
                       "緑" = "#198754",
                       "緑茶" = "#20c997",
                       "シアン" = "#0dcaf0",
                       "灰" = "#adb5bd"
                     )
                   ),
                   plotOutput("colorbar", height = "20px"),
                   br(),
                   actionButton("scheduleFileAddButton", "スケジュールを追加"),
                   p("＊重複したイベントは削除されます"),
                   hr(),
                   
                   numericInput(
                     "deleteLineNumber",
                     "削除する行を選んでください",
                     value = 1,
                     min = 1,
                     max = 100
                   ),
                   br(),
                   actionButton("DeleteLineButton", "スケジュールを削除"),
                   hr(),
                   actionButton("deleteAllButton", "すべてのスケジュールを削除"),
                   
                   hr(),
                   br(),
                   fileInput("scheduleFile", "スケジュールファイルを選択してください",
                             accept = c(
                               "text/csv",
                               "text/comma-separated-values,text/plain",
                               ".csv")),
                   actionButton("scheduleFileShowButton", "ファイルを表示"),
                   hr(),
                   br(),
                   downloadButton("downloadData", "ファイルのダウンロード")
                 ),
                 
                 mainPanel(
                   id = "mainpaneltabs",
                   width = 9,
                   tabsetPanel(
                     tabPanel(
                       "タイムライン",
                       actionBttn(
                         inputId = "runPloting",
                         label = "タイムラインを表示",
                         style = "material-flat",
                         color = "primary"
                       ),
                       plotlyOutput("timeLine", height="40em"),
                       hr(),
                       br(),
                       dataTableOutput("scheduleDT", height = "400em")
                     ),
                     tabPanel(
                       "使い方",
                       h4("はじめに"),
                       p("このShinyアプリは，アプリ上でスケジュールを作成し，作成したスケジュールに対応したタイムライン（ガントチャート）を作成するためのツールです．csvで同様のフォーマットのファイルを作成し，アップロードすることでもタイムラインを作成できます．"),
                       h4("使い方"),
                       p("イベント名，イベントのカテゴリ（グループ），開始日，終了日，表示色を入力し，「スケジュールを追加」を押すと，「タイムライン」のタグの下に表が作成されます．"),
                       p("スケジュールを削除する場合には，削除する行を指定し，「スケジュールを削除」を押すとその行のスケジュールが削除されます．"),
                       p("スケジュールを全削除するときには，「すべてのスケジュールを削除」をクリックします."),
                       p("スケジュールの表は「ファイルのダウンロード」でローカルに保存できます．保存したファイルを「Browse...」から選択し，アップロードすることで保存したスケジュールを使用することができます．"),
                       p("ファイルはCSVで保存されます（エンコーディングはUTF-8）．CSVファイルをExcel上などで修正することで，スケジュールの記載を変更することもできます．"),
                       h4("仕組み"),
                       p("基本的にすべてRで動いています．入力したスケジュールに対応したdata.frameを作成し，そのdata.frameをvisTimeという，plotlyベースのライブラリを用いてタイムラインにして，表示しています．"),
                       p("Shinyのスコープの問題で，data.frameをrenderXXXの外にそのまま持ち出すのは難しいので，それぞれの要素（スケジュール名，開始日など）をベクトルに記録し，ベクトルをreactive_valとして更新し，このベクトルから逐次data.frameを構築し直す，というやや面倒くさいことをしています．"),
                       h4("モチベーション"),
                       p("Web上でガントチャートを作成するツールは無数に存在しているのですが，無料で作成できるツールはほぼありません（Redmineならできるかもしれませんが，なかなか入門のハードルが高いです）．ですので，手元で無料でタイムラインを作成できないか，と考えていました．"),
                       p("そうこうしているときに，visTimeについて紹介した記事をQiitaで見つけました．visTimeと，その時勉強していたShinyで何かできないかと考え，このツールを作成してみました．"),
                       p("実際に作成してみると，Shinyではスコープが厳密にrender関数内に収められており，data.frameを加工するのが難しいこと，色表示をうまく選択する方法など，なかなか学ぶところが多かったように思います．ただし，使い勝手はイマイチで，もうちょっとなんとかなればいいのになあ，と思うところです．DTを直接編集できればいいのですが，データ型まで指定するのも難しく，ハードルは高そうです．"),
                       
                       br(),
                       hr(),
                       h4("使用したツール"),
                       p("このページには，R，Shiny，tidyverse，stringr，DT，bslib，ShinyWidgets，lubridate，plotly，visTimeを使用しています．特にvisTimeはこれを作成するきっかけになったツールです．"),
                       actionButton(inputId='Rlink', label="CRAN", 
                                    icon = icon("link"), 
                                    onclick ="window.open('https://cran.r-project.org/', '_blank')"),
                       actionButton(inputId='Shinylink', label="Shiny", 
                                    icon = icon("link"), 
                                    onclick ="window.open('https://shiny.rstudio.com/', '_blank')"), 
                       actionButton(inputId='tidyverseLink', label="tidyverse", 
                                    icon = icon("link"), 
                                    onclick ="window.open('https://www.tidyverse.org/', '_blank')"),
                       actionButton(inputId='stringrLink', label="stringr", 
                                    icon = icon("link"), 
                                    onclick ="window.open('https://stringr.tidyverse.org/', '_blank')"),
                       actionButton(inputId='DTlink', label="DT", 
                                    icon = icon("link"), 
                                    onclick ="window.open('https://rstudio.github.io/DT/', '_blank')"),
                       actionButton(inputId='bslibLink', label="bslib", 
                                    icon = icon("link"), 
                                    onclick ="window.open('https://rstudio.github.io/bslib/', '_blank')"),
                       actionButton(inputId='ShinywidgetsLink', label="ShinyWidgets", 
                                    icon = icon("link"), 
                                    onclick ="window.open('https://shinyapps.dreamrs.fr/shinyWidgets', '_blank')"),
                       actionButton(inputId='lubridateLink', label="lubridate", 
                                    icon = icon("link"), 
                                    onclick ="window.open('https://lubridate.tidyverse.org/', '_blank')"),
                       actionButton(inputId='plotlyLink', label="plotly", 
                                    icon = icon("link"), 
                                    onclick ="window.open('https://plotly.com/r/', '_blank')"),
                       actionButton(inputId='visTimeLink', label="visTime", 
                                    icon = icon("link"), 
                                    onclick ="window.open('https://cran.r-project.org/web/packages/vistime/vignettes/vistime-vignette.html', '_blank')"),
                     )
                   )

                 )
               )
             ))
)
