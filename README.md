Code and data for "How does Nobel prize awarding shift the research topics of Nobelists’ coauthors and non-coauthors?"

Three datasets used in this study are all available online:
* The APS dataset is accessible at https://journals.aps.org/datasets.
* The disambiguated author name data provided by Sinatra et al. (2016) is available at https://www.science.org/doi/10.1126/science.aaf5239. (Adding papers published after 2010：authors_disambiguation_id2doi_addDOI.json)
* The dataset on Nobelists and their prizewinning works provided by Li et al. (2019) is available at https://www.nature.com/articles/s41597-019-0033-6.

Constructing weighted bibliographic coupling network (BCN) and appling the Leiden algorithm to detect communities:
* BCN_write_node&edge_for_allPapers.ipynb
* BCN_allPapers_clustering_Leidenalg_withParameters.ipynb
* allPapers_globalCluster_weighted.csv

Discerning coauthorships among scholars:
* Module2_get_collasInfo_name2id.ipynb
* Coauthors of Nobelists: groupA_match_byGlobalTopic.ipynb
* Non-coauthors of Nobelists: groupD-tempList.ipynb
* Utilizing the Propensity Score Matching to construct a parallel sample：psm.R; groupAD_forPSM.csv; groupAD1_forPSM.csv
  
Harnessing the promulgation of the Nobel Prize as a natural experiment: DID_Ratio.do
