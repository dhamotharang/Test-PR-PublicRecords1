import CrimSrch;

string8 fMaxDate2(string8 pDate1, string8 pDate2)
 := if(if((integer4)pDate1=0,'00000000',pDate1) > if((integer4)pDate2=0,'00000000',pDate2),
		  if((integer4)pDate1=0,'',pDate1),
		  if((integer4)pDate2=0,'',pDate2));

string8 fMaxDate(string8 pDate1, string8 pDate2, string8 pDate3='', string8 pDate4='', string8 pDate5='', string8 pDate6='')
 := fMaxDate2(pDate1,fMaxDate2(pDate2,fMaxDate2(pDate3,fMaxDate2(pDate4,fMaxDate2(pDate5,pDate6)))));

	Layout_Moxie_Offender_temp tSexPredSearchandSexPred2toOffender(Layout_Sex_Pred_Search_DID pSexPredSearch, Layout_Sex_Pred_2 pSexPred2):= transform
		self.date_first_reported	:= pSexPredSearch.dt_last_reported;
		self.date_last_reported		:= pSexPredSearch.dt_last_reported;
		self.offender_key			:= pSexPredSearch.seisint_primary_key;
		self.vendor					:= pSexPredSearch.vendor_code;
		self.state_of_origin		:= pSexPredSearch.state_of_origin;
		self.data_type				:= '4';
		self.source_file			:= pSexPredSearch.source_file;
		self.off_name_type			:= pSexPredSearch.name_type;
		self.off_name				:= pSexPredSearch.name_orig;
		self.orig_lname				:= '';
		self.orig_fname				:= '';
		self.orig_mname				:= '';
		self.orig_name_suffix		:= '';
		self.place_of_birth			:= '';
		self.dob					:= pSexPredSearch.date_of_birth;
		self.dob_alias				:= pSexPredSearch.dob_aka;
		self.orig_ssn				:= pSexPredSearch.orig_ssn;
		self.offender_address_1		:= pSexPredSearch.registration_address_1;
		self.offender_address_2		:= pSexPredSearch.registration_address_2;
		self.offender_address_3		:= pSexPredSearch.registration_address_3;
		self.offender_address_4		:= pSexPredSearch.registration_address_4;
		self.offender_address_5		:= pSexPredSearch.registration_address_5;
		self.race_desc				:= pSexPred2.race;
		self.sex					:= pSexPred2.sex;
		self.hair_color_desc		:= pSexPred2.hair_color;
		self.eye_color_desc			:= pSexPred2.eye_color;
		self.height					:= pSexPred2.height;
		self.weight					:= pSexPred2.weight;
		self.ethnicity				:= pSexPred2.ethnicity;
		self.age					:= pSexPred2.age;
		self.build_type				:= pSexPred2.build_type;
		self.scars_marks_tattoos	:= pSexPred2.scars_marks_tattoos;
		self.skin_color_desc		:= pSexPred2.skin_tone;
		self.fcra_conviction_flag	:= 'Y';
		self.fcra_traffic_flag		:= 'N';
		self.fcra_date				:= pSexPredSearch.dt_last_reported;
		self.fcra_date_type			:= 'R';
		self.prim_range				:= pSexPredSearch.prim_range;
		self.predir					:= pSexPredSearch.predir;
		self.prim_name				:= pSexPredSearch.prim_name;
		self.addr_suffix			:= pSexPredSearch.suffix;
		self.postdir				:= pSexPredSearch.postdir;
		self.unit_desig				:= pSexPredSearch.unit_desig;
		self.sec_range				:= pSexPredSearch.sec_range;
		self.p_city_name			:= pSexPredSearch.p_city_name;
		self.v_city_name			:= pSexPredSearch.v_city_name;
		self.state					:= pSexPredSearch.st;
		self.zip5					:= pSexPredSearch.zip;
		self.zip4					:= pSexPredSearch.zip4;
		self.cart					:= pSexPredSearch.cart;
		self.cr_sort_sz				:= pSexPredSearch.cr_sort_sz;
		self.lot					:= pSexPredSearch.lot;
		self.lot_order				:= pSexPredSearch.lot_order;
		self.dpbc					:= pSexPredSearch.dpbc;
		self.chk_digit				:= pSexPredSearch.chk_digit;
		self.rec_type				:= pSexPredSearch.rec_type;
		self.ace_fips_st			:= pSexPredSearch.fips_st;
		self.ace_fips_county		:= pSexPredSearch.fips_county;
		self.geo_lat				:= pSexPredSearch.geo_lat;
		self.geo_long				:= pSexPredSearch.geo_long;
		self.msa					:= pSexPredSearch.msa;
		self.geo_blk				:= pSexPredSearch.geo_blk;
		self.geo_match				:= pSexPredSearch.geo_match;
		self.err_stat				:= pSexPredSearch.err_stat;
		self.title					:= pSexPredSearch.title;
		self.fname					:= pSexPredSearch.fname;
		self.mname					:= pSexPredSearch.mname;
		self.lname					:= pSexPredSearch.lname;
		self.name_suffix			:= pSexPredSearch.name_suffix;
		self.cleaning_score			:= pSexPredSearch.cleaning_score;
		self.did					:= pSexPredSearch.did;
		self.ssn					:= pSexPredSearch.best_ssn;
		self.offender_id_num_1		:= pSexPred2.sor_number;
		self.offender_id_num_type_1	:= if(pSexPred2.sor_number<>'','SOR Number','');
		self.offender_id_num_2		:= if(pSexPred2.ncic_number<>'',pSexPred2.ncic_number,
												  if(pSexPred2.fbi_number<>'',pSexPred2.fbi_number,
													 if(pSexPred2.st_id_number<>'',pSexPred2.st_id_number,
														if(pSexPred2.doc_number<>'',pSexPred2.doc_number,''
														  )
													   )
													)
												 );
		self.offender_id_num_type_2	:= if(pSexPred2.ncic_number<>'','NCIC No',
												  if(pSexPred2.fbi_number<>'','FBI No',
													 if(pSexPred2.st_id_number<>'','State ID',
														if(pSexPred2.doc_number<>'','DOC No',''
														  )
													   )
													)
												 );
		self.sor_date_1				:= pSexPred2.reg_date_1;
		self.sor_date_type_1		:= pSexPred2.reg_date_1_type;
		self.sor_date_2				:= pSexPred2.reg_date_2;
		self.sor_date_type_2		:= pSexPred2.reg_date_2_type;
		self.sor_date_3				:= pSexPred2.reg_date_3;
		self.sor_date_type_3		:= pSexPred2.reg_date_3_type;
		self.sor_status				:= pSexPred2.offender_status;
		self.offender_status		:= pSexPred2.offender_status;
		self.sor_risk_level_code	:= pSexPred2.risk_level_code;
		self.sor_risk_level_desc	:= pSexPred2.risk_description;
		self.sor_registration_type	:= pSexPred2.registration_type;
		self.sor_offender_category	:= pSexPred2.offender_category;
		self.case_number			:= if(trim(pSexPred2.court_case_number_2+pSexPred2.court_case_number_3+pSexPred2.court_case_number_4+pSexPred2.court_case_number_5)='',pSexPred2.court_case_number_1,'');
		self.case_court				:= if(trim(pSexPred2.court_case_number_2+pSexPred2.court_case_number_3+pSexPred2.court_case_number_4+pSexPred2.court_case_number_5)='',pSexPred2.court_1,'');
		self.case_name				:= '';
		self.case_type				:= '';
		self.case_type_desc			:= '';
		self.case_filing_date		:= '';
	/*
		self.conviction_override_date		:= if(fMaxDate(pSexPred2.conviction_date_1,
														   pSexPred2.conviction_date_2,
														   pSexPred2.conviction_date_3,
														   pSexPred2.conviction_date_4,
														   pSexPred2.conviction_date_5
														  )<>'',
												  fMaxDate(pSexPred2.conviction_date_1,
														   pSexPred2.conviction_date_2,
														   pSexPred2.conviction_date_3,
														   pSexPred2.conviction_date_4,
														   pSexPred2.conviction_date_5
														  ),
												  pSexPredSearch.dt_last_reported
												 );
	*/
		self.conviction_override_date		:= pSexPredSearch.dt_last_reported;
		self.conviction_override_date_type	:= 'L';
		self.offense_score					:= 'S';
		self.image_link					    := pSexPred2.image_link;

		//mapping for temporary fields added to facilitate LIfe EIR project
		self.process_date 					:= self.date_last_reported;
		self.file_date						:= pSexPred2.reg_date_1;
		self.orig_state						:= self.state_of_origin;
		self.ssn_appended					:= pSexPredSearch.best_ssn;
		self.id_num							:= self.offender_id_num_1;
		self.pty_nm							:= self.off_name;
		self.pty_typ						:= self.off_name_type;
		self.dle_num						:= pSexPred2.ncic_number;
		self.fbi_num						:= pSexPred2.fbi_number;
		self.doc_num						:= pSexPred2.doc_number;
		
		self.street_address_1				:= pSexPredSearch.registration_address_1;
		self.street_address_2				:= pSexPredSearch.registration_address_2;
		self.street_address_3				:= pSexPredSearch.registration_address_3;
		self.street_address_4				:= pSexPredSearch.registration_address_4;
		self.street_address_5				:= pSexPredSearch.registration_address_5;
		self.party_status_desc				:= self.offender_status;

		//field added for CROSS
		//self.src_upload_date				:= pSexPredSearch.src_upload_date;
		//self.pkey							:= pSexPredSearch.pkey;
		self								:= [];
	end;

dSexPredSearchDist 	:= distribute(File_Sex_Pred_Search_DID, hash(Seisint_Primary_Key));
dSexPred2Dist		:= distribute(File_Sex_Pred_2, hash(Seisint_Primary_Key));
dSexPredSearchSort	:= sort(dSexPredSearchDist, Seisint_Primary_Key,local);
dSexPred2Sort		:= sort(dSexPred2Dist, Seisint_Primary_Key,local);

dSexPredJoined		:= join(dSexPredSearchSort,dSexPred2Sort,
							left.Seisint_Primary_Key = right.Seisint_Primary_Key,
							tSexPredSearchandSexPred2toOffender(left,right), local);

#if(CrimSrch.Switch_ShouldUsePersists = CrimSrch.Switch_YesValue)
	export Sex_Pred_Search_DID_as_CrimSrch_Offender := dSexPredJoined : persist('persist::Sex_Pred_Search_DID_as_CrimSrch_Offender');
#else
	export Sex_Pred_Search_DID_as_CrimSrch_Offender := dSexPredJoined;
#end