IMPORT SALT37;
EXPORT Input_FL_Event_hygiene(dataset(Input_FL_Event_layout_FBNV2) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT37.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_action_OWN_name_pcnt := AVE(GROUP,IF(h.action_OWN_name = (TYPEOF(h.action_OWN_name))'',0,100));
    maxlength_action_OWN_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.action_OWN_name)));
    avelength_action_OWN_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.action_OWN_name)),h.action_OWN_name<>(typeof(h.action_OWN_name))'');
    populated_event_date_pcnt := AVE(GROUP,IF(h.event_date = (TYPEOF(h.event_date))'',0,100));
    maxlength_event_date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.event_date)));
    avelength_event_date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.event_date)),h.event_date<>(typeof(h.event_date))'');
    populated_event_doc_number_pcnt := AVE(GROUP,IF(h.event_doc_number = (TYPEOF(h.event_doc_number))'',0,100));
    maxlength_event_doc_number := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.event_doc_number)));
    avelength_event_doc_number := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.event_doc_number)),h.event_doc_number<>(typeof(h.event_doc_number))'');
    populated_event_orig_doc_number_pcnt := AVE(GROUP,IF(h.event_orig_doc_number = (TYPEOF(h.event_orig_doc_number))'',0,100));
    maxlength_event_orig_doc_number := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.event_orig_doc_number)));
    avelength_event_orig_doc_number := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.event_orig_doc_number)),h.event_orig_doc_number<>(typeof(h.event_orig_doc_number))'');
    populated_prep_old_addr_line1_pcnt := AVE(GROUP,IF(h.prep_old_addr_line1 = (TYPEOF(h.prep_old_addr_line1))'',0,100));
    maxlength_prep_old_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_old_addr_line1)));
    avelength_prep_old_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_old_addr_line1)),h.prep_old_addr_line1<>(typeof(h.prep_old_addr_line1))'');
    populated_prep_old_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_old_addr_line_last = (TYPEOF(h.prep_old_addr_line_last))'',0,100));
    maxlength_prep_old_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_old_addr_line_last)));
    avelength_prep_old_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_old_addr_line_last)),h.prep_old_addr_line_last<>(typeof(h.prep_old_addr_line_last))'');
    populated_prep_new_addr_line1_pcnt := AVE(GROUP,IF(h.prep_new_addr_line1 = (TYPEOF(h.prep_new_addr_line1))'',0,100));
    maxlength_prep_new_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_new_addr_line1)));
    avelength_prep_new_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_new_addr_line1)),h.prep_new_addr_line1<>(typeof(h.prep_new_addr_line1))'');
    populated_prep_new_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_new_addr_line_last = (TYPEOF(h.prep_new_addr_line_last))'',0,100));
    maxlength_prep_new_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_new_addr_line_last)));
    avelength_prep_new_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_new_addr_line_last)),h.prep_new_addr_line_last<>(typeof(h.prep_new_addr_line_last))'');
    populated_prep_owner_addr_line1_pcnt := AVE(GROUP,IF(h.prep_owner_addr_line1 = (TYPEOF(h.prep_owner_addr_line1))'',0,100));
    maxlength_prep_owner_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line1)));
    avelength_prep_owner_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line1)),h.prep_owner_addr_line1<>(typeof(h.prep_owner_addr_line1))'');
    populated_prep_owner_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_owner_addr_line_last = (TYPEOF(h.prep_owner_addr_line_last))'',0,100));
    maxlength_prep_owner_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line_last)));
    avelength_prep_owner_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line_last)),h.prep_owner_addr_line_last<>(typeof(h.prep_owner_addr_line_last))'');
    populated_EVENT_FIC_NAME_pcnt := AVE(GROUP,IF(h.EVENT_FIC_NAME = (TYPEOF(h.EVENT_FIC_NAME))'',0,100));
    maxlength_EVENT_FIC_NAME := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EVENT_FIC_NAME)));
    avelength_EVENT_FIC_NAME := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EVENT_FIC_NAME)),h.EVENT_FIC_NAME<>(typeof(h.EVENT_FIC_NAME))'');
    populated_EVENT_ACTION_CTR_pcnt := AVE(GROUP,IF(h.EVENT_ACTION_CTR = (TYPEOF(h.EVENT_ACTION_CTR))'',0,100));
    maxlength_EVENT_ACTION_CTR := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EVENT_ACTION_CTR)));
    avelength_EVENT_ACTION_CTR := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EVENT_ACTION_CTR)),h.EVENT_ACTION_CTR<>(typeof(h.EVENT_ACTION_CTR))'');
    populated_EVENT_SEQ_NUMBER_pcnt := AVE(GROUP,IF(h.EVENT_SEQ_NUMBER = (TYPEOF(h.EVENT_SEQ_NUMBER))'',0,100));
    maxlength_EVENT_SEQ_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EVENT_SEQ_NUMBER)));
    avelength_EVENT_SEQ_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EVENT_SEQ_NUMBER)),h.EVENT_SEQ_NUMBER<>(typeof(h.EVENT_SEQ_NUMBER))'');
    populated_EVENT_PAGES_pcnt := AVE(GROUP,IF(h.EVENT_PAGES = (TYPEOF(h.EVENT_PAGES))'',0,100));
    maxlength_EVENT_PAGES := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.EVENT_PAGES)));
    avelength_EVENT_PAGES := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.EVENT_PAGES)),h.EVENT_PAGES<>(typeof(h.EVENT_PAGES))'');
    populated_ACTION_SEQ_NUMBER_pcnt := AVE(GROUP,IF(h.ACTION_SEQ_NUMBER = (TYPEOF(h.ACTION_SEQ_NUMBER))'',0,100));
    maxlength_ACTION_SEQ_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_SEQ_NUMBER)));
    avelength_ACTION_SEQ_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_SEQ_NUMBER)),h.ACTION_SEQ_NUMBER<>(typeof(h.ACTION_SEQ_NUMBER))'');
    populated_ACTION_CODE_pcnt := AVE(GROUP,IF(h.ACTION_CODE = (TYPEOF(h.ACTION_CODE))'',0,100));
    maxlength_ACTION_CODE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_CODE)));
    avelength_ACTION_CODE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_CODE)),h.ACTION_CODE<>(typeof(h.ACTION_CODE))'');
    populated_ACTION_VERBAGE_pcnt := AVE(GROUP,IF(h.ACTION_VERBAGE = (TYPEOF(h.ACTION_VERBAGE))'',0,100));
    maxlength_ACTION_VERBAGE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_VERBAGE)));
    avelength_ACTION_VERBAGE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_VERBAGE)),h.ACTION_VERBAGE<>(typeof(h.ACTION_VERBAGE))'');
    populated_ACTION_OLD_FEI_pcnt := AVE(GROUP,IF(h.ACTION_OLD_FEI = (TYPEOF(h.ACTION_OLD_FEI))'',0,100));
    maxlength_ACTION_OLD_FEI := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OLD_FEI)));
    avelength_ACTION_OLD_FEI := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OLD_FEI)),h.ACTION_OLD_FEI<>(typeof(h.ACTION_OLD_FEI))'');
    populated_ACTION_OLD_COUNTY_pcnt := AVE(GROUP,IF(h.ACTION_OLD_COUNTY = (TYPEOF(h.ACTION_OLD_COUNTY))'',0,100));
    maxlength_ACTION_OLD_COUNTY := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OLD_COUNTY)));
    avelength_ACTION_OLD_COUNTY := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OLD_COUNTY)),h.ACTION_OLD_COUNTY<>(typeof(h.ACTION_OLD_COUNTY))'');
    populated_ACTION_OLD_ADDR1_pcnt := AVE(GROUP,IF(h.ACTION_OLD_ADDR1 = (TYPEOF(h.ACTION_OLD_ADDR1))'',0,100));
    maxlength_ACTION_OLD_ADDR1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OLD_ADDR1)));
    avelength_ACTION_OLD_ADDR1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OLD_ADDR1)),h.ACTION_OLD_ADDR1<>(typeof(h.ACTION_OLD_ADDR1))'');
    populated_ACTION_OLD_ADDR2_pcnt := AVE(GROUP,IF(h.ACTION_OLD_ADDR2 = (TYPEOF(h.ACTION_OLD_ADDR2))'',0,100));
    maxlength_ACTION_OLD_ADDR2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OLD_ADDR2)));
    avelength_ACTION_OLD_ADDR2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OLD_ADDR2)),h.ACTION_OLD_ADDR2<>(typeof(h.ACTION_OLD_ADDR2))'');
    populated_ACTION_OLD_CITY_pcnt := AVE(GROUP,IF(h.ACTION_OLD_CITY = (TYPEOF(h.ACTION_OLD_CITY))'',0,100));
    maxlength_ACTION_OLD_CITY := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OLD_CITY)));
    avelength_ACTION_OLD_CITY := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OLD_CITY)),h.ACTION_OLD_CITY<>(typeof(h.ACTION_OLD_CITY))'');
    populated_ACTION_OLD_STATE_pcnt := AVE(GROUP,IF(h.ACTION_OLD_STATE = (TYPEOF(h.ACTION_OLD_STATE))'',0,100));
    maxlength_ACTION_OLD_STATE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OLD_STATE)));
    avelength_ACTION_OLD_STATE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OLD_STATE)),h.ACTION_OLD_STATE<>(typeof(h.ACTION_OLD_STATE))'');
    populated_ACTION_OLD_ZIP5_pcnt := AVE(GROUP,IF(h.ACTION_OLD_ZIP5 = (TYPEOF(h.ACTION_OLD_ZIP5))'',0,100));
    maxlength_ACTION_OLD_ZIP5 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OLD_ZIP5)));
    avelength_ACTION_OLD_ZIP5 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OLD_ZIP5)),h.ACTION_OLD_ZIP5<>(typeof(h.ACTION_OLD_ZIP5))'');
    populated_ACTION_OLD_ZIP4_pcnt := AVE(GROUP,IF(h.ACTION_OLD_ZIP4 = (TYPEOF(h.ACTION_OLD_ZIP4))'',0,100));
    maxlength_ACTION_OLD_ZIP4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OLD_ZIP4)));
    avelength_ACTION_OLD_ZIP4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OLD_ZIP4)),h.ACTION_OLD_ZIP4<>(typeof(h.ACTION_OLD_ZIP4))'');
    populated_ACTION_OLD_COUNTRY_pcnt := AVE(GROUP,IF(h.ACTION_OLD_COUNTRY = (TYPEOF(h.ACTION_OLD_COUNTRY))'',0,100));
    maxlength_ACTION_OLD_COUNTRY := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OLD_COUNTRY)));
    avelength_ACTION_OLD_COUNTRY := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OLD_COUNTRY)),h.ACTION_OLD_COUNTRY<>(typeof(h.ACTION_OLD_COUNTRY))'');
    populated_ACTION_OLD_COUNTRY_DESC_pcnt := AVE(GROUP,IF(h.ACTION_OLD_COUNTRY_DESC = (TYPEOF(h.ACTION_OLD_COUNTRY_DESC))'',0,100));
    maxlength_ACTION_OLD_COUNTRY_DESC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OLD_COUNTRY_DESC)));
    avelength_ACTION_OLD_COUNTRY_DESC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OLD_COUNTRY_DESC)),h.ACTION_OLD_COUNTRY_DESC<>(typeof(h.ACTION_OLD_COUNTRY_DESC))'');
    populated_ACTION_NEW_FEI_pcnt := AVE(GROUP,IF(h.ACTION_NEW_FEI = (TYPEOF(h.ACTION_NEW_FEI))'',0,100));
    maxlength_ACTION_NEW_FEI := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_NEW_FEI)));
    avelength_ACTION_NEW_FEI := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_NEW_FEI)),h.ACTION_NEW_FEI<>(typeof(h.ACTION_NEW_FEI))'');
    populated_ACTION_NEW_COUNTY_pcnt := AVE(GROUP,IF(h.ACTION_NEW_COUNTY = (TYPEOF(h.ACTION_NEW_COUNTY))'',0,100));
    maxlength_ACTION_NEW_COUNTY := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_NEW_COUNTY)));
    avelength_ACTION_NEW_COUNTY := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_NEW_COUNTY)),h.ACTION_NEW_COUNTY<>(typeof(h.ACTION_NEW_COUNTY))'');
    populated_ACTION_NEW_ADDR1_pcnt := AVE(GROUP,IF(h.ACTION_NEW_ADDR1 = (TYPEOF(h.ACTION_NEW_ADDR1))'',0,100));
    maxlength_ACTION_NEW_ADDR1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_NEW_ADDR1)));
    avelength_ACTION_NEW_ADDR1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_NEW_ADDR1)),h.ACTION_NEW_ADDR1<>(typeof(h.ACTION_NEW_ADDR1))'');
    populated_ACTION_NEW_ADDR2_pcnt := AVE(GROUP,IF(h.ACTION_NEW_ADDR2 = (TYPEOF(h.ACTION_NEW_ADDR2))'',0,100));
    maxlength_ACTION_NEW_ADDR2 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_NEW_ADDR2)));
    avelength_ACTION_NEW_ADDR2 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_NEW_ADDR2)),h.ACTION_NEW_ADDR2<>(typeof(h.ACTION_NEW_ADDR2))'');
    populated_ACTION_NEW_CITY_pcnt := AVE(GROUP,IF(h.ACTION_NEW_CITY = (TYPEOF(h.ACTION_NEW_CITY))'',0,100));
    maxlength_ACTION_NEW_CITY := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_NEW_CITY)));
    avelength_ACTION_NEW_CITY := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_NEW_CITY)),h.ACTION_NEW_CITY<>(typeof(h.ACTION_NEW_CITY))'');
    populated_ACTION_NEW_STATE_pcnt := AVE(GROUP,IF(h.ACTION_NEW_STATE = (TYPEOF(h.ACTION_NEW_STATE))'',0,100));
    maxlength_ACTION_NEW_STATE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_NEW_STATE)));
    avelength_ACTION_NEW_STATE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_NEW_STATE)),h.ACTION_NEW_STATE<>(typeof(h.ACTION_NEW_STATE))'');
    populated_ACTION_NEW_ZIP5_pcnt := AVE(GROUP,IF(h.ACTION_NEW_ZIP5 = (TYPEOF(h.ACTION_NEW_ZIP5))'',0,100));
    maxlength_ACTION_NEW_ZIP5 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_NEW_ZIP5)));
    avelength_ACTION_NEW_ZIP5 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_NEW_ZIP5)),h.ACTION_NEW_ZIP5<>(typeof(h.ACTION_NEW_ZIP5))'');
    populated_ACTION_NEW_ZIP4_pcnt := AVE(GROUP,IF(h.ACTION_NEW_ZIP4 = (TYPEOF(h.ACTION_NEW_ZIP4))'',0,100));
    maxlength_ACTION_NEW_ZIP4 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_NEW_ZIP4)));
    avelength_ACTION_NEW_ZIP4 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_NEW_ZIP4)),h.ACTION_NEW_ZIP4<>(typeof(h.ACTION_NEW_ZIP4))'');
    populated_ACTION_NEW_COUNTRY_pcnt := AVE(GROUP,IF(h.ACTION_NEW_COUNTRY = (TYPEOF(h.ACTION_NEW_COUNTRY))'',0,100));
    maxlength_ACTION_NEW_COUNTRY := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_NEW_COUNTRY)));
    avelength_ACTION_NEW_COUNTRY := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_NEW_COUNTRY)),h.ACTION_NEW_COUNTRY<>(typeof(h.ACTION_NEW_COUNTRY))'');
    populated_ACTION_NEW_COUNTRY_DESC_pcnt := AVE(GROUP,IF(h.ACTION_NEW_COUNTRY_DESC = (TYPEOF(h.ACTION_NEW_COUNTRY_DESC))'',0,100));
    maxlength_ACTION_NEW_COUNTRY_DESC := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_NEW_COUNTRY_DESC)));
    avelength_ACTION_NEW_COUNTRY_DESC := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_NEW_COUNTRY_DESC)),h.ACTION_NEW_COUNTRY_DESC<>(typeof(h.ACTION_NEW_COUNTRY_DESC))'');
    populated_ACTION_OWN_ADDRESS_pcnt := AVE(GROUP,IF(h.ACTION_OWN_ADDRESS = (TYPEOF(h.ACTION_OWN_ADDRESS))'',0,100));
    maxlength_ACTION_OWN_ADDRESS := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OWN_ADDRESS)));
    avelength_ACTION_OWN_ADDRESS := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OWN_ADDRESS)),h.ACTION_OWN_ADDRESS<>(typeof(h.ACTION_OWN_ADDRESS))'');
    populated_ACTION_OWN_CITY_pcnt := AVE(GROUP,IF(h.ACTION_OWN_CITY = (TYPEOF(h.ACTION_OWN_CITY))'',0,100));
    maxlength_ACTION_OWN_CITY := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OWN_CITY)));
    avelength_ACTION_OWN_CITY := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OWN_CITY)),h.ACTION_OWN_CITY<>(typeof(h.ACTION_OWN_CITY))'');
    populated_ACTION_OWN_STATE_pcnt := AVE(GROUP,IF(h.ACTION_OWN_STATE = (TYPEOF(h.ACTION_OWN_STATE))'',0,100));
    maxlength_ACTION_OWN_STATE := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OWN_STATE)));
    avelength_ACTION_OWN_STATE := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OWN_STATE)),h.ACTION_OWN_STATE<>(typeof(h.ACTION_OWN_STATE))'');
    populated_ACTION_OWN_ZIP5_pcnt := AVE(GROUP,IF(h.ACTION_OWN_ZIP5 = (TYPEOF(h.ACTION_OWN_ZIP5))'',0,100));
    maxlength_ACTION_OWN_ZIP5 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OWN_ZIP5)));
    avelength_ACTION_OWN_ZIP5 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OWN_ZIP5)),h.ACTION_OWN_ZIP5<>(typeof(h.ACTION_OWN_ZIP5))'');
    populated_ACTION_OWN_FEI_pcnt := AVE(GROUP,IF(h.ACTION_OWN_FEI = (TYPEOF(h.ACTION_OWN_FEI))'',0,100));
    maxlength_ACTION_OWN_FEI := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OWN_FEI)));
    avelength_ACTION_OWN_FEI := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OWN_FEI)),h.ACTION_OWN_FEI<>(typeof(h.ACTION_OWN_FEI))'');
    populated_ACTION_OWN_CHARTER_NUMBER_pcnt := AVE(GROUP,IF(h.ACTION_OWN_CHARTER_NUMBER = (TYPEOF(h.ACTION_OWN_CHARTER_NUMBER))'',0,100));
    maxlength_ACTION_OWN_CHARTER_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OWN_CHARTER_NUMBER)));
    avelength_ACTION_OWN_CHARTER_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OWN_CHARTER_NUMBER)),h.ACTION_OWN_CHARTER_NUMBER<>(typeof(h.ACTION_OWN_CHARTER_NUMBER))'');
    populated_ACTION_OLD_NAME_SEQ_pcnt := AVE(GROUP,IF(h.ACTION_OLD_NAME_SEQ = (TYPEOF(h.ACTION_OLD_NAME_SEQ))'',0,100));
    maxlength_ACTION_OLD_NAME_SEQ := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OLD_NAME_SEQ)));
    avelength_ACTION_OLD_NAME_SEQ := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_OLD_NAME_SEQ)),h.ACTION_OLD_NAME_SEQ<>(typeof(h.ACTION_OLD_NAME_SEQ))'');
    populated_ACTION_NEW_NAME_SEQ_pcnt := AVE(GROUP,IF(h.ACTION_NEW_NAME_SEQ = (TYPEOF(h.ACTION_NEW_NAME_SEQ))'',0,100));
    maxlength_ACTION_NEW_NAME_SEQ := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_NEW_NAME_SEQ)));
    avelength_ACTION_NEW_NAME_SEQ := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.ACTION_NEW_NAME_SEQ)),h.ACTION_NEW_NAME_SEQ<>(typeof(h.ACTION_NEW_NAME_SEQ))'');
    populated_Owner_title_pcnt := AVE(GROUP,IF(h.Owner_title = (TYPEOF(h.Owner_title))'',0,100));
    maxlength_Owner_title := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_title)));
    avelength_Owner_title := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_title)),h.Owner_title<>(typeof(h.Owner_title))'');
    populated_Owner_fname_pcnt := AVE(GROUP,IF(h.Owner_fname = (TYPEOF(h.Owner_fname))'',0,100));
    maxlength_Owner_fname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_fname)));
    avelength_Owner_fname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_fname)),h.Owner_fname<>(typeof(h.Owner_fname))'');
    populated_Owner_mname_pcnt := AVE(GROUP,IF(h.Owner_mname = (TYPEOF(h.Owner_mname))'',0,100));
    maxlength_Owner_mname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_mname)));
    avelength_Owner_mname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_mname)),h.Owner_mname<>(typeof(h.Owner_mname))'');
    populated_Owner_lname_pcnt := AVE(GROUP,IF(h.Owner_lname = (TYPEOF(h.Owner_lname))'',0,100));
    maxlength_Owner_lname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_lname)));
    avelength_Owner_lname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_lname)),h.Owner_lname<>(typeof(h.Owner_lname))'');
    populated_Owner_name_suffix_pcnt := AVE(GROUP,IF(h.Owner_name_suffix = (TYPEOF(h.Owner_name_suffix))'',0,100));
    maxlength_Owner_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_name_suffix)));
    avelength_Owner_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_name_suffix)),h.Owner_name_suffix<>(typeof(h.Owner_name_suffix))'');
    populated_Owner_name_score_pcnt := AVE(GROUP,IF(h.Owner_name_score = (TYPEOF(h.Owner_name_score))'',0,100));
    maxlength_Owner_name_score := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_name_score)));
    avelength_Owner_name_score := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.Owner_name_score)),h.Owner_name_score<>(typeof(h.Owner_name_score))'');
    populated_cname_pcnt := AVE(GROUP,IF(h.cname = (TYPEOF(h.cname))'',0,100));
    maxlength_cname := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.cname)));
    avelength_cname := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.cname)),h.cname<>(typeof(h.cname))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_action_OWN_name_pcnt *   0.00 / 100 + T.Populated_event_date_pcnt *   0.00 / 100 + T.Populated_event_doc_number_pcnt *   0.00 / 100 + T.Populated_event_orig_doc_number_pcnt *   0.00 / 100 + T.Populated_prep_old_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_old_addr_line_last_pcnt *   0.00 / 100 + T.Populated_prep_new_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_new_addr_line_last_pcnt *   0.00 / 100 + T.Populated_prep_owner_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_owner_addr_line_last_pcnt *   0.00 / 100 + T.Populated_EVENT_FIC_NAME_pcnt *   0.00 / 100 + T.Populated_EVENT_ACTION_CTR_pcnt *   0.00 / 100 + T.Populated_EVENT_SEQ_NUMBER_pcnt *   0.00 / 100 + T.Populated_EVENT_PAGES_pcnt *   0.00 / 100 + T.Populated_ACTION_SEQ_NUMBER_pcnt *   0.00 / 100 + T.Populated_ACTION_CODE_pcnt *   0.00 / 100 + T.Populated_ACTION_VERBAGE_pcnt *   0.00 / 100 + T.Populated_ACTION_OLD_FEI_pcnt *   0.00 / 100 + T.Populated_ACTION_OLD_COUNTY_pcnt *   0.00 / 100 + T.Populated_ACTION_OLD_ADDR1_pcnt *   0.00 / 100 + T.Populated_ACTION_OLD_ADDR2_pcnt *   0.00 / 100 + T.Populated_ACTION_OLD_CITY_pcnt *   0.00 / 100 + T.Populated_ACTION_OLD_STATE_pcnt *   0.00 / 100 + T.Populated_ACTION_OLD_ZIP5_pcnt *   0.00 / 100 + T.Populated_ACTION_OLD_ZIP4_pcnt *   0.00 / 100 + T.Populated_ACTION_OLD_COUNTRY_pcnt *   0.00 / 100 + T.Populated_ACTION_OLD_COUNTRY_DESC_pcnt *   0.00 / 100 + T.Populated_ACTION_NEW_FEI_pcnt *   0.00 / 100 + T.Populated_ACTION_NEW_COUNTY_pcnt *   0.00 / 100 + T.Populated_ACTION_NEW_ADDR1_pcnt *   0.00 / 100 + T.Populated_ACTION_NEW_ADDR2_pcnt *   0.00 / 100 + T.Populated_ACTION_NEW_CITY_pcnt *   0.00 / 100 + T.Populated_ACTION_NEW_STATE_pcnt *   0.00 / 100 + T.Populated_ACTION_NEW_ZIP5_pcnt *   0.00 / 100 + T.Populated_ACTION_NEW_ZIP4_pcnt *   0.00 / 100 + T.Populated_ACTION_NEW_COUNTRY_pcnt *   0.00 / 100 + T.Populated_ACTION_NEW_COUNTRY_DESC_pcnt *   0.00 / 100 + T.Populated_ACTION_OWN_ADDRESS_pcnt *   0.00 / 100 + T.Populated_ACTION_OWN_CITY_pcnt *   0.00 / 100 + T.Populated_ACTION_OWN_STATE_pcnt *   0.00 / 100 + T.Populated_ACTION_OWN_ZIP5_pcnt *   0.00 / 100 + T.Populated_ACTION_OWN_FEI_pcnt *   0.00 / 100 + T.Populated_ACTION_OWN_CHARTER_NUMBER_pcnt *   0.00 / 100 + T.Populated_ACTION_OLD_NAME_SEQ_pcnt *   0.00 / 100 + T.Populated_ACTION_NEW_NAME_SEQ_pcnt *   0.00 / 100 + T.Populated_Owner_title_pcnt *   0.00 / 100 + T.Populated_Owner_fname_pcnt *   0.00 / 100 + T.Populated_Owner_mname_pcnt *   0.00 / 100 + T.Populated_Owner_lname_pcnt *   0.00 / 100 + T.Populated_Owner_name_suffix_pcnt *   0.00 / 100 + T.Populated_Owner_name_score_pcnt *   0.00 / 100 + T.Populated_cname_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT37.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'action_OWN_name','event_date','event_doc_number','event_orig_doc_number','prep_old_addr_line1','prep_old_addr_line_last','prep_new_addr_line1','prep_new_addr_line_last','prep_owner_addr_line1','prep_owner_addr_line_last','EVENT_FIC_NAME','EVENT_ACTION_CTR','EVENT_SEQ_NUMBER','EVENT_PAGES','ACTION_SEQ_NUMBER','ACTION_CODE','ACTION_VERBAGE','ACTION_OLD_FEI','ACTION_OLD_COUNTY','ACTION_OLD_ADDR1','ACTION_OLD_ADDR2','ACTION_OLD_CITY','ACTION_OLD_STATE','ACTION_OLD_ZIP5','ACTION_OLD_ZIP4','ACTION_OLD_COUNTRY','ACTION_OLD_COUNTRY_DESC','ACTION_NEW_FEI','ACTION_NEW_COUNTY','ACTION_NEW_ADDR1','ACTION_NEW_ADDR2','ACTION_NEW_CITY','ACTION_NEW_STATE','ACTION_NEW_ZIP5','ACTION_NEW_ZIP4','ACTION_NEW_COUNTRY','ACTION_NEW_COUNTRY_DESC','ACTION_OWN_ADDRESS','ACTION_OWN_CITY','ACTION_OWN_STATE','ACTION_OWN_ZIP5','ACTION_OWN_FEI','ACTION_OWN_CHARTER_NUMBER','ACTION_OLD_NAME_SEQ','ACTION_NEW_NAME_SEQ','Owner_title','Owner_fname','Owner_mname','Owner_lname','Owner_name_suffix','Owner_name_score','cname');
  SELF.populated_pcnt := CHOOSE(C,le.populated_action_OWN_name_pcnt,le.populated_event_date_pcnt,le.populated_event_doc_number_pcnt,le.populated_event_orig_doc_number_pcnt,le.populated_prep_old_addr_line1_pcnt,le.populated_prep_old_addr_line_last_pcnt,le.populated_prep_new_addr_line1_pcnt,le.populated_prep_new_addr_line_last_pcnt,le.populated_prep_owner_addr_line1_pcnt,le.populated_prep_owner_addr_line_last_pcnt,le.populated_EVENT_FIC_NAME_pcnt,le.populated_EVENT_ACTION_CTR_pcnt,le.populated_EVENT_SEQ_NUMBER_pcnt,le.populated_EVENT_PAGES_pcnt,le.populated_ACTION_SEQ_NUMBER_pcnt,le.populated_ACTION_CODE_pcnt,le.populated_ACTION_VERBAGE_pcnt,le.populated_ACTION_OLD_FEI_pcnt,le.populated_ACTION_OLD_COUNTY_pcnt,le.populated_ACTION_OLD_ADDR1_pcnt,le.populated_ACTION_OLD_ADDR2_pcnt,le.populated_ACTION_OLD_CITY_pcnt,le.populated_ACTION_OLD_STATE_pcnt,le.populated_ACTION_OLD_ZIP5_pcnt,le.populated_ACTION_OLD_ZIP4_pcnt,le.populated_ACTION_OLD_COUNTRY_pcnt,le.populated_ACTION_OLD_COUNTRY_DESC_pcnt,le.populated_ACTION_NEW_FEI_pcnt,le.populated_ACTION_NEW_COUNTY_pcnt,le.populated_ACTION_NEW_ADDR1_pcnt,le.populated_ACTION_NEW_ADDR2_pcnt,le.populated_ACTION_NEW_CITY_pcnt,le.populated_ACTION_NEW_STATE_pcnt,le.populated_ACTION_NEW_ZIP5_pcnt,le.populated_ACTION_NEW_ZIP4_pcnt,le.populated_ACTION_NEW_COUNTRY_pcnt,le.populated_ACTION_NEW_COUNTRY_DESC_pcnt,le.populated_ACTION_OWN_ADDRESS_pcnt,le.populated_ACTION_OWN_CITY_pcnt,le.populated_ACTION_OWN_STATE_pcnt,le.populated_ACTION_OWN_ZIP5_pcnt,le.populated_ACTION_OWN_FEI_pcnt,le.populated_ACTION_OWN_CHARTER_NUMBER_pcnt,le.populated_ACTION_OLD_NAME_SEQ_pcnt,le.populated_ACTION_NEW_NAME_SEQ_pcnt,le.populated_Owner_title_pcnt,le.populated_Owner_fname_pcnt,le.populated_Owner_mname_pcnt,le.populated_Owner_lname_pcnt,le.populated_Owner_name_suffix_pcnt,le.populated_Owner_name_score_pcnt,le.populated_cname_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_action_OWN_name,le.maxlength_event_date,le.maxlength_event_doc_number,le.maxlength_event_orig_doc_number,le.maxlength_prep_old_addr_line1,le.maxlength_prep_old_addr_line_last,le.maxlength_prep_new_addr_line1,le.maxlength_prep_new_addr_line_last,le.maxlength_prep_owner_addr_line1,le.maxlength_prep_owner_addr_line_last,le.maxlength_EVENT_FIC_NAME,le.maxlength_EVENT_ACTION_CTR,le.maxlength_EVENT_SEQ_NUMBER,le.maxlength_EVENT_PAGES,le.maxlength_ACTION_SEQ_NUMBER,le.maxlength_ACTION_CODE,le.maxlength_ACTION_VERBAGE,le.maxlength_ACTION_OLD_FEI,le.maxlength_ACTION_OLD_COUNTY,le.maxlength_ACTION_OLD_ADDR1,le.maxlength_ACTION_OLD_ADDR2,le.maxlength_ACTION_OLD_CITY,le.maxlength_ACTION_OLD_STATE,le.maxlength_ACTION_OLD_ZIP5,le.maxlength_ACTION_OLD_ZIP4,le.maxlength_ACTION_OLD_COUNTRY,le.maxlength_ACTION_OLD_COUNTRY_DESC,le.maxlength_ACTION_NEW_FEI,le.maxlength_ACTION_NEW_COUNTY,le.maxlength_ACTION_NEW_ADDR1,le.maxlength_ACTION_NEW_ADDR2,le.maxlength_ACTION_NEW_CITY,le.maxlength_ACTION_NEW_STATE,le.maxlength_ACTION_NEW_ZIP5,le.maxlength_ACTION_NEW_ZIP4,le.maxlength_ACTION_NEW_COUNTRY,le.maxlength_ACTION_NEW_COUNTRY_DESC,le.maxlength_ACTION_OWN_ADDRESS,le.maxlength_ACTION_OWN_CITY,le.maxlength_ACTION_OWN_STATE,le.maxlength_ACTION_OWN_ZIP5,le.maxlength_ACTION_OWN_FEI,le.maxlength_ACTION_OWN_CHARTER_NUMBER,le.maxlength_ACTION_OLD_NAME_SEQ,le.maxlength_ACTION_NEW_NAME_SEQ,le.maxlength_Owner_title,le.maxlength_Owner_fname,le.maxlength_Owner_mname,le.maxlength_Owner_lname,le.maxlength_Owner_name_suffix,le.maxlength_Owner_name_score,le.maxlength_cname);
  SELF.avelength := CHOOSE(C,le.avelength_action_OWN_name,le.avelength_event_date,le.avelength_event_doc_number,le.avelength_event_orig_doc_number,le.avelength_prep_old_addr_line1,le.avelength_prep_old_addr_line_last,le.avelength_prep_new_addr_line1,le.avelength_prep_new_addr_line_last,le.avelength_prep_owner_addr_line1,le.avelength_prep_owner_addr_line_last,le.avelength_EVENT_FIC_NAME,le.avelength_EVENT_ACTION_CTR,le.avelength_EVENT_SEQ_NUMBER,le.avelength_EVENT_PAGES,le.avelength_ACTION_SEQ_NUMBER,le.avelength_ACTION_CODE,le.avelength_ACTION_VERBAGE,le.avelength_ACTION_OLD_FEI,le.avelength_ACTION_OLD_COUNTY,le.avelength_ACTION_OLD_ADDR1,le.avelength_ACTION_OLD_ADDR2,le.avelength_ACTION_OLD_CITY,le.avelength_ACTION_OLD_STATE,le.avelength_ACTION_OLD_ZIP5,le.avelength_ACTION_OLD_ZIP4,le.avelength_ACTION_OLD_COUNTRY,le.avelength_ACTION_OLD_COUNTRY_DESC,le.avelength_ACTION_NEW_FEI,le.avelength_ACTION_NEW_COUNTY,le.avelength_ACTION_NEW_ADDR1,le.avelength_ACTION_NEW_ADDR2,le.avelength_ACTION_NEW_CITY,le.avelength_ACTION_NEW_STATE,le.avelength_ACTION_NEW_ZIP5,le.avelength_ACTION_NEW_ZIP4,le.avelength_ACTION_NEW_COUNTRY,le.avelength_ACTION_NEW_COUNTRY_DESC,le.avelength_ACTION_OWN_ADDRESS,le.avelength_ACTION_OWN_CITY,le.avelength_ACTION_OWN_STATE,le.avelength_ACTION_OWN_ZIP5,le.avelength_ACTION_OWN_FEI,le.avelength_ACTION_OWN_CHARTER_NUMBER,le.avelength_ACTION_OLD_NAME_SEQ,le.avelength_ACTION_NEW_NAME_SEQ,le.avelength_Owner_title,le.avelength_Owner_fname,le.avelength_Owner_mname,le.avelength_Owner_lname,le.avelength_Owner_name_suffix,le.avelength_Owner_name_score,le.avelength_cname);
