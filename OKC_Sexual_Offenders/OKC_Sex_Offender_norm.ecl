import SexOffender, lib_stringlib, ut, Digssoff;

//Fix Registration Dates
concat_files := OKC_Sexual_Offenders.File_OKC_Sex_Offender_In;

Digssoff.Layout_Target_OKC_Layout dateFix(concat_files l):= transform

self.registration_address_3 := if(l.registration_address_3<>'' and
								regexfind('AS OF|VERIFIED',StringLib.StringToUpperCase(l.registration_address_3),0)<>'',
								'',
								l.registration_address_3);
self.registration_address_4 := if(l.registration_address_4<>'' and
								regexfind('AS OF|VERIFIED',StringLib.StringToUpperCase(l.registration_address_4),0)<>'',
								'',
								l.registration_address_4);
self.registration_address_5 := if(l.registration_address_5<>'' and
								regexfind('AS OF|VERIFIED',StringLib.StringToUpperCase(l.registration_address_5),0)<>'',
								'',
								l.registration_address_5);
								
self.reg_date_1 			:= if(trim(l.reg_date_1[1..2],left,right) ~in ['20','19','','Li'] and regexfind('\\/',l.reg_date_1[1..3],0)<>'' and l.reg_date_1[7]='0',
								'20'+l.reg_date_1[7..8]+l.reg_date_1[1..2]+l.reg_date_1[4..5],
								if(trim(l.reg_date_1[1..2],left,right) ~in ['20','19','','Li'] and regexfind('\\/',l.reg_date_1[1..3],0)<>'' and l.reg_date_1[7] in ['6','7','8','9'],
								'19'+l.reg_date_1[7..8]+l.reg_date_1[1..2]+l.reg_date_1[4..5],
								if(trim(l.reg_date_1[1..2],left,right) ~in ['20','19','','Li'] and length(trim(l.reg_date_1,left,right))= 10 and regexfind('\\/',l.reg_date_1[1..3],0)<>'' and l.reg_date_1[8] in ['0','9','8'],
								l.reg_date_1[7..10]+l.reg_date_1[1..2]+l.reg_date_1[4..5],
								l.reg_date_1)));
self.reg_date_2 			:= if(trim(l.reg_date_2[1..2],left,right) ~in ['20','19','','Li'] and regexfind('\\/',l.reg_date_2[1..3],0)<>'' and l.reg_date_2[7]='0',
								'20'+l.reg_date_2[7..8]+l.reg_date_2[1..2]+l.reg_date_2[4..5],
								if(trim(l.reg_date_2[1..2],left,right) ~in ['20','19','','Li'] and regexfind('\\/',l.reg_date_2[1..3],0)<>'' and l.reg_date_2[7] in ['6','7','8','9'],
								'19'+l.reg_date_2[7..8]+l.reg_date_2[1..2]+l.reg_date_2[4..5],
								if(trim(l.reg_date_2[1..2],left,right) ~in ['20','19','','Li'] and length(trim(l.reg_date_2,left,right))= 10 and regexfind('\\/',l.reg_date_2[1..3],0)<>'' and l.reg_date_2[8] in ['0','9','8'],
								l.reg_date_2[7..10]+l.reg_date_2[1..2]+l.reg_date_2[4..5],
								l.reg_date_2)));
self.reg_date_3 			:= if(trim(l.reg_date_3[1..2],left,right) ~in ['20','19','','Li'] and regexfind('\\/',l.reg_date_3[1..3],0)<>'' and l.reg_date_3[7]='0',
								'20'+l.reg_date_3[7..8]+l.reg_date_3[1..2]+l.reg_date_3[4..5],
								if(trim(l.reg_date_3[1..2],left,right) ~in ['20','19','','Li'] and regexfind('\\/',l.reg_date_3[1..3],0)<>'' and l.reg_date_3[7] in ['6','7','8','9'],
								'19'+l.reg_date_3[7..8]+l.reg_date_3[1..2]+l.reg_date_3[4..5],
								if(trim(l.reg_date_3[1..2],left,right) ~in ['20','19','','Li'] and length(trim(l.reg_date_3,left,right))= 10 and regexfind('\\/',l.reg_date_3[1..3],0)<>'' and l.reg_date_3[8] in ['0','9','8'],
								l.reg_date_3[7..10]+l.reg_date_3[1..2]+l.reg_date_3[4..5],
								l.reg_date_3)));
