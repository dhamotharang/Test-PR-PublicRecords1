import Prof_License,Address,ut,NID,lib_Stringlib,_Validate;

EXPORT proc_clean_all( dataset(recordof(Prof_License.Layout_proLic_in))infile,string state ) := module

//Assign prolic key



Prof_License.Layout_proLic_in appendPLkey( infile l) := transform

valid_license_number := if ( l.license_number <> '',l.license_number,l.orig_license_number);

self.prolic_key := if ( StringLib.Stringfilter(valid_license_number, '123456789') <> '' ,
                                                                                     (string) hash32(trim(l.source_st)+ ut.CleanSpacesAndUpper (trim(l.vendor))) + trim(valid_license_number) [1..50]
																																										 , '' 
										  );
self.orig_license_number := if ( l.orig_license_number <> '',l.orig_license_number,valid_license_number);
self.license_number := if ( l.license_number <> '',l.license_number,valid_license_number);
self           := l;
end;

dWithKey := project( infile ,appendPLkey(left));

Prof_License.Layout_proLic_in toupper( dWithKey l ) := transform
  self.profession_or_board             := ut.CleanSpacesAndUpper (l.profession_or_board);
  self.license_type                    := ut.CleanSpacesAndUpper (l.license_type);
  self.status                          := ut.CleanSpacesAndUpper (l.status);
  self.orig_license_number             := ut.CleanSpacesAndUpper (l.orig_license_number);
  self.license_number                  := ut.CleanSpacesAndUpper (l.license_number);
  self.previous_license_number         := ut.CleanSpacesAndUpper (l.previous_license_number);
  self.previous_license_type           := ut.CleanSpacesAndUpper (l.previous_license_type);
  self.company_name                    := ut.CleanSpacesAndUpper (l.company_name);
  self.orig_name                       := ut.CleanSpacesAndUpper (l.orig_name);
  self.name_order                      := ut.CleanSpacesAndUpper (l.name_order);
  self.orig_former_name                := ut.CleanSpacesAndUpper (l.orig_former_name);
  self.former_name_order               := ut.CleanSpacesAndUpper (l.former_name_order);
  self.orig_addr_1                     := ut.CleanSpacesAndUpper (l.orig_addr_1);
  self.orig_addr_2                     := ut.CleanSpacesAndUpper (l.orig_addr_2);
  self.orig_addr_3                     := ut.CleanSpacesAndUpper (l.orig_addr_3);
  self.orig_addr_4                     := ut.CleanSpacesAndUpper (l.orig_addr_4);
  self.orig_city                       := ut.CleanSpacesAndUpper (l.orig_city);
  self.orig_st                         := ut.CleanSpacesAndUpper (l.orig_st);
  self.county_str                      := ut.CleanSpacesAndUpper (l.county_str);
  self.country_str                     := ut.CleanSpacesAndUpper (l.country_str);
  self.business_flag                   := ut.CleanSpacesAndUpper (l.business_flag);
  self.phone                           := ut.CleanSpacesAndUpper (l.phone);
  self.sex                             := ut.CleanSpacesAndUpper (l.sex);
  self.license_obtained_by             := ut.CleanSpacesAndUpper (l.license_obtained_by);
  self.board_action_indicator          := ut.CleanSpacesAndUpper (l.board_action_indicator);
  self.source_st                       := ut.CleanSpacesAndUpper (l.source_st);
  self.vendor                          := ut.CleanSpacesAndUpper (l.vendor);
  self.action_record_type              := ut.CleanSpacesAndUpper (l.action_record_type);
  self.action_complaint_violation_cds  := ut.CleanSpacesAndUpper (l.action_complaint_violation_cds);
  self.action_complaint_violation_desc := ut.CleanSpacesAndUpper (l.action_complaint_violation_desc);
  self.action_case_number              := ut.CleanSpacesAndUpper (l.action_case_number);
  self.action_cds                      := ut.CleanSpacesAndUpper (l.action_cds);
  self.action_desc                     := ut.CleanSpacesAndUpper (l.action_desc);
  self.action_final_order_no           := ut.CleanSpacesAndUpper (l.action_final_order_no);
  self.action_status                   := ut.CleanSpacesAndUpper (l.action_status);
  self.action_original_filename_or_url := ut.CleanSpacesAndUpper (l.action_original_filename_or_url);
  self.additional_name_addr_type := ut.CleanSpacesAndUpper (l.additional_name_addr_type);
  self.additional_orig_name         := ut.CleanSpacesAndUpper (l.additional_orig_name);
  self.additional_name_order        := ut.CleanSpacesAndUpper (l.additional_name_order);
  self.additional_orig_additional_1 := ut.CleanSpacesAndUpper (l.additional_orig_additional_1);
  self.additional_orig_additional_2 := ut.CleanSpacesAndUpper (l.additional_orig_additional_2);
  self.additional_orig_additional_3 := ut.CleanSpacesAndUpper (l.additional_orig_additional_3);
  self.additional_orig_additional_4 := ut.CleanSpacesAndUpper (l.additional_orig_additional_4);
  self.additional_orig_city         := ut.CleanSpacesAndUpper (l.additional_orig_city);
  self.additional_orig_st           := ut.CleanSpacesAndUpper (l.additional_orig_st);
  self.misc_occupation              := ut.CleanSpacesAndUpper (l.misc_occupation);
  self.misc_practice_hours          := ut.CleanSpacesAndUpper (l.misc_practice_hours);
  self.misc_practice_type           := ut.CleanSpacesAndUpper (l.misc_practice_type);
  self.misc_email                   := ut.CleanSpacesAndUpper (l.misc_email);
  self.misc_web_site                := ut.CleanSpacesAndUpper (l.misc_web_site);
  self.misc_other_id                := ut.CleanSpacesAndUpper (l.misc_other_id);
  self.misc_other_id_type           := ut.CleanSpacesAndUpper (l.misc_other_id_type);
  self.education_continuing_education := ut.CleanSpacesAndUpper (l.education_continuing_education);
  self.education_1_school_attended   := ut.CleanSpacesAndUpper (l.education_1_school_attended);
  self.education_1_dates_attended    := ut.CleanSpacesAndUpper (l.education_1_dates_attended);
  self.education_1_curriculum        := ut.CleanSpacesAndUpper (l.education_1_curriculum);
  self.education_1_degree            := ut.CleanSpacesAndUpper (l.education_1_degree);
  self.education_2_school_attended   := ut.CleanSpacesAndUpper (l.education_2_school_attended);
  self.education_2_dates_attended    := ut.CleanSpacesAndUpper (l.education_2_dates_attended);
  self.education_2_curriculum        := ut.CleanSpacesAndUpper (l.education_2_curriculum);
  self.education_2_degree            := ut.CleanSpacesAndUpper (l.education_2_degree);
  self.education_3_school_attended   := ut.CleanSpacesAndUpper (l.education_3_school_attended);
  self.education_3_dates_attended    := ut.CleanSpacesAndUpper (l.education_3_dates_attended);
  self.education_3_curriculum        := ut.CleanSpacesAndUpper (l.education_3_curriculum);
  self.education_3_degree            := ut.CleanSpacesAndUpper (l.education_3_degree);
  self.additional_licensing_specifics := ut.CleanSpacesAndUpper (l.additional_licensing_specifics);
  self.personal_pob_cd                := ut.CleanSpacesAndUpper (l.personal_pob_cd);
  self.personal_pob_desc               := ut.CleanSpacesAndUpper (l.personal_pob_desc);
  self.personal_race_cd                := ut.CleanSpacesAndUpper (l.personal_race_cd);
  self.personal_race_desc              := ut.CleanSpacesAndUpper (l.personal_race_desc);
  self.status_status_cds               := ut.CleanSpacesAndUpper (l.status_status_cds);
  self.status_renewal_desc             := ut.CleanSpacesAndUpper (l.status_renewal_desc);
  self.status_other_agency             := ut.CleanSpacesAndUpper (l.status_other_agency);
  self.prolic_key                      := ut.CleanSpacesAndUpper (l.prolic_key);
  self.date_first_seen                 := IF(_Validate.Date.fIsValid(l.date_first_seen),l.date_first_seen,'');
  self.date_last_seen                  := IF(_Validate.Date.fIsValid(l.date_last_seen), l.date_last_seen, '');
  self.orig_zip                        := l.orig_zip;
  self.dob                           := l.dob;
  self.issue_date                      := l.issue_date;		
  self.expiration_date                 := l.expiration_date;
  self.last_renewal_date               := l.last_renewal_date;
  self.action_complaint_violation_dt   := IF(_Validate.Date.fIsValid(l.action_complaint_violation_dt),l.action_complaint_violation_dt,'');
  self.action_effective_dt             := IF(_Validate.Date.fIsValid(l.action_effective_dt),l.action_effective_dt,'');
  self.action_posting_status_dt        := IF(_Validate.Date.fIsValid(l.action_posting_status_dt),l.action_posting_status_dt,'');
  self.additional_orig_zip             := l.additional_orig_zip;
  self.additional_phone                := l.additional_phone;
  self.misc_fax                        := l.misc_fax;
  self.status_effective_dt             :=IF(_Validate.Date.fIsValid(l.status_effective_dt),l.status_effective_dt,'');
	self := [];
