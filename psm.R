library(MatchIt)
library(stringr)
library(cobalt)
library(broom)
library(writexl)


psm_and_draw_func <- function(nonColla_param, ratio, period, year_diff, resolution_param){
  
  dirPath <- "D:/Anaconda/Code_and_Data/8.1 Nobel_Prize_Analyze_apsNew/results-datasets/"
  file_path <- str_c(dirPath, 
                     str_glue("/7-nonCollas-groupD-tempList-matching/temp{nonColla_param}_forDID/year_diff_{year_diff}/did_data_groupA{nonColla_param}/resolutionParam_{resolution_param}/period_{period}/data_perYear.csv"), 
                     sep=""
  )
  
  data <- read.csv(file_path)
  colnames(data)[1] <- "Year"
  mydata <- data[ ,-which(names(data) == "Treat_Year")]
  rm(file_path)
  print(colSums(is.na(mydata)))
  mydata <- mydata[complete.cases(data),]
  
  result_dirpath <- str_c(dirPath, 
                          str_glue("/7-nonCollas-groupD-tempList-matching/PSM_groupA{nonColla_param}/year_diff_{year_diff}/resolutionParam_{resolution_param}/period_{period}/psm_1to{ratio}"), 
                          sep=""
  )
  
  set.seed(1234)
  psm_model <- matchit(Treat ~ Papers_Count + Citation_Count + Coauthors_Count_per_Paper + Topics_Variety + Topics_Balance + Topics_Disparity + Topics_DivTD + Gender_Coded, 
                       data = mydata, method = "nearest", ratio=ratio, exact=c("GroupID_byLaurID", "Year"))
  matched_data <- match.data(psm_model)
  result_filepath <- str_c(result_dirpath, "/psm_results.csv", sep="", collapse="")
  write.csv(matched_data, result_filepath)
  print("Successfully writing to csv ...")
  mod1 <- summary(psm_model)
  print(mod1)
  print(bal.tab(psm_model))
  
}


psm_and_draw_func(nonColla_param="D1",  # D（全部非合作者待选）, D1（早期进入的非合作者待选）, D2（后期进入的非合作者待选
                  ratio=3,      # 1,3,5
                  period="10",  # 3, 5, 10
                  year_diff="None",
                  resolution_param=0.1
                  )

