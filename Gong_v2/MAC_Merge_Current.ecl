import gong_v2,gong,did_add, didville;

export mac_merge_current(infile,outfile) := macro

#uniquename(history_did_hhid)
gong_v2.MAC_Did_Hhid_Append(infile, %history_did_hhid%)
#uniquename(history_with_count)
//gong.mac_add_disc_cnt(%history_did_hhid%,'20071001',%history_with_count%);


outfile := 
sequential(
		 output(%history_with_count%),,
		        Gong_v2.thor_cluster+'base::gongv2_history' + thorlib.WUID(),__compressed__,overwrite),
			   FileServices.StartSuperFileTransaction(),
			   FileServices.AddSuperFile(Gong_v2.thor_cluster+'base::gongv2_history_delete',
			                             Gong_v2.thor_cluster+'base::gongv2_history_father',, true),
			   FileServices.ClearSuperFile(Gong_v2.thor_cluster+'base::gongv2_history_father'),
			   FileServices.AddSuperFile(Gong_v2.thor_cluster+'base::gongv2_history_father', 
			                             Gong_v2.thor_cluster+'base::gongv2_history',, true),
			   FileServices.ClearSuperFile(Gong_v2.thor_cluster+'base::gongv2_history'),
			   FileServices.AddSuperFile(Gong_v2.thor_cluster+'base::gongv2_history', 
			                             Gong_v2.thor_cluster+'base::gongv2_history' + thorlib.WUID()), 
			   FileServices.FinishSuperFileTransaction(),
			   FileServices.ClearSuperFile(Gong_v2.thor_cluster+'base::gongv2_history_delete',true));
			   
endmacro;