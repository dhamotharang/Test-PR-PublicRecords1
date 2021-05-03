IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Pol_Fields := MODULE
 
EXPORT NumFields := 61;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Date','Invalid_No','Invalid_Float','Invalid_Alpha','Invalid_AlphaNum','Invalid_AlphaChar','Invalid_AlphaNumChar','Invalid_State','Invalid_Zip','Invalid_Phone');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Date' => 1,'Invalid_No' => 2,'Invalid_Float' => 3,'Invalid_Alpha' => 4,'Invalid_AlphaNum' => 5,'Invalid_AlphaChar' => 6,'Invalid_AlphaNumChar' => 7,'Invalid_State' => 8,'Invalid_Zip' => 9,'Invalid_Phone' => 10,0);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Scrubs.Fn_Valid_Date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Fn_Valid_Date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_No(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789NA'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_No(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789NA'))));
EXPORT InValidMessageFT_Invalid_No(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789NA'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Float(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789,.-/NA'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Float(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789,.-/NA'))));
EXPORT InValidMessageFT_Invalid_Float(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789,.-/NA'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Alpha(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Alpha(SALT311.StrType s) := WHICH(~Scrubs.Fn_Allow_ws(s,'Alpha')>0);
EXPORT InValidMessageFT_Invalid_Alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Fn_Allow_ws'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNum(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_AlphaNum(SALT311.StrType s) := WHICH(~Scrubs.Fn_Allow_ws(s,'AlphaNum')>0);
EXPORT InValidMessageFT_Invalid_AlphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Fn_Allow_ws'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaChar(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_AlphaChar(SALT311.StrType s) := WHICH(~Scrubs.Fn_Allow_ws(s,'AlphaChar')>0);
EXPORT InValidMessageFT_Invalid_AlphaChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Fn_Allow_ws'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNumChar(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_AlphaNumChar(SALT311.StrType s) := WHICH(~Scrubs.Fn_Allow_ws(s,'AlphaNumChar')>0);
EXPORT InValidMessageFT_Invalid_AlphaNumChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Fn_Allow_ws'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT311.StrType s0) := FUNCTION
  RETURN  MakeFT_Invalid_Alpha(s0);
END;
EXPORT InValidFT_Invalid_State(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('0,2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789,.-/NA'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_Float(s1);
END;
EXPORT InValidFT_Invalid_Zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789,.-/NA'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_Invalid_Zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789,.-/NA'),SALT311.HygieneErrors.NotLength('0,5,9'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Phone(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789NA'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_No(s1);
END;
EXPORT InValidFT_Invalid_Phone(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789NA'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_Invalid_Phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789NA'),SALT311.HygieneErrors.NotLength('0,9,10'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'date_firstseen','date_lastseen','bdid','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','lninscertrecordid','dartid','insuranceprovider','policynumber','coveragestartdate','coverageexpirationdate','coveragewrapup','policystatus','insuranceprovideraddressline','insuranceprovideraddressline2','insuranceprovidercity','insuranceproviderstate','insuranceproviderzip','insuranceproviderzip4','insuranceproviderphone','insuranceproviderfax','coveragereinstatedate','coveragecancellationdate','coveragewrapupdate','businessnameduringcoverage','addresslineduringcoverage','addressline2duringcoverage','cityduringcoverage','stateduringcoverage','zipduringcoverage','zip4duringcoverage','numberofemployeesduringcoverage','insuranceprovidercontactdept','insurancetype','coverageposteddate','coverageamountfrom','coverageamountto','unique_id','append_mailaddress1','append_mailaddresslast','append_mailrawaid','append_mailaceaid');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'date_firstseen','date_lastseen','bdid','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','lninscertrecordid','dartid','insuranceprovider','policynumber','coveragestartdate','coverageexpirationdate','coveragewrapup','policystatus','insuranceprovideraddressline','insuranceprovideraddressline2','insuranceprovidercity','insuranceproviderstate','insuranceproviderzip','insuranceproviderzip4','insuranceproviderphone','insuranceproviderfax','coveragereinstatedate','coveragecancellationdate','coveragewrapupdate','businessnameduringcoverage','addresslineduringcoverage','addressline2duringcoverage','cityduringcoverage','stateduringcoverage','zipduringcoverage','zip4duringcoverage','numberofemployeesduringcoverage','insuranceprovidercontactdept','insurancetype','coverageposteddate','coverageamountfrom','coverageamountto','unique_id','append_mailaddress1','append_mailaddresslast','append_mailrawaid','append_mailaceaid');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'date_firstseen' => 0,'date_lastseen' => 1,'bdid' => 2,'dotid' => 3,'dotscore' => 4,'dotweight' => 5,'empid' => 6,'empscore' => 7,'empweight' => 8,'powid' => 9,'powscore' => 10,'powweight' => 11,'proxid' => 12,'proxscore' => 13,'proxweight' => 14,'seleid' => 15,'selescore' => 16,'seleweight' => 17,'orgid' => 18,'orgscore' => 19,'orgweight' => 20,'ultid' => 21,'ultscore' => 22,'ultweight' => 23,'lninscertrecordid' => 24,'dartid' => 25,'insuranceprovider' => 26,'policynumber' => 27,'coveragestartdate' => 28,'coverageexpirationdate' => 29,'coveragewrapup' => 30,'policystatus' => 31,'insuranceprovideraddressline' => 32,'insuranceprovideraddressline2' => 33,'insuranceprovidercity' => 34,'insuranceproviderstate' => 35,'insuranceproviderzip' => 36,'insuranceproviderzip4' => 37,'insuranceproviderphone' => 38,'insuranceproviderfax' => 39,'coveragereinstatedate' => 40,'coveragecancellationdate' => 41,'coveragewrapupdate' => 42,'businessnameduringcoverage' => 43,'addresslineduringcoverage' => 44,'addressline2duringcoverage' => 45,'cityduringcoverage' => 46,'stateduringcoverage' => 47,'zipduringcoverage' => 48,'zip4duringcoverage' => 49,'numberofemployeesduringcoverage' => 50,'insuranceprovidercontactdept' => 51,'insurancetype' => 52,'coverageposteddate' => 53,'coverageamountfrom' => 54,'coverageamountto' => 55,'unique_id' => 56,'append_mailaddress1' => 57,'append_mailaddresslast' => 58,'append_mailrawaid' => 59,'append_mailaceaid' => 60,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],[],['CUSTOM'],['CUSTOM'],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_date_firstseen(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_firstseen(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_firstseen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_date_lastseen(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_date_lastseen(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_date_lastseen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_bdid(SALT311.StrType s0) := s0;
EXPORT InValid_bdid(SALT311.StrType s) := 0;
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := '';
 
EXPORT Make_dotid(SALT311.StrType s0) := s0;
EXPORT InValid_dotid(SALT311.StrType s) := 0;
EXPORT InValidMessage_dotid(UNSIGNED1 wh) := '';
 
EXPORT Make_dotscore(SALT311.StrType s0) := s0;
EXPORT InValid_dotscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_dotscore(UNSIGNED1 wh) := '';
 
EXPORT Make_dotweight(SALT311.StrType s0) := s0;
EXPORT InValid_dotweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_dotweight(UNSIGNED1 wh) := '';
 
EXPORT Make_empid(SALT311.StrType s0) := s0;
EXPORT InValid_empid(SALT311.StrType s) := 0;
EXPORT InValidMessage_empid(UNSIGNED1 wh) := '';
 
EXPORT Make_empscore(SALT311.StrType s0) := s0;
EXPORT InValid_empscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_empscore(UNSIGNED1 wh) := '';
 
EXPORT Make_empweight(SALT311.StrType s0) := s0;
EXPORT InValid_empweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_empweight(UNSIGNED1 wh) := '';
 
EXPORT Make_powid(SALT311.StrType s0) := s0;
EXPORT InValid_powid(SALT311.StrType s) := 0;
EXPORT InValidMessage_powid(UNSIGNED1 wh) := '';
 
EXPORT Make_powscore(SALT311.StrType s0) := s0;
EXPORT InValid_powscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_powscore(UNSIGNED1 wh) := '';
 
EXPORT Make_powweight(SALT311.StrType s0) := s0;
EXPORT InValid_powweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_powweight(UNSIGNED1 wh) := '';
 
EXPORT Make_proxid(SALT311.StrType s0) := s0;
EXPORT InValid_proxid(SALT311.StrType s) := 0;
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := '';
 
EXPORT Make_proxscore(SALT311.StrType s0) := s0;
EXPORT InValid_proxscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_proxscore(UNSIGNED1 wh) := '';
 
EXPORT Make_proxweight(SALT311.StrType s0) := s0;
EXPORT InValid_proxweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_proxweight(UNSIGNED1 wh) := '';
 
EXPORT Make_seleid(SALT311.StrType s0) := s0;
EXPORT InValid_seleid(SALT311.StrType s) := 0;
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := '';
 
EXPORT Make_selescore(SALT311.StrType s0) := s0;
EXPORT InValid_selescore(SALT311.StrType s) := 0;
EXPORT InValidMessage_selescore(UNSIGNED1 wh) := '';
 
EXPORT Make_seleweight(SALT311.StrType s0) := s0;
EXPORT InValid_seleweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_seleweight(UNSIGNED1 wh) := '';
 
EXPORT Make_orgid(SALT311.StrType s0) := s0;
EXPORT InValid_orgid(SALT311.StrType s) := 0;
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := '';
 
EXPORT Make_orgscore(SALT311.StrType s0) := s0;
EXPORT InValid_orgscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_orgscore(UNSIGNED1 wh) := '';
 
EXPORT Make_orgweight(SALT311.StrType s0) := s0;
EXPORT InValid_orgweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_orgweight(UNSIGNED1 wh) := '';
 
EXPORT Make_ultid(SALT311.StrType s0) := s0;
EXPORT InValid_ultid(SALT311.StrType s) := 0;
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := '';
 
EXPORT Make_ultscore(SALT311.StrType s0) := s0;
EXPORT InValid_ultscore(SALT311.StrType s) := 0;
EXPORT InValidMessage_ultscore(UNSIGNED1 wh) := '';
 
EXPORT Make_ultweight(SALT311.StrType s0) := s0;
EXPORT InValid_ultweight(SALT311.StrType s) := 0;
EXPORT InValidMessage_ultweight(UNSIGNED1 wh) := '';
 
EXPORT Make_lninscertrecordid(SALT311.StrType s0) := s0;
EXPORT InValid_lninscertrecordid(SALT311.StrType s) := 0;
EXPORT InValidMessage_lninscertrecordid(UNSIGNED1 wh) := '';
 
EXPORT Make_dartid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_dartid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_dartid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_insuranceprovider(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_insuranceprovider(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_insuranceprovider(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_policynumber(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_policynumber(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_policynumber(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_coveragestartdate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_coveragestartdate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_coveragestartdate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_coverageexpirationdate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_coverageexpirationdate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_coverageexpirationdate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_coveragewrapup(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_coveragewrapup(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_coveragewrapup(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_policystatus(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_policystatus(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_policystatus(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_insuranceprovideraddressline(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_insuranceprovideraddressline(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_insuranceprovideraddressline(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_insuranceprovideraddressline2(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_insuranceprovideraddressline2(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_insuranceprovideraddressline2(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_insuranceprovidercity(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_insuranceprovidercity(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_insuranceprovidercity(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_insuranceproviderstate(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_insuranceproviderstate(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_insuranceproviderstate(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_insuranceproviderzip(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_insuranceproviderzip(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_insuranceproviderzip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_insuranceproviderzip4(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_insuranceproviderzip4(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_insuranceproviderzip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_insuranceproviderphone(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_insuranceproviderphone(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_insuranceproviderphone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_insuranceproviderfax(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_insuranceproviderfax(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_insuranceproviderfax(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_coveragereinstatedate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_coveragereinstatedate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_coveragereinstatedate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_coveragecancellationdate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_coveragecancellationdate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_coveragecancellationdate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_coveragewrapupdate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_coveragewrapupdate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_coveragewrapupdate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_businessnameduringcoverage(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_businessnameduringcoverage(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_businessnameduringcoverage(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_addresslineduringcoverage(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_addresslineduringcoverage(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_addresslineduringcoverage(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_addressline2duringcoverage(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_addressline2duringcoverage(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_addressline2duringcoverage(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_cityduringcoverage(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_cityduringcoverage(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_cityduringcoverage(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_stateduringcoverage(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_stateduringcoverage(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_stateduringcoverage(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_zipduringcoverage(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_zipduringcoverage(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_zipduringcoverage(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_zip4duringcoverage(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_zip4duringcoverage(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_zip4duringcoverage(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_numberofemployeesduringcoverage(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_numberofemployeesduringcoverage(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_numberofemployeesduringcoverage(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_insuranceprovidercontactdept(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_insuranceprovidercontactdept(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_insuranceprovidercontactdept(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_insurancetype(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_insurancetype(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_insurancetype(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_coverageposteddate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_coverageposteddate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_coverageposteddate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_coverageamountfrom(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_coverageamountfrom(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_coverageamountfrom(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_coverageamountto(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_coverageamountto(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_coverageamountto(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_unique_id(SALT311.StrType s0) := s0;
EXPORT InValid_unique_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_unique_id(UNSIGNED1 wh) := '';
 
EXPORT Make_append_mailaddress1(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_append_mailaddress1(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_append_mailaddress1(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_append_mailaddresslast(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_append_mailaddresslast(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_append_mailaddresslast(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_append_mailrawaid(SALT311.StrType s0) := s0;
EXPORT InValid_append_mailrawaid(SALT311.StrType s) := 0;
EXPORT InValidMessage_append_mailrawaid(UNSIGNED1 wh) := '';
 
EXPORT Make_append_mailaceaid(SALT311.StrType s0) := s0;
EXPORT InValid_append_mailaceaid(SALT311.StrType s) := 0;
EXPORT InValidMessage_append_mailaceaid(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Insurance_Cert;
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
    BOOLEAN Diff_date_firstseen;
    BOOLEAN Diff_date_lastseen;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_dotid;
    BOOLEAN Diff_dotscore;
    BOOLEAN Diff_dotweight;
    BOOLEAN Diff_empid;
    BOOLEAN Diff_empscore;
    BOOLEAN Diff_empweight;
    BOOLEAN Diff_powid;
    BOOLEAN Diff_powscore;
    BOOLEAN Diff_powweight;
    BOOLEAN Diff_proxid;
    BOOLEAN Diff_proxscore;
    BOOLEAN Diff_proxweight;
    BOOLEAN Diff_seleid;
    BOOLEAN Diff_selescore;
    BOOLEAN Diff_seleweight;
    BOOLEAN Diff_orgid;
    BOOLEAN Diff_orgscore;
    BOOLEAN Diff_orgweight;
    BOOLEAN Diff_ultid;
    BOOLEAN Diff_ultscore;
    BOOLEAN Diff_ultweight;
    BOOLEAN Diff_lninscertrecordid;
    BOOLEAN Diff_dartid;
    BOOLEAN Diff_insuranceprovider;
    BOOLEAN Diff_policynumber;
    BOOLEAN Diff_coveragestartdate;
    BOOLEAN Diff_coverageexpirationdate;
    BOOLEAN Diff_coveragewrapup;
    BOOLEAN Diff_policystatus;
    BOOLEAN Diff_insuranceprovideraddressline;
    BOOLEAN Diff_insuranceprovideraddressline2;
    BOOLEAN Diff_insuranceprovidercity;
    BOOLEAN Diff_insuranceproviderstate;
    BOOLEAN Diff_insuranceproviderzip;
    BOOLEAN Diff_insuranceproviderzip4;
    BOOLEAN Diff_insuranceproviderphone;
    BOOLEAN Diff_insuranceproviderfax;
    BOOLEAN Diff_coveragereinstatedate;
    BOOLEAN Diff_coveragecancellationdate;
    BOOLEAN Diff_coveragewrapupdate;
    BOOLEAN Diff_businessnameduringcoverage;
    BOOLEAN Diff_addresslineduringcoverage;
    BOOLEAN Diff_addressline2duringcoverage;
    BOOLEAN Diff_cityduringcoverage;
    BOOLEAN Diff_stateduringcoverage;
    BOOLEAN Diff_zipduringcoverage;
    BOOLEAN Diff_zip4duringcoverage;
    BOOLEAN Diff_numberofemployeesduringcoverage;
    BOOLEAN Diff_insuranceprovidercontactdept;
    BOOLEAN Diff_insurancetype;
    BOOLEAN Diff_coverageposteddate;
    BOOLEAN Diff_coverageamountfrom;
    BOOLEAN Diff_coverageamountto;
    BOOLEAN Diff_unique_id;
    BOOLEAN Diff_append_mailaddress1;
    BOOLEAN Diff_append_mailaddresslast;
    BOOLEAN Diff_append_mailrawaid;
    BOOLEAN Diff_append_mailaceaid;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_date_firstseen := le.date_firstseen <> ri.date_firstseen;
    SELF.Diff_date_lastseen := le.date_lastseen <> ri.date_lastseen;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_dotid := le.dotid <> ri.dotid;
    SELF.Diff_dotscore := le.dotscore <> ri.dotscore;
    SELF.Diff_dotweight := le.dotweight <> ri.dotweight;
    SELF.Diff_empid := le.empid <> ri.empid;
    SELF.Diff_empscore := le.empscore <> ri.empscore;
    SELF.Diff_empweight := le.empweight <> ri.empweight;
    SELF.Diff_powid := le.powid <> ri.powid;
    SELF.Diff_powscore := le.powscore <> ri.powscore;
    SELF.Diff_powweight := le.powweight <> ri.powweight;
    SELF.Diff_proxid := le.proxid <> ri.proxid;
    SELF.Diff_proxscore := le.proxscore <> ri.proxscore;
    SELF.Diff_proxweight := le.proxweight <> ri.proxweight;
    SELF.Diff_seleid := le.seleid <> ri.seleid;
    SELF.Diff_selescore := le.selescore <> ri.selescore;
    SELF.Diff_seleweight := le.seleweight <> ri.seleweight;
    SELF.Diff_orgid := le.orgid <> ri.orgid;
    SELF.Diff_orgscore := le.orgscore <> ri.orgscore;
    SELF.Diff_orgweight := le.orgweight <> ri.orgweight;
    SELF.Diff_ultid := le.ultid <> ri.ultid;
    SELF.Diff_ultscore := le.ultscore <> ri.ultscore;
    SELF.Diff_ultweight := le.ultweight <> ri.ultweight;
    SELF.Diff_lninscertrecordid := le.lninscertrecordid <> ri.lninscertrecordid;
    SELF.Diff_dartid := le.dartid <> ri.dartid;
    SELF.Diff_insuranceprovider := le.insuranceprovider <> ri.insuranceprovider;
    SELF.Diff_policynumber := le.policynumber <> ri.policynumber;
    SELF.Diff_coveragestartdate := le.coveragestartdate <> ri.coveragestartdate;
    SELF.Diff_coverageexpirationdate := le.coverageexpirationdate <> ri.coverageexpirationdate;
    SELF.Diff_coveragewrapup := le.coveragewrapup <> ri.coveragewrapup;
    SELF.Diff_policystatus := le.policystatus <> ri.policystatus;
    SELF.Diff_insuranceprovideraddressline := le.insuranceprovideraddressline <> ri.insuranceprovideraddressline;
    SELF.Diff_insuranceprovideraddressline2 := le.insuranceprovideraddressline2 <> ri.insuranceprovideraddressline2;
    SELF.Diff_insuranceprovidercity := le.insuranceprovidercity <> ri.insuranceprovidercity;
    SELF.Diff_insuranceproviderstate := le.insuranceproviderstate <> ri.insuranceproviderstate;
    SELF.Diff_insuranceproviderzip := le.insuranceproviderzip <> ri.insuranceproviderzip;
    SELF.Diff_insuranceproviderzip4 := le.insuranceproviderzip4 <> ri.insuranceproviderzip4;
    SELF.Diff_insuranceproviderphone := le.insuranceproviderphone <> ri.insuranceproviderphone;
    SELF.Diff_insuranceproviderfax := le.insuranceproviderfax <> ri.insuranceproviderfax;
    SELF.Diff_coveragereinstatedate := le.coveragereinstatedate <> ri.coveragereinstatedate;
    SELF.Diff_coveragecancellationdate := le.coveragecancellationdate <> ri.coveragecancellationdate;
    SELF.Diff_coveragewrapupdate := le.coveragewrapupdate <> ri.coveragewrapupdate;
    SELF.Diff_businessnameduringcoverage := le.businessnameduringcoverage <> ri.businessnameduringcoverage;
    SELF.Diff_addresslineduringcoverage := le.addresslineduringcoverage <> ri.addresslineduringcoverage;
    SELF.Diff_addressline2duringcoverage := le.addressline2duringcoverage <> ri.addressline2duringcoverage;
    SELF.Diff_cityduringcoverage := le.cityduringcoverage <> ri.cityduringcoverage;
    SELF.Diff_stateduringcoverage := le.stateduringcoverage <> ri.stateduringcoverage;
    SELF.Diff_zipduringcoverage := le.zipduringcoverage <> ri.zipduringcoverage;
    SELF.Diff_zip4duringcoverage := le.zip4duringcoverage <> ri.zip4duringcoverage;
    SELF.Diff_numberofemployeesduringcoverage := le.numberofemployeesduringcoverage <> ri.numberofemployeesduringcoverage;
    SELF.Diff_insuranceprovidercontactdept := le.insuranceprovidercontactdept <> ri.insuranceprovidercontactdept;
    SELF.Diff_insurancetype := le.insurancetype <> ri.insurancetype;
    SELF.Diff_coverageposteddate := le.coverageposteddate <> ri.coverageposteddate;
    SELF.Diff_coverageamountfrom := le.coverageamountfrom <> ri.coverageamountfrom;
    SELF.Diff_coverageamountto := le.coverageamountto <> ri.coverageamountto;
    SELF.Diff_unique_id := le.unique_id <> ri.unique_id;
    SELF.Diff_append_mailaddress1 := le.append_mailaddress1 <> ri.append_mailaddress1;
    SELF.Diff_append_mailaddresslast := le.append_mailaddresslast <> ri.append_mailaddresslast;
    SELF.Diff_append_mailrawaid := le.append_mailrawaid <> ri.append_mailrawaid;
    SELF.Diff_append_mailaceaid := le.append_mailaceaid <> ri.append_mailaceaid;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_date_firstseen,1,0)+ IF( SELF.Diff_date_lastseen,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_dotid,1,0)+ IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_selescore,1,0)+ IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ IF( SELF.Diff_ultweight,1,0)+ IF( SELF.Diff_lninscertrecordid,1,0)+ IF( SELF.Diff_dartid,1,0)+ IF( SELF.Diff_insuranceprovider,1,0)+ IF( SELF.Diff_policynumber,1,0)+ IF( SELF.Diff_coveragestartdate,1,0)+ IF( SELF.Diff_coverageexpirationdate,1,0)+ IF( SELF.Diff_coveragewrapup,1,0)+ IF( SELF.Diff_policystatus,1,0)+ IF( SELF.Diff_insuranceprovideraddressline,1,0)+ IF( SELF.Diff_insuranceprovideraddressline2,1,0)+ IF( SELF.Diff_insuranceprovidercity,1,0)+ IF( SELF.Diff_insuranceproviderstate,1,0)+ IF( SELF.Diff_insuranceproviderzip,1,0)+ IF( SELF.Diff_insuranceproviderzip4,1,0)+ IF( SELF.Diff_insuranceproviderphone,1,0)+ IF( SELF.Diff_insuranceproviderfax,1,0)+ IF( SELF.Diff_coveragereinstatedate,1,0)+ IF( SELF.Diff_coveragecancellationdate,1,0)+ IF( SELF.Diff_coveragewrapupdate,1,0)+ IF( SELF.Diff_businessnameduringcoverage,1,0)+ IF( SELF.Diff_addresslineduringcoverage,1,0)+ IF( SELF.Diff_addressline2duringcoverage,1,0)+ IF( SELF.Diff_cityduringcoverage,1,0)+ IF( SELF.Diff_stateduringcoverage,1,0)+ IF( SELF.Diff_zipduringcoverage,1,0)+ IF( SELF.Diff_zip4duringcoverage,1,0)+ IF( SELF.Diff_numberofemployeesduringcoverage,1,0)+ IF( SELF.Diff_insuranceprovidercontactdept,1,0)+ IF( SELF.Diff_insurancetype,1,0)+ IF( SELF.Diff_coverageposteddate,1,0)+ IF( SELF.Diff_coverageamountfrom,1,0)+ IF( SELF.Diff_coverageamountto,1,0)+ IF( SELF.Diff_unique_id,1,0)+ IF( SELF.Diff_append_mailaddress1,1,0)+ IF( SELF.Diff_append_mailaddresslast,1,0)+ IF( SELF.Diff_append_mailrawaid,1,0)+ IF( SELF.Diff_append_mailaceaid,1,0);
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
    Count_Diff_date_firstseen := COUNT(GROUP,%Closest%.Diff_date_firstseen);
    Count_Diff_date_lastseen := COUNT(GROUP,%Closest%.Diff_date_lastseen);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_dotid := COUNT(GROUP,%Closest%.Diff_dotid);
    Count_Diff_dotscore := COUNT(GROUP,%Closest%.Diff_dotscore);
    Count_Diff_dotweight := COUNT(GROUP,%Closest%.Diff_dotweight);
    Count_Diff_empid := COUNT(GROUP,%Closest%.Diff_empid);
    Count_Diff_empscore := COUNT(GROUP,%Closest%.Diff_empscore);
    Count_Diff_empweight := COUNT(GROUP,%Closest%.Diff_empweight);
    Count_Diff_powid := COUNT(GROUP,%Closest%.Diff_powid);
    Count_Diff_powscore := COUNT(GROUP,%Closest%.Diff_powscore);
    Count_Diff_powweight := COUNT(GROUP,%Closest%.Diff_powweight);
    Count_Diff_proxid := COUNT(GROUP,%Closest%.Diff_proxid);
    Count_Diff_proxscore := COUNT(GROUP,%Closest%.Diff_proxscore);
    Count_Diff_proxweight := COUNT(GROUP,%Closest%.Diff_proxweight);
    Count_Diff_seleid := COUNT(GROUP,%Closest%.Diff_seleid);
    Count_Diff_selescore := COUNT(GROUP,%Closest%.Diff_selescore);
    Count_Diff_seleweight := COUNT(GROUP,%Closest%.Diff_seleweight);
    Count_Diff_orgid := COUNT(GROUP,%Closest%.Diff_orgid);
    Count_Diff_orgscore := COUNT(GROUP,%Closest%.Diff_orgscore);
    Count_Diff_orgweight := COUNT(GROUP,%Closest%.Diff_orgweight);
    Count_Diff_ultid := COUNT(GROUP,%Closest%.Diff_ultid);
    Count_Diff_ultscore := COUNT(GROUP,%Closest%.Diff_ultscore);
    Count_Diff_ultweight := COUNT(GROUP,%Closest%.Diff_ultweight);
    Count_Diff_lninscertrecordid := COUNT(GROUP,%Closest%.Diff_lninscertrecordid);
    Count_Diff_dartid := COUNT(GROUP,%Closest%.Diff_dartid);
    Count_Diff_insuranceprovider := COUNT(GROUP,%Closest%.Diff_insuranceprovider);
    Count_Diff_policynumber := COUNT(GROUP,%Closest%.Diff_policynumber);
    Count_Diff_coveragestartdate := COUNT(GROUP,%Closest%.Diff_coveragestartdate);
    Count_Diff_coverageexpirationdate := COUNT(GROUP,%Closest%.Diff_coverageexpirationdate);
    Count_Diff_coveragewrapup := COUNT(GROUP,%Closest%.Diff_coveragewrapup);
    Count_Diff_policystatus := COUNT(GROUP,%Closest%.Diff_policystatus);
    Count_Diff_insuranceprovideraddressline := COUNT(GROUP,%Closest%.Diff_insuranceprovideraddressline);
    Count_Diff_insuranceprovideraddressline2 := COUNT(GROUP,%Closest%.Diff_insuranceprovideraddressline2);
    Count_Diff_insuranceprovidercity := COUNT(GROUP,%Closest%.Diff_insuranceprovidercity);
    Count_Diff_insuranceproviderstate := COUNT(GROUP,%Closest%.Diff_insuranceproviderstate);
    Count_Diff_insuranceproviderzip := COUNT(GROUP,%Closest%.Diff_insuranceproviderzip);
    Count_Diff_insuranceproviderzip4 := COUNT(GROUP,%Closest%.Diff_insuranceproviderzip4);
    Count_Diff_insuranceproviderphone := COUNT(GROUP,%Closest%.Diff_insuranceproviderphone);
    Count_Diff_insuranceproviderfax := COUNT(GROUP,%Closest%.Diff_insuranceproviderfax);
    Count_Diff_coveragereinstatedate := COUNT(GROUP,%Closest%.Diff_coveragereinstatedate);
    Count_Diff_coveragecancellationdate := COUNT(GROUP,%Closest%.Diff_coveragecancellationdate);
    Count_Diff_coveragewrapupdate := COUNT(GROUP,%Closest%.Diff_coveragewrapupdate);
    Count_Diff_businessnameduringcoverage := COUNT(GROUP,%Closest%.Diff_businessnameduringcoverage);
    Count_Diff_addresslineduringcoverage := COUNT(GROUP,%Closest%.Diff_addresslineduringcoverage);
    Count_Diff_addressline2duringcoverage := COUNT(GROUP,%Closest%.Diff_addressline2duringcoverage);
    Count_Diff_cityduringcoverage := COUNT(GROUP,%Closest%.Diff_cityduringcoverage);
    Count_Diff_stateduringcoverage := COUNT(GROUP,%Closest%.Diff_stateduringcoverage);
    Count_Diff_zipduringcoverage := COUNT(GROUP,%Closest%.Diff_zipduringcoverage);
    Count_Diff_zip4duringcoverage := COUNT(GROUP,%Closest%.Diff_zip4duringcoverage);
    Count_Diff_numberofemployeesduringcoverage := COUNT(GROUP,%Closest%.Diff_numberofemployeesduringcoverage);
    Count_Diff_insuranceprovidercontactdept := COUNT(GROUP,%Closest%.Diff_insuranceprovidercontactdept);
    Count_Diff_insurancetype := COUNT(GROUP,%Closest%.Diff_insurancetype);
    Count_Diff_coverageposteddate := COUNT(GROUP,%Closest%.Diff_coverageposteddate);
    Count_Diff_coverageamountfrom := COUNT(GROUP,%Closest%.Diff_coverageamountfrom);
    Count_Diff_coverageamountto := COUNT(GROUP,%Closest%.Diff_coverageamountto);
    Count_Diff_unique_id := COUNT(GROUP,%Closest%.Diff_unique_id);
    Count_Diff_append_mailaddress1 := COUNT(GROUP,%Closest%.Diff_append_mailaddress1);
    Count_Diff_append_mailaddresslast := COUNT(GROUP,%Closest%.Diff_append_mailaddresslast);
    Count_Diff_append_mailrawaid := COUNT(GROUP,%Closest%.Diff_append_mailrawaid);
    Count_Diff_append_mailaceaid := COUNT(GROUP,%Closest%.Diff_append_mailaceaid);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
