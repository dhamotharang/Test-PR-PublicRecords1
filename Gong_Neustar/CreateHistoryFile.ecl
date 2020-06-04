/*
Create history file from master
1) remove old neustar master
2) append new neustar master
*/
import	_control, ut, gong, header_quick, header, mdr, std;
EXPORT CreateHistoryFile(dataset(layout_gongMaster) mstr, 
													dataset(layout_history) history_base = File_History,
													string update_date = ut.Now()) := FUNCTION

	new_history := PROJECT(mstr, xNewHistory(LEFT));
	old_history := IF(RelinkGong, gong_neustar.fn_did_bdid_hhid(history_base(bell_id<>'NEU')), history_base(bell_id<>'NEU'));

	history_new := new_history & old_history;
	
	replaced := history_new(current_record_flag<>'Y',deletion_date='');
	counted := history_new(current_record_flag='Y' OR deletion_date<>'');	// do not count replaced records
	gong.mac_add_disc_cnt(counted,update_date,history_with_count);
  h1 := history_with_count&replaced;
//*** 55136 Add gong lift (cjs) history 
	gong_neustar.Macro_GongLift(h1, history_with_lift);
	history_with_pdid := gong_neustar.fnPropagateADLs(history_with_lift).history;
//*** end gong lift
	
	addGlobalSID := mdr.macGetGlobalSID(history_with_pdid,'Gong','bell_id','global_sid');// DF-26340: Populate Global_SID	

	history_with_pidd := DISTRIBUTE(addGlobalSID);	
	//gong_neustar.Mac_Apply_Legal(history_with_pidd, hist_d_out);

	return history_with_pidd;

END;