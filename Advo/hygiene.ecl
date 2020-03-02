IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_Scrubs) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_ZIP_5_cnt := COUNT(GROUP,h.ZIP_5 <> (TYPEOF(h.ZIP_5))'');
    populated_ZIP_5_pcnt := AVE(GROUP,IF(h.ZIP_5 = (TYPEOF(h.ZIP_5))'',0,100));
    maxlength_ZIP_5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ZIP_5)));
    avelength_ZIP_5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ZIP_5)),h.ZIP_5<>(typeof(h.ZIP_5))'');
    populated_Route_Num_cnt := COUNT(GROUP,h.Route_Num <> (TYPEOF(h.Route_Num))'');
    populated_Route_Num_pcnt := AVE(GROUP,IF(h.Route_Num = (TYPEOF(h.Route_Num))'',0,100));
    maxlength_Route_Num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Route_Num)));
    avelength_Route_Num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Route_Num)),h.Route_Num<>(typeof(h.Route_Num))'');
    populated_ZIP_4_cnt := COUNT(GROUP,h.ZIP_4 <> (TYPEOF(h.ZIP_4))'');
    populated_ZIP_4_pcnt := AVE(GROUP,IF(h.ZIP_4 = (TYPEOF(h.ZIP_4))'',0,100));
    maxlength_ZIP_4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ZIP_4)));
    avelength_ZIP_4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ZIP_4)),h.ZIP_4<>(typeof(h.ZIP_4))'');
    populated_WALK_Sequence_cnt := COUNT(GROUP,h.WALK_Sequence <> (TYPEOF(h.WALK_Sequence))'');
    populated_WALK_Sequence_pcnt := AVE(GROUP,IF(h.WALK_Sequence = (TYPEOF(h.WALK_Sequence))'',0,100));
    maxlength_WALK_Sequence := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.WALK_Sequence)));
    avelength_WALK_Sequence := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.WALK_Sequence)),h.WALK_Sequence<>(typeof(h.WALK_Sequence))'');
    populated_STREET_NUM_cnt := COUNT(GROUP,h.STREET_NUM <> (TYPEOF(h.STREET_NUM))'');
    populated_STREET_NUM_pcnt := AVE(GROUP,IF(h.STREET_NUM = (TYPEOF(h.STREET_NUM))'',0,100));
    maxlength_STREET_NUM := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.STREET_NUM)));
    avelength_STREET_NUM := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.STREET_NUM)),h.STREET_NUM<>(typeof(h.STREET_NUM))'');
    populated_STREET_PRE_DIRectional_cnt := COUNT(GROUP,h.STREET_PRE_DIRectional <> (TYPEOF(h.STREET_PRE_DIRectional))'');
    populated_STREET_PRE_DIRectional_pcnt := AVE(GROUP,IF(h.STREET_PRE_DIRectional = (TYPEOF(h.STREET_PRE_DIRectional))'',0,100));
    maxlength_STREET_PRE_DIRectional := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.STREET_PRE_DIRectional)));
    avelength_STREET_PRE_DIRectional := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.STREET_PRE_DIRectional)),h.STREET_PRE_DIRectional<>(typeof(h.STREET_PRE_DIRectional))'');
    populated_STREET_NAME_cnt := COUNT(GROUP,h.STREET_NAME <> (TYPEOF(h.STREET_NAME))'');
    populated_STREET_NAME_pcnt := AVE(GROUP,IF(h.STREET_NAME = (TYPEOF(h.STREET_NAME))'',0,100));
    maxlength_STREET_NAME := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.STREET_NAME)));
    avelength_STREET_NAME := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.STREET_NAME)),h.STREET_NAME<>(typeof(h.STREET_NAME))'');
    populated_STREET_POST_DIRectional_cnt := COUNT(GROUP,h.STREET_POST_DIRectional <> (TYPEOF(h.STREET_POST_DIRectional))'');
    populated_STREET_POST_DIRectional_pcnt := AVE(GROUP,IF(h.STREET_POST_DIRectional = (TYPEOF(h.STREET_POST_DIRectional))'',0,100));
    maxlength_STREET_POST_DIRectional := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.STREET_POST_DIRectional)));
    avelength_STREET_POST_DIRectional := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.STREET_POST_DIRectional)),h.STREET_POST_DIRectional<>(typeof(h.STREET_POST_DIRectional))'');
    populated_STREET_SUFFIX_cnt := COUNT(GROUP,h.STREET_SUFFIX <> (TYPEOF(h.STREET_SUFFIX))'');
    populated_STREET_SUFFIX_pcnt := AVE(GROUP,IF(h.STREET_SUFFIX = (TYPEOF(h.STREET_SUFFIX))'',0,100));
    maxlength_STREET_SUFFIX := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.STREET_SUFFIX)));
    avelength_STREET_SUFFIX := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.STREET_SUFFIX)),h.STREET_SUFFIX<>(typeof(h.STREET_SUFFIX))'');
    populated_Secondary_Unit_Designator_cnt := COUNT(GROUP,h.Secondary_Unit_Designator <> (TYPEOF(h.Secondary_Unit_Designator))'');
    populated_Secondary_Unit_Designator_pcnt := AVE(GROUP,IF(h.Secondary_Unit_Designator = (TYPEOF(h.Secondary_Unit_Designator))'',0,100));
    maxlength_Secondary_Unit_Designator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Secondary_Unit_Designator)));
    avelength_Secondary_Unit_Designator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Secondary_Unit_Designator)),h.Secondary_Unit_Designator<>(typeof(h.Secondary_Unit_Designator))'');
    populated_Secondary_Unit_Number_cnt := COUNT(GROUP,h.Secondary_Unit_Number <> (TYPEOF(h.Secondary_Unit_Number))'');
    populated_Secondary_Unit_Number_pcnt := AVE(GROUP,IF(h.Secondary_Unit_Number = (TYPEOF(h.Secondary_Unit_Number))'',0,100));
    maxlength_Secondary_Unit_Number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Secondary_Unit_Number)));
    avelength_Secondary_Unit_Number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Secondary_Unit_Number)),h.Secondary_Unit_Number<>(typeof(h.Secondary_Unit_Number))'');
    populated_Address_Vacancy_Indicator_cnt := COUNT(GROUP,h.Address_Vacancy_Indicator <> (TYPEOF(h.Address_Vacancy_Indicator))'');
    populated_Address_Vacancy_Indicator_pcnt := AVE(GROUP,IF(h.Address_Vacancy_Indicator = (TYPEOF(h.Address_Vacancy_Indicator))'',0,100));
    maxlength_Address_Vacancy_Indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Address_Vacancy_Indicator)));
    avelength_Address_Vacancy_Indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Address_Vacancy_Indicator)),h.Address_Vacancy_Indicator<>(typeof(h.Address_Vacancy_Indicator))'');
    populated_Throw_Back_Indicator_cnt := COUNT(GROUP,h.Throw_Back_Indicator <> (TYPEOF(h.Throw_Back_Indicator))'');
    populated_Throw_Back_Indicator_pcnt := AVE(GROUP,IF(h.Throw_Back_Indicator = (TYPEOF(h.Throw_Back_Indicator))'',0,100));
    maxlength_Throw_Back_Indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Throw_Back_Indicator)));
    avelength_Throw_Back_Indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Throw_Back_Indicator)),h.Throw_Back_Indicator<>(typeof(h.Throw_Back_Indicator))'');
    populated_Seasonal_Delivery_Indicator_cnt := COUNT(GROUP,h.Seasonal_Delivery_Indicator <> (TYPEOF(h.Seasonal_Delivery_Indicator))'');
    populated_Seasonal_Delivery_Indicator_pcnt := AVE(GROUP,IF(h.Seasonal_Delivery_Indicator = (TYPEOF(h.Seasonal_Delivery_Indicator))'',0,100));
    maxlength_Seasonal_Delivery_Indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Seasonal_Delivery_Indicator)));
    avelength_Seasonal_Delivery_Indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Seasonal_Delivery_Indicator)),h.Seasonal_Delivery_Indicator<>(typeof(h.Seasonal_Delivery_Indicator))'');
    populated_Seasonal_Start_Suppression_Date_cnt := COUNT(GROUP,h.Seasonal_Start_Suppression_Date <> (TYPEOF(h.Seasonal_Start_Suppression_Date))'');
    populated_Seasonal_Start_Suppression_Date_pcnt := AVE(GROUP,IF(h.Seasonal_Start_Suppression_Date = (TYPEOF(h.Seasonal_Start_Suppression_Date))'',0,100));
    maxlength_Seasonal_Start_Suppression_Date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Seasonal_Start_Suppression_Date)));
    avelength_Seasonal_Start_Suppression_Date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Seasonal_Start_Suppression_Date)),h.Seasonal_Start_Suppression_Date<>(typeof(h.Seasonal_Start_Suppression_Date))'');
    populated_Seasonal_End_Suppression_Date_cnt := COUNT(GROUP,h.Seasonal_End_Suppression_Date <> (TYPEOF(h.Seasonal_End_Suppression_Date))'');
    populated_Seasonal_End_Suppression_Date_pcnt := AVE(GROUP,IF(h.Seasonal_End_Suppression_Date = (TYPEOF(h.Seasonal_End_Suppression_Date))'',0,100));
    maxlength_Seasonal_End_Suppression_Date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Seasonal_End_Suppression_Date)));
    avelength_Seasonal_End_Suppression_Date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Seasonal_End_Suppression_Date)),h.Seasonal_End_Suppression_Date<>(typeof(h.Seasonal_End_Suppression_Date))'');
    populated_DND_Indicator_cnt := COUNT(GROUP,h.DND_Indicator <> (TYPEOF(h.DND_Indicator))'');
    populated_DND_Indicator_pcnt := AVE(GROUP,IF(h.DND_Indicator = (TYPEOF(h.DND_Indicator))'',0,100));
    maxlength_DND_Indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.DND_Indicator)));
    avelength_DND_Indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.DND_Indicator)),h.DND_Indicator<>(typeof(h.DND_Indicator))'');
    populated_College_Indicator_cnt := COUNT(GROUP,h.College_Indicator <> (TYPEOF(h.College_Indicator))'');
    populated_College_Indicator_pcnt := AVE(GROUP,IF(h.College_Indicator = (TYPEOF(h.College_Indicator))'',0,100));
    maxlength_College_Indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.College_Indicator)));
    avelength_College_Indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.College_Indicator)),h.College_Indicator<>(typeof(h.College_Indicator))'');
    populated_College_Start_Suppression_Date_cnt := COUNT(GROUP,h.College_Start_Suppression_Date <> (TYPEOF(h.College_Start_Suppression_Date))'');
    populated_College_Start_Suppression_Date_pcnt := AVE(GROUP,IF(h.College_Start_Suppression_Date = (TYPEOF(h.College_Start_Suppression_Date))'',0,100));
    maxlength_College_Start_Suppression_Date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.College_Start_Suppression_Date)));
    avelength_College_Start_Suppression_Date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.College_Start_Suppression_Date)),h.College_Start_Suppression_Date<>(typeof(h.College_Start_Suppression_Date))'');
    populated_College_End_Suppression_Date_cnt := COUNT(GROUP,h.College_End_Suppression_Date <> (TYPEOF(h.College_End_Suppression_Date))'');
    populated_College_End_Suppression_Date_pcnt := AVE(GROUP,IF(h.College_End_Suppression_Date = (TYPEOF(h.College_End_Suppression_Date))'',0,100));
    maxlength_College_End_Suppression_Date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.College_End_Suppression_Date)));
    avelength_College_End_Suppression_Date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.College_End_Suppression_Date)),h.College_End_Suppression_Date<>(typeof(h.College_End_Suppression_Date))'');
    populated_Address_Style_Flag_cnt := COUNT(GROUP,h.Address_Style_Flag <> (TYPEOF(h.Address_Style_Flag))'');
    populated_Address_Style_Flag_pcnt := AVE(GROUP,IF(h.Address_Style_Flag = (TYPEOF(h.Address_Style_Flag))'',0,100));
    maxlength_Address_Style_Flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Address_Style_Flag)));
    avelength_Address_Style_Flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Address_Style_Flag)),h.Address_Style_Flag<>(typeof(h.Address_Style_Flag))'');
    populated_Simplify_Address_Count_cnt := COUNT(GROUP,h.Simplify_Address_Count <> (TYPEOF(h.Simplify_Address_Count))'');
    populated_Simplify_Address_Count_pcnt := AVE(GROUP,IF(h.Simplify_Address_Count = (TYPEOF(h.Simplify_Address_Count))'',0,100));
    maxlength_Simplify_Address_Count := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Simplify_Address_Count)));
    avelength_Simplify_Address_Count := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Simplify_Address_Count)),h.Simplify_Address_Count<>(typeof(h.Simplify_Address_Count))'');
    populated_Drop_Indicator_cnt := COUNT(GROUP,h.Drop_Indicator <> (TYPEOF(h.Drop_Indicator))'');
    populated_Drop_Indicator_pcnt := AVE(GROUP,IF(h.Drop_Indicator = (TYPEOF(h.Drop_Indicator))'',0,100));
    maxlength_Drop_Indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Drop_Indicator)));
    avelength_Drop_Indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Drop_Indicator)),h.Drop_Indicator<>(typeof(h.Drop_Indicator))'');
    populated_Residential_or_Business_Ind_cnt := COUNT(GROUP,h.Residential_or_Business_Ind <> (TYPEOF(h.Residential_or_Business_Ind))'');
    populated_Residential_or_Business_Ind_pcnt := AVE(GROUP,IF(h.Residential_or_Business_Ind = (TYPEOF(h.Residential_or_Business_Ind))'',0,100));
    maxlength_Residential_or_Business_Ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Residential_or_Business_Ind)));
    avelength_Residential_or_Business_Ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Residential_or_Business_Ind)),h.Residential_or_Business_Ind<>(typeof(h.Residential_or_Business_Ind))'');
    populated_DPBC_Digit_cnt := COUNT(GROUP,h.DPBC_Digit <> (TYPEOF(h.DPBC_Digit))'');
    populated_DPBC_Digit_pcnt := AVE(GROUP,IF(h.DPBC_Digit = (TYPEOF(h.DPBC_Digit))'',0,100));
    maxlength_DPBC_Digit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.DPBC_Digit)));
    avelength_DPBC_Digit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.DPBC_Digit)),h.DPBC_Digit<>(typeof(h.DPBC_Digit))'');
    populated_DPBC_Check_Digit_cnt := COUNT(GROUP,h.DPBC_Check_Digit <> (TYPEOF(h.DPBC_Check_Digit))'');
    populated_DPBC_Check_Digit_pcnt := AVE(GROUP,IF(h.DPBC_Check_Digit = (TYPEOF(h.DPBC_Check_Digit))'',0,100));
    maxlength_DPBC_Check_Digit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.DPBC_Check_Digit)));
    avelength_DPBC_Check_Digit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.DPBC_Check_Digit)),h.DPBC_Check_Digit<>(typeof(h.DPBC_Check_Digit))'');
    populated_Update_Date_cnt := COUNT(GROUP,h.Update_Date <> (TYPEOF(h.Update_Date))'');
    populated_Update_Date_pcnt := AVE(GROUP,IF(h.Update_Date = (TYPEOF(h.Update_Date))'',0,100));
    maxlength_Update_Date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Update_Date)));
    avelength_Update_Date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Update_Date)),h.Update_Date<>(typeof(h.Update_Date))'');
    populated_File_Release_Date_cnt := COUNT(GROUP,h.File_Release_Date <> (TYPEOF(h.File_Release_Date))'');
    populated_File_Release_Date_pcnt := AVE(GROUP,IF(h.File_Release_Date = (TYPEOF(h.File_Release_Date))'',0,100));
    maxlength_File_Release_Date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.File_Release_Date)));
    avelength_File_Release_Date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.File_Release_Date)),h.File_Release_Date<>(typeof(h.File_Release_Date))'');
    populated_Override_file_release_date_cnt := COUNT(GROUP,h.Override_file_release_date <> (TYPEOF(h.Override_file_release_date))'');
    populated_Override_file_release_date_pcnt := AVE(GROUP,IF(h.Override_file_release_date = (TYPEOF(h.Override_file_release_date))'',0,100));
    maxlength_Override_file_release_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Override_file_release_date)));
    avelength_Override_file_release_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Override_file_release_date)),h.Override_file_release_date<>(typeof(h.Override_file_release_date))'');
    populated_County_Num_cnt := COUNT(GROUP,h.County_Num <> (TYPEOF(h.County_Num))'');
    populated_County_Num_pcnt := AVE(GROUP,IF(h.County_Num = (TYPEOF(h.County_Num))'',0,100));
    maxlength_County_Num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.County_Num)));
    avelength_County_Num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.County_Num)),h.County_Num<>(typeof(h.County_Num))'');
    populated_County_Name_cnt := COUNT(GROUP,h.County_Name <> (TYPEOF(h.County_Name))'');
    populated_County_Name_pcnt := AVE(GROUP,IF(h.County_Name = (TYPEOF(h.County_Name))'',0,100));
    maxlength_County_Name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.County_Name)));
    avelength_County_Name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.County_Name)),h.County_Name<>(typeof(h.County_Name))'');
    populated_City_Name_cnt := COUNT(GROUP,h.City_Name <> (TYPEOF(h.City_Name))'');
    populated_City_Name_pcnt := AVE(GROUP,IF(h.City_Name = (TYPEOF(h.City_Name))'',0,100));
    maxlength_City_Name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.City_Name)));
    avelength_City_Name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.City_Name)),h.City_Name<>(typeof(h.City_Name))'');
    populated_State_Code_cnt := COUNT(GROUP,h.State_Code <> (TYPEOF(h.State_Code))'');
    populated_State_Code_pcnt := AVE(GROUP,IF(h.State_Code = (TYPEOF(h.State_Code))'',0,100));
    maxlength_State_Code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.State_Code)));
    avelength_State_Code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.State_Code)),h.State_Code<>(typeof(h.State_Code))'');
    populated_State_Num_cnt := COUNT(GROUP,h.State_Num <> (TYPEOF(h.State_Num))'');
    populated_State_Num_pcnt := AVE(GROUP,IF(h.State_Num = (TYPEOF(h.State_Num))'',0,100));
    maxlength_State_Num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.State_Num)));
    avelength_State_Num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.State_Num)),h.State_Num<>(typeof(h.State_Num))'');
    populated_Congressional_District_Number_cnt := COUNT(GROUP,h.Congressional_District_Number <> (TYPEOF(h.Congressional_District_Number))'');
    populated_Congressional_District_Number_pcnt := AVE(GROUP,IF(h.Congressional_District_Number = (TYPEOF(h.Congressional_District_Number))'',0,100));
    maxlength_Congressional_District_Number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Congressional_District_Number)));
    avelength_Congressional_District_Number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Congressional_District_Number)),h.Congressional_District_Number<>(typeof(h.Congressional_District_Number))'');
    populated_OWGM_Indicator_cnt := COUNT(GROUP,h.OWGM_Indicator <> (TYPEOF(h.OWGM_Indicator))'');
    populated_OWGM_Indicator_pcnt := AVE(GROUP,IF(h.OWGM_Indicator = (TYPEOF(h.OWGM_Indicator))'',0,100));
    maxlength_OWGM_Indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.OWGM_Indicator)));
    avelength_OWGM_Indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.OWGM_Indicator)),h.OWGM_Indicator<>(typeof(h.OWGM_Indicator))'');
    populated_Record_Type_Code_cnt := COUNT(GROUP,h.Record_Type_Code <> (TYPEOF(h.Record_Type_Code))'');
    populated_Record_Type_Code_pcnt := AVE(GROUP,IF(h.Record_Type_Code = (TYPEOF(h.Record_Type_Code))'',0,100));
    maxlength_Record_Type_Code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Record_Type_Code)));
    avelength_Record_Type_Code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Record_Type_Code)),h.Record_Type_Code<>(typeof(h.Record_Type_Code))'');
    populated_ADVO_Key_cnt := COUNT(GROUP,h.ADVO_Key <> (TYPEOF(h.ADVO_Key))'');
    populated_ADVO_Key_pcnt := AVE(GROUP,IF(h.ADVO_Key = (TYPEOF(h.ADVO_Key))'',0,100));
    maxlength_ADVO_Key := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ADVO_Key)));
    avelength_ADVO_Key := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ADVO_Key)),h.ADVO_Key<>(typeof(h.ADVO_Key))'');
    populated_Address_Type_cnt := COUNT(GROUP,h.Address_Type <> (TYPEOF(h.Address_Type))'');
    populated_Address_Type_pcnt := AVE(GROUP,IF(h.Address_Type = (TYPEOF(h.Address_Type))'',0,100));
    maxlength_Address_Type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Address_Type)));
    avelength_Address_Type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Address_Type)),h.Address_Type<>(typeof(h.Address_Type))'');
    populated_Mixed_Address_Usage_cnt := COUNT(GROUP,h.Mixed_Address_Usage <> (TYPEOF(h.Mixed_Address_Usage))'');
    populated_Mixed_Address_Usage_pcnt := AVE(GROUP,IF(h.Mixed_Address_Usage = (TYPEOF(h.Mixed_Address_Usage))'',0,100));
    maxlength_Mixed_Address_Usage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Mixed_Address_Usage)));
    avelength_Mixed_Address_Usage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Mixed_Address_Usage)),h.Mixed_Address_Usage<>(typeof(h.Mixed_Address_Usage))'');
    populated_date_first_seen_cnt := COUNT(GROUP,h.date_first_seen <> (TYPEOF(h.date_first_seen))'');
    populated_date_first_seen_pcnt := AVE(GROUP,IF(h.date_first_seen = (TYPEOF(h.date_first_seen))'',0,100));
    maxlength_date_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_first_seen)));
    avelength_date_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_first_seen)),h.date_first_seen<>(typeof(h.date_first_seen))'');
    populated_date_last_seen_cnt := COUNT(GROUP,h.date_last_seen <> (TYPEOF(h.date_last_seen))'');
    populated_date_last_seen_pcnt := AVE(GROUP,IF(h.date_last_seen = (TYPEOF(h.date_last_seen))'',0,100));
    maxlength_date_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_last_seen)));
    avelength_date_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_last_seen)),h.date_last_seen<>(typeof(h.date_last_seen))'');
    populated_date_vendor_first_reported_cnt := COUNT(GROUP,h.date_vendor_first_reported <> (TYPEOF(h.date_vendor_first_reported))'');
    populated_date_vendor_first_reported_pcnt := AVE(GROUP,IF(h.date_vendor_first_reported = (TYPEOF(h.date_vendor_first_reported))'',0,100));
    maxlength_date_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_vendor_first_reported)));
    avelength_date_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_vendor_first_reported)),h.date_vendor_first_reported<>(typeof(h.date_vendor_first_reported))'');
    populated_date_vendor_last_reported_cnt := COUNT(GROUP,h.date_vendor_last_reported <> (TYPEOF(h.date_vendor_last_reported))'');
    populated_date_vendor_last_reported_pcnt := AVE(GROUP,IF(h.date_vendor_last_reported = (TYPEOF(h.date_vendor_last_reported))'',0,100));
    maxlength_date_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_vendor_last_reported)));
    avelength_date_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_vendor_last_reported)),h.date_vendor_last_reported<>(typeof(h.date_vendor_last_reported))'');
    populated_VAC_BEGDT_cnt := COUNT(GROUP,h.VAC_BEGDT <> (TYPEOF(h.VAC_BEGDT))'');
    populated_VAC_BEGDT_pcnt := AVE(GROUP,IF(h.VAC_BEGDT = (TYPEOF(h.VAC_BEGDT))'',0,100));
    maxlength_VAC_BEGDT := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.VAC_BEGDT)));
    avelength_VAC_BEGDT := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.VAC_BEGDT)),h.VAC_BEGDT<>(typeof(h.VAC_BEGDT))'');
    populated_VAC_ENDDT_cnt := COUNT(GROUP,h.VAC_ENDDT <> (TYPEOF(h.VAC_ENDDT))'');
    populated_VAC_ENDDT_pcnt := AVE(GROUP,IF(h.VAC_ENDDT = (TYPEOF(h.VAC_ENDDT))'',0,100));
    maxlength_VAC_ENDDT := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.VAC_ENDDT)));
    avelength_VAC_ENDDT := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.VAC_ENDDT)),h.VAC_ENDDT<>(typeof(h.VAC_ENDDT))'');
    populated_MONTHS_VAC_CURR_cnt := COUNT(GROUP,h.MONTHS_VAC_CURR <> (TYPEOF(h.MONTHS_VAC_CURR))'');
    populated_MONTHS_VAC_CURR_pcnt := AVE(GROUP,IF(h.MONTHS_VAC_CURR = (TYPEOF(h.MONTHS_VAC_CURR))'',0,100));
    maxlength_MONTHS_VAC_CURR := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.MONTHS_VAC_CURR)));
    avelength_MONTHS_VAC_CURR := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.MONTHS_VAC_CURR)),h.MONTHS_VAC_CURR<>(typeof(h.MONTHS_VAC_CURR))'');
    populated_MONTHS_VAC_MAX_cnt := COUNT(GROUP,h.MONTHS_VAC_MAX <> (TYPEOF(h.MONTHS_VAC_MAX))'');
    populated_MONTHS_VAC_MAX_pcnt := AVE(GROUP,IF(h.MONTHS_VAC_MAX = (TYPEOF(h.MONTHS_VAC_MAX))'',0,100));
    maxlength_MONTHS_VAC_MAX := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.MONTHS_VAC_MAX)));
    avelength_MONTHS_VAC_MAX := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.MONTHS_VAC_MAX)),h.MONTHS_VAC_MAX<>(typeof(h.MONTHS_VAC_MAX))'');
    populated_VAC_COUNT_cnt := COUNT(GROUP,h.VAC_COUNT <> (TYPEOF(h.VAC_COUNT))'');
    populated_VAC_COUNT_pcnt := AVE(GROUP,IF(h.VAC_COUNT = (TYPEOF(h.VAC_COUNT))'',0,100));
    maxlength_VAC_COUNT := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.VAC_COUNT)));
    avelength_VAC_COUNT := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.VAC_COUNT)),h.VAC_COUNT<>(typeof(h.VAC_COUNT))'');
    populated_prim_range_cnt := COUNT(GROUP,h.prim_range <> (TYPEOF(h.prim_range))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_cnt := COUNT(GROUP,h.predir <> (TYPEOF(h.predir))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_cnt := COUNT(GROUP,h.addr_suffix <> (TYPEOF(h.addr_suffix))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_cnt := COUNT(GROUP,h.postdir <> (TYPEOF(h.postdir))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_cnt := COUNT(GROUP,h.unit_desig <> (TYPEOF(h.unit_desig))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_cnt := COUNT(GROUP,h.sec_range <> (TYPEOF(h.sec_range))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_cnt := COUNT(GROUP,h.p_city_name <> (TYPEOF(h.p_city_name))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_cnt := COUNT(GROUP,h.v_city_name <> (TYPEOF(h.v_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_cnt := COUNT(GROUP,h.st <> (TYPEOF(h.st))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_cnt := COUNT(GROUP,h.cart <> (TYPEOF(h.cart))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_cnt := COUNT(GROUP,h.cr_sort_sz <> (TYPEOF(h.cr_sort_sz))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_cnt := COUNT(GROUP,h.lot <> (TYPEOF(h.lot))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_cnt := COUNT(GROUP,h.lot_order <> (TYPEOF(h.lot_order))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dbpc_cnt := COUNT(GROUP,h.dbpc <> (TYPEOF(h.dbpc))'');
    populated_dbpc_pcnt := AVE(GROUP,IF(h.dbpc = (TYPEOF(h.dbpc))'',0,100));
    maxlength_dbpc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbpc)));
    avelength_dbpc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbpc)),h.dbpc<>(typeof(h.dbpc))'');
    populated_chk_digit_cnt := COUNT(GROUP,h.chk_digit <> (TYPEOF(h.chk_digit))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_cnt := COUNT(GROUP,h.rec_type <> (TYPEOF(h.rec_type))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_fips_county_cnt := COUNT(GROUP,h.fips_county <> (TYPEOF(h.fips_county))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
    populated_county_cnt := COUNT(GROUP,h.county <> (TYPEOF(h.county))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_geo_lat_cnt := COUNT(GROUP,h.geo_lat <> (TYPEOF(h.geo_lat))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_cnt := COUNT(GROUP,h.geo_long <> (TYPEOF(h.geo_long))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_cnt := COUNT(GROUP,h.msa <> (TYPEOF(h.msa))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_cnt := COUNT(GROUP,h.geo_blk <> (TYPEOF(h.geo_blk))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_cnt := COUNT(GROUP,h.geo_match <> (TYPEOF(h.geo_match))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_cnt := COUNT(GROUP,h.err_stat <> (TYPEOF(h.err_stat))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_RawAID_cnt := COUNT(GROUP,h.RawAID <> (TYPEOF(h.RawAID))'');
    populated_RawAID_pcnt := AVE(GROUP,IF(h.RawAID = (TYPEOF(h.RawAID))'',0,100));
    maxlength_RawAID := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.RawAID)));
    avelength_RawAID := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.RawAID)),h.RawAID<>(typeof(h.RawAID))'');
    populated_cleanaid_cnt := COUNT(GROUP,h.cleanaid <> (TYPEOF(h.cleanaid))'');
    populated_cleanaid_pcnt := AVE(GROUP,IF(h.cleanaid = (TYPEOF(h.cleanaid))'',0,100));
    maxlength_cleanaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanaid)));
    avelength_cleanaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanaid)),h.cleanaid<>(typeof(h.cleanaid))'');
    populated_addresstype_cnt := COUNT(GROUP,h.addresstype <> (TYPEOF(h.addresstype))'');
    populated_addresstype_pcnt := AVE(GROUP,IF(h.addresstype = (TYPEOF(h.addresstype))'',0,100));
    maxlength_addresstype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addresstype)));
    avelength_addresstype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addresstype)),h.addresstype<>(typeof(h.addresstype))'');
    populated_Active_flag_cnt := COUNT(GROUP,h.Active_flag <> (TYPEOF(h.Active_flag))'');
    populated_Active_flag_pcnt := AVE(GROUP,IF(h.Active_flag = (TYPEOF(h.Active_flag))'',0,100));
    maxlength_Active_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Active_flag)));
    avelength_Active_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Active_flag)),h.Active_flag<>(typeof(h.Active_flag))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_ZIP_5_pcnt *   0.00 / 100 + T.Populated_Route_Num_pcnt *   0.00 / 100 + T.Populated_ZIP_4_pcnt *   0.00 / 100 + T.Populated_WALK_Sequence_pcnt *   0.00 / 100 + T.Populated_STREET_NUM_pcnt *   0.00 / 100 + T.Populated_STREET_PRE_DIRectional_pcnt *   0.00 / 100 + T.Populated_STREET_NAME_pcnt *   0.00 / 100 + T.Populated_STREET_POST_DIRectional_pcnt *   0.00 / 100 + T.Populated_STREET_SUFFIX_pcnt *   0.00 / 100 + T.Populated_Secondary_Unit_Designator_pcnt *   0.00 / 100 + T.Populated_Secondary_Unit_Number_pcnt *   0.00 / 100 + T.Populated_Address_Vacancy_Indicator_pcnt *   0.00 / 100 + T.Populated_Throw_Back_Indicator_pcnt *   0.00 / 100 + T.Populated_Seasonal_Delivery_Indicator_pcnt *   0.00 / 100 + T.Populated_Seasonal_Start_Suppression_Date_pcnt *   0.00 / 100 + T.Populated_Seasonal_End_Suppression_Date_pcnt *   0.00 / 100 + T.Populated_DND_Indicator_pcnt *   0.00 / 100 + T.Populated_College_Indicator_pcnt *   0.00 / 100 + T.Populated_College_Start_Suppression_Date_pcnt *   0.00 / 100 + T.Populated_College_End_Suppression_Date_pcnt *   0.00 / 100 + T.Populated_Address_Style_Flag_pcnt *   0.00 / 100 + T.Populated_Simplify_Address_Count_pcnt *   0.00 / 100 + T.Populated_Drop_Indicator_pcnt *   0.00 / 100 + T.Populated_Residential_or_Business_Ind_pcnt *   0.00 / 100 + T.Populated_DPBC_Digit_pcnt *   0.00 / 100 + T.Populated_DPBC_Check_Digit_pcnt *   0.00 / 100 + T.Populated_Update_Date_pcnt *   0.00 / 100 + T.Populated_File_Release_Date_pcnt *   0.00 / 100 + T.Populated_Override_file_release_date_pcnt *   0.00 / 100 + T.Populated_County_Num_pcnt *   0.00 / 100 + T.Populated_County_Name_pcnt *   0.00 / 100 + T.Populated_City_Name_pcnt *   0.00 / 100 + T.Populated_State_Code_pcnt *   0.00 / 100 + T.Populated_State_Num_pcnt *   0.00 / 100 + T.Populated_Congressional_District_Number_pcnt *   0.00 / 100 + T.Populated_OWGM_Indicator_pcnt *   0.00 / 100 + T.Populated_Record_Type_Code_pcnt *   0.00 / 100 + T.Populated_ADVO_Key_pcnt *   0.00 / 100 + T.Populated_Address_Type_pcnt *   0.00 / 100 + T.Populated_Mixed_Address_Usage_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_date_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_date_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_VAC_BEGDT_pcnt *   0.00 / 100 + T.Populated_VAC_ENDDT_pcnt *   0.00 / 100 + T.Populated_MONTHS_VAC_CURR_pcnt *   0.00 / 100 + T.Populated_MONTHS_VAC_MAX_pcnt *   0.00 / 100 + T.Populated_VAC_COUNT_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_RawAID_pcnt *   0.00 / 100 + T.Populated_cleanaid_pcnt *   0.00 / 100 + T.Populated_addresstype_pcnt *   0.00 / 100 + T.Populated_Active_flag_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'ZIP_5','Route_Num','ZIP_4','WALK_Sequence','STREET_NUM','STREET_PRE_DIRectional','STREET_NAME','STREET_POST_DIRectional','STREET_SUFFIX','Secondary_Unit_Designator','Secondary_Unit_Number','Address_Vacancy_Indicator','Throw_Back_Indicator','Seasonal_Delivery_Indicator','Seasonal_Start_Suppression_Date','Seasonal_End_Suppression_Date','DND_Indicator','College_Indicator','College_Start_Suppression_Date','College_End_Suppression_Date','Address_Style_Flag','Simplify_Address_Count','Drop_Indicator','Residential_or_Business_Ind','DPBC_Digit','DPBC_Check_Digit','Update_Date','File_Release_Date','Override_file_release_date','County_Num','County_Name','City_Name','State_Code','State_Num','Congressional_District_Number','OWGM_Indicator','Record_Type_Code','ADVO_Key','Address_Type','Mixed_Address_Usage','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','VAC_BEGDT','VAC_ENDDT','MONTHS_VAC_CURR','MONTHS_VAC_MAX','VAC_COUNT','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_county','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','RawAID','cleanaid','addresstype','Active_flag');
  SELF.populated_pcnt := CHOOSE(C,le.populated_ZIP_5_pcnt,le.populated_Route_Num_pcnt,le.populated_ZIP_4_pcnt,le.populated_WALK_Sequence_pcnt,le.populated_STREET_NUM_pcnt,le.populated_STREET_PRE_DIRectional_pcnt,le.populated_STREET_NAME_pcnt,le.populated_STREET_POST_DIRectional_pcnt,le.populated_STREET_SUFFIX_pcnt,le.populated_Secondary_Unit_Designator_pcnt,le.populated_Secondary_Unit_Number_pcnt,le.populated_Address_Vacancy_Indicator_pcnt,le.populated_Throw_Back_Indicator_pcnt,le.populated_Seasonal_Delivery_Indicator_pcnt,le.populated_Seasonal_Start_Suppression_Date_pcnt,le.populated_Seasonal_End_Suppression_Date_pcnt,le.populated_DND_Indicator_pcnt,le.populated_College_Indicator_pcnt,le.populated_College_Start_Suppression_Date_pcnt,le.populated_College_End_Suppression_Date_pcnt,le.populated_Address_Style_Flag_pcnt,le.populated_Simplify_Address_Count_pcnt,le.populated_Drop_Indicator_pcnt,le.populated_Residential_or_Business_Ind_pcnt,le.populated_DPBC_Digit_pcnt,le.populated_DPBC_Check_Digit_pcnt,le.populated_Update_Date_pcnt,le.populated_File_Release_Date_pcnt,le.populated_Override_file_release_date_pcnt,le.populated_County_Num_pcnt,le.populated_County_Name_pcnt,le.populated_City_Name_pcnt,le.populated_State_Code_pcnt,le.populated_State_Num_pcnt,le.populated_Congressional_District_Number_pcnt,le.populated_OWGM_Indicator_pcnt,le.populated_Record_Type_Code_pcnt,le.populated_ADVO_Key_pcnt,le.populated_Address_Type_pcnt,le.populated_Mixed_Address_Usage_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_date_vendor_first_reported_pcnt,le.populated_date_vendor_last_reported_pcnt,le.populated_VAC_BEGDT_pcnt,le.populated_VAC_ENDDT_pcnt,le.populated_MONTHS_VAC_CURR_pcnt,le.populated_MONTHS_VAC_MAX_pcnt,le.populated_VAC_COUNT_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_fips_county_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_RawAID_pcnt,le.populated_cleanaid_pcnt,le.populated_addresstype_pcnt,le.populated_Active_flag_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_ZIP_5,le.maxlength_Route_Num,le.maxlength_ZIP_4,le.maxlength_WALK_Sequence,le.maxlength_STREET_NUM,le.maxlength_STREET_PRE_DIRectional,le.maxlength_STREET_NAME,le.maxlength_STREET_POST_DIRectional,le.maxlength_STREET_SUFFIX,le.maxlength_Secondary_Unit_Designator,le.maxlength_Secondary_Unit_Number,le.maxlength_Address_Vacancy_Indicator,le.maxlength_Throw_Back_Indicator,le.maxlength_Seasonal_Delivery_Indicator,le.maxlength_Seasonal_Start_Suppression_Date,le.maxlength_Seasonal_End_Suppression_Date,le.maxlength_DND_Indicator,le.maxlength_College_Indicator,le.maxlength_College_Start_Suppression_Date,le.maxlength_College_End_Suppression_Date,le.maxlength_Address_Style_Flag,le.maxlength_Simplify_Address_Count,le.maxlength_Drop_Indicator,le.maxlength_Residential_or_Business_Ind,le.maxlength_DPBC_Digit,le.maxlength_DPBC_Check_Digit,le.maxlength_Update_Date,le.maxlength_File_Release_Date,le.maxlength_Override_file_release_date,le.maxlength_County_Num,le.maxlength_County_Name,le.maxlength_City_Name,le.maxlength_State_Code,le.maxlength_State_Num,le.maxlength_Congressional_District_Number,le.maxlength_OWGM_Indicator,le.maxlength_Record_Type_Code,le.maxlength_ADVO_Key,le.maxlength_Address_Type,le.maxlength_Mixed_Address_Usage,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_date_vendor_first_reported,le.maxlength_date_vendor_last_reported,le.maxlength_VAC_BEGDT,le.maxlength_VAC_ENDDT,le.maxlength_MONTHS_VAC_CURR,le.maxlength_MONTHS_VAC_MAX,le.maxlength_VAC_COUNT,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_fips_county,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_RawAID,le.maxlength_cleanaid,le.maxlength_addresstype,le.maxlength_Active_flag);
  SELF.avelength := CHOOSE(C,le.avelength_ZIP_5,le.avelength_Route_Num,le.avelength_ZIP_4,le.avelength_WALK_Sequence,le.avelength_STREET_NUM,le.avelength_STREET_PRE_DIRectional,le.avelength_STREET_NAME,le.avelength_STREET_POST_DIRectional,le.avelength_STREET_SUFFIX,le.avelength_Secondary_Unit_Designator,le.avelength_Secondary_Unit_Number,le.avelength_Address_Vacancy_Indicator,le.avelength_Throw_Back_Indicator,le.avelength_Seasonal_Delivery_Indicator,le.avelength_Seasonal_Start_Suppression_Date,le.avelength_Seasonal_End_Suppression_Date,le.avelength_DND_Indicator,le.avelength_College_Indicator,le.avelength_College_Start_Suppression_Date,le.avelength_College_End_Suppression_Date,le.avelength_Address_Style_Flag,le.avelength_Simplify_Address_Count,le.avelength_Drop_Indicator,le.avelength_Residential_or_Business_Ind,le.avelength_DPBC_Digit,le.avelength_DPBC_Check_Digit,le.avelength_Update_Date,le.avelength_File_Release_Date,le.avelength_Override_file_release_date,le.avelength_County_Num,le.avelength_County_Name,le.avelength_City_Name,le.avelength_State_Code,le.avelength_State_Num,le.avelength_Congressional_District_Number,le.avelength_OWGM_Indicator,le.avelength_Record_Type_Code,le.avelength_ADVO_Key,le.avelength_Address_Type,le.avelength_Mixed_Address_Usage,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_date_vendor_first_reported,le.avelength_date_vendor_last_reported,le.avelength_VAC_BEGDT,le.avelength_VAC_ENDDT,le.avelength_MONTHS_VAC_CURR,le.avelength_MONTHS_VAC_MAX,le.avelength_VAC_COUNT,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_fips_county,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_RawAID,le.avelength_cleanaid,le.avelength_addresstype,le.avelength_Active_flag);
