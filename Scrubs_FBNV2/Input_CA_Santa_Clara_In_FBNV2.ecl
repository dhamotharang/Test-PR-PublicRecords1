import FBNV2, Data_Services;

EXPORT Input_CA_Santa_Clara_In_FBNV2 := DATASET(FBNV2.Cluster.Cluster_In +'in::fbnv2::ca::Santa_Clara::cleaned',
												  Scrubs_FBNV2.Input_CA_Santa_Clara_Layout_FBNV2,
													THOR);