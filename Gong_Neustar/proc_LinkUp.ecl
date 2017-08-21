import did_add,didville,header,business_header,Address,ut,header_slimsort,business_header_ss,_control, BIPv2, mdr;
// do all linking functions
EXPORT proc_LinkUp(dataset(layout_gongMaster) infile) := FUNCTION

		with_did_hhid := fmac_did_bdid_hhid(infile, layout_gongMaster);
		
		lifted := fn_GongLift(with_did_hhid);

		propagated := fn_PropagateDID_mstr(lifted);
		//mac_add_disc_cnt(history_did_hhid,cmplt_history);
		
		return propagated;

END;