import FBNV2, Data_Services;

EXPORT Input_TX_Harris_In_FBNV2 := DATASET(FBNV2.Cluster.Cluster_In +'in::fbnv2::tx::Harris::cleaned',
												  Scrubs_FBNV2.Input_TX_Harris_Layout_FBNV2,
													THOR);