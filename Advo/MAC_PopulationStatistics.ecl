 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_ZIP_5 = '',Input_Route_Num = '',Input_ZIP_4 = '',Input_WALK_Sequence = '',Input_STREET_NUM = '',Input_STREET_PRE_DIRectional = '',Input_STREET_NAME = '',Input_STREET_POST_DIRectional = '',Input_STREET_SUFFIX = '',Input_Secondary_Unit_Designator = '',Input_Secondary_Unit_Number = '',Input_Address_Vacancy_Indicator = '',Input_Throw_Back_Indicator = '',Input_Seasonal_Delivery_Indicator = '',Input_Seasonal_Start_Suppression_Date = '',Input_Seasonal_End_Suppression_Date = '',Input_DND_Indicator = '',Input_College_Indicator = '',Input_College_Start_Suppression_Date = '',Input_College_End_Suppression_Date = '',Input_Address_Style_Flag = '',Input_Simplify_Address_Count = '',Input_Drop_Indicator = '',Input_Residential_or_Business_Ind = '',Input_DPBC_Digit = '',Input_DPBC_Check_Digit = '',Input_Update_Date = '',Input_File_Release_Date = '',Input_Override_file_release_date = '',Input_County_Num = '',Input_County_Name = '',Input_City_Name = '',Input_State_Code = '',Input_State_Num = '',Input_Congressional_District_Number = '',Input_OWGM_Indicator = '',Input_Record_Type_Code = '',Input_ADVO_Key = '',Input_Address_Type = '',Input_Mixed_Address_Usage = '',Input_date_first_seen = '',Input_date_last_seen = '',Input_date_vendor_first_reported = '',Input_date_vendor_last_reported = '',Input_VAC_BEGDT = '',Input_VAC_ENDDT = '',Input_MONTHS_VAC_CURR = '',Input_MONTHS_VAC_MAX = '',Input_VAC_COUNT = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_fips_county = '',Input_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_RawAID = '',Input_cleanaid = '',Input_addresstype = '',Input_Active_flag = '',OutFile) := MACRO
  IMPORT SALT311,Advo;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_ZIP_5)='' )
      '' 
    #ELSE
        IF( le.Input_ZIP_5 = (TYPEOF(le.Input_ZIP_5))'','',':ZIP_5')
    #END
 
+    #IF( #TEXT(Input_Route_Num)='' )
      '' 
    #ELSE
        IF( le.Input_Route_Num = (TYPEOF(le.Input_Route_Num))'','',':Route_Num')
    #END
 
+    #IF( #TEXT(Input_ZIP_4)='' )
      '' 
    #ELSE
        IF( le.Input_ZIP_4 = (TYPEOF(le.Input_ZIP_4))'','',':ZIP_4')
    #END
 
+    #IF( #TEXT(Input_WALK_Sequence)='' )
      '' 
    #ELSE
        IF( le.Input_WALK_Sequence = (TYPEOF(le.Input_WALK_Sequence))'','',':WALK_Sequence')
    #END
 
+    #IF( #TEXT(Input_STREET_NUM)='' )
      '' 
    #ELSE
        IF( le.Input_STREET_NUM = (TYPEOF(le.Input_STREET_NUM))'','',':STREET_NUM')
    #END
 
+    #IF( #TEXT(Input_STREET_PRE_DIRectional)='' )
      '' 
    #ELSE
        IF( le.Input_STREET_PRE_DIRectional = (TYPEOF(le.Input_STREET_PRE_DIRectional))'','',':STREET_PRE_DIRectional')
    #END
 
+    #IF( #TEXT(Input_STREET_NAME)='' )
      '' 
    #ELSE
        IF( le.Input_STREET_NAME = (TYPEOF(le.Input_STREET_NAME))'','',':STREET_NAME')
    #END
 
+    #IF( #TEXT(Input_STREET_POST_DIRectional)='' )
      '' 
    #ELSE
        IF( le.Input_STREET_POST_DIRectional = (TYPEOF(le.Input_STREET_POST_DIRectional))'','',':STREET_POST_DIRectional')
    #END
 