self := l;
end;

date_fix := project(concat_files,dateFix(left));

//Bugzilla #39184 -- UT Addresses///////////////////////////////////////////////////////////////////////
stFilter := date_fix(state_of_origin='UT');

Digssoff.Layout_Target_OKC_Layout concatAddress(stFilter l):= transform
	self.registration_address_1 := if(l.registration_address_1<>'' and l.registration_address_2<>'',
										StringLib.StringToUpperCase(l.registration_address_1)+', '+StringLib.StringToUpperCase(l.registration_address_2),
										'');
	self.registration_address_2 := '';
	self := l;
end;

concatAddr := project(stFilter, concatAddress(left));

Digssoff.Layout_Target_OKC_Layout fixAddress(concatAddr l):= transform

	prep_address				:= stringlib.stringfilter(trim(l.registration_address_1, left, right),
										' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ,');
	
	prep_state 					:= if(regexfind(',', prep_address, 0)<>'',
										trim(prep_address[length(prep_address)-stringlib.stringfind(stringLib.StringReverse(trim(prep_address, left, right)), ',', 1)+2..length(prep_address)-stringlib.stringfind(stringLib.StringReverse(trim(prep_address, left, right)), ',', 1)+4]),
										'XX');
																	
	prep_city					:= if(regexfind(',', prep_address, 0)<>'',
										prep_address[1..stringlib.stringfind(trim(prep_address, left, right), ',', 1)-1],
										'XX');
	
	prep_zip					:= if(regexfind('[0-9]+', l.registration_address_1, 0)<>'',
										l.registration_address_1[length(l.registration_address_1)-stringlib.stringfind(stringLib.StringReverse(trim(l.registration_address_1, left, right)), ' ', 1)+1..length(l.registration_address_1)],
										'');
	
	string c_4token  			:= if(trim(regexreplace(',', prep_city, ''), left, right)<>'',
										regexreplace(',', prep_city[stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' ')-3)+1..stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' ')-3)+40], ''),
										'XX');
		
	string c_3token  			:= if(trim(regexreplace(',', prep_city, ''), left, right)<>'',
										regexreplace(',', prep_city[stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' ')-2)+1..stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' ')-2)+40], ''),
										'XX');
	
	string c_2token  			:= if(trim(regexreplace(',', prep_city, ''), left, right)<>'',
										regexreplace(',', prep_city[stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' ')-1)+1..stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' ')-1)+40], ''),
										'XX');
	
	string c_1token  			:= if(trim(regexreplace(',', prep_city, ''), left, right)<>'',
										regexreplace(',', prep_city[stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' '))+1..stringlib.stringfind(prep_city,' ',stringlib.stringfindcount(prep_city,' '))+40], ''),
										'XX');
	
	//city list derived from zip
	drvd_city 					:= if(trim(prep_zip)<>'',
										trim(regexreplace('[0-9]|,', ziplib.ZipToCities(stringlib.stringfilter(prep_zip, '0123456789')[1..5]), ''), left, right),
										'XX');
	
	//city pulled from input address line 1 that exists in derived list
	prsd_city 					:= if(trim(c_4token,left,right)<>'' and drvd_city<>'' and regexfind(trim(c_4token,left,right),drvd_city),
											c_4token,
											if(trim(c_3token,left,right)<>'' and drvd_city<>'' and regexfind(trim(c_3token,left,right),drvd_city),
											c_3token,
											if(trim(c_2token,left,right)<>'' and drvd_city<>'' and regexfind(trim(c_2token,left,right),drvd_city),
											c_2token,
											if(trim(c_1token,left,right)<>'' and drvd_city<>'' and regexfind(trim(c_1token,left,right),drvd_city),
											c_1token,
											''))));
											
	address_1 					:= if(prsd_city != '',
											lib_StringLib.StringLib.StringToUpperCase(trim(regexreplace(trim(prsd_city,left,right),prep_city,''),left,right)),
											if(regexfind(',', prep_address, 0)<>'',
											prep_address[1..stringlib.stringfind(prep_address, ',', 1)-1-stringlib.stringfind(StringLib.StringReverse(trim(prep_address, left, right)), ',', 1)-1],
											''));
	
	address_2					:= lib_StringLib.StringLib.StringToUpperCase(trim(prsd_city,left,right) + if(trim(prsd_city, left, right) <> '',', ','') + trim(prep_state, left, right) + ' ' + trim(prep_zip, left, right)[1..5]);

	self.registration_address_1 := if(address_1<>'',
										address_1,
										'');
	self.registration_address_2 := if(address_2<>'',
										address_2,
										'');
	self 						:= l;
	
