Import BIPV2,AutoStandardI,TopBusiness_Services,MDR,STD;
EXPORT fn_BIPLookup( dataset(BIPV2.IDfunctions.rec_SearchInput) ds_Format2SearchInput,
												AutoStandardI.DataRestrictionI.params in_mod2   
											) := FUNCTION
	
	ds_Format2SearchInput_Hsort := project(ds_Format2SearchInput,
																								transform(BIPV2.IDfunctions.rec_SearchInput,
	self.company_name := STD.Str.ToUpperCase(left.company_name);
  self.prim_name := STD.Str.ToUpperCase(left.prim_name);
  self.sec_range := STD.Str.ToUpperCase(left.sec_range);
  self.city := STD.Str.ToUpperCase(left.city);
  self.state := STD.Str.ToUpperCase(left.state);
  self.URL := STD.Str.ToUpperCase(left.URL);
  self.Email := STD.Str.ToUpperCase(left.Email);
  self.Contact_fname := STD.Str.ToUpperCase(left.Contact_fname);
  self.Contact_mname := STD.Str.ToUpperCase(left.Contact_mname);
  self.Contact_lname := STD.Str.ToUpperCase(left.Contact_lname);
  self.hsort := true,
	self := left )) ;
	
	ds_InfoProxIdNonRestrictedWithD := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(ds_Format2SearchInput_Hsort).data2_;
	ds_InfoProxIdNonRestricted := ds_InfoProxIdNonRestrictedWithD(source <> MDR.SourceTools.src_Dunn_Bradstreet);
   	
	TopBusiness_Services.functions.MAC_IsRestricted(ds_InfoProxIdNonRestricted,
																 ds_ProxIdRestricted, 															
																 source, // field name
																 vl_id, // field name
																 in_mod2, 
																 false, //in_options.lnBranded, 															 
																 false, // //in_options.internal_testing, default to false for internal_testing
																 dt_first_seen // this is field name only no value
															 );
		 																							   
	topResults := dedup(sort(ds_ProxIdRestricted,ultid, orgid, seleid, proxid,powid,
      			                         -proxweight,-record_score, -dt_last_seen,record),ultid, orgid, seleid, proxid,powid);
										 
  //sort by -proxweight to bubble top score within a proxid group to the top again.
  tmpTopResultsScored := sort(topResults,-proxweight,-record_score, -dt_last_seen);  
  					 
	return(tmpTopResultsScored);
	end;