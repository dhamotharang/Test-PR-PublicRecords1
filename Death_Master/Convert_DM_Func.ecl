import header,text_search,Property,Codes;

export Convert_DM_Func := function

udmain_file := header.File_DID_Death_MasterV2;

udsupp_file := header.file_death_master_supplemental;

main_file := distribute(udmain_file,hash(state_death_id));

supp_file := distribute(udsupp_file,hash(state_death_id));

boolean_layout := record, maxlength(10000)
	string9  ssn := '';
	string20 lname := '';
	string20 fname := '';
	string20 mname := '';
	string4 name_suffix := '';
	string8  dod8 := '';
	string8  dob8 := '';
	string2  st_country_code := '';
	string5  zip_lastres := '';
	string5  zip_lastpayment := '';
	string2  state := '';
	string3  fipscounty := '';
	string18 county_desc := '';
	string16 state_death_id := '';
	string2 SOURCE_STATE := '';
	string28 PUBLICATION := '';
	string93 DECEDENT_RACE := '';
	string69 DECEDENT_ORIGIN := '';
	string12 DECEDENT_SEX := '';
	string34 DECEDENT_AGE := '';
	string26 EDUCATION := '';
	string74 OCCUPATION := '';
	string62 WHERE_WORKED := '';
	string289 CAUSE := '';
	string35 BIRTHPLACE := '';
	string38 MARITAL_STATUS := '';
	string44 FATHER := '';
	string44 MOTHER := '';
	string8 FILED_DATE := '';
	string4 YEAR := '';
	string77 COUNTY_RESIDENCE := '';
	string23 COUNTY_DEATH := '';
	string76 ADDRESS := '';
	string7 AUTOPSY := '';
	string44 AUTOPSY_FINDINGS := '';
	string3 MED_EXAM := '';
	string6 EST_LIC_NO := '';
	string22 DISPOSITION := '';
	string8 DISPOSITION_DATE := '';
	string9 WORK_INJURY := '';
	string8 INJURY_DATE := '';
	string23 INJURY_TYPE := '';
	string50 INJURY_LOCATION := '';
	string7 SURG_PERFORMED := '';
	string8 SURGERY_DATE := '';
	string120 HOSPITAL_STATUS := '';
	string14 PREGNANCY := '';
	string70 FACILITY_DEATH := '';
	string6 EMBALMER_LIC_NO := '';
	string21 DEATH_TYPE := '';
	string5 TIME_DEATH := '';
	string12 BIRTH_CERT := '';
	string31 CERTIFIER := '';
	string20 CERT_NUMBER := '';
	string5 LOCAL_FILE_NO := '';
	string3 US_ARMED_FORCES := '';
	string49 PLACE_OF_DEATH := '';
	string3 CERTIFICATE_VOL_NO := '';
  string4 CERTIFICATE_VOL_YEAR := '';
  string4 BIRTH_VOL_YEAR := '';
	string st_country_desc := '';
end;

