import header, address, ut, doxie, header_quick, AID, idl_header;
export preprocess(boolean pFastHeader=false) := function

monthly_data := header.file_header_in(pFastHeader).eq_uid_monthly;

rCleanNames
 :=
  record
	monthly_data;
	string5	 title_1;
    string20 fname_1;
    string20 minit_1;
    string20 lname_1;
    string5  name_suffix_1;
    string20 fname_2;
    string20 minit_2;
    string20 lname_2;
    string5  name_suffix_2;
    string20 fname_3;
    string20 minit_3;
    string20 lname_3;
    string5  name_suffix_3;
    string20 fname_4;
    string20 minit_4;
    string20 lname_4;
    string5  name_suffix_4;
	string18 vendor_id;
	string1  jflag3;
  end
 ;

string fNameIfValid(string pFirst, string pMiddle, string pLast, string pSuffix)
 :=	if(pFirst + pMiddle + pLast + pSuffix <> '',
	   Address.CleanPersonFML73(pFirst + ' ' + pMiddle + ' ' + pLast + ' ' + pSuffix),
	   ''
	  );

rCleanNames	tCleanNames(monthly_data pInput)
 :=
  transform
    string15 v_mi          := if(trim(pInput.middle_initial)         not in ['NMI','NMN'],pInput.middle_initial,'');
	string15 v_former_mi   := if(trim(pInput.former_middle_initial)  not in ['NMI','NMN'],pInput.former_middle_initial,'');
	string15 v_former_mi_2 := if(trim(pInput.former_middle_initial2) not in ['NMI','NMN'],pInput.former_middle_initial2,'');
	string15 v_aka_mi      := if(trim(pInput.aka_middle_initial)     not in ['NMI','NMN'],pInput.aka_middle_initial,'');
	
	string73 v_cleanName1 := fNameIfValid(pInput.first_name,        v_mi,         pInput.last_name,        pInput.suffix);
	string73 v_cleanName2 := fNameIfValid(pInput.former_first_name, v_former_mi,  pInput.former_last_name, pInput.former_suffix);
	string73 v_cleanName3 := fNameIfValid(pInput.former_first_name2,v_former_mi_2,pInput.former_last_name2,pInput.former_suffix2);
	string73 v_cleanName4 := fNameIfValid(pInput.aka_first_name,    v_aka_mi,     pInput.aka_last_name,    pInput.aka_suffix);
	
	self.title_1       := v_cleanName1[1..5];
    self.fname_1       := v_cleanName1[6..25];
    self.minit_1       := v_cleanName1[26..45];
    self.lname_1       := v_cleanName1[46..65];
    self.name_suffix_1 := if(v_cleanName1[66..70]='',pInput.suffix,v_cleanName1[66..70]);
    self.fname_2       := v_cleanName2[6..25];
    self.minit_2       := v_cleanName2[26..45];
    self.lname_2       := v_cleanName2[46..65];
    self.name_suffix_2 := if(v_cleanName2[66..70]='',pInput.former_suffix,v_cleanName2[66..70]);
    self.fname_3       := v_cleanName3[6..25];
    self.minit_3       := v_cleanName3[26..45];
    self.lname_3       := v_cleanName3[46..65];
    self.name_suffix_3 := if(v_cleanName3[66..70]='',pInput.former_suffix2,v_cleanName3[66..70]);
    self.fname_4       := v_cleanName4[6..25];
    self.minit_4       := v_cleanName4[26..45];
    self.lname_4       := v_cleanName4[46..65];
    self.name_suffix_4 := if(v_cleanName4[66..70]='',pInput.aka_suffix,v_cleanName4[66..70]);

	self.vendor_id					:=	header.Cid_Converter(pInput.cid[1])
									+ 	header.Cid_Converter(pInput.cid[2])
									+	header.Cid_Converter(pInput.cid[3])
									+	header.Cid_Converter(pInput.cid[4])
									+	header.Cid_Converter(pInput.cid[5])
									+	header.Cid_Converter(pInput.cid[6])
									+	header.Cid_Converter(pInput.cid[7])
									+	header.Cid_Converter(pInput.cid[8])
									+	header.Cid_Converter(pInput.cid[9]);

    self.jflag3       := pInput.ssn_confirmed;
	
	self			  := pInput;
  end
