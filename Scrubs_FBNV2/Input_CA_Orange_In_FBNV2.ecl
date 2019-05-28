import FBNV2, Data_Services, Scrubs_FBNV2;

EXPORT Input_CA_Orange_In_FBNV2 := DATASET(FBNV2.Cluster.Cluster_In +'in::fbnv2::ca::orange::cleaned',
												  Scrubs_FBNV2.Input_CA_Orange_Layout_FBNV2,
													// fbnv2.Layout_File_CA_Orange_in.cleaned,
													THOR);
