Code and data for "How does Nobel prize awarding shift the research topics of Nobelists’ coauthors and non-coauthors?"

在线获取数据集：APS、去重信息、诺奖得主信息

添加了2010年以后的论文的去重文件数据：authors_disambiguation_id2doi_addDOI.json

主题模型相关：
* BCN网络：allPapers_cociting_data.csv
* 主题聚类结果：allPapers_globalCluster_weighted.csv
* LEIDEN进行主题聚类代码：CCN_allPapers_clustering_Leidenalg_withParameters.ipynb

匹配合作者：
* groupA_match_byGlobalTopic.ipynb
* 根据论文doi找合作者姓名，然后匹配ID：Module2_get_collasInfo_name2id.ipynb

匹配非合作者：
groupD-tempList.ipynb

PSM匹配：
* psm.R
* 数据（10年时间窗，聚类参数0.1）：groupAD_forPSM.csv；groupAD1_forPSM.csv
  
DID：
DID_Ratio.do