boolean_layout join_main_supp(main_file l, supp_file r) := transform
self.ssn := l.ssn;
self.lname := l.lname;
self.fname := l.fname;
self.mname := l.mname;
self.name_suffix := l.name_suffix;
self.dod8 := l.dod8;
self.dob8 := l.dob8;
self.st_country_code := l.st_country_code;
self.zip_lastres := l.zip_lastres;
self.zip_lastpayment := l.zip_lastpayment;
self.state := l.state;
self.fipscounty := l.fipscounty;
self.state_death_id := l.state_death_id;
self.SOURCE_STATE := r.SOURCE_STATE;
self.PUBLICATION := r.PUBLICATION;
self.DECEDENT_RACE := r.DECEDENT_RACE;
self.DECEDENT_ORIGIN := r.DECEDENT_ORIGIN;
self.DECEDENT_SEX := r.DECEDENT_SEX;
self.DECEDENT_AGE := r.DECEDENT_AGE;
self.EDUCATION := r.EDUCATION;
self.OCCUPATION := r.OCCUPATION;
self.WHERE_WORKED := r.WHERE_WORKED;
self.CAUSE := r.CAUSE;
self.BIRTHPLACE := r.BIRTHPLACE;
self.MARITAL_STATUS := r.MARITAL_STATUS;
self.FATHER := r.FATHER;
self.MOTHER := r.MOTHER;
self.FILED_DATE := r.FILED_DATE;
self.YEAR := r.YEAR;
self.COUNTY_RESIDENCE := r.COUNTY_RESIDENCE;
self.COUNTY_DEATH := r.COUNTY_DEATH;
self.ADDRESS := r.ADDRESS;
self.AUTOPSY := r.AUTOPSY;
self.AUTOPSY_FINDINGS := r.AUTOPSY_FINDINGS;
self.MED_EXAM := r.MED_EXAM;
self.EST_LIC_NO := r.EST_LIC_NO;
self.DISPOSITION := r.DISPOSITION;
self.DISPOSITION_DATE := r.DISPOSITION_DATE;
self.WORK_INJURY := r.WORK_INJURY;
self.INJURY_DATE := if (length(trim(r.INJURY_DATE)) = 8 and regexfind('[0-9]',r.INJURY_DATE) ,r.injury_date[5..] +  r.injury_date[1..2] + r.injury_date[3..4],r.INJURY_DATE);
self.INJURY_TYPE := r.INJURY_TYPE;
self.INJURY_LOCATION := r.INJURY_LOCATION;
self.SURG_PERFORMED := r.SURG_PERFORMED;
self.SURGERY_DATE := if (length(trim(r.SURGERY_DATE)) = 8 and regexfind('[0-9]',r.SURGERY_DATE),r.SURGERY_DATE[5..] +  r.SURGERY_DATE[1..2] + r.SURGERY_DATE[3..4],r.SURGERY_DATE);
self.HOSPITAL_STATUS := r.HOSPITAL_STATUS;
self.PREGNANCY := r.PREGNANCY;
self.FACILITY_DEATH := r.FACILITY_DEATH;
self.EMBALMER_LIC_NO := r.EMBALMER_LIC_NO;
self.DEATH_TYPE := r.DEATH_TYPE;
self.TIME_DEATH := r.TIME_DEATH;
self.BIRTH_CERT := r.BIRTH_CERT;
self.CERTIFIER := r.CERTIFIER;
self.CERT_NUMBER := r.CERT_NUMBER;
self.LOCAL_FILE_NO := r.LOCAL_FILE_NO;
self.US_ARMED_FORCES := r.US_ARMED_FORCES;
self.PLACE_OF_DEATH := r.PLACE_OF_DEATH;
self.CERTIFICATE_VOL_NO := r.certificate_vol_no;
self.CERTIFICATE_VOL_YEAR := r.certificate_vol_year;
self.BIRTH_VOL_YEAR := r.BIRTH_VOL_YEAR;
end;

main_join := join(main_file,supp_file,
				left.state_death_id = right.state_death_id,
				join_main_supp(left,right),
				left outer,local
				);

boolean_layout lkp_st_ctry_codes(main_join l, Codes.Key_Codes_V3 R) := transform
	self.st_country_desc := r.long_desc;
	self := l;
end;

lkp_join := join(main_join,Codes.Key_Codes_V3,
					left.st_country_code = right.code and right.file_name = 'DEATH_MASTER' and right.field_name = 'ST_COUNTRY_CODE'
					and right.field_name2 = '',
					lkp_st_ctry_codes(left,right),left outer, LOOKUP,	local);

boolean_layout lkp_county(lkp_join l,Property.Layout_County_Code_Names R) := transform
	self.county_desc := r.county_name;
	self := l;
end;

join_out := join(lkp_join,Property.File_County_Code_Names,
						(integer)left.fipscounty = (integer)right.fips_county_code
						and left.state = right.state,
						lkp_county(left,right),left outer, lookup);


// Convert to document + state_death_id field

layout_DM_record := record(text_search.Layout_Document)
	string16 state_death_id;