END;
EXPORT invSummary := NORMALIZE(summary0, 52, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT37.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT37.StrType)le.action_OWN_name),TRIM((SALT37.StrType)le.event_date),TRIM((SALT37.StrType)le.event_doc_number),TRIM((SALT37.StrType)le.event_orig_doc_number),TRIM((SALT37.StrType)le.prep_old_addr_line1),TRIM((SALT37.StrType)le.prep_old_addr_line_last),TRIM((SALT37.StrType)le.prep_new_addr_line1),TRIM((SALT37.StrType)le.prep_new_addr_line_last),TRIM((SALT37.StrType)le.prep_owner_addr_line1),TRIM((SALT37.StrType)le.prep_owner_addr_line_last),TRIM((SALT37.StrType)le.EVENT_FIC_NAME),TRIM((SALT37.StrType)le.EVENT_ACTION_CTR),TRIM((SALT37.StrType)le.EVENT_SEQ_NUMBER),TRIM((SALT37.StrType)le.EVENT_PAGES),TRIM((SALT37.StrType)le.ACTION_SEQ_NUMBER),TRIM((SALT37.StrType)le.ACTION_CODE),TRIM((SALT37.StrType)le.ACTION_VERBAGE),TRIM((SALT37.StrType)le.ACTION_OLD_FEI),TRIM((SALT37.StrType)le.ACTION_OLD_COUNTY),TRIM((SALT37.StrType)le.ACTION_OLD_ADDR1),TRIM((SALT37.StrType)le.ACTION_OLD_ADDR2),TRIM((SALT37.StrType)le.ACTION_OLD_CITY),TRIM((SALT37.StrType)le.ACTION_OLD_STATE),TRIM((SALT37.StrType)le.ACTION_OLD_ZIP5),TRIM((SALT37.StrType)le.ACTION_OLD_ZIP4),TRIM((SALT37.StrType)le.ACTION_OLD_COUNTRY),TRIM((SALT37.StrType)le.ACTION_OLD_COUNTRY_DESC),TRIM((SALT37.StrType)le.ACTION_NEW_FEI),TRIM((SALT37.StrType)le.ACTION_NEW_COUNTY),TRIM((SALT37.StrType)le.ACTION_NEW_ADDR1),TRIM((SALT37.StrType)le.ACTION_NEW_ADDR2),TRIM((SALT37.StrType)le.ACTION_NEW_CITY),TRIM((SALT37.StrType)le.ACTION_NEW_STATE),TRIM((SALT37.StrType)le.ACTION_NEW_ZIP5),TRIM((SALT37.StrType)le.ACTION_NEW_ZIP4),TRIM((SALT37.StrType)le.ACTION_NEW_COUNTRY),TRIM((SALT37.StrType)le.ACTION_NEW_COUNTRY_DESC),TRIM((SALT37.StrType)le.ACTION_OWN_ADDRESS),TRIM((SALT37.StrType)le.ACTION_OWN_CITY),TRIM((SALT37.StrType)le.ACTION_OWN_STATE),TRIM((SALT37.StrType)le.ACTION_OWN_ZIP5),TRIM((SALT37.StrType)le.ACTION_OWN_FEI),TRIM((SALT37.StrType)le.ACTION_OWN_CHARTER_NUMBER),TRIM((SALT37.StrType)le.ACTION_OLD_NAME_SEQ),TRIM((SALT37.StrType)le.ACTION_NEW_NAME_SEQ),TRIM((SALT37.StrType)le.Owner_title),TRIM((SALT37.StrType)le.Owner_fname),TRIM((SALT37.StrType)le.Owner_mname),TRIM((SALT37.StrType)le.Owner_lname),TRIM((SALT37.StrType)le.Owner_name_suffix),TRIM((SALT37.StrType)le.Owner_name_score),TRIM((SALT37.StrType)le.cname)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,52,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT37.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 52);
  SELF.FldNo2 := 1 + (C % 52);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT37.StrType)le.action_OWN_name),TRIM((SALT37.StrType)le.event_date),TRIM((SALT37.StrType)le.event_doc_number),TRIM((SALT37.StrType)le.event_orig_doc_number),TRIM((SALT37.StrType)le.prep_old_addr_line1),TRIM((SALT37.StrType)le.prep_old_addr_line_last),TRIM((SALT37.StrType)le.prep_new_addr_line1),TRIM((SALT37.StrType)le.prep_new_addr_line_last),TRIM((SALT37.StrType)le.prep_owner_addr_line1),TRIM((SALT37.StrType)le.prep_owner_addr_line_last),TRIM((SALT37.StrType)le.EVENT_FIC_NAME),TRIM((SALT37.StrType)le.EVENT_ACTION_CTR),TRIM((SALT37.StrType)le.EVENT_SEQ_NUMBER),TRIM((SALT37.StrType)le.EVENT_PAGES),TRIM((SALT37.StrType)le.ACTION_SEQ_NUMBER),TRIM((SALT37.StrType)le.ACTION_CODE),TRIM((SALT37.StrType)le.ACTION_VERBAGE),TRIM((SALT37.StrType)le.ACTION_OLD_FEI),TRIM((SALT37.StrType)le.ACTION_OLD_COUNTY),TRIM((SALT37.StrType)le.ACTION_OLD_ADDR1),TRIM((SALT37.StrType)le.ACTION_OLD_ADDR2),TRIM((SALT37.StrType)le.ACTION_OLD_CITY),TRIM((SALT37.StrType)le.ACTION_OLD_STATE),TRIM((SALT37.StrType)le.ACTION_OLD_ZIP5),TRIM((SALT37.StrType)le.ACTION_OLD_ZIP4),TRIM((SALT37.StrType)le.ACTION_OLD_COUNTRY),TRIM((SALT37.StrType)le.ACTION_OLD_COUNTRY_DESC),TRIM((SALT37.StrType)le.ACTION_NEW_FEI),TRIM((SALT37.StrType)le.ACTION_NEW_COUNTY),TRIM((SALT37.StrType)le.ACTION_NEW_ADDR1),TRIM((SALT37.StrType)le.ACTION_NEW_ADDR2),TRIM((SALT37.StrType)le.ACTION_NEW_CITY),TRIM((SALT37.StrType)le.ACTION_NEW_STATE),TRIM((SALT37.StrType)le.ACTION_NEW_ZIP5),TRIM((SALT37.StrType)le.ACTION_NEW_ZIP4),TRIM((SALT37.StrType)le.ACTION_NEW_COUNTRY),TRIM((SALT37.StrType)le.ACTION_NEW_COUNTRY_DESC),TRIM((SALT37.StrType)le.ACTION_OWN_ADDRESS),TRIM((SALT37.StrType)le.ACTION_OWN_CITY),TRIM((SALT37.StrType)le.ACTION_OWN_STATE),TRIM((SALT37.StrType)le.ACTION_OWN_ZIP5),TRIM((SALT37.StrType)le.ACTION_OWN_FEI),TRIM((SALT37.StrType)le.ACTION_OWN_CHARTER_NUMBER),TRIM((SALT37.StrType)le.ACTION_OLD_NAME_SEQ),TRIM((SALT37.StrType)le.ACTION_NEW_NAME_SEQ),TRIM((SALT37.StrType)le.Owner_title),TRIM((SALT37.StrType)le.Owner_fname),TRIM((SALT37.StrType)le.Owner_mname),TRIM((SALT37.StrType)le.Owner_lname),TRIM((SALT37.StrType)le.Owner_name_suffix),TRIM((SALT37.StrType)le.Owner_name_score),TRIM((SALT37.StrType)le.cname)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT37.StrType)le.action_OWN_name),TRIM((SALT37.StrType)le.event_date),TRIM((SALT37.StrType)le.event_doc_number),TRIM((SALT37.StrType)le.event_orig_doc_number),TRIM((SALT37.StrType)le.prep_old_addr_line1),TRIM((SALT37.StrType)le.prep_old_addr_line_last),TRIM((SALT37.StrType)le.prep_new_addr_line1),TRIM((SALT37.StrType)le.prep_new_addr_line_last),TRIM((SALT37.StrType)le.prep_owner_addr_line1),TRIM((SALT37.StrType)le.prep_owner_addr_line_last),TRIM((SALT37.StrType)le.EVENT_FIC_NAME),TRIM((SALT37.StrType)le.EVENT_ACTION_CTR),TRIM((SALT37.StrType)le.EVENT_SEQ_NUMBER),TRIM((SALT37.StrType)le.EVENT_PAGES),TRIM((SALT37.StrType)le.ACTION_SEQ_NUMBER),TRIM((SALT37.StrType)le.ACTION_CODE),TRIM((SALT37.StrType)le.ACTION_VERBAGE),TRIM((SALT37.StrType)le.ACTION_OLD_FEI),TRIM((SALT37.StrType)le.ACTION_OLD_COUNTY),TRIM((SALT37.StrType)le.ACTION_OLD_ADDR1),TRIM((SALT37.StrType)le.ACTION_OLD_ADDR2),TRIM((SALT37.StrType)le.ACTION_OLD_CITY),TRIM((SALT37.StrType)le.ACTION_OLD_STATE),TRIM((SALT37.StrType)le.ACTION_OLD_ZIP5),TRIM((SALT37.StrType)le.ACTION_OLD_ZIP4),TRIM((SALT37.StrType)le.ACTION_OLD_COUNTRY),TRIM((SALT37.StrType)le.ACTION_OLD_COUNTRY_DESC),TRIM((SALT37.StrType)le.ACTION_NEW_FEI),TRIM((SALT37.StrType)le.ACTION_NEW_COUNTY),TRIM((SALT37.StrType)le.ACTION_NEW_ADDR1),TRIM((SALT37.StrType)le.ACTION_NEW_ADDR2),TRIM((SALT37.StrType)le.ACTION_NEW_CITY),TRIM((SALT37.StrType)le.ACTION_NEW_STATE),TRIM((SALT37.StrType)le.ACTION_NEW_ZIP5),TRIM((SALT37.StrType)le.ACTION_NEW_ZIP4),TRIM((SALT37.StrType)le.ACTION_NEW_COUNTRY),TRIM((SALT37.StrType)le.ACTION_NEW_COUNTRY_DESC),TRIM((SALT37.StrType)le.ACTION_OWN_ADDRESS),TRIM((SALT37.StrType)le.ACTION_OWN_CITY),TRIM((SALT37.StrType)le.ACTION_OWN_STATE),TRIM((SALT37.StrType)le.ACTION_OWN_ZIP5),TRIM((SALT37.StrType)le.ACTION_OWN_FEI),TRIM((SALT37.StrType)le.ACTION_OWN_CHARTER_NUMBER),TRIM((SALT37.StrType)le.ACTION_OLD_NAME_SEQ),TRIM((SALT37.StrType)le.ACTION_NEW_NAME_SEQ),TRIM((SALT37.StrType)le.Owner_title),TRIM((SALT37.StrType)le.Owner_fname),TRIM((SALT37.StrType)le.Owner_mname),TRIM((SALT37.StrType)le.Owner_lname),TRIM((SALT37.StrType)le.Owner_name_suffix),TRIM((SALT37.StrType)le.Owner_name_score),TRIM((SALT37.StrType)le.cname)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),52*52,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'action_OWN_name'}
      ,{2,'event_date'}
      ,{3,'event_doc_number'}
      ,{4,'event_orig_doc_number'}
      ,{5,'prep_old_addr_line1'}
      ,{6,'prep_old_addr_line_last'}
      ,{7,'prep_new_addr_line1'}
      ,{8,'prep_new_addr_line_last'}
      ,{9,'prep_owner_addr_line1'}
      ,{10,'prep_owner_addr_line_last'}
      ,{11,'EVENT_FIC_NAME'}
      ,{12,'EVENT_ACTION_CTR'}
      ,{13,'EVENT_SEQ_NUMBER'}
      ,{14,'EVENT_PAGES'}
      ,{15,'ACTION_SEQ_NUMBER'}
      ,{16,'ACTION_CODE'}
      ,{17,'ACTION_VERBAGE'}
      ,{18,'ACTION_OLD_FEI'}
      ,{19,'ACTION_OLD_COUNTY'}
      ,{20,'ACTION_OLD_ADDR1'}
      ,{21,'ACTION_OLD_ADDR2'}
      ,{22,'ACTION_OLD_CITY'}
      ,{23,'ACTION_OLD_STATE'}
      ,{24,'ACTION_OLD_ZIP5'}
      ,{25,'ACTION_OLD_ZIP4'}
      ,{26,'ACTION_OLD_COUNTRY'}
      ,{27,'ACTION_OLD_COUNTRY_DESC'}
      ,{28,'ACTION_NEW_FEI'}
      ,{29,'ACTION_NEW_COUNTY'}
      ,{30,'ACTION_NEW_ADDR1'}
      ,{31,'ACTION_NEW_ADDR2'}
      ,{32,'ACTION_NEW_CITY'}
      ,{33,'ACTION_NEW_STATE'}
      ,{34,'ACTION_NEW_ZIP5'}
      ,{35,'ACTION_NEW_ZIP4'}
      ,{36,'ACTION_NEW_COUNTRY'}
      ,{37,'ACTION_NEW_COUNTRY_DESC'}
      ,{38,'ACTION_OWN_ADDRESS'}
      ,{39,'ACTION_OWN_CITY'}
      ,{40,'ACTION_OWN_STATE'}
      ,{41,'ACTION_OWN_ZIP5'}
      ,{42,'ACTION_OWN_FEI'}
      ,{43,'ACTION_OWN_CHARTER_NUMBER'}
      ,{44,'ACTION_OLD_NAME_SEQ'}
      ,{45,'ACTION_NEW_NAME_SEQ'}
      ,{46,'Owner_title'}
      ,{47,'Owner_fname'}
      ,{48,'Owner_mname'}
      ,{49,'Owner_lname'}
      ,{50,'Owner_name_suffix'}
      ,{51,'Owner_name_score'}
      ,{52,'cname'}],SALT37.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT37.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT37.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT37.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_FL_Event_Fields.InValid_action_OWN_name((SALT37.StrType)le.action_OWN_name),
    Input_FL_Event_Fields.InValid_event_date((SALT37.StrType)le.event_date),
    Input_FL_Event_Fields.InValid_event_doc_number((SALT37.StrType)le.event_doc_number),
    Input_FL_Event_Fields.InValid_event_orig_doc_number((SALT37.StrType)le.event_orig_doc_number),
    Input_FL_Event_Fields.InValid_prep_old_addr_line1((SALT37.StrType)le.prep_old_addr_line1),
    Input_FL_Event_Fields.InValid_prep_old_addr_line_last((SALT37.StrType)le.prep_old_addr_line_last),
    Input_FL_Event_Fields.InValid_prep_new_addr_line1((SALT37.StrType)le.prep_new_addr_line1),
    Input_FL_Event_Fields.InValid_prep_new_addr_line_last((SALT37.StrType)le.prep_new_addr_line_last),
    Input_FL_Event_Fields.InValid_prep_owner_addr_line1((SALT37.StrType)le.prep_owner_addr_line1),
    Input_FL_Event_Fields.InValid_prep_owner_addr_line_last((SALT37.StrType)le.prep_owner_addr_line_last),
    Input_FL_Event_Fields.InValid_EVENT_FIC_NAME((SALT37.StrType)le.EVENT_FIC_NAME),
    Input_FL_Event_Fields.InValid_EVENT_ACTION_CTR((SALT37.StrType)le.EVENT_ACTION_CTR),
    Input_FL_Event_Fields.InValid_EVENT_SEQ_NUMBER((SALT37.StrType)le.EVENT_SEQ_NUMBER),
    Input_FL_Event_Fields.InValid_EVENT_PAGES((SALT37.StrType)le.EVENT_PAGES),
    Input_FL_Event_Fields.InValid_ACTION_SEQ_NUMBER((SALT37.StrType)le.ACTION_SEQ_NUMBER),
    Input_FL_Event_Fields.InValid_ACTION_CODE((SALT37.StrType)le.ACTION_CODE),
    Input_FL_Event_Fields.InValid_ACTION_VERBAGE((SALT37.StrType)le.ACTION_VERBAGE),
    Input_FL_Event_Fields.InValid_ACTION_OLD_FEI((SALT37.StrType)le.ACTION_OLD_FEI),
    Input_FL_Event_Fields.InValid_ACTION_OLD_COUNTY((SALT37.StrType)le.ACTION_OLD_COUNTY),
    Input_FL_Event_Fields.InValid_ACTION_OLD_ADDR1((SALT37.StrType)le.ACTION_OLD_ADDR1),
    Input_FL_Event_Fields.InValid_ACTION_OLD_ADDR2((SALT37.StrType)le.ACTION_OLD_ADDR2),
    Input_FL_Event_Fields.InValid_ACTION_OLD_CITY((SALT37.StrType)le.ACTION_OLD_CITY),
    Input_FL_Event_Fields.InValid_ACTION_OLD_STATE((SALT37.StrType)le.ACTION_OLD_STATE),
    Input_FL_Event_Fields.InValid_ACTION_OLD_ZIP5((SALT37.StrType)le.ACTION_OLD_ZIP5),
    Input_FL_Event_Fields.InValid_ACTION_OLD_ZIP4((SALT37.StrType)le.ACTION_OLD_ZIP4),
    Input_FL_Event_Fields.InValid_ACTION_OLD_COUNTRY((SALT37.StrType)le.ACTION_OLD_COUNTRY),
    Input_FL_Event_Fields.InValid_ACTION_OLD_COUNTRY_DESC((SALT37.StrType)le.ACTION_OLD_COUNTRY_DESC),
    Input_FL_Event_Fields.InValid_ACTION_NEW_FEI((SALT37.StrType)le.ACTION_NEW_FEI),
    Input_FL_Event_Fields.InValid_ACTION_NEW_COUNTY((SALT37.StrType)le.ACTION_NEW_COUNTY),
    Input_FL_Event_Fields.InValid_ACTION_NEW_ADDR1((SALT37.StrType)le.ACTION_NEW_ADDR1),
    Input_FL_Event_Fields.InValid_ACTION_NEW_ADDR2((SALT37.StrType)le.ACTION_NEW_ADDR2),
    Input_FL_Event_Fields.InValid_ACTION_NEW_CITY((SALT37.StrType)le.ACTION_NEW_CITY),
    Input_FL_Event_Fields.InValid_ACTION_NEW_STATE((SALT37.StrType)le.ACTION_NEW_STATE),
    Input_FL_Event_Fields.InValid_ACTION_NEW_ZIP5((SALT37.StrType)le.ACTION_NEW_ZIP5),
    Input_FL_Event_Fields.InValid_ACTION_NEW_ZIP4((SALT37.StrType)le.ACTION_NEW_ZIP4),
    Input_FL_Event_Fields.InValid_ACTION_NEW_COUNTRY((SALT37.StrType)le.ACTION_NEW_COUNTRY),
    Input_FL_Event_Fields.InValid_ACTION_NEW_COUNTRY_DESC((SALT37.StrType)le.ACTION_NEW_COUNTRY_DESC),
    Input_FL_Event_Fields.InValid_ACTION_OWN_ADDRESS((SALT37.StrType)le.ACTION_OWN_ADDRESS),
    Input_FL_Event_Fields.InValid_ACTION_OWN_CITY((SALT37.StrType)le.ACTION_OWN_CITY),
    Input_FL_Event_Fields.InValid_ACTION_OWN_STATE((SALT37.StrType)le.ACTION_OWN_STATE),
    Input_FL_Event_Fields.InValid_ACTION_OWN_ZIP5((SALT37.StrType)le.ACTION_OWN_ZIP5),
    Input_FL_Event_Fields.InValid_ACTION_OWN_FEI((SALT37.StrType)le.ACTION_OWN_FEI),
    Input_FL_Event_Fields.InValid_ACTION_OWN_CHARTER_NUMBER((SALT37.StrType)le.ACTION_OWN_CHARTER_NUMBER),
    Input_FL_Event_Fields.InValid_ACTION_OLD_NAME_SEQ((SALT37.StrType)le.ACTION_OLD_NAME_SEQ),
    Input_FL_Event_Fields.InValid_ACTION_NEW_NAME_SEQ((SALT37.StrType)le.ACTION_NEW_NAME_SEQ),
    Input_FL_Event_Fields.InValid_Owner_title((SALT37.StrType)le.Owner_title),
    Input_FL_Event_Fields.InValid_Owner_fname((SALT37.StrType)le.Owner_fname),
    Input_FL_Event_Fields.InValid_Owner_mname((SALT37.StrType)le.Owner_mname),
    Input_FL_Event_Fields.InValid_Owner_lname((SALT37.StrType)le.Owner_lname),
    Input_FL_Event_Fields.InValid_Owner_name_suffix((SALT37.StrType)le.Owner_name_suffix),
    Input_FL_Event_Fields.InValid_Owner_name_score((SALT37.StrType)le.Owner_name_score),
    Input_FL_Event_Fields.InValid_cname((SALT37.StrType)le.cname),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,52,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Input_FL_Event_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_general_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_FL_Event_Fields.InValidMessage_action_OWN_name(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_event_date(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_event_doc_number(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_event_orig_doc_number(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_prep_old_addr_line1(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_prep_old_addr_line_last(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_prep_new_addr_line1(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_prep_new_addr_line_last(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_prep_owner_addr_line1(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_prep_owner_addr_line_last(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_EVENT_FIC_NAME(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_EVENT_ACTION_CTR(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_EVENT_SEQ_NUMBER(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_EVENT_PAGES(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_SEQ_NUMBER(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_CODE(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_VERBAGE(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_OLD_FEI(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_OLD_COUNTY(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_OLD_ADDR1(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_OLD_ADDR2(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_OLD_CITY(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_OLD_STATE(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_OLD_ZIP5(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_OLD_ZIP4(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_OLD_COUNTRY(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_OLD_COUNTRY_DESC(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_NEW_FEI(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_NEW_COUNTY(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_NEW_ADDR1(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_NEW_ADDR2(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_NEW_CITY(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_NEW_STATE(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_NEW_ZIP5(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_NEW_ZIP4(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_NEW_COUNTRY(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_NEW_COUNTRY_DESC(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_OWN_ADDRESS(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_OWN_CITY(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_OWN_STATE(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_OWN_ZIP5(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_OWN_FEI(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_OWN_CHARTER_NUMBER(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_OLD_NAME_SEQ(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_NEW_NAME_SEQ(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_Owner_title(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_Owner_fname(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_Owner_mname(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_Owner_lname(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_Owner_name_suffix(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_Owner_name_score(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_cname(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
