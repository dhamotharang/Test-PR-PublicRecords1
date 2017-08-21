// BWR_OtherSteps 

//
// These I have been performing individually AFTER BWR_BuildStep1
//
// Further prep operation...
ds := DATASET(buzzsaw.Mod_Data.FN_IpLocation, buzzsaw.Mod_Data.L_Ip_Location, csv);
 OUTPUT(ds,,buzzsaw.Mod_Data.FN_Std_IpLocation,OVERWRITE);
 
 // ds1 := DATASET(
		// [	{'2007-11-01','REMOTE','216.115.208.0/20'}, 
			// {'2007-11-01','REMOTE','216.219.112.0/20'},
			// {'2007-11-01','REMOTE','66.151.158.0/24'},
			// {'2007-11-01','REMOTE','66.151.150.160/27'},
			// {'2007-11-01','REMOTE','66.151.115.128/26'},
			// {'2007-11-01','REMOTE','64.74.80.0/24'},
			// {'2007-11-01','REMOTE','202.173.24.0/21'},
			// {'2007-11-01','REMOTE','67.217.64.0/19'},
			// {'2007-11-01','REMOTE','78.108.112.0/20'}
		// ],
		// buzzsaw.Mod_Data.L_Threat_Raw);
		
// output(ds1,, buzzsaw.Mod_Data.FN_Threat_Remote_Raw, OVERWRITE);

 
// Buzzsaw.Mod_Data_Creation.C_DD;
// Buzzsaw.Mod_Data_Creation.C_All_Unique_Ips;
// Buzzsaw.Mod_Data_Creation.C_Ip_Location_With_Group_Info;		// No need to look at this since it is done once.
// Buzzsaw.Mod_Data_Creation.C_Ip_Location_Distribution_Groups; // No need to look at this since it is done once.
// Buzzsaw.Mod_Data_Creation.C_All_Unique_Ips_LocationEx;
// Buzzsaw.Mod_Data_Creation.C_U4_EX;
// BUILDINDEX(Buzzsaw.Mod_Data_Indexes.IDX_U4);		// added so new indexes won't need the entire payload...just do another join with this index to get back to the raw data.
//
//
//
 // PARALLEL(
// buildindex(buzzsaw.Mod_Data_Indexes.IDX_U4_Time_of_day_TEST, overwrite),
// buildindex(buzzsaw.Mod_Data_Indexes.IDX_U4_destport_TEST, overwrite),
// buildindex(buzzsaw.Mod_Data_Indexes.IDX_U4_dest_cc_TEST, overwrite),
// buildindex(buzzsaw.Mod_Data_Indexes.IDX_U4_src_cc_TEST, overwrite),
// buildindex(buzzsaw.Mod_Data_Indexes.IDX_U4_protocol_TEST, overwrite),
// buildindex(buzzsaw.Mod_Data_Indexes.IDX_U4_destip_u4_TEST, overwrite),
// buildindex(buzzsaw.Mod_Data_Indexes.IDX_U4_ips_TEST, overwrite)
// );


// Buzzsaw.Mod_Data_Creation.c_STDDev_IPIPDP, OUTPUT('Done');
// Buzzsaw.Mod_Data_Creation.c_clusters(128,128), OUTPUT('Done');
// Buzzsaw.Mod_Data_Indexes.C_Cluster_Indexes, OUTPUT('Done');
//


// Mod_Data_Creation.C_Threats();	// needs g2::bleeding-botccrules, 
// and ~g2::compromisedrules to be sprayed
// buildindex(buzzsaw.Mod_Data_Indexes.IDX_UIP_Location_IP, overwrite) // 11 seconds
Buzzsaw.Mod_Data_Creation.C_Find_Threats(), OUTPUT('Done');
