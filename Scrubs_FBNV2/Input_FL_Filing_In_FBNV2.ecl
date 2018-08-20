import FBNV2, Data_Services;

EXPORT Input_FL_Filing_In_FBNV2 := DATASET(FBNV2.Cluster.Cluster_In +'in::fbnv2::fl::Filing::cleaned',
												  Scrubs_FBNV2.Input_FL_Filing_Layout_FBNV2,
													THOR);