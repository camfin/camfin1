shinyUI(pageWithSidebar(
    headerPanel("Campaign Finance Contributions for 2015-2016 Election Cycle through December 2015"),
    sidebarPanel(
        width = 2,
        textInput('name',       'Search NAME',       value = '') ,
        textInput('city',       'Search CITY',       value = '') ,
        textInput('state',      'Search STATE',      value = '') ,
        textInput('employer',   'Search EMPLOYER',   value = '') ,
        textInput('cmte_nm',    'Search CMTE_NM',    value = '') ,
        textInput('prty',       'Search PRTY',       value = '') ,
        textInput('candidate',  'Search CANDIDATE',  value = 'CLINTON') ,
        textInput('occupation', 'Search OCCUPATION', value = '') ,
        checkboxGroupInput("xgrp1", "Show",
            choice   = c("NAME","CITY","STATE","EMPLOYER","CMTE_NM","PRTY","CANDIDATE","OCCUPATION","LAST_DATE","TOTAL_CONTRIB","N_CONTRIB"),
            selected = c("NAME","CITY","STATE",           "CMTE_NM","PRTY","CANDIDATE",             "LAST_DATE","TOTAL_CONTRIB","N_CONTRIB"),
            inline = TRUE),
        textInput('colwidth',  'Maximum Column Width', value = '40') ,
        textInput('totwidth',  'Maximum Total Width', value = '240') ,
        textInput('totrows',  'Maximum Total Rows', value = '900') ),
    mainPanel(
        div(
            tabsetPanel(
                tabPanel("Output",
                    width = 10,
                    verbatimTextOutput('myText')
                ),
                tabPanel("Usage",
                    width = 10,
                    includeMarkdown("camfin.Rmd")
                )
            )
        ),
        width = 10)
    )
)