END;
EXPORT invSummary := NORMALIZE(summary0, 80, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.ZIP_5),TRIM((SALT311.StrType)le.Route_Num),TRIM((SALT311.StrType)le.ZIP_4),TRIM((SALT311.StrType)le.WALK_Sequence),TRIM((SALT311.StrType)le.STREET_NUM),TRIM((SALT311.StrType)le.STREET_PRE_DIRectional),TRIM((SALT311.StrType)le.STREET_NAME),TRIM((SALT311.StrType)le.STREET_POST_DIRectional),TRIM((SALT311.StrType)le.STREET_SUFFIX),TRIM((SALT311.StrType)le.Secondary_Unit_Designator),TRIM((SALT311.StrType)le.Secondary_Unit_Number),TRIM((SALT311.StrType)le.Address_Vacancy_Indicator),TRIM((SALT311.StrType)le.Throw_Back_Indicator),TRIM((SALT311.StrType)le.Seasonal_Delivery_Indicator),TRIM((SALT311.StrType)le.Seasonal_Start_Suppression_Date),TRIM((SALT311.StrType)le.Seasonal_End_Suppression_Date),TRIM((SALT311.StrType)le.DND_Indicator),TRIM((SALT311.StrType)le.College_Indicator),TRIM((SALT311.StrType)le.College_Start_Suppression_Date),TRIM((SALT311.StrType)le.College_End_Suppression_Date),TRIM((SALT311.StrType)le.Address_Style_Flag),TRIM((SALT311.StrType)le.Simplify_Address_Count),TRIM((SALT311.StrType)le.Drop_Indicator),TRIM((SALT311.StrType)le.Residential_or_Business_Ind),TRIM((SALT311.StrType)le.DPBC_Digit),TRIM((SALT311.StrType)le.DPBC_Check_Digit),TRIM((SALT311.StrType)le.Update_Date),TRIM((SALT311.StrType)le.File_Release_Date),TRIM((SALT311.StrType)le.Override_file_release_date),TRIM((SALT311.StrType)le.County_Num),TRIM((SALT311.StrType)le.County_Name),TRIM((SALT311.StrType)le.City_Name),TRIM((SALT311.StrType)le.State_Code),TRIM((SALT311.StrType)le.State_Num),TRIM((SALT311.StrType)le.Congressional_District_Number),TRIM((SALT311.StrType)le.OWGM_Indicator),TRIM((SALT311.StrType)le.Record_Type_Code),TRIM((SALT311.StrType)le.ADVO_Key),TRIM((SALT311.StrType)le.Address_Type),TRIM((SALT311.StrType)le.Mixed_Address_Usage),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),TRIM((SALT311.StrType)le.date_vendor_first_reported),TRIM((SALT311.StrType)le.date_vendor_last_reported),TRIM((SALT311.StrType)le.VAC_BEGDT),TRIM((SALT311.StrType)le.VAC_ENDDT),TRIM((SALT311.StrType)le.MONTHS_VAC_CURR),TRIM((SALT311.StrType)le.MONTHS_VAC_MAX),TRIM((SALT311.StrType)le.VAC_COUNT),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),IF (le.RawAID <> 0,TRIM((SALT311.StrType)le.RawAID), ''),IF (le.cleanaid <> 0,TRIM((SALT311.StrType)le.cleanaid), ''),TRIM((SALT311.StrType)le.addresstype),TRIM((SALT311.StrType)le.Active_flag)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,80,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 80);
  SELF.FldNo2 := 1 + (C % 80);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.ZIP_5),TRIM((SALT311.StrType)le.Route_Num),TRIM((SALT311.StrType)le.ZIP_4),TRIM((SALT311.StrType)le.WALK_Sequence),TRIM((SALT311.StrType)le.STREET_NUM),TRIM((SALT311.StrType)le.STREET_PRE_DIRectional),TRIM((SALT311.StrType)le.STREET_NAME),TRIM((SALT311.StrType)le.STREET_POST_DIRectional),TRIM((SALT311.StrType)le.STREET_SUFFIX),TRIM((SALT311.StrType)le.Secondary_Unit_Designator),TRIM((SALT311.StrType)le.Secondary_Unit_Number),TRIM((SALT311.StrType)le.Address_Vacancy_Indicator),TRIM((SALT311.StrType)le.Throw_Back_Indicator),TRIM((SALT311.StrType)le.Seasonal_Delivery_Indicator),TRIM((SALT311.StrType)le.Seasonal_Start_Suppression_Date),TRIM((SALT311.StrType)le.Seasonal_End_Suppression_Date),TRIM((SALT311.StrType)le.DND_Indicator),TRIM((SALT311.StrType)le.College_Indicator),TRIM((SALT311.StrType)le.College_Start_Suppression_Date),TRIM((SALT311.StrType)le.College_End_Suppression_Date),TRIM((SALT311.StrType)le.Address_Style_Flag),TRIM((SALT311.StrType)le.Simplify_Address_Count),TRIM((SALT311.StrType)le.Drop_Indicator),TRIM((SALT311.StrType)le.Residential_or_Business_Ind),TRIM((SALT311.StrType)le.DPBC_Digit),TRIM((SALT311.StrType)le.DPBC_Check_Digit),TRIM((SALT311.StrType)le.Update_Date),TRIM((SALT311.StrType)le.File_Release_Date),TRIM((SALT311.StrType)le.Override_file_release_date),TRIM((SALT311.StrType)le.County_Num),TRIM((SALT311.StrType)le.County_Name),TRIM((SALT311.StrType)le.City_Name),TRIM((SALT311.StrType)le.State_Code),TRIM((SALT311.StrType)le.State_Num),TRIM((SALT311.StrType)le.Congressional_District_Number),TRIM((SALT311.StrType)le.OWGM_Indicator),TRIM((SALT311.StrType)le.Record_Type_Code),TRIM((SALT311.StrType)le.ADVO_Key),TRIM((SALT311.StrType)le.Address_Type),TRIM((SALT311.StrType)le.Mixed_Address_Usage),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),TRIM((SALT311.StrType)le.date_vendor_first_reported),TRIM((SALT311.StrType)le.date_vendor_last_reported),TRIM((SALT311.StrType)le.VAC_BEGDT),TRIM((SALT311.StrType)le.VAC_ENDDT),TRIM((SALT311.StrType)le.MONTHS_VAC_CURR),TRIM((SALT311.StrType)le.MONTHS_VAC_MAX),TRIM((SALT311.StrType)le.VAC_COUNT),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),IF (le.RawAID <> 0,TRIM((SALT311.StrType)le.RawAID), ''),IF (le.cleanaid <> 0,TRIM((SALT311.StrType)le.cleanaid), ''),TRIM((SALT311.StrType)le.addresstype),TRIM((SALT311.StrType)le.Active_flag)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.ZIP_5),TRIM((SALT311.StrType)le.Route_Num),TRIM((SALT311.StrType)le.ZIP_4),TRIM((SALT311.StrType)le.WALK_Sequence),TRIM((SALT311.StrType)le.STREET_NUM),TRIM((SALT311.StrType)le.STREET_PRE_DIRectional),TRIM((SALT311.StrType)le.STREET_NAME),TRIM((SALT311.StrType)le.STREET_POST_DIRectional),TRIM((SALT311.StrType)le.STREET_SUFFIX),TRIM((SALT311.StrType)le.Secondary_Unit_Designator),TRIM((SALT311.StrType)le.Secondary_Unit_Number),TRIM((SALT311.StrType)le.Address_Vacancy_Indicator),TRIM((SALT311.StrType)le.Throw_Back_Indicator),TRIM((SALT311.StrType)le.Seasonal_Delivery_Indicator),TRIM((SALT311.StrType)le.Seasonal_Start_Suppression_Date),TRIM((SALT311.StrType)le.Seasonal_End_Suppression_Date),TRIM((SALT311.StrType)le.DND_Indicator),TRIM((SALT311.StrType)le.College_Indicator),TRIM((SALT311.StrType)le.College_Start_Suppression_Date),TRIM((SALT311.StrType)le.College_End_Suppression_Date),TRIM((SALT311.StrType)le.Address_Style_Flag),TRIM((SALT311.StrType)le.Simplify_Address_Count),TRIM((SALT311.StrType)le.Drop_Indicator),TRIM((SALT311.StrType)le.Residential_or_Business_Ind),TRIM((SALT311.StrType)le.DPBC_Digit),TRIM((SALT311.StrType)le.DPBC_Check_Digit),TRIM((SALT311.StrType)le.Update_Date),TRIM((SALT311.StrType)le.File_Release_Date),TRIM((SALT311.StrType)le.Override_file_release_date),TRIM((SALT311.StrType)le.County_Num),TRIM((SALT311.StrType)le.County_Name),TRIM((SALT311.StrType)le.City_Name),TRIM((SALT311.StrType)le.State_Code),TRIM((SALT311.StrType)le.State_Num),TRIM((SALT311.StrType)le.Congressional_District_Number),TRIM((SALT311.StrType)le.OWGM_Indicator),TRIM((SALT311.StrType)le.Record_Type_Code),TRIM((SALT311.StrType)le.ADVO_Key),TRIM((SALT311.StrType)le.Address_Type),TRIM((SALT311.StrType)le.Mixed_Address_Usage),TRIM((SALT311.StrType)le.date_first_seen),TRIM((SALT311.StrType)le.date_last_seen),TRIM((SALT311.StrType)le.date_vendor_first_reported),TRIM((SALT311.StrType)le.date_vendor_last_reported),TRIM((SALT311.StrType)le.VAC_BEGDT),TRIM((SALT311.StrType)le.VAC_ENDDT),TRIM((SALT311.StrType)le.MONTHS_VAC_CURR),TRIM((SALT311.StrType)le.MONTHS_VAC_MAX),TRIM((SALT311.StrType)le.VAC_COUNT),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.fips_county),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),IF (le.RawAID <> 0,TRIM((SALT311.StrType)le.RawAID), ''),IF (le.cleanaid <> 0,TRIM((SALT311.StrType)le.cleanaid), ''),TRIM((SALT311.StrType)le.addresstype),TRIM((SALT311.StrType)le.Active_flag)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),80*80,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'ZIP_5'}
      ,{2,'Route_Num'}
      ,{3,'ZIP_4'}
      ,{4,'WALK_Sequence'}
      ,{5,'STREET_NUM'}
      ,{6,'STREET_PRE_DIRectional'}
      ,{7,'STREET_NAME'}
      ,{8,'STREET_POST_DIRectional'}
      ,{9,'STREET_SUFFIX'}
      ,{10,'Secondary_Unit_Designator'}
      ,{11,'Secondary_Unit_Number'}
      ,{12,'Address_Vacancy_Indicator'}
      ,{13,'Throw_Back_Indicator'}
      ,{14,'Seasonal_Delivery_Indicator'}
      ,{15,'Seasonal_Start_Suppression_Date'}
      ,{16,'Seasonal_End_Suppression_Date'}
      ,{17,'DND_Indicator'}
      ,{18,'College_Indicator'}
      ,{19,'College_Start_Suppression_Date'}
      ,{20,'College_End_Suppression_Date'}
      ,{21,'Address_Style_Flag'}
      ,{22,'Simplify_Address_Count'}
      ,{23,'Drop_Indicator'}
      ,{24,'Residential_or_Business_Ind'}
      ,{25,'DPBC_Digit'}
      ,{26,'DPBC_Check_Digit'}
      ,{27,'Update_Date'}
      ,{28,'File_Release_Date'}
      ,{29,'Override_file_release_date'}
      ,{30,'County_Num'}
      ,{31,'County_Name'}
      ,{32,'City_Name'}
      ,{33,'State_Code'}
      ,{34,'State_Num'}
      ,{35,'Congressional_District_Number'}
      ,{36,'OWGM_Indicator'}
      ,{37,'Record_Type_Code'}
      ,{38,'ADVO_Key'}
      ,{39,'Address_Type'}
      ,{40,'Mixed_Address_Usage'}
      ,{41,'date_first_seen'}
      ,{42,'date_last_seen'}
      ,{43,'date_vendor_first_reported'}
      ,{44,'date_vendor_last_reported'}
      ,{45,'VAC_BEGDT'}
      ,{46,'VAC_ENDDT'}
      ,{47,'MONTHS_VAC_CURR'}
      ,{48,'MONTHS_VAC_MAX'}
      ,{49,'VAC_COUNT'}
      ,{50,'prim_range'}
      ,{51,'predir'}
      ,{52,'prim_name'}
      ,{53,'addr_suffix'}
      ,{54,'postdir'}
      ,{55,'unit_desig'}
      ,{56,'sec_range'}
      ,{57,'p_city_name'}
      ,{58,'v_city_name'}
      ,{59,'st'}
      ,{60,'zip'}
      ,{61,'zip4'}
      ,{62,'cart'}
      ,{63,'cr_sort_sz'}
      ,{64,'lot'}
      ,{65,'lot_order'}
      ,{66,'dbpc'}
      ,{67,'chk_digit'}
      ,{68,'rec_type'}
      ,{69,'fips_county'}
      ,{70,'county'}
      ,{71,'geo_lat'}
      ,{72,'geo_long'}
      ,{73,'msa'}
      ,{74,'geo_blk'}
      ,{75,'geo_match'}
      ,{76,'err_stat'}
      ,{77,'RawAID'}
      ,{78,'cleanaid'}
      ,{79,'addresstype'}
      ,{80,'Active_flag'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_ZIP_5((SALT311.StrType)le.ZIP_5),
    Fields.InValid_Route_Num((SALT311.StrType)le.Route_Num),
    Fields.InValid_ZIP_4((SALT311.StrType)le.ZIP_4),
    Fields.InValid_WALK_Sequence((SALT311.StrType)le.WALK_Sequence),
    Fields.InValid_STREET_NUM((SALT311.StrType)le.STREET_NUM),
    Fields.InValid_STREET_PRE_DIRectional((SALT311.StrType)le.STREET_PRE_DIRectional),
    Fields.InValid_STREET_NAME((SALT311.StrType)le.STREET_NAME),
    Fields.InValid_STREET_POST_DIRectional((SALT311.StrType)le.STREET_POST_DIRectional),
    Fields.InValid_STREET_SUFFIX((SALT311.StrType)le.STREET_SUFFIX),
    Fields.InValid_Secondary_Unit_Designator((SALT311.StrType)le.Secondary_Unit_Designator),
    Fields.InValid_Secondary_Unit_Number((SALT311.StrType)le.Secondary_Unit_Number),
    Fields.InValid_Address_Vacancy_Indicator((SALT311.StrType)le.Address_Vacancy_Indicator),
    Fields.InValid_Throw_Back_Indicator((SALT311.StrType)le.Throw_Back_Indicator),
    Fields.InValid_Seasonal_Delivery_Indicator((SALT311.StrType)le.Seasonal_Delivery_Indicator),
    Fields.InValid_Seasonal_Start_Suppression_Date((SALT311.StrType)le.Seasonal_Start_Suppression_Date),
    Fields.InValid_Seasonal_End_Suppression_Date((SALT311.StrType)le.Seasonal_End_Suppression_Date),
    Fields.InValid_DND_Indicator((SALT311.StrType)le.DND_Indicator),
    Fields.InValid_College_Indicator((SALT311.StrType)le.College_Indicator),
    Fields.InValid_College_Start_Suppression_Date((SALT311.StrType)le.College_Start_Suppression_Date),
    Fields.InValid_College_End_Suppression_Date((SALT311.StrType)le.College_End_Suppression_Date),
    Fields.InValid_Address_Style_Flag((SALT311.StrType)le.Address_Style_Flag),
    Fields.InValid_Simplify_Address_Count((SALT311.StrType)le.Simplify_Address_Count),
    Fields.InValid_Drop_Indicator((SALT311.StrType)le.Drop_Indicator),
    Fields.InValid_Residential_or_Business_Ind((SALT311.StrType)le.Residential_or_Business_Ind),
    Fields.InValid_DPBC_Digit((SALT311.StrType)le.DPBC_Digit),
    Fields.InValid_DPBC_Check_Digit((SALT311.StrType)le.DPBC_Check_Digit),
    Fields.InValid_Update_Date((SALT311.StrType)le.Update_Date),
    Fields.InValid_File_Release_Date((SALT311.StrType)le.File_Release_Date),
    Fields.InValid_Override_file_release_date((SALT311.StrType)le.Override_file_release_date),
    Fields.InValid_County_Num((SALT311.StrType)le.County_Num),
    Fields.InValid_County_Name((SALT311.StrType)le.County_Name),
    Fields.InValid_City_Name((SALT311.StrType)le.City_Name),
    Fields.InValid_State_Code((SALT311.StrType)le.State_Code),
    Fields.InValid_State_Num((SALT311.StrType)le.State_Num),
    Fields.InValid_Congressional_District_Number((SALT311.StrType)le.Congressional_District_Number),
    Fields.InValid_OWGM_Indicator((SALT311.StrType)le.OWGM_Indicator),
    Fields.InValid_Record_Type_Code((SALT311.StrType)le.Record_Type_Code),
    Fields.InValid_ADVO_Key((SALT311.StrType)le.ADVO_Key),
    Fields.InValid_Address_Type((SALT311.StrType)le.Address_Type),
    Fields.InValid_Mixed_Address_Usage((SALT311.StrType)le.Mixed_Address_Usage),
    Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen),
    Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen),
    Fields.InValid_date_vendor_first_reported((SALT311.StrType)le.date_vendor_first_reported),
    Fields.InValid_date_vendor_last_reported((SALT311.StrType)le.date_vendor_last_reported),
    Fields.InValid_VAC_BEGDT((SALT311.StrType)le.VAC_BEGDT),
    Fields.InValid_VAC_ENDDT((SALT311.StrType)le.VAC_ENDDT),
    Fields.InValid_MONTHS_VAC_CURR((SALT311.StrType)le.MONTHS_VAC_CURR),
    Fields.InValid_MONTHS_VAC_MAX((SALT311.StrType)le.MONTHS_VAC_MAX),
    Fields.InValid_VAC_COUNT((SALT311.StrType)le.VAC_COUNT),
    Fields.InValid_prim_range((SALT311.StrType)le.prim_range),
    Fields.InValid_predir((SALT311.StrType)le.predir),
    Fields.InValid_prim_name((SALT311.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT311.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT311.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT311.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name),
    Fields.InValid_st((SALT311.StrType)le.st),
    Fields.InValid_zip((SALT311.StrType)le.zip),
    Fields.InValid_zip4((SALT311.StrType)le.zip4),
    Fields.InValid_cart((SALT311.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT311.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT311.StrType)le.lot),
    Fields.InValid_lot_order((SALT311.StrType)le.lot_order),
    Fields.InValid_dbpc((SALT311.StrType)le.dbpc),
    Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit),
    Fields.InValid_rec_type((SALT311.StrType)le.rec_type),
    Fields.InValid_fips_county((SALT311.StrType)le.fips_county),
    Fields.InValid_county((SALT311.StrType)le.county),
    Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT311.StrType)le.geo_long),
    Fields.InValid_msa((SALT311.StrType)le.msa),
    Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT311.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT311.StrType)le.err_stat),
    Fields.InValid_RawAID((SALT311.StrType)le.RawAID),
    Fields.InValid_cleanaid((SALT311.StrType)le.cleanaid),
    Fields.InValid_addresstype((SALT311.StrType)le.addresstype),
    Fields.InValid_Active_flag((SALT311.StrType)le.Active_flag),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,80,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_zip','invalid_route_num','invalid_zip','invalid_num','invalid_street','invalid_prepostdir','invalid_street','invalid_prepostdir','invalid_alpha','invalid_alpha','invalid_street','invalid_YN','invalid_YN','invalid_YNE','invalid_SupDate','invalid_SupDate','invalid_YN','invalid_YN','invalid_Dates','invalid_Dates','invalid_AddrStyleFlag','invalid_num','invalid_YNC','invalid_ResBusInd','invalid_num','invalid_num','invalid_Dates','invalid_Dates','invalid_Dates','invalid_num','invalid_street','invalid_street','invalid_alpha','invalid_num','invalid_cda','invalid_YN','invalid_RTC','invalid_num','invalid_addr_type','invalid_AddrUsg','invalid_Vacdate','invalid_Vacdate','invalid_Vacdate','invalid_Vacdate','invalid_Vacdate','invalid_Vacdate','invalid_Vacdate','invalid_Vacdate','invalid_Vacdate','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_addrtype','invalid_YN');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_ZIP_5(TotalErrors.ErrorNum),Fields.InValidMessage_Route_Num(TotalErrors.ErrorNum),Fields.InValidMessage_ZIP_4(TotalErrors.ErrorNum),Fields.InValidMessage_WALK_Sequence(TotalErrors.ErrorNum),Fields.InValidMessage_STREET_NUM(TotalErrors.ErrorNum),Fields.InValidMessage_STREET_PRE_DIRectional(TotalErrors.ErrorNum),Fields.InValidMessage_STREET_NAME(TotalErrors.ErrorNum),Fields.InValidMessage_STREET_POST_DIRectional(TotalErrors.ErrorNum),Fields.InValidMessage_STREET_SUFFIX(TotalErrors.ErrorNum),Fields.InValidMessage_Secondary_Unit_Designator(TotalErrors.ErrorNum),Fields.InValidMessage_Secondary_Unit_Number(TotalErrors.ErrorNum),Fields.InValidMessage_Address_Vacancy_Indicator(TotalErrors.ErrorNum),Fields.InValidMessage_Throw_Back_Indicator(TotalErrors.ErrorNum),Fields.InValidMessage_Seasonal_Delivery_Indicator(TotalErrors.ErrorNum),Fields.InValidMessage_Seasonal_Start_Suppression_Date(TotalErrors.ErrorNum),Fields.InValidMessage_Seasonal_End_Suppression_Date(TotalErrors.ErrorNum),Fields.InValidMessage_DND_Indicator(TotalErrors.ErrorNum),Fields.InValidMessage_College_Indicator(TotalErrors.ErrorNum),Fields.InValidMessage_College_Start_Suppression_Date(TotalErrors.ErrorNum),Fields.InValidMessage_College_End_Suppression_Date(TotalErrors.ErrorNum),Fields.InValidMessage_Address_Style_Flag(TotalErrors.ErrorNum),Fields.InValidMessage_Simplify_Address_Count(TotalErrors.ErrorNum),Fields.InValidMessage_Drop_Indicator(TotalErrors.ErrorNum),Fields.InValidMessage_Residential_or_Business_Ind(TotalErrors.ErrorNum),Fields.InValidMessage_DPBC_Digit(TotalErrors.ErrorNum),Fields.InValidMessage_DPBC_Check_Digit(TotalErrors.ErrorNum),Fields.InValidMessage_Update_Date(TotalErrors.ErrorNum),Fields.InValidMessage_File_Release_Date(TotalErrors.ErrorNum),Fields.InValidMessage_Override_file_release_date(TotalErrors.ErrorNum),Fields.InValidMessage_County_Num(TotalErrors.ErrorNum),Fields.InValidMessage_County_Name(TotalErrors.ErrorNum),Fields.InValidMessage_City_Name(TotalErrors.ErrorNum),Fields.InValidMessage_State_Code(TotalErrors.ErrorNum),Fields.InValidMessage_State_Num(TotalErrors.ErrorNum),Fields.InValidMessage_Congressional_District_Number(TotalErrors.ErrorNum),Fields.InValidMessage_OWGM_Indicator(TotalErrors.ErrorNum),Fields.InValidMessage_Record_Type_Code(TotalErrors.ErrorNum),Fields.InValidMessage_ADVO_Key(TotalErrors.ErrorNum),Fields.InValidMessage_Address_Type(TotalErrors.ErrorNum),Fields.InValidMessage_Mixed_Address_Usage(TotalErrors.ErrorNum),Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_VAC_BEGDT(TotalErrors.ErrorNum),Fields.InValidMessage_VAC_ENDDT(TotalErrors.ErrorNum),Fields.InValidMessage_MONTHS_VAC_CURR(TotalErrors.ErrorNum),Fields.InValidMessage_MONTHS_VAC_MAX(TotalErrors.ErrorNum),Fields.InValidMessage_VAC_COUNT(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_RawAID(TotalErrors.ErrorNum),Fields.InValidMessage_cleanaid(TotalErrors.ErrorNum),Fields.InValidMessage_addresstype(TotalErrors.ErrorNum),Fields.InValidMessage_Active_flag(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Advo, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