+    #IF( #TEXT(Input_STREET_SUFFIX)='' )
      '' 
    #ELSE
        IF( le.Input_STREET_SUFFIX = (TYPEOF(le.Input_STREET_SUFFIX))'','',':STREET_SUFFIX')
    #END
 
+    #IF( #TEXT(Input_Secondary_Unit_Designator)='' )
      '' 
    #ELSE
        IF( le.Input_Secondary_Unit_Designator = (TYPEOF(le.Input_Secondary_Unit_Designator))'','',':Secondary_Unit_Designator')
    #END
 
+    #IF( #TEXT(Input_Secondary_Unit_Number)='' )
      '' 
    #ELSE
        IF( le.Input_Secondary_Unit_Number = (TYPEOF(le.Input_Secondary_Unit_Number))'','',':Secondary_Unit_Number')
    #END
 
+    #IF( #TEXT(Input_Address_Vacancy_Indicator)='' )
      '' 
    #ELSE
        IF( le.Input_Address_Vacancy_Indicator = (TYPEOF(le.Input_Address_Vacancy_Indicator))'','',':Address_Vacancy_Indicator')
    #END
 
+    #IF( #TEXT(Input_Throw_Back_Indicator)='' )
      '' 
    #ELSE
        IF( le.Input_Throw_Back_Indicator = (TYPEOF(le.Input_Throw_Back_Indicator))'','',':Throw_Back_Indicator')
    #END
 
+    #IF( #TEXT(Input_Seasonal_Delivery_Indicator)='' )
      '' 
    #ELSE
        IF( le.Input_Seasonal_Delivery_Indicator = (TYPEOF(le.Input_Seasonal_Delivery_Indicator))'','',':Seasonal_Delivery_Indicator')
    #END
 
+    #IF( #TEXT(Input_Seasonal_Start_Suppression_Date)='' )
      '' 
    #ELSE
        IF( le.Input_Seasonal_Start_Suppression_Date = (TYPEOF(le.Input_Seasonal_Start_Suppression_Date))'','',':Seasonal_Start_Suppression_Date')
    #END
 
+    #IF( #TEXT(Input_Seasonal_End_Suppression_Date)='' )
      '' 
    #ELSE
        IF( le.Input_Seasonal_End_Suppression_Date = (TYPEOF(le.Input_Seasonal_End_Suppression_Date))'','',':Seasonal_End_Suppression_Date')
    #END
 
+    #IF( #TEXT(Input_DND_Indicator)='' )
      '' 
    #ELSE
        IF( le.Input_DND_Indicator = (TYPEOF(le.Input_DND_Indicator))'','',':DND_Indicator')
    #END
 
+    #IF( #TEXT(Input_College_Indicator)='' )
      '' 
    #ELSE
        IF( le.Input_College_Indicator = (TYPEOF(le.Input_College_Indicator))'','',':College_Indicator')
    #END
 
+    #IF( #TEXT(Input_College_Start_Suppression_Date)='' )
      '' 
    #ELSE
        IF( le.Input_College_Start_Suppression_Date = (TYPEOF(le.Input_College_Start_Suppression_Date))'','',':College_Start_Suppression_Date')
    #END
 
+    #IF( #TEXT(Input_College_End_Suppression_Date)='' )
      '' 
    #ELSE
        IF( le.Input_College_End_Suppression_Date = (TYPEOF(le.Input_College_End_Suppression_Date))'','',':College_End_Suppression_Date')
    #END
 
+    #IF( #TEXT(Input_Address_Style_Flag)='' )
      '' 
    #ELSE
        IF( le.Input_Address_Style_Flag = (TYPEOF(le.Input_Address_Style_Flag))'','',':Address_Style_Flag')
    #END
 
