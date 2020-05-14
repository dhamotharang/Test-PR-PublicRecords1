IMPORT SALT311;
IMPORT Scrubs,Scrubs_Crim; // Import modules for FieldTypes attribute definitions
EXPORT defendant_Fields := MODULE
 
EXPORT NumFields := 62;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Record_ID','Invalid_State','Invalid_Current_Date','Invalid_Future_Date','Invalid_Source_ID','Invalid_Inmate_Num','Invalid_Gender','Invalid_Zip','Invalid_Race','Invalid_Height','Invalid_City');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Record_ID' => 1,'Invalid_State' => 2,'Invalid_Current_Date' => 3,'Invalid_Future_Date' => 4,'Invalid_Source_ID' => 5,'Invalid_Inmate_Num' => 6,'Invalid_Gender' => 7,'Invalid_Zip' => 8,'Invalid_Race' => 9,'Invalid_Height' => 10,'Invalid_City' => 11,0);
 
EXPORT MakeFT_Invalid_Record_ID(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Record_ID(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_'))));
EXPORT InValidMessageFT_Invalid_Record_ID(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_State(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Current_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Current_Date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Current_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Future_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Future_Date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_date(s,'future')>0);
EXPORT InValidMessageFT_Invalid_Future_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Source_ID(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789C'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Source_ID(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789C'))));
EXPORT InValidMessageFT_Invalid_Source_ID(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789C'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Inmate_Num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-*,#@'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Inmate_Num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-*,#@'))));
EXPORT InValidMessageFT_Invalid_Inmate_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-*,#@'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Gender(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Gender(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['MALE','FEMALE','Female','Male','female','male','f','m','F','M','Unknown','UNKNOWN','U','u','']);
EXPORT InValidMessageFT_Invalid_Gender(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('MALE|FEMALE|Female|Male|female|male|f|m|F|M|Unknown|UNKNOWN|U|u|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789-'))));
EXPORT InValidMessageFT_Invalid_Zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789-'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Race(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Race(SALT311.StrType s) := WHICH(~Scrubs_Crim.fn_StandardizeRace(s)>0);
EXPORT InValidMessageFT_Invalid_Race(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Crim.fn_StandardizeRace'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Height(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789,"\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Height(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789,"\''))));
EXPORT InValidMessageFT_Invalid_Height(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789,"\''),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_City(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.-,? '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_City(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.-,? '))));
EXPORT InValidMessageFT_Invalid_City(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.-,? '),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'recordid','sourcename','sourcetype','statecode','recordtype','recorduploaddate','docnumber','fbinumber','stateidnumber','inmatenumber','aliennumber','orig_ssn','nametype','name','lastname','firstname','middlename','suffix','defendantstatus','defendantadditionalinfo','dob','birthcity','birthplace','age','gender','height','weight','haircolor','eyecolor','race','ethnicity','skincolor','bodymarks','physicalbuild','photoname','dlnumber','dlstate','phone','phonetype','uscitizenflag','addresstype','street','unit','city','orig_state','orig_zip','county','institutionname','institutiondetails','institutionreceiptdate','releasetolocation','releasetodetails','deceasedflag','deceaseddate','healthflag','healthdesc','bloodtype','sexoffenderregistrydate','sexoffenderregexpirationdate','sexoffenderregistrynumber','sourceid','vendor');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'recordid','sourcename','sourcetype','statecode','recordtype','recorduploaddate','docnumber','fbinumber','stateidnumber','inmatenumber','aliennumber','orig_ssn','nametype','name','lastname','firstname','middlename','suffix','defendantstatus','defendantadditionalinfo','dob','birthcity','birthplace','age','gender','height','weight','haircolor','eyecolor','race','ethnicity','skincolor','bodymarks','physicalbuild','photoname','dlnumber','dlstate','phone','phonetype','uscitizenflag','addresstype','street','unit','city','orig_state','orig_zip','county','institutionname','institutiondetails','institutionreceiptdate','releasetolocation','releasetodetails','deceasedflag','deceaseddate','healthflag','healthdesc','bloodtype','sexoffenderregistrydate','sexoffenderregexpirationdate','sexoffenderregistrynumber','sourceid','vendor');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'recordid' => 0,'sourcename' => 1,'sourcetype' => 2,'statecode' => 3,'recordtype' => 4,'recorduploaddate' => 5,'docnumber' => 6,'fbinumber' => 7,'stateidnumber' => 8,'inmatenumber' => 9,'aliennumber' => 10,'orig_ssn' => 11,'nametype' => 12,'name' => 13,'lastname' => 14,'firstname' => 15,'middlename' => 16,'suffix' => 17,'defendantstatus' => 18,'defendantadditionalinfo' => 19,'dob' => 20,'birthcity' => 21,'birthplace' => 22,'age' => 23,'gender' => 24,'height' => 25,'weight' => 26,'haircolor' => 27,'eyecolor' => 28,'race' => 29,'ethnicity' => 30,'skincolor' => 31,'bodymarks' => 32,'physicalbuild' => 33,'photoname' => 34,'dlnumber' => 35,'dlstate' => 36,'phone' => 37,'phonetype' => 38,'uscitizenflag' => 39,'addresstype' => 40,'street' => 41,'unit' => 42,'city' => 43,'orig_state' => 44,'orig_zip' => 45,'county' => 46,'institutionname' => 47,'institutiondetails' => 48,'institutionreceiptdate' => 49,'releasetolocation' => 50,'releasetodetails' => 51,'deceasedflag' => 52,'deceaseddate' => 53,'healthflag' => 54,'healthdesc' => 55,'bloodtype' => 56,'sexoffenderregistrydate' => 57,'sexoffenderregexpirationdate' => 58,'sexoffenderregistrynumber' => 59,'sourceid' => 60,'vendor' => 61,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],[],[],['ALLOW'],[],[],[],[],[],['ALLOW'],[],[],[],[],[],[],[],[],[],[],['CUSTOM'],['ALLOW'],[],[],['ENUM'],[],[],[],[],['CUSTOM'],[],[],[],[],[],[],['ALLOW'],[],[],[],[],[],[],['ALLOW'],[],['ALLOW'],[],[],[],['CUSTOM'],[],[],[],['CUSTOM'],[],[],[],['CUSTOM'],['CUSTOM'],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_recordid(SALT311.StrType s0) := MakeFT_Invalid_Record_ID(s0);
EXPORT InValid_recordid(SALT311.StrType s) := InValidFT_Invalid_Record_ID(s);
EXPORT InValidMessage_recordid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Record_ID(wh);
 
EXPORT Make_sourcename(SALT311.StrType s0) := s0;
EXPORT InValid_sourcename(SALT311.StrType s) := 0;
EXPORT InValidMessage_sourcename(UNSIGNED1 wh) := '';
 
EXPORT Make_sourcetype(SALT311.StrType s0) := s0;
EXPORT InValid_sourcetype(SALT311.StrType s) := 0;
EXPORT InValidMessage_sourcetype(UNSIGNED1 wh) := '';
 
EXPORT Make_statecode(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_statecode(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_statecode(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_recordtype(SALT311.StrType s0) := s0;
EXPORT InValid_recordtype(SALT311.StrType s) := 0;
EXPORT InValidMessage_recordtype(UNSIGNED1 wh) := '';
 
EXPORT Make_recorduploaddate(SALT311.StrType s0) := s0;
EXPORT InValid_recorduploaddate(SALT311.StrType s) := 0;
EXPORT InValidMessage_recorduploaddate(UNSIGNED1 wh) := '';
 
EXPORT Make_docnumber(SALT311.StrType s0) := s0;
EXPORT InValid_docnumber(SALT311.StrType s) := 0;
EXPORT InValidMessage_docnumber(UNSIGNED1 wh) := '';
 
EXPORT Make_fbinumber(SALT311.StrType s0) := s0;
EXPORT InValid_fbinumber(SALT311.StrType s) := 0;
EXPORT InValidMessage_fbinumber(UNSIGNED1 wh) := '';
 
EXPORT Make_stateidnumber(SALT311.StrType s0) := s0;
EXPORT InValid_stateidnumber(SALT311.StrType s) := 0;
EXPORT InValidMessage_stateidnumber(UNSIGNED1 wh) := '';
 
EXPORT Make_inmatenumber(SALT311.StrType s0) := MakeFT_Invalid_Inmate_Num(s0);
EXPORT InValid_inmatenumber(SALT311.StrType s) := InValidFT_Invalid_Inmate_Num(s);
EXPORT InValidMessage_inmatenumber(UNSIGNED1 wh) := InValidMessageFT_Invalid_Inmate_Num(wh);
 
EXPORT Make_aliennumber(SALT311.StrType s0) := s0;
EXPORT InValid_aliennumber(SALT311.StrType s) := 0;
EXPORT InValidMessage_aliennumber(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_ssn(SALT311.StrType s0) := s0;
EXPORT InValid_orig_ssn(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_ssn(UNSIGNED1 wh) := '';
 
EXPORT Make_nametype(SALT311.StrType s0) := s0;
EXPORT InValid_nametype(SALT311.StrType s) := 0;
EXPORT InValidMessage_nametype(UNSIGNED1 wh) := '';
 
EXPORT Make_name(SALT311.StrType s0) := s0;
EXPORT InValid_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_name(UNSIGNED1 wh) := '';
 
EXPORT Make_lastname(SALT311.StrType s0) := s0;
EXPORT InValid_lastname(SALT311.StrType s) := 0;
EXPORT InValidMessage_lastname(UNSIGNED1 wh) := '';
 
EXPORT Make_firstname(SALT311.StrType s0) := s0;
EXPORT InValid_firstname(SALT311.StrType s) := 0;
EXPORT InValidMessage_firstname(UNSIGNED1 wh) := '';
 
EXPORT Make_middlename(SALT311.StrType s0) := s0;
EXPORT InValid_middlename(SALT311.StrType s) := 0;
EXPORT InValidMessage_middlename(UNSIGNED1 wh) := '';
 
EXPORT Make_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_defendantstatus(SALT311.StrType s0) := s0;
EXPORT InValid_defendantstatus(SALT311.StrType s) := 0;
EXPORT InValidMessage_defendantstatus(UNSIGNED1 wh) := '';
 
EXPORT Make_defendantadditionalinfo(SALT311.StrType s0) := s0;
EXPORT InValid_defendantadditionalinfo(SALT311.StrType s) := 0;
EXPORT InValidMessage_defendantadditionalinfo(UNSIGNED1 wh) := '';
 
EXPORT Make_dob(SALT311.StrType s0) := MakeFT_Invalid_Current_Date(s0);
EXPORT InValid_dob(SALT311.StrType s) := InValidFT_Invalid_Current_Date(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_Invalid_Current_Date(wh);
 
EXPORT Make_birthcity(SALT311.StrType s0) := MakeFT_Invalid_City(s0);
EXPORT InValid_birthcity(SALT311.StrType s) := InValidFT_Invalid_City(s);
EXPORT InValidMessage_birthcity(UNSIGNED1 wh) := InValidMessageFT_Invalid_City(wh);
 
EXPORT Make_birthplace(SALT311.StrType s0) := s0;
EXPORT InValid_birthplace(SALT311.StrType s) := 0;
EXPORT InValidMessage_birthplace(UNSIGNED1 wh) := '';
 
EXPORT Make_age(SALT311.StrType s0) := s0;
EXPORT InValid_age(SALT311.StrType s) := 0;
EXPORT InValidMessage_age(UNSIGNED1 wh) := '';
 
EXPORT Make_gender(SALT311.StrType s0) := MakeFT_Invalid_Gender(s0);
EXPORT InValid_gender(SALT311.StrType s) := InValidFT_Invalid_Gender(s);
EXPORT InValidMessage_gender(UNSIGNED1 wh) := InValidMessageFT_Invalid_Gender(wh);
 
EXPORT Make_height(SALT311.StrType s0) := s0;
EXPORT InValid_height(SALT311.StrType s) := 0;
EXPORT InValidMessage_height(UNSIGNED1 wh) := '';
 
EXPORT Make_weight(SALT311.StrType s0) := s0;
EXPORT InValid_weight(SALT311.StrType s) := 0;
EXPORT InValidMessage_weight(UNSIGNED1 wh) := '';
 
EXPORT Make_haircolor(SALT311.StrType s0) := s0;
EXPORT InValid_haircolor(SALT311.StrType s) := 0;
EXPORT InValidMessage_haircolor(UNSIGNED1 wh) := '';
 
EXPORT Make_eyecolor(SALT311.StrType s0) := s0;
EXPORT InValid_eyecolor(SALT311.StrType s) := 0;
EXPORT InValidMessage_eyecolor(UNSIGNED1 wh) := '';
 
EXPORT Make_race(SALT311.StrType s0) := MakeFT_Invalid_Race(s0);
EXPORT InValid_race(SALT311.StrType s) := InValidFT_Invalid_Race(s);
EXPORT InValidMessage_race(UNSIGNED1 wh) := InValidMessageFT_Invalid_Race(wh);
 
EXPORT Make_ethnicity(SALT311.StrType s0) := s0;
EXPORT InValid_ethnicity(SALT311.StrType s) := 0;
EXPORT InValidMessage_ethnicity(UNSIGNED1 wh) := '';
 
EXPORT Make_skincolor(SALT311.StrType s0) := s0;
EXPORT InValid_skincolor(SALT311.StrType s) := 0;
EXPORT InValidMessage_skincolor(UNSIGNED1 wh) := '';
 
EXPORT Make_bodymarks(SALT311.StrType s0) := s0;
EXPORT InValid_bodymarks(SALT311.StrType s) := 0;
EXPORT InValidMessage_bodymarks(UNSIGNED1 wh) := '';
 
EXPORT Make_physicalbuild(SALT311.StrType s0) := s0;
EXPORT InValid_physicalbuild(SALT311.StrType s) := 0;
EXPORT InValidMessage_physicalbuild(UNSIGNED1 wh) := '';
 
EXPORT Make_photoname(SALT311.StrType s0) := s0;
EXPORT InValid_photoname(SALT311.StrType s) := 0;
EXPORT InValidMessage_photoname(UNSIGNED1 wh) := '';
 
EXPORT Make_dlnumber(SALT311.StrType s0) := s0;
EXPORT InValid_dlnumber(SALT311.StrType s) := 0;
EXPORT InValidMessage_dlnumber(UNSIGNED1 wh) := '';
 
EXPORT Make_dlstate(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_dlstate(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_dlstate(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_phone(SALT311.StrType s0) := s0;
EXPORT InValid_phone(SALT311.StrType s) := 0;
EXPORT InValidMessage_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_phonetype(SALT311.StrType s0) := s0;
EXPORT InValid_phonetype(SALT311.StrType s) := 0;
EXPORT InValidMessage_phonetype(UNSIGNED1 wh) := '';
 
EXPORT Make_uscitizenflag(SALT311.StrType s0) := s0;
EXPORT InValid_uscitizenflag(SALT311.StrType s) := 0;
EXPORT InValidMessage_uscitizenflag(UNSIGNED1 wh) := '';
 
EXPORT Make_addresstype(SALT311.StrType s0) := s0;
EXPORT InValid_addresstype(SALT311.StrType s) := 0;
EXPORT InValidMessage_addresstype(UNSIGNED1 wh) := '';
 
EXPORT Make_street(SALT311.StrType s0) := s0;
EXPORT InValid_street(SALT311.StrType s) := 0;
EXPORT InValidMessage_street(UNSIGNED1 wh) := '';
 
EXPORT Make_unit(SALT311.StrType s0) := s0;
EXPORT InValid_unit(SALT311.StrType s) := 0;
EXPORT InValidMessage_unit(UNSIGNED1 wh) := '';
 
EXPORT Make_city(SALT311.StrType s0) := MakeFT_Invalid_City(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_Invalid_City(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_City(wh);
 
EXPORT Make_orig_state(SALT311.StrType s0) := s0;
EXPORT InValid_orig_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_state(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_zip(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_orig_zip(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_orig_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_county(SALT311.StrType s0) := s0;
EXPORT InValid_county(SALT311.StrType s) := 0;
EXPORT InValidMessage_county(UNSIGNED1 wh) := '';
 
EXPORT Make_institutionname(SALT311.StrType s0) := s0;
EXPORT InValid_institutionname(SALT311.StrType s) := 0;
EXPORT InValidMessage_institutionname(UNSIGNED1 wh) := '';
 
EXPORT Make_institutiondetails(SALT311.StrType s0) := s0;
EXPORT InValid_institutiondetails(SALT311.StrType s) := 0;
EXPORT InValidMessage_institutiondetails(UNSIGNED1 wh) := '';
 
EXPORT Make_institutionreceiptdate(SALT311.StrType s0) := MakeFT_Invalid_Current_Date(s0);
EXPORT InValid_institutionreceiptdate(SALT311.StrType s) := InValidFT_Invalid_Current_Date(s);
EXPORT InValidMessage_institutionreceiptdate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Current_Date(wh);
 
EXPORT Make_releasetolocation(SALT311.StrType s0) := s0;
EXPORT InValid_releasetolocation(SALT311.StrType s) := 0;
EXPORT InValidMessage_releasetolocation(UNSIGNED1 wh) := '';
 
EXPORT Make_releasetodetails(SALT311.StrType s0) := s0;
EXPORT InValid_releasetodetails(SALT311.StrType s) := 0;
EXPORT InValidMessage_releasetodetails(UNSIGNED1 wh) := '';
 
EXPORT Make_deceasedflag(SALT311.StrType s0) := s0;
EXPORT InValid_deceasedflag(SALT311.StrType s) := 0;
EXPORT InValidMessage_deceasedflag(UNSIGNED1 wh) := '';
 
EXPORT Make_deceaseddate(SALT311.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_deceaseddate(SALT311.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_deceaseddate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
 
EXPORT Make_healthflag(SALT311.StrType s0) := s0;
EXPORT InValid_healthflag(SALT311.StrType s) := 0;
EXPORT InValidMessage_healthflag(UNSIGNED1 wh) := '';
 
EXPORT Make_healthdesc(SALT311.StrType s0) := s0;
EXPORT InValid_healthdesc(SALT311.StrType s) := 0;
EXPORT InValidMessage_healthdesc(UNSIGNED1 wh) := '';
 
EXPORT Make_bloodtype(SALT311.StrType s0) := s0;
EXPORT InValid_bloodtype(SALT311.StrType s) := 0;
EXPORT InValidMessage_bloodtype(UNSIGNED1 wh) := '';
 
EXPORT Make_sexoffenderregistrydate(SALT311.StrType s0) := MakeFT_Invalid_Current_Date(s0);
EXPORT InValid_sexoffenderregistrydate(SALT311.StrType s) := InValidFT_Invalid_Current_Date(s);
EXPORT InValidMessage_sexoffenderregistrydate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Current_Date(wh);
 
EXPORT Make_sexoffenderregexpirationdate(SALT311.StrType s0) := MakeFT_Invalid_Future_Date(s0);
EXPORT InValid_sexoffenderregexpirationdate(SALT311.StrType s) := InValidFT_Invalid_Future_Date(s);
EXPORT InValidMessage_sexoffenderregexpirationdate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future_Date(wh);
 
EXPORT Make_sexoffenderregistrynumber(SALT311.StrType s0) := s0;
EXPORT InValid_sexoffenderregistrynumber(SALT311.StrType s) := 0;
EXPORT InValidMessage_sexoffenderregistrynumber(UNSIGNED1 wh) := '';
 
EXPORT Make_sourceid(SALT311.StrType s0) := s0;
EXPORT InValid_sourceid(SALT311.StrType s) := 0;
EXPORT InValidMessage_sourceid(UNSIGNED1 wh) := '';
 
EXPORT Make_vendor(SALT311.StrType s0) := s0;
EXPORT InValid_vendor(SALT311.StrType s) := 0;
EXPORT InValidMessage_vendor(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Crim;
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
    BOOLEAN Diff_recordid;
    BOOLEAN Diff_sourcename;
    BOOLEAN Diff_sourcetype;
    BOOLEAN Diff_statecode;
    BOOLEAN Diff_recordtype;
    BOOLEAN Diff_recorduploaddate;
    BOOLEAN Diff_docnumber;
    BOOLEAN Diff_fbinumber;
    BOOLEAN Diff_stateidnumber;
    BOOLEAN Diff_inmatenumber;
    BOOLEAN Diff_aliennumber;
    BOOLEAN Diff_orig_ssn;
    BOOLEAN Diff_nametype;
    BOOLEAN Diff_name;
    BOOLEAN Diff_lastname;
    BOOLEAN Diff_firstname;
    BOOLEAN Diff_middlename;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_defendantstatus;
    BOOLEAN Diff_defendantadditionalinfo;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_birthcity;
    BOOLEAN Diff_birthplace;
    BOOLEAN Diff_age;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_height;
    BOOLEAN Diff_weight;
    BOOLEAN Diff_haircolor;
    BOOLEAN Diff_eyecolor;
    BOOLEAN Diff_race;
    BOOLEAN Diff_ethnicity;
    BOOLEAN Diff_skincolor;
    BOOLEAN Diff_bodymarks;
    BOOLEAN Diff_physicalbuild;
    BOOLEAN Diff_photoname;
    BOOLEAN Diff_dlnumber;
    BOOLEAN Diff_dlstate;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_phonetype;
    BOOLEAN Diff_uscitizenflag;
    BOOLEAN Diff_addresstype;
    BOOLEAN Diff_street;
    BOOLEAN Diff_unit;
    BOOLEAN Diff_city;
    BOOLEAN Diff_orig_state;
    BOOLEAN Diff_orig_zip;
    BOOLEAN Diff_county;
    BOOLEAN Diff_institutionname;
    BOOLEAN Diff_institutiondetails;
    BOOLEAN Diff_institutionreceiptdate;
    BOOLEAN Diff_releasetolocation;
    BOOLEAN Diff_releasetodetails;
    BOOLEAN Diff_deceasedflag;
    BOOLEAN Diff_deceaseddate;
    BOOLEAN Diff_healthflag;
    BOOLEAN Diff_healthdesc;
    BOOLEAN Diff_bloodtype;
    BOOLEAN Diff_sexoffenderregistrydate;
    BOOLEAN Diff_sexoffenderregexpirationdate;
    BOOLEAN Diff_sexoffenderregistrynumber;
    BOOLEAN Diff_sourceid;
    BOOLEAN Diff_vendor;
    SALT311.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_recordid := le.recordid <> ri.recordid;
    SELF.Diff_sourcename := le.sourcename <> ri.sourcename;
    SELF.Diff_sourcetype := le.sourcetype <> ri.sourcetype;
    SELF.Diff_statecode := le.statecode <> ri.statecode;
    SELF.Diff_recordtype := le.recordtype <> ri.recordtype;
    SELF.Diff_recorduploaddate := le.recorduploaddate <> ri.recorduploaddate;
    SELF.Diff_docnumber := le.docnumber <> ri.docnumber;
    SELF.Diff_fbinumber := le.fbinumber <> ri.fbinumber;
    SELF.Diff_stateidnumber := le.stateidnumber <> ri.stateidnumber;
    SELF.Diff_inmatenumber := le.inmatenumber <> ri.inmatenumber;
    SELF.Diff_aliennumber := le.aliennumber <> ri.aliennumber;
    SELF.Diff_orig_ssn := le.orig_ssn <> ri.orig_ssn;
    SELF.Diff_nametype := le.nametype <> ri.nametype;
    SELF.Diff_name := le.name <> ri.name;
    SELF.Diff_lastname := le.lastname <> ri.lastname;
    SELF.Diff_firstname := le.firstname <> ri.firstname;
    SELF.Diff_middlename := le.middlename <> ri.middlename;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_defendantstatus := le.defendantstatus <> ri.defendantstatus;
    SELF.Diff_defendantadditionalinfo := le.defendantadditionalinfo <> ri.defendantadditionalinfo;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_birthcity := le.birthcity <> ri.birthcity;
    SELF.Diff_birthplace := le.birthplace <> ri.birthplace;
    SELF.Diff_age := le.age <> ri.age;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_height := le.height <> ri.height;
    SELF.Diff_weight := le.weight <> ri.weight;
    SELF.Diff_haircolor := le.haircolor <> ri.haircolor;
    SELF.Diff_eyecolor := le.eyecolor <> ri.eyecolor;
    SELF.Diff_race := le.race <> ri.race;
    SELF.Diff_ethnicity := le.ethnicity <> ri.ethnicity;
    SELF.Diff_skincolor := le.skincolor <> ri.skincolor;
    SELF.Diff_bodymarks := le.bodymarks <> ri.bodymarks;
    SELF.Diff_physicalbuild := le.physicalbuild <> ri.physicalbuild;
    SELF.Diff_photoname := le.photoname <> ri.photoname;
    SELF.Diff_dlnumber := le.dlnumber <> ri.dlnumber;
    SELF.Diff_dlstate := le.dlstate <> ri.dlstate;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_phonetype := le.phonetype <> ri.phonetype;
    SELF.Diff_uscitizenflag := le.uscitizenflag <> ri.uscitizenflag;
    SELF.Diff_addresstype := le.addresstype <> ri.addresstype;
    SELF.Diff_street := le.street <> ri.street;
    SELF.Diff_unit := le.unit <> ri.unit;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_orig_state := le.orig_state <> ri.orig_state;
    SELF.Diff_orig_zip := le.orig_zip <> ri.orig_zip;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_institutionname := le.institutionname <> ri.institutionname;
    SELF.Diff_institutiondetails := le.institutiondetails <> ri.institutiondetails;
    SELF.Diff_institutionreceiptdate := le.institutionreceiptdate <> ri.institutionreceiptdate;
    SELF.Diff_releasetolocation := le.releasetolocation <> ri.releasetolocation;
    SELF.Diff_releasetodetails := le.releasetodetails <> ri.releasetodetails;
    SELF.Diff_deceasedflag := le.deceasedflag <> ri.deceasedflag;
    SELF.Diff_deceaseddate := le.deceaseddate <> ri.deceaseddate;
    SELF.Diff_healthflag := le.healthflag <> ri.healthflag;
    SELF.Diff_healthdesc := le.healthdesc <> ri.healthdesc;
    SELF.Diff_bloodtype := le.bloodtype <> ri.bloodtype;
    SELF.Diff_sexoffenderregistrydate := le.sexoffenderregistrydate <> ri.sexoffenderregistrydate;
    SELF.Diff_sexoffenderregexpirationdate := le.sexoffenderregexpirationdate <> ri.sexoffenderregexpirationdate;
    SELF.Diff_sexoffenderregistrynumber := le.sexoffenderregistrynumber <> ri.sexoffenderregistrynumber;
    SELF.Diff_sourceid := le.sourceid <> ri.sourceid;
    SELF.Diff_vendor := le.vendor <> ri.vendor;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.vendor;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_recordid,1,0)+ IF( SELF.Diff_sourcename,1,0)+ IF( SELF.Diff_sourcetype,1,0)+ IF( SELF.Diff_statecode,1,0)+ IF( SELF.Diff_recordtype,1,0)+ IF( SELF.Diff_recorduploaddate,1,0)+ IF( SELF.Diff_docnumber,1,0)+ IF( SELF.Diff_fbinumber,1,0)+ IF( SELF.Diff_stateidnumber,1,0)+ IF( SELF.Diff_inmatenumber,1,0)+ IF( SELF.Diff_aliennumber,1,0)+ IF( SELF.Diff_orig_ssn,1,0)+ IF( SELF.Diff_nametype,1,0)+ IF( SELF.Diff_name,1,0)+ IF( SELF.Diff_lastname,1,0)+ IF( SELF.Diff_firstname,1,0)+ IF( SELF.Diff_middlename,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_defendantstatus,1,0)+ IF( SELF.Diff_defendantadditionalinfo,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_birthcity,1,0)+ IF( SELF.Diff_birthplace,1,0)+ IF( SELF.Diff_age,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_height,1,0)+ IF( SELF.Diff_weight,1,0)+ IF( SELF.Diff_haircolor,1,0)+ IF( SELF.Diff_eyecolor,1,0)+ IF( SELF.Diff_race,1,0)+ IF( SELF.Diff_ethnicity,1,0)+ IF( SELF.Diff_skincolor,1,0)+ IF( SELF.Diff_bodymarks,1,0)+ IF( SELF.Diff_physicalbuild,1,0)+ IF( SELF.Diff_photoname,1,0)+ IF( SELF.Diff_dlnumber,1,0)+ IF( SELF.Diff_dlstate,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_phonetype,1,0)+ IF( SELF.Diff_uscitizenflag,1,0)+ IF( SELF.Diff_addresstype,1,0)+ IF( SELF.Diff_street,1,0)+ IF( SELF.Diff_unit,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_orig_state,1,0)+ IF( SELF.Diff_orig_zip,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_institutionname,1,0)+ IF( SELF.Diff_institutiondetails,1,0)+ IF( SELF.Diff_institutionreceiptdate,1,0)+ IF( SELF.Diff_releasetolocation,1,0)+ IF( SELF.Diff_releasetodetails,1,0)+ IF( SELF.Diff_deceasedflag,1,0)+ IF( SELF.Diff_deceaseddate,1,0)+ IF( SELF.Diff_healthflag,1,0)+ IF( SELF.Diff_healthdesc,1,0)+ IF( SELF.Diff_bloodtype,1,0)+ IF( SELF.Diff_sexoffenderregistrydate,1,0)+ IF( SELF.Diff_sexoffenderregexpirationdate,1,0)+ IF( SELF.Diff_sexoffenderregistrynumber,1,0)+ IF( SELF.Diff_sourceid,1,0)+ IF( SELF.Diff_vendor,1,0);
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
    Count_Diff_recordid := COUNT(GROUP,%Closest%.Diff_recordid);
    Count_Diff_sourcename := COUNT(GROUP,%Closest%.Diff_sourcename);
    Count_Diff_sourcetype := COUNT(GROUP,%Closest%.Diff_sourcetype);
    Count_Diff_statecode := COUNT(GROUP,%Closest%.Diff_statecode);
    Count_Diff_recordtype := COUNT(GROUP,%Closest%.Diff_recordtype);
    Count_Diff_recorduploaddate := COUNT(GROUP,%Closest%.Diff_recorduploaddate);
    Count_Diff_docnumber := COUNT(GROUP,%Closest%.Diff_docnumber);
    Count_Diff_fbinumber := COUNT(GROUP,%Closest%.Diff_fbinumber);
    Count_Diff_stateidnumber := COUNT(GROUP,%Closest%.Diff_stateidnumber);
    Count_Diff_inmatenumber := COUNT(GROUP,%Closest%.Diff_inmatenumber);
    Count_Diff_aliennumber := COUNT(GROUP,%Closest%.Diff_aliennumber);
    Count_Diff_orig_ssn := COUNT(GROUP,%Closest%.Diff_orig_ssn);
    Count_Diff_nametype := COUNT(GROUP,%Closest%.Diff_nametype);
    Count_Diff_name := COUNT(GROUP,%Closest%.Diff_name);
    Count_Diff_lastname := COUNT(GROUP,%Closest%.Diff_lastname);
    Count_Diff_firstname := COUNT(GROUP,%Closest%.Diff_firstname);
    Count_Diff_middlename := COUNT(GROUP,%Closest%.Diff_middlename);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_defendantstatus := COUNT(GROUP,%Closest%.Diff_defendantstatus);
    Count_Diff_defendantadditionalinfo := COUNT(GROUP,%Closest%.Diff_defendantadditionalinfo);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_birthcity := COUNT(GROUP,%Closest%.Diff_birthcity);
    Count_Diff_birthplace := COUNT(GROUP,%Closest%.Diff_birthplace);
    Count_Diff_age := COUNT(GROUP,%Closest%.Diff_age);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_height := COUNT(GROUP,%Closest%.Diff_height);
    Count_Diff_weight := COUNT(GROUP,%Closest%.Diff_weight);
    Count_Diff_haircolor := COUNT(GROUP,%Closest%.Diff_haircolor);
    Count_Diff_eyecolor := COUNT(GROUP,%Closest%.Diff_eyecolor);
    Count_Diff_race := COUNT(GROUP,%Closest%.Diff_race);
    Count_Diff_ethnicity := COUNT(GROUP,%Closest%.Diff_ethnicity);
    Count_Diff_skincolor := COUNT(GROUP,%Closest%.Diff_skincolor);
    Count_Diff_bodymarks := COUNT(GROUP,%Closest%.Diff_bodymarks);
    Count_Diff_physicalbuild := COUNT(GROUP,%Closest%.Diff_physicalbuild);
    Count_Diff_photoname := COUNT(GROUP,%Closest%.Diff_photoname);
    Count_Diff_dlnumber := COUNT(GROUP,%Closest%.Diff_dlnumber);
    Count_Diff_dlstate := COUNT(GROUP,%Closest%.Diff_dlstate);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_phonetype := COUNT(GROUP,%Closest%.Diff_phonetype);
    Count_Diff_uscitizenflag := COUNT(GROUP,%Closest%.Diff_uscitizenflag);
    Count_Diff_addresstype := COUNT(GROUP,%Closest%.Diff_addresstype);
    Count_Diff_street := COUNT(GROUP,%Closest%.Diff_street);
    Count_Diff_unit := COUNT(GROUP,%Closest%.Diff_unit);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_orig_state := COUNT(GROUP,%Closest%.Diff_orig_state);
    Count_Diff_orig_zip := COUNT(GROUP,%Closest%.Diff_orig_zip);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_institutionname := COUNT(GROUP,%Closest%.Diff_institutionname);
    Count_Diff_institutiondetails := COUNT(GROUP,%Closest%.Diff_institutiondetails);
    Count_Diff_institutionreceiptdate := COUNT(GROUP,%Closest%.Diff_institutionreceiptdate);
    Count_Diff_releasetolocation := COUNT(GROUP,%Closest%.Diff_releasetolocation);
    Count_Diff_releasetodetails := COUNT(GROUP,%Closest%.Diff_releasetodetails);
    Count_Diff_deceasedflag := COUNT(GROUP,%Closest%.Diff_deceasedflag);
    Count_Diff_deceaseddate := COUNT(GROUP,%Closest%.Diff_deceaseddate);
    Count_Diff_healthflag := COUNT(GROUP,%Closest%.Diff_healthflag);
    Count_Diff_healthdesc := COUNT(GROUP,%Closest%.Diff_healthdesc);
    Count_Diff_bloodtype := COUNT(GROUP,%Closest%.Diff_bloodtype);
    Count_Diff_sexoffenderregistrydate := COUNT(GROUP,%Closest%.Diff_sexoffenderregistrydate);
    Count_Diff_sexoffenderregexpirationdate := COUNT(GROUP,%Closest%.Diff_sexoffenderregexpirationdate);
    Count_Diff_sexoffenderregistrynumber := COUNT(GROUP,%Closest%.Diff_sexoffenderregistrynumber);
    Count_Diff_sourceid := COUNT(GROUP,%Closest%.Diff_sourceid);
    Count_Diff_vendor := COUNT(GROUP,%Closest%.Diff_vendor);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
