IMPORT SALT311;
EXPORT raw_Fields := MODULE
 
EXPORT NumFields := 148;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_orig_name','invalid_orig_parsed_name','invalid_race','invalid_alpha','invalid_number');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_orig_name' => 1,'invalid_orig_parsed_name' => 2,'invalid_race' => 3,'invalid_alpha' => 4,'invalid_number' => 5,0);
 
EXPORT MakeFT_invalid_orig_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ, -\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_orig_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ, -\''))));
EXPORT InValidMessageFT_invalid_orig_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ, -\''),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_parsed_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_orig_parsed_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -\''))));
EXPORT InValidMessageFT_invalid_orig_parsed_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -\''),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_race(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_race(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_race(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_number(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'recordid','sourcename','sourcetype','statecode','recordtype','recorduploaddate','docnumber','fbinumber','stateidnumber','inmatenumber','aliennumber','orig_ssn','nametype','name','lastname','firstname','middlename','suffix','defendantstatus','defendantadditionalinfo','dob','birthcity','birthplace','age','gender','height','weight','haircolor','eyecolor','race','ethnicity','skincolor','bodymarks','physicalbuild','photoname','dlnumber','dlstate','phone','phonetype','uscitizenflag','addresstype','street','unit','city','orig_state','orig_zip','county','institutionname','institutiondetails','institutionreceiptdate','releasetolocation','releasetodetails','deceasedflag','deceaseddate','healthflag','healthdesc','bloodtype','sexoffenderregistrydate','sexoffenderregexpirationdate','sexoffenderregistrynumber','sourceid','caseid','casenumber','casetitle','casetype','casestatus','casestatusdate','casecomments','fileddate','caseinfo','docketnumber','offensecode','offensedesc','offensedate','offensetype','offensedegree','offenseclass','dispositionstatus','dispositionstatusdate','disposition','dispositiondate','offenselocation','finaloffense','finaloffensedate','offensecount','victimunder18','prioroffenseflag','initialplea','initialpleadate','finalruling','finalrulingdate','appealstatus','appealdate','courtname','fineamount','courtfee','restitution','trialtype','courtdate','classification_code','sub_classification_code','state','zip','sourceid2','sentencedate','sentencebegindate','sentenceenddate','sentencetype','sentencemaxyears','sentencemaxmonths','sentencemaxdays','sentenceminyears','sentenceminmonths','sentencemindays','scheduledreleasedate','actualreleasedate','sentencestatus','timeservedyears','timeservedmonths','timeserveddays','publicservicehours','sentenceadditionalinfo','communitysupervisioncounty','communitysupervisionyears','communitysupervisionmonths','communitysupervisiondays','parolebegindate','paroleenddate','paroleeligibilitydate','parolehearingdate','parolemaxyears','parolemaxmonths','parolemaxdays','paroleminyears','paroleminmonths','parolemindays','parolestatus','paroleofficer','paroleoffcerphone','probationbegindate','probationenddate','probationmaxyears','probationmaxmonths','probationmaxdays','probationminyears','probationminmonths','probationmindays','probationstatus');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'recordid','sourcename','sourcetype','statecode','recordtype','recorduploaddate','docnumber','fbinumber','stateidnumber','inmatenumber','aliennumber','orig_ssn','nametype','name','lastname','firstname','middlename','suffix','defendantstatus','defendantadditionalinfo','dob','birthcity','birthplace','age','gender','height','weight','haircolor','eyecolor','race','ethnicity','skincolor','bodymarks','physicalbuild','photoname','dlnumber','dlstate','phone','phonetype','uscitizenflag','addresstype','street','unit','city','orig_state','orig_zip','county','institutionname','institutiondetails','institutionreceiptdate','releasetolocation','releasetodetails','deceasedflag','deceaseddate','healthflag','healthdesc','bloodtype','sexoffenderregistrydate','sexoffenderregexpirationdate','sexoffenderregistrynumber','sourceid','caseid','casenumber','casetitle','casetype','casestatus','casestatusdate','casecomments','fileddate','caseinfo','docketnumber','offensecode','offensedesc','offensedate','offensetype','offensedegree','offenseclass','dispositionstatus','dispositionstatusdate','disposition','dispositiondate','offenselocation','finaloffense','finaloffensedate','offensecount','victimunder18','prioroffenseflag','initialplea','initialpleadate','finalruling','finalrulingdate','appealstatus','appealdate','courtname','fineamount','courtfee','restitution','trialtype','courtdate','classification_code','sub_classification_code','state','zip','sourceid2','sentencedate','sentencebegindate','sentenceenddate','sentencetype','sentencemaxyears','sentencemaxmonths','sentencemaxdays','sentenceminyears','sentenceminmonths','sentencemindays','scheduledreleasedate','actualreleasedate','sentencestatus','timeservedyears','timeservedmonths','timeserveddays','publicservicehours','sentenceadditionalinfo','communitysupervisioncounty','communitysupervisionyears','communitysupervisionmonths','communitysupervisiondays','parolebegindate','paroleenddate','paroleeligibilitydate','parolehearingdate','parolemaxyears','parolemaxmonths','parolemaxdays','paroleminyears','paroleminmonths','parolemindays','parolestatus','paroleofficer','paroleoffcerphone','probationbegindate','probationenddate','probationmaxyears','probationmaxmonths','probationmaxdays','probationminyears','probationminmonths','probationmindays','probationstatus');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'recordid' => 0,'sourcename' => 1,'sourcetype' => 2,'statecode' => 3,'recordtype' => 4,'recorduploaddate' => 5,'docnumber' => 6,'fbinumber' => 7,'stateidnumber' => 8,'inmatenumber' => 9,'aliennumber' => 10,'orig_ssn' => 11,'nametype' => 12,'name' => 13,'lastname' => 14,'firstname' => 15,'middlename' => 16,'suffix' => 17,'defendantstatus' => 18,'defendantadditionalinfo' => 19,'dob' => 20,'birthcity' => 21,'birthplace' => 22,'age' => 23,'gender' => 24,'height' => 25,'weight' => 26,'haircolor' => 27,'eyecolor' => 28,'race' => 29,'ethnicity' => 30,'skincolor' => 31,'bodymarks' => 32,'physicalbuild' => 33,'photoname' => 34,'dlnumber' => 35,'dlstate' => 36,'phone' => 37,'phonetype' => 38,'uscitizenflag' => 39,'addresstype' => 40,'street' => 41,'unit' => 42,'city' => 43,'orig_state' => 44,'orig_zip' => 45,'county' => 46,'institutionname' => 47,'institutiondetails' => 48,'institutionreceiptdate' => 49,'releasetolocation' => 50,'releasetodetails' => 51,'deceasedflag' => 52,'deceaseddate' => 53,'healthflag' => 54,'healthdesc' => 55,'bloodtype' => 56,'sexoffenderregistrydate' => 57,'sexoffenderregexpirationdate' => 58,'sexoffenderregistrynumber' => 59,'sourceid' => 60,'caseid' => 61,'casenumber' => 62,'casetitle' => 63,'casetype' => 64,'casestatus' => 65,'casestatusdate' => 66,'casecomments' => 67,'fileddate' => 68,'caseinfo' => 69,'docketnumber' => 70,'offensecode' => 71,'offensedesc' => 72,'offensedate' => 73,'offensetype' => 74,'offensedegree' => 75,'offenseclass' => 76,'dispositionstatus' => 77,'dispositionstatusdate' => 78,'disposition' => 79,'dispositiondate' => 80,'offenselocation' => 81,'finaloffense' => 82,'finaloffensedate' => 83,'offensecount' => 84,'victimunder18' => 85,'prioroffenseflag' => 86,'initialplea' => 87,'initialpleadate' => 88,'finalruling' => 89,'finalrulingdate' => 90,'appealstatus' => 91,'appealdate' => 92,'courtname' => 93,'fineamount' => 94,'courtfee' => 95,'restitution' => 96,'trialtype' => 97,'courtdate' => 98,'classification_code' => 99,'sub_classification_code' => 100,'state' => 101,'zip' => 102,'sourceid2' => 103,'sentencedate' => 104,'sentencebegindate' => 105,'sentenceenddate' => 106,'sentencetype' => 107,'sentencemaxyears' => 108,'sentencemaxmonths' => 109,'sentencemaxdays' => 110,'sentenceminyears' => 111,'sentenceminmonths' => 112,'sentencemindays' => 113,'scheduledreleasedate' => 114,'actualreleasedate' => 115,'sentencestatus' => 116,'timeservedyears' => 117,'timeservedmonths' => 118,'timeserveddays' => 119,'publicservicehours' => 120,'sentenceadditionalinfo' => 121,'communitysupervisioncounty' => 122,'communitysupervisionyears' => 123,'communitysupervisionmonths' => 124,'communitysupervisiondays' => 125,'parolebegindate' => 126,'paroleenddate' => 127,'paroleeligibilitydate' => 128,'parolehearingdate' => 129,'parolemaxyears' => 130,'parolemaxmonths' => 131,'parolemaxdays' => 132,'paroleminyears' => 133,'paroleminmonths' => 134,'parolemindays' => 135,'parolestatus' => 136,'paroleofficer' => 137,'paroleoffcerphone' => 138,'probationbegindate' => 139,'probationenddate' => 140,'probationmaxyears' => 141,'probationmaxmonths' => 142,'probationmaxdays' => 143,'probationminyears' => 144,'probationminmonths' => 145,'probationmindays' => 146,'probationstatus' => 147,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],[],[],[],[],[],[],[],[],[],[],[],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],[],['ALLOW'],[],[],['ALLOW'],['ALLOW'],[],[],[],[],['ALLOW'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_recordid(SALT311.StrType s0) := s0;
EXPORT InValid_recordid(SALT311.StrType s) := 0;
EXPORT InValidMessage_recordid(UNSIGNED1 wh) := '';
 
EXPORT Make_sourcename(SALT311.StrType s0) := s0;
EXPORT InValid_sourcename(SALT311.StrType s) := 0;
EXPORT InValidMessage_sourcename(UNSIGNED1 wh) := '';
 
EXPORT Make_sourcetype(SALT311.StrType s0) := s0;
EXPORT InValid_sourcetype(SALT311.StrType s) := 0;
EXPORT InValidMessage_sourcetype(UNSIGNED1 wh) := '';
 
EXPORT Make_statecode(SALT311.StrType s0) := s0;
EXPORT InValid_statecode(SALT311.StrType s) := 0;
EXPORT InValidMessage_statecode(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_inmatenumber(SALT311.StrType s0) := s0;
EXPORT InValid_inmatenumber(SALT311.StrType s) := 0;
EXPORT InValidMessage_inmatenumber(UNSIGNED1 wh) := '';
 
EXPORT Make_aliennumber(SALT311.StrType s0) := s0;
EXPORT InValid_aliennumber(SALT311.StrType s) := 0;
EXPORT InValidMessage_aliennumber(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_ssn(SALT311.StrType s0) := s0;
EXPORT InValid_orig_ssn(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_ssn(UNSIGNED1 wh) := '';
 
EXPORT Make_nametype(SALT311.StrType s0) := s0;
EXPORT InValid_nametype(SALT311.StrType s) := 0;
EXPORT InValidMessage_nametype(UNSIGNED1 wh) := '';
 
EXPORT Make_name(SALT311.StrType s0) := MakeFT_invalid_orig_name(s0);
EXPORT InValid_name(SALT311.StrType s) := InValidFT_invalid_orig_name(s);
EXPORT InValidMessage_name(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_name(wh);
 
EXPORT Make_lastname(SALT311.StrType s0) := MakeFT_invalid_orig_parsed_name(s0);
EXPORT InValid_lastname(SALT311.StrType s) := InValidFT_invalid_orig_parsed_name(s);
EXPORT InValidMessage_lastname(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_parsed_name(wh);
 
EXPORT Make_firstname(SALT311.StrType s0) := MakeFT_invalid_orig_parsed_name(s0);
EXPORT InValid_firstname(SALT311.StrType s) := InValidFT_invalid_orig_parsed_name(s);
EXPORT InValidMessage_firstname(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_parsed_name(wh);
 
EXPORT Make_middlename(SALT311.StrType s0) := MakeFT_invalid_orig_parsed_name(s0);
EXPORT InValid_middlename(SALT311.StrType s) := InValidFT_invalid_orig_parsed_name(s);
EXPORT InValidMessage_middlename(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_parsed_name(wh);
 
EXPORT Make_suffix(SALT311.StrType s0) := MakeFT_invalid_orig_parsed_name(s0);
EXPORT InValid_suffix(SALT311.StrType s) := InValidFT_invalid_orig_parsed_name(s);
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_parsed_name(wh);
 
EXPORT Make_defendantstatus(SALT311.StrType s0) := s0;
EXPORT InValid_defendantstatus(SALT311.StrType s) := 0;
EXPORT InValidMessage_defendantstatus(UNSIGNED1 wh) := '';
 
EXPORT Make_defendantadditionalinfo(SALT311.StrType s0) := s0;
EXPORT InValid_defendantadditionalinfo(SALT311.StrType s) := 0;
EXPORT InValidMessage_defendantadditionalinfo(UNSIGNED1 wh) := '';
 
EXPORT Make_dob(SALT311.StrType s0) := MakeFT_invalid_number(s0);
EXPORT InValid_dob(SALT311.StrType s) := InValidFT_invalid_number(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_number(wh);
 
EXPORT Make_birthcity(SALT311.StrType s0) := s0;
EXPORT InValid_birthcity(SALT311.StrType s) := 0;
EXPORT InValidMessage_birthcity(UNSIGNED1 wh) := '';
 
EXPORT Make_birthplace(SALT311.StrType s0) := s0;
EXPORT InValid_birthplace(SALT311.StrType s) := 0;
EXPORT InValidMessage_birthplace(UNSIGNED1 wh) := '';
 
EXPORT Make_age(SALT311.StrType s0) := MakeFT_invalid_number(s0);
EXPORT InValid_age(SALT311.StrType s) := InValidFT_invalid_number(s);
EXPORT InValidMessage_age(UNSIGNED1 wh) := InValidMessageFT_invalid_number(wh);
 
EXPORT Make_gender(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_gender(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_gender(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
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
 
EXPORT Make_race(SALT311.StrType s0) := MakeFT_invalid_race(s0);
EXPORT InValid_race(SALT311.StrType s) := InValidFT_invalid_race(s);
EXPORT InValidMessage_race(UNSIGNED1 wh) := InValidMessageFT_invalid_race(wh);
 
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
 
EXPORT Make_dlstate(SALT311.StrType s0) := s0;
EXPORT InValid_dlstate(SALT311.StrType s) := 0;
EXPORT InValidMessage_dlstate(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_city(SALT311.StrType s0) := s0;
EXPORT InValid_city(SALT311.StrType s) := 0;
EXPORT InValidMessage_city(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_state(SALT311.StrType s0) := s0;
EXPORT InValid_orig_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_state(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_zip(SALT311.StrType s0) := s0;
EXPORT InValid_orig_zip(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_county(SALT311.StrType s0) := s0;
EXPORT InValid_county(SALT311.StrType s) := 0;
EXPORT InValidMessage_county(UNSIGNED1 wh) := '';
 
EXPORT Make_institutionname(SALT311.StrType s0) := s0;
EXPORT InValid_institutionname(SALT311.StrType s) := 0;
EXPORT InValidMessage_institutionname(UNSIGNED1 wh) := '';
 
EXPORT Make_institutiondetails(SALT311.StrType s0) := s0;
EXPORT InValid_institutiondetails(SALT311.StrType s) := 0;
EXPORT InValidMessage_institutiondetails(UNSIGNED1 wh) := '';
 
EXPORT Make_institutionreceiptdate(SALT311.StrType s0) := s0;
EXPORT InValid_institutionreceiptdate(SALT311.StrType s) := 0;
EXPORT InValidMessage_institutionreceiptdate(UNSIGNED1 wh) := '';
 
EXPORT Make_releasetolocation(SALT311.StrType s0) := s0;
EXPORT InValid_releasetolocation(SALT311.StrType s) := 0;
EXPORT InValidMessage_releasetolocation(UNSIGNED1 wh) := '';
 
EXPORT Make_releasetodetails(SALT311.StrType s0) := s0;
EXPORT InValid_releasetodetails(SALT311.StrType s) := 0;
EXPORT InValidMessage_releasetodetails(UNSIGNED1 wh) := '';
 
EXPORT Make_deceasedflag(SALT311.StrType s0) := s0;
EXPORT InValid_deceasedflag(SALT311.StrType s) := 0;
EXPORT InValidMessage_deceasedflag(UNSIGNED1 wh) := '';
 
EXPORT Make_deceaseddate(SALT311.StrType s0) := s0;
EXPORT InValid_deceaseddate(SALT311.StrType s) := 0;
EXPORT InValidMessage_deceaseddate(UNSIGNED1 wh) := '';
 
EXPORT Make_healthflag(SALT311.StrType s0) := s0;
EXPORT InValid_healthflag(SALT311.StrType s) := 0;
EXPORT InValidMessage_healthflag(UNSIGNED1 wh) := '';
 
EXPORT Make_healthdesc(SALT311.StrType s0) := s0;
EXPORT InValid_healthdesc(SALT311.StrType s) := 0;
EXPORT InValidMessage_healthdesc(UNSIGNED1 wh) := '';
 
EXPORT Make_bloodtype(SALT311.StrType s0) := s0;
EXPORT InValid_bloodtype(SALT311.StrType s) := 0;
EXPORT InValidMessage_bloodtype(UNSIGNED1 wh) := '';
 
EXPORT Make_sexoffenderregistrydate(SALT311.StrType s0) := s0;
EXPORT InValid_sexoffenderregistrydate(SALT311.StrType s) := 0;
EXPORT InValidMessage_sexoffenderregistrydate(UNSIGNED1 wh) := '';
 
EXPORT Make_sexoffenderregexpirationdate(SALT311.StrType s0) := s0;
EXPORT InValid_sexoffenderregexpirationdate(SALT311.StrType s) := 0;
EXPORT InValidMessage_sexoffenderregexpirationdate(UNSIGNED1 wh) := '';
 
EXPORT Make_sexoffenderregistrynumber(SALT311.StrType s0) := s0;
EXPORT InValid_sexoffenderregistrynumber(SALT311.StrType s) := 0;
EXPORT InValidMessage_sexoffenderregistrynumber(UNSIGNED1 wh) := '';
 
EXPORT Make_sourceid(SALT311.StrType s0) := s0;
EXPORT InValid_sourceid(SALT311.StrType s) := 0;
EXPORT InValidMessage_sourceid(UNSIGNED1 wh) := '';
 
EXPORT Make_caseid(SALT311.StrType s0) := s0;
EXPORT InValid_caseid(SALT311.StrType s) := 0;
EXPORT InValidMessage_caseid(UNSIGNED1 wh) := '';
 
EXPORT Make_casenumber(SALT311.StrType s0) := s0;
EXPORT InValid_casenumber(SALT311.StrType s) := 0;
EXPORT InValidMessage_casenumber(UNSIGNED1 wh) := '';
 
EXPORT Make_casetitle(SALT311.StrType s0) := s0;
EXPORT InValid_casetitle(SALT311.StrType s) := 0;
EXPORT InValidMessage_casetitle(UNSIGNED1 wh) := '';
 
EXPORT Make_casetype(SALT311.StrType s0) := s0;
EXPORT InValid_casetype(SALT311.StrType s) := 0;
EXPORT InValidMessage_casetype(UNSIGNED1 wh) := '';
 
EXPORT Make_casestatus(SALT311.StrType s0) := s0;
EXPORT InValid_casestatus(SALT311.StrType s) := 0;
EXPORT InValidMessage_casestatus(UNSIGNED1 wh) := '';
 
EXPORT Make_casestatusdate(SALT311.StrType s0) := s0;
EXPORT InValid_casestatusdate(SALT311.StrType s) := 0;
EXPORT InValidMessage_casestatusdate(UNSIGNED1 wh) := '';
 
EXPORT Make_casecomments(SALT311.StrType s0) := s0;
EXPORT InValid_casecomments(SALT311.StrType s) := 0;
EXPORT InValidMessage_casecomments(UNSIGNED1 wh) := '';
 
EXPORT Make_fileddate(SALT311.StrType s0) := s0;
EXPORT InValid_fileddate(SALT311.StrType s) := 0;
EXPORT InValidMessage_fileddate(UNSIGNED1 wh) := '';
 
EXPORT Make_caseinfo(SALT311.StrType s0) := s0;
EXPORT InValid_caseinfo(SALT311.StrType s) := 0;
EXPORT InValidMessage_caseinfo(UNSIGNED1 wh) := '';
 
EXPORT Make_docketnumber(SALT311.StrType s0) := s0;
EXPORT InValid_docketnumber(SALT311.StrType s) := 0;
EXPORT InValidMessage_docketnumber(UNSIGNED1 wh) := '';
 
EXPORT Make_offensecode(SALT311.StrType s0) := s0;
EXPORT InValid_offensecode(SALT311.StrType s) := 0;
EXPORT InValidMessage_offensecode(UNSIGNED1 wh) := '';
 
EXPORT Make_offensedesc(SALT311.StrType s0) := s0;
EXPORT InValid_offensedesc(SALT311.StrType s) := 0;
EXPORT InValidMessage_offensedesc(UNSIGNED1 wh) := '';
 
EXPORT Make_offensedate(SALT311.StrType s0) := s0;
EXPORT InValid_offensedate(SALT311.StrType s) := 0;
EXPORT InValidMessage_offensedate(UNSIGNED1 wh) := '';
 
EXPORT Make_offensetype(SALT311.StrType s0) := s0;
EXPORT InValid_offensetype(SALT311.StrType s) := 0;
EXPORT InValidMessage_offensetype(UNSIGNED1 wh) := '';
 
EXPORT Make_offensedegree(SALT311.StrType s0) := s0;
EXPORT InValid_offensedegree(SALT311.StrType s) := 0;
EXPORT InValidMessage_offensedegree(UNSIGNED1 wh) := '';
 
EXPORT Make_offenseclass(SALT311.StrType s0) := s0;
EXPORT InValid_offenseclass(SALT311.StrType s) := 0;
EXPORT InValidMessage_offenseclass(UNSIGNED1 wh) := '';
 
EXPORT Make_dispositionstatus(SALT311.StrType s0) := s0;
EXPORT InValid_dispositionstatus(SALT311.StrType s) := 0;
EXPORT InValidMessage_dispositionstatus(UNSIGNED1 wh) := '';
 
EXPORT Make_dispositionstatusdate(SALT311.StrType s0) := s0;
EXPORT InValid_dispositionstatusdate(SALT311.StrType s) := 0;
EXPORT InValidMessage_dispositionstatusdate(UNSIGNED1 wh) := '';
 
EXPORT Make_disposition(SALT311.StrType s0) := s0;
EXPORT InValid_disposition(SALT311.StrType s) := 0;
EXPORT InValidMessage_disposition(UNSIGNED1 wh) := '';
 
EXPORT Make_dispositiondate(SALT311.StrType s0) := s0;
EXPORT InValid_dispositiondate(SALT311.StrType s) := 0;
EXPORT InValidMessage_dispositiondate(UNSIGNED1 wh) := '';
 
EXPORT Make_offenselocation(SALT311.StrType s0) := s0;
EXPORT InValid_offenselocation(SALT311.StrType s) := 0;
EXPORT InValidMessage_offenselocation(UNSIGNED1 wh) := '';
 
EXPORT Make_finaloffense(SALT311.StrType s0) := s0;
EXPORT InValid_finaloffense(SALT311.StrType s) := 0;
EXPORT InValidMessage_finaloffense(UNSIGNED1 wh) := '';
 
EXPORT Make_finaloffensedate(SALT311.StrType s0) := s0;
EXPORT InValid_finaloffensedate(SALT311.StrType s) := 0;
EXPORT InValidMessage_finaloffensedate(UNSIGNED1 wh) := '';
 
EXPORT Make_offensecount(SALT311.StrType s0) := s0;
EXPORT InValid_offensecount(SALT311.StrType s) := 0;
EXPORT InValidMessage_offensecount(UNSIGNED1 wh) := '';
 
EXPORT Make_victimunder18(SALT311.StrType s0) := s0;
EXPORT InValid_victimunder18(SALT311.StrType s) := 0;
EXPORT InValidMessage_victimunder18(UNSIGNED1 wh) := '';
 
EXPORT Make_prioroffenseflag(SALT311.StrType s0) := s0;
EXPORT InValid_prioroffenseflag(SALT311.StrType s) := 0;
EXPORT InValidMessage_prioroffenseflag(UNSIGNED1 wh) := '';
 
EXPORT Make_initialplea(SALT311.StrType s0) := s0;
EXPORT InValid_initialplea(SALT311.StrType s) := 0;
EXPORT InValidMessage_initialplea(UNSIGNED1 wh) := '';
 
EXPORT Make_initialpleadate(SALT311.StrType s0) := s0;
EXPORT InValid_initialpleadate(SALT311.StrType s) := 0;
EXPORT InValidMessage_initialpleadate(UNSIGNED1 wh) := '';
 
EXPORT Make_finalruling(SALT311.StrType s0) := s0;
EXPORT InValid_finalruling(SALT311.StrType s) := 0;
EXPORT InValidMessage_finalruling(UNSIGNED1 wh) := '';
 
EXPORT Make_finalrulingdate(SALT311.StrType s0) := s0;
EXPORT InValid_finalrulingdate(SALT311.StrType s) := 0;
EXPORT InValidMessage_finalrulingdate(UNSIGNED1 wh) := '';
 
EXPORT Make_appealstatus(SALT311.StrType s0) := s0;
EXPORT InValid_appealstatus(SALT311.StrType s) := 0;
EXPORT InValidMessage_appealstatus(UNSIGNED1 wh) := '';
 
EXPORT Make_appealdate(SALT311.StrType s0) := s0;
EXPORT InValid_appealdate(SALT311.StrType s) := 0;
EXPORT InValidMessage_appealdate(UNSIGNED1 wh) := '';
 
EXPORT Make_courtname(SALT311.StrType s0) := s0;
EXPORT InValid_courtname(SALT311.StrType s) := 0;
EXPORT InValidMessage_courtname(UNSIGNED1 wh) := '';
 
EXPORT Make_fineamount(SALT311.StrType s0) := s0;
EXPORT InValid_fineamount(SALT311.StrType s) := 0;
EXPORT InValidMessage_fineamount(UNSIGNED1 wh) := '';
 
EXPORT Make_courtfee(SALT311.StrType s0) := s0;
EXPORT InValid_courtfee(SALT311.StrType s) := 0;
EXPORT InValidMessage_courtfee(UNSIGNED1 wh) := '';
 
EXPORT Make_restitution(SALT311.StrType s0) := s0;
EXPORT InValid_restitution(SALT311.StrType s) := 0;
EXPORT InValidMessage_restitution(UNSIGNED1 wh) := '';
 
EXPORT Make_trialtype(SALT311.StrType s0) := s0;
EXPORT InValid_trialtype(SALT311.StrType s) := 0;
EXPORT InValidMessage_trialtype(UNSIGNED1 wh) := '';
 
EXPORT Make_courtdate(SALT311.StrType s0) := s0;
EXPORT InValid_courtdate(SALT311.StrType s) := 0;
EXPORT InValidMessage_courtdate(UNSIGNED1 wh) := '';
 
EXPORT Make_classification_code(SALT311.StrType s0) := s0;
EXPORT InValid_classification_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_classification_code(UNSIGNED1 wh) := '';
 
EXPORT Make_sub_classification_code(SALT311.StrType s0) := s0;
EXPORT InValid_sub_classification_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_sub_classification_code(UNSIGNED1 wh) := '';
 
EXPORT Make_state(SALT311.StrType s0) := s0;
EXPORT InValid_state(SALT311.StrType s) := 0;
EXPORT InValidMessage_state(UNSIGNED1 wh) := '';
 
EXPORT Make_zip(SALT311.StrType s0) := s0;
EXPORT InValid_zip(SALT311.StrType s) := 0;
EXPORT InValidMessage_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_sourceid2(SALT311.StrType s0) := s0;
EXPORT InValid_sourceid2(SALT311.StrType s) := 0;
EXPORT InValidMessage_sourceid2(UNSIGNED1 wh) := '';
 
EXPORT Make_sentencedate(SALT311.StrType s0) := s0;
EXPORT InValid_sentencedate(SALT311.StrType s) := 0;
EXPORT InValidMessage_sentencedate(UNSIGNED1 wh) := '';
 
EXPORT Make_sentencebegindate(SALT311.StrType s0) := s0;
EXPORT InValid_sentencebegindate(SALT311.StrType s) := 0;
EXPORT InValidMessage_sentencebegindate(UNSIGNED1 wh) := '';
 
EXPORT Make_sentenceenddate(SALT311.StrType s0) := s0;
EXPORT InValid_sentenceenddate(SALT311.StrType s) := 0;
EXPORT InValidMessage_sentenceenddate(UNSIGNED1 wh) := '';
 
EXPORT Make_sentencetype(SALT311.StrType s0) := s0;
EXPORT InValid_sentencetype(SALT311.StrType s) := 0;
EXPORT InValidMessage_sentencetype(UNSIGNED1 wh) := '';
 
EXPORT Make_sentencemaxyears(SALT311.StrType s0) := s0;
EXPORT InValid_sentencemaxyears(SALT311.StrType s) := 0;
EXPORT InValidMessage_sentencemaxyears(UNSIGNED1 wh) := '';
 
EXPORT Make_sentencemaxmonths(SALT311.StrType s0) := s0;
EXPORT InValid_sentencemaxmonths(SALT311.StrType s) := 0;
EXPORT InValidMessage_sentencemaxmonths(UNSIGNED1 wh) := '';
 
EXPORT Make_sentencemaxdays(SALT311.StrType s0) := s0;
EXPORT InValid_sentencemaxdays(SALT311.StrType s) := 0;
EXPORT InValidMessage_sentencemaxdays(UNSIGNED1 wh) := '';
 
EXPORT Make_sentenceminyears(SALT311.StrType s0) := s0;
EXPORT InValid_sentenceminyears(SALT311.StrType s) := 0;
EXPORT InValidMessage_sentenceminyears(UNSIGNED1 wh) := '';
 
EXPORT Make_sentenceminmonths(SALT311.StrType s0) := s0;
EXPORT InValid_sentenceminmonths(SALT311.StrType s) := 0;
EXPORT InValidMessage_sentenceminmonths(UNSIGNED1 wh) := '';
 
EXPORT Make_sentencemindays(SALT311.StrType s0) := s0;
EXPORT InValid_sentencemindays(SALT311.StrType s) := 0;
EXPORT InValidMessage_sentencemindays(UNSIGNED1 wh) := '';
 
EXPORT Make_scheduledreleasedate(SALT311.StrType s0) := s0;
EXPORT InValid_scheduledreleasedate(SALT311.StrType s) := 0;
EXPORT InValidMessage_scheduledreleasedate(UNSIGNED1 wh) := '';
 
EXPORT Make_actualreleasedate(SALT311.StrType s0) := s0;
EXPORT InValid_actualreleasedate(SALT311.StrType s) := 0;
EXPORT InValidMessage_actualreleasedate(UNSIGNED1 wh) := '';
 
EXPORT Make_sentencestatus(SALT311.StrType s0) := s0;
EXPORT InValid_sentencestatus(SALT311.StrType s) := 0;
EXPORT InValidMessage_sentencestatus(UNSIGNED1 wh) := '';
 
EXPORT Make_timeservedyears(SALT311.StrType s0) := s0;
EXPORT InValid_timeservedyears(SALT311.StrType s) := 0;
EXPORT InValidMessage_timeservedyears(UNSIGNED1 wh) := '';
 
EXPORT Make_timeservedmonths(SALT311.StrType s0) := s0;
EXPORT InValid_timeservedmonths(SALT311.StrType s) := 0;
EXPORT InValidMessage_timeservedmonths(UNSIGNED1 wh) := '';
 
EXPORT Make_timeserveddays(SALT311.StrType s0) := s0;
EXPORT InValid_timeserveddays(SALT311.StrType s) := 0;
EXPORT InValidMessage_timeserveddays(UNSIGNED1 wh) := '';
 
EXPORT Make_publicservicehours(SALT311.StrType s0) := s0;
EXPORT InValid_publicservicehours(SALT311.StrType s) := 0;
EXPORT InValidMessage_publicservicehours(UNSIGNED1 wh) := '';
 
EXPORT Make_sentenceadditionalinfo(SALT311.StrType s0) := s0;
EXPORT InValid_sentenceadditionalinfo(SALT311.StrType s) := 0;
EXPORT InValidMessage_sentenceadditionalinfo(UNSIGNED1 wh) := '';
 
EXPORT Make_communitysupervisioncounty(SALT311.StrType s0) := s0;
EXPORT InValid_communitysupervisioncounty(SALT311.StrType s) := 0;
EXPORT InValidMessage_communitysupervisioncounty(UNSIGNED1 wh) := '';
 
EXPORT Make_communitysupervisionyears(SALT311.StrType s0) := s0;
EXPORT InValid_communitysupervisionyears(SALT311.StrType s) := 0;
EXPORT InValidMessage_communitysupervisionyears(UNSIGNED1 wh) := '';
 
EXPORT Make_communitysupervisionmonths(SALT311.StrType s0) := s0;
EXPORT InValid_communitysupervisionmonths(SALT311.StrType s) := 0;
EXPORT InValidMessage_communitysupervisionmonths(UNSIGNED1 wh) := '';
 
EXPORT Make_communitysupervisiondays(SALT311.StrType s0) := s0;
EXPORT InValid_communitysupervisiondays(SALT311.StrType s) := 0;
EXPORT InValidMessage_communitysupervisiondays(UNSIGNED1 wh) := '';
 
EXPORT Make_parolebegindate(SALT311.StrType s0) := s0;
EXPORT InValid_parolebegindate(SALT311.StrType s) := 0;
EXPORT InValidMessage_parolebegindate(UNSIGNED1 wh) := '';
 
EXPORT Make_paroleenddate(SALT311.StrType s0) := s0;
EXPORT InValid_paroleenddate(SALT311.StrType s) := 0;
EXPORT InValidMessage_paroleenddate(UNSIGNED1 wh) := '';
 
EXPORT Make_paroleeligibilitydate(SALT311.StrType s0) := s0;
EXPORT InValid_paroleeligibilitydate(SALT311.StrType s) := 0;
EXPORT InValidMessage_paroleeligibilitydate(UNSIGNED1 wh) := '';
 
EXPORT Make_parolehearingdate(SALT311.StrType s0) := s0;
EXPORT InValid_parolehearingdate(SALT311.StrType s) := 0;
EXPORT InValidMessage_parolehearingdate(UNSIGNED1 wh) := '';
 
EXPORT Make_parolemaxyears(SALT311.StrType s0) := s0;
EXPORT InValid_parolemaxyears(SALT311.StrType s) := 0;
EXPORT InValidMessage_parolemaxyears(UNSIGNED1 wh) := '';
 
EXPORT Make_parolemaxmonths(SALT311.StrType s0) := s0;
EXPORT InValid_parolemaxmonths(SALT311.StrType s) := 0;
EXPORT InValidMessage_parolemaxmonths(UNSIGNED1 wh) := '';
 
EXPORT Make_parolemaxdays(SALT311.StrType s0) := s0;
EXPORT InValid_parolemaxdays(SALT311.StrType s) := 0;
EXPORT InValidMessage_parolemaxdays(UNSIGNED1 wh) := '';
 
EXPORT Make_paroleminyears(SALT311.StrType s0) := s0;
EXPORT InValid_paroleminyears(SALT311.StrType s) := 0;
EXPORT InValidMessage_paroleminyears(UNSIGNED1 wh) := '';
 
EXPORT Make_paroleminmonths(SALT311.StrType s0) := s0;
EXPORT InValid_paroleminmonths(SALT311.StrType s) := 0;
EXPORT InValidMessage_paroleminmonths(UNSIGNED1 wh) := '';
 
EXPORT Make_parolemindays(SALT311.StrType s0) := s0;
EXPORT InValid_parolemindays(SALT311.StrType s) := 0;
EXPORT InValidMessage_parolemindays(UNSIGNED1 wh) := '';
 
EXPORT Make_parolestatus(SALT311.StrType s0) := s0;
EXPORT InValid_parolestatus(SALT311.StrType s) := 0;
EXPORT InValidMessage_parolestatus(UNSIGNED1 wh) := '';
 
EXPORT Make_paroleofficer(SALT311.StrType s0) := s0;
EXPORT InValid_paroleofficer(SALT311.StrType s) := 0;
EXPORT InValidMessage_paroleofficer(UNSIGNED1 wh) := '';
 
EXPORT Make_paroleoffcerphone(SALT311.StrType s0) := s0;
EXPORT InValid_paroleoffcerphone(SALT311.StrType s) := 0;
EXPORT InValidMessage_paroleoffcerphone(UNSIGNED1 wh) := '';
 
EXPORT Make_probationbegindate(SALT311.StrType s0) := s0;
EXPORT InValid_probationbegindate(SALT311.StrType s) := 0;
EXPORT InValidMessage_probationbegindate(UNSIGNED1 wh) := '';
 
EXPORT Make_probationenddate(SALT311.StrType s0) := s0;
EXPORT InValid_probationenddate(SALT311.StrType s) := 0;
EXPORT InValidMessage_probationenddate(UNSIGNED1 wh) := '';
 
EXPORT Make_probationmaxyears(SALT311.StrType s0) := s0;
EXPORT InValid_probationmaxyears(SALT311.StrType s) := 0;
EXPORT InValidMessage_probationmaxyears(UNSIGNED1 wh) := '';
 
EXPORT Make_probationmaxmonths(SALT311.StrType s0) := s0;
EXPORT InValid_probationmaxmonths(SALT311.StrType s) := 0;
EXPORT InValidMessage_probationmaxmonths(UNSIGNED1 wh) := '';
 
EXPORT Make_probationmaxdays(SALT311.StrType s0) := s0;
EXPORT InValid_probationmaxdays(SALT311.StrType s) := 0;
EXPORT InValidMessage_probationmaxdays(UNSIGNED1 wh) := '';
 
EXPORT Make_probationminyears(SALT311.StrType s0) := s0;
EXPORT InValid_probationminyears(SALT311.StrType s) := 0;
EXPORT InValidMessage_probationminyears(UNSIGNED1 wh) := '';
 
EXPORT Make_probationminmonths(SALT311.StrType s0) := s0;
EXPORT InValid_probationminmonths(SALT311.StrType s) := 0;
EXPORT InValidMessage_probationminmonths(UNSIGNED1 wh) := '';
 
EXPORT Make_probationmindays(SALT311.StrType s0) := s0;
EXPORT InValid_probationmindays(SALT311.StrType s) := 0;
EXPORT InValidMessage_probationmindays(UNSIGNED1 wh) := '';
 
EXPORT Make_probationstatus(SALT311.StrType s0) := s0;
EXPORT InValid_probationstatus(SALT311.StrType s) := 0;
EXPORT InValidMessage_probationstatus(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,scrubs_Fed_Bureau_Prisons;
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
    BOOLEAN Diff_caseid;
    BOOLEAN Diff_casenumber;
    BOOLEAN Diff_casetitle;
    BOOLEAN Diff_casetype;
    BOOLEAN Diff_casestatus;
    BOOLEAN Diff_casestatusdate;
    BOOLEAN Diff_casecomments;
    BOOLEAN Diff_fileddate;
    BOOLEAN Diff_caseinfo;
    BOOLEAN Diff_docketnumber;
    BOOLEAN Diff_offensecode;
    BOOLEAN Diff_offensedesc;
    BOOLEAN Diff_offensedate;
    BOOLEAN Diff_offensetype;
    BOOLEAN Diff_offensedegree;
    BOOLEAN Diff_offenseclass;
    BOOLEAN Diff_dispositionstatus;
    BOOLEAN Diff_dispositionstatusdate;
    BOOLEAN Diff_disposition;
    BOOLEAN Diff_dispositiondate;
    BOOLEAN Diff_offenselocation;
    BOOLEAN Diff_finaloffense;
    BOOLEAN Diff_finaloffensedate;
    BOOLEAN Diff_offensecount;
    BOOLEAN Diff_victimunder18;
    BOOLEAN Diff_prioroffenseflag;
    BOOLEAN Diff_initialplea;
    BOOLEAN Diff_initialpleadate;
    BOOLEAN Diff_finalruling;
    BOOLEAN Diff_finalrulingdate;
    BOOLEAN Diff_appealstatus;
    BOOLEAN Diff_appealdate;
    BOOLEAN Diff_courtname;
    BOOLEAN Diff_fineamount;
    BOOLEAN Diff_courtfee;
    BOOLEAN Diff_restitution;
    BOOLEAN Diff_trialtype;
    BOOLEAN Diff_courtdate;
    BOOLEAN Diff_classification_code;
    BOOLEAN Diff_sub_classification_code;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_sourceid2;
    BOOLEAN Diff_sentencedate;
    BOOLEAN Diff_sentencebegindate;
    BOOLEAN Diff_sentenceenddate;
    BOOLEAN Diff_sentencetype;
    BOOLEAN Diff_sentencemaxyears;
    BOOLEAN Diff_sentencemaxmonths;
    BOOLEAN Diff_sentencemaxdays;
    BOOLEAN Diff_sentenceminyears;
    BOOLEAN Diff_sentenceminmonths;
    BOOLEAN Diff_sentencemindays;
    BOOLEAN Diff_scheduledreleasedate;
    BOOLEAN Diff_actualreleasedate;
    BOOLEAN Diff_sentencestatus;
    BOOLEAN Diff_timeservedyears;
    BOOLEAN Diff_timeservedmonths;
    BOOLEAN Diff_timeserveddays;
    BOOLEAN Diff_publicservicehours;
    BOOLEAN Diff_sentenceadditionalinfo;
    BOOLEAN Diff_communitysupervisioncounty;
    BOOLEAN Diff_communitysupervisionyears;
    BOOLEAN Diff_communitysupervisionmonths;
    BOOLEAN Diff_communitysupervisiondays;
    BOOLEAN Diff_parolebegindate;
    BOOLEAN Diff_paroleenddate;
    BOOLEAN Diff_paroleeligibilitydate;
    BOOLEAN Diff_parolehearingdate;
    BOOLEAN Diff_parolemaxyears;
    BOOLEAN Diff_parolemaxmonths;
    BOOLEAN Diff_parolemaxdays;
    BOOLEAN Diff_paroleminyears;
    BOOLEAN Diff_paroleminmonths;
    BOOLEAN Diff_parolemindays;
    BOOLEAN Diff_parolestatus;
    BOOLEAN Diff_paroleofficer;
    BOOLEAN Diff_paroleoffcerphone;
    BOOLEAN Diff_probationbegindate;
    BOOLEAN Diff_probationenddate;
    BOOLEAN Diff_probationmaxyears;
    BOOLEAN Diff_probationmaxmonths;
    BOOLEAN Diff_probationmaxdays;
    BOOLEAN Diff_probationminyears;
    BOOLEAN Diff_probationminmonths;
    BOOLEAN Diff_probationmindays;
    BOOLEAN Diff_probationstatus;
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
    SELF.Diff_caseid := le.caseid <> ri.caseid;
    SELF.Diff_casenumber := le.casenumber <> ri.casenumber;
    SELF.Diff_casetitle := le.casetitle <> ri.casetitle;
    SELF.Diff_casetype := le.casetype <> ri.casetype;
    SELF.Diff_casestatus := le.casestatus <> ri.casestatus;
    SELF.Diff_casestatusdate := le.casestatusdate <> ri.casestatusdate;
    SELF.Diff_casecomments := le.casecomments <> ri.casecomments;
    SELF.Diff_fileddate := le.fileddate <> ri.fileddate;
    SELF.Diff_caseinfo := le.caseinfo <> ri.caseinfo;
    SELF.Diff_docketnumber := le.docketnumber <> ri.docketnumber;
    SELF.Diff_offensecode := le.offensecode <> ri.offensecode;
    SELF.Diff_offensedesc := le.offensedesc <> ri.offensedesc;
    SELF.Diff_offensedate := le.offensedate <> ri.offensedate;
    SELF.Diff_offensetype := le.offensetype <> ri.offensetype;
    SELF.Diff_offensedegree := le.offensedegree <> ri.offensedegree;
    SELF.Diff_offenseclass := le.offenseclass <> ri.offenseclass;
    SELF.Diff_dispositionstatus := le.dispositionstatus <> ri.dispositionstatus;
    SELF.Diff_dispositionstatusdate := le.dispositionstatusdate <> ri.dispositionstatusdate;
    SELF.Diff_disposition := le.disposition <> ri.disposition;
    SELF.Diff_dispositiondate := le.dispositiondate <> ri.dispositiondate;
    SELF.Diff_offenselocation := le.offenselocation <> ri.offenselocation;
    SELF.Diff_finaloffense := le.finaloffense <> ri.finaloffense;
    SELF.Diff_finaloffensedate := le.finaloffensedate <> ri.finaloffensedate;
    SELF.Diff_offensecount := le.offensecount <> ri.offensecount;
    SELF.Diff_victimunder18 := le.victimunder18 <> ri.victimunder18;
    SELF.Diff_prioroffenseflag := le.prioroffenseflag <> ri.prioroffenseflag;
    SELF.Diff_initialplea := le.initialplea <> ri.initialplea;
    SELF.Diff_initialpleadate := le.initialpleadate <> ri.initialpleadate;
    SELF.Diff_finalruling := le.finalruling <> ri.finalruling;
    SELF.Diff_finalrulingdate := le.finalrulingdate <> ri.finalrulingdate;
    SELF.Diff_appealstatus := le.appealstatus <> ri.appealstatus;
    SELF.Diff_appealdate := le.appealdate <> ri.appealdate;
    SELF.Diff_courtname := le.courtname <> ri.courtname;
    SELF.Diff_fineamount := le.fineamount <> ri.fineamount;
    SELF.Diff_courtfee := le.courtfee <> ri.courtfee;
    SELF.Diff_restitution := le.restitution <> ri.restitution;
    SELF.Diff_trialtype := le.trialtype <> ri.trialtype;
    SELF.Diff_courtdate := le.courtdate <> ri.courtdate;
    SELF.Diff_classification_code := le.classification_code <> ri.classification_code;
    SELF.Diff_sub_classification_code := le.sub_classification_code <> ri.sub_classification_code;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_sourceid2 := le.sourceid2 <> ri.sourceid2;
    SELF.Diff_sentencedate := le.sentencedate <> ri.sentencedate;
    SELF.Diff_sentencebegindate := le.sentencebegindate <> ri.sentencebegindate;
    SELF.Diff_sentenceenddate := le.sentenceenddate <> ri.sentenceenddate;
    SELF.Diff_sentencetype := le.sentencetype <> ri.sentencetype;
    SELF.Diff_sentencemaxyears := le.sentencemaxyears <> ri.sentencemaxyears;
    SELF.Diff_sentencemaxmonths := le.sentencemaxmonths <> ri.sentencemaxmonths;
    SELF.Diff_sentencemaxdays := le.sentencemaxdays <> ri.sentencemaxdays;
    SELF.Diff_sentenceminyears := le.sentenceminyears <> ri.sentenceminyears;
    SELF.Diff_sentenceminmonths := le.sentenceminmonths <> ri.sentenceminmonths;
    SELF.Diff_sentencemindays := le.sentencemindays <> ri.sentencemindays;
    SELF.Diff_scheduledreleasedate := le.scheduledreleasedate <> ri.scheduledreleasedate;
    SELF.Diff_actualreleasedate := le.actualreleasedate <> ri.actualreleasedate;
    SELF.Diff_sentencestatus := le.sentencestatus <> ri.sentencestatus;
    SELF.Diff_timeservedyears := le.timeservedyears <> ri.timeservedyears;
    SELF.Diff_timeservedmonths := le.timeservedmonths <> ri.timeservedmonths;
    SELF.Diff_timeserveddays := le.timeserveddays <> ri.timeserveddays;
    SELF.Diff_publicservicehours := le.publicservicehours <> ri.publicservicehours;
    SELF.Diff_sentenceadditionalinfo := le.sentenceadditionalinfo <> ri.sentenceadditionalinfo;
    SELF.Diff_communitysupervisioncounty := le.communitysupervisioncounty <> ri.communitysupervisioncounty;
    SELF.Diff_communitysupervisionyears := le.communitysupervisionyears <> ri.communitysupervisionyears;
    SELF.Diff_communitysupervisionmonths := le.communitysupervisionmonths <> ri.communitysupervisionmonths;
    SELF.Diff_communitysupervisiondays := le.communitysupervisiondays <> ri.communitysupervisiondays;
    SELF.Diff_parolebegindate := le.parolebegindate <> ri.parolebegindate;
    SELF.Diff_paroleenddate := le.paroleenddate <> ri.paroleenddate;
    SELF.Diff_paroleeligibilitydate := le.paroleeligibilitydate <> ri.paroleeligibilitydate;
    SELF.Diff_parolehearingdate := le.parolehearingdate <> ri.parolehearingdate;
    SELF.Diff_parolemaxyears := le.parolemaxyears <> ri.parolemaxyears;
    SELF.Diff_parolemaxmonths := le.parolemaxmonths <> ri.parolemaxmonths;
    SELF.Diff_parolemaxdays := le.parolemaxdays <> ri.parolemaxdays;
    SELF.Diff_paroleminyears := le.paroleminyears <> ri.paroleminyears;
    SELF.Diff_paroleminmonths := le.paroleminmonths <> ri.paroleminmonths;
    SELF.Diff_parolemindays := le.parolemindays <> ri.parolemindays;
    SELF.Diff_parolestatus := le.parolestatus <> ri.parolestatus;
    SELF.Diff_paroleofficer := le.paroleofficer <> ri.paroleofficer;
    SELF.Diff_paroleoffcerphone := le.paroleoffcerphone <> ri.paroleoffcerphone;
    SELF.Diff_probationbegindate := le.probationbegindate <> ri.probationbegindate;
    SELF.Diff_probationenddate := le.probationenddate <> ri.probationenddate;
    SELF.Diff_probationmaxyears := le.probationmaxyears <> ri.probationmaxyears;
    SELF.Diff_probationmaxmonths := le.probationmaxmonths <> ri.probationmaxmonths;
    SELF.Diff_probationmaxdays := le.probationmaxdays <> ri.probationmaxdays;
    SELF.Diff_probationminyears := le.probationminyears <> ri.probationminyears;
    SELF.Diff_probationminmonths := le.probationminmonths <> ri.probationminmonths;
    SELF.Diff_probationmindays := le.probationmindays <> ri.probationmindays;
    SELF.Diff_probationstatus := le.probationstatus <> ri.probationstatus;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_recordid,1,0)+ IF( SELF.Diff_sourcename,1,0)+ IF( SELF.Diff_sourcetype,1,0)+ IF( SELF.Diff_statecode,1,0)+ IF( SELF.Diff_recordtype,1,0)+ IF( SELF.Diff_recorduploaddate,1,0)+ IF( SELF.Diff_docnumber,1,0)+ IF( SELF.Diff_fbinumber,1,0)+ IF( SELF.Diff_stateidnumber,1,0)+ IF( SELF.Diff_inmatenumber,1,0)+ IF( SELF.Diff_aliennumber,1,0)+ IF( SELF.Diff_orig_ssn,1,0)+ IF( SELF.Diff_nametype,1,0)+ IF( SELF.Diff_name,1,0)+ IF( SELF.Diff_lastname,1,0)+ IF( SELF.Diff_firstname,1,0)+ IF( SELF.Diff_middlename,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_defendantstatus,1,0)+ IF( SELF.Diff_defendantadditionalinfo,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_birthcity,1,0)+ IF( SELF.Diff_birthplace,1,0)+ IF( SELF.Diff_age,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_height,1,0)+ IF( SELF.Diff_weight,1,0)+ IF( SELF.Diff_haircolor,1,0)+ IF( SELF.Diff_eyecolor,1,0)+ IF( SELF.Diff_race,1,0)+ IF( SELF.Diff_ethnicity,1,0)+ IF( SELF.Diff_skincolor,1,0)+ IF( SELF.Diff_bodymarks,1,0)+ IF( SELF.Diff_physicalbuild,1,0)+ IF( SELF.Diff_photoname,1,0)+ IF( SELF.Diff_dlnumber,1,0)+ IF( SELF.Diff_dlstate,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_phonetype,1,0)+ IF( SELF.Diff_uscitizenflag,1,0)+ IF( SELF.Diff_addresstype,1,0)+ IF( SELF.Diff_street,1,0)+ IF( SELF.Diff_unit,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_orig_state,1,0)+ IF( SELF.Diff_orig_zip,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_institutionname,1,0)+ IF( SELF.Diff_institutiondetails,1,0)+ IF( SELF.Diff_institutionreceiptdate,1,0)+ IF( SELF.Diff_releasetolocation,1,0)+ IF( SELF.Diff_releasetodetails,1,0)+ IF( SELF.Diff_deceasedflag,1,0)+ IF( SELF.Diff_deceaseddate,1,0)+ IF( SELF.Diff_healthflag,1,0)+ IF( SELF.Diff_healthdesc,1,0)+ IF( SELF.Diff_bloodtype,1,0)+ IF( SELF.Diff_sexoffenderregistrydate,1,0)+ IF( SELF.Diff_sexoffenderregexpirationdate,1,0)+ IF( SELF.Diff_sexoffenderregistrynumber,1,0)+ IF( SELF.Diff_sourceid,1,0)+ IF( SELF.Diff_caseid,1,0)+ IF( SELF.Diff_casenumber,1,0)+ IF( SELF.Diff_casetitle,1,0)+ IF( SELF.Diff_casetype,1,0)+ IF( SELF.Diff_casestatus,1,0)+ IF( SELF.Diff_casestatusdate,1,0)+ IF( SELF.Diff_casecomments,1,0)+ IF( SELF.Diff_fileddate,1,0)+ IF( SELF.Diff_caseinfo,1,0)+ IF( SELF.Diff_docketnumber,1,0)+ IF( SELF.Diff_offensecode,1,0)+ IF( SELF.Diff_offensedesc,1,0)+ IF( SELF.Diff_offensedate,1,0)+ IF( SELF.Diff_offensetype,1,0)+ IF( SELF.Diff_offensedegree,1,0)+ IF( SELF.Diff_offenseclass,1,0)+ IF( SELF.Diff_dispositionstatus,1,0)+ IF( SELF.Diff_dispositionstatusdate,1,0)+ IF( SELF.Diff_disposition,1,0)+ IF( SELF.Diff_dispositiondate,1,0)+ IF( SELF.Diff_offenselocation,1,0)+ IF( SELF.Diff_finaloffense,1,0)+ IF( SELF.Diff_finaloffensedate,1,0)+ IF( SELF.Diff_offensecount,1,0)+ IF( SELF.Diff_victimunder18,1,0)+ IF( SELF.Diff_prioroffenseflag,1,0)+ IF( SELF.Diff_initialplea,1,0)+ IF( SELF.Diff_initialpleadate,1,0)+ IF( SELF.Diff_finalruling,1,0)+ IF( SELF.Diff_finalrulingdate,1,0)+ IF( SELF.Diff_appealstatus,1,0)+ IF( SELF.Diff_appealdate,1,0)+ IF( SELF.Diff_courtname,1,0)+ IF( SELF.Diff_fineamount,1,0)+ IF( SELF.Diff_courtfee,1,0)+ IF( SELF.Diff_restitution,1,0)+ IF( SELF.Diff_trialtype,1,0)+ IF( SELF.Diff_courtdate,1,0)+ IF( SELF.Diff_classification_code,1,0)+ IF( SELF.Diff_sub_classification_code,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_sourceid2,1,0)+ IF( SELF.Diff_sentencedate,1,0)+ IF( SELF.Diff_sentencebegindate,1,0)+ IF( SELF.Diff_sentenceenddate,1,0)+ IF( SELF.Diff_sentencetype,1,0)+ IF( SELF.Diff_sentencemaxyears,1,0)+ IF( SELF.Diff_sentencemaxmonths,1,0)+ IF( SELF.Diff_sentencemaxdays,1,0)+ IF( SELF.Diff_sentenceminyears,1,0)+ IF( SELF.Diff_sentenceminmonths,1,0)+ IF( SELF.Diff_sentencemindays,1,0)+ IF( SELF.Diff_scheduledreleasedate,1,0)+ IF( SELF.Diff_actualreleasedate,1,0)+ IF( SELF.Diff_sentencestatus,1,0)+ IF( SELF.Diff_timeservedyears,1,0)+ IF( SELF.Diff_timeservedmonths,1,0)+ IF( SELF.Diff_timeserveddays,1,0)+ IF( SELF.Diff_publicservicehours,1,0)+ IF( SELF.Diff_sentenceadditionalinfo,1,0)+ IF( SELF.Diff_communitysupervisioncounty,1,0)+ IF( SELF.Diff_communitysupervisionyears,1,0)+ IF( SELF.Diff_communitysupervisionmonths,1,0)+ IF( SELF.Diff_communitysupervisiondays,1,0)+ IF( SELF.Diff_parolebegindate,1,0)+ IF( SELF.Diff_paroleenddate,1,0)+ IF( SELF.Diff_paroleeligibilitydate,1,0)+ IF( SELF.Diff_parolehearingdate,1,0)+ IF( SELF.Diff_parolemaxyears,1,0)+ IF( SELF.Diff_parolemaxmonths,1,0)+ IF( SELF.Diff_parolemaxdays,1,0)+ IF( SELF.Diff_paroleminyears,1,0)+ IF( SELF.Diff_paroleminmonths,1,0)+ IF( SELF.Diff_parolemindays,1,0)+ IF( SELF.Diff_parolestatus,1,0)+ IF( SELF.Diff_paroleofficer,1,0)+ IF( SELF.Diff_paroleoffcerphone,1,0)+ IF( SELF.Diff_probationbegindate,1,0)+ IF( SELF.Diff_probationenddate,1,0)+ IF( SELF.Diff_probationmaxyears,1,0)+ IF( SELF.Diff_probationmaxmonths,1,0)+ IF( SELF.Diff_probationmaxdays,1,0)+ IF( SELF.Diff_probationminyears,1,0)+ IF( SELF.Diff_probationminmonths,1,0)+ IF( SELF.Diff_probationmindays,1,0)+ IF( SELF.Diff_probationstatus,1,0);
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
    Count_Diff_caseid := COUNT(GROUP,%Closest%.Diff_caseid);
    Count_Diff_casenumber := COUNT(GROUP,%Closest%.Diff_casenumber);
    Count_Diff_casetitle := COUNT(GROUP,%Closest%.Diff_casetitle);
    Count_Diff_casetype := COUNT(GROUP,%Closest%.Diff_casetype);
    Count_Diff_casestatus := COUNT(GROUP,%Closest%.Diff_casestatus);
    Count_Diff_casestatusdate := COUNT(GROUP,%Closest%.Diff_casestatusdate);
    Count_Diff_casecomments := COUNT(GROUP,%Closest%.Diff_casecomments);
    Count_Diff_fileddate := COUNT(GROUP,%Closest%.Diff_fileddate);
    Count_Diff_caseinfo := COUNT(GROUP,%Closest%.Diff_caseinfo);
    Count_Diff_docketnumber := COUNT(GROUP,%Closest%.Diff_docketnumber);
    Count_Diff_offensecode := COUNT(GROUP,%Closest%.Diff_offensecode);
    Count_Diff_offensedesc := COUNT(GROUP,%Closest%.Diff_offensedesc);
    Count_Diff_offensedate := COUNT(GROUP,%Closest%.Diff_offensedate);
    Count_Diff_offensetype := COUNT(GROUP,%Closest%.Diff_offensetype);
    Count_Diff_offensedegree := COUNT(GROUP,%Closest%.Diff_offensedegree);
    Count_Diff_offenseclass := COUNT(GROUP,%Closest%.Diff_offenseclass);
    Count_Diff_dispositionstatus := COUNT(GROUP,%Closest%.Diff_dispositionstatus);
    Count_Diff_dispositionstatusdate := COUNT(GROUP,%Closest%.Diff_dispositionstatusdate);
    Count_Diff_disposition := COUNT(GROUP,%Closest%.Diff_disposition);
    Count_Diff_dispositiondate := COUNT(GROUP,%Closest%.Diff_dispositiondate);
    Count_Diff_offenselocation := COUNT(GROUP,%Closest%.Diff_offenselocation);
    Count_Diff_finaloffense := COUNT(GROUP,%Closest%.Diff_finaloffense);
    Count_Diff_finaloffensedate := COUNT(GROUP,%Closest%.Diff_finaloffensedate);
    Count_Diff_offensecount := COUNT(GROUP,%Closest%.Diff_offensecount);
    Count_Diff_victimunder18 := COUNT(GROUP,%Closest%.Diff_victimunder18);
    Count_Diff_prioroffenseflag := COUNT(GROUP,%Closest%.Diff_prioroffenseflag);
    Count_Diff_initialplea := COUNT(GROUP,%Closest%.Diff_initialplea);
    Count_Diff_initialpleadate := COUNT(GROUP,%Closest%.Diff_initialpleadate);
    Count_Diff_finalruling := COUNT(GROUP,%Closest%.Diff_finalruling);
    Count_Diff_finalrulingdate := COUNT(GROUP,%Closest%.Diff_finalrulingdate);
    Count_Diff_appealstatus := COUNT(GROUP,%Closest%.Diff_appealstatus);
    Count_Diff_appealdate := COUNT(GROUP,%Closest%.Diff_appealdate);
    Count_Diff_courtname := COUNT(GROUP,%Closest%.Diff_courtname);
    Count_Diff_fineamount := COUNT(GROUP,%Closest%.Diff_fineamount);
    Count_Diff_courtfee := COUNT(GROUP,%Closest%.Diff_courtfee);
    Count_Diff_restitution := COUNT(GROUP,%Closest%.Diff_restitution);
    Count_Diff_trialtype := COUNT(GROUP,%Closest%.Diff_trialtype);
    Count_Diff_courtdate := COUNT(GROUP,%Closest%.Diff_courtdate);
    Count_Diff_classification_code := COUNT(GROUP,%Closest%.Diff_classification_code);
    Count_Diff_sub_classification_code := COUNT(GROUP,%Closest%.Diff_sub_classification_code);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_sourceid2 := COUNT(GROUP,%Closest%.Diff_sourceid2);
    Count_Diff_sentencedate := COUNT(GROUP,%Closest%.Diff_sentencedate);
    Count_Diff_sentencebegindate := COUNT(GROUP,%Closest%.Diff_sentencebegindate);
    Count_Diff_sentenceenddate := COUNT(GROUP,%Closest%.Diff_sentenceenddate);
    Count_Diff_sentencetype := COUNT(GROUP,%Closest%.Diff_sentencetype);
    Count_Diff_sentencemaxyears := COUNT(GROUP,%Closest%.Diff_sentencemaxyears);
    Count_Diff_sentencemaxmonths := COUNT(GROUP,%Closest%.Diff_sentencemaxmonths);
    Count_Diff_sentencemaxdays := COUNT(GROUP,%Closest%.Diff_sentencemaxdays);
    Count_Diff_sentenceminyears := COUNT(GROUP,%Closest%.Diff_sentenceminyears);
    Count_Diff_sentenceminmonths := COUNT(GROUP,%Closest%.Diff_sentenceminmonths);
    Count_Diff_sentencemindays := COUNT(GROUP,%Closest%.Diff_sentencemindays);
    Count_Diff_scheduledreleasedate := COUNT(GROUP,%Closest%.Diff_scheduledreleasedate);
    Count_Diff_actualreleasedate := COUNT(GROUP,%Closest%.Diff_actualreleasedate);
    Count_Diff_sentencestatus := COUNT(GROUP,%Closest%.Diff_sentencestatus);
    Count_Diff_timeservedyears := COUNT(GROUP,%Closest%.Diff_timeservedyears);
    Count_Diff_timeservedmonths := COUNT(GROUP,%Closest%.Diff_timeservedmonths);
    Count_Diff_timeserveddays := COUNT(GROUP,%Closest%.Diff_timeserveddays);
    Count_Diff_publicservicehours := COUNT(GROUP,%Closest%.Diff_publicservicehours);
    Count_Diff_sentenceadditionalinfo := COUNT(GROUP,%Closest%.Diff_sentenceadditionalinfo);
    Count_Diff_communitysupervisioncounty := COUNT(GROUP,%Closest%.Diff_communitysupervisioncounty);
    Count_Diff_communitysupervisionyears := COUNT(GROUP,%Closest%.Diff_communitysupervisionyears);
    Count_Diff_communitysupervisionmonths := COUNT(GROUP,%Closest%.Diff_communitysupervisionmonths);
    Count_Diff_communitysupervisiondays := COUNT(GROUP,%Closest%.Diff_communitysupervisiondays);
    Count_Diff_parolebegindate := COUNT(GROUP,%Closest%.Diff_parolebegindate);
    Count_Diff_paroleenddate := COUNT(GROUP,%Closest%.Diff_paroleenddate);
    Count_Diff_paroleeligibilitydate := COUNT(GROUP,%Closest%.Diff_paroleeligibilitydate);
    Count_Diff_parolehearingdate := COUNT(GROUP,%Closest%.Diff_parolehearingdate);
    Count_Diff_parolemaxyears := COUNT(GROUP,%Closest%.Diff_parolemaxyears);
    Count_Diff_parolemaxmonths := COUNT(GROUP,%Closest%.Diff_parolemaxmonths);
    Count_Diff_parolemaxdays := COUNT(GROUP,%Closest%.Diff_parolemaxdays);
    Count_Diff_paroleminyears := COUNT(GROUP,%Closest%.Diff_paroleminyears);
    Count_Diff_paroleminmonths := COUNT(GROUP,%Closest%.Diff_paroleminmonths);
    Count_Diff_parolemindays := COUNT(GROUP,%Closest%.Diff_parolemindays);
    Count_Diff_parolestatus := COUNT(GROUP,%Closest%.Diff_parolestatus);
    Count_Diff_paroleofficer := COUNT(GROUP,%Closest%.Diff_paroleofficer);
    Count_Diff_paroleoffcerphone := COUNT(GROUP,%Closest%.Diff_paroleoffcerphone);
    Count_Diff_probationbegindate := COUNT(GROUP,%Closest%.Diff_probationbegindate);
    Count_Diff_probationenddate := COUNT(GROUP,%Closest%.Diff_probationenddate);
    Count_Diff_probationmaxyears := COUNT(GROUP,%Closest%.Diff_probationmaxyears);
    Count_Diff_probationmaxmonths := COUNT(GROUP,%Closest%.Diff_probationmaxmonths);
    Count_Diff_probationmaxdays := COUNT(GROUP,%Closest%.Diff_probationmaxdays);
    Count_Diff_probationminyears := COUNT(GROUP,%Closest%.Diff_probationminyears);
    Count_Diff_probationminmonths := COUNT(GROUP,%Closest%.Diff_probationminmonths);
    Count_Diff_probationmindays := COUNT(GROUP,%Closest%.Diff_probationmindays);
    Count_Diff_probationstatus := COUNT(GROUP,%Closest%.Diff_probationstatus);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