+    #IF( #TEXT(Input_Simplify_Address_Count)='' )
      '' 
    #ELSE
        IF( le.Input_Simplify_Address_Count = (TYPEOF(le.Input_Simplify_Address_Count))'','',':Simplify_Address_Count')
    #END
 
+    #IF( #TEXT(Input_Drop_Indicator)='' )
      '' 
    #ELSE
        IF( le.Input_Drop_Indicator = (TYPEOF(le.Input_Drop_Indicator))'','',':Drop_Indicator')
    #END
 
+    #IF( #TEXT(Input_Residential_or_Business_Ind)='' )
      '' 
    #ELSE
        IF( le.Input_Residential_or_Business_Ind = (TYPEOF(le.Input_Residential_or_Business_Ind))'','',':Residential_or_Business_Ind')
    #END
 
+    #IF( #TEXT(Input_DPBC_Digit)='' )
      '' 
    #ELSE
        IF( le.Input_DPBC_Digit = (TYPEOF(le.Input_DPBC_Digit))'','',':DPBC_Digit')
    #END
 
+    #IF( #TEXT(Input_DPBC_Check_Digit)='' )
      '' 
    #ELSE
        IF( le.Input_DPBC_Check_Digit = (TYPEOF(le.Input_DPBC_Check_Digit))'','',':DPBC_Check_Digit')
    #END
 
+    #IF( #TEXT(Input_Update_Date)='' )
      '' 
    #ELSE
        IF( le.Input_Update_Date = (TYPEOF(le.Input_Update_Date))'','',':Update_Date')
    #END
 
+    #IF( #TEXT(Input_File_Release_Date)='' )
      '' 
    #ELSE
        IF( le.Input_File_Release_Date = (TYPEOF(le.Input_File_Release_Date))'','',':File_Release_Date')
    #END
 
+    #IF( #TEXT(Input_Override_file_release_date)='' )
      '' 
    #ELSE
        IF( le.Input_Override_file_release_date = (TYPEOF(le.Input_Override_file_release_date))'','',':Override_file_release_date')
    #END
 
+    #IF( #TEXT(Input_County_Num)='' )
      '' 
    #ELSE
        IF( le.Input_County_Num = (TYPEOF(le.Input_County_Num))'','',':County_Num')
    #END
 
+    #IF( #TEXT(Input_County_Name)='' )
      '' 
    #ELSE
        IF( le.Input_County_Name = (TYPEOF(le.Input_County_Name))'','',':County_Name')
    #END
 
+    #IF( #TEXT(Input_City_Name)='' )
      '' 
    #ELSE
        IF( le.Input_City_Name = (TYPEOF(le.Input_City_Name))'','',':City_Name')
    #END
 
+    #IF( #TEXT(Input_State_Code)='' )
      '' 
    #ELSE
        IF( le.Input_State_Code = (TYPEOF(le.Input_State_Code))'','',':State_Code')
    #END
 
+    #IF( #TEXT(Input_State_Num)='' )
      '' 
    #ELSE
        IF( le.Input_State_Num = (TYPEOF(le.Input_State_Num))'','',':State_Num')
    #END
 
+    #IF( #TEXT(Input_Congressional_District_Number)='' )
      '' 
    #ELSE
        IF( le.Input_Congressional_District_Number = (TYPEOF(le.Input_Congressional_District_Number))'','',':Congressional_District_Number')
    #END
 
+    #IF( #TEXT(Input_OWGM_Indicator)='' )
      '' 
    #ELSE
        IF( le.Input_OWGM_Indicator = (TYPEOF(le.Input_OWGM_Indicator))'','',':OWGM_Indicator')
    #END
 
+    #IF( #TEXT(Input_Record_Type_Code)='' )
      '' 
    #ELSE
        IF( le.Input_Record_Type_Code = (TYPEOF(le.Input_Record_Type_Code))'','',':Record_Type_Code')
    #END
 
+    #IF( #TEXT(Input_ADVO_Key)='' )
      '' 
    #ELSE
        IF( le.Input_ADVO_Key = (TYPEOF(le.Input_ADVO_Key))'','',':ADVO_Key')
    #END
 
