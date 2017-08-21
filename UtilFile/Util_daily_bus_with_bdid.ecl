import did_add, Business_Header_SS, Business_Header, Header_Slimsort, ut, Lib_Stringlib, WatchDog, didville, header_services;

//**** Filtered Business Utility records from the Utility daily file.
dUtilBusFiltRecs := utilfile.fn_util_base(utilfile.file_util_full_daily);

Layout_util_daily_temp := record
   Utilfile.Layout_Utility_Bus_Base and not [bdid, bdid_score, UltID, OrgID, SELEID,
																						 ProxID, POWID, EmpID, DotID, UltScore,
																						 OrgScore, SELEScore, ProxScore, POWScore,
																						 EmpScore, DotScore, UltWeight, OrgWeight,
																						 SELEWeight, ProxWeight, POWWeight, 
																						 EmpWeight, DotWeight, source_rec_id];
end;
dMarkedUtilBusFiltRecs := project(dUtilBusFiltRecs, Layout_util_daily_temp);
//*** match set - "A" Address and "P" Phone
matchset := ['A','P'];

business_header_ss.MAC_Match_Flex(
	dMarkedUtilBusFiltRecs, matchset,
	Company_name, 
  prim_range, prim_name, zip, 
	sec_range, st,
	Phone,'',
	bdid,	
	UtilFile.Layout_util_daily_bus_out,
	false, bdid_score, //set the flag to true for bdid_score
	postBDID)

export Util_daily_bus_with_bdid := postBDID: persist('~thor_data400::persist::UtilFile::Util_daily_bus_with_bdid');
