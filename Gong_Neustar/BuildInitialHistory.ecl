import gong, gong_v2, ut, header,gong,header_quick,watchdog, header_services;

EXPORT BuildInitialHistory(dataset(layout_gongMaster) mstr, string update_date) := FUNCTION

	history_base := File_Final_LSSI_History;
//	mstr := distribute(File_Master, hash(telephone,prim_range,prim_name,z5,company_name));

	//clear current_record_flag in the old history file
	//typeof(history_base) clear_curr_flag(history_base l) := transform
	//	self.current_record_flag := '';
	//	self.deletion_date := update_date;
	////	self := l;
	//end;

	//history_curr := distribute(project(history_base(current_record_flag='Y'), clear_curr_flag(left)),
  //                           hash(phone10,prim_range,prim_name,z5,listed_name));
	history_curr := distribute(ProcessFinalLssiHistory(history_base(current_record_flag='Y'), mstr, update_date),
                             hash(phone10,prim_range,prim_name,z5,listed_name));
	history_notcurr := distribute(history_base(current_record_flag<>'Y'),
                             hash(phone10,prim_range,prim_name,z5,listed_name));

	
	new_history := PROJECT(mstr, xNewHistory(LEFT));
	history_did_hhid := fn_did_bdid_hhid(new_history);

/*** 55136 Add gong lift (cjs) history ***/
	gong_v2.Macro_GongLift(history_did_hhid, history_with_lift);
	history_with_pdid := fnPropagateADLs(history_with_lift).history;
/*** end gong lift ***/

	history_new := history_notcurr & history_curr & history_with_pdid;	// add new master records
	gong.mac_add_disc_cnt(history_new,update_date,history_with_count);
	
	history_newd := DISTRIBUTE(history_with_count);
	//history_with_pid := Gong_Neustar.Mac_Assign_UniqueId(history_newd, persistent_record_id);
	
	//history_with_pidd := DISTRIBUTE(history_with_pid,hash(phone10,prim_range,prim_name,z5,listed_name));	
	//gong_neustar.Mac_Apply_Legal(history_with_pidd, hist_d_out);

	return	history_newd;
END;
	
//	OUTPUT(hist_d_out,,'~thor::gong::neustar::history::20140731',compressed,overwrite);
	


	