;

dHeadersInNameCleaned := project(monthly_data,tCleanNames(left)) : persist('~thor_data400::persist::header_preprocess_name_clean');

rNormalizedAddresses
 :=
  record
	string15 first_name;
	string15 middle_initial;
	string25 last_name;
	string2	 suffix;
	string15 former_first_name;
	string15 former_middle_initial;
	string25 former_last_name;
	string2	 former_suffix;
	string15 former_first_name2;
	string15 former_middle_initial2;
	string25 former_last_name2;
	string2	 former_suffix2;
	string15 aka_first_name;
	string15 aka_middle_initial;
	string25 aka_last_name;
	string2	 aka_suffix;
	string57 addr;
	string20 orig_city;
	string2	 orig_state;
	string5	 zip;
	string6	 address_date_reported;
	string9	 ssn;
	string9	 cid;
    string1	 rec_type;
	string5	 title;
    string20 fname;
    string20 mname;
    string20 lname;
    string5  name_suffix;
	string18 vendor_id;
	string1  jflag3;
	string30 temp_addr2;			// created from components below
	header.Layout_Source_ID;
  end
 ;


rNormalizedAddresses tNormalizeAddresses(dHeadersInNameCleaned pInput, unsigned1 pCounter)
 :=
  transform
  
    string9 ssn_1_2 := header.fn_rule_for_normalizing_eq_ssn(pInput.fname_1, pInput.minit_1, pInput.lname_1, pInput.fname_2, pInput.minit_2, pInput.lname_2, pInput.ssn);
	string9 ssn_1_3 := header.fn_rule_for_normalizing_eq_ssn(pInput.fname_1, pInput.minit_1, pInput.lname_1, pInput.fname_3, pInput.minit_3, pInput.lname_3, pInput.ssn);
	string9 ssn_1_4 := header.fn_rule_for_normalizing_eq_ssn(pInput.fname_1, pInput.minit_1, pInput.lname_1, pInput.fname_4, pInput.minit_4, pInput.lname_4, pInput.ssn);
	
    self.addr := choose(pCounter,
	               pInput.current_address,pInput.former1_address,pInput.former2_address,
				   pInput.current_address,pInput.former1_address,pInput.former2_address,
				   pInput.current_address,pInput.former1_address,pInput.former2_address,
				   pInput.current_address,pInput.former1_address,pInput.former2_address
				   );
    self.orig_city := choose(pCounter,
	                   pInput.current_city,pInput.former1_city,pInput.former2_city,
				       pInput.current_city,pInput.former1_city,pInput.former2_city,
				       pInput.current_city,pInput.former1_city,pInput.former2_city,
				       pInput.current_city,pInput.former1_city,pInput.former2_city
				       );
    self.orig_state := choose(pCounter,
	                    pInput.current_state,pInput.former1_state,pInput.former2_state,
				        pInput.current_state,pInput.former1_state,pInput.former2_state,
				        pInput.current_state,pInput.former1_state,pInput.former2_state,
				        pInput.current_state,pInput.former1_state,pInput.former2_state
				        );
    self.zip := choose(pCounter,
	             pInput.current_zip,pInput.former1_zip,pInput.former2_zip,
			     pInput.current_zip,pInput.former1_zip,pInput.former2_zip,
			     pInput.current_zip,pInput.former1_zip,pInput.former2_zip,
			     pInput.current_zip,pInput.former1_zip,pInput.former2_zip
			     );
    self.address_date_reported := choose(pCounter,
	             pInput.current_address_date_reported,pInput.former1_address_date_reported,pInput.former2_address_date_reported,
			     pInput.current_address_date_reported,pInput.former1_address_date_reported,pInput.former2_address_date_reported,
			     pInput.current_address_date_reported,pInput.former1_address_date_reported,pInput.former2_address_date_reported,
			     pInput.current_address_date_reported,pInput.former1_address_date_reported,pInput.former2_address_date_reported
			     );

	self.rec_type := choose(pCounter,
	               '1','2','2',
				   '2','2','2',
				   '3','3','3',
				   '3','3','3'
				   );
    
	self.title := pInput.title_1;				   
    self.fname := choose(pCounter,
	               pInput.fname_1,pInput.fname_1,pInput.fname_1,
				   pInput.fname_2,pInput.fname_2,pInput.fname_2,
				   pInput.fname_3,pInput.fname_3,pInput.fname_3,
				   pInput.fname_4,pInput.fname_4,pInput.fname_4
				   );
    self.mname := choose(pCounter,
	               pInput.minit_1,pInput.minit_1,pInput.minit_1,
				   pInput.minit_2,pInput.minit_2,pInput.minit_2,
				   pInput.minit_3,pInput.minit_3,pInput.minit_3,
				   pInput.minit_4,pInput.minit_4,pInput.minit_4
				   );
    self.lname := choose(pCounter,
	               pInput.lname_1,pInput.lname_1,pInput.lname_1,
				   pInput.lname_2,pInput.lname_2,pInput.lname_2,
				   pInput.lname_3,pInput.lname_3,pInput.lname_3,
				   pInput.lname_4,pInput.lname_4,pInput.lname_4
				   );
    self.name_suffix := choose(pCounter,
	                     pInput.name_suffix_1,pInput.name_suffix_1,pInput.name_suffix_1,
						 pInput.name_suffix_2,pInput.name_suffix_2,pInput.name_suffix_2,
						 pInput.name_suffix_3,pInput.name_suffix_3,pInput.name_suffix_3,
						 pInput.name_suffix_4,pInput.name_suffix_4,pInput.name_suffix_4
						 );

    self.ssn := choose(pCounter,
					   pInput.ssn,pInput.ssn,pInput.ssn,
					   ssn_1_2,ssn_1_2,ssn_1_2,
					   ssn_1_3,ssn_1_3,ssn_1_3,
					   ssn_1_4,ssn_1_4,ssn_1_4
					   );
			 
	self.temp_addr2	:= trim(StringLib.StringCleanSpaces(	trim(self.orig_city) + if(self.orig_city <> '',',','')
																												+ ' '+ self.orig_state
																												+ ' '+ self.zip
																												),left,right
																							);

	self.jflag3     := if(trim(self.ssn)='' and pInput.jflag3='C','',pInput.jflag3);
	
	self 			:= pInput;
