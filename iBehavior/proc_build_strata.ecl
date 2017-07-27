EXPORT proc_build_strata(STRING version) := FUNCTION

	IMPORT STRATA;
 
	Basefile:=Files.File_consumer;
	PurchaseFile := Files.File_behavior; 
 
	Layout_Strata
		:=
			RECORD
				// basefile.clean_st;
				basefile.State;
				CountGroup:=COUNT(GROUP);
				Persistent_Record_ID := SUM(GROUP,IF(basefile.persistent_record_id <> 0,1,0));
				Last_Name_cnt := SUM(GROUP, IF(basefile.Last_Name <> '', 1, 0));
				First_Name_cnt := SUM(GROUP, IF(basefile.First_Name <> '', 1, 0));
				Middle_Initial_cnt := SUM(GROUP, IF(basefile.Middle_Initial <> '', 1, 0));
				Maturity_Title_cnt := SUM(GROUP, IF(basefile.Maturity_Title <> '', 1, 0));
				Title_cnt := SUM(GROUP, IF(basefile.Title <> '', 1, 0));
				CO_Address_cnt := SUM(GROUP, IF(basefile.CO_Address <> '', 1, 0));
				Apt_No_cnt := SUM(GROUP, IF(basefile.Apt_No <> '', 1, 0));
				Address_Line1_cnt := SUM(GROUP, IF(basefile.Address_Line1 <> '', 1, 0));
				Address_Line2_cnt := SUM(GROUP, IF(basefile.Address_Line2 <> '', 1, 0));
				City_cnt := SUM(GROUP, IF(basefile.City <> '', 1, 0));
				State_cnt := SUM(GROUP, IF(basefile.State <> '', 1, 0));
				Zip_Code_cnt := SUM(GROUP, IF(basefile.Zip_Code <> '', 1, 0));
				Zip_4_cnt := SUM(GROUP, IF(basefile.Zip_4 <> '', 1, 0));
				Gender_Code_cnt := SUM(GROUP, IF(basefile.Gender_Code <> '', 1, 0));
				IB_Individual_ID_cnt := SUM(GROUP, IF(basefile.IB_Individual_ID <> '', 1, 0));
				IB_Household_ID_cnt := SUM(GROUP, IF(basefile.IB_Household_ID <> '', 1, 0));
				Email_Address_1_cnt := SUM(GROUP, IF(basefile.Email_Address_1 <> '', 1, 0));
				Email_Address_2_cnt := SUM(GROUP, IF(basefile.Email_Address_2 <> '', 1, 0));
				Email_Address_3_cnt := SUM(GROUP, IF(basefile.Email_Address_3 <> '', 1, 0));
				Primary_Phone_Number_cnt := SUM(GROUP, IF(basefile.Primary_Phone_Number <> '', 1, 0));
				Secondary_Phone_Number_cnt := SUM(GROUP, IF(basefile.Secondary_Phone_Number <> '', 1, 0)); 
				did_Cnt  := sum(group,if(basefile.did<>0,1,0));
				did_score_Cnt  := sum(group,if(basefile.did_score<>0,1,0));
				nameid_Cnt			 := sum(group,if(basefile.nameid<>0,1,0));
				name_type_Cnt			 := sum(group,if(basefile.nametype<>'',1,0));
				fullname_Cnt			 := sum(group,if(basefile.fullname<>'',1,0));
				clean_title_Cnt  := sum(group,if(basefile.title<>'',1,0));
				clean_fname_Cnt  := sum(group,if(basefile.fname<>'',1,0));
				clean_mname_Cnt  := sum(group,if(basefile.mname<>'',1,0));
				clean_lname_Cnt  := sum(group,if(basefile.lname<>'',1,0));
				clean_name_suffix_Cnt  := sum(group,if(basefile.name_suffix<>'',1,0));
				// clean_name_score_Cnt  := sum(group,if(basefile.clean_name_score<>'',1,0));
				clean_name_ind_Cnt	 := sum(group,if(basefile.name_ind<>0,1,0));
				rawaid_Cnt  := sum(group,if(basefile.rawaid<>0,1,0));
				append_prep_address_Cnt  := sum(group,if(basefile.append_prep_address<>'',1,0));
				append_prep_address_last_Cnt  := sum(group,if(basefile.append_prep_address_last<>'',1,0));
				clean_Primary_Phone_Number_Cnt  := sum(group,if(basefile.phone_1<>'',1,0));
				clean_Secondary_Phone_Number_Cnt  := sum(group,if(basefile.phone_2<>'',1,0));
				clean_prim_range_Cnt  := sum(group,if(basefile.prim_range<>'',1,0));
				clean_predir_Cnt  := sum(group,if(basefile.predir<>'',1,0));
				clean_prim_name_Cnt  := sum(group,if(basefile.prim_name<>'',1,0));
				clean_addr_suffix_Cnt  := sum(group,if(basefile.addr_suffix<>'',1,0));
				clean_postdir_Cnt  := sum(group,if(basefile.postdir<>'',1,0));
				clean_unit_desig_Cnt  := sum(group,if(basefile.unit_desig<>'',1,0));
				clean_sec_range_Cnt  := sum(group,if(basefile.sec_range<>'',1,0));
				clean_p_city_name_Cnt  := sum(group,if(basefile.p_city_name<>'',1,0));
				clean_v_city_name_Cnt  := sum(group,if(basefile.v_city_name<>'',1,0));
				clean_st_Cnt  := sum(group,if(basefile.st<>'',1,0));
				clean_zip5_Cnt  := sum(group,if(basefile.zip5<>'',1,0));
				clean_zip4_Cnt  := sum(group,if(basefile.zip4<>'',1,0));
				clean_cart_Cnt  := sum(group,if(basefile.cart<>'',1,0));
				clean_cr_sort_sz_Cnt  := sum(group,if(basefile.cr_sort_sz<>'',1,0));
				clean_lot_Cnt  := sum(group,if(basefile.lot<>'',1,0));
				clean_lot_order_Cnt  := sum(group,if(basefile.lot_order<>'',1,0));
				clean_dbpc_Cnt  := sum(group,if(basefile.dbpc<>'',1,0));
				clean_chk_digit_Cnt  := sum(group,if(basefile.chk_digit<>'',1,0));
				clean_rec_type_Cnt  := sum(group,if(basefile.rec_type<>'',1,0));
				clean_county_Cnt  := sum(group,if(basefile.county<>'',1,0));
				clean_ace_fips_st_Cnt  := sum(group,if(basefile.ace_fips_st<>'',1,0));
				clean_fips_county_Cnt  := sum(group,if(basefile.fips_county<>'',1,0));
				clean_geo_lat_Cnt  := sum(group,if(basefile.geo_lat<>'',1,0));
				clean_geo_long_Cnt  := sum(group,if(basefile.geo_long<>'',1,0));
				clean_msa_Cnt  := sum(group,if(basefile.msa<>'',1,0));
				clean_geo_blk_Cnt  := sum(group,if(basefile.geo_blk<>'',1,0));
				clean_geo_match_Cnt  := sum(group,if(basefile.geo_match<>'',1,0));
				clean_err_stat_Cnt  := sum(group,if(basefile.err_stat<>'',1,0));
				process_date_Cnt  := sum(group,if(basefile.process_date<>'',1,0));
				date_first_seen_Cnt  := sum(group,if(basefile.date_first_seen<>'',1,0));
				date_last_seen_Cnt  := sum(group,if(basefile.date_last_seen<>'',1,0));
				date_vendor_first_reported_Cnt  := sum(group,if(basefile.date_vendor_first_reported<>'',1,0));
				date_vendor_last_reported_Cnt  := sum(group,if(basefile.date_vendor_last_reported<>'',1,0));
			END;


