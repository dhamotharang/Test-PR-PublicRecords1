IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Cert_Fields := MODULE
 
EXPORT NumFields := 181;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_Date','Invalid_No','Invalid_Float','Invalid_Alpha','Invalid_AlphaNum','Invalid_AlphaNumChar','Invalid_State','Invalid_Zip','Invalid_Phone','Invalid_NAICS');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_Date' => 1,'Invalid_No' => 2,'Invalid_Float' => 3,'Invalid_Alpha' => 4,'Invalid_AlphaNum' => 5,'Invalid_AlphaNumChar' => 6,'Invalid_State' => 7,'Invalid_Zip' => 8,'Invalid_Phone' => 9,'Invalid_NAICS' => 10,0);
 
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
 
EXPORT MakeFT_Invalid_NAICS(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_NAICS(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_naics(s)>0);
EXPORT InValidMessageFT_Invalid_NAICS(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_naics'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'date_firstseen','date_lastseen','bdid','did','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','unique_id','norm_type','norm_businessname','norm_firstname','norm_middle','norm_last','norm_suffix','norm_address1','norm_address2','norm_city','norm_state','norm_zip','norm_zip4','norm_phone','dartid','dateadded','dateupdated','website','state','lninscertrecordid','profilelastupdated','siid','sipstatuscode','wcbempnumber','ubinumber','cofanumber','usdotnumber','phone2','phone3','fax1','fax2','email1','email2','businesstype','nametitle','mailingaddress1','mailingaddress2','mailingaddresscity','mailingaddressstate','mailingaddresszip','mailingaddresszip4','contactfax','contactemail','policyholdernamefirst','policyholdernamemiddle','policyholdernamelast','policyholdernamesuffix','statepolicyfilenumber','coverageinjuryillnessdate','selfinsurancegroup','selfinsurancegroupphone','selfinsurancegroupid','numberofemployees','licensedcontractor','mconame','mconumber','mcoaddressline1','mcoaddressline2','mcocity','mcostate','mcozip','mcozip4','mcophone','governingclasscode','licensenumber','class','classificationdescription','licensestatus','licenseadditionalinfo','licenseissuedate','licenseexpirationdate','naicscode','officerexemptfirstname1','officerexemptlastname1','officerexemptmiddlename1','officerexempttitle1','officerexempteffectivedate1','officerexemptterminationdate1','officerexempttype1','officerexemptbusinessactivities1','officerexemptfirstname2','officerexemptlastname2','officerexemptmiddlename2','officerexempttitle2','officerexempteffectivedate2','officerexemptterminationdate2','officerexempttype2','officerexemptbusinessactivities2','officerexemptfirstname3','officerexemptlastname3','officerexemptmiddlename3','officerexempttitle3','officerexempteffectivedate3','officerexemptterminationdate3','officerexempttype3','officerexemptbusinessactivities3','officerexemptfirstname4','officerexemptlastname4','officerexemptmiddlename4','officerexempttitle4','officerexempteffectivedate4','officerexemptterminationdate4','officerexempttype4','officerexemptbusinessactivities4','officerexemptfirstname5','officerexemptlastname5','officerexemptmiddlename5','officerexempttitle5','officerexempteffectivedate5','officerexemptterminationdate5','officerexempttype5','officerexemptbusinessactivities5','dba1','dbadatefrom1','dbadateto1','dbatype1','dba2','dbadatefrom2','dbadateto2','dbatype2','dba3','dbadatefrom3','dbadateto3','dbatype3','dba4','dbadatefrom4','dbadateto4','dbatype4','dba5','dbadatefrom5','dbadateto5','dbatype5','subsidiaryname1','subsidiarystartdate1','subsidiaryname2','subsidiarystartdate2','subsidiaryname3','subsidiarystartdate3','subsidiaryname4','subsidiarystartdate4','subsidiaryname5','subsidiarystartdate5','subsidiaryname6','subsidiarystartdate6','subsidiaryname7','subsidiarystartdate7','subsidiaryname8','subsidiarystartdate8','subsidiaryname9','subsidiarystartdate9','subsidiaryname10','subsidiarystartdate10','append_mailaddress1','append_mailaddresslast','append_mailrawaid','append_mailaceaid');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'date_firstseen','date_lastseen','bdid','did','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','unique_id','norm_type','norm_businessname','norm_firstname','norm_middle','norm_last','norm_suffix','norm_address1','norm_address2','norm_city','norm_state','norm_zip','norm_zip4','norm_phone','dartid','dateadded','dateupdated','website','state','lninscertrecordid','profilelastupdated','siid','sipstatuscode','wcbempnumber','ubinumber','cofanumber','usdotnumber','phone2','phone3','fax1','fax2','email1','email2','businesstype','nametitle','mailingaddress1','mailingaddress2','mailingaddresscity','mailingaddressstate','mailingaddresszip','mailingaddresszip4','contactfax','contactemail','policyholdernamefirst','policyholdernamemiddle','policyholdernamelast','policyholdernamesuffix','statepolicyfilenumber','coverageinjuryillnessdate','selfinsurancegroup','selfinsurancegroupphone','selfinsurancegroupid','numberofemployees','licensedcontractor','mconame','mconumber','mcoaddressline1','mcoaddressline2','mcocity','mcostate','mcozip','mcozip4','mcophone','governingclasscode','licensenumber','class','classificationdescription','licensestatus','licenseadditionalinfo','licenseissuedate','licenseexpirationdate','naicscode','officerexemptfirstname1','officerexemptlastname1','officerexemptmiddlename1','officerexempttitle1','officerexempteffectivedate1','officerexemptterminationdate1','officerexempttype1','officerexemptbusinessactivities1','officerexemptfirstname2','officerexemptlastname2','officerexemptmiddlename2','officerexempttitle2','officerexempteffectivedate2','officerexemptterminationdate2','officerexempttype2','officerexemptbusinessactivities2','officerexemptfirstname3','officerexemptlastname3','officerexemptmiddlename3','officerexempttitle3','officerexempteffectivedate3','officerexemptterminationdate3','officerexempttype3','officerexemptbusinessactivities3','officerexemptfirstname4','officerexemptlastname4','officerexemptmiddlename4','officerexempttitle4','officerexempteffectivedate4','officerexemptterminationdate4','officerexempttype4','officerexemptbusinessactivities4','officerexemptfirstname5','officerexemptlastname5','officerexemptmiddlename5','officerexempttitle5','officerexempteffectivedate5','officerexemptterminationdate5','officerexempttype5','officerexemptbusinessactivities5','dba1','dbadatefrom1','dbadateto1','dbatype1','dba2','dbadatefrom2','dbadateto2','dbatype2','dba3','dbadatefrom3','dbadateto3','dbatype3','dba4','dbadatefrom4','dbadateto4','dbatype4','dba5','dbadatefrom5','dbadateto5','dbatype5','subsidiaryname1','subsidiarystartdate1','subsidiaryname2','subsidiarystartdate2','subsidiaryname3','subsidiarystartdate3','subsidiaryname4','subsidiarystartdate4','subsidiaryname5','subsidiarystartdate5','subsidiaryname6','subsidiarystartdate6','subsidiaryname7','subsidiarystartdate7','subsidiaryname8','subsidiarystartdate8','subsidiaryname9','subsidiarystartdate9','subsidiaryname10','subsidiarystartdate10','append_mailaddress1','append_mailaddresslast','append_mailrawaid','append_mailaceaid');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'date_firstseen' => 0,'date_lastseen' => 1,'bdid' => 2,'did' => 3,'dotid' => 4,'dotscore' => 5,'dotweight' => 6,'empid' => 7,'empscore' => 8,'empweight' => 9,'powid' => 10,'powscore' => 11,'powweight' => 12,'proxid' => 13,'proxscore' => 14,'proxweight' => 15,'seleid' => 16,'selescore' => 17,'seleweight' => 18,'orgid' => 19,'orgscore' => 20,'orgweight' => 21,'ultid' => 22,'ultscore' => 23,'ultweight' => 24,'unique_id' => 25,'norm_type' => 26,'norm_businessname' => 27,'norm_firstname' => 28,'norm_middle' => 29,'norm_last' => 30,'norm_suffix' => 31,'norm_address1' => 32,'norm_address2' => 33,'norm_city' => 34,'norm_state' => 35,'norm_zip' => 36,'norm_zip4' => 37,'norm_phone' => 38,'dartid' => 39,'dateadded' => 40,'dateupdated' => 41,'website' => 42,'state' => 43,'lninscertrecordid' => 44,'profilelastupdated' => 45,'siid' => 46,'sipstatuscode' => 47,'wcbempnumber' => 48,'ubinumber' => 49,'cofanumber' => 50,'usdotnumber' => 51,'phone2' => 52,'phone3' => 53,'fax1' => 54,'fax2' => 55,'email1' => 56,'email2' => 57,'businesstype' => 58,'nametitle' => 59,'mailingaddress1' => 60,'mailingaddress2' => 61,'mailingaddresscity' => 62,'mailingaddressstate' => 63,'mailingaddresszip' => 64,'mailingaddresszip4' => 65,'contactfax' => 66,'contactemail' => 67,'policyholdernamefirst' => 68,'policyholdernamemiddle' => 69,'policyholdernamelast' => 70,'policyholdernamesuffix' => 71,'statepolicyfilenumber' => 72,'coverageinjuryillnessdate' => 73,'selfinsurancegroup' => 74,'selfinsurancegroupphone' => 75,'selfinsurancegroupid' => 76,'numberofemployees' => 77,'licensedcontractor' => 78,'mconame' => 79,'mconumber' => 80,'mcoaddressline1' => 81,'mcoaddressline2' => 82,'mcocity' => 83,'mcostate' => 84,'mcozip' => 85,'mcozip4' => 86,'mcophone' => 87,'governingclasscode' => 88,'licensenumber' => 89,'class' => 90,'classificationdescription' => 91,'licensestatus' => 92,'licenseadditionalinfo' => 93,'licenseissuedate' => 94,'licenseexpirationdate' => 95,'naicscode' => 96,'officerexemptfirstname1' => 97,'officerexemptlastname1' => 98,'officerexemptmiddlename1' => 99,'officerexempttitle1' => 100,'officerexempteffectivedate1' => 101,'officerexemptterminationdate1' => 102,'officerexempttype1' => 103,'officerexemptbusinessactivities1' => 104,'officerexemptfirstname2' => 105,'officerexemptlastname2' => 106,'officerexemptmiddlename2' => 107,'officerexempttitle2' => 108,'officerexempteffectivedate2' => 109,'officerexemptterminationdate2' => 110,'officerexempttype2' => 111,'officerexemptbusinessactivities2' => 112,'officerexemptfirstname3' => 113,'officerexemptlastname3' => 114,'officerexemptmiddlename3' => 115,'officerexempttitle3' => 116,'officerexempteffectivedate3' => 117,'officerexemptterminationdate3' => 118,'officerexempttype3' => 119,'officerexemptbusinessactivities3' => 120,'officerexemptfirstname4' => 121,'officerexemptlastname4' => 122,'officerexemptmiddlename4' => 123,'officerexempttitle4' => 124,'officerexempteffectivedate4' => 125,'officerexemptterminationdate4' => 126,'officerexempttype4' => 127,'officerexemptbusinessactivities4' => 128,'officerexemptfirstname5' => 129,'officerexemptlastname5' => 130,'officerexemptmiddlename5' => 131,'officerexempttitle5' => 132,'officerexempteffectivedate5' => 133,'officerexemptterminationdate5' => 134,'officerexempttype5' => 135,'officerexemptbusinessactivities5' => 136,'dba1' => 137,'dbadatefrom1' => 138,'dbadateto1' => 139,'dbatype1' => 140,'dba2' => 141,'dbadatefrom2' => 142,'dbadateto2' => 143,'dbatype2' => 144,'dba3' => 145,'dbadatefrom3' => 146,'dbadateto3' => 147,'dbatype3' => 148,'dba4' => 149,'dbadatefrom4' => 150,'dbadateto4' => 151,'dbatype4' => 152,'dba5' => 153,'dbadatefrom5' => 154,'dbadateto5' => 155,'dbatype5' => 156,'subsidiaryname1' => 157,'subsidiarystartdate1' => 158,'subsidiaryname2' => 159,'subsidiarystartdate2' => 160,'subsidiaryname3' => 161,'subsidiarystartdate3' => 162,'subsidiaryname4' => 163,'subsidiarystartdate4' => 164,'subsidiaryname5' => 165,'subsidiarystartdate5' => 166,'subsidiaryname6' => 167,'subsidiarystartdate6' => 168,'subsidiaryname7' => 169,'subsidiarystartdate7' => 170,'subsidiaryname8' => 171,'subsidiarystartdate8' => 172,'subsidiaryname9' => 173,'subsidiarystartdate9' => 174,'subsidiaryname10' => 175,'subsidiarystartdate10' => 176,'append_mailaddress1' => 177,'append_mailaddresslast' => 178,'append_mailrawaid' => 179,'append_mailaceaid' => 180,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['LENGTHS'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW','LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW','LENGTHS'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW','LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
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
 
EXPORT Make_did(SALT311.StrType s0) := s0;
EXPORT InValid_did(SALT311.StrType s) := 0;
EXPORT InValidMessage_did(UNSIGNED1 wh) := '';
 
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
 
EXPORT Make_unique_id(SALT311.StrType s0) := s0;
EXPORT InValid_unique_id(SALT311.StrType s) := 0;
EXPORT InValidMessage_unique_id(UNSIGNED1 wh) := '';
 
EXPORT Make_norm_type(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_norm_type(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_norm_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_norm_businessname(SALT311.StrType s0) := s0;
EXPORT InValid_norm_businessname(SALT311.StrType s) := 0;
EXPORT InValidMessage_norm_businessname(UNSIGNED1 wh) := '';
 
EXPORT Make_norm_firstname(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_norm_firstname(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_norm_firstname(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_norm_middle(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_norm_middle(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_norm_middle(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_norm_last(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_norm_last(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_norm_last(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_norm_suffix(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_norm_suffix(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_norm_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_norm_address1(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_norm_address1(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_norm_address1(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_norm_address2(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_norm_address2(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_norm_address2(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_norm_city(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_norm_city(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_norm_city(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_norm_state(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_norm_state(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_norm_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_norm_zip(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_norm_zip(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_norm_zip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_norm_zip4(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_norm_zip4(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_norm_zip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_norm_phone(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_norm_phone(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_norm_phone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_dartid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_dartid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_dartid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_dateadded(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dateadded(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dateadded(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dateupdated(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dateupdated(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dateupdated(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_website(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_website(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_website(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_lninscertrecordid(SALT311.StrType s0) := s0;
EXPORT InValid_lninscertrecordid(SALT311.StrType s) := 0;
EXPORT InValidMessage_lninscertrecordid(UNSIGNED1 wh) := '';
 
EXPORT Make_profilelastupdated(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_profilelastupdated(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_profilelastupdated(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_siid(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_siid(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_siid(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_sipstatuscode(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_sipstatuscode(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_sipstatuscode(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_wcbempnumber(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_wcbempnumber(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_wcbempnumber(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_ubinumber(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_ubinumber(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_ubinumber(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_cofanumber(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_cofanumber(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_cofanumber(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_usdotnumber(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_usdotnumber(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_usdotnumber(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_phone2(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_phone2(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_phone2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_phone3(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_phone3(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_phone3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_fax1(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_fax1(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_fax1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_fax2(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_fax2(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_fax2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_email1(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_email1(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_email1(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_email2(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_email2(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_email2(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_businesstype(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_businesstype(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_businesstype(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_nametitle(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_nametitle(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_nametitle(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mailingaddress1(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_mailingaddress1(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_mailingaddress1(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_mailingaddress2(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_mailingaddress2(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_mailingaddress2(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_mailingaddresscity(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_mailingaddresscity(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_mailingaddresscity(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mailingaddressstate(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_mailingaddressstate(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_mailingaddressstate(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_mailingaddresszip(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_mailingaddresszip(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_mailingaddresszip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_mailingaddresszip4(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_mailingaddresszip4(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_mailingaddresszip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_contactfax(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_contactfax(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_contactfax(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_contactemail(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_contactemail(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_contactemail(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_policyholdernamefirst(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_policyholdernamefirst(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_policyholdernamefirst(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_policyholdernamemiddle(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_policyholdernamemiddle(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_policyholdernamemiddle(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_policyholdernamelast(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_policyholdernamelast(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_policyholdernamelast(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_policyholdernamesuffix(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_policyholdernamesuffix(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_policyholdernamesuffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_statepolicyfilenumber(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_statepolicyfilenumber(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_statepolicyfilenumber(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_coverageinjuryillnessdate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_coverageinjuryillnessdate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_coverageinjuryillnessdate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_selfinsurancegroup(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_selfinsurancegroup(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_selfinsurancegroup(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_selfinsurancegroupphone(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_selfinsurancegroupphone(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_selfinsurancegroupphone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_selfinsurancegroupid(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_selfinsurancegroupid(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_selfinsurancegroupid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_numberofemployees(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_numberofemployees(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_numberofemployees(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_licensedcontractor(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_licensedcontractor(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_licensedcontractor(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mconame(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_mconame(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_mconame(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mconumber(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_mconumber(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_mconumber(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_mcoaddressline1(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_mcoaddressline1(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_mcoaddressline1(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_mcoaddressline2(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_mcoaddressline2(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_mcoaddressline2(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_mcocity(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_mcocity(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_mcocity(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mcostate(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_mcostate(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_mcostate(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_mcozip(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_mcozip(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_mcozip(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_mcozip4(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_mcozip4(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_mcozip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_mcophone(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_mcophone(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_mcophone(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_governingclasscode(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_governingclasscode(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_governingclasscode(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_licensenumber(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_licensenumber(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_licensenumber(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_class(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_class(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_class(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_classificationdescription(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_classificationdescription(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_classificationdescription(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_licensestatus(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_licensestatus(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_licensestatus(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_licenseadditionalinfo(SALT311.StrType s0) := s0;
EXPORT InValid_licenseadditionalinfo(SALT311.StrType s) := 0;
EXPORT InValidMessage_licenseadditionalinfo(UNSIGNED1 wh) := '';
 
EXPORT Make_licenseissuedate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_licenseissuedate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_licenseissuedate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_licenseexpirationdate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_licenseexpirationdate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_licenseexpirationdate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_naicscode(SALT311.StrType s0) := MakeFT_Invalid_NAICS(s0);
EXPORT InValid_naicscode(SALT311.StrType s) := InValidFT_Invalid_NAICS(s);
EXPORT InValidMessage_naicscode(UNSIGNED1 wh) := InValidMessageFT_Invalid_NAICS(wh);
 
EXPORT Make_officerexemptfirstname1(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexemptfirstname1(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexemptfirstname1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexemptlastname1(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexemptlastname1(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexemptlastname1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexemptmiddlename1(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexemptmiddlename1(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexemptmiddlename1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexempttitle1(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexempttitle1(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexempttitle1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexempteffectivedate1(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_officerexempteffectivedate1(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_officerexempteffectivedate1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_officerexemptterminationdate1(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_officerexemptterminationdate1(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_officerexemptterminationdate1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_officerexempttype1(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexempttype1(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexempttype1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexemptbusinessactivities1(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexemptbusinessactivities1(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexemptbusinessactivities1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexemptfirstname2(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexemptfirstname2(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexemptfirstname2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexemptlastname2(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexemptlastname2(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexemptlastname2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexemptmiddlename2(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexemptmiddlename2(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexemptmiddlename2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexempttitle2(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexempttitle2(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexempttitle2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexempteffectivedate2(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_officerexempteffectivedate2(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_officerexempteffectivedate2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_officerexemptterminationdate2(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_officerexemptterminationdate2(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_officerexemptterminationdate2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_officerexempttype2(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexempttype2(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexempttype2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexemptbusinessactivities2(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexemptbusinessactivities2(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexemptbusinessactivities2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexemptfirstname3(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexemptfirstname3(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexemptfirstname3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexemptlastname3(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexemptlastname3(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexemptlastname3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexemptmiddlename3(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexemptmiddlename3(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexemptmiddlename3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexempttitle3(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexempttitle3(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexempttitle3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexempteffectivedate3(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_officerexempteffectivedate3(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_officerexempteffectivedate3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_officerexemptterminationdate3(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_officerexemptterminationdate3(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_officerexemptterminationdate3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_officerexempttype3(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexempttype3(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexempttype3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexemptbusinessactivities3(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexemptbusinessactivities3(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexemptbusinessactivities3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexemptfirstname4(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexemptfirstname4(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexemptfirstname4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexemptlastname4(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexemptlastname4(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexemptlastname4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexemptmiddlename4(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexemptmiddlename4(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexemptmiddlename4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexempttitle4(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexempttitle4(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexempttitle4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexempteffectivedate4(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_officerexempteffectivedate4(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_officerexempteffectivedate4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_officerexemptterminationdate4(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_officerexemptterminationdate4(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_officerexemptterminationdate4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_officerexempttype4(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexempttype4(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexempttype4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexemptbusinessactivities4(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexemptbusinessactivities4(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexemptbusinessactivities4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexemptfirstname5(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexemptfirstname5(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexemptfirstname5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexemptlastname5(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexemptlastname5(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexemptlastname5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexemptmiddlename5(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexemptmiddlename5(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexemptmiddlename5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexempttitle5(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexempttitle5(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexempttitle5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexempteffectivedate5(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_officerexempteffectivedate5(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_officerexempteffectivedate5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_officerexemptterminationdate5(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_officerexemptterminationdate5(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_officerexemptterminationdate5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_officerexempttype5(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexempttype5(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexempttype5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_officerexemptbusinessactivities5(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_officerexemptbusinessactivities5(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_officerexemptbusinessactivities5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_dba1(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_dba1(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_dba1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_dbadatefrom1(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dbadatefrom1(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dbadatefrom1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dbadateto1(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dbadateto1(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dbadateto1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dbatype1(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_dbatype1(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_dbatype1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_dba2(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_dba2(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_dba2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_dbadatefrom2(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dbadatefrom2(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dbadatefrom2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dbadateto2(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dbadateto2(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dbadateto2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dbatype2(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_dbatype2(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_dbatype2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_dba3(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_dba3(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_dba3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_dbadatefrom3(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dbadatefrom3(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dbadatefrom3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dbadateto3(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dbadateto3(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dbadateto3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dbatype3(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_dbatype3(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_dbatype3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_dba4(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_dba4(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_dba4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_dbadatefrom4(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dbadatefrom4(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dbadatefrom4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dbadateto4(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dbadateto4(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dbadateto4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dbatype4(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_dbatype4(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_dbatype4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_dba5(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_dba5(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_dba5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_dbadatefrom5(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dbadatefrom5(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dbadatefrom5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dbadateto5(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dbadateto5(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dbadateto5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dbatype5(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_dbatype5(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_dbatype5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_subsidiaryname1(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_subsidiaryname1(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_subsidiaryname1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_subsidiarystartdate1(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_subsidiarystartdate1(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_subsidiarystartdate1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_subsidiaryname2(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_subsidiaryname2(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_subsidiaryname2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_subsidiarystartdate2(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_subsidiarystartdate2(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_subsidiarystartdate2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_subsidiaryname3(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_subsidiaryname3(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_subsidiaryname3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_subsidiarystartdate3(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_subsidiarystartdate3(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_subsidiarystartdate3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_subsidiaryname4(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_subsidiaryname4(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_subsidiaryname4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_subsidiarystartdate4(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_subsidiarystartdate4(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_subsidiarystartdate4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_subsidiaryname5(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_subsidiaryname5(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_subsidiaryname5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_subsidiarystartdate5(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_subsidiarystartdate5(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_subsidiarystartdate5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_subsidiaryname6(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_subsidiaryname6(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_subsidiaryname6(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_subsidiarystartdate6(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_subsidiarystartdate6(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_subsidiarystartdate6(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_subsidiaryname7(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_subsidiaryname7(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_subsidiaryname7(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_subsidiarystartdate7(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_subsidiarystartdate7(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_subsidiarystartdate7(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_subsidiaryname8(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_subsidiaryname8(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_subsidiaryname8(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_subsidiarystartdate8(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_subsidiarystartdate8(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_subsidiarystartdate8(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_subsidiaryname9(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_subsidiaryname9(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_subsidiaryname9(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_subsidiarystartdate9(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_subsidiarystartdate9(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_subsidiarystartdate9(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_subsidiaryname10(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_subsidiaryname10(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_subsidiaryname10(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_subsidiarystartdate10(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_subsidiarystartdate10(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_subsidiarystartdate10(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
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
    BOOLEAN Diff_did;
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
    BOOLEAN Diff_unique_id;
    BOOLEAN Diff_norm_type;
    BOOLEAN Diff_norm_businessname;
    BOOLEAN Diff_norm_firstname;
    BOOLEAN Diff_norm_middle;
    BOOLEAN Diff_norm_last;
    BOOLEAN Diff_norm_suffix;
    BOOLEAN Diff_norm_address1;
    BOOLEAN Diff_norm_address2;
    BOOLEAN Diff_norm_city;
    BOOLEAN Diff_norm_state;
    BOOLEAN Diff_norm_zip;
    BOOLEAN Diff_norm_zip4;
    BOOLEAN Diff_norm_phone;
    BOOLEAN Diff_dartid;
    BOOLEAN Diff_dateadded;
    BOOLEAN Diff_dateupdated;
    BOOLEAN Diff_website;
    BOOLEAN Diff_state;
    BOOLEAN Diff_lninscertrecordid;
    BOOLEAN Diff_profilelastupdated;
    BOOLEAN Diff_siid;
    BOOLEAN Diff_sipstatuscode;
    BOOLEAN Diff_wcbempnumber;
    BOOLEAN Diff_ubinumber;
    BOOLEAN Diff_cofanumber;
    BOOLEAN Diff_usdotnumber;
    BOOLEAN Diff_phone2;
    BOOLEAN Diff_phone3;
    BOOLEAN Diff_fax1;
    BOOLEAN Diff_fax2;
    BOOLEAN Diff_email1;
    BOOLEAN Diff_email2;
    BOOLEAN Diff_businesstype;
    BOOLEAN Diff_nametitle;
    BOOLEAN Diff_mailingaddress1;
    BOOLEAN Diff_mailingaddress2;
    BOOLEAN Diff_mailingaddresscity;
    BOOLEAN Diff_mailingaddressstate;
    BOOLEAN Diff_mailingaddresszip;
    BOOLEAN Diff_mailingaddresszip4;
    BOOLEAN Diff_contactfax;
    BOOLEAN Diff_contactemail;
    BOOLEAN Diff_policyholdernamefirst;
    BOOLEAN Diff_policyholdernamemiddle;
    BOOLEAN Diff_policyholdernamelast;
    BOOLEAN Diff_policyholdernamesuffix;
    BOOLEAN Diff_statepolicyfilenumber;
    BOOLEAN Diff_coverageinjuryillnessdate;
    BOOLEAN Diff_selfinsurancegroup;
    BOOLEAN Diff_selfinsurancegroupphone;
    BOOLEAN Diff_selfinsurancegroupid;
    BOOLEAN Diff_numberofemployees;
    BOOLEAN Diff_licensedcontractor;
    BOOLEAN Diff_mconame;
    BOOLEAN Diff_mconumber;
    BOOLEAN Diff_mcoaddressline1;
    BOOLEAN Diff_mcoaddressline2;
    BOOLEAN Diff_mcocity;
    BOOLEAN Diff_mcostate;
    BOOLEAN Diff_mcozip;
    BOOLEAN Diff_mcozip4;
    BOOLEAN Diff_mcophone;
    BOOLEAN Diff_governingclasscode;
    BOOLEAN Diff_licensenumber;
    BOOLEAN Diff_class;
    BOOLEAN Diff_classificationdescription;
    BOOLEAN Diff_licensestatus;
    BOOLEAN Diff_licenseadditionalinfo;
    BOOLEAN Diff_licenseissuedate;
    BOOLEAN Diff_licenseexpirationdate;
    BOOLEAN Diff_naicscode;
    BOOLEAN Diff_officerexemptfirstname1;
    BOOLEAN Diff_officerexemptlastname1;
    BOOLEAN Diff_officerexemptmiddlename1;
    BOOLEAN Diff_officerexempttitle1;
    BOOLEAN Diff_officerexempteffectivedate1;
    BOOLEAN Diff_officerexemptterminationdate1;
    BOOLEAN Diff_officerexempttype1;
    BOOLEAN Diff_officerexemptbusinessactivities1;
    BOOLEAN Diff_officerexemptfirstname2;
    BOOLEAN Diff_officerexemptlastname2;
    BOOLEAN Diff_officerexemptmiddlename2;
    BOOLEAN Diff_officerexempttitle2;
    BOOLEAN Diff_officerexempteffectivedate2;
    BOOLEAN Diff_officerexemptterminationdate2;
    BOOLEAN Diff_officerexempttype2;
    BOOLEAN Diff_officerexemptbusinessactivities2;
    BOOLEAN Diff_officerexemptfirstname3;
    BOOLEAN Diff_officerexemptlastname3;
    BOOLEAN Diff_officerexemptmiddlename3;
    BOOLEAN Diff_officerexempttitle3;
    BOOLEAN Diff_officerexempteffectivedate3;
    BOOLEAN Diff_officerexemptterminationdate3;
    BOOLEAN Diff_officerexempttype3;
    BOOLEAN Diff_officerexemptbusinessactivities3;
    BOOLEAN Diff_officerexemptfirstname4;
    BOOLEAN Diff_officerexemptlastname4;
    BOOLEAN Diff_officerexemptmiddlename4;
    BOOLEAN Diff_officerexempttitle4;
    BOOLEAN Diff_officerexempteffectivedate4;
    BOOLEAN Diff_officerexemptterminationdate4;
    BOOLEAN Diff_officerexempttype4;
    BOOLEAN Diff_officerexemptbusinessactivities4;
    BOOLEAN Diff_officerexemptfirstname5;
    BOOLEAN Diff_officerexemptlastname5;
    BOOLEAN Diff_officerexemptmiddlename5;
    BOOLEAN Diff_officerexempttitle5;
    BOOLEAN Diff_officerexempteffectivedate5;
    BOOLEAN Diff_officerexemptterminationdate5;
    BOOLEAN Diff_officerexempttype5;
    BOOLEAN Diff_officerexemptbusinessactivities5;
    BOOLEAN Diff_dba1;
    BOOLEAN Diff_dbadatefrom1;
    BOOLEAN Diff_dbadateto1;
    BOOLEAN Diff_dbatype1;
    BOOLEAN Diff_dba2;
    BOOLEAN Diff_dbadatefrom2;
    BOOLEAN Diff_dbadateto2;
    BOOLEAN Diff_dbatype2;
    BOOLEAN Diff_dba3;
    BOOLEAN Diff_dbadatefrom3;
    BOOLEAN Diff_dbadateto3;
    BOOLEAN Diff_dbatype3;
    BOOLEAN Diff_dba4;
    BOOLEAN Diff_dbadatefrom4;
    BOOLEAN Diff_dbadateto4;
    BOOLEAN Diff_dbatype4;
    BOOLEAN Diff_dba5;
    BOOLEAN Diff_dbadatefrom5;
    BOOLEAN Diff_dbadateto5;
    BOOLEAN Diff_dbatype5;
    BOOLEAN Diff_subsidiaryname1;
    BOOLEAN Diff_subsidiarystartdate1;
    BOOLEAN Diff_subsidiaryname2;
    BOOLEAN Diff_subsidiarystartdate2;
    BOOLEAN Diff_subsidiaryname3;
    BOOLEAN Diff_subsidiarystartdate3;
    BOOLEAN Diff_subsidiaryname4;
    BOOLEAN Diff_subsidiarystartdate4;
    BOOLEAN Diff_subsidiaryname5;
    BOOLEAN Diff_subsidiarystartdate5;
    BOOLEAN Diff_subsidiaryname6;
    BOOLEAN Diff_subsidiarystartdate6;
    BOOLEAN Diff_subsidiaryname7;
    BOOLEAN Diff_subsidiarystartdate7;
    BOOLEAN Diff_subsidiaryname8;
    BOOLEAN Diff_subsidiarystartdate8;
    BOOLEAN Diff_subsidiaryname9;
    BOOLEAN Diff_subsidiarystartdate9;
    BOOLEAN Diff_subsidiaryname10;
    BOOLEAN Diff_subsidiarystartdate10;
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
    SELF.Diff_did := le.did <> ri.did;
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
    SELF.Diff_unique_id := le.unique_id <> ri.unique_id;
    SELF.Diff_norm_type := le.norm_type <> ri.norm_type;
    SELF.Diff_norm_businessname := le.norm_businessname <> ri.norm_businessname;
    SELF.Diff_norm_firstname := le.norm_firstname <> ri.norm_firstname;
    SELF.Diff_norm_middle := le.norm_middle <> ri.norm_middle;
    SELF.Diff_norm_last := le.norm_last <> ri.norm_last;
    SELF.Diff_norm_suffix := le.norm_suffix <> ri.norm_suffix;
    SELF.Diff_norm_address1 := le.norm_address1 <> ri.norm_address1;
    SELF.Diff_norm_address2 := le.norm_address2 <> ri.norm_address2;
    SELF.Diff_norm_city := le.norm_city <> ri.norm_city;
    SELF.Diff_norm_state := le.norm_state <> ri.norm_state;
    SELF.Diff_norm_zip := le.norm_zip <> ri.norm_zip;
    SELF.Diff_norm_zip4 := le.norm_zip4 <> ri.norm_zip4;
    SELF.Diff_norm_phone := le.norm_phone <> ri.norm_phone;
    SELF.Diff_dartid := le.dartid <> ri.dartid;
    SELF.Diff_dateadded := le.dateadded <> ri.dateadded;
    SELF.Diff_dateupdated := le.dateupdated <> ri.dateupdated;
    SELF.Diff_website := le.website <> ri.website;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_lninscertrecordid := le.lninscertrecordid <> ri.lninscertrecordid;
    SELF.Diff_profilelastupdated := le.profilelastupdated <> ri.profilelastupdated;
    SELF.Diff_siid := le.siid <> ri.siid;
    SELF.Diff_sipstatuscode := le.sipstatuscode <> ri.sipstatuscode;
    SELF.Diff_wcbempnumber := le.wcbempnumber <> ri.wcbempnumber;
    SELF.Diff_ubinumber := le.ubinumber <> ri.ubinumber;
    SELF.Diff_cofanumber := le.cofanumber <> ri.cofanumber;
    SELF.Diff_usdotnumber := le.usdotnumber <> ri.usdotnumber;
    SELF.Diff_phone2 := le.phone2 <> ri.phone2;
    SELF.Diff_phone3 := le.phone3 <> ri.phone3;
    SELF.Diff_fax1 := le.fax1 <> ri.fax1;
    SELF.Diff_fax2 := le.fax2 <> ri.fax2;
    SELF.Diff_email1 := le.email1 <> ri.email1;
    SELF.Diff_email2 := le.email2 <> ri.email2;
    SELF.Diff_businesstype := le.businesstype <> ri.businesstype;
    SELF.Diff_nametitle := le.nametitle <> ri.nametitle;
    SELF.Diff_mailingaddress1 := le.mailingaddress1 <> ri.mailingaddress1;
    SELF.Diff_mailingaddress2 := le.mailingaddress2 <> ri.mailingaddress2;
    SELF.Diff_mailingaddresscity := le.mailingaddresscity <> ri.mailingaddresscity;
    SELF.Diff_mailingaddressstate := le.mailingaddressstate <> ri.mailingaddressstate;
    SELF.Diff_mailingaddresszip := le.mailingaddresszip <> ri.mailingaddresszip;
    SELF.Diff_mailingaddresszip4 := le.mailingaddresszip4 <> ri.mailingaddresszip4;
    SELF.Diff_contactfax := le.contactfax <> ri.contactfax;
    SELF.Diff_contactemail := le.contactemail <> ri.contactemail;
    SELF.Diff_policyholdernamefirst := le.policyholdernamefirst <> ri.policyholdernamefirst;
    SELF.Diff_policyholdernamemiddle := le.policyholdernamemiddle <> ri.policyholdernamemiddle;
    SELF.Diff_policyholdernamelast := le.policyholdernamelast <> ri.policyholdernamelast;
    SELF.Diff_policyholdernamesuffix := le.policyholdernamesuffix <> ri.policyholdernamesuffix;
    SELF.Diff_statepolicyfilenumber := le.statepolicyfilenumber <> ri.statepolicyfilenumber;
    SELF.Diff_coverageinjuryillnessdate := le.coverageinjuryillnessdate <> ri.coverageinjuryillnessdate;
    SELF.Diff_selfinsurancegroup := le.selfinsurancegroup <> ri.selfinsurancegroup;
    SELF.Diff_selfinsurancegroupphone := le.selfinsurancegroupphone <> ri.selfinsurancegroupphone;
    SELF.Diff_selfinsurancegroupid := le.selfinsurancegroupid <> ri.selfinsurancegroupid;
    SELF.Diff_numberofemployees := le.numberofemployees <> ri.numberofemployees;
    SELF.Diff_licensedcontractor := le.licensedcontractor <> ri.licensedcontractor;
    SELF.Diff_mconame := le.mconame <> ri.mconame;
    SELF.Diff_mconumber := le.mconumber <> ri.mconumber;
    SELF.Diff_mcoaddressline1 := le.mcoaddressline1 <> ri.mcoaddressline1;
    SELF.Diff_mcoaddressline2 := le.mcoaddressline2 <> ri.mcoaddressline2;
    SELF.Diff_mcocity := le.mcocity <> ri.mcocity;
    SELF.Diff_mcostate := le.mcostate <> ri.mcostate;
    SELF.Diff_mcozip := le.mcozip <> ri.mcozip;
    SELF.Diff_mcozip4 := le.mcozip4 <> ri.mcozip4;
    SELF.Diff_mcophone := le.mcophone <> ri.mcophone;
    SELF.Diff_governingclasscode := le.governingclasscode <> ri.governingclasscode;
    SELF.Diff_licensenumber := le.licensenumber <> ri.licensenumber;
    SELF.Diff_class := le.class <> ri.class;
    SELF.Diff_classificationdescription := le.classificationdescription <> ri.classificationdescription;
    SELF.Diff_licensestatus := le.licensestatus <> ri.licensestatus;
    SELF.Diff_licenseadditionalinfo := le.licenseadditionalinfo <> ri.licenseadditionalinfo;
    SELF.Diff_licenseissuedate := le.licenseissuedate <> ri.licenseissuedate;
    SELF.Diff_licenseexpirationdate := le.licenseexpirationdate <> ri.licenseexpirationdate;
    SELF.Diff_naicscode := le.naicscode <> ri.naicscode;
    SELF.Diff_officerexemptfirstname1 := le.officerexemptfirstname1 <> ri.officerexemptfirstname1;
    SELF.Diff_officerexemptlastname1 := le.officerexemptlastname1 <> ri.officerexemptlastname1;
    SELF.Diff_officerexemptmiddlename1 := le.officerexemptmiddlename1 <> ri.officerexemptmiddlename1;
    SELF.Diff_officerexempttitle1 := le.officerexempttitle1 <> ri.officerexempttitle1;
    SELF.Diff_officerexempteffectivedate1 := le.officerexempteffectivedate1 <> ri.officerexempteffectivedate1;
    SELF.Diff_officerexemptterminationdate1 := le.officerexemptterminationdate1 <> ri.officerexemptterminationdate1;
    SELF.Diff_officerexempttype1 := le.officerexempttype1 <> ri.officerexempttype1;
    SELF.Diff_officerexemptbusinessactivities1 := le.officerexemptbusinessactivities1 <> ri.officerexemptbusinessactivities1;
    SELF.Diff_officerexemptfirstname2 := le.officerexemptfirstname2 <> ri.officerexemptfirstname2;
    SELF.Diff_officerexemptlastname2 := le.officerexemptlastname2 <> ri.officerexemptlastname2;
    SELF.Diff_officerexemptmiddlename2 := le.officerexemptmiddlename2 <> ri.officerexemptmiddlename2;
    SELF.Diff_officerexempttitle2 := le.officerexempttitle2 <> ri.officerexempttitle2;
    SELF.Diff_officerexempteffectivedate2 := le.officerexempteffectivedate2 <> ri.officerexempteffectivedate2;
    SELF.Diff_officerexemptterminationdate2 := le.officerexemptterminationdate2 <> ri.officerexemptterminationdate2;
    SELF.Diff_officerexempttype2 := le.officerexempttype2 <> ri.officerexempttype2;
    SELF.Diff_officerexemptbusinessactivities2 := le.officerexemptbusinessactivities2 <> ri.officerexemptbusinessactivities2;
    SELF.Diff_officerexemptfirstname3 := le.officerexemptfirstname3 <> ri.officerexemptfirstname3;
    SELF.Diff_officerexemptlastname3 := le.officerexemptlastname3 <> ri.officerexemptlastname3;
    SELF.Diff_officerexemptmiddlename3 := le.officerexemptmiddlename3 <> ri.officerexemptmiddlename3;
    SELF.Diff_officerexempttitle3 := le.officerexempttitle3 <> ri.officerexempttitle3;
    SELF.Diff_officerexempteffectivedate3 := le.officerexempteffectivedate3 <> ri.officerexempteffectivedate3;
    SELF.Diff_officerexemptterminationdate3 := le.officerexemptterminationdate3 <> ri.officerexemptterminationdate3;
    SELF.Diff_officerexempttype3 := le.officerexempttype3 <> ri.officerexempttype3;
    SELF.Diff_officerexemptbusinessactivities3 := le.officerexemptbusinessactivities3 <> ri.officerexemptbusinessactivities3;
    SELF.Diff_officerexemptfirstname4 := le.officerexemptfirstname4 <> ri.officerexemptfirstname4;
    SELF.Diff_officerexemptlastname4 := le.officerexemptlastname4 <> ri.officerexemptlastname4;
    SELF.Diff_officerexemptmiddlename4 := le.officerexemptmiddlename4 <> ri.officerexemptmiddlename4;
    SELF.Diff_officerexempttitle4 := le.officerexempttitle4 <> ri.officerexempttitle4;
    SELF.Diff_officerexempteffectivedate4 := le.officerexempteffectivedate4 <> ri.officerexempteffectivedate4;
    SELF.Diff_officerexemptterminationdate4 := le.officerexemptterminationdate4 <> ri.officerexemptterminationdate4;
    SELF.Diff_officerexempttype4 := le.officerexempttype4 <> ri.officerexempttype4;
    SELF.Diff_officerexemptbusinessactivities4 := le.officerexemptbusinessactivities4 <> ri.officerexemptbusinessactivities4;
    SELF.Diff_officerexemptfirstname5 := le.officerexemptfirstname5 <> ri.officerexemptfirstname5;
    SELF.Diff_officerexemptlastname5 := le.officerexemptlastname5 <> ri.officerexemptlastname5;
    SELF.Diff_officerexemptmiddlename5 := le.officerexemptmiddlename5 <> ri.officerexemptmiddlename5;
    SELF.Diff_officerexempttitle5 := le.officerexempttitle5 <> ri.officerexempttitle5;
    SELF.Diff_officerexempteffectivedate5 := le.officerexempteffectivedate5 <> ri.officerexempteffectivedate5;
    SELF.Diff_officerexemptterminationdate5 := le.officerexemptterminationdate5 <> ri.officerexemptterminationdate5;
    SELF.Diff_officerexempttype5 := le.officerexempttype5 <> ri.officerexempttype5;
    SELF.Diff_officerexemptbusinessactivities5 := le.officerexemptbusinessactivities5 <> ri.officerexemptbusinessactivities5;
    SELF.Diff_dba1 := le.dba1 <> ri.dba1;
    SELF.Diff_dbadatefrom1 := le.dbadatefrom1 <> ri.dbadatefrom1;
    SELF.Diff_dbadateto1 := le.dbadateto1 <> ri.dbadateto1;
    SELF.Diff_dbatype1 := le.dbatype1 <> ri.dbatype1;
    SELF.Diff_dba2 := le.dba2 <> ri.dba2;
    SELF.Diff_dbadatefrom2 := le.dbadatefrom2 <> ri.dbadatefrom2;
    SELF.Diff_dbadateto2 := le.dbadateto2 <> ri.dbadateto2;
    SELF.Diff_dbatype2 := le.dbatype2 <> ri.dbatype2;
    SELF.Diff_dba3 := le.dba3 <> ri.dba3;
    SELF.Diff_dbadatefrom3 := le.dbadatefrom3 <> ri.dbadatefrom3;
    SELF.Diff_dbadateto3 := le.dbadateto3 <> ri.dbadateto3;
    SELF.Diff_dbatype3 := le.dbatype3 <> ri.dbatype3;
    SELF.Diff_dba4 := le.dba4 <> ri.dba4;
    SELF.Diff_dbadatefrom4 := le.dbadatefrom4 <> ri.dbadatefrom4;
    SELF.Diff_dbadateto4 := le.dbadateto4 <> ri.dbadateto4;
    SELF.Diff_dbatype4 := le.dbatype4 <> ri.dbatype4;
    SELF.Diff_dba5 := le.dba5 <> ri.dba5;
    SELF.Diff_dbadatefrom5 := le.dbadatefrom5 <> ri.dbadatefrom5;
    SELF.Diff_dbadateto5 := le.dbadateto5 <> ri.dbadateto5;
    SELF.Diff_dbatype5 := le.dbatype5 <> ri.dbatype5;
    SELF.Diff_subsidiaryname1 := le.subsidiaryname1 <> ri.subsidiaryname1;
    SELF.Diff_subsidiarystartdate1 := le.subsidiarystartdate1 <> ri.subsidiarystartdate1;
    SELF.Diff_subsidiaryname2 := le.subsidiaryname2 <> ri.subsidiaryname2;
    SELF.Diff_subsidiarystartdate2 := le.subsidiarystartdate2 <> ri.subsidiarystartdate2;
    SELF.Diff_subsidiaryname3 := le.subsidiaryname3 <> ri.subsidiaryname3;
    SELF.Diff_subsidiarystartdate3 := le.subsidiarystartdate3 <> ri.subsidiarystartdate3;
    SELF.Diff_subsidiaryname4 := le.subsidiaryname4 <> ri.subsidiaryname4;
    SELF.Diff_subsidiarystartdate4 := le.subsidiarystartdate4 <> ri.subsidiarystartdate4;
    SELF.Diff_subsidiaryname5 := le.subsidiaryname5 <> ri.subsidiaryname5;
    SELF.Diff_subsidiarystartdate5 := le.subsidiarystartdate5 <> ri.subsidiarystartdate5;
    SELF.Diff_subsidiaryname6 := le.subsidiaryname6 <> ri.subsidiaryname6;
    SELF.Diff_subsidiarystartdate6 := le.subsidiarystartdate6 <> ri.subsidiarystartdate6;
    SELF.Diff_subsidiaryname7 := le.subsidiaryname7 <> ri.subsidiaryname7;
    SELF.Diff_subsidiarystartdate7 := le.subsidiarystartdate7 <> ri.subsidiarystartdate7;
    SELF.Diff_subsidiaryname8 := le.subsidiaryname8 <> ri.subsidiaryname8;
    SELF.Diff_subsidiarystartdate8 := le.subsidiarystartdate8 <> ri.subsidiarystartdate8;
    SELF.Diff_subsidiaryname9 := le.subsidiaryname9 <> ri.subsidiaryname9;
    SELF.Diff_subsidiarystartdate9 := le.subsidiarystartdate9 <> ri.subsidiarystartdate9;
    SELF.Diff_subsidiaryname10 := le.subsidiaryname10 <> ri.subsidiaryname10;
    SELF.Diff_subsidiarystartdate10 := le.subsidiarystartdate10 <> ri.subsidiarystartdate10;
    SELF.Diff_append_mailaddress1 := le.append_mailaddress1 <> ri.append_mailaddress1;
    SELF.Diff_append_mailaddresslast := le.append_mailaddresslast <> ri.append_mailaddresslast;
    SELF.Diff_append_mailrawaid := le.append_mailrawaid <> ri.append_mailrawaid;
    SELF.Diff_append_mailaceaid := le.append_mailaceaid <> ri.append_mailaceaid;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_date_firstseen,1,0)+ IF( SELF.Diff_date_lastseen,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_dotid,1,0)+ IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_selescore,1,0)+ IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ IF( SELF.Diff_ultweight,1,0)+ IF( SELF.Diff_unique_id,1,0)+ IF( SELF.Diff_norm_type,1,0)+ IF( SELF.Diff_norm_businessname,1,0)+ IF( SELF.Diff_norm_firstname,1,0)+ IF( SELF.Diff_norm_middle,1,0)+ IF( SELF.Diff_norm_last,1,0)+ IF( SELF.Diff_norm_suffix,1,0)+ IF( SELF.Diff_norm_address1,1,0)+ IF( SELF.Diff_norm_address2,1,0)+ IF( SELF.Diff_norm_city,1,0)+ IF( SELF.Diff_norm_state,1,0)+ IF( SELF.Diff_norm_zip,1,0)+ IF( SELF.Diff_norm_zip4,1,0)+ IF( SELF.Diff_norm_phone,1,0)+ IF( SELF.Diff_dartid,1,0)+ IF( SELF.Diff_dateadded,1,0)+ IF( SELF.Diff_dateupdated,1,0)+ IF( SELF.Diff_website,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_lninscertrecordid,1,0)+ IF( SELF.Diff_profilelastupdated,1,0)+ IF( SELF.Diff_siid,1,0)+ IF( SELF.Diff_sipstatuscode,1,0)+ IF( SELF.Diff_wcbempnumber,1,0)+ IF( SELF.Diff_ubinumber,1,0)+ IF( SELF.Diff_cofanumber,1,0)+ IF( SELF.Diff_usdotnumber,1,0)+ IF( SELF.Diff_phone2,1,0)+ IF( SELF.Diff_phone3,1,0)+ IF( SELF.Diff_fax1,1,0)+ IF( SELF.Diff_fax2,1,0)+ IF( SELF.Diff_email1,1,0)+ IF( SELF.Diff_email2,1,0)+ IF( SELF.Diff_businesstype,1,0)+ IF( SELF.Diff_nametitle,1,0)+ IF( SELF.Diff_mailingaddress1,1,0)+ IF( SELF.Diff_mailingaddress2,1,0)+ IF( SELF.Diff_mailingaddresscity,1,0)+ IF( SELF.Diff_mailingaddressstate,1,0)+ IF( SELF.Diff_mailingaddresszip,1,0)+ IF( SELF.Diff_mailingaddresszip4,1,0)+ IF( SELF.Diff_contactfax,1,0)+ IF( SELF.Diff_contactemail,1,0)+ IF( SELF.Diff_policyholdernamefirst,1,0)+ IF( SELF.Diff_policyholdernamemiddle,1,0)+ IF( SELF.Diff_policyholdernamelast,1,0)+ IF( SELF.Diff_policyholdernamesuffix,1,0)+ IF( SELF.Diff_statepolicyfilenumber,1,0)+ IF( SELF.Diff_coverageinjuryillnessdate,1,0)+ IF( SELF.Diff_selfinsurancegroup,1,0)+ IF( SELF.Diff_selfinsurancegroupphone,1,0)+ IF( SELF.Diff_selfinsurancegroupid,1,0)+ IF( SELF.Diff_numberofemployees,1,0)+ IF( SELF.Diff_licensedcontractor,1,0)+ IF( SELF.Diff_mconame,1,0)+ IF( SELF.Diff_mconumber,1,0)+ IF( SELF.Diff_mcoaddressline1,1,0)+ IF( SELF.Diff_mcoaddressline2,1,0)+ IF( SELF.Diff_mcocity,1,0)+ IF( SELF.Diff_mcostate,1,0)+ IF( SELF.Diff_mcozip,1,0)+ IF( SELF.Diff_mcozip4,1,0)+ IF( SELF.Diff_mcophone,1,0)+ IF( SELF.Diff_governingclasscode,1,0)+ IF( SELF.Diff_licensenumber,1,0)+ IF( SELF.Diff_class,1,0)+ IF( SELF.Diff_classificationdescription,1,0)+ IF( SELF.Diff_licensestatus,1,0)+ IF( SELF.Diff_licenseadditionalinfo,1,0)+ IF( SELF.Diff_licenseissuedate,1,0)+ IF( SELF.Diff_licenseexpirationdate,1,0)+ IF( SELF.Diff_naicscode,1,0)+ IF( SELF.Diff_officerexemptfirstname1,1,0)+ IF( SELF.Diff_officerexemptlastname1,1,0)+ IF( SELF.Diff_officerexemptmiddlename1,1,0)+ IF( SELF.Diff_officerexempttitle1,1,0)+ IF( SELF.Diff_officerexempteffectivedate1,1,0)+ IF( SELF.Diff_officerexemptterminationdate1,1,0)+ IF( SELF.Diff_officerexempttype1,1,0)+ IF( SELF.Diff_officerexemptbusinessactivities1,1,0)+ IF( SELF.Diff_officerexemptfirstname2,1,0)+ IF( SELF.Diff_officerexemptlastname2,1,0)+ IF( SELF.Diff_officerexemptmiddlename2,1,0)+ IF( SELF.Diff_officerexempttitle2,1,0)+ IF( SELF.Diff_officerexempteffectivedate2,1,0)+ IF( SELF.Diff_officerexemptterminationdate2,1,0)+ IF( SELF.Diff_officerexempttype2,1,0)+ IF( SELF.Diff_officerexemptbusinessactivities2,1,0)+ IF( SELF.Diff_officerexemptfirstname3,1,0)+ IF( SELF.Diff_officerexemptlastname3,1,0)+ IF( SELF.Diff_officerexemptmiddlename3,1,0)+ IF( SELF.Diff_officerexempttitle3,1,0)+ IF( SELF.Diff_officerexempteffectivedate3,1,0)+ IF( SELF.Diff_officerexemptterminationdate3,1,0)+ IF( SELF.Diff_officerexempttype3,1,0)+ IF( SELF.Diff_officerexemptbusinessactivities3,1,0)+ IF( SELF.Diff_officerexemptfirstname4,1,0)+ IF( SELF.Diff_officerexemptlastname4,1,0)+ IF( SELF.Diff_officerexemptmiddlename4,1,0)+ IF( SELF.Diff_officerexempttitle4,1,0)+ IF( SELF.Diff_officerexempteffectivedate4,1,0)+ IF( SELF.Diff_officerexemptterminationdate4,1,0)+ IF( SELF.Diff_officerexempttype4,1,0)+ IF( SELF.Diff_officerexemptbusinessactivities4,1,0)+ IF( SELF.Diff_officerexemptfirstname5,1,0)+ IF( SELF.Diff_officerexemptlastname5,1,0)+ IF( SELF.Diff_officerexemptmiddlename5,1,0)+ IF( SELF.Diff_officerexempttitle5,1,0)+ IF( SELF.Diff_officerexempteffectivedate5,1,0)+ IF( SELF.Diff_officerexemptterminationdate5,1,0)+ IF( SELF.Diff_officerexempttype5,1,0)+ IF( SELF.Diff_officerexemptbusinessactivities5,1,0)+ IF( SELF.Diff_dba1,1,0)+ IF( SELF.Diff_dbadatefrom1,1,0)+ IF( SELF.Diff_dbadateto1,1,0)+ IF( SELF.Diff_dbatype1,1,0)+ IF( SELF.Diff_dba2,1,0)+ IF( SELF.Diff_dbadatefrom2,1,0)+ IF( SELF.Diff_dbadateto2,1,0)+ IF( SELF.Diff_dbatype2,1,0)+ IF( SELF.Diff_dba3,1,0)+ IF( SELF.Diff_dbadatefrom3,1,0)+ IF( SELF.Diff_dbadateto3,1,0)+ IF( SELF.Diff_dbatype3,1,0)+ IF( SELF.Diff_dba4,1,0)+ IF( SELF.Diff_dbadatefrom4,1,0)+ IF( SELF.Diff_dbadateto4,1,0)+ IF( SELF.Diff_dbatype4,1,0)+ IF( SELF.Diff_dba5,1,0)+ IF( SELF.Diff_dbadatefrom5,1,0)+ IF( SELF.Diff_dbadateto5,1,0)+ IF( SELF.Diff_dbatype5,1,0)+ IF( SELF.Diff_subsidiaryname1,1,0)+ IF( SELF.Diff_subsidiarystartdate1,1,0)+ IF( SELF.Diff_subsidiaryname2,1,0)+ IF( SELF.Diff_subsidiarystartdate2,1,0)+ IF( SELF.Diff_subsidiaryname3,1,0)+ IF( SELF.Diff_subsidiarystartdate3,1,0)+ IF( SELF.Diff_subsidiaryname4,1,0)+ IF( SELF.Diff_subsidiarystartdate4,1,0)+ IF( SELF.Diff_subsidiaryname5,1,0)+ IF( SELF.Diff_subsidiarystartdate5,1,0)+ IF( SELF.Diff_subsidiaryname6,1,0)+ IF( SELF.Diff_subsidiarystartdate6,1,0)+ IF( SELF.Diff_subsidiaryname7,1,0)+ IF( SELF.Diff_subsidiarystartdate7,1,0)+ IF( SELF.Diff_subsidiaryname8,1,0)+ IF( SELF.Diff_subsidiarystartdate8,1,0)+ IF( SELF.Diff_subsidiaryname9,1,0)+ IF( SELF.Diff_subsidiarystartdate9,1,0)+ IF( SELF.Diff_subsidiaryname10,1,0)+ IF( SELF.Diff_subsidiarystartdate10,1,0)+ IF( SELF.Diff_append_mailaddress1,1,0)+ IF( SELF.Diff_append_mailaddresslast,1,0)+ IF( SELF.Diff_append_mailrawaid,1,0)+ IF( SELF.Diff_append_mailaceaid,1,0);
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
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
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
    Count_Diff_unique_id := COUNT(GROUP,%Closest%.Diff_unique_id);
    Count_Diff_norm_type := COUNT(GROUP,%Closest%.Diff_norm_type);
    Count_Diff_norm_businessname := COUNT(GROUP,%Closest%.Diff_norm_businessname);
    Count_Diff_norm_firstname := COUNT(GROUP,%Closest%.Diff_norm_firstname);
    Count_Diff_norm_middle := COUNT(GROUP,%Closest%.Diff_norm_middle);
    Count_Diff_norm_last := COUNT(GROUP,%Closest%.Diff_norm_last);
    Count_Diff_norm_suffix := COUNT(GROUP,%Closest%.Diff_norm_suffix);
    Count_Diff_norm_address1 := COUNT(GROUP,%Closest%.Diff_norm_address1);
    Count_Diff_norm_address2 := COUNT(GROUP,%Closest%.Diff_norm_address2);
    Count_Diff_norm_city := COUNT(GROUP,%Closest%.Diff_norm_city);
    Count_Diff_norm_state := COUNT(GROUP,%Closest%.Diff_norm_state);
    Count_Diff_norm_zip := COUNT(GROUP,%Closest%.Diff_norm_zip);
    Count_Diff_norm_zip4 := COUNT(GROUP,%Closest%.Diff_norm_zip4);
    Count_Diff_norm_phone := COUNT(GROUP,%Closest%.Diff_norm_phone);
    Count_Diff_dartid := COUNT(GROUP,%Closest%.Diff_dartid);
    Count_Diff_dateadded := COUNT(GROUP,%Closest%.Diff_dateadded);
    Count_Diff_dateupdated := COUNT(GROUP,%Closest%.Diff_dateupdated);
    Count_Diff_website := COUNT(GROUP,%Closest%.Diff_website);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_lninscertrecordid := COUNT(GROUP,%Closest%.Diff_lninscertrecordid);
    Count_Diff_profilelastupdated := COUNT(GROUP,%Closest%.Diff_profilelastupdated);
    Count_Diff_siid := COUNT(GROUP,%Closest%.Diff_siid);
    Count_Diff_sipstatuscode := COUNT(GROUP,%Closest%.Diff_sipstatuscode);
    Count_Diff_wcbempnumber := COUNT(GROUP,%Closest%.Diff_wcbempnumber);
    Count_Diff_ubinumber := COUNT(GROUP,%Closest%.Diff_ubinumber);
    Count_Diff_cofanumber := COUNT(GROUP,%Closest%.Diff_cofanumber);
    Count_Diff_usdotnumber := COUNT(GROUP,%Closest%.Diff_usdotnumber);
    Count_Diff_phone2 := COUNT(GROUP,%Closest%.Diff_phone2);
    Count_Diff_phone3 := COUNT(GROUP,%Closest%.Diff_phone3);
    Count_Diff_fax1 := COUNT(GROUP,%Closest%.Diff_fax1);
    Count_Diff_fax2 := COUNT(GROUP,%Closest%.Diff_fax2);
    Count_Diff_email1 := COUNT(GROUP,%Closest%.Diff_email1);
    Count_Diff_email2 := COUNT(GROUP,%Closest%.Diff_email2);
    Count_Diff_businesstype := COUNT(GROUP,%Closest%.Diff_businesstype);
    Count_Diff_nametitle := COUNT(GROUP,%Closest%.Diff_nametitle);
    Count_Diff_mailingaddress1 := COUNT(GROUP,%Closest%.Diff_mailingaddress1);
    Count_Diff_mailingaddress2 := COUNT(GROUP,%Closest%.Diff_mailingaddress2);
    Count_Diff_mailingaddresscity := COUNT(GROUP,%Closest%.Diff_mailingaddresscity);
    Count_Diff_mailingaddressstate := COUNT(GROUP,%Closest%.Diff_mailingaddressstate);
    Count_Diff_mailingaddresszip := COUNT(GROUP,%Closest%.Diff_mailingaddresszip);
    Count_Diff_mailingaddresszip4 := COUNT(GROUP,%Closest%.Diff_mailingaddresszip4);
    Count_Diff_contactfax := COUNT(GROUP,%Closest%.Diff_contactfax);
    Count_Diff_contactemail := COUNT(GROUP,%Closest%.Diff_contactemail);
    Count_Diff_policyholdernamefirst := COUNT(GROUP,%Closest%.Diff_policyholdernamefirst);
    Count_Diff_policyholdernamemiddle := COUNT(GROUP,%Closest%.Diff_policyholdernamemiddle);
    Count_Diff_policyholdernamelast := COUNT(GROUP,%Closest%.Diff_policyholdernamelast);
    Count_Diff_policyholdernamesuffix := COUNT(GROUP,%Closest%.Diff_policyholdernamesuffix);
    Count_Diff_statepolicyfilenumber := COUNT(GROUP,%Closest%.Diff_statepolicyfilenumber);
    Count_Diff_coverageinjuryillnessdate := COUNT(GROUP,%Closest%.Diff_coverageinjuryillnessdate);
    Count_Diff_selfinsurancegroup := COUNT(GROUP,%Closest%.Diff_selfinsurancegroup);
    Count_Diff_selfinsurancegroupphone := COUNT(GROUP,%Closest%.Diff_selfinsurancegroupphone);
    Count_Diff_selfinsurancegroupid := COUNT(GROUP,%Closest%.Diff_selfinsurancegroupid);
    Count_Diff_numberofemployees := COUNT(GROUP,%Closest%.Diff_numberofemployees);
    Count_Diff_licensedcontractor := COUNT(GROUP,%Closest%.Diff_licensedcontractor);
    Count_Diff_mconame := COUNT(GROUP,%Closest%.Diff_mconame);
    Count_Diff_mconumber := COUNT(GROUP,%Closest%.Diff_mconumber);
    Count_Diff_mcoaddressline1 := COUNT(GROUP,%Closest%.Diff_mcoaddressline1);
    Count_Diff_mcoaddressline2 := COUNT(GROUP,%Closest%.Diff_mcoaddressline2);
    Count_Diff_mcocity := COUNT(GROUP,%Closest%.Diff_mcocity);
    Count_Diff_mcostate := COUNT(GROUP,%Closest%.Diff_mcostate);
    Count_Diff_mcozip := COUNT(GROUP,%Closest%.Diff_mcozip);
    Count_Diff_mcozip4 := COUNT(GROUP,%Closest%.Diff_mcozip4);
    Count_Diff_mcophone := COUNT(GROUP,%Closest%.Diff_mcophone);
    Count_Diff_governingclasscode := COUNT(GROUP,%Closest%.Diff_governingclasscode);
    Count_Diff_licensenumber := COUNT(GROUP,%Closest%.Diff_licensenumber);
    Count_Diff_class := COUNT(GROUP,%Closest%.Diff_class);
    Count_Diff_classificationdescription := COUNT(GROUP,%Closest%.Diff_classificationdescription);
    Count_Diff_licensestatus := COUNT(GROUP,%Closest%.Diff_licensestatus);
    Count_Diff_licenseadditionalinfo := COUNT(GROUP,%Closest%.Diff_licenseadditionalinfo);
    Count_Diff_licenseissuedate := COUNT(GROUP,%Closest%.Diff_licenseissuedate);
    Count_Diff_licenseexpirationdate := COUNT(GROUP,%Closest%.Diff_licenseexpirationdate);
    Count_Diff_naicscode := COUNT(GROUP,%Closest%.Diff_naicscode);
    Count_Diff_officerexemptfirstname1 := COUNT(GROUP,%Closest%.Diff_officerexemptfirstname1);
    Count_Diff_officerexemptlastname1 := COUNT(GROUP,%Closest%.Diff_officerexemptlastname1);
    Count_Diff_officerexemptmiddlename1 := COUNT(GROUP,%Closest%.Diff_officerexemptmiddlename1);
    Count_Diff_officerexempttitle1 := COUNT(GROUP,%Closest%.Diff_officerexempttitle1);
    Count_Diff_officerexempteffectivedate1 := COUNT(GROUP,%Closest%.Diff_officerexempteffectivedate1);
    Count_Diff_officerexemptterminationdate1 := COUNT(GROUP,%Closest%.Diff_officerexemptterminationdate1);
    Count_Diff_officerexempttype1 := COUNT(GROUP,%Closest%.Diff_officerexempttype1);
    Count_Diff_officerexemptbusinessactivities1 := COUNT(GROUP,%Closest%.Diff_officerexemptbusinessactivities1);
    Count_Diff_officerexemptfirstname2 := COUNT(GROUP,%Closest%.Diff_officerexemptfirstname2);
    Count_Diff_officerexemptlastname2 := COUNT(GROUP,%Closest%.Diff_officerexemptlastname2);
    Count_Diff_officerexemptmiddlename2 := COUNT(GROUP,%Closest%.Diff_officerexemptmiddlename2);
    Count_Diff_officerexempttitle2 := COUNT(GROUP,%Closest%.Diff_officerexempttitle2);
    Count_Diff_officerexempteffectivedate2 := COUNT(GROUP,%Closest%.Diff_officerexempteffectivedate2);
    Count_Diff_officerexemptterminationdate2 := COUNT(GROUP,%Closest%.Diff_officerexemptterminationdate2);
    Count_Diff_officerexempttype2 := COUNT(GROUP,%Closest%.Diff_officerexempttype2);
    Count_Diff_officerexemptbusinessactivities2 := COUNT(GROUP,%Closest%.Diff_officerexemptbusinessactivities2);
    Count_Diff_officerexemptfirstname3 := COUNT(GROUP,%Closest%.Diff_officerexemptfirstname3);
    Count_Diff_officerexemptlastname3 := COUNT(GROUP,%Closest%.Diff_officerexemptlastname3);
    Count_Diff_officerexemptmiddlename3 := COUNT(GROUP,%Closest%.Diff_officerexemptmiddlename3);
    Count_Diff_officerexempttitle3 := COUNT(GROUP,%Closest%.Diff_officerexempttitle3);
    Count_Diff_officerexempteffectivedate3 := COUNT(GROUP,%Closest%.Diff_officerexempteffectivedate3);
    Count_Diff_officerexemptterminationdate3 := COUNT(GROUP,%Closest%.Diff_officerexemptterminationdate3);
    Count_Diff_officerexempttype3 := COUNT(GROUP,%Closest%.Diff_officerexempttype3);
    Count_Diff_officerexemptbusinessactivities3 := COUNT(GROUP,%Closest%.Diff_officerexemptbusinessactivities3);
    Count_Diff_officerexemptfirstname4 := COUNT(GROUP,%Closest%.Diff_officerexemptfirstname4);
    Count_Diff_officerexemptlastname4 := COUNT(GROUP,%Closest%.Diff_officerexemptlastname4);
    Count_Diff_officerexemptmiddlename4 := COUNT(GROUP,%Closest%.Diff_officerexemptmiddlename4);
    Count_Diff_officerexempttitle4 := COUNT(GROUP,%Closest%.Diff_officerexempttitle4);
    Count_Diff_officerexempteffectivedate4 := COUNT(GROUP,%Closest%.Diff_officerexempteffectivedate4);
    Count_Diff_officerexemptterminationdate4 := COUNT(GROUP,%Closest%.Diff_officerexemptterminationdate4);
    Count_Diff_officerexempttype4 := COUNT(GROUP,%Closest%.Diff_officerexempttype4);
    Count_Diff_officerexemptbusinessactivities4 := COUNT(GROUP,%Closest%.Diff_officerexemptbusinessactivities4);
    Count_Diff_officerexemptfirstname5 := COUNT(GROUP,%Closest%.Diff_officerexemptfirstname5);
    Count_Diff_officerexemptlastname5 := COUNT(GROUP,%Closest%.Diff_officerexemptlastname5);
    Count_Diff_officerexemptmiddlename5 := COUNT(GROUP,%Closest%.Diff_officerexemptmiddlename5);
    Count_Diff_officerexempttitle5 := COUNT(GROUP,%Closest%.Diff_officerexempttitle5);
    Count_Diff_officerexempteffectivedate5 := COUNT(GROUP,%Closest%.Diff_officerexempteffectivedate5);
    Count_Diff_officerexemptterminationdate5 := COUNT(GROUP,%Closest%.Diff_officerexemptterminationdate5);
    Count_Diff_officerexempttype5 := COUNT(GROUP,%Closest%.Diff_officerexempttype5);
    Count_Diff_officerexemptbusinessactivities5 := COUNT(GROUP,%Closest%.Diff_officerexemptbusinessactivities5);
    Count_Diff_dba1 := COUNT(GROUP,%Closest%.Diff_dba1);
    Count_Diff_dbadatefrom1 := COUNT(GROUP,%Closest%.Diff_dbadatefrom1);
    Count_Diff_dbadateto1 := COUNT(GROUP,%Closest%.Diff_dbadateto1);
    Count_Diff_dbatype1 := COUNT(GROUP,%Closest%.Diff_dbatype1);
    Count_Diff_dba2 := COUNT(GROUP,%Closest%.Diff_dba2);
    Count_Diff_dbadatefrom2 := COUNT(GROUP,%Closest%.Diff_dbadatefrom2);
    Count_Diff_dbadateto2 := COUNT(GROUP,%Closest%.Diff_dbadateto2);
    Count_Diff_dbatype2 := COUNT(GROUP,%Closest%.Diff_dbatype2);
    Count_Diff_dba3 := COUNT(GROUP,%Closest%.Diff_dba3);
    Count_Diff_dbadatefrom3 := COUNT(GROUP,%Closest%.Diff_dbadatefrom3);
    Count_Diff_dbadateto3 := COUNT(GROUP,%Closest%.Diff_dbadateto3);
    Count_Diff_dbatype3 := COUNT(GROUP,%Closest%.Diff_dbatype3);
    Count_Diff_dba4 := COUNT(GROUP,%Closest%.Diff_dba4);
    Count_Diff_dbadatefrom4 := COUNT(GROUP,%Closest%.Diff_dbadatefrom4);
    Count_Diff_dbadateto4 := COUNT(GROUP,%Closest%.Diff_dbadateto4);
    Count_Diff_dbatype4 := COUNT(GROUP,%Closest%.Diff_dbatype4);
    Count_Diff_dba5 := COUNT(GROUP,%Closest%.Diff_dba5);
    Count_Diff_dbadatefrom5 := COUNT(GROUP,%Closest%.Diff_dbadatefrom5);
    Count_Diff_dbadateto5 := COUNT(GROUP,%Closest%.Diff_dbadateto5);
    Count_Diff_dbatype5 := COUNT(GROUP,%Closest%.Diff_dbatype5);
    Count_Diff_subsidiaryname1 := COUNT(GROUP,%Closest%.Diff_subsidiaryname1);
    Count_Diff_subsidiarystartdate1 := COUNT(GROUP,%Closest%.Diff_subsidiarystartdate1);
    Count_Diff_subsidiaryname2 := COUNT(GROUP,%Closest%.Diff_subsidiaryname2);
    Count_Diff_subsidiarystartdate2 := COUNT(GROUP,%Closest%.Diff_subsidiarystartdate2);
    Count_Diff_subsidiaryname3 := COUNT(GROUP,%Closest%.Diff_subsidiaryname3);
    Count_Diff_subsidiarystartdate3 := COUNT(GROUP,%Closest%.Diff_subsidiarystartdate3);
    Count_Diff_subsidiaryname4 := COUNT(GROUP,%Closest%.Diff_subsidiaryname4);
    Count_Diff_subsidiarystartdate4 := COUNT(GROUP,%Closest%.Diff_subsidiarystartdate4);
    Count_Diff_subsidiaryname5 := COUNT(GROUP,%Closest%.Diff_subsidiaryname5);
    Count_Diff_subsidiarystartdate5 := COUNT(GROUP,%Closest%.Diff_subsidiarystartdate5);
    Count_Diff_subsidiaryname6 := COUNT(GROUP,%Closest%.Diff_subsidiaryname6);
    Count_Diff_subsidiarystartdate6 := COUNT(GROUP,%Closest%.Diff_subsidiarystartdate6);
    Count_Diff_subsidiaryname7 := COUNT(GROUP,%Closest%.Diff_subsidiaryname7);
    Count_Diff_subsidiarystartdate7 := COUNT(GROUP,%Closest%.Diff_subsidiarystartdate7);
    Count_Diff_subsidiaryname8 := COUNT(GROUP,%Closest%.Diff_subsidiaryname8);
    Count_Diff_subsidiarystartdate8 := COUNT(GROUP,%Closest%.Diff_subsidiarystartdate8);
    Count_Diff_subsidiaryname9 := COUNT(GROUP,%Closest%.Diff_subsidiaryname9);
    Count_Diff_subsidiarystartdate9 := COUNT(GROUP,%Closest%.Diff_subsidiarystartdate9);
    Count_Diff_subsidiaryname10 := COUNT(GROUP,%Closest%.Diff_subsidiaryname10);
    Count_Diff_subsidiarystartdate10 := COUNT(GROUP,%Closest%.Diff_subsidiarystartdate10);
    Count_Diff_append_mailaddress1 := COUNT(GROUP,%Closest%.Diff_append_mailaddress1);
    Count_Diff_append_mailaddresslast := COUNT(GROUP,%Closest%.Diff_append_mailaddresslast);
    Count_Diff_append_mailrawaid := COUNT(GROUP,%Closest%.Diff_append_mailrawaid);
    Count_Diff_append_mailaceaid := COUNT(GROUP,%Closest%.Diff_append_mailaceaid);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
