// 经过PSM后进行DID回归

// 切换非合作者组别（AD，AD1）、PSM匹配ratio（1,3,5）、时间窗period（3,5,10）读取数据
import delimited "D:\Anaconda\Code_and_Data\8.1 Nobel_Prize_Analyze_apsNew\results-datasets\7-nonCollas-groupD-tempList-matching\PSM_groupAD\year_diff_None\resolutionParam_0.1\period_10\psm_1to5\psm_results.csv", case(preserve) 

gen Treat_Year = Prize_Year if Treat == 1

//删掉PSM导出的一些不需要的变量
drop v1
drop distance
drop weights
drop subclass


// 相关性分析
logout, save(CorrelationMatrix_logout) word replace: pwcorr_a Prize_Topic_Papers_Ratio Papers_Count Citation_Count Coauthors_Count_per_Paper Topics_DivTD Gender_Coded Start_Publish_Year Treat 


// DID
gen post_cmc = (Year > Treat_Year)
reghdfe Prize_Topic_Papers_Ratio post_cmc, absorb(AuthorID_laurID Year, savefe) vce(cluster AuthorID_laurID)
est store m1

reghdfe Prize_Topic_Papers_Ratio post_cmc Papers_Count, absorb(AuthorID_laurID Year, savefe) vce(cluster AuthorID_laurID)
est store m2

reghdfe Prize_Topic_Papers_Ratio post_cmc Citation_Count Papers_Count, absorb(AuthorID_laurID Year, savefe) vce(cluster AuthorID_laurID)
est store m3

reghdfe Prize_Topic_Papers_Ratio post_cmc Coauthors_Count_per_Paper Citation_Count Papers_Count, absorb(AuthorID_laurID Year, savefe) vce(cluster AuthorID_laurID)
est store m4

reghdfe Prize_Topic_Papers_Ratio post_cmc Topics_DivTD Coauthors_Count_per_Paper Citation_Count Papers_Count, absorb(AuthorID_laurID Year, savefe) vce(cluster AuthorID_laurID)
est store m5

esttab m1 m2 m3 m4 m5 using RegressionModels.rtf, replace star(* 0.1 ** 0.05 *** 0.01) nogaps compress b(%20.3f) se(%7.3f) r2(%9.3f) ar2(%9.3f) aic bic obslast scalars(F) mtitles('Model-1' 'Model-2' 'Model-3' 'Model-4' 'Model-5') title(esttab_Table: Regression Results) 