end;

dStringToUpperCase := project( dWithKey, toupper(left));

  



Layout_prolic_in_clean tCleanfile ( dStringToUpperCase l) := transform

clean_prename                         := trim(regexreplace(' NMN |\b+|', StringLib.StringFilterout( l.orig_name,'"'),'' ));
clean_precname                        := trim(regexreplace('\b+' ,StringLib.StringFilterout( l.company_name,'"'),'' ));
//Check if the orig_name is a company name using NID cleaner
string v_is_company_NID                :=  NID.GetNameType(l.company_name);
string v_is_name_NID                   :=  NID.GetNameType(l.orig_name);

self.company_name                     := map ( l.company_name <> '' and  v_is_company_NID = 'B' => clean_precname,
                                            l.orig_name <> '' and  v_is_name_NID = 'B'  => clean_prename, 
																							 ''
																							);
self.orig_name                       := map ( l.orig_name <> '' and  v_is_name_NID <> 'B'  => clean_prename,
                                            l.company_name <> '' and v_is_company_NID <> 'B' => clean_precname,
																							 ''
																							);
self.name_order                     := if ( self.orig_name = '' , '' , l.name_order);
self.business_flag                  := if ( self.company_name <> '' , 'Y' , 'N');
self.sex                            := map ( 
	                                           l.sex[1] = 'M' => 'MALE' , 
	                                           l.sex[1] = 'F' => 'FEMALE' , '');
