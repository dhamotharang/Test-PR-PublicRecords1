import did_add, address, ut, header_slimsort, didville;

infile := Ingenix_NatlProf.Cleaned_Sanctions;

outrec := record
	unsigned6 did := 0;
	//unsigned1 did_score := 0;
	Ingenix_NatlProf.Layout_in_Cleaned_Sanctions;
end;

matchset :=['A','D','S','Z'];

did_Add.MAC_Match_Flex(infile, matchset,
											 sanc_tin, sanc_dob, Prov_Clean_fname, Prov_Clean_mname,Prov_Clean_lname, Prov_Clean_name_suffix, 
											 ProvCo_Address_Clean_prim_range, ProvCo_Address_Clean_prim_name, ProvCo_Address_Clean_sec_range, ProvCo_Address_Clean_zip, ProvCo_Address_Clean_st,'',
											 did,   			
											 outrec, 
											 false, did_score_field,	//these should default to zero in definition
											 75,	//dids with a score below here will be dropped 
											 outfile);
/*
matchset := ['A','D','S'];
did_Add.MAC_Match_Flex
	(raw, matchset,						
	 sanc_tin, sanc_dob, Prov_Clean_fname, Prov_Clean_mname,Prov_Clean_lname, Prov_Clean_name_suffix, 
	 ProvCo_Address_Clean_prim_range, ProvCo_Address_Clean_prim_name, ProvCo_Address_Clean_sec_range, ProvCo_Address_Clean_zip, ProvCo_Address_Clean_st,'',
	 DID,   			
	 wdid_rec, 
	 false, DID_Score_field, //*if outrec has scores, these will always be zero
	 75,	//dids with a score below here will be dropped
	 wdid)

*/


//export 
Cleaned_Sanctions_Add_DID := outfile;
//:persist('~thor_data400::persist::Ingenix_cleaned_sanctions_add_did');
//OUTPUT(enth(Cleaned_Sanctions_Add_DID,100),all);

d := Cleaned_Sanctions_Add_DID;

Layout_file := record
	string12 did ;
	//unsigned1 did_score := 0;
	Ingenix_NatlProf.Layout_in_Cleaned_Sanctions;
  unsigned8 source_rec_id :=0;

end;

Layout_file Re_xform(d l) := transform
	self.did := if(l.did=0,'',intformat(l.did,12,1));
	self 		 := l;
end;
ds_Cleaned_Sanc_did :=Project(d,Re_xform(left));

// Sanctions basefile is being built using all raw inputs eachtime,
// Using the previous base file inorder to retain the source_rec_id's
Update_base         := dedup(sort(distribute(ds_Cleaned_Sanc_did,hash64(filetyp,sanc_id)),record,local),record,local);
Previous_base       := distribute(Ingenix_NatlProf.Basefile_Sanctions_DID_RecID,hash64(filetyp,sanc_id));

Layout_file trans_getRecID(Layout_file l, ingenix_natlprof.layout_sanctions_DID_RecID r):=transform
	self.source_rec_id  :=r.source_rec_id ;
	self                :=l;
end;

