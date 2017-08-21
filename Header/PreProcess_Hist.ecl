import header, address, ut, doxie, header_quick, AID, idl_header;

monthly_data := Rollup_Hist;

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
string fGetSuffix(string SuffixIn) := case(SuffixIn,'JR' => 'JR',
													'SR' => 'SR',
													'1' => 'I',
													'2' => 'II',
													'3' => 'III',
													'4' => 'IV',
													'5' => 'V',
													'6' => 'VI',
													'7' => 'VII',
													'8' => 'VIII',
													'9' => 'IX',
													'I' => 'I',
													'II' => 'II',
													'III' => 'III',
													'IV' => 'IV',
													'V' => 'V',
													'VI' => 'VI',
													'VII' => 'VII',
													'VIII' => 'VIII',
													'IX' => 'IX','');
											

string fNameIfValid(string pFirst, string pMiddle, string pLast, string pSuffix)
 :=	if(stringlib.stringfilterout(stringlib.stringtouppercase(pFirst),'ABCDEFGHIJKLMNOPQRSTUVWXYZ')
		+stringlib.stringfilterout(stringlib.stringtouppercase(pMiddle),'ABCDEFGHIJKLMNOPQRSTUVWXYZ')
		+stringlib.stringfilterout(stringlib.stringtouppercase(pLast),'ABCDEFGHIJKLMNOPQRSTUVWXYZ \'-') = '',
			Address.CleanPersonFML73(stringlib.stringfilter(stringlib.stringtouppercase(pFirst),'ABCDEFGHIJKLMNOPQRSTUVWXYZ')+ ' ' + 
										  stringlib.stringfilter(stringlib.stringtouppercase(pMiddle),'ABCDEFGHIJKLMNOPQRSTUVWXYZ') + ' ' + 
										  stringlib.stringfilter(stringlib.stringtouppercase(pLast),'ABCDEFGHIJKLMNOPQRSTUVWXYZ \'-') + ' ' + 
										  fGetSuffix(pSuffix)),
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
	
	self.title_1       := if(v_cleanName1[1..5] in ['MR','MS'],v_cleanName1[1..5],'');
    self.fname_1       := v_cleanName1[6..25];
    self.minit_1       := v_cleanName1[26..45];
    self.lname_1       := v_cleanName1[46..65];
    self.name_suffix_1 := if(v_cleanName1[66..70]='',fGetSuffix(pInput.suffix),v_cleanName1[66..70]);
    self.fname_2       := v_cleanName2[6..25];
    self.minit_2       := v_cleanName2[26..45];
    self.lname_2       := v_cleanName2[46..65];
    self.name_suffix_2 := if(v_cleanName2[66..70]='',fGetSuffix(pInput.former_suffix),v_cleanName2[66..70]);
    self.fname_3       := v_cleanName3[6..25];
    self.minit_3       := v_cleanName3[26..45];
    self.lname_3       := v_cleanName3[46..65];
    self.name_suffix_3 := if(v_cleanName3[66..70]='',fGetSuffix(pInput.former_suffix2),v_cleanName3[66..70]);
    self.fname_4       := v_cleanName4[6..25];
    self.minit_4       := v_cleanName4[26..45];
    self.lname_4       := v_cleanName4[46..65];
    self.name_suffix_4 := if(v_cleanName4[66..70]='',fGetSuffix(pInput.aka_suffix),v_cleanName4[66..70]);
	string32 cid 	   := header.Cid_Converter(pInput.cid[1])
						  + header.Cid_Converter(pInput.cid[2])
						  + header.Cid_Converter(pInput.cid[3])
						  + header.Cid_Converter(pInput.cid[4])
						  + header.Cid_Converter(pInput.cid[5])
						  + header.Cid_Converter(pInput.cid[6])
						  + header.Cid_Converter(pInput.cid[7])
						  + header.Cid_Converter(pInput.cid[8]) 
						  + header.Cid_Converter(pInput.cid[9]);
	self.vendor_id	  := if(Header.Vendor_Id_Null(header.make_new_vendor(cid)),'EQ'+(string)pInput.uid,cid);

    self.jflag3     := if(trim(pInput.ssn)='' and pInput.ssn_confirmed='C','',pInput.ssn_confirmed);
	
	self			  := pInput;
  end
;

dHeadersInNameCleaned := project(monthly_data,tCleanNames(left));

rNormalizedAddresses
 :=
  record
	string8	file_date;
	string8	file_date_max;
	string8	file_date_min;
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
	string1  ssn_confirmed;
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
	string6	min_address_date_reported;
	string6	max_address_date_reported;
	string8	birthdate;
	string10 phone;
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
    self.min_address_date_reported:= choose(pCounter,
	             pInput.min_ar1,pInput.min_ar2,pInput.min_ar3,
			     pInput.min_ar1,pInput.min_ar2,pInput.min_ar3,
			     pInput.min_ar1,pInput.min_ar2,pInput.min_ar3,
			     pInput.min_ar1,pInput.min_ar2,pInput.min_ar3
			     );
    self.max_address_date_reported := choose(pCounter,
	             pInput.max_ar1,pInput.max_ar2,pInput.max_ar3,
			     pInput.max_ar1,pInput.max_ar2,pInput.max_ar3,
			     pInput.max_ar1,pInput.max_ar2,pInput.max_ar3,
			     pInput.max_ar1,pInput.max_ar2,pInput.max_ar3
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
			 
	self.temp_addr2	:= trim(StringLib.StringCleanSpaces(	trim(stringlib.stringfilterout(self.orig_city,'/\'')) + if(stringlib.stringfilterout(self.orig_city,'/\'') <> '',',','')
																												+ ' '+ self.orig_state
																												+ ' '+ stringlib.stringfilterout(self.zip,'ABCDEFGHIJKLMNOPQRSTUVWXYZ')
																												),left,right
																							);

	self.src := 'EQ';
	self 			:= pInput;
end;

dNormalizedAddresses0			:=	normalize(dHeadersInNameCleaned,12,tNormalizeAddresses(left,counter));
//this is a tighter filter than what's in header.mac_normalize_header
dNormalizedAddresses            := dNormalizedAddresses0(stringlib.stringfilterout(stringlib.stringtouppercase(fname),'ABCDEFGHIJKLMNOPQRSTUVWXYZ')='' and stringlib.stringfilterout(stringlib.stringtouppercase(lname),'ABCDEFGHIJKLMNOPQRSTUVWXYZ \'-')='' and addr<>'');

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
	string57 addr_std;
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
	string6	min_address_date_reported;
	string6	max_address_date_reported;
	string8	birthdate;
	string10 phone;
end;

//Adjusting dates so date first seen is closer to what EQ says was a valid date for that data
np_headers_in project_headers(dNormalizedAddresses pInput)
 :=
  transform
	self.dt_first_seen				:=	pInput.File_date_min[1..6];
	self.dt_last_seen				:=	pInput.file_date_max[1..6];
	self.dt_vendor_last_reported	:=	if(pInput.max_address_date_reported='',pInput.File_date_max[1..6],pInput.max_address_date_reported);
	self.dt_vendor_first_reported	:=	if(pInput.min_address_date_reported='',pInput.file_date_min[1..6],pInput.min_address_date_reported);
	self.addr_std := if(stringlib.stringfilterout(stringlib.stringtouppercase(pInput.addr),'POBX -.0123456789')='' 
					and stringlib.stringfilterout(pInput.addr,' -0123456789')<>'','PO BOX ' + stringlib.stringfilterout(stringlib.stringtouppercase(pInput.addr),'POBX -.'),pInput.addr);				
	self.min_address_date_reported  :=  'H';
	self							:=	pInput;	
  end
 ;
 
np_headers_set	:=	project(dNormalizedAddresses, project_headers(LEFT));
dist_header_set := distribute(np_headers_set,hash(vendor_id));
srt_header_set := sort(dist_header_set,record,local);
dedup_header_set := dedup(srt_header_set,record,local);

export PreProcess_Hist := dedup_header_set : persist('~thor_data400::persist::header_preprocess_EqfxHist');