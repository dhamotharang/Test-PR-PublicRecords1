import STRATA;
pbase:=Files.File_Base;
pVersion:=Version;

rPopulationStats_ExperianWP_base
 :=
  record
    CountGroup									 := count(group);
	date_first_seen_CountNonBlank				 := sum(group,if(pbase.date_first_seen<>'',1,0));
	date_last_seen_CountNonBlank				 := sum(group,if(pbase.date_last_seen<>'',1,0));
	date_vendor_first_reported_CountNonBlank 	 := sum(group,if(pbase.date_vendor_first_reported<>'',1,0));
	date_vendor_last_reported_CountNonBlank		 := sum(group,if(pbase.date_vendor_last_reported<>'',1,0));
	fname_CountNonBlank							 := sum(group,if(pbase.fname<>'',1,0));
	mname_CountNonBlank							 := sum(group,if(pbase.mname<>'',1,0));
	lname_CountNonBlank							 := sum(group,if(pbase.lname<>'',1,0));
	name_suffix_CountNonBlank					 := sum(group,if(pbase.name_suffix<>'',1,0));
	name_score_CountNonBlank					 := sum(group,if(pbase.name_score<>'',1,0));
	prim_range_CountNonBlank				 	 := sum(group,if(pbase.prim_range<>'',1,0));
	predir_CountNonBlank						 := sum(group,if(pbase.predir<>'',1,0));
	prim_name_CountNonBlank						 := sum(group,if(pbase.prim_name<>'',1,0));
	addr_suffix_CountNonBlank					 := sum(group,if(pbase.addr_suffix<>'',1,0));
	postdir_CountNonBlank						 := sum(group,if(pbase.postdir<>'',1,0));
	unit_desig_CountNonBlank					 := sum(group,if(pbase.unit_desig<>'',1,0));
	sec_range_CountNonBlank						 := sum(group,if(pbase.sec_range<>'',1,0));
	p_city_name_CountNonBlank					 := sum(group,if(pbase.p_city_name<>'',1,0));
	v_city_name_CountNonBlank					 := sum(group,if(pbase.v_city_name<>'',1,0));
	st_CountNonBlank							 := sum(group,if(pbase.st<>'',1,0));
	zip_CountNonBlank							 := sum(group,if(pbase.zip<>'',1,0));
	zip4_CountNonBlank							 := sum(group,if(pbase.zip4<>'',1,0));
	cart_CountNonBlank							 := sum(group,if(pbase.cart<>'',1,0));
	cr_sort_sz_CountNonBlank					 := sum(group,if(pbase.cr_sort_sz<>'',1,0));
	lot_CountNonBlank							 := sum(group,if(pbase.lot<>'',1,0));
	lot_order_CountNonBlank						 := sum(group,if(pbase.lot_order<>'',1,0));
	dbpc_CountNonBlank							 := sum(group,if(pbase.dbpc<>'',1,0));
	chk_digit_CountNonBlank						 := sum(group,if(pbase.chk_digit<>'',1,0));
	rec_type_CountNonBlank						 := sum(group,if(pbase.rec_type<>'',1,0));
	county_CountNonBlank						 := sum(group,if(pbase.county<>'',1,0));
	geo_lat_CountNonBlank						 := sum(group,if(pbase.geo_lat<>'',1,0));
	geo_long_CountNonBlank						 := sum(group,if(pbase.geo_long<>'',1,0));
	msa_CountNonBlank							 := sum(group,if(pbase.msa<>'',1,0));
	geo_blk_CountNonBlank						 := sum(group,if(pbase.geo_blk<>'',1,0));
	geo_match_CountNonBlank						 := sum(group,if(pbase.geo_match<>'',1,0));
	err_stat_CountNonBlank					     := sum(group,if(pbase.err_stat<>'',1,0));
	
	State_Code_CountNonBlank					 := sum(group,if(pbase.State_Code<>'',1,0));
	Record_Type_CountNonBlank					 := sum(group,if(pbase.Record_Type<>'',1,0));
	Batch_Creation_Date_CountNonBlank			 := sum(group,if(pbase.Batch_Creation_Date<>'',1,0));
	Batch_Creation_Time_CountNonBlank			 := sum(group,if(pbase.Batch_Creation_Time<>'',1,0));
	House_CountNonBlank							 := sum(group,if(pbase.House<>'',1,0));
	Street_Direction_Prefix_CountNonBlank		 := sum(group,if(pbase.Street_Direction_Prefix<>'',1,0));
	Street_CountNonBlank						 := sum(group,if(pbase.Street<>'',1,0));
	Street_Suffix_CountNonBlank					 := sum(group,if(pbase.Street_Suffix<>'',1,0));
	Street_Direction_Post_CountNonBlank			 := sum(group,if(pbase.Street_Direction_Post<>'',1,0));
	Zip_Code_CountNonBlank						 := sum(group,if(pbase.Zip_Code<>'',1,0));
	PO_Box_CountNonBlank						 := sum(group,if(pbase.PO_Box<>'',1,0));
	Unit_Designator_CountNonBlank				 := sum(group,if(pbase.Unit_Designator<>'',1,0));
	Uni_CountNonBlankt							 := sum(group,if(pbase.Unit<>'',1,0));
	City_Standardized_CountNonBlank				 := sum(group,if(pbase.City_Standardized<>'',1,0));
	City_Alternate_Name_CountNonBlank			 := sum(group,if(pbase.City_Alternate_Name<>'',1,0));
	Zip_4_CountNonBlank 						 := sum(group,if(pbase.Zip_4<>'',1,0));
	Phone_Number_CountNonBlank				     := sum(group,if(pbase.Phone_Number<>'',1,0));
	Phone_Area_Code_CountNonBlank				 := sum(group,if(pbase.Phone_Area_Code<>'',1,0));
	Phone_Listing_CountNonBlank					 := sum(group,if(pbase.Phone_Listing<>'',1,0));
	Verified_Date_CountNonBlank					 := sum(group,if(pbase.Verified_Date<>'',1,0));
	Date_of_Knowledge_CountNonBlank				 := sum(group,if(pbase.Date_of_Knowledge<>'',1,0));
	Surname_CountNonBlank					   	 := sum(group,if(pbase.Surname<>'',1,0));
	Primary_Occupant_Type_CountNonBlank			 := sum(group,if(pbase.Primary_Occupant_Type<>'',1,0));
	Primary_Occupant_First_Name_CountNonBlank	 := sum(group,if(pbase.Primary_Occupant_First_Name<>'',1,0));
	Primary_Occupant_Middle_Initial_CountNonBlank:= sum(group,if(pbase.Primary_Occupant_Middle_Initial<>'',1,0));
	Primary_Occupant_Title_CountNonBlank		 := sum(group,if(pbase.Primary_Occupant_Title<>'',1,0));
	Primary_Occupant_Date_of_Birth_CountNonBlank := sum(group,if(pbase.Primary_Occupant_Date_of_Birth<>'',1,0));
	Primary_Occupant_Sex_CountNonBlank			 := sum(group,if(pbase.Primary_Occupant_Sex<>'',1,0));
	Secondary_Occupant_Type_CountNonBlank		 := sum(group,if(pbase.Secondary_Occupant_Type<>'',1,0));
	Secondary_Occupant_First_Name_CountNonBlank	 := sum(group,if(pbase.Secondary_Occupant_First_Name<>'',1,0));
	Secondary_Occupant_Middle_Initial_CountNonBlank	:= sum(group,if(pbase.Secondary_Occupant_Middle_Initial<>'',1,0));
	Secondary_Occupant_Title_CountNonBlank		 := sum(group,if(pbase.Secondary_Occupant_Title<>'',1,0));
	Secondary_Occupant_Date_of_Birth_CountNonBlank:= sum(group,if(pbase.Secondary_Occupant_Date_of_Birth<>'',1,0));
	Secondary_Occupant_Sex_CountNonBlank		 := sum(group,if(pbase.Secondary_Occupant_Sex<>'',1,0));
	Third_Occupant_Type_CountNonBlank			 := sum(group,if(pbase.Third_Occupant_Type<>'',1,0));
	Third_Occupant_First_Name_CountNonBlank		 := sum(group,if(pbase.Third_Occupant_First_Name<>'',1,0));
	Third_Occupant_Middle_Initial_CountNonBlank	 := sum(group,if(pbase.Third_Occupant_Middle_Initial<>'',1,0));
	Third_Occupant_Title_CountNonBlank			 := sum(group,if(pbase.Third_Occupant_Title<>'',1,0));
	Third_Occupant_Date_of_Birth_CountNonBlank	 := sum(group,if(pbase.Third_Occupant_Date_of_Birth<>'',1,0));
	Third_Occupant_Sex_CountNonBlank			 := sum(group,if(pbase.Third_Occupant_Sex<>'',1,0));
	Fourth_Occupant_Type_CountNonBlank			 := sum(group,if(pbase.Fourth_Occupant_Type<>'',1,0));
	Fourth_Occupant_First_Name_CountNonBlank	 := sum(group,if(pbase.Fourth_Occupant_First_Name<>'',1,0));
	Fourth_Occupant_Middle_Initial_CountNonBlank := sum(group,if(pbase.Fourth_Occupant_Middle_Initial<>'',1,0));
	Fourth_Occupant_Title_CountNonBlank			 := sum(group,if(pbase.Fourth_Occupant_Title<>'',1,0));
	Fourth_Occupant_Date_of_Birth_CountNonBlank	 := sum(group,if(pbase.Fourth_Occupant_Date_of_Birth<>'',1,0));
	Fourth_Occupant_Sex_CountNonBlank			 := sum(group,if(pbase.Fourth_Occupant_Sex<>'',1,0));
	Fifth_Occupant_Type_CountNonBlank			 := sum(group,if(pbase.Fifth_Occupant_Type<>'',1,0));
	Fifth_Occupant_First_Name_CountNonBlank	 	 := sum(group,if(pbase.Fifth_Occupant_First_Name<>'',1,0));
	Fifth_Occupant_Middle_Initial_CountNonBlank	 := sum(group,if(pbase.Fifth_Occupant_Middle_Initial<>'',1,0));
	Fifth_Occupant_Title_CountNonBlank			 := sum(group,if(pbase.Fifth_Occupant_Title<>'',1,0));
	Fifth_Occupant_Date_of_Birth_CountNonBlank	 := sum(group,if(pbase.err_stat<>'',1,0));
	Fifth_Occupant_Sex_CountNonBlank			 := sum(group,if(pbase.Fifth_Occupant_Sex<>'',1,0));
	AddDelete_Indicator_CountNonBlank			 := sum(group,if(pbase.AddDelete_Indicator<>'',1,0));
	MM_Reference_Sequence_Number_CountNonBlank	 := sum(group,if(pbase.MM_Reference_Sequence_Number<>'',1,0));
	DOB1_Indicator_CountNonBlank				 := sum(group,if(pbase.DOB1_Indicator<>'',1,0));
	DOB2_Indicator_CountNonBlank				 := sum(group,if(pbase.DOB2_Indicator<>'',1,0));
	DOB3_Indicator_CountNonBlank				 := sum(group,if(pbase.DOB3_Indicator<>'',1,0));
	DOB4_Indicator_CountNonBlank				 := sum(group,if(pbase.DOB4_Indicator<>'',1,0));
	DOB5_Indicator_CountNonBlank				 := sum(group,if(pbase.DOB5_Indicator<>'',1,0));
	
	Norm_Occupant_Type_CountNonBlank			 := sum(group,if(pbase.Norm_Occupant_Type<>'',1,0));
	Norm_Occupant_Name_CountNonBlank			 := sum(group,if(pbase.Norm_Occupant_Name<>'',1,0));
	Norm_Occupant_Title_CountNonBlank			 := sum(group,if(pbase.Norm_Occupant_Title<>'',1,0));
	Norm_Occupant_Date_of_Birth_CountNonBlank	 := sum(group,if(pbase.Norm_Occupant_Date_of_Birth<>'',1,0));
	Norm_Occupant_Sex_CountNonBlank				 := sum(group,if(pbase.Norm_Occupant_Sex<>'',1,0));
	Norm_DOB_Indicator_CountNonBlank			 := sum(group,if(pbase.Norm_DOB_Indicator<>'',1,0));
	clean_DOB_CountNonBlank						 := sum(group,if(pbase.clean_DOB<>'',1,0));
	clean_phone_CountNonBlank					 := sum(group,if(pbase.clean_phone<>'',1,0));
 end;


dPopulationStats_ExperianWP := table(pbase
							  	    ,rPopulationStats_ExperianWP_base
									,st
									,few);
STRATA.createXMLStats(dPopulationStats_ExperianWP
					 ,'PH'
					 ,'ExperianWP'
					 ,pVersion
					 ,'aherzberg@seisint.com'
					 ,zExperianWP_base);

export Strata_Stat_ExperianWP := zExperianWP_base;