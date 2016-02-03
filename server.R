#library(UsingR)
#data(galton)
shinyServer(
    function(input, output) {
        output$myText <- renderPrint({
            library(plyr)
            yr <- 16
            iname       <- toupper(trimws(input$name))
            icity       <- toupper(trimws(input$city))
            istate      <- toupper(trimws(input$state))
            iemployer   <- toupper(trimws(input$employer))
            icmte_nm    <- toupper(trimws(input$cmte_nm))
            iprty       <- toupper(trimws(input$prty))
            icandidate  <- toupper(trimws(input$candidate))
            ioccupation <- toupper(trimws(input$occupation))

            nname       <- nchar(iname)
            ncity       <- nchar(icity)
            nstate      <- nchar(istate)
            nemployer   <- nchar(iemployer)
            ncmte_nm    <- nchar(icmte_nm)
            nprty       <- nchar(iprty)
            ncandidate  <- nchar(icandidate)
            noccupation <- nchar(ioccupation)

            if (nname       > 0) print(paste("Search NAME for", iname))
            if (ncity       > 0) print(paste("Search CITY for", icity))
            if (nstate      > 0) print(paste("Search STATE for", istate))
            if (nemployer   > 0) print(paste("Search EMPLOYER for", iemployer))
            if (ncmte_nm    > 0) print(paste("Search CMTE_NM for", icmte_nm))
            if (nprty       > 0) print(paste("Search PRTY for", iprty))
            if (ncandidate  > 0) print(paste("Search CANDIDATE for", icandidate))
            if (noccupation > 0) print(paste("Search OCCUPATION for", ioccupation))
            print("")
            print("CAMPAIGN FINANCE CONTRIBUTIONS FOR 2015-2016 ELECTION CYCLE THROUGH DECEMBER 2015")
            print("(grouped by name, city, state, employer, and cmte_nm, sorted by total_contrib)")
            print("")

            csvfile <- paste("inemcm", yr, ".csv", sep="")
            if (!exists("oo")){
                print(paste("READ", csvfile))
                oo <<- read.csv(csvfile)
            }
            xx <- oo
            if (nname       > 0) xx <- xx[grep(iname,       xx$NAME),]
            if (ncity       > 0) xx <- xx[grep(icity,       xx$CITY),]
            if (nstate      > 0) xx <- xx[grep(istate,      xx$STATE),]
            if (nemployer   > 0) xx <- xx[grep(iemployer,   xx$EMPLOYER),]
            if (ncmte_nm    > 0) xx <- xx[grep(icmte_nm,    xx$CMTE_NM),]
            if (nprty       > 0) xx <- xx[grep(iprty,       xx$PRTY),]
            if (ncandidate  > 0) xx <- xx[grep(icandidate,  xx$CANDIDATE),]
            if (noccupation > 0) xx <- xx[grep(ioccupation, xx$OCCUPATION),]
            if (input$xsort == "LAST_DATE (ASC)")  xx <- xx[order(as.Date(xx$LAST_DATE), -xx$TOTAL_CONTRIB),]
            if (input$xsort == "LAST_DATE (DESC)") xx <- xx[rev(order(as.Date(xx$LAST_DATE), xx$TOTAL_CONTRIB)),]
            if (input$xsort == "TOTAL_CONTRIB")    xx <- xx[order(-xx$TOTAL_CONTRIB),]
            if (input$xsort == "N_CONTRIB")        xx <- xx[order(-xx$N_CONTRIB, -xx$TOTAL_CONTRIB),]
            print(paste("SUM(TOTAL_CONTRIB) =", format(sum(xx$TOTAL_CONTRIB), big.mark=",",scientific=FALSE)))
            print(paste("SUM(N_CONTRIB)     =", format(sum(xx$N_CONTRIB), big.mark=",",scientific=FALSE)))
            print(paste("NUMBER OF ROWS     =", format(length(xx$N_CONTRIB), big.mark=",",scientific=FALSE)))
            print("")
            itotrows <- as.integer(input$totrows)
            if (nrow(xx) > itotrows) xx <- head(xx, n = itotrows)
            
            xx$NAME       <- strtrim(xx$NAME, width=input$colwidth)
            xx$CITY       <- strtrim(xx$CITY, width=input$colwidth)
            xx$EMPLOYER   <- strtrim(xx$EMPLOYER, width=input$colwidth)
            xx$CMTE_NM    <- strtrim(xx$CMTE_NM, width=input$colwidth)
            xx$OCCUPATION <- strtrim(xx$OCCUPATION, width=input$colwidth)
            xx$TOTAL_CONTRIB <- format(xx$TOTAL_CONTRIB, big.mark=",",scientific=FALSE)
            if (nrow(xx) > 0) row.names(xx) <- 1:nrow(xx)
            options(width = input$totwidth)
            xx <- subset(xx, select = input$xshow)
            print(xx)
        }) }
)