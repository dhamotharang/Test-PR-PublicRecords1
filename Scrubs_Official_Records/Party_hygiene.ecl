IMPORT SALT311,STD;
EXPORT Party_hygiene(dataset(Party_layout_Official_Records) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_vendor_cnt := COUNT(GROUP,h.vendor <> (TYPEOF(h.vendor))'');
    populated_vendor_pcnt := AVE(GROUP,IF(h.vendor = (TYPEOF(h.vendor))'',0,100));
    maxlength_vendor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor)));
    avelength_vendor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor)),h.vendor<>(typeof(h.vendor))'');
    populated_state_origin_cnt := COUNT(GROUP,h.state_origin <> (TYPEOF(h.state_origin))'');
    populated_state_origin_pcnt := AVE(GROUP,IF(h.state_origin = (TYPEOF(h.state_origin))'',0,100));
    maxlength_state_origin := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_origin)));
    avelength_state_origin := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_origin)),h.state_origin<>(typeof(h.state_origin))'');
    populated_county_name_cnt := COUNT(GROUP,h.county_name <> (TYPEOF(h.county_name))'');
    populated_county_name_pcnt := AVE(GROUP,IF(h.county_name = (TYPEOF(h.county_name))'',0,100));
    maxlength_county_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_name)));
    avelength_county_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_name)),h.county_name<>(typeof(h.county_name))'');
    populated_official_record_key_cnt := COUNT(GROUP,h.official_record_key <> (TYPEOF(h.official_record_key))'');
    populated_official_record_key_pcnt := AVE(GROUP,IF(h.official_record_key = (TYPEOF(h.official_record_key))'',0,100));
    maxlength_official_record_key := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.official_record_key)));
    avelength_official_record_key := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.official_record_key)),h.official_record_key<>(typeof(h.official_record_key))'');
    populated_doc_instrument_or_clerk_filing_num_cnt := COUNT(GROUP,h.doc_instrument_or_clerk_filing_num <> (TYPEOF(h.doc_instrument_or_clerk_filing_num))'');
    populated_doc_instrument_or_clerk_filing_num_pcnt := AVE(GROUP,IF(h.doc_instrument_or_clerk_filing_num = (TYPEOF(h.doc_instrument_or_clerk_filing_num))'',0,100));
    maxlength_doc_instrument_or_clerk_filing_num := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_instrument_or_clerk_filing_num)));
    avelength_doc_instrument_or_clerk_filing_num := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_instrument_or_clerk_filing_num)),h.doc_instrument_or_clerk_filing_num<>(typeof(h.doc_instrument_or_clerk_filing_num))'');
    populated_doc_filed_dt_cnt := COUNT(GROUP,h.doc_filed_dt <> (TYPEOF(h.doc_filed_dt))'');
    populated_doc_filed_dt_pcnt := AVE(GROUP,IF(h.doc_filed_dt = (TYPEOF(h.doc_filed_dt))'',0,100));
    maxlength_doc_filed_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_filed_dt)));
    avelength_doc_filed_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_filed_dt)),h.doc_filed_dt<>(typeof(h.doc_filed_dt))'');
    populated_doc_type_desc_cnt := COUNT(GROUP,h.doc_type_desc <> (TYPEOF(h.doc_type_desc))'');
    populated_doc_type_desc_pcnt := AVE(GROUP,IF(h.doc_type_desc = (TYPEOF(h.doc_type_desc))'',0,100));
    maxlength_doc_type_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_type_desc)));
    avelength_doc_type_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.doc_type_desc)),h.doc_type_desc<>(typeof(h.doc_type_desc))'');
    populated_entity_sequence_cnt := COUNT(GROUP,h.entity_sequence <> (TYPEOF(h.entity_sequence))'');
    populated_entity_sequence_pcnt := AVE(GROUP,IF(h.entity_sequence = (TYPEOF(h.entity_sequence))'',0,100));
    maxlength_entity_sequence := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.entity_sequence)));
    avelength_entity_sequence := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.entity_sequence)),h.entity_sequence<>(typeof(h.entity_sequence))'');
    populated_entity_type_cd_cnt := COUNT(GROUP,h.entity_type_cd <> (TYPEOF(h.entity_type_cd))'');
    populated_entity_type_cd_pcnt := AVE(GROUP,IF(h.entity_type_cd = (TYPEOF(h.entity_type_cd))'',0,100));
    maxlength_entity_type_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.entity_type_cd)));
    avelength_entity_type_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.entity_type_cd)),h.entity_type_cd<>(typeof(h.entity_type_cd))'');
    populated_entity_type_desc_cnt := COUNT(GROUP,h.entity_type_desc <> (TYPEOF(h.entity_type_desc))'');
    populated_entity_type_desc_pcnt := AVE(GROUP,IF(h.entity_type_desc = (TYPEOF(h.entity_type_desc))'',0,100));
    maxlength_entity_type_desc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.entity_type_desc)));
    avelength_entity_type_desc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.entity_type_desc)),h.entity_type_desc<>(typeof(h.entity_type_desc))'');
    populated_entity_nm_cnt := COUNT(GROUP,h.entity_nm <> (TYPEOF(h.entity_nm))'');
    populated_entity_nm_pcnt := AVE(GROUP,IF(h.entity_nm = (TYPEOF(h.entity_nm))'',0,100));
    maxlength_entity_nm := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.entity_nm)));
    avelength_entity_nm := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.entity_nm)),h.entity_nm<>(typeof(h.entity_nm))'');
    populated_entity_nm_format_cnt := COUNT(GROUP,h.entity_nm_format <> (TYPEOF(h.entity_nm_format))'');
    populated_entity_nm_format_pcnt := AVE(GROUP,IF(h.entity_nm_format = (TYPEOF(h.entity_nm_format))'',0,100));
    maxlength_entity_nm_format := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.entity_nm_format)));
    avelength_entity_nm_format := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.entity_nm_format)),h.entity_nm_format<>(typeof(h.entity_nm_format))'');
    populated_entity_dob_cnt := COUNT(GROUP,h.entity_dob <> (TYPEOF(h.entity_dob))'');
    populated_entity_dob_pcnt := AVE(GROUP,IF(h.entity_dob = (TYPEOF(h.entity_dob))'',0,100));
    maxlength_entity_dob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.entity_dob)));
    avelength_entity_dob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.entity_dob)),h.entity_dob<>(typeof(h.entity_dob))'');
    populated_entity_ssn_cnt := COUNT(GROUP,h.entity_ssn <> (TYPEOF(h.entity_ssn))'');
    populated_entity_ssn_pcnt := AVE(GROUP,IF(h.entity_ssn = (TYPEOF(h.entity_ssn))'',0,100));
    maxlength_entity_ssn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.entity_ssn)));
    avelength_entity_ssn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.entity_ssn)),h.entity_ssn<>(typeof(h.entity_ssn))'');
    populated_title1_cnt := COUNT(GROUP,h.title1 <> (TYPEOF(h.title1))'');
    populated_title1_pcnt := AVE(GROUP,IF(h.title1 = (TYPEOF(h.title1))'',0,100));
    maxlength_title1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title1)));
    avelength_title1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title1)),h.title1<>(typeof(h.title1))'');
    populated_fname1_cnt := COUNT(GROUP,h.fname1 <> (TYPEOF(h.fname1))'');
    populated_fname1_pcnt := AVE(GROUP,IF(h.fname1 = (TYPEOF(h.fname1))'',0,100));
    maxlength_fname1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname1)));
    avelength_fname1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname1)),h.fname1<>(typeof(h.fname1))'');
    populated_mname1_cnt := COUNT(GROUP,h.mname1 <> (TYPEOF(h.mname1))'');
    populated_mname1_pcnt := AVE(GROUP,IF(h.mname1 = (TYPEOF(h.mname1))'',0,100));
    maxlength_mname1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname1)));
    avelength_mname1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname1)),h.mname1<>(typeof(h.mname1))'');
    populated_lname1_cnt := COUNT(GROUP,h.lname1 <> (TYPEOF(h.lname1))'');
    populated_lname1_pcnt := AVE(GROUP,IF(h.lname1 = (TYPEOF(h.lname1))'',0,100));
    maxlength_lname1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname1)));
    avelength_lname1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname1)),h.lname1<>(typeof(h.lname1))'');
    populated_suffix1_cnt := COUNT(GROUP,h.suffix1 <> (TYPEOF(h.suffix1))'');
    populated_suffix1_pcnt := AVE(GROUP,IF(h.suffix1 = (TYPEOF(h.suffix1))'',0,100));
    maxlength_suffix1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix1)));
    avelength_suffix1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix1)),h.suffix1<>(typeof(h.suffix1))'');
    populated_pname1_score_cnt := COUNT(GROUP,h.pname1_score <> (TYPEOF(h.pname1_score))'');
    populated_pname1_score_pcnt := AVE(GROUP,IF(h.pname1_score = (TYPEOF(h.pname1_score))'',0,100));
    maxlength_pname1_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pname1_score)));
    avelength_pname1_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pname1_score)),h.pname1_score<>(typeof(h.pname1_score))'');
    populated_cname1_cnt := COUNT(GROUP,h.cname1 <> (TYPEOF(h.cname1))'');
    populated_cname1_pcnt := AVE(GROUP,IF(h.cname1 = (TYPEOF(h.cname1))'',0,100));
    maxlength_cname1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cname1)));
    avelength_cname1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cname1)),h.cname1<>(typeof(h.cname1))'');
    populated_title2_cnt := COUNT(GROUP,h.title2 <> (TYPEOF(h.title2))'');
    populated_title2_pcnt := AVE(GROUP,IF(h.title2 = (TYPEOF(h.title2))'',0,100));
    maxlength_title2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title2)));
    avelength_title2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title2)),h.title2<>(typeof(h.title2))'');
    populated_fname2_cnt := COUNT(GROUP,h.fname2 <> (TYPEOF(h.fname2))'');
    populated_fname2_pcnt := AVE(GROUP,IF(h.fname2 = (TYPEOF(h.fname2))'',0,100));
    maxlength_fname2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname2)));
    avelength_fname2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname2)),h.fname2<>(typeof(h.fname2))'');
    populated_mname2_cnt := COUNT(GROUP,h.mname2 <> (TYPEOF(h.mname2))'');
    populated_mname2_pcnt := AVE(GROUP,IF(h.mname2 = (TYPEOF(h.mname2))'',0,100));
    maxlength_mname2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname2)));
    avelength_mname2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname2)),h.mname2<>(typeof(h.mname2))'');
    populated_lname2_cnt := COUNT(GROUP,h.lname2 <> (TYPEOF(h.lname2))'');
    populated_lname2_pcnt := AVE(GROUP,IF(h.lname2 = (TYPEOF(h.lname2))'',0,100));
    maxlength_lname2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname2)));
    avelength_lname2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname2)),h.lname2<>(typeof(h.lname2))'');
    populated_suffix2_cnt := COUNT(GROUP,h.suffix2 <> (TYPEOF(h.suffix2))'');
    populated_suffix2_pcnt := AVE(GROUP,IF(h.suffix2 = (TYPEOF(h.suffix2))'',0,100));
    maxlength_suffix2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix2)));
    avelength_suffix2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix2)),h.suffix2<>(typeof(h.suffix2))'');
    populated_pname2_score_cnt := COUNT(GROUP,h.pname2_score <> (TYPEOF(h.pname2_score))'');
    populated_pname2_score_pcnt := AVE(GROUP,IF(h.pname2_score = (TYPEOF(h.pname2_score))'',0,100));
    maxlength_pname2_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pname2_score)));
    avelength_pname2_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pname2_score)),h.pname2_score<>(typeof(h.pname2_score))'');
    populated_cname2_cnt := COUNT(GROUP,h.cname2 <> (TYPEOF(h.cname2))'');
    populated_cname2_pcnt := AVE(GROUP,IF(h.cname2 = (TYPEOF(h.cname2))'',0,100));
    maxlength_cname2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cname2)));
    avelength_cname2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cname2)),h.cname2<>(typeof(h.cname2))'');
    populated_title3_cnt := COUNT(GROUP,h.title3 <> (TYPEOF(h.title3))'');
    populated_title3_pcnt := AVE(GROUP,IF(h.title3 = (TYPEOF(h.title3))'',0,100));
    maxlength_title3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title3)));
    avelength_title3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title3)),h.title3<>(typeof(h.title3))'');
    populated_fname3_cnt := COUNT(GROUP,h.fname3 <> (TYPEOF(h.fname3))'');
    populated_fname3_pcnt := AVE(GROUP,IF(h.fname3 = (TYPEOF(h.fname3))'',0,100));
    maxlength_fname3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname3)));
    avelength_fname3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname3)),h.fname3<>(typeof(h.fname3))'');
    populated_mname3_cnt := COUNT(GROUP,h.mname3 <> (TYPEOF(h.mname3))'');
    populated_mname3_pcnt := AVE(GROUP,IF(h.mname3 = (TYPEOF(h.mname3))'',0,100));
    maxlength_mname3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname3)));
    avelength_mname3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname3)),h.mname3<>(typeof(h.mname3))'');
    populated_lname3_cnt := COUNT(GROUP,h.lname3 <> (TYPEOF(h.lname3))'');
    populated_lname3_pcnt := AVE(GROUP,IF(h.lname3 = (TYPEOF(h.lname3))'',0,100));
    maxlength_lname3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname3)));
    avelength_lname3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname3)),h.lname3<>(typeof(h.lname3))'');
    populated_suffix3_cnt := COUNT(GROUP,h.suffix3 <> (TYPEOF(h.suffix3))'');
    populated_suffix3_pcnt := AVE(GROUP,IF(h.suffix3 = (TYPEOF(h.suffix3))'',0,100));
    maxlength_suffix3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix3)));
    avelength_suffix3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix3)),h.suffix3<>(typeof(h.suffix3))'');
    populated_pname3_score_cnt := COUNT(GROUP,h.pname3_score <> (TYPEOF(h.pname3_score))'');
    populated_pname3_score_pcnt := AVE(GROUP,IF(h.pname3_score = (TYPEOF(h.pname3_score))'',0,100));
    maxlength_pname3_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pname3_score)));
    avelength_pname3_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pname3_score)),h.pname3_score<>(typeof(h.pname3_score))'');
    populated_cname3_cnt := COUNT(GROUP,h.cname3 <> (TYPEOF(h.cname3))'');
    populated_cname3_pcnt := AVE(GROUP,IF(h.cname3 = (TYPEOF(h.cname3))'',0,100));
    maxlength_cname3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cname3)));
    avelength_cname3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cname3)),h.cname3<>(typeof(h.cname3))'');
    populated_title4_cnt := COUNT(GROUP,h.title4 <> (TYPEOF(h.title4))'');
    populated_title4_pcnt := AVE(GROUP,IF(h.title4 = (TYPEOF(h.title4))'',0,100));
    maxlength_title4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title4)));
    avelength_title4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title4)),h.title4<>(typeof(h.title4))'');
    populated_fname4_cnt := COUNT(GROUP,h.fname4 <> (TYPEOF(h.fname4))'');
    populated_fname4_pcnt := AVE(GROUP,IF(h.fname4 = (TYPEOF(h.fname4))'',0,100));
    maxlength_fname4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname4)));
    avelength_fname4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname4)),h.fname4<>(typeof(h.fname4))'');
    populated_mname4_cnt := COUNT(GROUP,h.mname4 <> (TYPEOF(h.mname4))'');
    populated_mname4_pcnt := AVE(GROUP,IF(h.mname4 = (TYPEOF(h.mname4))'',0,100));
    maxlength_mname4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname4)));
    avelength_mname4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname4)),h.mname4<>(typeof(h.mname4))'');
    populated_lname4_cnt := COUNT(GROUP,h.lname4 <> (TYPEOF(h.lname4))'');
    populated_lname4_pcnt := AVE(GROUP,IF(h.lname4 = (TYPEOF(h.lname4))'',0,100));
    maxlength_lname4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname4)));
    avelength_lname4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname4)),h.lname4<>(typeof(h.lname4))'');
    populated_suffix4_cnt := COUNT(GROUP,h.suffix4 <> (TYPEOF(h.suffix4))'');
    populated_suffix4_pcnt := AVE(GROUP,IF(h.suffix4 = (TYPEOF(h.suffix4))'',0,100));
    maxlength_suffix4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix4)));
    avelength_suffix4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix4)),h.suffix4<>(typeof(h.suffix4))'');
    populated_pname4_score_cnt := COUNT(GROUP,h.pname4_score <> (TYPEOF(h.pname4_score))'');
    populated_pname4_score_pcnt := AVE(GROUP,IF(h.pname4_score = (TYPEOF(h.pname4_score))'',0,100));
    maxlength_pname4_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pname4_score)));
    avelength_pname4_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pname4_score)),h.pname4_score<>(typeof(h.pname4_score))'');
    populated_cname4_cnt := COUNT(GROUP,h.cname4 <> (TYPEOF(h.cname4))'');
    populated_cname4_pcnt := AVE(GROUP,IF(h.cname4 = (TYPEOF(h.cname4))'',0,100));
    maxlength_cname4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cname4)));
    avelength_cname4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cname4)),h.cname4<>(typeof(h.cname4))'');
    populated_title5_cnt := COUNT(GROUP,h.title5 <> (TYPEOF(h.title5))'');
    populated_title5_pcnt := AVE(GROUP,IF(h.title5 = (TYPEOF(h.title5))'',0,100));
    maxlength_title5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title5)));
    avelength_title5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title5)),h.title5<>(typeof(h.title5))'');
    populated_fname5_cnt := COUNT(GROUP,h.fname5 <> (TYPEOF(h.fname5))'');
    populated_fname5_pcnt := AVE(GROUP,IF(h.fname5 = (TYPEOF(h.fname5))'',0,100));
    maxlength_fname5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname5)));
    avelength_fname5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname5)),h.fname5<>(typeof(h.fname5))'');
    populated_mname5_cnt := COUNT(GROUP,h.mname5 <> (TYPEOF(h.mname5))'');
    populated_mname5_pcnt := AVE(GROUP,IF(h.mname5 = (TYPEOF(h.mname5))'',0,100));
    maxlength_mname5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname5)));
    avelength_mname5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname5)),h.mname5<>(typeof(h.mname5))'');
    populated_lname5_cnt := COUNT(GROUP,h.lname5 <> (TYPEOF(h.lname5))'');
    populated_lname5_pcnt := AVE(GROUP,IF(h.lname5 = (TYPEOF(h.lname5))'',0,100));
    maxlength_lname5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname5)));
    avelength_lname5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname5)),h.lname5<>(typeof(h.lname5))'');
    populated_suffix5_cnt := COUNT(GROUP,h.suffix5 <> (TYPEOF(h.suffix5))'');
    populated_suffix5_pcnt := AVE(GROUP,IF(h.suffix5 = (TYPEOF(h.suffix5))'',0,100));
    maxlength_suffix5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix5)));
    avelength_suffix5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix5)),h.suffix5<>(typeof(h.suffix5))'');
    populated_pname5_score_cnt := COUNT(GROUP,h.pname5_score <> (TYPEOF(h.pname5_score))'');
    populated_pname5_score_pcnt := AVE(GROUP,IF(h.pname5_score = (TYPEOF(h.pname5_score))'',0,100));
    maxlength_pname5_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pname5_score)));
    avelength_pname5_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pname5_score)),h.pname5_score<>(typeof(h.pname5_score))'');
    populated_cname5_cnt := COUNT(GROUP,h.cname5 <> (TYPEOF(h.cname5))'');
    populated_cname5_pcnt := AVE(GROUP,IF(h.cname5 = (TYPEOF(h.cname5))'',0,100));
    maxlength_cname5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cname5)));
    avelength_cname5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cname5)),h.cname5<>(typeof(h.cname5))'');
    populated_master_party_type_cd_cnt := COUNT(GROUP,h.master_party_type_cd <> (TYPEOF(h.master_party_type_cd))'');
    populated_master_party_type_cd_pcnt := AVE(GROUP,IF(h.master_party_type_cd = (TYPEOF(h.master_party_type_cd))'',0,100));
    maxlength_master_party_type_cd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.master_party_type_cd)));
    avelength_master_party_type_cd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.master_party_type_cd)),h.master_party_type_cd<>(typeof(h.master_party_type_cd))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_vendor_pcnt *   0.00 / 100 + T.Populated_state_origin_pcnt *   0.00 / 100 + T.Populated_county_name_pcnt *   0.00 / 100 + T.Populated_official_record_key_pcnt *   0.00 / 100 + T.Populated_doc_instrument_or_clerk_filing_num_pcnt *   0.00 / 100 + T.Populated_doc_filed_dt_pcnt *   0.00 / 100 + T.Populated_doc_type_desc_pcnt *   0.00 / 100 + T.Populated_entity_sequence_pcnt *   0.00 / 100 + T.Populated_entity_type_cd_pcnt *   0.00 / 100 + T.Populated_entity_type_desc_pcnt *   0.00 / 100 + T.Populated_entity_nm_pcnt *   0.00 / 100 + T.Populated_entity_nm_format_pcnt *   0.00 / 100 + T.Populated_entity_dob_pcnt *   0.00 / 100 + T.Populated_entity_ssn_pcnt *   0.00 / 100 + T.Populated_title1_pcnt *   0.00 / 100 + T.Populated_fname1_pcnt *   0.00 / 100 + T.Populated_mname1_pcnt *   0.00 / 100 + T.Populated_lname1_pcnt *   0.00 / 100 + T.Populated_suffix1_pcnt *   0.00 / 100 + T.Populated_pname1_score_pcnt *   0.00 / 100 + T.Populated_cname1_pcnt *   0.00 / 100 + T.Populated_title2_pcnt *   0.00 / 100 + T.Populated_fname2_pcnt *   0.00 / 100 + T.Populated_mname2_pcnt *   0.00 / 100 + T.Populated_lname2_pcnt *   0.00 / 100 + T.Populated_suffix2_pcnt *   0.00 / 100 + T.Populated_pname2_score_pcnt *   0.00 / 100 + T.Populated_cname2_pcnt *   0.00 / 100 + T.Populated_title3_pcnt *   0.00 / 100 + T.Populated_fname3_pcnt *   0.00 / 100 + T.Populated_mname3_pcnt *   0.00 / 100 + T.Populated_lname3_pcnt *   0.00 / 100 + T.Populated_suffix3_pcnt *   0.00 / 100 + T.Populated_pname3_score_pcnt *   0.00 / 100 + T.Populated_cname3_pcnt *   0.00 / 100 + T.Populated_title4_pcnt *   0.00 / 100 + T.Populated_fname4_pcnt *   0.00 / 100 + T.Populated_mname4_pcnt *   0.00 / 100 + T.Populated_lname4_pcnt *   0.00 / 100 + T.Populated_suffix4_pcnt *   0.00 / 100 + T.Populated_pname4_score_pcnt *   0.00 / 100 + T.Populated_cname4_pcnt *   0.00 / 100 + T.Populated_title5_pcnt *   0.00 / 100 + T.Populated_fname5_pcnt *   0.00 / 100 + T.Populated_mname5_pcnt *   0.00 / 100 + T.Populated_lname5_pcnt *   0.00 / 100 + T.Populated_suffix5_pcnt *   0.00 / 100 + T.Populated_pname5_score_pcnt *   0.00 / 100 + T.Populated_cname5_pcnt *   0.00 / 100 + T.Populated_master_party_type_cd_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'process_date','vendor','state_origin','county_name','official_record_key','doc_instrument_or_clerk_filing_num','doc_filed_dt','doc_type_desc','entity_sequence','entity_type_cd','entity_type_desc','entity_nm','entity_nm_format','entity_dob','entity_ssn','title1','fname1','mname1','lname1','suffix1','pname1_score','cname1','title2','fname2','mname2','lname2','suffix2','pname2_score','cname2','title3','fname3','mname3','lname3','suffix3','pname3_score','cname3','title4','fname4','mname4','lname4','suffix4','pname4_score','cname4','title5','fname5','mname5','lname5','suffix5','pname5_score','cname5','master_party_type_cd');
  SELF.populated_pcnt := CHOOSE(C,le.populated_process_date_pcnt,le.populated_vendor_pcnt,le.populated_state_origin_pcnt,le.populated_county_name_pcnt,le.populated_official_record_key_pcnt,le.populated_doc_instrument_or_clerk_filing_num_pcnt,le.populated_doc_filed_dt_pcnt,le.populated_doc_type_desc_pcnt,le.populated_entity_sequence_pcnt,le.populated_entity_type_cd_pcnt,le.populated_entity_type_desc_pcnt,le.populated_entity_nm_pcnt,le.populated_entity_nm_format_pcnt,le.populated_entity_dob_pcnt,le.populated_entity_ssn_pcnt,le.populated_title1_pcnt,le.populated_fname1_pcnt,le.populated_mname1_pcnt,le.populated_lname1_pcnt,le.populated_suffix1_pcnt,le.populated_pname1_score_pcnt,le.populated_cname1_pcnt,le.populated_title2_pcnt,le.populated_fname2_pcnt,le.populated_mname2_pcnt,le.populated_lname2_pcnt,le.populated_suffix2_pcnt,le.populated_pname2_score_pcnt,le.populated_cname2_pcnt,le.populated_title3_pcnt,le.populated_fname3_pcnt,le.populated_mname3_pcnt,le.populated_lname3_pcnt,le.populated_suffix3_pcnt,le.populated_pname3_score_pcnt,le.populated_cname3_pcnt,le.populated_title4_pcnt,le.populated_fname4_pcnt,le.populated_mname4_pcnt,le.populated_lname4_pcnt,le.populated_suffix4_pcnt,le.populated_pname4_score_pcnt,le.populated_cname4_pcnt,le.populated_title5_pcnt,le.populated_fname5_pcnt,le.populated_mname5_pcnt,le.populated_lname5_pcnt,le.populated_suffix5_pcnt,le.populated_pname5_score_pcnt,le.populated_cname5_pcnt,le.populated_master_party_type_cd_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_process_date,le.maxlength_vendor,le.maxlength_state_origin,le.maxlength_county_name,le.maxlength_official_record_key,le.maxlength_doc_instrument_or_clerk_filing_num,le.maxlength_doc_filed_dt,le.maxlength_doc_type_desc,le.maxlength_entity_sequence,le.maxlength_entity_type_cd,le.maxlength_entity_type_desc,le.maxlength_entity_nm,le.maxlength_entity_nm_format,le.maxlength_entity_dob,le.maxlength_entity_ssn,le.maxlength_title1,le.maxlength_fname1,le.maxlength_mname1,le.maxlength_lname1,le.maxlength_suffix1,le.maxlength_pname1_score,le.maxlength_cname1,le.maxlength_title2,le.maxlength_fname2,le.maxlength_mname2,le.maxlength_lname2,le.maxlength_suffix2,le.maxlength_pname2_score,le.maxlength_cname2,le.maxlength_title3,le.maxlength_fname3,le.maxlength_mname3,le.maxlength_lname3,le.maxlength_suffix3,le.maxlength_pname3_score,le.maxlength_cname3,le.maxlength_title4,le.maxlength_fname4,le.maxlength_mname4,le.maxlength_lname4,le.maxlength_suffix4,le.maxlength_pname4_score,le.maxlength_cname4,le.maxlength_title5,le.maxlength_fname5,le.maxlength_mname5,le.maxlength_lname5,le.maxlength_suffix5,le.maxlength_pname5_score,le.maxlength_cname5,le.maxlength_master_party_type_cd);
  SELF.avelength := CHOOSE(C,le.avelength_process_date,le.avelength_vendor,le.avelength_state_origin,le.avelength_county_name,le.avelength_official_record_key,le.avelength_doc_instrument_or_clerk_filing_num,le.avelength_doc_filed_dt,le.avelength_doc_type_desc,le.avelength_entity_sequence,le.avelength_entity_type_cd,le.avelength_entity_type_desc,le.avelength_entity_nm,le.avelength_entity_nm_format,le.avelength_entity_dob,le.avelength_entity_ssn,le.avelength_title1,le.avelength_fname1,le.avelength_mname1,le.avelength_lname1,le.avelength_suffix1,le.avelength_pname1_score,le.avelength_cname1,le.avelength_title2,le.avelength_fname2,le.avelength_mname2,le.avelength_lname2,le.avelength_suffix2,le.avelength_pname2_score,le.avelength_cname2,le.avelength_title3,le.avelength_fname3,le.avelength_mname3,le.avelength_lname3,le.avelength_suffix3,le.avelength_pname3_score,le.avelength_cname3,le.avelength_title4,le.avelength_fname4,le.avelength_mname4,le.avelength_lname4,le.avelength_suffix4,le.avelength_pname4_score,le.avelength_cname4,le.avelength_title5,le.avelength_fname5,le.avelength_mname5,le.avelength_lname5,le.avelength_suffix5,le.avelength_pname5_score,le.avelength_cname5,le.avelength_master_party_type_cd);
