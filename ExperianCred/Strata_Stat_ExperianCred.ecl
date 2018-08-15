import STRATA;
pExperian_base:=Files.Base_File_Out;

rPopulationStats_Experian_base
 :=
  record
  string3  grouping                                   := 'ALL';
	CountGroup									:= count(group);
	did_CountNonBlank							:= sum(group,if(pExperian_base.did<>0,1,0));
	did_score_CountNonBlank						:= sum(group,if(pExperian_base.DID_Score_field<>0,1,0));
	date_first_seen_CountNonBlank				:= sum(group,if(pExperian_base.date_first_seen<>0,1,0));
	date_last_seen_CountNonBlank				:= sum(group,if(pExperian_base.date_last_seen<>0,1,0));
	date_vendor_first_reported_CountNonBlank	:= sum(group,if(pExperian_base.date_vendor_first_reported<>0,1,0));
	date_vendor_last_reported_CountNonBlank		:= sum(group,if(pExperian_base.date_vendor_last_reported<>0,1,0));
	delete_flag_CountNonBlank			    	:= sum(group,if(pExperian_base.delete_flag<>0,1,0));
	delete_file_date_CountNonBlank				:= sum(group,if(pExperian_base.delete_file_date<>0,1,0));
	current_rec_flag_CountNonBlank				:= sum(group,if(pExperian_base.current_rec_flag<>0,1,0));
	//---Original data
	Encrypted_Experian_PIN_CountNonBlank		:= sum(group,if(pExperian_base.Encrypted_Experian_PIN<>'',1,0));
	Orig_Social_Security_Number_CountNonBlank	:= sum(group,if(pExperian_base.Social_Security_Number<>'',1,0));
	Orig_Date_of_Birth_CountNonBlank			:= sum(group,if(pExperian_base.Date_of_Birth<>'',1,0));
	Orig_Telephone_CountNonBlank				:= sum(group,if(pExperian_base.Telephone<>'',1,0));
	Orig_Gender_CountNonBlank					:= sum(group,if(pExperian_base.Gender<>'',1,0));
	Orig_Additional_Name_Count_CountNonBlank	:= sum(group,if((unsigned)pExperian_base.Additional_Name_Count > 0,1,0));
	Orig_Previous_Address_Count_CountNonBlank	:= sum(group,if((unsigned)pExperian_base.Previous_Address_Count > 0,1,0));
	NameType_CountNonBlank						:= sum(group,if(pExperian_base.NameType<>'',1,0));
	Orig_Consumer_Create_Date_CountNonBlank		:= sum(group,if(pExperian_base.Orig_Consumer_Create_Date<>'',1,0));
	Orig_fname_CountNonBlank					:= sum(group,if(pExperian_base.Orig_fname<>'',1,0));
	Orig_mname_CountNonBlank					:= sum(group,if(pExperian_base.Orig_mname<>'',1,0));	
	Orig_lname_CountNonBlank					:= sum(group,if(pExperian_base.Orig_lname<>'',1,0));		
	Orig_suffix_CountNonBlank					:= sum(group,if(pExperian_base.Orig_suffix<>'',1,0));	
	Orig_Address_create_date_CountNonBlank		:= sum(group,if(pExperian_base.Orig_Address_Create_date<>'',1,0));	
	Orig_Address_update_date_CountNonBlank		:= sum(group,if(pExperian_base.Orig_Address_Update_date<>'',1,0));	
	AddressSeq_CountNonBlank					:= sum(group,if(pExperian_base.AddressSeq > 0,1,0));
	Orig_Prim_Range_CountNonBlank				:= sum(group,if(pExperian_base.Orig_Prim_Range<>'',1,0));
	Orig_Predir_CountNonBlank					:= sum(group,if(pExperian_base.Orig_Predir<>'',1,0));
	Orig_Prim_Name_CountNonBlank				:= sum(group,if(pExperian_base.Orig_Prim_Name<>'',1,0));
	Orig_Addr_Suffix_CountNonBlank				:= sum(group,if(pExperian_base.Orig_Addr_Suffix<>'',1,0));
	Orig_Postdir_CountNonBlank					:= sum(group,if(pExperian_base.Orig_Postdir<>'',1,0));
	Orig_Unit_Desig_CountNonBlank				:= sum(group,if(pExperian_base.Orig_Unit_Desig<>'',1,0));
	Orig_Sec_Range_CountNonBlank				:= sum(group,if(pExperian_base.Orig_Sec_Range<>'',1,0));
	Orig_City_CountNonBlank						:= sum(group,if(pExperian_base.Orig_City<>'',1,0));
	Orig_State_CountNonBlank					:= sum(group,if(pExperian_base.Orig_State<>'',1,0));
	Orig_ZipCode_CountNonBlank					:= sum(group,if(pExperian_base.Orig_ZipCode<>'',1,0));
	Orig_ZipCode4_CountNonBlank					:= sum(group,if(pExperian_base.Orig_ZipCode4<>'',1,0));

	//-------clean name data
	title_CountNonBlank							:= sum(group,if(pExperian_base.title<>'',1,0));
	fname_CountNonBlank							:= sum(group,if(pExperian_base.fname<>'',1,0));
	mname_CountNonBlank							:= sum(group,if(pExperian_base.mname<>'',1,0));
	lname_CountNonBlank							:= sum(group,if(pExperian_base.lname<>'',1,0));
	name_suffix_CountNonBlank					:= sum(group,if(pExperian_base.name_suffix<>'',1,0));
	name_score_CountNonBlank					:= sum(group,if(pExperian_base.name_score<>'',1,0));

	//-------clean address data
	prim_range_CountNonBlank					:= sum(group,if(pExperian_base.prim_range<>'',1,0));
	predir_CountNonBlank						:= sum(group,if(pExperian_base.predir<>'',1,0));
	prim_name_CountNonBlank						:= sum(group,if(pExperian_base.prim_name<>'',1,0));
	addr_suffix_CountNonBlank					:= sum(group,if(pExperian_base.addr_suffix<>'',1,0));
	postdir_CountNonBlank						:= sum(group,if(pExperian_base.postdir<>'',1,0));
	unit_desig_CountNonBlank					:= sum(group,if(pExperian_base.unit_desig<>'',1,0));
	sec_range_CountNonBlank						:= sum(group,if(pExperian_base.sec_range<>'',1,0));
	p_city_name_CountNonBlank					:= sum(group,if(pExperian_base.p_city_name<>'',1,0));
	v_city_name_CountNonBlank					:= sum(group,if(pExperian_base.v_city_name<>'',1,0));
	st_CountNonBlank							:= sum(group,if(pExperian_base.st<>'',1,0));
	zip_CountNonBlank							:= sum(group,if(pExperian_base.zip<>'',1,0));
	zip4_CountNonBlank							:= sum(group,if(pExperian_base.zip4<>'',1,0));
	cart_CountNonBlank							:= sum(group,if(pExperian_base.cart<>'',1,0));
	cr_sort_sz_CountNonBlank					:= sum(group,if(pExperian_base.cr_sort_sz<>'',1,0));
	lot_CountNonBlank							:= sum(group,if(pExperian_base.lot<>'',1,0));
	lot_order_CountNonBlank						:= sum(group,if(pExperian_base.lot_order<>'',1,0));
	dbpc_CountNonBlank							:= sum(group,if(pExperian_base.dbpc<>'',1,0));
	chk_digit_CountNonBlank						:= sum(group,if(pExperian_base.chk_digit<>'',1,0));
	rec_type_CountNonBlank						:= sum(group,if(pExperian_base.rec_type<>'',1,0));
	county_CountNonBlank						:= sum(group,if(pExperian_base.county<>'',1,0));
	geo_lat_CountNonBlank						:= sum(group,if(pExperian_base.geo_lat<>'',1,0));
	geo_long_CountNonBlank						:= sum(group,if(pExperian_base.geo_long<>'',1,0));
	msa_CountNonBlank							:= sum(group,if(pExperian_base.msa<>'',1,0));
	geo_blk_CountNonBlank						:= sum(group,if(pExperian_base.geo_blk<>'',1,0));
	geo_match_CountNonBlank						:= sum(group,if(pExperian_base.geo_match<>'',1,0));
	err_stat_CountNonBlank						:= sum(group,if(pExperian_base.err_stat<>'',1,0));
  end;

dPopulationStats_Experian_base := table(pExperian_base
							  	    ,rPopulationStats_Experian_base
									,few);

CreateXMLStats(string ver) := function 
	STRATA.createXMLStats(dPopulationStats_Experian_base
					 ,'ENv3'
					 ,'ExperianCred'
					 ,ver
					 ,'Angela.Herzberg@lexisnexis.com; Michael.Gould@lexisnexis.com;Gabriel.Marcan@lexisnexis.com'
					 ,zExperian_base);
	return zExperian_base;
END;

EXPORT Strata_Stat_ExperianCred(string ver) := CreateXMLStats(ver);