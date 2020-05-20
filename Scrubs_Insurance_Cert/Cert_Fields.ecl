IMPORT SALT311;
EXPORT Cert_Fields := MODULE
 
EXPORT NumFields := 163;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Test');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Test' => 1,0);
 
EXPORT MakeFT_Test(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'x'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Test(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'x'))));
EXPORT InValidMessageFT_Test(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('x'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dartid','dateadded','dateupdated','website','state','lninscertrecordid','profilelastupdated','siid','sipstatuscode','wcbempnumber','ubinumber','cofanumber','usdotnumber','businessname','dba','addressline1','addressline2','addresscity','addressstate','addresszip','zip4','phone1','phone2','phone3','fax1','fax2','email1','email2','businesstype','namefirst','namemiddle','namelast','namesuffix','nametitle','mailingaddress1','mailingaddress2','mailingaddresscity','mailingaddressstate','mailingaddresszip','mailingaddresszip4','contactnamefirst','contactnamemiddle','contactnamelast','contactnamesuffix','contactbusinessname','contactaddressline1','contactaddressline2','contactcity','contactstate','contactzip','contactzip4','contactphone','contactfax','contactemail','policyholdernamefirst','policyholdernamemiddle','policyholdernamelast','policyholdernamesuffix','statepolicyfilenumber','coverageinjuryillnessdate','selfinsurancegroup','selfinsurancegroupphone','selfinsurancegroupid','numberofemployees','licensedcontractor','mconame','mconumber','mcoaddressline1','mcoaddressline2','mcocity','mcostate','mcozip','mcozip4','mcophone','governingclasscode','licensenumber','class','classificationdescription','licensestatus','licenseadditionalinfo','licenseissuedate','licenseexpirationdate','naicscode','officerexemptfirstname1','officerexemptlastname1','officerexemptmiddlename1','officerexempttitle1','officerexempteffectivedate1','officerexemptterminationdate1','officerexempttype1','officerexemptbusinessactivities1','officerexemptfirstname2','officerexemptlastname2','officerexemptmiddlename2','officerexempttitle2','officerexempteffectivedate2','officerexemptterminationdate2','officerexempttype2','officerexemptbusinessactivities2','officerexemptfirstname3','officerexemptlastname3','officerexemptmiddlename3','officerexempttitle3','officerexempteffectivedate3','officerexemptterminationdate3','officerexempttype3','officerexemptbusinessactivities3','officerexemptfirstname4','officerexemptlastname4','officerexemptmiddlename4','officerexempttitle4','officerexempteffectivedate4','officerexemptterminationdate4','officerexempttype4','officerexemptbusinessactivities4','officerexemptfirstname5','officerexemptlastname5','officerexemptmiddlename5','officerexempttitle5','officerexempteffectivedate5','officerexemptterminationdate5','officerexempttype5','officerexemptbusinessactivities5','dba1','dbadatefrom1','dbadateto1','dbatype1','dba2','dbadatefrom2','dbadateto2','dbatype2','dba3','dbadatefrom3','dbadateto3','dbatype3','dba4','dbadatefrom4','dbadateto4','dbatype4','dba5','dbadatefrom5','dbadateto5','dbatype5','subsidiaryname1','subsidiarystartdate1','subsidiaryname2','subsidiarystartdate2','subsidiaryname3','subsidiarystartdate3','subsidiaryname4','subsidiarystartdate4','subsidiaryname5','subsidiarystartdate5','subsidiaryname6','subsidiarystartdate6','subsidiaryname7','subsidiarystartdate7','subsidiaryname8','subsidiarystartdate8','subsidiaryname9','subsidiarystartdate9','subsidiaryname10','subsidiarystartdate10');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dartid','dateadded','dateupdated','website','state','lninscertrecordid','profilelastupdated','siid','sipstatuscode','wcbempnumber','ubinumber','cofanumber','usdotnumber','businessname','dba','addressline1','addressline2','addresscity','addressstate','addresszip','zip4','phone1','phone2','phone3','fax1','fax2','email1','email2','businesstype','namefirst','namemiddle','namelast','namesuffix','nametitle','mailingaddress1','mailingaddress2','mailingaddresscity','mailingaddressstate','mailingaddresszip','mailingaddresszip4','contactnamefirst','contactnamemiddle','contactnamelast','contactnamesuffix','contactbusinessname','contactaddressline1','contactaddressline2','contactcity','contactstate','contactzip','contactzip4','contactphone','contactfax','contactemail','policyholdernamefirst','policyholdernamemiddle','policyholdernamelast','policyholdernamesuffix','statepolicyfilenumber','coverageinjuryillnessdate','selfinsurancegroup','selfinsurancegroupphone','selfinsurancegroupid','numberofemployees','licensedcontractor','mconame','mconumber','mcoaddressline1','mcoaddressline2','mcocity','mcostate','mcozip','mcozip4','mcophone','governingclasscode','licensenumber','class','classificationdescription','licensestatus','licenseadditionalinfo','licenseissuedate','licenseexpirationdate','naicscode','officerexemptfirstname1','officerexemptlastname1','officerexemptmiddlename1','officerexempttitle1','officerexempteffectivedate1','officerexemptterminationdate1','officerexempttype1','officerexemptbusinessactivities1','officerexemptfirstname2','officerexemptlastname2','officerexemptmiddlename2','officerexempttitle2','officerexempteffectivedate2','officerexemptterminationdate2','officerexempttype2','officerexemptbusinessactivities2','officerexemptfirstname3','officerexemptlastname3','officerexemptmiddlename3','officerexempttitle3','officerexempteffectivedate3','officerexemptterminationdate3','officerexempttype3','officerexemptbusinessactivities3','officerexemptfirstname4','officerexemptlastname4','officerexemptmiddlename4','officerexempttitle4','officerexempteffectivedate4','officerexemptterminationdate4','officerexempttype4','officerexemptbusinessactivities4','officerexemptfirstname5','officerexemptlastname5','officerexemptmiddlename5','officerexempttitle5','officerexempteffectivedate5','officerexemptterminationdate5','officerexempttype5','officerexemptbusinessactivities5','dba1','dbadatefrom1','dbadateto1','dbatype1','dba2','dbadatefrom2','dbadateto2','dbatype2','dba3','dbadatefrom3','dbadateto3','dbatype3','dba4','dbadatefrom4','dbadateto4','dbatype4','dba5','dbadatefrom5','dbadateto5','dbatype5','subsidiaryname1','subsidiarystartdate1','subsidiaryname2','subsidiarystartdate2','subsidiaryname3','subsidiarystartdate3','subsidiaryname4','subsidiarystartdate4','subsidiaryname5','subsidiarystartdate5','subsidiaryname6','subsidiarystartdate6','subsidiaryname7','subsidiarystartdate7','subsidiaryname8','subsidiarystartdate8','subsidiaryname9','subsidiarystartdate9','subsidiaryname10','subsidiarystartdate10');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'dartid' => 0,'dateadded' => 1,'dateupdated' => 2,'website' => 3,'state' => 4,'lninscertrecordid' => 5,'profilelastupdated' => 6,'siid' => 7,'sipstatuscode' => 8,'wcbempnumber' => 9,'ubinumber' => 10,'cofanumber' => 11,'usdotnumber' => 12,'businessname' => 13,'dba' => 14,'addressline1' => 15,'addressline2' => 16,'addresscity' => 17,'addressstate' => 18,'addresszip' => 19,'zip4' => 20,'phone1' => 21,'phone2' => 22,'phone3' => 23,'fax1' => 24,'fax2' => 25,'email1' => 26,'email2' => 27,'businesstype' => 28,'namefirst' => 29,'namemiddle' => 30,'namelast' => 31,'namesuffix' => 32,'nametitle' => 33,'mailingaddress1' => 34,'mailingaddress2' => 35,'mailingaddresscity' => 36,'mailingaddressstate' => 37,'mailingaddresszip' => 38,'mailingaddresszip4' => 39,'contactnamefirst' => 40,'contactnamemiddle' => 41,'contactnamelast' => 42,'contactnamesuffix' => 43,'contactbusinessname' => 44,'contactaddressline1' => 45,'contactaddressline2' => 46,'contactcity' => 47,'contactstate' => 48,'contactzip' => 49,'contactzip4' => 50,'contactphone' => 51,'contactfax' => 52,'contactemail' => 53,'policyholdernamefirst' => 54,'policyholdernamemiddle' => 55,'policyholdernamelast' => 56,'policyholdernamesuffix' => 57,'statepolicyfilenumber' => 58,'coverageinjuryillnessdate' => 59,'selfinsurancegroup' => 60,'selfinsurancegroupphone' => 61,'selfinsurancegroupid' => 62,'numberofemployees' => 63,'licensedcontractor' => 64,'mconame' => 65,'mconumber' => 66,'mcoaddressline1' => 67,'mcoaddressline2' => 68,'mcocity' => 69,'mcostate' => 70,'mcozip' => 71,'mcozip4' => 72,'mcophone' => 73,'governingclasscode' => 74,'licensenumber' => 75,'class' => 76,'classificationdescription' => 77,'licensestatus' => 78,'licenseadditionalinfo' => 79,'licenseissuedate' => 80,'licenseexpirationdate' => 81,'naicscode' => 82,'officerexemptfirstname1' => 83,'officerexemptlastname1' => 84,'officerexemptmiddlename1' => 85,'officerexempttitle1' => 86,'officerexempteffectivedate1' => 87,'officerexemptterminationdate1' => 88,'officerexempttype1' => 89,'officerexemptbusinessactivities1' => 90,'officerexemptfirstname2' => 91,'officerexemptlastname2' => 92,'officerexemptmiddlename2' => 93,'officerexempttitle2' => 94,'officerexempteffectivedate2' => 95,'officerexemptterminationdate2' => 96,'officerexempttype2' => 97,'officerexemptbusinessactivities2' => 98,'officerexemptfirstname3' => 99,'officerexemptlastname3' => 100,'officerexemptmiddlename3' => 101,'officerexempttitle3' => 102,'officerexempteffectivedate3' => 103,'officerexemptterminationdate3' => 104,'officerexempttype3' => 105,'officerexemptbusinessactivities3' => 106,'officerexemptfirstname4' => 107,'officerexemptlastname4' => 108,'officerexemptmiddlename4' => 109,'officerexempttitle4' => 110,'officerexempteffectivedate4' => 111,'officerexemptterminationdate4' => 112,'officerexempttype4' => 113,'officerexemptbusinessactivities4' => 114,'officerexemptfirstname5' => 115,'officerexemptlastname5' => 116,'officerexemptmiddlename5' => 117,'officerexempttitle5' => 118,'officerexempteffectivedate5' => 119,'officerexemptterminationdate5' => 120,'officerexempttype5' => 121,'officerexemptbusinessactivities5' => 122,'dba1' => 123,'dbadatefrom1' => 124,'dbadateto1' => 125,'dbatype1' => 126,'dba2' => 127,'dbadatefrom2' => 128,'dbadateto2' => 129,'dbatype2' => 130,'dba3' => 131,'dbadatefrom3' => 132,'dbadateto3' => 133,'dbatype3' => 134,'dba4' => 135,'dbadatefrom4' => 136,'dbadateto4' => 137,'dbatype4' => 138,'dba5' => 139,'dbadatefrom5' => 140,'dbadateto5' => 141,'dbatype5' => 142,'subsidiaryname1' => 143,'subsidiarystartdate1' => 144,'subsidiaryname2' => 145,'subsidiarystartdate2' => 146,'subsidiaryname3' => 147,'subsidiarystartdate3' => 148,'subsidiaryname4' => 149,'subsidiarystartdate4' => 150,'subsidiaryname5' => 151,'subsidiarystartdate5' => 152,'subsidiaryname6' => 153,'subsidiarystartdate6' => 154,'subsidiaryname7' => 155,'subsidiarystartdate7' => 156,'subsidiaryname8' => 157,'subsidiarystartdate8' => 158,'subsidiaryname9' => 159,'subsidiarystartdate9' => 160,'subsidiaryname10' => 161,'subsidiarystartdate10' => 162,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_dartid(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_dartid(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_dartid(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_dateadded(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_dateadded(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_dateadded(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_dateupdated(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_dateupdated(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_dateupdated(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_website(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_website(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_website(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_lninscertrecordid(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_lninscertrecordid(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_lninscertrecordid(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_profilelastupdated(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_profilelastupdated(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_profilelastupdated(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_siid(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_siid(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_siid(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_sipstatuscode(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_sipstatuscode(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_sipstatuscode(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_wcbempnumber(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_wcbempnumber(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_wcbempnumber(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_ubinumber(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_ubinumber(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_ubinumber(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_cofanumber(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_cofanumber(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_cofanumber(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_usdotnumber(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_usdotnumber(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_usdotnumber(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_businessname(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_businessname(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_businessname(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_dba(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_dba(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_dba(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_addressline1(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_addressline1(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_addressline1(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_addressline2(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_addressline2(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_addressline2(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_addresscity(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_addresscity(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_addresscity(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_addressstate(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_addressstate(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_addressstate(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_addresszip(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_addresszip(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_addresszip(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_zip4(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_zip4(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_phone1(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_phone1(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_phone1(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_phone2(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_phone2(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_phone2(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_phone3(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_phone3(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_phone3(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_fax1(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_fax1(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_fax1(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_fax2(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_fax2(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_fax2(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_email1(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_email1(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_email1(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_email2(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_email2(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_email2(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_businesstype(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_businesstype(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_businesstype(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_namefirst(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_namefirst(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_namefirst(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_namemiddle(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_namemiddle(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_namemiddle(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_namelast(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_namelast(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_namelast(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_namesuffix(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_namesuffix(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_namesuffix(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_nametitle(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_nametitle(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_nametitle(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_mailingaddress1(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_mailingaddress1(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_mailingaddress1(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_mailingaddress2(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_mailingaddress2(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_mailingaddress2(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_mailingaddresscity(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_mailingaddresscity(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_mailingaddresscity(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_mailingaddressstate(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_mailingaddressstate(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_mailingaddressstate(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_mailingaddresszip(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_mailingaddresszip(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_mailingaddresszip(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_mailingaddresszip4(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_mailingaddresszip4(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_mailingaddresszip4(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_contactnamefirst(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_contactnamefirst(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_contactnamefirst(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_contactnamemiddle(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_contactnamemiddle(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_contactnamemiddle(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_contactnamelast(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_contactnamelast(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_contactnamelast(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_contactnamesuffix(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_contactnamesuffix(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_contactnamesuffix(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_contactbusinessname(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_contactbusinessname(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_contactbusinessname(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_contactaddressline1(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_contactaddressline1(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_contactaddressline1(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_contactaddressline2(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_contactaddressline2(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_contactaddressline2(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_contactcity(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_contactcity(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_contactcity(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_contactstate(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_contactstate(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_contactstate(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_contactzip(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_contactzip(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_contactzip(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_contactzip4(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_contactzip4(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_contactzip4(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_contactphone(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_contactphone(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_contactphone(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_contactfax(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_contactfax(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_contactfax(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_contactemail(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_contactemail(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_contactemail(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_policyholdernamefirst(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_policyholdernamefirst(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_policyholdernamefirst(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_policyholdernamemiddle(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_policyholdernamemiddle(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_policyholdernamemiddle(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_policyholdernamelast(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_policyholdernamelast(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_policyholdernamelast(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_policyholdernamesuffix(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_policyholdernamesuffix(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_policyholdernamesuffix(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_statepolicyfilenumber(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_statepolicyfilenumber(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_statepolicyfilenumber(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_coverageinjuryillnessdate(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_coverageinjuryillnessdate(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_coverageinjuryillnessdate(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_selfinsurancegroup(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_selfinsurancegroup(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_selfinsurancegroup(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_selfinsurancegroupphone(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_selfinsurancegroupphone(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_selfinsurancegroupphone(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_selfinsurancegroupid(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_selfinsurancegroupid(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_selfinsurancegroupid(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_numberofemployees(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_numberofemployees(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_numberofemployees(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_licensedcontractor(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_licensedcontractor(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_licensedcontractor(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_mconame(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_mconame(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_mconame(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_mconumber(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_mconumber(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_mconumber(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_mcoaddressline1(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_mcoaddressline1(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_mcoaddressline1(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_mcoaddressline2(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_mcoaddressline2(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_mcoaddressline2(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_mcocity(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_mcocity(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_mcocity(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_mcostate(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_mcostate(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_mcostate(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_mcozip(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_mcozip(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_mcozip(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_mcozip4(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_mcozip4(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_mcozip4(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_mcophone(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_mcophone(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_mcophone(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_governingclasscode(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_governingclasscode(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_governingclasscode(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_licensenumber(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_licensenumber(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_licensenumber(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_class(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_class(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_class(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_classificationdescription(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_classificationdescription(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_classificationdescription(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_licensestatus(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_licensestatus(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_licensestatus(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_licenseadditionalinfo(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_licenseadditionalinfo(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_licenseadditionalinfo(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_licenseissuedate(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_licenseissuedate(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_licenseissuedate(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_licenseexpirationdate(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_licenseexpirationdate(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_licenseexpirationdate(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_naicscode(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_naicscode(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_naicscode(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexemptfirstname1(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexemptfirstname1(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexemptfirstname1(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexemptlastname1(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexemptlastname1(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexemptlastname1(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexemptmiddlename1(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexemptmiddlename1(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexemptmiddlename1(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexempttitle1(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexempttitle1(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexempttitle1(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexempteffectivedate1(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexempteffectivedate1(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexempteffectivedate1(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexemptterminationdate1(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexemptterminationdate1(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexemptterminationdate1(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexempttype1(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexempttype1(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexempttype1(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexemptbusinessactivities1(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexemptbusinessactivities1(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexemptbusinessactivities1(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexemptfirstname2(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexemptfirstname2(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexemptfirstname2(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexemptlastname2(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexemptlastname2(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexemptlastname2(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexemptmiddlename2(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexemptmiddlename2(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexemptmiddlename2(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexempttitle2(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexempttitle2(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexempttitle2(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexempteffectivedate2(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexempteffectivedate2(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexempteffectivedate2(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexemptterminationdate2(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexemptterminationdate2(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexemptterminationdate2(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexempttype2(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexempttype2(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexempttype2(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexemptbusinessactivities2(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexemptbusinessactivities2(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexemptbusinessactivities2(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexemptfirstname3(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexemptfirstname3(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexemptfirstname3(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexemptlastname3(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexemptlastname3(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexemptlastname3(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexemptmiddlename3(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexemptmiddlename3(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexemptmiddlename3(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexempttitle3(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexempttitle3(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexempttitle3(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexempteffectivedate3(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexempteffectivedate3(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexempteffectivedate3(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexemptterminationdate3(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexemptterminationdate3(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexemptterminationdate3(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexempttype3(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexempttype3(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexempttype3(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexemptbusinessactivities3(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexemptbusinessactivities3(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexemptbusinessactivities3(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexemptfirstname4(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexemptfirstname4(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexemptfirstname4(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexemptlastname4(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexemptlastname4(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexemptlastname4(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexemptmiddlename4(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexemptmiddlename4(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexemptmiddlename4(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexempttitle4(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexempttitle4(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexempttitle4(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexempteffectivedate4(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexempteffectivedate4(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexempteffectivedate4(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexemptterminationdate4(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexemptterminationdate4(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexemptterminationdate4(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexempttype4(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexempttype4(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexempttype4(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexemptbusinessactivities4(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexemptbusinessactivities4(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexemptbusinessactivities4(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexemptfirstname5(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexemptfirstname5(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexemptfirstname5(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexemptlastname5(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexemptlastname5(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexemptlastname5(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexemptmiddlename5(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexemptmiddlename5(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexemptmiddlename5(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexempttitle5(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexempttitle5(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexempttitle5(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexempteffectivedate5(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexempteffectivedate5(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexempteffectivedate5(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexemptterminationdate5(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexemptterminationdate5(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexemptterminationdate5(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexempttype5(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexempttype5(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexempttype5(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_officerexemptbusinessactivities5(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_officerexemptbusinessactivities5(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_officerexemptbusinessactivities5(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_dba1(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_dba1(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_dba1(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_dbadatefrom1(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_dbadatefrom1(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_dbadatefrom1(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_dbadateto1(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_dbadateto1(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_dbadateto1(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_dbatype1(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_dbatype1(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_dbatype1(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_dba2(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_dba2(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_dba2(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_dbadatefrom2(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_dbadatefrom2(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_dbadatefrom2(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_dbadateto2(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_dbadateto2(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_dbadateto2(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_dbatype2(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_dbatype2(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_dbatype2(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_dba3(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_dba3(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_dba3(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_dbadatefrom3(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_dbadatefrom3(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_dbadatefrom3(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_dbadateto3(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_dbadateto3(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_dbadateto3(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_dbatype3(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_dbatype3(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_dbatype3(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_dba4(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_dba4(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_dba4(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_dbadatefrom4(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_dbadatefrom4(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_dbadatefrom4(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_dbadateto4(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_dbadateto4(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_dbadateto4(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_dbatype4(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_dbatype4(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_dbatype4(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_dba5(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_dba5(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_dba5(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_dbadatefrom5(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_dbadatefrom5(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_dbadatefrom5(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_dbadateto5(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_dbadateto5(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_dbadateto5(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_dbatype5(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_dbatype5(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_dbatype5(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_subsidiaryname1(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_subsidiaryname1(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_subsidiaryname1(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_subsidiarystartdate1(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_subsidiarystartdate1(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_subsidiarystartdate1(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_subsidiaryname2(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_subsidiaryname2(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_subsidiaryname2(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_subsidiarystartdate2(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_subsidiarystartdate2(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_subsidiarystartdate2(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_subsidiaryname3(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_subsidiaryname3(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_subsidiaryname3(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_subsidiarystartdate3(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_subsidiarystartdate3(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_subsidiarystartdate3(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_subsidiaryname4(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_subsidiaryname4(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_subsidiaryname4(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_subsidiarystartdate4(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_subsidiarystartdate4(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_subsidiarystartdate4(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_subsidiaryname5(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_subsidiaryname5(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_subsidiaryname5(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_subsidiarystartdate5(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_subsidiarystartdate5(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_subsidiarystartdate5(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_subsidiaryname6(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_subsidiaryname6(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_subsidiaryname6(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_subsidiarystartdate6(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_subsidiarystartdate6(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_subsidiarystartdate6(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_subsidiaryname7(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_subsidiaryname7(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_subsidiaryname7(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_subsidiarystartdate7(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_subsidiarystartdate7(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_subsidiarystartdate7(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_subsidiaryname8(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_subsidiaryname8(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_subsidiaryname8(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_subsidiarystartdate8(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_subsidiarystartdate8(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_subsidiarystartdate8(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_subsidiaryname9(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_subsidiaryname9(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_subsidiaryname9(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_subsidiarystartdate9(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_subsidiarystartdate9(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_subsidiarystartdate9(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_subsidiaryname10(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_subsidiaryname10(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_subsidiaryname10(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
EXPORT Make_subsidiarystartdate10(SALT311.StrType s0) := MakeFT_Test(s0);
EXPORT InValid_subsidiarystartdate10(SALT311.StrType s) := InValidFT_Test(s);
EXPORT InValidMessage_subsidiarystartdate10(UNSIGNED1 wh) := InValidMessageFT_Test(wh);
 
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
    BOOLEAN Diff_businessname;
    BOOLEAN Diff_dba;
    BOOLEAN Diff_addressline1;
    BOOLEAN Diff_addressline2;
    BOOLEAN Diff_addresscity;
    BOOLEAN Diff_addressstate;
    BOOLEAN Diff_addresszip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_phone1;
    BOOLEAN Diff_phone2;
    BOOLEAN Diff_phone3;
    BOOLEAN Diff_fax1;
    BOOLEAN Diff_fax2;
    BOOLEAN Diff_email1;
    BOOLEAN Diff_email2;
    BOOLEAN Diff_businesstype;
    BOOLEAN Diff_namefirst;
    BOOLEAN Diff_namemiddle;
    BOOLEAN Diff_namelast;
    BOOLEAN Diff_namesuffix;
    BOOLEAN Diff_nametitle;
    BOOLEAN Diff_mailingaddress1;
    BOOLEAN Diff_mailingaddress2;
    BOOLEAN Diff_mailingaddresscity;
    BOOLEAN Diff_mailingaddressstate;
    BOOLEAN Diff_mailingaddresszip;
    BOOLEAN Diff_mailingaddresszip4;
    BOOLEAN Diff_contactnamefirst;
    BOOLEAN Diff_contactnamemiddle;
    BOOLEAN Diff_contactnamelast;
    BOOLEAN Diff_contactnamesuffix;
    BOOLEAN Diff_contactbusinessname;
    BOOLEAN Diff_contactaddressline1;
    BOOLEAN Diff_contactaddressline2;
    BOOLEAN Diff_contactcity;
    BOOLEAN Diff_contactstate;
    BOOLEAN Diff_contactzip;
    BOOLEAN Diff_contactzip4;
    BOOLEAN Diff_contactphone;
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
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
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
    SELF.Diff_businessname := le.businessname <> ri.businessname;
    SELF.Diff_dba := le.dba <> ri.dba;
    SELF.Diff_addressline1 := le.addressline1 <> ri.addressline1;
    SELF.Diff_addressline2 := le.addressline2 <> ri.addressline2;
    SELF.Diff_addresscity := le.addresscity <> ri.addresscity;
    SELF.Diff_addressstate := le.addressstate <> ri.addressstate;
    SELF.Diff_addresszip := le.addresszip <> ri.addresszip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_phone1 := le.phone1 <> ri.phone1;
    SELF.Diff_phone2 := le.phone2 <> ri.phone2;
    SELF.Diff_phone3 := le.phone3 <> ri.phone3;
    SELF.Diff_fax1 := le.fax1 <> ri.fax1;
    SELF.Diff_fax2 := le.fax2 <> ri.fax2;
    SELF.Diff_email1 := le.email1 <> ri.email1;
    SELF.Diff_email2 := le.email2 <> ri.email2;
    SELF.Diff_businesstype := le.businesstype <> ri.businesstype;
    SELF.Diff_namefirst := le.namefirst <> ri.namefirst;
    SELF.Diff_namemiddle := le.namemiddle <> ri.namemiddle;
    SELF.Diff_namelast := le.namelast <> ri.namelast;
    SELF.Diff_namesuffix := le.namesuffix <> ri.namesuffix;
    SELF.Diff_nametitle := le.nametitle <> ri.nametitle;
    SELF.Diff_mailingaddress1 := le.mailingaddress1 <> ri.mailingaddress1;
    SELF.Diff_mailingaddress2 := le.mailingaddress2 <> ri.mailingaddress2;
    SELF.Diff_mailingaddresscity := le.mailingaddresscity <> ri.mailingaddresscity;
    SELF.Diff_mailingaddressstate := le.mailingaddressstate <> ri.mailingaddressstate;
    SELF.Diff_mailingaddresszip := le.mailingaddresszip <> ri.mailingaddresszip;
    SELF.Diff_mailingaddresszip4 := le.mailingaddresszip4 <> ri.mailingaddresszip4;
    SELF.Diff_contactnamefirst := le.contactnamefirst <> ri.contactnamefirst;
    SELF.Diff_contactnamemiddle := le.contactnamemiddle <> ri.contactnamemiddle;
    SELF.Diff_contactnamelast := le.contactnamelast <> ri.contactnamelast;
    SELF.Diff_contactnamesuffix := le.contactnamesuffix <> ri.contactnamesuffix;
    SELF.Diff_contactbusinessname := le.contactbusinessname <> ri.contactbusinessname;
    SELF.Diff_contactaddressline1 := le.contactaddressline1 <> ri.contactaddressline1;
    SELF.Diff_contactaddressline2 := le.contactaddressline2 <> ri.contactaddressline2;
    SELF.Diff_contactcity := le.contactcity <> ri.contactcity;
    SELF.Diff_contactstate := le.contactstate <> ri.contactstate;
    SELF.Diff_contactzip := le.contactzip <> ri.contactzip;
    SELF.Diff_contactzip4 := le.contactzip4 <> ri.contactzip4;
    SELF.Diff_contactphone := le.contactphone <> ri.contactphone;
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
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dartid,1,0)+ IF( SELF.Diff_dateadded,1,0)+ IF( SELF.Diff_dateupdated,1,0)+ IF( SELF.Diff_website,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_lninscertrecordid,1,0)+ IF( SELF.Diff_profilelastupdated,1,0)+ IF( SELF.Diff_siid,1,0)+ IF( SELF.Diff_sipstatuscode,1,0)+ IF( SELF.Diff_wcbempnumber,1,0)+ IF( SELF.Diff_ubinumber,1,0)+ IF( SELF.Diff_cofanumber,1,0)+ IF( SELF.Diff_usdotnumber,1,0)+ IF( SELF.Diff_businessname,1,0)+ IF( SELF.Diff_dba,1,0)+ IF( SELF.Diff_addressline1,1,0)+ IF( SELF.Diff_addressline2,1,0)+ IF( SELF.Diff_addresscity,1,0)+ IF( SELF.Diff_addressstate,1,0)+ IF( SELF.Diff_addresszip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_phone1,1,0)+ IF( SELF.Diff_phone2,1,0)+ IF( SELF.Diff_phone3,1,0)+ IF( SELF.Diff_fax1,1,0)+ IF( SELF.Diff_fax2,1,0)+ IF( SELF.Diff_email1,1,0)+ IF( SELF.Diff_email2,1,0)+ IF( SELF.Diff_businesstype,1,0)+ IF( SELF.Diff_namefirst,1,0)+ IF( SELF.Diff_namemiddle,1,0)+ IF( SELF.Diff_namelast,1,0)+ IF( SELF.Diff_namesuffix,1,0)+ IF( SELF.Diff_nametitle,1,0)+ IF( SELF.Diff_mailingaddress1,1,0)+ IF( SELF.Diff_mailingaddress2,1,0)+ IF( SELF.Diff_mailingaddresscity,1,0)+ IF( SELF.Diff_mailingaddressstate,1,0)+ IF( SELF.Diff_mailingaddresszip,1,0)+ IF( SELF.Diff_mailingaddresszip4,1,0)+ IF( SELF.Diff_contactnamefirst,1,0)+ IF( SELF.Diff_contactnamemiddle,1,0)+ IF( SELF.Diff_contactnamelast,1,0)+ IF( SELF.Diff_contactnamesuffix,1,0)+ IF( SELF.Diff_contactbusinessname,1,0)+ IF( SELF.Diff_contactaddressline1,1,0)+ IF( SELF.Diff_contactaddressline2,1,0)+ IF( SELF.Diff_contactcity,1,0)+ IF( SELF.Diff_contactstate,1,0)+ IF( SELF.Diff_contactzip,1,0)+ IF( SELF.Diff_contactzip4,1,0)+ IF( SELF.Diff_contactphone,1,0)+ IF( SELF.Diff_contactfax,1,0)+ IF( SELF.Diff_contactemail,1,0)+ IF( SELF.Diff_policyholdernamefirst,1,0)+ IF( SELF.Diff_policyholdernamemiddle,1,0)+ IF( SELF.Diff_policyholdernamelast,1,0)+ IF( SELF.Diff_policyholdernamesuffix,1,0)+ IF( SELF.Diff_statepolicyfilenumber,1,0)+ IF( SELF.Diff_coverageinjuryillnessdate,1,0)+ IF( SELF.Diff_selfinsurancegroup,1,0)+ IF( SELF.Diff_selfinsurancegroupphone,1,0)+ IF( SELF.Diff_selfinsurancegroupid,1,0)+ IF( SELF.Diff_numberofemployees,1,0)+ IF( SELF.Diff_licensedcontractor,1,0)+ IF( SELF.Diff_mconame,1,0)+ IF( SELF.Diff_mconumber,1,0)+ IF( SELF.Diff_mcoaddressline1,1,0)+ IF( SELF.Diff_mcoaddressline2,1,0)+ IF( SELF.Diff_mcocity,1,0)+ IF( SELF.Diff_mcostate,1,0)+ IF( SELF.Diff_mcozip,1,0)+ IF( SELF.Diff_mcozip4,1,0)+ IF( SELF.Diff_mcophone,1,0)+ IF( SELF.Diff_governingclasscode,1,0)+ IF( SELF.Diff_licensenumber,1,0)+ IF( SELF.Diff_class,1,0)+ IF( SELF.Diff_classificationdescription,1,0)+ IF( SELF.Diff_licensestatus,1,0)+ IF( SELF.Diff_licenseadditionalinfo,1,0)+ IF( SELF.Diff_licenseissuedate,1,0)+ IF( SELF.Diff_licenseexpirationdate,1,0)+ IF( SELF.Diff_naicscode,1,0)+ IF( SELF.Diff_officerexemptfirstname1,1,0)+ IF( SELF.Diff_officerexemptlastname1,1,0)+ IF( SELF.Diff_officerexemptmiddlename1,1,0)+ IF( SELF.Diff_officerexempttitle1,1,0)+ IF( SELF.Diff_officerexempteffectivedate1,1,0)+ IF( SELF.Diff_officerexemptterminationdate1,1,0)+ IF( SELF.Diff_officerexempttype1,1,0)+ IF( SELF.Diff_officerexemptbusinessactivities1,1,0)+ IF( SELF.Diff_officerexemptfirstname2,1,0)+ IF( SELF.Diff_officerexemptlastname2,1,0)+ IF( SELF.Diff_officerexemptmiddlename2,1,0)+ IF( SELF.Diff_officerexempttitle2,1,0)+ IF( SELF.Diff_officerexempteffectivedate2,1,0)+ IF( SELF.Diff_officerexemptterminationdate2,1,0)+ IF( SELF.Diff_officerexempttype2,1,0)+ IF( SELF.Diff_officerexemptbusinessactivities2,1,0)+ IF( SELF.Diff_officerexemptfirstname3,1,0)+ IF( SELF.Diff_officerexemptlastname3,1,0)+ IF( SELF.Diff_officerexemptmiddlename3,1,0)+ IF( SELF.Diff_officerexempttitle3,1,0)+ IF( SELF.Diff_officerexempteffectivedate3,1,0)+ IF( SELF.Diff_officerexemptterminationdate3,1,0)+ IF( SELF.Diff_officerexempttype3,1,0)+ IF( SELF.Diff_officerexemptbusinessactivities3,1,0)+ IF( SELF.Diff_officerexemptfirstname4,1,0)+ IF( SELF.Diff_officerexemptlastname4,1,0)+ IF( SELF.Diff_officerexemptmiddlename4,1,0)+ IF( SELF.Diff_officerexempttitle4,1,0)+ IF( SELF.Diff_officerexempteffectivedate4,1,0)+ IF( SELF.Diff_officerexemptterminationdate4,1,0)+ IF( SELF.Diff_officerexempttype4,1,0)+ IF( SELF.Diff_officerexemptbusinessactivities4,1,0)+ IF( SELF.Diff_officerexemptfirstname5,1,0)+ IF( SELF.Diff_officerexemptlastname5,1,0)+ IF( SELF.Diff_officerexemptmiddlename5,1,0)+ IF( SELF.Diff_officerexempttitle5,1,0)+ IF( SELF.Diff_officerexempteffectivedate5,1,0)+ IF( SELF.Diff_officerexemptterminationdate5,1,0)+ IF( SELF.Diff_officerexempttype5,1,0)+ IF( SELF.Diff_officerexemptbusinessactivities5,1,0)+ IF( SELF.Diff_dba1,1,0)+ IF( SELF.Diff_dbadatefrom1,1,0)+ IF( SELF.Diff_dbadateto1,1,0)+ IF( SELF.Diff_dbatype1,1,0)+ IF( SELF.Diff_dba2,1,0)+ IF( SELF.Diff_dbadatefrom2,1,0)+ IF( SELF.Diff_dbadateto2,1,0)+ IF( SELF.Diff_dbatype2,1,0)+ IF( SELF.Diff_dba3,1,0)+ IF( SELF.Diff_dbadatefrom3,1,0)+ IF( SELF.Diff_dbadateto3,1,0)+ IF( SELF.Diff_dbatype3,1,0)+ IF( SELF.Diff_dba4,1,0)+ IF( SELF.Diff_dbadatefrom4,1,0)+ IF( SELF.Diff_dbadateto4,1,0)+ IF( SELF.Diff_dbatype4,1,0)+ IF( SELF.Diff_dba5,1,0)+ IF( SELF.Diff_dbadatefrom5,1,0)+ IF( SELF.Diff_dbadateto5,1,0)+ IF( SELF.Diff_dbatype5,1,0)+ IF( SELF.Diff_subsidiaryname1,1,0)+ IF( SELF.Diff_subsidiarystartdate1,1,0)+ IF( SELF.Diff_subsidiaryname2,1,0)+ IF( SELF.Diff_subsidiarystartdate2,1,0)+ IF( SELF.Diff_subsidiaryname3,1,0)+ IF( SELF.Diff_subsidiarystartdate3,1,0)+ IF( SELF.Diff_subsidiaryname4,1,0)+ IF( SELF.Diff_subsidiarystartdate4,1,0)+ IF( SELF.Diff_subsidiaryname5,1,0)+ IF( SELF.Diff_subsidiarystartdate5,1,0)+ IF( SELF.Diff_subsidiaryname6,1,0)+ IF( SELF.Diff_subsidiarystartdate6,1,0)+ IF( SELF.Diff_subsidiaryname7,1,0)+ IF( SELF.Diff_subsidiarystartdate7,1,0)+ IF( SELF.Diff_subsidiaryname8,1,0)+ IF( SELF.Diff_subsidiarystartdate8,1,0)+ IF( SELF.Diff_subsidiaryname9,1,0)+ IF( SELF.Diff_subsidiarystartdate9,1,0)+ IF( SELF.Diff_subsidiaryname10,1,0)+ IF( SELF.Diff_subsidiarystartdate10,1,0);
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
    Count_Diff_businessname := COUNT(GROUP,%Closest%.Diff_businessname);
    Count_Diff_dba := COUNT(GROUP,%Closest%.Diff_dba);
    Count_Diff_addressline1 := COUNT(GROUP,%Closest%.Diff_addressline1);
    Count_Diff_addressline2 := COUNT(GROUP,%Closest%.Diff_addressline2);
    Count_Diff_addresscity := COUNT(GROUP,%Closest%.Diff_addresscity);
    Count_Diff_addressstate := COUNT(GROUP,%Closest%.Diff_addressstate);
    Count_Diff_addresszip := COUNT(GROUP,%Closest%.Diff_addresszip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_phone1 := COUNT(GROUP,%Closest%.Diff_phone1);
    Count_Diff_phone2 := COUNT(GROUP,%Closest%.Diff_phone2);
    Count_Diff_phone3 := COUNT(GROUP,%Closest%.Diff_phone3);
    Count_Diff_fax1 := COUNT(GROUP,%Closest%.Diff_fax1);
    Count_Diff_fax2 := COUNT(GROUP,%Closest%.Diff_fax2);
    Count_Diff_email1 := COUNT(GROUP,%Closest%.Diff_email1);
    Count_Diff_email2 := COUNT(GROUP,%Closest%.Diff_email2);
    Count_Diff_businesstype := COUNT(GROUP,%Closest%.Diff_businesstype);
    Count_Diff_namefirst := COUNT(GROUP,%Closest%.Diff_namefirst);
    Count_Diff_namemiddle := COUNT(GROUP,%Closest%.Diff_namemiddle);
    Count_Diff_namelast := COUNT(GROUP,%Closest%.Diff_namelast);
    Count_Diff_namesuffix := COUNT(GROUP,%Closest%.Diff_namesuffix);
    Count_Diff_nametitle := COUNT(GROUP,%Closest%.Diff_nametitle);
    Count_Diff_mailingaddress1 := COUNT(GROUP,%Closest%.Diff_mailingaddress1);
    Count_Diff_mailingaddress2 := COUNT(GROUP,%Closest%.Diff_mailingaddress2);
    Count_Diff_mailingaddresscity := COUNT(GROUP,%Closest%.Diff_mailingaddresscity);
    Count_Diff_mailingaddressstate := COUNT(GROUP,%Closest%.Diff_mailingaddressstate);
    Count_Diff_mailingaddresszip := COUNT(GROUP,%Closest%.Diff_mailingaddresszip);
    Count_Diff_mailingaddresszip4 := COUNT(GROUP,%Closest%.Diff_mailingaddresszip4);
    Count_Diff_contactnamefirst := COUNT(GROUP,%Closest%.Diff_contactnamefirst);
    Count_Diff_contactnamemiddle := COUNT(GROUP,%Closest%.Diff_contactnamemiddle);
    Count_Diff_contactnamelast := COUNT(GROUP,%Closest%.Diff_contactnamelast);
    Count_Diff_contactnamesuffix := COUNT(GROUP,%Closest%.Diff_contactnamesuffix);
    Count_Diff_contactbusinessname := COUNT(GROUP,%Closest%.Diff_contactbusinessname);
    Count_Diff_contactaddressline1 := COUNT(GROUP,%Closest%.Diff_contactaddressline1);
    Count_Diff_contactaddressline2 := COUNT(GROUP,%Closest%.Diff_contactaddressline2);
    Count_Diff_contactcity := COUNT(GROUP,%Closest%.Diff_contactcity);
    Count_Diff_contactstate := COUNT(GROUP,%Closest%.Diff_contactstate);
    Count_Diff_contactzip := COUNT(GROUP,%Closest%.Diff_contactzip);
    Count_Diff_contactzip4 := COUNT(GROUP,%Closest%.Diff_contactzip4);
    Count_Diff_contactphone := COUNT(GROUP,%Closest%.Diff_contactphone);
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
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