END;
EXPORT invSummary := NORMALIZE(summary0, 51, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.vendor),TRIM((SALT311.StrType)le.state_origin),TRIM((SALT311.StrType)le.county_name),TRIM((SALT311.StrType)le.official_record_key),TRIM((SALT311.StrType)le.doc_instrument_or_clerk_filing_num),TRIM((SALT311.StrType)le.doc_filed_dt),TRIM((SALT311.StrType)le.doc_type_desc),TRIM((SALT311.StrType)le.entity_sequence),TRIM((SALT311.StrType)le.entity_type_cd),TRIM((SALT311.StrType)le.entity_type_desc),TRIM((SALT311.StrType)le.entity_nm),TRIM((SALT311.StrType)le.entity_nm_format),TRIM((SALT311.StrType)le.entity_dob),TRIM((SALT311.StrType)le.entity_ssn),TRIM((SALT311.StrType)le.title1),TRIM((SALT311.StrType)le.fname1),TRIM((SALT311.StrType)le.mname1),TRIM((SALT311.StrType)le.lname1),TRIM((SALT311.StrType)le.suffix1),TRIM((SALT311.StrType)le.pname1_score),TRIM((SALT311.StrType)le.cname1),TRIM((SALT311.StrType)le.title2),TRIM((SALT311.StrType)le.fname2),TRIM((SALT311.StrType)le.mname2),TRIM((SALT311.StrType)le.lname2),TRIM((SALT311.StrType)le.suffix2),TRIM((SALT311.StrType)le.pname2_score),TRIM((SALT311.StrType)le.cname2),TRIM((SALT311.StrType)le.title3),TRIM((SALT311.StrType)le.fname3),TRIM((SALT311.StrType)le.mname3),TRIM((SALT311.StrType)le.lname3),TRIM((SALT311.StrType)le.suffix3),TRIM((SALT311.StrType)le.pname3_score),TRIM((SALT311.StrType)le.cname3),TRIM((SALT311.StrType)le.title4),TRIM((SALT311.StrType)le.fname4),TRIM((SALT311.StrType)le.mname4),TRIM((SALT311.StrType)le.lname4),TRIM((SALT311.StrType)le.suffix4),TRIM((SALT311.StrType)le.pname4_score),TRIM((SALT311.StrType)le.cname4),TRIM((SALT311.StrType)le.title5),TRIM((SALT311.StrType)le.fname5),TRIM((SALT311.StrType)le.mname5),TRIM((SALT311.StrType)le.lname5),TRIM((SALT311.StrType)le.suffix5),TRIM((SALT311.StrType)le.pname5_score),TRIM((SALT311.StrType)le.cname5),TRIM((SALT311.StrType)le.master_party_type_cd)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,51,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 51);
  SELF.FldNo2 := 1 + (C % 51);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.vendor),TRIM((SALT311.StrType)le.state_origin),TRIM((SALT311.StrType)le.county_name),TRIM((SALT311.StrType)le.official_record_key),TRIM((SALT311.StrType)le.doc_instrument_or_clerk_filing_num),TRIM((SALT311.StrType)le.doc_filed_dt),TRIM((SALT311.StrType)le.doc_type_desc),TRIM((SALT311.StrType)le.entity_sequence),TRIM((SALT311.StrType)le.entity_type_cd),TRIM((SALT311.StrType)le.entity_type_desc),TRIM((SALT311.StrType)le.entity_nm),TRIM((SALT311.StrType)le.entity_nm_format),TRIM((SALT311.StrType)le.entity_dob),TRIM((SALT311.StrType)le.entity_ssn),TRIM((SALT311.StrType)le.title1),TRIM((SALT311.StrType)le.fname1),TRIM((SALT311.StrType)le.mname1),TRIM((SALT311.StrType)le.lname1),TRIM((SALT311.StrType)le.suffix1),TRIM((SALT311.StrType)le.pname1_score),TRIM((SALT311.StrType)le.cname1),TRIM((SALT311.StrType)le.title2),TRIM((SALT311.StrType)le.fname2),TRIM((SALT311.StrType)le.mname2),TRIM((SALT311.StrType)le.lname2),TRIM((SALT311.StrType)le.suffix2),TRIM((SALT311.StrType)le.pname2_score),TRIM((SALT311.StrType)le.cname2),TRIM((SALT311.StrType)le.title3),TRIM((SALT311.StrType)le.fname3),TRIM((SALT311.StrType)le.mname3),TRIM((SALT311.StrType)le.lname3),TRIM((SALT311.StrType)le.suffix3),TRIM((SALT311.StrType)le.pname3_score),TRIM((SALT311.StrType)le.cname3),TRIM((SALT311.StrType)le.title4),TRIM((SALT311.StrType)le.fname4),TRIM((SALT311.StrType)le.mname4),TRIM((SALT311.StrType)le.lname4),TRIM((SALT311.StrType)le.suffix4),TRIM((SALT311.StrType)le.pname4_score),TRIM((SALT311.StrType)le.cname4),TRIM((SALT311.StrType)le.title5),TRIM((SALT311.StrType)le.fname5),TRIM((SALT311.StrType)le.mname5),TRIM((SALT311.StrType)le.lname5),TRIM((SALT311.StrType)le.suffix5),TRIM((SALT311.StrType)le.pname5_score),TRIM((SALT311.StrType)le.cname5),TRIM((SALT311.StrType)le.master_party_type_cd)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.vendor),TRIM((SALT311.StrType)le.state_origin),TRIM((SALT311.StrType)le.county_name),TRIM((SALT311.StrType)le.official_record_key),TRIM((SALT311.StrType)le.doc_instrument_or_clerk_filing_num),TRIM((SALT311.StrType)le.doc_filed_dt),TRIM((SALT311.StrType)le.doc_type_desc),TRIM((SALT311.StrType)le.entity_sequence),TRIM((SALT311.StrType)le.entity_type_cd),TRIM((SALT311.StrType)le.entity_type_desc),TRIM((SALT311.StrType)le.entity_nm),TRIM((SALT311.StrType)le.entity_nm_format),TRIM((SALT311.StrType)le.entity_dob),TRIM((SALT311.StrType)le.entity_ssn),TRIM((SALT311.StrType)le.title1),TRIM((SALT311.StrType)le.fname1),TRIM((SALT311.StrType)le.mname1),TRIM((SALT311.StrType)le.lname1),TRIM((SALT311.StrType)le.suffix1),TRIM((SALT311.StrType)le.pname1_score),TRIM((SALT311.StrType)le.cname1),TRIM((SALT311.StrType)le.title2),TRIM((SALT311.StrType)le.fname2),TRIM((SALT311.StrType)le.mname2),TRIM((SALT311.StrType)le.lname2),TRIM((SALT311.StrType)le.suffix2),TRIM((SALT311.StrType)le.pname2_score),TRIM((SALT311.StrType)le.cname2),TRIM((SALT311.StrType)le.title3),TRIM((SALT311.StrType)le.fname3),TRIM((SALT311.StrType)le.mname3),TRIM((SALT311.StrType)le.lname3),TRIM((SALT311.StrType)le.suffix3),TRIM((SALT311.StrType)le.pname3_score),TRIM((SALT311.StrType)le.cname3),TRIM((SALT311.StrType)le.title4),TRIM((SALT311.StrType)le.fname4),TRIM((SALT311.StrType)le.mname4),TRIM((SALT311.StrType)le.lname4),TRIM((SALT311.StrType)le.suffix4),TRIM((SALT311.StrType)le.pname4_score),TRIM((SALT311.StrType)le.cname4),TRIM((SALT311.StrType)le.title5),TRIM((SALT311.StrType)le.fname5),TRIM((SALT311.StrType)le.mname5),TRIM((SALT311.StrType)le.lname5),TRIM((SALT311.StrType)le.suffix5),TRIM((SALT311.StrType)le.pname5_score),TRIM((SALT311.StrType)le.cname5),TRIM((SALT311.StrType)le.master_party_type_cd)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),51*51,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'process_date'}
      ,{2,'vendor'}
      ,{3,'state_origin'}
      ,{4,'county_name'}
      ,{5,'official_record_key'}
      ,{6,'doc_instrument_or_clerk_filing_num'}
      ,{7,'doc_filed_dt'}
      ,{8,'doc_type_desc'}
      ,{9,'entity_sequence'}
      ,{10,'entity_type_cd'}
      ,{11,'entity_type_desc'}
      ,{12,'entity_nm'}
      ,{13,'entity_nm_format'}
      ,{14,'entity_dob'}
      ,{15,'entity_ssn'}
      ,{16,'title1'}
      ,{17,'fname1'}
      ,{18,'mname1'}
      ,{19,'lname1'}
      ,{20,'suffix1'}
      ,{21,'pname1_score'}
      ,{22,'cname1'}
      ,{23,'title2'}
      ,{24,'fname2'}
      ,{25,'mname2'}
      ,{26,'lname2'}
      ,{27,'suffix2'}
      ,{28,'pname2_score'}
      ,{29,'cname2'}
      ,{30,'title3'}
      ,{31,'fname3'}
      ,{32,'mname3'}
      ,{33,'lname3'}
      ,{34,'suffix3'}
      ,{35,'pname3_score'}
      ,{36,'cname3'}
      ,{37,'title4'}
      ,{38,'fname4'}
      ,{39,'mname4'}
      ,{40,'lname4'}
      ,{41,'suffix4'}
      ,{42,'pname4_score'}
      ,{43,'cname4'}
      ,{44,'title5'}
      ,{45,'fname5'}
      ,{46,'mname5'}
      ,{47,'lname5'}
      ,{48,'suffix5'}
      ,{49,'pname5_score'}
      ,{50,'cname5'}
      ,{51,'master_party_type_cd'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Party_Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Party_Fields.InValid_vendor((SALT311.StrType)le.vendor),
    Party_Fields.InValid_state_origin((SALT311.StrType)le.state_origin),
    Party_Fields.InValid_county_name((SALT311.StrType)le.county_name),
    Party_Fields.InValid_official_record_key((SALT311.StrType)le.official_record_key),
    Party_Fields.InValid_doc_instrument_or_clerk_filing_num((SALT311.StrType)le.doc_instrument_or_clerk_filing_num),
    Party_Fields.InValid_doc_filed_dt((SALT311.StrType)le.doc_filed_dt),
    Party_Fields.InValid_doc_type_desc((SALT311.StrType)le.doc_type_desc),
    Party_Fields.InValid_entity_sequence((SALT311.StrType)le.entity_sequence),
    Party_Fields.InValid_entity_type_cd((SALT311.StrType)le.entity_type_cd),
    Party_Fields.InValid_entity_type_desc((SALT311.StrType)le.entity_type_desc),
    Party_Fields.InValid_entity_nm((SALT311.StrType)le.entity_nm),
    Party_Fields.InValid_entity_nm_format((SALT311.StrType)le.entity_nm_format),
    Party_Fields.InValid_entity_dob((SALT311.StrType)le.entity_dob),
    Party_Fields.InValid_entity_ssn((SALT311.StrType)le.entity_ssn),
    Party_Fields.InValid_title1((SALT311.StrType)le.title1),
    Party_Fields.InValid_fname1((SALT311.StrType)le.fname1),
    Party_Fields.InValid_mname1((SALT311.StrType)le.mname1),
    Party_Fields.InValid_lname1((SALT311.StrType)le.lname1),
    Party_Fields.InValid_suffix1((SALT311.StrType)le.suffix1),
    Party_Fields.InValid_pname1_score((SALT311.StrType)le.pname1_score),
    Party_Fields.InValid_cname1((SALT311.StrType)le.cname1),
    Party_Fields.InValid_title2((SALT311.StrType)le.title2),
    Party_Fields.InValid_fname2((SALT311.StrType)le.fname2),
    Party_Fields.InValid_mname2((SALT311.StrType)le.mname2),
    Party_Fields.InValid_lname2((SALT311.StrType)le.lname2),
    Party_Fields.InValid_suffix2((SALT311.StrType)le.suffix2),
    Party_Fields.InValid_pname2_score((SALT311.StrType)le.pname2_score),
    Party_Fields.InValid_cname2((SALT311.StrType)le.cname2),
    Party_Fields.InValid_title3((SALT311.StrType)le.title3),
    Party_Fields.InValid_fname3((SALT311.StrType)le.fname3),
    Party_Fields.InValid_mname3((SALT311.StrType)le.mname3),
    Party_Fields.InValid_lname3((SALT311.StrType)le.lname3),
    Party_Fields.InValid_suffix3((SALT311.StrType)le.suffix3),
    Party_Fields.InValid_pname3_score((SALT311.StrType)le.pname3_score),
    Party_Fields.InValid_cname3((SALT311.StrType)le.cname3),
    Party_Fields.InValid_title4((SALT311.StrType)le.title4),
    Party_Fields.InValid_fname4((SALT311.StrType)le.fname4),
    Party_Fields.InValid_mname4((SALT311.StrType)le.mname4),
    Party_Fields.InValid_lname4((SALT311.StrType)le.lname4),
    Party_Fields.InValid_suffix4((SALT311.StrType)le.suffix4),
    Party_Fields.InValid_pname4_score((SALT311.StrType)le.pname4_score),
    Party_Fields.InValid_cname4((SALT311.StrType)le.cname4),
    Party_Fields.InValid_title5((SALT311.StrType)le.title5),
    Party_Fields.InValid_fname5((SALT311.StrType)le.fname5),
    Party_Fields.InValid_mname5((SALT311.StrType)le.mname5),
    Party_Fields.InValid_lname5((SALT311.StrType)le.lname5),
    Party_Fields.InValid_suffix5((SALT311.StrType)le.suffix5),
    Party_Fields.InValid_pname5_score((SALT311.StrType)le.pname5_score),
    Party_Fields.InValid_cname5((SALT311.StrType)le.cname5),
    Party_Fields.InValid_master_party_type_cd((SALT311.StrType)le.master_party_type_cd),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,51,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Party_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Date','Invalid_Num','Invalid_State','Invalid_County','Invalid_NonBlank','Unknown','Invalid_Date','Invalid_NonBlank','Unknown','Invalid_NonBlank','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Num','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Num','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Num','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Num','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Num','Invalid_Char','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Party_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Party_Fields.InValidMessage_vendor(TotalErrors.ErrorNum),Party_Fields.InValidMessage_state_origin(TotalErrors.ErrorNum),Party_Fields.InValidMessage_county_name(TotalErrors.ErrorNum),Party_Fields.InValidMessage_official_record_key(TotalErrors.ErrorNum),Party_Fields.InValidMessage_doc_instrument_or_clerk_filing_num(TotalErrors.ErrorNum),Party_Fields.InValidMessage_doc_filed_dt(TotalErrors.ErrorNum),Party_Fields.InValidMessage_doc_type_desc(TotalErrors.ErrorNum),Party_Fields.InValidMessage_entity_sequence(TotalErrors.ErrorNum),Party_Fields.InValidMessage_entity_type_cd(TotalErrors.ErrorNum),Party_Fields.InValidMessage_entity_type_desc(TotalErrors.ErrorNum),Party_Fields.InValidMessage_entity_nm(TotalErrors.ErrorNum),Party_Fields.InValidMessage_entity_nm_format(TotalErrors.ErrorNum),Party_Fields.InValidMessage_entity_dob(TotalErrors.ErrorNum),Party_Fields.InValidMessage_entity_ssn(TotalErrors.ErrorNum),Party_Fields.InValidMessage_title1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_fname1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_mname1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_lname1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_suffix1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_pname1_score(TotalErrors.ErrorNum),Party_Fields.InValidMessage_cname1(TotalErrors.ErrorNum),Party_Fields.InValidMessage_title2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_fname2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_mname2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_lname2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_suffix2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_pname2_score(TotalErrors.ErrorNum),Party_Fields.InValidMessage_cname2(TotalErrors.ErrorNum),Party_Fields.InValidMessage_title3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_fname3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_mname3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_lname3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_suffix3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_pname3_score(TotalErrors.ErrorNum),Party_Fields.InValidMessage_cname3(TotalErrors.ErrorNum),Party_Fields.InValidMessage_title4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_fname4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_mname4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_lname4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_suffix4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_pname4_score(TotalErrors.ErrorNum),Party_Fields.InValidMessage_cname4(TotalErrors.ErrorNum),Party_Fields.InValidMessage_title5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_fname5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_mname5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_lname5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_suffix5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_pname5_score(TotalErrors.ErrorNum),Party_Fields.InValidMessage_cname5(TotalErrors.ErrorNum),Party_Fields.InValidMessage_master_party_type_cd(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Official_Records, Party_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