end;

dNormalizedAddresses0			:=	normalize(dHeadersInNameCleaned,12,tNormalizeAddresses(left,counter));
//this is a tighter filter than what's in header.mac_normalize_header
dNormalizedAddresses            := dNormalizedAddresses0(fname<>'' and lname<>'' and addr<>'');

np_headers_in
 :=
  record
	string6	 dt_first_seen;
	string6	 dt_last_seen;
	string6	 dt_vendor_last_reported;
	string6	 dt_vendor_first_reported;
	string1	 rec_type;
	string9	 ssn;
	string15 first_name;
	string15 middle_initial;
	string25 last_name;
	string2	 suffix;
	string15 former_first_name;
	string15 former_middle_initial;
	string25 former_last_name;
	string2	 former_suffix;
	string15 former_first_name2;
	string15 former_middle_initial2;
	string25 former_last_name2;
	string2	 former_suffix2;
	string15 aka_first_name;
	string15 aka_middle_initial;
	string25 aka_last_name;
	string2	 aka_suffix;
	string57 addr;
	string20 orig_city;
	string2	 orig_state;
	string5	 zip;
	string6	 address_date_reported;
	string5	 title;
    string20 fname;
    string20 mname;
    string20 lname;
    string5  name_suffix;
	string18 vendor_id;
	string1  jflag3;
	string30 temp_addr2;
	unsigned8 RawAID:=0;
	header.Layout_Source_ID;