j_append_recID:= join( Update_base,Previous_base ,
											 trim(left.did,left,right)                               =  trim(right.did   ,left,right) and
											 trim(left.filetyp,left,right)                           =  trim(right.filetyp   ,left,right) and
											 trim(left.sanc_id,left,right)                           =  trim(right.sanc_id   ,left,right) and
											 trim(left.sanc_lnme,left,right)                         =  trim(right.sanc_lnme   ,left,right) and
											 trim(left.sanc_fnme,left,right)                         =  trim(right.sanc_fnme   ,left,right) and
											 trim(left.sanc_mid_i_nm,left,right)                     =  trim(right.sanc_mid_i_nm   ,left,right) and
											 trim(left.sanc_busnme,left,right)                       =  trim(right.sanc_busnme   ,left,right) and
											 trim(left.sanc_dob,left,right)                          =  trim(right.sanc_dob   ,left,right) and
											 trim(left.sanc_street,left,right)                       =  trim(right.sanc_street   ,left,right) and
											 trim(left.sanc_city,left,right)                         =  trim(right.sanc_city   ,left,right) and
											 trim(left.sanc_zip,left,right)                          =  trim(right.sanc_zip   ,left,right) and
											 trim(left.sanc_state,left,right)                        =  trim(right.sanc_state   ,left,right) and
											 trim(left.sanc_cntry,left,right)                        =  trim(right.sanc_cntry   ,left,right) and
											 trim(left.sanc_tin,left,right)                          =  trim(right.sanc_tin   ,left,right) and
											 trim(left.sanc_upin,left,right)                         =  trim(right.sanc_upin   ,left,right) and
											 trim(left.sanc_provtype,left,right)                     =  trim(right.sanc_provtype   ,left,right) and
											 trim(left.sanc_sancdte,left,right)                      =  trim(right.sanc_sancdte   ,left,right) and
											 trim(left.sanc_sancst,left,right)                       =  trim(right.sanc_sancst   ,left,right) and
											 trim(left.sanc_licnbr,left,right)                       =  trim(right.sanc_licnbr   ,left,right) and
											 trim(left.sanc_brdtype,left,right)                      =  trim(right.sanc_brdtype   ,left,right) and
											 trim(left.sanc_src_desc,left,right)                     =  trim(right.sanc_src_desc   ,left,right) and
											 trim(left.sanc_type,left,right)                         =  trim(right.sanc_type   ,left,right) and
											 trim(left.sanc_reas,left,right)                         =  trim(right.sanc_reas   ,left,right) and
											 trim(left.sanc_terms,left,right)                        =  trim(right.sanc_terms   ,left,right) and
											 trim(left.sanc_cond,left,right)                         =  trim(right.sanc_cond   ,left,right) and
											 trim(left.sanc_fines,left,right)                        =  trim(right.sanc_fines   ,left,right) and
											 trim(left.sanc_fab,left,right)                          =  trim(right.sanc_fab   ,left,right) and
											 trim(left.sanc_updte,left,right)                        =  trim(right.sanc_updte   ,left,right) and
											 trim(left.sanc_reindte,left,right)                      =  trim(right.sanc_reindte   ,left,right) and
											 trim(left.sanc_unamb_ind,left,right)                    =  trim(right.sanc_unamb_ind   ,left,right) and
											 trim(left.prov_clean_title,left,right)                  =  trim(right.prov_clean_title   ,left,right) and
											 trim(left.prov_clean_fname,left,right)                  =  trim(right.prov_clean_fname   ,left,right) and
											 trim(left.prov_clean_mname,left,right)                  =  trim(right.prov_clean_mname   ,left,right) and
											 trim(left.prov_clean_lname,left,right)                  =  trim(right.prov_clean_lname   ,left,right) and
											 trim(left.prov_clean_name_suffix,left,right)            =  trim(right.prov_clean_name_suffix   ,left,right) and
											 trim(left.prov_clean_cleaning_score,left,right)         =  trim(right.prov_clean_cleaning_score   ,left,right) and
											 trim(left.provco_address_clean_prim_range,left,right)   =  trim(right.provco_address_clean_prim_range   ,left,right) and
											 trim(left.provco_address_clean_predir,left,right)       =  trim(right.provco_address_clean_predir   ,left,right) and
											 trim(left.provco_address_clean_prim_name,left,right)    =  trim(right.provco_address_clean_prim_name   ,left,right) and
											 trim(left.provco_address_clean_addr_suffix,left,right)  =  trim(right.provco_address_clean_addr_suffix   ,left,right) and
											 trim(left.provco_address_clean_postdir,left,right)      =  trim(right.provco_address_clean_postdir   ,left,right) and
											 trim(left.provco_address_clean_unit_desig,left,right)   =  trim(right.provco_address_clean_unit_desig   ,left,right) and
											 trim(left.provco_address_clean_sec_range,left,right)    =  trim(right.provco_address_clean_sec_range   ,left,right) and
											 trim(left.provco_address_clean_p_city_name,left,right)  =  trim(right.provco_address_clean_p_city_name   ,left,right) and
											 trim(left.provco_address_clean_v_city_name,left,right)  =  trim(right.provco_address_clean_V_city_name   ,left,right) and
											 trim(left.provco_address_clean_st,left,right)           =  trim(right.provco_address_clean_st   ,left,right) and
											 trim(left.provco_address_clean_zip,left,right)          =  trim(right.provco_address_clean_zip   ,left,right) and
											 trim(left.provco_address_clean_zip4,left,right)         =  trim(right.provco_address_clean_zip4  ,left,right) ,
                trans_getRecID(left,right),left outer,local );

export Sanctions_Code_Did := j_append_recID :persist('~thor_data400::persist::Ingenix_Sanctions_DID');

