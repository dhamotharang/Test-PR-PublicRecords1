import	business_header_ss, BIPV2,business_header, ut;

EXPORT proc_linkBiz(dataset(Cortera.Layout_Header_Out) basein) := FUNCTION

	bdid_matchset := ['A','P','F'];
	
business_header_ss.MAC_match_FLEX(basein
																	,bdid_matchset
																	,NAME
																	,prim_range
																	,prim_name
																	,zip
																	,sec_range
																	,st
																	,clean_phone
																	,fein
																	,bdid
																	,Cortera.Layout_Header_Out
																	,true
																	,bdid_score
																	,result
																	,														// keep count
																	,														// default threshold
																	,														// use prod version of superfiles
																	,														// default is to hit prod from dataland, and on prod hit prod.		
																	,BIPV2.xlink_version_set		// create BIP keys only
																	,url												// url
																	,														// email 
																	,v_city_name								// city
																	,									// fname
																	,								// mname
																	,									// lname
																	,														// contact ssn
																	,														// source
																	,														// source_record_id
																	,false
																	);												

	return result;

END;