end;

//Adjusting dates so date first seen is closer to what EQ says was a valid date for that data
np_headers_in project_headers(dNormalizedAddresses pInput)
 :=
  transform
	self.dt_first_seen				:=	pInput.address_date_reported[3..6] + pInput.address_date_reported[1..2];
	self.dt_last_seen				:=	header.Sourcedata_month.v_version[1..6];
	self.dt_vendor_last_reported	:=	header.Sourcedata_month.v_version[1..6];
	self.dt_vendor_first_reported	:=	header.Sourcedata_month.v_version[1..6];
    self							:=	pInput;
  end
 ;
 
np_headers_set	:=	project(dNormalizedAddresses, project_headers(LEFT));

unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;		
AID.MacAppendFromRaw_2Line(np_headers_set,addr,temp_addr2,RawAID,hdrs_addr, lFlags);

temp_rec := record
 header.Layout_In_Header;
 string1 jflag3;
	unsigned8 RawAID:=0;
end;

temp_rec project_header_in(hdrs_addr le) := TRANSFORM
	SELF.RawAID			:= 	le.aidwork_rawaid;
	SELF.prim_range	:= 	le.aidwork_acecache.prim_range;
	SELF.predir			:= 	le.aidwork_acecache.predir;
	SELF.prim_name	:= 	le.aidwork_acecache.prim_name;
	SELF.suffix			:= 	le.aidwork_acecache.addr_suffix;
	SELF.postdir		:= 	le.aidwork_acecache.postdir;
	SELF.unit_desig	:= 	le.aidwork_acecache.unit_desig;
	SELF.sec_range	:= 	le.aidwork_acecache.sec_range;
	SELF.city_name	:= 	le.aidwork_acecache.v_city_name;
	SELF.st					:= 	le.aidwork_acecache.st;
	SELF.zip				:= 	le.aidwork_acecache.zip5;
	SELF.zip4				:= 	le.aidwork_acecache.zip4;
	SELF.county			:= 	le.aidwork_acecache.county[3..5]; 
	self.cbsa				:=	if(le.aidwork_acecache.msa='','',le.aidwork_acecache.msa+'0');
	SELF.geo_blk		:= 	le.aidwork_acecache.geo_blk;
  self            := le;
END;

headers_preprocessed := project(hdrs_addr,project_header_in(left));

dist_hdrs            := distribute(headers_preprocessed,hash(vendor_id));
sorted_hdrs          := sort(dist_hdrs,record,local);
deduped_hdrs0         := dedup(sorted_hdrs,local);
ut.mac_flipnames(deduped_hdrs0,fname,mname,lname,deduped_hdrs);

header.Layout_New_Records t_map_to_new_rec_layout(temp_rec le) := transform

 self.dt_first_seen            := if(le.rec_type='1',(integer)le.dt_first_seen,0);
 self.dt_last_seen             := if(le.rec_type='1',(integer)le.dt_last_seen,0);
 self.dt_vendor_last_reported  := (integer)le.dt_vendor_last_reported;
 self.dt_vendor_first_reported := (integer)le.dt_vendor_first_reported;
 self.dt_nonglb_last_seen      := 0;
 self.phone                    := '';
 self.dob                      := 0;					
 self.did                      := 0;
 self.rid                      := 0;
 self                          := le;
end;

map_to_new_rec_layout := project(deduped_hdrs,t_map_to_new_rec_layout(left));

did_monthly0 := header_quick.FN_DID(map_to_new_rec_layout);

did_monthly:=fn_Not_Primary_EQ(did_monthly0): persist('~thor_data400::persist::header_preprocess_did');

return did_monthly;
end;