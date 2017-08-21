//
// original codde from 40 way.....BUILDINDEX(Buzzsaw.Index_uip_location_std, OVERWRITE);		
//

// sequential(Buzzsaw.Mod_Data_Creation.C_Start, OUTPUT('Done'));
// sequential(Buzzsaw.Mod_Data_Creation.C_Super, OUTPUT('Done'));
// sequential(Buzzsaw.Mod_Data_Creation.C_DD, OUTPUT('Done'));
// sequential(Buzzsaw.Mod_Data_Creation.C_DDC, OUTPUT('Done'));
// sequential(Buzzsaw.Mod_Data_Creation.C_Unique_Srcips, OUTPUT('Done'));
// sequential(Buzzsaw.Mod_Data_Creation.C_Unique_destips, OUTPUT('Done'));
// sequential(Buzzsaw.Mod_Data_Creation.C_Unique_Ips_Superfile, OUTPUT('Done'));

 // ds := DATASET(buzzsaw.Mod_Data.FN_IpLocation, buzzsaw.Mod_Data.L_Ip_Location, csv);
 // OUTPUT(ds,,buzzsaw.Mod_Data.FN_Std_IpLocation,OVERWRITE);
 
// sequential(Buzzsaw.Mod_Data_Creation.C_Ip_Location_With_Group_Info, OUTPUT('Done')); // took about three seconds
// sequential(Buzzsaw.Mod_Data_Creation.C_Ip_Location_Distribution_Groups, OUTPUT('Done')); // took about two seconds
// sequential(Buzzsaw.Mod_Data_Creation.C_All_Unique_Ips_Location, OUTPUT('Done')); // took about 1.5 minutes

//sequential(Buzzsaw.Mod_Data_Creation.C_U4, OUTPUT('Done'));
//
// The following took 45 minutes to run
// Parallel(
// buildindex(buzzsaw.Mod_Data_Indexes.IDX_U4_Time_of_day, overwrite),	// 6 min. 10 secs.
// buildindex(buzzsaw.Mod_Data_Indexes.IDX_U4_destport, overwrite),
// buildindex(buzzsaw.Mod_Data_Indexes.IDX_U4_dest_cc, overwrite),
// buildindex(buzzsaw.Mod_Data_Indexes.IDX_U4_src_cc, overwrite),
// buildindex(buzzsaw.Mod_Data_Indexes.IDX_U4_protocol, overwrite),
// buildindex(buzzsaw.Mod_Data_Indexes.IDX_U4_destip_u4, overwrite),
// buildindex(buzzsaw.Mod_Data_Indexes.IDX_U4_ips, overwrite)
// );


// sequential(Buzzsaw.Mod_Data_Creation.c_STDDev_IPIPDP, OUTPUT('Done')); //one minuite and 56 seconds
// sequential(Buzzsaw.Mod_Data_Creation.c_clusters(128,128), OUTPUT('Done')); // 10 seconds
// sequential(Buzzsaw.Mod_Data_Indexes.C_Cluster_Indexes, OUTPUT('Done')); // 20 seconds
//
// Mod_Data_Creation.C_Threats needs g2::bleeding-botccrules, 
// and ~g2::compromisedrules to be sprayed
//
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

// buildindex(buzzsaw.Mod_Data_Indexes.IDX_UIP_Location_IP, overwrite) // 11 seconds
// sequential(Buzzsaw.Mod_Data_Creation.C_Find_Threats(), OUTPUT('Done'));