+    #IF( #TEXT(Input_Address_Type)='' )
      '' 
    #ELSE
        IF( le.Input_Address_Type = (TYPEOF(le.Input_Address_Type))'','',':Address_Type')
    #END
 
+    #IF( #TEXT(Input_Mixed_Address_Usage)='' )
      '' 
    #ELSE
        IF( le.Input_Mixed_Address_Usage = (TYPEOF(le.Input_Mixed_Address_Usage))'','',':Mixed_Address_Usage')
    #END
 
+    #IF( #TEXT(Input_date_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_date_first_seen = (TYPEOF(le.Input_date_first_seen))'','',':date_first_seen')
    #END
 
+    #IF( #TEXT(Input_date_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_date_last_seen = (TYPEOF(le.Input_date_last_seen))'','',':date_last_seen')
    #END
 
+    #IF( #TEXT(Input_date_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_date_vendor_first_reported = (TYPEOF(le.Input_date_vendor_first_reported))'','',':date_vendor_first_reported')
    #END
 
+    #IF( #TEXT(Input_date_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_date_vendor_last_reported = (TYPEOF(le.Input_date_vendor_last_reported))'','',':date_vendor_last_reported')
    #END
 
+    #IF( #TEXT(Input_VAC_BEGDT)='' )
      '' 
    #ELSE
        IF( le.Input_VAC_BEGDT = (TYPEOF(le.Input_VAC_BEGDT))'','',':VAC_BEGDT')
    #END
 
+    #IF( #TEXT(Input_VAC_ENDDT)='' )
      '' 
    #ELSE
        IF( le.Input_VAC_ENDDT = (TYPEOF(le.Input_VAC_ENDDT))'','',':VAC_ENDDT')
    #END
 
+    #IF( #TEXT(Input_MONTHS_VAC_CURR)='' )
      '' 
    #ELSE
        IF( le.Input_MONTHS_VAC_CURR = (TYPEOF(le.Input_MONTHS_VAC_CURR))'','',':MONTHS_VAC_CURR')
    #END
 
+    #IF( #TEXT(Input_MONTHS_VAC_MAX)='' )
      '' 
    #ELSE
        IF( le.Input_MONTHS_VAC_MAX = (TYPEOF(le.Input_MONTHS_VAC_MAX))'','',':MONTHS_VAC_MAX')
    #END
 
+    #IF( #TEXT(Input_VAC_COUNT)='' )
      '' 
    #ELSE
        IF( le.Input_VAC_COUNT = (TYPEOF(le.Input_VAC_COUNT))'','',':VAC_COUNT')
    #END
 
+    #IF( #TEXT(Input_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_prim_range = (TYPEOF(le.Input_prim_range))'','',':prim_range')
    #END
 
+    #IF( #TEXT(Input_predir)='' )
      '' 
    #ELSE
        IF( le.Input_predir = (TYPEOF(le.Input_predir))'','',':predir')
    #END
 
+    #IF( #TEXT(Input_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_prim_name = (TYPEOF(le.Input_prim_name))'','',':prim_name')
    #END
 
+    #IF( #TEXT(Input_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_addr_suffix = (TYPEOF(le.Input_addr_suffix))'','',':addr_suffix')
    #END
 
+    #IF( #TEXT(Input_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_postdir = (TYPEOF(le.Input_postdir))'','',':postdir')
    #END
 
+    #IF( #TEXT(Input_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_unit_desig = (TYPEOF(le.Input_unit_desig))'','',':unit_desig')
    #END
 
+    #IF( #TEXT(Input_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_sec_range = (TYPEOF(le.Input_sec_range))'','',':sec_range')
    #END
 
+    #IF( #TEXT(Input_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_p_city_name = (TYPEOF(le.Input_p_city_name))'','',':p_city_name')
    #END
 
+    #IF( #TEXT(Input_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_v_city_name = (TYPEOF(le.Input_v_city_name))'','',':v_city_name')
    #END
 
