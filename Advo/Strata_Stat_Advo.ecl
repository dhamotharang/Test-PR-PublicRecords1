import STRATA;

export Strata_Stat_Advo(

	 string															pversion
	,dataset(Layouts.Layout_Common_Out) padvo_base	= Files().Base.built

) :=
function

rPopulationStats_advo_base
 :=
  record
    CountGroup									 := count(group);
	padvo_base.state_code;
	Active_flag_CountTrue		                 := sum(group,if(padvo_base.Active_flag = 'Y',1,0));
	date_first_seen_CountNonBlank				 := sum(group,if(padvo_base.date_first_seen<>'',1,0));
	date_last_seen_CountNonBlank				 := sum(group,if(padvo_base.date_last_seen<>'',1,0));
	date_vendor_first_reported_CountNonBlank 	 := sum(group,if(padvo_base.date_vendor_first_reported<>'',1,0));
	date_vendor_last_reported_CountNonBlank		 := sum(group,if(padvo_base.date_vendor_last_reported<>'',1,0));
	prim_range_CountNonBlank				 	 := sum(group,if(padvo_base.prim_range<>'',1,0));
	predir_CountNonBlank						 := sum(group,if(padvo_base.predir<>'',1,0));
	prim_name_CountNonBlank						 := sum(group,if(padvo_base.prim_name<>'',1,0));
	addr_suffix_CountNonBlank					 := sum(group,if(padvo_base.addr_suffix<>'',1,0));
	postdir_CountNonBlank						 := sum(group,if(padvo_base.postdir<>'',1,0));
	unit_desig_CountNonBlank					 := sum(group,if(padvo_base.unit_desig<>'',1,0));
	sec_range_CountNonBlank						 := sum(group,if(padvo_base.sec_range<>'',1,0));
	p_city_name_CountNonBlank					 := sum(group,if(padvo_base.p_city_name<>'',1,0));
	v_city_name_CountNonBlank					 := sum(group,if(padvo_base.v_city_name<>'',1,0));
	st_CountNonBlank							 := sum(group,if(padvo_base.st<>'',1,0));
	zip_CountNonBlank							 := sum(group,if(padvo_base.zip<>'',1,0));
	zip4_CountNonBlank							 := sum(group,if(padvo_base.zip4<>'',1,0));
	cart_CountNonBlank							 := sum(group,if(padvo_base.cart<>'',1,0));
	cr_sort_sz_CountNonBlank					 := sum(group,if(padvo_base.cr_sort_sz<>'',1,0));
	lot_CountNonBlank							 := sum(group,if(padvo_base.lot<>'',1,0));
	lot_order_CountNonBlank						 := sum(group,if(padvo_base.lot_order<>'',1,0));
	dbpc_CountNonBlank							 := sum(group,if(padvo_base.dbpc<>'',1,0));
	chk_digit_CountNonBlank						 := sum(group,if(padvo_base.chk_digit<>'',1,0));
	rec_type_CountNonBlank						 := sum(group,if(padvo_base.rec_type<>'',1,0));
	fips_county									 := sum(group,if(padvo_base.fips_county<>'',1,0));
	county_CountNonBlank						 := sum(group,if(padvo_base.county<>'',1,0));
	geo_lat_CountNonBlank						 := sum(group,if(padvo_base.geo_lat<>'',1,0));
	geo_long_CountNonBlank						 := sum(group,if(padvo_base.geo_long<>'',1,0));
	msa_CountNonBlank							 := sum(group,if(padvo_base.msa<>'',1,0));
	geo_blk_CountNonBlank						 := sum(group,if(padvo_base.geo_blk<>'',1,0));
	geo_match_CountNonBlank						 := sum(group,if(padvo_base.geo_match<>'',1,0));
	err_stat_CountNonBlank					     := sum(group,if(padvo_base.err_stat<>'',1,0));
	Route_Num_CountNonBlank					     := sum(group,if(padvo_base.Route_Num<>'',1,0));
	ZIP_4_CountNonBlank						     := sum(group,if(padvo_base.ZIP_4  <>'',1,0)); 
	WALK_Sequence_CountNonBlank					 := sum(group,if(padvo_base.WALK_Sequence<>'',1,0));
	Address_Vacancy_Indicator_CountNonBlank		 := sum(group,if(padvo_base.Address_Vacancy_Indicator<>'',1,0));
	Throw_Back_Indicator_CountNonBlank			 := sum(group,if(padvo_base.Throw_Back_Indicator<>'',1,0));
	Seasonal_Delivery_Indicator_CountNonBlank	 := sum(group,if(padvo_base.Seasonal_Delivery_Indicator<>'',1,0));
	Seasonal_Start_Suppression_Date_CountNonBlank:= sum(group,if(padvo_base.Seasonal_Start_Suppression_Date<>'',1,0));
	Seasonal_End_Suppression_Date_CountNonBlank	 := sum(group,if(padvo_base.Seasonal_End_Suppression_Date<>'',1,0));
	DND_Indicator_CountNonBlank					 := sum(group,if(padvo_base.DND_Indicator<>'',1,0));
	College_Indicator_CountNonBlank				 := sum(group,if(padvo_base.College_Indicator<>'',1,0));
	College_Start_Suppression_Date_CountNonBlank := sum(group,if(padvo_base.College_Start_Suppression_Date<>'',1,0));
	College_End_Suppression_Date_CountNonBlank	 := sum(group,if(padvo_base.College_End_Suppression_Date<>'',1,0));
	Address_Style_Flag_CountNonBlank			 := sum(group,if(padvo_base.Address_Style_Flag<>'',1,0));
	Simplify_Address_Count_CountNonBlank		 := sum(group,if(padvo_base.Simplify_Address_Count<>'',1,0));
	Drop_Indicator_CountNonBlank				 := sum(group,if(padvo_base.Drop_Indicator<>'',1,0));
	Residential_or_Business_Ind_CountNonBlank	 := sum(group,if(padvo_base.Residential_or_Business_Ind<>'',1,0));
	DPBC_Digit_CountNonBlank					 := sum(group,if(padvo_base.DPBC_Digit<>'',1,0));
	DPBC_Check_Digit_CountNonBlank				 := sum(group,if(padvo_base.DPBC_Check_Digit<>'',1,0));
	Update_Date_CountNonBlank					 := sum(group,if(padvo_base.Update_Date<>'',1,0));
	File_Release_Date_CountNonBlank				 := sum(group,if(padvo_base.File_Release_Date<>'',1,0));
	Override_file_release_date_CountNonBlank	 := sum(group,if(padvo_base.Override_file_release_date<>'',1,0));
	County_Num_CountNonBlank					 := sum(group,if(padvo_base.County_Num<>'',1,0));
	County_Name_CountNonBlank					 := sum(group,if(padvo_base.County_Name<>'',1,0));
	City_Name_CountNonBlank						 := sum(group,if(padvo_base.City_Name<>'',1,0));
	State_Code_CountNonBlank					 := sum(group,if(padvo_base.State_Code<>'',1,0));
	State_Num_CountNonBlank						 := sum(group,if(padvo_base.State_Num<>'',1,0));
	Congressional_District_Number_CountNonBlank	 := sum(group,if(padvo_base.Congressional_District_Number<>'',1,0));
	OWGM_Indicator_CountNonBlank				 := sum(group,if(padvo_base.OWGM_Indicator<>'',1,0));
	Record_Type_Code_CountNonBlank				 := sum(group,if(padvo_base.Record_Type_Code<>'',1,0));
	ADVO_Key_CountNonBlank						 := sum(group,if(padvo_base.ADVO_Key<>'',1,0));
	Address_Type_CountNonBlank					 := sum(group,if(padvo_base.Address_Type<>'',1,0));
	Mixed_Address_Usage_CountNonBlank			 := sum(group,if(padvo_base.Mixed_Address_Usage<>'',1,0));
  end;


dPopulationStats_advo_base := table(padvo_base
							  	    ,rPopulationStats_advo_base
									,state_code
									,few);
									
Srt_dPopulationStats_advo_base := sort(dPopulationStats_advo_base,state_code);

STRATA.createXMLStats(Srt_dPopulationStats_advo_base
					 ,'DL'
					 ,'advo'
					 ,pVersion
					 ,'Sudhir.Kasavajjala@lexisnexisrisk.com'
					 ,zadvo_base);

return zadvo_base;

end;