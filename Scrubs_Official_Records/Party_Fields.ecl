IMPORT SALT311;
IMPORT Scrubs,Scrubs_Official_Records; // Import modules for FieldTypes attribute definitions
EXPORT Party_Fields := MODULE
 
EXPORT NumFields := 51;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Num','Invalid_Date','Invalid_State','Invalid_County','Invalid_NonBlank','Invalid_Char');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Num' => 1,'Invalid_Date' => 2,'Invalid_State' => 3,'Invalid_County' => 4,'Invalid_NonBlank' => 5,'Invalid_Char' => 6,0);
 
EXPORT MakeFT_Invalid_Num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_State(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['FL','CA']);
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('FL|CA'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_County(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_County(SALT311.StrType s) := WHICH(~Scrubs_Official_Records.fnValidCounty(s)>0);
EXPORT InValidMessageFT_Invalid_County(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Official_Records.fnValidCounty'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_NonBlank(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_NonBlank(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_Invalid_NonBlank(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Char(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Char(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -\''))));
EXPORT InValidMessageFT_Invalid_Char(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -\''),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'process_date','vendor','state_origin','county_name','official_record_key','doc_instrument_or_clerk_filing_num','doc_filed_dt','doc_type_desc','entity_sequence','entity_type_cd','entity_type_desc','entity_nm','entity_nm_format','entity_dob','entity_ssn','title1','fname1','mname1','lname1','suffix1','pname1_score','cname1','title2','fname2','mname2','lname2','suffix2','pname2_score','cname2','title3','fname3','mname3','lname3','suffix3','pname3_score','cname3','title4','fname4','mname4','lname4','suffix4','pname4_score','cname4','title5','fname5','mname5','lname5','suffix5','pname5_score','cname5','master_party_type_cd');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'process_date','vendor','state_origin','county_name','official_record_key','doc_instrument_or_clerk_filing_num','doc_filed_dt','doc_type_desc','entity_sequence','entity_type_cd','entity_type_desc','entity_nm','entity_nm_format','entity_dob','entity_ssn','title1','fname1','mname1','lname1','suffix1','pname1_score','cname1','title2','fname2','mname2','lname2','suffix2','pname2_score','cname2','title3','fname3','mname3','lname3','suffix3','pname3_score','cname3','title4','fname4','mname4','lname4','suffix4','pname4_score','cname4','title5','fname5','mname5','lname5','suffix5','pname5_score','cname5','master_party_type_cd');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'process_date' => 0,'vendor' => 1,'state_origin' => 2,'county_name' => 3,'official_record_key' => 4,'doc_instrument_or_clerk_filing_num' => 5,'doc_filed_dt' => 6,'doc_type_desc' => 7,'entity_sequence' => 8,'entity_type_cd' => 9,'entity_type_desc' => 10,'entity_nm' => 11,'entity_nm_format' => 12,'entity_dob' => 13,'entity_ssn' => 14,'title1' => 15,'fname1' => 16,'mname1' => 17,'lname1' => 18,'suffix1' => 19,'pname1_score' => 20,'cname1' => 21,'title2' => 22,'fname2' => 23,'mname2' => 24,'lname2' => 25,'suffix2' => 26,'pname2_score' => 27,'cname2' => 28,'title3' => 29,'fname3' => 30,'mname3' => 31,'lname3' => 32,'suffix3' => 33,'pname3_score' => 34,'cname3' => 35,'title4' => 36,'fname4' => 37,'mname4' => 38,'lname4' => 39,'suffix4' => 40,'pname4_score' => 41,'cname4' => 42,'title5' => 43,'fname5' => 44,'mname5' => 45,'lname5' => 46,'suffix5' => 47,'pname5_score' => 48,'cname5' => 49,'master_party_type_cd' => 50,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['ALLOW'],['ENUM'],['CUSTOM'],['LENGTHS'],[],['CUSTOM'],['LENGTHS'],[],['LENGTHS'],[],[],[],[],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_process_date(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_process_date(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_vendor(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_vendor(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_vendor(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_state_origin(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_state_origin(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_state_origin(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_county_name(SALT311.StrType s0) := MakeFT_Invalid_County(s0);
EXPORT InValid_county_name(SALT311.StrType s) := InValidFT_Invalid_County(s);
EXPORT InValidMessage_county_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_County(wh);
 
EXPORT Make_official_record_key(SALT311.StrType s0) := MakeFT_Invalid_NonBlank(s0);
EXPORT InValid_official_record_key(SALT311.StrType s) := InValidFT_Invalid_NonBlank(s);
EXPORT InValidMessage_official_record_key(UNSIGNED1 wh) := InValidMessageFT_Invalid_NonBlank(wh);
 
EXPORT Make_doc_instrument_or_clerk_filing_num(SALT311.StrType s0) := s0;
EXPORT InValid_doc_instrument_or_clerk_filing_num(SALT311.StrType s) := 0;
EXPORT InValidMessage_doc_instrument_or_clerk_filing_num(UNSIGNED1 wh) := '';
 
EXPORT Make_doc_filed_dt(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_doc_filed_dt(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_doc_filed_dt(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_doc_type_desc(SALT311.StrType s0) := MakeFT_Invalid_NonBlank(s0);
EXPORT InValid_doc_type_desc(SALT311.StrType s) := InValidFT_Invalid_NonBlank(s);
EXPORT InValidMessage_doc_type_desc(UNSIGNED1 wh) := InValidMessageFT_Invalid_NonBlank(wh);
 
EXPORT Make_entity_sequence(SALT311.StrType s0) := s0;
EXPORT InValid_entity_sequence(SALT311.StrType s) := 0;
EXPORT InValidMessage_entity_sequence(UNSIGNED1 wh) := '';
 
EXPORT Make_entity_type_cd(SALT311.StrType s0) := MakeFT_Invalid_NonBlank(s0);
EXPORT InValid_entity_type_cd(SALT311.StrType s) := InValidFT_Invalid_NonBlank(s);
EXPORT InValidMessage_entity_type_cd(UNSIGNED1 wh) := InValidMessageFT_Invalid_NonBlank(wh);
 
EXPORT Make_entity_type_desc(SALT311.StrType s0) := s0;
EXPORT InValid_entity_type_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_entity_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_entity_nm(SALT311.StrType s0) := s0;
EXPORT InValid_entity_nm(SALT311.StrType s) := 0;
EXPORT InValidMessage_entity_nm(UNSIGNED1 wh) := '';
 
EXPORT Make_entity_nm_format(SALT311.StrType s0) := s0;
EXPORT InValid_entity_nm_format(SALT311.StrType s) := 0;
EXPORT InValidMessage_entity_nm_format(UNSIGNED1 wh) := '';
 
EXPORT Make_entity_dob(SALT311.StrType s0) := s0;
EXPORT InValid_entity_dob(SALT311.StrType s) := 0;
EXPORT InValidMessage_entity_dob(UNSIGNED1 wh) := '';
 
EXPORT Make_entity_ssn(SALT311.StrType s0) := s0;
EXPORT InValid_entity_ssn(SALT311.StrType s) := 0;
EXPORT InValidMessage_entity_ssn(UNSIGNED1 wh) := '';
 
EXPORT Make_title1(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_title1(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_title1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_fname1(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_fname1(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_fname1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_mname1(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_mname1(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_mname1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_lname1(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_lname1(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_lname1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_suffix1(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_suffix1(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_suffix1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_pname1_score(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_pname1_score(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_pname1_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_cname1(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_cname1(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_cname1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_title2(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_title2(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_title2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_fname2(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_fname2(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_fname2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_mname2(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_mname2(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_mname2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_lname2(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_lname2(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_lname2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_suffix2(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_suffix2(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_suffix2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_pname2_score(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_pname2_score(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_pname2_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_cname2(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_cname2(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_cname2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_title3(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_title3(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_title3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_fname3(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_fname3(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_fname3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_mname3(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_mname3(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_mname3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_lname3(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_lname3(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_lname3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_suffix3(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_suffix3(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_suffix3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_pname3_score(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_pname3_score(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_pname3_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_cname3(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_cname3(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_cname3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_title4(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_title4(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_title4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_fname4(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_fname4(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_fname4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_mname4(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_mname4(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_mname4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_lname4(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_lname4(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_lname4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_suffix4(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_suffix4(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_suffix4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_pname4_score(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_pname4_score(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_pname4_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_cname4(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_cname4(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_cname4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_title5(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_title5(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_title5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_fname5(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_fname5(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_fname5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_mname5(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_mname5(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_mname5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_lname5(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_lname5(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_lname5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_suffix5(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_suffix5(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_suffix5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_pname5_score(SALT311.StrType s0) := MakeFT_Invalid_Num(s0);
EXPORT InValid_pname5_score(SALT311.StrType s) := InValidFT_Invalid_Num(s);
EXPORT InValidMessage_pname5_score(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num(wh);
 
EXPORT Make_cname5(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_cname5(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_cname5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);
 
EXPORT Make_master_party_type_cd(SALT311.StrType s0) := s0;
EXPORT InValid_master_party_type_cd(SALT311.StrType s) := 0;
EXPORT InValidMessage_master_party_type_cd(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Official_Records;
//Find those highly occuring pivot values to remove them from consideration
#uniquename(tr)
  %tr% := table(in_left+in_right,{ val := pivot_exp; });
#uniquename(r1)
  %r1% := record
    %tr%.val;    unsigned Cnt := COUNT(GROUP);
  end;
#uniquename(t1)
  %t1% := table(%tr%,%r1%,val,local); // Pre-aggregate before distribute
#uniquename(r2)
  %r2% := record
    %t1%.val;    unsigned Cnt := SUM(GROUP,%t1%.Cnt);
  end;
#uniquename(t2)
  %t2% := table(%t1%,%r2%,val); // Now do global aggregate
Bad_Pivots := %t2%(Cnt>100);
#uniquename(dl)
  %dl% := RECORD
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_vendor;
    BOOLEAN Diff_state_origin;
    BOOLEAN Diff_county_name;
    BOOLEAN Diff_official_record_key;
    BOOLEAN Diff_doc_instrument_or_clerk_filing_num;
    BOOLEAN Diff_doc_filed_dt;
    BOOLEAN Diff_doc_type_desc;
    BOOLEAN Diff_entity_sequence;
    BOOLEAN Diff_entity_type_cd;
    BOOLEAN Diff_entity_type_desc;
    BOOLEAN Diff_entity_nm;
    BOOLEAN Diff_entity_nm_format;
    BOOLEAN Diff_entity_dob;
    BOOLEAN Diff_entity_ssn;
    BOOLEAN Diff_title1;
    BOOLEAN Diff_fname1;
    BOOLEAN Diff_mname1;
    BOOLEAN Diff_lname1;
    BOOLEAN Diff_suffix1;
    BOOLEAN Diff_pname1_score;
    BOOLEAN Diff_cname1;
    BOOLEAN Diff_title2;
    BOOLEAN Diff_fname2;
    BOOLEAN Diff_mname2;
    BOOLEAN Diff_lname2;
    BOOLEAN Diff_suffix2;
    BOOLEAN Diff_pname2_score;
    BOOLEAN Diff_cname2;
    BOOLEAN Diff_title3;
    BOOLEAN Diff_fname3;
    BOOLEAN Diff_mname3;
    BOOLEAN Diff_lname3;
    BOOLEAN Diff_suffix3;
    BOOLEAN Diff_pname3_score;
    BOOLEAN Diff_cname3;
    BOOLEAN Diff_title4;
    BOOLEAN Diff_fname4;
    BOOLEAN Diff_mname4;
    BOOLEAN Diff_lname4;
    BOOLEAN Diff_suffix4;
    BOOLEAN Diff_pname4_score;
    BOOLEAN Diff_cname4;
    BOOLEAN Diff_title5;
    BOOLEAN Diff_fname5;
    BOOLEAN Diff_mname5;
    BOOLEAN Diff_lname5;
    BOOLEAN Diff_suffix5;
    BOOLEAN Diff_pname5_score;
    BOOLEAN Diff_cname5;
    BOOLEAN Diff_master_party_type_cd;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_vendor := le.vendor <> ri.vendor;
    SELF.Diff_state_origin := le.state_origin <> ri.state_origin;
    SELF.Diff_county_name := le.county_name <> ri.county_name;
    SELF.Diff_official_record_key := le.official_record_key <> ri.official_record_key;
    SELF.Diff_doc_instrument_or_clerk_filing_num := le.doc_instrument_or_clerk_filing_num <> ri.doc_instrument_or_clerk_filing_num;
    SELF.Diff_doc_filed_dt := le.doc_filed_dt <> ri.doc_filed_dt;
    SELF.Diff_doc_type_desc := le.doc_type_desc <> ri.doc_type_desc;
    SELF.Diff_entity_sequence := le.entity_sequence <> ri.entity_sequence;
    SELF.Diff_entity_type_cd := le.entity_type_cd <> ri.entity_type_cd;
    SELF.Diff_entity_type_desc := le.entity_type_desc <> ri.entity_type_desc;
    SELF.Diff_entity_nm := le.entity_nm <> ri.entity_nm;
    SELF.Diff_entity_nm_format := le.entity_nm_format <> ri.entity_nm_format;
    SELF.Diff_entity_dob := le.entity_dob <> ri.entity_dob;
    SELF.Diff_entity_ssn := le.entity_ssn <> ri.entity_ssn;
    SELF.Diff_title1 := le.title1 <> ri.title1;
    SELF.Diff_fname1 := le.fname1 <> ri.fname1;
    SELF.Diff_mname1 := le.mname1 <> ri.mname1;
    SELF.Diff_lname1 := le.lname1 <> ri.lname1;
    SELF.Diff_suffix1 := le.suffix1 <> ri.suffix1;
    SELF.Diff_pname1_score := le.pname1_score <> ri.pname1_score;
    SELF.Diff_cname1 := le.cname1 <> ri.cname1;
    SELF.Diff_title2 := le.title2 <> ri.title2;
    SELF.Diff_fname2 := le.fname2 <> ri.fname2;
    SELF.Diff_mname2 := le.mname2 <> ri.mname2;
    SELF.Diff_lname2 := le.lname2 <> ri.lname2;
    SELF.Diff_suffix2 := le.suffix2 <> ri.suffix2;
    SELF.Diff_pname2_score := le.pname2_score <> ri.pname2_score;
    SELF.Diff_cname2 := le.cname2 <> ri.cname2;
    SELF.Diff_title3 := le.title3 <> ri.title3;
    SELF.Diff_fname3 := le.fname3 <> ri.fname3;
    SELF.Diff_mname3 := le.mname3 <> ri.mname3;
    SELF.Diff_lname3 := le.lname3 <> ri.lname3;
    SELF.Diff_suffix3 := le.suffix3 <> ri.suffix3;
    SELF.Diff_pname3_score := le.pname3_score <> ri.pname3_score;
    SELF.Diff_cname3 := le.cname3 <> ri.cname3;
    SELF.Diff_title4 := le.title4 <> ri.title4;
    SELF.Diff_fname4 := le.fname4 <> ri.fname4;
    SELF.Diff_mname4 := le.mname4 <> ri.mname4;
    SELF.Diff_lname4 := le.lname4 <> ri.lname4;
    SELF.Diff_suffix4 := le.suffix4 <> ri.suffix4;
    SELF.Diff_pname4_score := le.pname4_score <> ri.pname4_score;
    SELF.Diff_cname4 := le.cname4 <> ri.cname4;
    SELF.Diff_title5 := le.title5 <> ri.title5;
    SELF.Diff_fname5 := le.fname5 <> ri.fname5;
    SELF.Diff_mname5 := le.mname5 <> ri.mname5;
    SELF.Diff_lname5 := le.lname5 <> ri.lname5;
    SELF.Diff_suffix5 := le.suffix5 <> ri.suffix5;
    SELF.Diff_pname5_score := le.pname5_score <> ri.pname5_score;
    SELF.Diff_cname5 := le.cname5 <> ri.cname5;
    SELF.Diff_master_party_type_cd := le.master_party_type_cd <> ri.master_party_type_cd;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_vendor,1,0)+ IF( SELF.Diff_state_origin,1,0)+ IF( SELF.Diff_county_name,1,0)+ IF( SELF.Diff_official_record_key,1,0)+ IF( SELF.Diff_doc_instrument_or_clerk_filing_num,1,0)+ IF( SELF.Diff_doc_filed_dt,1,0)+ IF( SELF.Diff_doc_type_desc,1,0)+ IF( SELF.Diff_entity_sequence,1,0)+ IF( SELF.Diff_entity_type_cd,1,0)+ IF( SELF.Diff_entity_type_desc,1,0)+ IF( SELF.Diff_entity_nm,1,0)+ IF( SELF.Diff_entity_nm_format,1,0)+ IF( SELF.Diff_entity_dob,1,0)+ IF( SELF.Diff_entity_ssn,1,0)+ IF( SELF.Diff_title1,1,0)+ IF( SELF.Diff_fname1,1,0)+ IF( SELF.Diff_mname1,1,0)+ IF( SELF.Diff_lname1,1,0)+ IF( SELF.Diff_suffix1,1,0)+ IF( SELF.Diff_pname1_score,1,0)+ IF( SELF.Diff_cname1,1,0)+ IF( SELF.Diff_title2,1,0)+ IF( SELF.Diff_fname2,1,0)+ IF( SELF.Diff_mname2,1,0)+ IF( SELF.Diff_lname2,1,0)+ IF( SELF.Diff_suffix2,1,0)+ IF( SELF.Diff_pname2_score,1,0)+ IF( SELF.Diff_cname2,1,0)+ IF( SELF.Diff_title3,1,0)+ IF( SELF.Diff_fname3,1,0)+ IF( SELF.Diff_mname3,1,0)+ IF( SELF.Diff_lname3,1,0)+ IF( SELF.Diff_suffix3,1,0)+ IF( SELF.Diff_pname3_score,1,0)+ IF( SELF.Diff_cname3,1,0)+ IF( SELF.Diff_title4,1,0)+ IF( SELF.Diff_fname4,1,0)+ IF( SELF.Diff_mname4,1,0)+ IF( SELF.Diff_lname4,1,0)+ IF( SELF.Diff_suffix4,1,0)+ IF( SELF.Diff_pname4_score,1,0)+ IF( SELF.Diff_cname4,1,0)+ IF( SELF.Diff_title5,1,0)+ IF( SELF.Diff_fname5,1,0)+ IF( SELF.Diff_mname5,1,0)+ IF( SELF.Diff_lname5,1,0)+ IF( SELF.Diff_suffix5,1,0)+ IF( SELF.Diff_pname5_score,1,0)+ IF( SELF.Diff_cname5,1,0)+ IF( SELF.Diff_master_party_type_cd,1,0);
  END;
// Now need to remove bad pivots from comparison
#uniquename(L)
  %L% := JOIN(in_left,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(R)
  %R% := JOIN(in_right,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(DiffL)
  %DiffL% := JOIN(%L%,%R%,evaluate(left,pivot_exp)=evaluate(right,pivot_exp),%fd%(left,right),hash);
#uniquename(Closest)
  %Closest% := DEDUP(SORT(%DiffL%,Val,Num_Diffs,local),Val,local); // Join will have distributed by pivot_exp
#uniquename(AggRec)
  %AggRec% := RECORD
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_vendor := COUNT(GROUP,%Closest%.Diff_vendor);
    Count_Diff_state_origin := COUNT(GROUP,%Closest%.Diff_state_origin);
    Count_Diff_county_name := COUNT(GROUP,%Closest%.Diff_county_name);
    Count_Diff_official_record_key := COUNT(GROUP,%Closest%.Diff_official_record_key);
    Count_Diff_doc_instrument_or_clerk_filing_num := COUNT(GROUP,%Closest%.Diff_doc_instrument_or_clerk_filing_num);
    Count_Diff_doc_filed_dt := COUNT(GROUP,%Closest%.Diff_doc_filed_dt);
    Count_Diff_doc_type_desc := COUNT(GROUP,%Closest%.Diff_doc_type_desc);
    Count_Diff_entity_sequence := COUNT(GROUP,%Closest%.Diff_entity_sequence);
    Count_Diff_entity_type_cd := COUNT(GROUP,%Closest%.Diff_entity_type_cd);
    Count_Diff_entity_type_desc := COUNT(GROUP,%Closest%.Diff_entity_type_desc);
    Count_Diff_entity_nm := COUNT(GROUP,%Closest%.Diff_entity_nm);
    Count_Diff_entity_nm_format := COUNT(GROUP,%Closest%.Diff_entity_nm_format);
    Count_Diff_entity_dob := COUNT(GROUP,%Closest%.Diff_entity_dob);
    Count_Diff_entity_ssn := COUNT(GROUP,%Closest%.Diff_entity_ssn);
    Count_Diff_title1 := COUNT(GROUP,%Closest%.Diff_title1);
    Count_Diff_fname1 := COUNT(GROUP,%Closest%.Diff_fname1);
    Count_Diff_mname1 := COUNT(GROUP,%Closest%.Diff_mname1);
    Count_Diff_lname1 := COUNT(GROUP,%Closest%.Diff_lname1);
    Count_Diff_suffix1 := COUNT(GROUP,%Closest%.Diff_suffix1);
    Count_Diff_pname1_score := COUNT(GROUP,%Closest%.Diff_pname1_score);
    Count_Diff_cname1 := COUNT(GROUP,%Closest%.Diff_cname1);
    Count_Diff_title2 := COUNT(GROUP,%Closest%.Diff_title2);
    Count_Diff_fname2 := COUNT(GROUP,%Closest%.Diff_fname2);
    Count_Diff_mname2 := COUNT(GROUP,%Closest%.Diff_mname2);
    Count_Diff_lname2 := COUNT(GROUP,%Closest%.Diff_lname2);
    Count_Diff_suffix2 := COUNT(GROUP,%Closest%.Diff_suffix2);
    Count_Diff_pname2_score := COUNT(GROUP,%Closest%.Diff_pname2_score);
    Count_Diff_cname2 := COUNT(GROUP,%Closest%.Diff_cname2);
    Count_Diff_title3 := COUNT(GROUP,%Closest%.Diff_title3);
    Count_Diff_fname3 := COUNT(GROUP,%Closest%.Diff_fname3);
    Count_Diff_mname3 := COUNT(GROUP,%Closest%.Diff_mname3);
    Count_Diff_lname3 := COUNT(GROUP,%Closest%.Diff_lname3);
    Count_Diff_suffix3 := COUNT(GROUP,%Closest%.Diff_suffix3);
    Count_Diff_pname3_score := COUNT(GROUP,%Closest%.Diff_pname3_score);
    Count_Diff_cname3 := COUNT(GROUP,%Closest%.Diff_cname3);
    Count_Diff_title4 := COUNT(GROUP,%Closest%.Diff_title4);
    Count_Diff_fname4 := COUNT(GROUP,%Closest%.Diff_fname4);
    Count_Diff_mname4 := COUNT(GROUP,%Closest%.Diff_mname4);
    Count_Diff_lname4 := COUNT(GROUP,%Closest%.Diff_lname4);
    Count_Diff_suffix4 := COUNT(GROUP,%Closest%.Diff_suffix4);
    Count_Diff_pname4_score := COUNT(GROUP,%Closest%.Diff_pname4_score);
    Count_Diff_cname4 := COUNT(GROUP,%Closest%.Diff_cname4);
    Count_Diff_title5 := COUNT(GROUP,%Closest%.Diff_title5);
    Count_Diff_fname5 := COUNT(GROUP,%Closest%.Diff_fname5);
    Count_Diff_mname5 := COUNT(GROUP,%Closest%.Diff_mname5);
    Count_Diff_lname5 := COUNT(GROUP,%Closest%.Diff_lname5);
    Count_Diff_suffix5 := COUNT(GROUP,%Closest%.Diff_suffix5);
    Count_Diff_pname5_score := COUNT(GROUP,%Closest%.Diff_pname5_score);
    Count_Diff_cname5 := COUNT(GROUP,%Closest%.Diff_cname5);
    Count_Diff_master_party_type_cd := COUNT(GROUP,%Closest%.Diff_master_party_type_cd);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