end;

fixAddr	:= project(concatAddr, fixAddress(left));

//////////////////////////////////////////////////////////////
cfiles 	:= date_fix(state_of_origin<>'UT') + fixAddr;

//Fix FL Registration_Address_4 & 5 Fields
in_file_fl := cfiles(state_of_origin='FL');

Layout_out1 := record
	OKC_Sexual_Offenders.Layout_OKC_Fixed_Altered;
	//unsigned8 fpos;
end;

Layout_out1 transRegAddr(in_file_fl l) := transform
self.source_file := l.source;
self.scrape_date := l.date_updated;
self.orig_state := l.state_of_origin;
self.registration_address_4 := if(l.registration_address_4<>'' and
								regexfind('SOURCE:',l.registration_address_4,0)<>'',
								'',
								l.registration_address_4);
self.registration_address_5 := if(l.registration_address_5<>'' and
								regexfind('TYPE:',l.registration_address_5,0)<>'',
								'',
								l.registration_address_5);
self.addl_comments_1		:= if(l.registration_address_4<>'' and
								regexfind('SOURCE:',l.registration_address_4[1..140],0)<>'',
								l.registration_address_4,
								'');
self.addl_comments_2		:=	if(l.registration_address_5<>'' and
								regexfind('TYPE:',l.registration_address_5[1..140],0)<>'',
								l.registration_address_5,
								'');
self := l;
end;

in_file_fl_table := project(in_file_fl,transRegAddr(left));

///////////////////////////////////////////////////////////

in_file_all := cfiles(state_of_origin<>'FL');

Layout_out1 transRegAddr2(in_file_all l) := transform
self.source_file := l.source;
self.scrape_date := l.date_updated;
self.orig_state := l.state_of_origin;
self.addl_comments_1 := l.addl_comments_1[1..140];
self.addl_comments_2 := l.addl_comments_2[1..140];
self := l;
end;

in_file_all_table := project(in_file_all,transRegAddr2(left));

in_file := in_file_fl_table + in_file_all_table;

//Fix TX Registration_Address_3 Fields
in_file_tx 		:= in_file(orig_state='TX');
in_file_all2 	:= in_file(orig_state<>'TX');
in_file_new 	:= in_file_tx + in_file_all2;

