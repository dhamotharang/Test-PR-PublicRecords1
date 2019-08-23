import FBNV2, Data_Services;

EXPORT Input_CA_San_Diego_In_FBNV2 := DATASET(FBNV2.Cluster.Cluster_In +'in::fbnv2::ca::San_Diego::cleaned',
												  Scrubs_FBNV2.Input_CA_San_Diego_Layout_FBNV2,
													THOR);
													

