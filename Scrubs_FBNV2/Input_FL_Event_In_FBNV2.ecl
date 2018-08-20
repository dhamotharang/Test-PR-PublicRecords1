import FBNV2, Data_Services;

EXPORT Input_FL_Event_In_FBNV2 := DATASET(FBNV2.Cluster.Cluster_In +'in::fbnv2::fl::event::cleaned',
												  Scrubs_FBNV2.Input_FL_Event_Layout_FBNV2,
													THOR);