////////////////////////////////////////////////////////////////////////////////////////
/*
//Add OKC VA & CO Data
dslayout := RECORD
,maxLength(9999)
  string source_file;
  string scrape_date;
  string orig_state;
  string name_orig;
  string name_aka;
  string offender_status;
  string offender_category;
  string risk_level_code;
  string risk_description;
  string police_agency;
  string police_agency_contact_name;
  string police_agency_address_1;
  string police_agency_address_2;
  string police_agency_phone;
  string registration_type;
  string reg_date_1;
  string reg_date_1_type;
  string reg_date_2;
  string reg_date_2_type;
  string reg_date_3;
  string reg_date_3_type;
  string registration_address_1;
  string registration_address_2;
  string registration_address_3;
  string registration_address_4;
  string registration_address_5;
  string registration_county;
  string employer;
  string employer_address_1;
  string employer_address_2;
  string employer_address_3;
  string employer_address_4;
  string employer_address_5;
  string employer_county;
  string school;
  string school_address_1;
  string school_address_2;
  string school_address_3;
  string school_address_4;
  string school_address_5;
  string school_county;
  string offender_id;
  string doc_number;
  string sor_number;
  string st_id_number;
  string fbi_number;
  string ncic_number;
  string orig_ssn;
  string date_of_birth;
  string date_of_birth_aka;
  string age;
  string race;
  string ethnicity;
  string sex;
  string hair_color;
  string eye_color;
  string height;
  string weight;
  string skin_tone;
  string build_type;
  string scars_marks_tattoos;
  string shoe_size;
  string corrective_lense_flag;
  string conviction_jurisdiction_1;
  string conviction_date_1;
  string court_1;
  string court_case_number_1;
  string offense_date_1;
  string offense_code_or_statute_1;
  string offense_description_1;
  string offense_description_1_2;
  string victim_minor_1;
  string victim_age_1;
  string victim_gender_1;
  string victim_relationship_1;
  string sentence_description_1;
  string sentence_description_1_2;
  string conviction_jurisdiction_2;
  string conviction_date_2;
  string court_2;
  string court_case_number_2;
  string offense_date_2;
  string offense_code_or_statute_2;
  string offense_description_2;
  string offense_description_2_2;
  string victim_minor_2;
  string victim_age_2;
  string victim_gender_2;
  string victim_relationship_2;
  string sentence_description_2;
  string sentence_description_2_2;
  string conviction_jurisdiction_3;
  string conviction_date_3;
  string court_3;
  string court_case_number_3;
  string offense_date_3;
  string offense_code_or_statute_3;
  string offense_description_3;
  string offense_description_3_2;
  string victim_minor_3;
  string victim_age_3;
  string victim_gender_3;
  string victim_relationship_3;
  string sentence_description_3;
  string sentence_description_3_2;
  string conviction_jurisdiction_4;
  string conviction_date_4;
  string court_4;
  string court_case_number_4;
  string offense_date_4;
  string offense_code_or_statute_4;
  string offense_description_4;
  string offense_description_4_2;
  string victim_minor_4;
  string victim_age_4;
  string victim_gender_4;
  string victim_relationship_4;
  string sentence_description_4;
  string sentence_description_4_2;
  string conviction_jurisdiction_5;
  string conviction_date_5;
  string court_5;
  string court_case_number_5;
  string offense_date_5;
  string offense_code_or_statute_5;
  string offense_description_5;
  string offense_description_5_2;
  string victim_minor_5;
  string victim_age_5;
  string victim_gender_5;
  string victim_relationship_5;
  string sentence_description_5;
  string sentence_description_5_2;
  string addl_comments_1;
  string addl_comments_2;
  string orig_dl_number;
  string orig_dl_state;
  string orig_veh_year_1;
  string orig_veh_color_1;
  string orig_veh_make_model_1;
  string orig_veh_plate_1;
  string orig_veh_state_1;
  string orig_veh_year_2;
  string orig_veh_color_2;
  string orig_veh_make_model_2;
  string orig_veh_plate_2;
  string orig_veh_state_2;
  string image_link;
  string image_date;
 END;

ds_va := dataset(ut.foreign_prod+'~thor_200::in::okc_sex_off::va::superfile',dslayout,flat);

Layout_out1 standardForm1(dslayout l):= transform
self.date_added:='';
self.intnet_email_address_1:='';
self.intnet_email_address_2:='';
self.intnet_email_address_3:='';
self.intnet_email_address_4:='';
self.intnet_email_address_5:='';
self.intnet_instant_message_addr_1:='';
self.intnet_instant_message_addr_2:='';
self.intnet_instant_message_addr_3:='';
self.intnet_instant_message_addr_4:='';
self.intnet_instant_message_addr_5:='';
self.intnet_user_name_1:='';
self.intnet_user_name_1_url:='';
self.intnet_user_name_2:='';
self.intnet_user_name_2_url:='';
self.intnet_user_name_3:='';
self.intnet_user_name_3_url:='';
self.intnet_user_name_4:='';
self.intnet_user_name_4_url:='';
self.intnet_user_name_5:='';
self.intnet_user_name_5_url:='';
self.registration_home_phone:='';
self.registration_cell_phone:='';
self.other_registration_address_1:='';
self.other_registration_address_2:='';
self.other_registration_address_3:='';
self.other_registration_address_4:='';
self.other_registration_address_5:='';
self.other_registration_county:='';
self.other_registration_phone:='';
self.temp_lodge_address_1:='';
self.temp_lodge_address_2:='';
self.temp_lodge_address_3:='';
self.temp_lodge_address_4:='';
self.temp_lodge_address_5:='';
self.temp_lodge_county:='';
self.temp_lodge_phone:='';
self.employer_phone:='';
self.employer_comments:='';
self.professional_licenses_1:='';
self.professional_licenses_2:='';
self.professional_licenses_3:='';
self.professional_licenses_4:='';
self.professional_licenses_5:='';
self.school_phone:='';
self.school_comments:='';
self.dna:='';
self.arrest_date_1:='';
self.arrest_warrant_1:='';
self.arrest_date_2:='';
self.arrest_warrant_2:='';
self.arrest_date_3:='';
self.arrest_warrant_3:='';
self.arrest_date_4:='';
self.arrest_warrant_4:='';
self.arrest_date_5:='';
self.arrest_warrant_5:='';
self.orig_dl_link:='';
self.orig_dl_date:='';
self.passport_type:='';
self.passport_code:='';
self.passport_number:='';
self.passport_first_name:='';
self.passport_given_name:='';
self.passport_nationality:='';
self.passport_dob:='';
self.passport_place_of_birth:='';
self.passport_sex:='';
self.passport_issue_date:='';
self.passport_authority:='';
self.passport_expiration_date:='';
self.passport_endorsement:='';
self.passport_link:='';
self.passport_date:='';
self.orig_registration_number_1:='';
self.orig_veh_location_1:='';
self.orig_registration_number_2:='';
self.orig_veh_location_2:='';
self.orig_veh_year_3:='';
self.orig_veh_color_3:='';
self.orig_veh_make_model_3:='';
self.orig_veh_plate_3:='';
self.orig_registration_number_3:='';
self.orig_veh_state_3:='';
self.orig_veh_location_3:='';
self.orig_veh_year_4:='';
self.orig_veh_color_4:='';
self.orig_veh_make_model_4:='';
self.orig_veh_plate_4:='';
self.orig_registration_number_4:='';
self.orig_veh_state_4:='';
self.orig_veh_location_4:='';
self.orig_veh_year_5:='';
self.orig_veh_color_5:='';
self.orig_veh_make_model_5:='';
self.orig_veh_plate_5:='';
self.orig_registration_number_5:='';
self.orig_veh_state_5:='';
self.orig_veh_location_5:='';
self.fingerprint_link:='';
self.fingerprint_date:='';
self.palmprint_link:='';
self.palmprint_date:='';
self := l;
end;

ds_va_project := project(ds_va, standardForm1(left));
*/
//ds_co := dataset('~thor_200::in::okc_sex_off::co::superfile',dslayout,flat);
//ds_co_project := project(ds_co, standardForm1(left));

