import  Business_Header_SS,Business_Header, ut,did_add;

matchset := ['A','P'];
//macro for businesses 
Business_Header_SS.MAC_Add_BDID_FLEX(
  cleaned_fbn_experian_business, matchset,
	cname, 
    Bus_prim_range, Bus_prim_name, Bus_zip5, 
	Bus_sec_range,	Bus_st,bus_phone ,
	'',bdid,Layout_fbn_experian.BDID_Rec,
	false, bdid_score, //set the flag to true for bdid_score
	postBDID)
export cleaned_fbn_experian_bdid:= postBDID :persist(cluster.cluster_out+'persist::FBNV2::CleanedFBN_Experian_Bdid');

