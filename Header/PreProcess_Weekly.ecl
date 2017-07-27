import header, address, ut, doxie, header_quick, AID;

weekly_data := header.file_header_in(true).eq_uid_weekly : persist('persist::headerbuild_eq_src_weekly');;

rCleanNames
 :=
  record
	weekly_data;
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
	string1  jflag3_temp;
	string18 vendor_id;
	string1  valid_ssn;
  end
 ;

string fNameIfValid(string pFirst, string pMiddle, string pLast, string pSuffix)
 :=	if(pFirst + pMiddle + pLast + pSuffix <> '',
	   Address.CleanPersonFML73(pFirst + ' ' + pMiddle + ' ' + pLast + ' ' + pSuffix),
	   ''
	  );

rCleanNames	tCleanNames(weekly_data pInput)
 :=
  transform
    string15 v_mi          := if(trim(pInput.middle_initial)         not in ['NMI','NMN'],pInput.middle_initial,'');
	string15 v_former_mi   := if(trim(pInput.former_middle_initial)  not in ['NMI','NMN'],pInput.former_middle_initial,'');
	string15 v_former_mi_2 := if(trim(pInput.former_middle_initial2) not in ['NMI','NMN'],pInput.former_middle_initial2,'');
	string15 v_aka_mi      := if(trim(pInput.aka_middle_initial)     not in ['NMI','NMN'],pInput.aka_middle_initial,'');
	
	//note this order was re-arranged b/c EQ indicates the AKA fields hold the latest name change
	string73 v_cleanName1 := fNameIfValid(pInput.first_name,        v_mi,         pInput.last_name,        pInput.suffix);
	string73 v_cleanName2 := fNameIfValid(pInput.former_first_name, v_former_mi,  pInput.former_last_name, pInput.former_suffix);
	string73 v_cleanName3 := fNameIfValid(pInput.former_first_name2,v_former_mi_2,pInput.former_last_name2,pInput.former_suffix2);
	string73 v_cleanName4 := fNameIfValid(pInput.aka_first_name,    v_aka_mi,     pInput.aka_last_name,    pInput.aka_suffix);

    string1 v_nc := pInput.name_change;
    string1 v_ac := pInput.addr_change;
    string1 v_sc := pInput.ssn_change;
    string1 v_fn := pInput.former_name_change;
    string1 v_nr := pInput.new_rec;

    string1 v_1 := if(v_nr<>'','W',                                                               //Just New
                   if(trim(v_nc)<>'' and trim(v_ac)<>'' and trim(v_sc)<>'' and trim(v_fn)<>'','1',//Name Chg,Addr Chg,SSN Chg,Former Name Chg
				   if(trim(v_nc)<>'' and trim(v_ac)<>'' and trim(v_sc)<>'' and trim(v_fn) ='','2',//Name Chg,Addr Chg,SSN Chg
				   if(trim(v_nc)<>'' and trim(v_ac) ='' and trim(v_sc)<>'' and trim(v_fn)<>'','3',//Name Chg,SSN Chg,Former Name Chg
				   if(trim(v_nc)<>'' and trim(v_ac)<>'' and trim(v_sc) ='' and trim(v_fn)<>'','4',//Name Chg,Addr Chg,Former Name Chg
				   if(trim(v_nc)<>'' and trim(v_ac)<>'' and trim(v_sc) ='' and trim(v_fn) ='','5',//Name Chg,Addr Chg
				   if(trim(v_nc)<>'' and trim(v_ac) ='' and trim(v_sc)<>'' and trim(v_fn) ='','6',//Name Chg,SSN Chg
				   if(trim(v_nc)<>'' and trim(v_ac) ='' and trim(v_sc) ='' and trim(v_fn)<>'','7',//Name Chg,Former Name Chg
				   if(trim(v_nc)<>'' and trim(v_ac) ='' and trim(v_sc) ='' and trim(v_fn) ='','N',//Just Name Chg
				   if(trim(v_nc) ='' and trim(v_ac)<>'' and trim(v_sc)<>'' and trim(v_fn)<>'','8',//Addr Chg,SSN Chg,Former Name Chg
				   if(trim(v_nc) ='' and trim(v_ac)<>'' and trim(v_sc)<>'' and trim(v_fn) ='','9',//Addr Chg,SSN Chg
				   if(trim(v_nc) ='' and trim(v_ac)<>'' and trim(v_sc) ='' and trim(v_fn)<>'','Y',//Addr Chg,Former Name Chg
				   if(trim(v_nc) ='' and trim(v_ac)<>'' and trim(v_sc) ='' and trim(v_fn) ='','A',//Just Addr Chg				 
				   if(trim(v_nc) ='' and trim(v_ac) ='' and trim(v_sc)<>'' and trim(v_fn)<>'','Z',//SSN Chg,Former Name Chg
				   if(trim(v_nc) ='' and trim(v_ac) ='' and trim(v_sc)<>'' and trim(v_fn) ='','S',//Just SSN Chg				 
				   if(trim(v_nc) ='' and trim(v_ac) ='' and trim(v_sc) ='' and trim(v_fn)<>'','F',//Just Former Name Chg
				   ''))))))))))))))));
				 
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
	
	self.jflag3_temp   := v_1;

	self.vendor_id					:=	header.Cid_Converter(pInput.cid[1])
									+ 	header.Cid_Converter(pInput.cid[2])
									+	header.Cid_Converter(pInput.cid[3])
									+	header.Cid_Converter(pInput.cid[4])
									+	header.Cid_Converter(pInput.cid[5])
									+	header.Cid_Converter(pInput.cid[6])
									+	header.Cid_Converter(pInput.cid[7])
									+	header.Cid_Converter(pInput.cid[8])
									+	header.Cid_Converter(pInput.cid[9]);
	
	self.valid_ssn     := pInput.ssn_confirmed;
	self			   := pInput;
  end
 ;