end;

				
Layout_DM_record DH_Convert(join_out l) := transform
	self.state_death_id := l.state_death_id;
	SELF.docRef.src := if(l.source_state <> '',TRANSFER(l.source_state[1..2], INTEGER2),
								TRANSFER('NA',integer2));
	SELF.docRef.doc := 0;
	self.segs := dataset([
	        {1,0,l.fname + ' ' + l.mname + ' ' + l.lname + ' ' + l.name_suffix + '; '},
        {2,0,l.address + ' ' + l.state + ' ' + l.st_country_desc + l.zip_lastres + '; '},
        //{3,0,l.city},
        //{4,0,l.state},
        //{5,0,l.address},
        //{6,0,l.zip_lastres},
        //{7,0,l.county_desc},
        {8,0,l.ssn},
        {9,0,l.dob8},
        {10,0,l.dod8},
        {11,0,l.DECEDENT_SEX},
        {12,0,l.birthplace},
        {13,0,l.DECEDENT_AGE},
        {14,0,l.birth_cert},
        {15,0,l.birth_vol_year},
        {16,0,l.education},
        {17,0,l.US_ARMED_FORCES},
        {18,0,l.occupation},
        {19,0,l.marital_status},
        {20,0,l.father + '; '},
        {21,0,l.mother + '; '},
        {22,0,l.source_state}, 
        {23,0,l.cert_number},
        {24,0,l.filed_date},
        {25,0,l.certificate_vol_no},
        {26,0,l.certificate_vol_year},
        {27,0,l.local_file_no},
        {28,0,l.EMBALMER_LIC_NO},
        {29,0,l.embalmer_lic_no},
        {30,0,l.zip_lastpayment},
        {31,0,l.cause},
        {32,0,l.time_death},
        {33,0,l.place_of_death},
        {34,0,l.facility_death},
        {35,0,l.death_type},
        {36,0,l.disposition},
        {37,0,l.disposition_date},
        {38,0,l.autopsy},
        {39,0,l.autopsy_findings},
        {40,0,l.med_exam},
        {41,0,l.work_injury},
        {42,0,if(trim(l.work_injury) = 'YES',l.injury_date,'')},
        {43,0,l.injury_date},
        {44,0,l.injury_location},
        {45,0,l.surg_performed},
        {46,0,l.surgery_date},
        {47,0,l.pregnancy},
        {48,0,l.certifier},
        {49,0,l.hospital_status}
	],Text_search.Layout_segment);
end;


proj_out := project(join_out,DH_Convert(left));

// Need to assign a unique id for document - because state_death_id is 16 byte 

layout_DM_flat := record(Text_Search.Layout_DocSeg)
	string16 state_death_id;
end;

layout_dm_flat flat1(layout_dm_record l, text_search.Layout_segment r) 
	:= TRANSFORM
		self.state_death_id := l.state_death_id;
		SELF.docRef := l.docRef;
		SELF := r;
END;
	
norm_dm := NORMALIZE(proj_out, LEFT.segs, flat1(LEFT,RIGHT));

sort_dm := sort(norm_dm(content <> '' and trim(content) <> ';'),state_death_id,segment,local);

layout_dm_flat Iterate_doc(layout_dm_flat L,layout_dm_flat R) 
	:= Transform
		self.DocRef.doc := if(L.state_death_id = R.state_death_id, L.docref.doc,
													if (L.docref.doc = 0,thorlib.node()+1,L.DocRef.doc + thorlib.nodes()));
		self.sect := IF(L.state_death_id<>R.state_death_id OR L.segment<>R.segment, 0, l.sect+1);
		self.docRef.src := r.docRef.src;
		self := R;
end;

iterate_dm := iterate(sort_dm,Iterate_doc(left,right),local);


// External key
	
	layout_dm_flat MakeKeySegs( iterate_dm l, unsigned2 segno ) := TRANSFORM
		self.state_death_id := l.state_death_id;
        self.docref.doc := l.docref.doc;
        self.docref.src := l.docref.src;
		self.segment := segno;
        self.content := l.state_death_id;
        self.sect := 1;
    END;

    segkeys := PROJECT(iterate_dm(trim(content) <> '' and trim(content) <> ';'),MakeKeySegs(LEFT,250));

	full_ret := iterate_dm(trim(content) <> '' and trim(content) <> ';') + segkeys;
	
	return full_ret;

end;