Layout_Purchase
		:=
			RECORD
				// PurchaseFile.number_of_sources;
				// CountGroup:=COUNT(GROUP);
				Persistent_Record_ID := SUM(GROUP,IF(PurchaseFile.persistent_record_id <> 0,1,0));
				IB_Individual_ID_cnt := SUM(GROUP, IF(PurchaseFile.IB_Individual_ID <> '', 1, 0));
				IB_Household_ID_cnt := SUM(GROUP, IF(PurchaseFile.IB_Household_ID <> '', 1, 0));
				First_Order_Date_cnt := SUM(GROUP, IF(PurchaseFile.First_Order_Date <> '', 1, 0));
				Last_Order_Date_cnt := SUM(GROUP, IF(PurchaseFile.Last_Order_Date <> '', 1, 0));
				First_Online_Order_Date_cnt := SUM(GROUP, IF(PurchaseFile.First_Online_Order_Date <> '', 1, 0));
				Last_Online_Order_Date_cnt := SUM(GROUP, IF(PurchaseFile.Last_Online_Order_Date <> '', 1, 0));
				First_Offline_Order_Date_cnt := SUM(GROUP, IF(PurchaseFile.First_Offline_Order_Date <> '', 1, 0));
				Last_Offline_Order_Date_cnt := SUM(GROUP, IF(PurchaseFile.Last_Offline_Order_Date <> '', 1, 0));
				First_Retail_Order_Date_cnt := SUM(GROUP, IF(PurchaseFile.First_Retail_Order_Date <> '', 1, 0));
				Last_Retail_Order_Date_cnt := SUM(GROUP, IF(PurchaseFile.Last_Retail_Order_Date <> '', 1, 0));
				number_of_sources_cnt := SUM(GROUP, IF(PurchaseFile.number_of_sources <> '', 1, 0));
				Total_Number_of_Orders_cnt := SUM(GROUP, IF(PurchaseFile.Total_Number_of_Orders <> '', 1, 0));
				Total_Dollars_cnt := SUM(GROUP, IF(PurchaseFile.Total_Dollars <> '', 1, 0));
				Online_Orders_cnt := SUM(GROUP, IF(PurchaseFile.Online_Orders <> '', 1, 0));
				Online_Dollars_cnt := SUM(GROUP, IF(PurchaseFile.Online_Dollars <> '', 1, 0));
				Offline_Orders_cnt := SUM(GROUP, IF(PurchaseFile.Offline_Orders <> '', 1, 0));
				Offline_Dollars_cnt := SUM(GROUP, IF(PurchaseFile.Offline_Dollars <> '', 1, 0));
				Retail_Orders_cnt := SUM(GROUP, IF(PurchaseFile.Retail_Orders <> '', 1, 0));
				Retail_Dollars_cnt := SUM(GROUP, IF(PurchaseFile.Retail_Dollars <> '', 1, 0));
				Average_Days_Between_Orders_cnt := SUM(GROUP, IF(PurchaseFile.Average_Days_Between_Orders <> '', 1, 0));
				Average_Days_Between_Online_Orders_cnt := SUM(GROUP, IF(PurchaseFile.Average_Days_Between_Online_Orders <> '', 1, 0));
				Average_Days_Between_Offline_Orders_cnt := SUM(GROUP, IF(PurchaseFile.Average_Days_Between_Offline_Orders <> '', 1, 0));
				Average_Days_Between_Retail_Orders_cnt := SUM(GROUP, IF(PurchaseFile.Average_Days_Between_Retail_Orders <> '', 1, 0));
				Average_Amount_Per_Order_cnt := SUM(GROUP, IF(PurchaseFile.Average_Amount_Per_Order <> '', 1, 0));
				Online_Average_Amount_Per_Order_cnt := SUM(GROUP, IF(PurchaseFile.Online_Average_Amount_Per_Order <> '', 1, 0));
				Offline_Average_Amount_Per_Order_cnt := SUM(GROUP, IF(PurchaseFile.Offline_Average_Amount_Per_Order <> '', 1, 0));
				Retail_Average_Amount_Per_Order_cnt := SUM(GROUP, IF(PurchaseFile.Retail_Average_Amount_Per_Order <> '', 1, 0));
				Online_Orders_Under_50_Range_cnt := SUM(GROUP, IF(PurchaseFile.Online_Orders_Under_50_Range <> '', 1, 0));
				Online_Orders_50_to_99_dot_99_Range_cnt := SUM(GROUP, IF(PurchaseFile.Online_Orders_50_to_99_dot_99_Range <> '', 1, 0));
				Online_Orders_100_to_249_dot_99_Range_cnt := SUM(GROUP, IF(PurchaseFile.Online_Orders_100_to_249_dot_99_Range <> '', 1, 0));
				Online_Orders_250_to_499_dot_99_Range_cnt := SUM(GROUP, IF(PurchaseFile.Online_Orders_250_to_499_dot_99_Range <> '', 1, 0));
				Online_Orders_500_to_999_dot_99_Range_cnt := SUM(GROUP, IF(PurchaseFile.Online_Orders_500_to_999_dot_99_Range <> '', 1, 0));
				Online_Orders_1000_plus_Range_cnt := SUM(GROUP, IF(PurchaseFile.Online_Orders_1000_plus_Range <> '', 1, 0));
				Offline_Orders_Under_50_Range_cnt := SUM(GROUP, IF(PurchaseFile.Offline_Orders_Under_50_Range <> '', 1, 0));
				Offline_Orders_50_to_99_dot_99_Range_cnt := SUM(GROUP, IF(PurchaseFile.Offline_Orders_50_to_99_dot_99_Range <> '', 1, 0));
				Offline_Orders_100_to_249_dot_99_Range_cnt := SUM(GROUP, IF(PurchaseFile.Offline_Orders_100_to_249_dot_99_Range <> '', 1, 0));
				Offline_Orders_250_to_499_dot_99_Range_cnt := SUM(GROUP, IF(PurchaseFile.Offline_Orders_250_to_499_dot_99_Range <> '', 1, 0));
				Offline_Orders_500_to_999_dot_99_Range_cnt := SUM(GROUP, IF(PurchaseFile.Offline_Orders_500_to_999_dot_99_Range <> '', 1, 0));
				Offline_Orders_1000_plus_Range_cnt := SUM(GROUP, IF(PurchaseFile.Offline_Orders_1000_plus_Range <> '', 1, 0));
				Retail_Orders_Under_50_Range_cnt := SUM(GROUP, IF(PurchaseFile.Retail_Orders_Under_50_Range <> '', 1, 0));
				Retail_Orders_50_to_99_dot_99_Range_cnt := SUM(GROUP, IF(PurchaseFile.Retail_Orders_50_to_99_dot_99_Range <> '', 1, 0));
				Retail_Orders_100_to_249_dot_99_Range_cnt := SUM(GROUP, IF(PurchaseFile.Retail_Orders_100_to_249_dot_99_Range <> '', 1, 0));
				Retail_Orders_250_to_499_dot_99_Range_cnt := SUM(GROUP, IF(PurchaseFile.Retail_Orders_250_to_499_dot_99_Range <> '', 1, 0));
				Retail_Orders_500_to_999_dot_99_Range_cnt := SUM(GROUP, IF(PurchaseFile.Retail_Orders_500_to_999_dot_99_Range <> '', 1, 0));
				Retail_Orders_1000_plus_Range_cnt := SUM(GROUP, IF(PurchaseFile.Retail_Orders_1000_plus_Range <> '', 1, 0));
				Weeks_Since_Last_Order_Apparel_General_cnt := SUM(GROUP, IF(PurchaseFile.Weeks_Since_Last_Order_Apparel_General <> '', 1, 0));
				Weeks_Since_Last_Order_Novelty_cnt := SUM(GROUP, IF(PurchaseFile.Weeks_Since_Last_Order_Novelty <> '', 1, 0));
				Weeks_Since_Last_Order_Books_cnt := SUM(GROUP, IF(PurchaseFile.Weeks_Since_Last_Order_Books <> '', 1, 0));
				Weeks_Since_Last_Order_Childrens_Products_cnt := SUM(GROUP, IF(PurchaseFile.Weeks_Since_Last_Order_Childrens_Products <> '', 1, 0));
				Weeks_Since_Last_Order_Crafts_or_Hobbies_cnt := SUM(GROUP, IF(PurchaseFile.Weeks_Since_Last_Order_Crafts_or_Hobbies <> '', 1, 0));
				Weeks_Since_Last_Order_Gift_cnt := SUM(GROUP, IF(PurchaseFile.Weeks_Since_Last_Order_Gift <> '', 1, 0));
				Weeks_Since_Last_Order_Holiday_Items_cnt := SUM(GROUP, IF(PurchaseFile.Weeks_Since_Last_Order_Holiday_Items <> '', 1, 0));
				Weeks_Since_Last_Order_Specialty_Gifts_cnt := SUM(GROUP, IF(PurchaseFile.Weeks_Since_Last_Order_Specialty_Gifts <> '', 1, 0));
				Weeks_Since_Last_Order_Home_Furnishings_cnt := SUM(GROUP, IF(PurchaseFile.Weeks_Since_Last_Order_Home_Furnishings <> '', 1, 0));
				Weeks_Since_Last_Order_Housewares_cnt := SUM(GROUP, IF(PurchaseFile.Weeks_Since_Last_Order_Housewares <> '', 1, 0));
				Weeks_Since_Last_Order_Homecare_cnt := SUM(GROUP, IF(PurchaseFile.Weeks_Since_Last_Order_Homecare <> '', 1, 0));
				Weeks_Since_Last_Order_Garden_cnt := SUM(GROUP, IF(PurchaseFile.Weeks_Since_Last_Order_Garden <> '', 1, 0));
				Weeks_Since_Last_Order_Sports_and_Leiser_cnt := SUM(GROUP, IF(PurchaseFile.Weeks_Since_Last_Order_Sports_and_Leiser <> '', 1, 0));
				Weeks_Since_Last_Order_Travel_cnt := SUM(GROUP, IF(PurchaseFile.Weeks_Since_Last_Order_Travel <> '', 1, 0));
				Orders_Apparel_General_cnt := SUM(GROUP, IF(PurchaseFile.Orders_Apparel_General <> '', 1, 0));
				Orders_Novelty_cnt := SUM(GROUP, IF(PurchaseFile.Orders_Novelty <> '', 1, 0));
				Orders_Books_cnt := SUM(GROUP, IF(PurchaseFile.Orders_Books <> '', 1, 0));
				Orders_Childrens_Products_cnt := SUM(GROUP, IF(PurchaseFile.Orders_Childrens_Products <> '', 1, 0));
				Orders_Crafts_or_Hobbies_cnt := SUM(GROUP, IF(PurchaseFile.Orders_Crafts_or_Hobbies <> '', 1, 0));
				Orders_Gift_cnt := SUM(GROUP, IF(PurchaseFile.Orders_Gift <> '', 1, 0));
				Orders_Holiday_Items_cnt := SUM(GROUP, IF(PurchaseFile.Orders_Holiday_Items <> '', 1, 0));
				Orders_Specialty_Gifts_cnt := SUM(GROUP, IF(PurchaseFile.Orders_Specialty_Gifts <> '', 1, 0));
				Orders_Home_Furnishings_cnt := SUM(GROUP, IF(PurchaseFile.Orders_Home_Furnishings <> '', 1, 0));
				Orders_Housewares_cnt := SUM(GROUP, IF(PurchaseFile.Orders_Housewares <> '', 1, 0));
				Orders_Homecare_cnt := SUM(GROUP, IF(PurchaseFile.Orders_Homecare <> '', 1, 0));
				Orders_Garden_cnt := SUM(GROUP, IF(PurchaseFile.Orders_Garden <> '', 1, 0));
				Orders_Sports_and_Leiser_cnt := SUM(GROUP, IF(PurchaseFile.Orders_Sports_and_Leiser <> '', 1, 0));
				Orders_Travel_cnt := SUM(GROUP, IF(PurchaseFile.Orders_Travel <> '', 1, 0));
				Dollars_Apparel_General_cnt := SUM(GROUP, IF(PurchaseFile.Dollars_Apparel_General <> '', 1, 0));
				Dollars_Novelty_cnt := SUM(GROUP, IF(PurchaseFile.Dollars_Novelty <> '', 1, 0));
				Dollars_Books_cnt := SUM(GROUP, IF(PurchaseFile.Dollars_Books <> '', 1, 0));
				Dollars_Childrens_Products_cnt := SUM(GROUP, IF(PurchaseFile.Dollars_Childrens_Products <> '', 1, 0));
				Dollars_Crafts_or_Hobbies_cnt := SUM(GROUP, IF(PurchaseFile.Dollars_Crafts_or_Hobbies <> '', 1, 0));
				Dollars_Gift_cnt := SUM(GROUP, IF(PurchaseFile.Dollars_Gift <> '', 1, 0));
				Dollars_Holiday_Items_cnt := SUM(GROUP, IF(PurchaseFile.Dollars_Holiday_Items <> '', 1, 0));
				Dollars_Specialty_Gifts_cnt := SUM(GROUP, IF(PurchaseFile.Dollars_Specialty_Gifts <> '', 1, 0));
				Dollars_Home_Furnishings_cnt := SUM(GROUP, IF(PurchaseFile.Dollars_Home_Furnishings <> '', 1, 0));
				Dollars_Housewares_cnt := SUM(GROUP, IF(PurchaseFile.Dollars_Housewares <> '', 1, 0));
				Dollars_Homecare_cnt := SUM(GROUP, IF(PurchaseFile.Dollars_Homecare <> '', 1, 0));
				Dollars_Garden_cnt := SUM(GROUP, IF(PurchaseFile.Dollars_Garden <> '', 1, 0));
				Dollars_Sports_and_Leiser_cnt := SUM(GROUP, IF(PurchaseFile.Dollars_Sports_and_Leiser <> '', 1, 0));
				Dollars_Travel_cnt := SUM(GROUP, IF(PurchaseFile.Dollars_Travel <> '', 1, 0));
		END;
		
	basestrata:=			Sort(Table(basefile,Layout_Strata,State,few),State);
	purchasestrata := Table(PurchaseFile,Layout_Purchase,number_of_sources,few);
	
	strata.createXMLStats(basestrata,'iBehavior Consumer stats','Main file',version,'',strataResults,'view','population');
	strata.createXMLStats(purchasestrata,'iBehavior Purchase stats','Purchase data',version,'',strataPurchaseResults,'view','population');
 
	RETURN SEQUENTIAL(strataResults,
										strataPurchaseResults);
	

END;