/*ADDRESS CLEANING**********************************************************************************************************************************/
self.orig_addr_1                   := regexreplace('\b+',StringLib.stringfilterout(l.orig_addr_1,'"'),  ' ');
self.orig_addr_2                   := regexreplace('\b+',StringLib.stringfilterout(l.orig_addr_2,'"'),  ' ');
self.orig_addr_3                   := regexreplace('\b+',StringLib.stringfilterout(l.orig_addr_3,'"'),  ' ');
self.orig_addr_4                   := regexreplace('\b+',StringLib.stringfilterout(l.orig_addr_4,'"'),  ' ');
self.orig_city                     := StringLib.stringfilterout(l.orig_city,'"');
self.orig_st                       := StringLib.stringfilterout(l.orig_st,'"');
self.orig_zip                      := StringLib.stringfilterout(l.orig_zip,'"');
/*DATE PARAMETERS***********************************************************************************************************************************/
self.dob                           := l.dob;
self.issue_date                    := l.issue_date;
self.expiration_date               := l.expiration_date;
self.last_renewal_date             := l.last_renewal_date;
self.action_complaint_violation_dt := l.action_complaint_violation_dt;
self.action_effective_dt           := l.action_effective_dt;
self.action_posting_status_dt      := l.action_posting_status_dt;
self.status_effective_dt           := l.status_effective_dt;
/*MISC**********************************************************************************************************************************/

self.additional_name_addr_type    := if ( l.additional_orig_name = '' or l.additional_orig_additional_1 = '' , '' ,l.additional_name_addr_type);  
self.additional_name_order        := if ( l.additional_orig_name <> '', l.additional_name_order , '');
self.education_1_school_attended  := StringLib.stringfilterout(l.education_1_school_attended,'"');
self.license_type                 := if ( l.license_type <> '', l.license_type , regexreplace('ALL AVAILABLE',l.profession_or_board,  ''));
self.license_number               := if ( regexfind('[~`!@#$^&*()+={}"?<>]',l.license_number) = false, trim(l.license_number), '');
self.misc_other_id_type           := if ( l.misc_other_id <> '', l.misc_other_id_type , '');
self.orig_license_number          := if ( l.orig_license_number = '' , trim(l.license_number), l.orig_license_number);
self.phone                        := if ( StringLib.stringfilterout(l.phone,'.') <> '' , (string) intformat((integer)trim(StringLib.stringfilterout(l.phone,'.')),10,0) , '');
self.profession_or_board          := if ( l.vendor = 'FL' , l.license_type , l.profession_or_board );
self.status                       := if ( l.expiration_date < l.issue_date , ' ', l.status);
self.vendor                       := l.vendor;
self                              := l;
self                              := [];
	end;

dprepClean := project( dStringToUpperCase, tCleanfile(left)) : PERSIST( '~thor_data400::persist::prolic_prepclean_'+state);
//////////////////////////////////////////////////////////////////////////////////////
	// -- Standardizes name using the NID macro
	//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
	
dWithCleanName := Standardize_Name.prolic ( dprepClean ).clname;

////////////////////////////////////////////////////////////////////////////////////////
	// -- Standardizes addresses using the AID macro
	//////////////////////////////////////////////////////////////////////////////////////
	
dWithCleanAddr := 	Standardize_Addr.prolic (dWithCleanName).dbase : PERSIST( '~thor_data400::persist::prolic_clean_'+state); 
	
	

Prof_License.Layout_proLic_in tcleanfill ( dWithCleanAddr L) := transform