in_file2 := in_file_new;// + ds_va_project; //+ ds_co_project;

////////////////////////////////////////////////////////////////////////////////////////

Layout_out := record
	unsigned8 key;
	string1   name_type;
	OKC_Sexual_Offenders.Layout_OKC_Fixed_Altered;
	//unsigned8 fpos;
end;

//in_file := OKC_Sexual_Offenders.File_OKC_Sex_Offender_In;

bad_values := ['',',',';',':','NONE','UNKNOWN','UNK'];

AlphaNumeric := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

// Only add the key value and set the name_type to the primary value for the record 
// if the name and two address fields are valid, otherwise skip the record
Layout_out trfProject(in_file2 l, integer c) := transform
	//self.key := l.orig_state + hash64(l.name_orig + l.registration_address_1 + l.registration_address_2 + l.date_of_birth);
	self.key :=  IF(lib_stringlib.stringlib.stringfilter(TRIM(l.name_orig,left,right)
	                                                    ,AlphaNumeric) in bad_values 
	            AND lib_stringlib.stringlib.stringfilter(TRIM(l.registration_address_1,left,right)
				                                        ,AlphaNumeric) in bad_values 
				AND lib_stringlib.stringlib.stringfilter(TRIM(l.registration_address_2,left,right)
				                                        ,AlphaNumeric) in bad_values 
				   , SKIP
				   , c);
    self.name_type  := '0';	
	//self.fpos := l.fpos;
 	self := l;	