dHeadersInNameCleaned := project(weekly_data,tCleanNames(left));// : persist('~thor_data400::persist::header_preprocess_weekly_name_clean');

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
	//
	string1     name_change;
    string1     addr_change;
    string1     ssn_change;
    string1     former_name_change;
    string1     new_rec;
	string1     valid_ssn;
	string1     jflag3;
	//
	string18 vendor_id;
	string30 temp_addr2;			// created from components below
	header.Layout_Source_ID;
	integer pCounter_;
	boolean vW_;
	boolean v1_;
	boolean v2_;
	boolean v3_;
	boolean v4_;
	boolean v5_;
	boolean v6_;
	boolean v7_;
	boolean vN_;
	boolean v8_;
	boolean v9_;
	boolean vY_;
	boolean vA_;
	boolean vZ_;
	boolean vS_;
	boolean vF_;
  end
 ;

rNormalizedAddresses tNormalizeAddresses(dHeadersInNameCleaned pInput, unsigned1 pCounter)
 :=
  transform

  string1 v_nc := pInput.name_change;
  string1 v_ac := pInput.addr_change;
  string1 v_sc := pInput.ssn_change;
  string1 v_fn := pInput.former_name_change;
  string1 v_nr := pInput.new_rec;

  boolean vW := trim(v_nr)<>'';	
  boolean v1 := trim(v_nc)<>'' and trim(v_ac)<>'' and trim(v_sc)<>'' and trim(v_fn)<>'';//,'1',//Name Chg,Addr Chg,SSN Chg,Former Name Chg
  boolean v2 := trim(v_nc)<>'' and trim(v_ac)<>'' and trim(v_sc)<>'' and trim(v_fn) ='';//,'2',//Name Chg,Addr Chg,SSN Chg
  boolean v3 := trim(v_nc)<>'' and trim(v_ac) ='' and trim(v_sc)<>'' and trim(v_fn)<>'';//,'3',//Name Chg,SSN Chg,Former Name Chg
  boolean v4 := trim(v_nc)<>'' and trim(v_ac)<>'' and trim(v_sc) ='' and trim(v_fn)<>'';//,'4',//Name Chg,Addr Chg,Former Name Chg
  boolean v5 := trim(v_nc)<>'' and trim(v_ac)<>'' and trim(v_sc) ='' and trim(v_fn) ='';//,'5',//Name Chg,Addr Chg
  boolean v6 := trim(v_nc)<>'' and trim(v_ac) ='' and trim(v_sc)<>'' and trim(v_fn) ='';//,'6',//Name Chg,SSN Chg
  boolean v7 := trim(v_nc)<>'' and trim(v_ac) ='' and trim(v_sc) ='' and trim(v_fn)<>'';//,'7',//Name Chg,Former Name Chg
  boolean vN := trim(v_nc)<>'' and trim(v_ac) ='' and trim(v_sc) ='' and trim(v_fn) ='';//,'N',//Just Name Chg
  boolean v8 := trim(v_nc) ='' and trim(v_ac)<>'' and trim(v_sc)<>'' and trim(v_fn)<>'';//,'8',//Addr Chg,SSN Chg,Former Name Chg
  boolean v9 := trim(v_nc) ='' and trim(v_ac)<>'' and trim(v_sc)<>'' and trim(v_fn) ='';//,'9',//Addr Chg,SSN Chg
  boolean vY := trim(v_nc) ='' and trim(v_ac)<>'' and trim(v_sc) ='' and trim(v_fn)<>'';//,'Y',//Addr Chg,Former Name Chg
  boolean vA := trim(v_nc) ='' and trim(v_ac)<>'' and trim(v_sc) ='' and trim(v_fn) ='';//,'A',//Just Addr Chg				 
  boolean vZ := trim(v_nc) ='' and trim(v_ac) ='' and trim(v_sc)<>'' and trim(v_fn)<>'';//,'Z',//SSN Chg,Former Name Chg
  boolean vS := trim(v_nc) ='' and trim(v_ac) ='' and trim(v_sc)<>'' and trim(v_fn) ='';//,'S',//Just SSN Chg				 
  boolean vF := trim(v_nc) ='' and trim(v_ac) ='' and trim(v_sc) ='' and trim(v_fn)<>'';//,'F',//Just Former Name Chg
				   
				   
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
				   
	//2 & 3 should be the same
	//4, 7 & 10 should be the same
	//5, 6, 8, 9, & 11 should be the same
	//per the vendor, the AKA field (fname_4) holds the newest name change
	//let's only apply the name and address change indicators
	//to the most recent changes, not ALL former/previous values
					
    self.pCounter_ := pCounter;

    self.vW_ := vW;
	self.v1_ := v1;
	self.v2_ := v2;
	self.v3_ := v3;
	self.v4_ := v4;
	self.v5_ := v5;
	self.v6_ := v6;
	self.v7_ := v7;
	self.vN_ := vN;
	self.v8_ := v8;
	self.v9_ := v9;
	self.vY_ := vY;
	self.vA_ := vA;
	self.vZ_ := vZ;
	self.vS_ := vS;
	self.vF_ := vF;

	/*
    W => Just New
    1 => Name Chg,Addr Chg,SSN Chg,Former Name Chg
	2 => Name Chg,Addr Chg,SSN Chg
	3 => Name Chg,SSN Chg,Former Name Chg
	4 => Name Chg,Addr Chg,Former Name Chg
	5 => Name Chg,Addr Chg
	6 => Name Chg,SSN Chg
	7 => Name Chg,Former Name Chg
	N => Just Name Chg
	8 => Addr Chg,SSN Chg,Former Name Chg
	9 => Addr Chg,SSN Chg
	Y => Addr Chg,Former Name Chg
	A => Just Addr Chg				 
	Z => SSN Chg,Former Name Chg
	S => Just SSN Chg				 
	F => Just Former Name Chg
    */
	//Note:  You should't have a 1, 3, or 4 in a normalized record b/c a normalized record can't have both a current and former name
	//Note:  Same reasoning applies to 7
	self.jflag3 := if(pCounter=1,
	                if(vW,'W',
					//test this one
					if(v1,'2',
					if(v2,'2',
					if(v5,'5',
					if(v6,'6',
					if(vN,'N',
					if(v9,'9',
					if(vA,'A',
					if(vS,'S',
					''))))))))),
				   if(pCounter in [2,3],
				    if(v1,'6',
				    if(v6,'6',
					if(vN,'N',
					if(vS,'S',
					'')))),
				   if(pCounter=4,
				    if(v1,'8',
				    if(v8,'8',
					if(v9,'9',
					if(vY,'Y',
					if(vA,'A',
					if(vZ,'Z',
					if(vS,'S',
					if(vF,'F',
					'')))))))),
				   if(pCounter in [5,6],
				    if(v1,'Z',
					if(vZ,'Z',
					if(vS,'S',
					if(vF,'F',
					'')))),
				   if(pCounter in [7,10],
				    if(v1,'9',
					if(v9,'9',
					if(vA,'A',
					if(vS,'S',
					'')))),
				   if(pCounter in [8,9,11,12],
				    if(vS,'S',
					''),
					''))))));
				   				    				   
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
						 
	self.temp_addr2	:= trim(StringLib.StringCleanSpaces(	trim(self.orig_city) + if(self.orig_city <> '',',','')
																												+ ' '+ self.orig_state
																												+ ' '+ self.zip
																												),left,right
																							);
	self 						:=	pInput;
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
	string18 vendor_id;
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
	//
	//string1     name_change;
    //string1     addr_change;
    //string1     ssn_change;
    //string1     former_name_change;
    //string1     new_rec;
	string1       jflag3;
	string1       valid_ssn;
	//	
	string30 temp_addr2;
	unsigned8 RawAID:=0;
	header.Layout_Source_ID;