self.prim_range 					    := L.clean_address[1..10]; 
	self.predir 						      := L.clean_address[11..12];					   
	self.prim_name 						    := L.clean_address[13..40];
	self.suffix 					    := L.clean_address[41..44];
	self.postdir 						      := L.clean_address[45..46];
	self.unit_desig 					    := L.clean_address[47..56];
	self.sec_range 						    := L.clean_address[57..64];
	self.p_city_name 					    := L.clean_address[65..89];
	self.v_city_name 					    := L.clean_address[90..114];
	self.st 						          := L.clean_address[115..116];
	self.zip 						          := L.clean_address[117..121];
	self.zip4 						          := L.clean_address[122..125];
	self.cart 						        := L.clean_address[126..129];
	self.cr_sort_sz 					    := L.clean_address[130];
	self.lot 						          := L.clean_address[131..134];
	self.lot_order 						    := L.clean_address[135];
	self.dpbc 						        := L.clean_address[136..137];
	self.chk_digit 						    := L.clean_address[138];
	self.record_type 						    := L.clean_address[139..140];
		self.ace_fips_st                  := L.clean_address[141..142];
	self.county					            := L.clean_address[143..145];
	self.geo_lat 						      := L.clean_address[146..155];
	self.geo_long 						    := L.clean_address[156..166];
	self.msa 						          := L.clean_address[167..170];
	self.geo_blk 						      := L.clean_address[171..177];
	self.geo_match 						    := L.clean_address[178];
	self.err_stat 						    := L.clean_address[179..182];
self.title                     :=  L.clean_name.title      ;  
self.fname                      :=   L.clean_name.fname     ;   
self.mname                      :=  L.clean_name.mname     ;   
self.lname                      :=  L.clean_name.lname     ;   
self.name_suffix                 :=  L.clean_name.name_suffix     ;
self.pl_score_in                 :=  L.clean_name.name_score     ;  
  
self := l;

end;

dWithCleanfields := project( dWithCleanAddr, tcleanfill(left));

string prev_fname := map ( 
                      state in ['wy','in'] => 'thor_data400::in::prolic_'+state+'_new',
											'~thor_data400::in::prolic_'+state+'_old'
											);
											
prev_ds := dataset(prev_fname,Prof_License.Layout_proLic_in,flat);

//concatenate update and previous full

concat_all := sort( distribute( dWithCleanfields + prev_ds , hash( prolic_key, profession_or_board, license_type, status, license_number, company_name, phone, issue_date, expiration_date, license_obtained_by, source_st, fname, mname, lname, suffix, prim_range, predir, prim_name, sec_range, zip )),
                                                                          prolic_key, profession_or_board, license_type, status, license_number, company_name, phone, issue_date, expiration_date, license_obtained_by, source_st, fname, mname, lname, suffix, prim_range, predir, prim_name, sec_range, zip,-date_last_seen,local)   ;

//Rollup the data

Prof_License.Layout_proLic_in trollup ( concat_all l ,concat_all r) := transform

 self.date_first_seen := (string8) Min((unsigned)l.date_first_seen, (unsigned)r.date_first_seen);
 self.date_last_seen := (string8) Max((unsigned)l.date_last_seen, (unsigned)r.date_last_seen);
 self := l;
 end;
 
 dUnique := Rollup ( concat_all,
                        LEFT.prolic_key = RIGHT.prolic_key and
												LEFT.profession_or_board = RIGHT.profession_or_board and
												LEFT.license_type = RIGHT.license_type and
												LEFT.status = RIGHT.status and
												LEFT.license_number = RIGHT.license_number and
												LEFT.company_name = RIGHT.company_name and
												LEFT.phone =RIGHT.phone and
												LEFT.issue_date = RIGHT.issue_date and
												LEFT.expiration_date = RIGHT.expiration_date and
												LEFT.license_obtained_by = RIGHT.license_obtained_by and
												LEFT.source_st = RIGHT.source_st and
												LEFT.fname = RIGHT.fname and
												LEFT.mname = RIGHT.mname and 
												LEFT.lname = RIGHT.lname and
												LEFT.suffix = RIGHT.suffix and
												LEFT.prim_range = RIGHT.prim_range and
												LEFT.predir = RIGHT.predir and
												LEFT.prim_name = RIGHT.prim_name and
												LEFT.sec_range = RIGHT.sec_range and
												LEFT.zip = RIGHT.zip, trollup(left,right),local);
												
 Prof_License_preprocess.IsValidLayout ( 	dUnique ).out_all  : PERSIST( '~thor_data400::persist::prolic_validate_'+state);										

												
export cleanout := sort( dUnique , profession_or_board, date_first_seen, date_last_seen, license_number, company_name, orig_name,local );





end;

 