end;

ds_with_new_fields := PROJECT(in_file2, trfProject(left, counter));
count_ds_with_new_fields := count(ds_with_new_fields);
//output(count_ds_with_new_fields,named('With_New_Fields'));

////////// Begin parsing and normalizing name AKAs//////////
pattern SingleName := pattern('[^;]+');

MyParsedRecord := record 
	ds_with_new_fields;
	string CompleteName := TRIM(MATCHTEXT(SingleName),left,right);
end;
	
// Parse the AKA name values	
MyParsedDs := PARSE(ds_with_new_fields,name_aka,SingleName,MyParsedRecord,scan,first);
// Specify the invalid AKA name values
Invalid_AKA_names := ['',',','NONE','N/A','NOT AVAILABLE','UNAVAILABLE','UNKNOWN','NONE REPORTED'];
// Transform the AKA name values
Layout_out trfAkaName(MyParsedDs l, unsigned c) := transform
	self.name_orig := IF(stringlib.StringToUpperCase(TRIM(l.CompleteName,left,right)) in Invalid_AKA_names
	                    ,SKIP
						,TRIM(l.CompleteName,left,right));
	self.name_type := '2';
	self := l;
end;
// Normalize the AKA name values
ds_NornAkaNames := NORMALIZE(MyParsedDs
                            ,1
							,trfAkaName(left,counter));
// Make a union of the original and the normalized data
ds_AllNames := ds_with_new_fields + ds_NornAkaNames;
count_ds_AllNames := count(ds_AllNames);
//output(count_ds_AllNames,named('AllNames'));
////////// End parsing and normalizing name AKAs//////////

////////// Begin parsing and normalizing date of birth AKAs//////////
pattern SingleDOB := pattern('[^;]+');

MyParsedDOBRecord := record 
	ds_AllNames;
	string CompleteDOB := TRIM(MATCHTEXT(SingleDOB),left,right);
end;
	
// Parse the AKA DOB values	
MyParsedDOBDs := PARSE(ds_AllNames,date_of_birth_aka,SingleDOB,MyParsedDOBRecord,scan,first);
count_MyParsedDOBDs := count(MyParsedDOBDs);
//output(count_MyParsedDOBDs,named('ParsedDOBs'));

// Transform the AKA DOB values
Layout_out trfAkaDOB(MyParsedDOBDs l, unsigned c) := transform
	self.date_of_birth := TRIM(l.CompleteDOB,left,right);
	self.name_type     := '3';
	self := l;
end;
// Normalize the AKA DOB values
ds_NornAkaDOBs := NORMALIZE(MyParsedDOBDs
                           ,1
						   ,trfAkaDOB(left,counter));
count_ds_NornAkaDOBs := count(ds_NornAkaDOBs);
//output(count_ds_NornAkaDOBs,named('Normalized_DOBs'));
// Make a union of the original and the normalized data
ds_AllNamesAndDOBs := ds_AllNames + ds_NornAkaDOBs;
count_ds_AllNamesAndDOBs := count(ds_AllNamesAndDOBs);
//output(count_ds_AllNamesAndDOBs,named('All_Names_and_Normalized_DOBs'));
////////// End parsing and normalizing date of birth AKAs//////////

// Dedup the AKA values
ds_dedupsAkaName := DEDUP(SORT(ds_AllNamesAndDOBs
                              ,orig_state
							  ,name_orig
							  ,name_type
							  ,registration_address_1
							  ,registration_address_2
							  ,date_of_birth
							  ,date_of_birth_aka
							  ,-image_link)
					     ,except key 
						       , name_type
						       , Image_Link);
count_ds_dedupsAkaName := count(ds_dedupsAkaName);							   
//output(count_ds_dedupsAkaName,named('Deduped_All_Names_and_Normalized_DOBs'));
// Sort the deduped AKA name values
sorted_ds_dedupedAkaName := SORT(ds_dedupsAkaName
                                ,orig_state
								,key
								,name_type
								,name_orig
								,date_of_birth
								,date_of_birth_aka);
								
export OKC_Sex_Offender_Norm := sorted_ds_dedupedAkaName : persist('~thor_data400::Persist::OKC_Sex_Offender_norm');