end;

//Adjusting dates so date first seen is closer to what EQ says was a valid date for that data
np_headers_in project_headers(dNormalizedAddresses pInput)
 :=
  transform
	self.dt_first_seen				:=	pInput.address_date_reported[3..6] + pInput.address_date_reported[1..2];
	self.dt_last_seen				:=	header.Sourcedata_month.v_eq_as_of_date[1..6];
	self.dt_vendor_last_reported	:=	header.Sourcedata_month.v_eq_as_of_date[1..6];
	self.dt_vendor_first_reported	:=	header.Sourcedata_month.v_eq_as_of_date[1..6];    
	self							:=	pInput;
  end
 ;
 
np_headers_set	:=	project(dNormalizedAddresses, project_headers(LEFT));

unsigned4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;		
AID.MacAppendFromRaw_2Line(np_headers_set,addr,temp_addr2,RawAID,hdrs_addr, lFlags);

temp_rec := record
 header.Layout_In_Header;
 string1 jflag3;
 string1 valid_ssn;
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
deduped_hdrs         := dedup(sorted_hdrs,local);

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
 //way to flag records that matched none of the criteria above
 //off hand, i don't think those set to '-' have any value
 //for quick header jflag3<>'' will set src='WH', else 'QH'
 self.jflag3                   := if(le.jflag3<>'',le.jflag3,'-');
 self                          := le;
end;

map_to_new_rec_layout := project(deduped_hdrs,t_map_to_new_rec_layout(left));

did_weekly0 := header_quick.FN_DID(map_to_new_rec_layout);

did_weekly:=fn_Not_Primary_EQ(did_weekly0);

export preprocess_weekly := did_weekly : persist('~thor_data400::persist::header_preprocess_weekly_did');