+    #IF( #TEXT(Input_st)='' )
      '' 
    #ELSE
        IF( le.Input_st = (TYPEOF(le.Input_st))'','',':st')
    #END
 
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END
 
+    #IF( #TEXT(Input_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_zip4 = (TYPEOF(le.Input_zip4))'','',':zip4')
    #END
 
+    #IF( #TEXT(Input_cart)='' )
      '' 
    #ELSE
        IF( le.Input_cart = (TYPEOF(le.Input_cart))'','',':cart')
    #END
 
+    #IF( #TEXT(Input_cr_sort_sz)='' )
      '' 
    #ELSE
        IF( le.Input_cr_sort_sz = (TYPEOF(le.Input_cr_sort_sz))'','',':cr_sort_sz')
    #END
 
+    #IF( #TEXT(Input_lot)='' )
      '' 
    #ELSE
        IF( le.Input_lot = (TYPEOF(le.Input_lot))'','',':lot')
    #END
 
+    #IF( #TEXT(Input_lot_order)='' )
      '' 
    #ELSE
        IF( le.Input_lot_order = (TYPEOF(le.Input_lot_order))'','',':lot_order')
    #END
 
+    #IF( #TEXT(Input_dbpc)='' )
      '' 
    #ELSE
        IF( le.Input_dbpc = (TYPEOF(le.Input_dbpc))'','',':dbpc')
    #END
 
+    #IF( #TEXT(Input_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_chk_digit = (TYPEOF(le.Input_chk_digit))'','',':chk_digit')
    #END
 
+    #IF( #TEXT(Input_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_rec_type = (TYPEOF(le.Input_rec_type))'','',':rec_type')
    #END
 
+    #IF( #TEXT(Input_fips_county)='' )
      '' 
    #ELSE
        IF( le.Input_fips_county = (TYPEOF(le.Input_fips_county))'','',':fips_county')
    #END
 
+    #IF( #TEXT(Input_county)='' )
      '' 
    #ELSE
        IF( le.Input_county = (TYPEOF(le.Input_county))'','',':county')
    #END
 
+    #IF( #TEXT(Input_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_geo_lat = (TYPEOF(le.Input_geo_lat))'','',':geo_lat')
    #END
 
+    #IF( #TEXT(Input_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_geo_long = (TYPEOF(le.Input_geo_long))'','',':geo_long')
    #END
 
+    #IF( #TEXT(Input_msa)='' )
      '' 
    #ELSE
        IF( le.Input_msa = (TYPEOF(le.Input_msa))'','',':msa')
    #END
 
+    #IF( #TEXT(Input_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_geo_blk = (TYPEOF(le.Input_geo_blk))'','',':geo_blk')
    #END
 
+    #IF( #TEXT(Input_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_geo_match = (TYPEOF(le.Input_geo_match))'','',':geo_match')
    #END
 
+    #IF( #TEXT(Input_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_err_stat = (TYPEOF(le.Input_err_stat))'','',':err_stat')
    #END
 
+    #IF( #TEXT(Input_RawAID)='' )
      '' 
    #ELSE
        IF( le.Input_RawAID = (TYPEOF(le.Input_RawAID))'','',':RawAID')
    #END
 
+    #IF( #TEXT(Input_cleanaid)='' )
      '' 
    #ELSE
        IF( le.Input_cleanaid = (TYPEOF(le.Input_cleanaid))'','',':cleanaid')
    #END
 
+    #IF( #TEXT(Input_addresstype)='' )
      '' 
    #ELSE
        IF( le.Input_addresstype = (TYPEOF(le.Input_addresstype))'','',':addresstype')
    #END
 
+    #IF( #TEXT(Input_Active_flag)='' )
      '' 
    #ELSE
        IF( le.Input_Active_flag = (TYPEOF(le.Input_Active_flag))'','',':Active_flag')
    #END
;
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%, fields, FEW ), 1000, -cnt );
ENDMACRO;
