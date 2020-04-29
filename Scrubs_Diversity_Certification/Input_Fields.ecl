IMPORT SALT311;
IMPORT Scrubs_Diversity_Certification,scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_Fields := MODULE
 
EXPORT NumFields := 204;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_No','Invalid_Float','Invalid_Alpha','Invalid_AlphaNum','Invalid_AlphaChar','Invalid_AlphaNumChar','Invalid_Date','Invalid_Future','Invalid_State','Invalid_Zip','Invalid_Phone','Invalid_NAICS','Invalid_Commodity','Invalid_Sic');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_No' => 1,'Invalid_Float' => 2,'Invalid_Alpha' => 3,'Invalid_AlphaNum' => 4,'Invalid_AlphaChar' => 5,'Invalid_AlphaNumChar' => 6,'Invalid_Date' => 7,'Invalid_Future' => 8,'Invalid_State' => 9,'Invalid_Zip' => 10,'Invalid_Phone' => 11,'Invalid_NAICS' => 12,'Invalid_Commodity' => 13,'Invalid_Sic' => 14,0);
 
EXPORT MakeFT_Invalid_No(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_No(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_No(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Float(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 .,-/+E$'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Float(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 .,-/+E$'))));
EXPORT InValidMessageFT_Invalid_Float(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 .,-/+E$'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ '))));
EXPORT InValidMessageFT_Invalid_Alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNum(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNum(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ '))));
EXPORT InValidMessageFT_Invalid_AlphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaChar(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ _,.\'-:;/&#@()'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaChar(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ _,.\'-:;/&#@()'))));
EXPORT InValidMessageFT_Invalid_AlphaChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ _,.\'-:;/&#@()'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNumChar(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ _,.\'-:;/&#@()'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNumChar(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ _,.\'-:;/&#@()'))));
EXPORT InValidMessageFT_Invalid_AlphaNumChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ _,.\'-:;/&#@()'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Scrubs_Diversity_Certification.Functions.fn_valid_Date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Diversity_Certification.Functions.fn_valid_Date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Future(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Future(SALT311.StrType s) := WHICH(~Scrubs_Diversity_Certification.Functions.fn_valid_Date(s,'Future')>0);
EXPORT InValidMessageFT_Invalid_Future(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Diversity_Certification.Functions.fn_valid_Date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_State(SALT311.StrType s) := WHICH(~scrubs.functions.fn_Valid_StateAbbrev(s)>0);
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('scrubs.functions.fn_Valid_StateAbbrev'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 .,-/+E$'); // Only allow valid symbols
  RETURN  MakeFT_Invalid_Float(s1);
END;
EXPORT InValidFT_Invalid_Zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 .,-/+E$'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_Invalid_Zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 .,-/+E$'),SALT311.HygieneErrors.NotLength('0,5,9,10'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Phone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Phone(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_verify_optional_phone(s)>0);
EXPORT InValidMessageFT_Invalid_Phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_verify_optional_phone'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_NAICS(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_NAICS(SALT311.StrType s) := WHICH(~Scrubs_Diversity_Certification.Functions.fn_valid_naics(s)>0);
EXPORT InValidMessageFT_Invalid_NAICS(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Diversity_Certification.Functions.fn_valid_naics'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Commodity(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Commodity(SALT311.StrType s) := WHICH(~Scrubs_Diversity_Certification.Functions.fn_valid_Commodity(s)>0);
EXPORT InValidMessageFT_Invalid_Commodity(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Diversity_Certification.Functions.fn_valid_Commodity'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Sic(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Sic(SALT311.StrType s) := WHICH(~Scrubs_Diversity_Certification.Functions.fn_valid_Sic(s)>0);
EXPORT InValidMessageFT_Invalid_Sic(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Diversity_Certification.Functions.fn_valid_Sic'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dartid','dateadded','dateupdated','website','state','profilelastupdated','county','servicearea','region1','region2','region3','region4','region5','fname','lname','mname','suffix','title','ethnicity','gender','address1','address2','addresscity','addressstate','addresszipcode','addresszip4','building','contact','phone1','phone2','phone3','cell','fax','email1','email2','email3','webpage1','webpage2','webpage3','businessname','dba','businessid','businesstype1','businesslocation1','businesstype2','businesslocation2','businesstype3','businesslocation3','businesstype4','businesslocation4','businesstype5','businesslocation5','industry','trade','resourcedescription','natureofbusiness','businessstructure','totalemployees','avgcontractsize','firmid','firmlocationaddress','firmlocationaddresscity','firmlocationaddresszip4','firmlocationaddresszipcode','firmlocationcounty','firmlocationstate','certfed','certstate','contractsfederal','contractsva','contractscommercial','contractorgovernmentprime','contractorgovernmentsub','contractornongovernment','registeredgovernmentbus','registerednongovernmentbus','clearancelevelpersonnel','clearancelevelfacility','certificatedatefrom1','certificatedateto1','certificatestatus1','certificationnumber1','certificationtype1','certificatedatefrom2','certificatedateto2','certificatestatus2','certificationnumber2','certificationtype2','certificatedatefrom3','certificatedateto3','certificatestatus3','certificationnumber3','certificationtype3','certificatedatefrom4','certificatedateto4','certificatestatus4','certificationnumber4','certificationtype4','certificatedatefrom5','certificatedateto5','certificatestatus5','certificationnumber5','certificationtype5','certificatedatefrom6','certificatedateto6','certificatestatus6','certificationnumber6','certificationtype6','starrating','assets','biddescription','competitiveadvantage','cagecode','capabilitiesnarrative','category','chtrclass','productdescription1','productdescription2','productdescription3','productdescription4','productdescription5','classdescription1','subclassdescription1','classdescription2','subclassdescription2','classdescription3','subclassdescription3','classdescription4','subclassdescription4','classdescription5','subclassdescription5','classifications','commodity1','commodity2','commodity3','commodity4','commodity5','commodity6','commodity7','commodity8','completedate','crossreference','dateestablished','businessage','deposits','dunsnumber','enttype','expirationdate','extendeddate','issuingauthority','keywords','licensenumber','licensetype','mincd','minorityaffiliation','minorityownershipdate','siccode1','siccode2','siccode3','siccode4','siccode5','siccode6','siccode7','siccode8','naicscode1','naicscode2','naicscode3','naicscode4','naicscode5','naicscode6','naicscode7','naicscode8','prequalify','procurementcategory1','subprocurementcategory1','procurementcategory2','subprocurementcategory2','procurementcategory3','subprocurementcategory3','procurementcategory4','subprocurementcategory4','procurementcategory5','subprocurementcategory5','renewal','renewaldate','unitedcertprogrampartner','vendorkey','vendornumber','workcode1','workcode2','workcode3','workcode4','workcode5','workcode6','workcode7','workcode8','exporter','exportbusinessactivities','exportto','exportbusinessrelationships','exportobjectives','reference1','reference2','reference3');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dartid','dateadded','dateupdated','website','state','profilelastupdated','county','servicearea','region1','region2','region3','region4','region5','fname','lname','mname','suffix','title','ethnicity','gender','address1','address2','addresscity','addressstate','addresszipcode','addresszip4','building','contact','phone1','phone2','phone3','cell','fax','email1','email2','email3','webpage1','webpage2','webpage3','businessname','dba','businessid','businesstype1','businesslocation1','businesstype2','businesslocation2','businesstype3','businesslocation3','businesstype4','businesslocation4','businesstype5','businesslocation5','industry','trade','resourcedescription','natureofbusiness','businessstructure','totalemployees','avgcontractsize','firmid','firmlocationaddress','firmlocationaddresscity','firmlocationaddresszip4','firmlocationaddresszipcode','firmlocationcounty','firmlocationstate','certfed','certstate','contractsfederal','contractsva','contractscommercial','contractorgovernmentprime','contractorgovernmentsub','contractornongovernment','registeredgovernmentbus','registerednongovernmentbus','clearancelevelpersonnel','clearancelevelfacility','certificatedatefrom1','certificatedateto1','certificatestatus1','certificationnumber1','certificationtype1','certificatedatefrom2','certificatedateto2','certificatestatus2','certificationnumber2','certificationtype2','certificatedatefrom3','certificatedateto3','certificatestatus3','certificationnumber3','certificationtype3','certificatedatefrom4','certificatedateto4','certificatestatus4','certificationnumber4','certificationtype4','certificatedatefrom5','certificatedateto5','certificatestatus5','certificationnumber5','certificationtype5','certificatedatefrom6','certificatedateto6','certificatestatus6','certificationnumber6','certificationtype6','starrating','assets','biddescription','competitiveadvantage','cagecode','capabilitiesnarrative','category','chtrclass','productdescription1','productdescription2','productdescription3','productdescription4','productdescription5','classdescription1','subclassdescription1','classdescription2','subclassdescription2','classdescription3','subclassdescription3','classdescription4','subclassdescription4','classdescription5','subclassdescription5','classifications','commodity1','commodity2','commodity3','commodity4','commodity5','commodity6','commodity7','commodity8','completedate','crossreference','dateestablished','businessage','deposits','dunsnumber','enttype','expirationdate','extendeddate','issuingauthority','keywords','licensenumber','licensetype','mincd','minorityaffiliation','minorityownershipdate','siccode1','siccode2','siccode3','siccode4','siccode5','siccode6','siccode7','siccode8','naicscode1','naicscode2','naicscode3','naicscode4','naicscode5','naicscode6','naicscode7','naicscode8','prequalify','procurementcategory1','subprocurementcategory1','procurementcategory2','subprocurementcategory2','procurementcategory3','subprocurementcategory3','procurementcategory4','subprocurementcategory4','procurementcategory5','subprocurementcategory5','renewal','renewaldate','unitedcertprogrampartner','vendorkey','vendornumber','workcode1','workcode2','workcode3','workcode4','workcode5','workcode6','workcode7','workcode8','exporter','exportbusinessactivities','exportto','exportbusinessrelationships','exportobjectives','reference1','reference2','reference3');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'dartid' => 0,'dateadded' => 1,'dateupdated' => 2,'website' => 3,'state' => 4,'profilelastupdated' => 5,'county' => 6,'servicearea' => 7,'region1' => 8,'region2' => 9,'region3' => 10,'region4' => 11,'region5' => 12,'fname' => 13,'lname' => 14,'mname' => 15,'suffix' => 16,'title' => 17,'ethnicity' => 18,'gender' => 19,'address1' => 20,'address2' => 21,'addresscity' => 22,'addressstate' => 23,'addresszipcode' => 24,'addresszip4' => 25,'building' => 26,'contact' => 27,'phone1' => 28,'phone2' => 29,'phone3' => 30,'cell' => 31,'fax' => 32,'email1' => 33,'email2' => 34,'email3' => 35,'webpage1' => 36,'webpage2' => 37,'webpage3' => 38,'businessname' => 39,'dba' => 40,'businessid' => 41,'businesstype1' => 42,'businesslocation1' => 43,'businesstype2' => 44,'businesslocation2' => 45,'businesstype3' => 46,'businesslocation3' => 47,'businesstype4' => 48,'businesslocation4' => 49,'businesstype5' => 50,'businesslocation5' => 51,'industry' => 52,'trade' => 53,'resourcedescription' => 54,'natureofbusiness' => 55,'businessstructure' => 56,'totalemployees' => 57,'avgcontractsize' => 58,'firmid' => 59,'firmlocationaddress' => 60,'firmlocationaddresscity' => 61,'firmlocationaddresszip4' => 62,'firmlocationaddresszipcode' => 63,'firmlocationcounty' => 64,'firmlocationstate' => 65,'certfed' => 66,'certstate' => 67,'contractsfederal' => 68,'contractsva' => 69,'contractscommercial' => 70,'contractorgovernmentprime' => 71,'contractorgovernmentsub' => 72,'contractornongovernment' => 73,'registeredgovernmentbus' => 74,'registerednongovernmentbus' => 75,'clearancelevelpersonnel' => 76,'clearancelevelfacility' => 77,'certificatedatefrom1' => 78,'certificatedateto1' => 79,'certificatestatus1' => 80,'certificationnumber1' => 81,'certificationtype1' => 82,'certificatedatefrom2' => 83,'certificatedateto2' => 84,'certificatestatus2' => 85,'certificationnumber2' => 86,'certificationtype2' => 87,'certificatedatefrom3' => 88,'certificatedateto3' => 89,'certificatestatus3' => 90,'certificationnumber3' => 91,'certificationtype3' => 92,'certificatedatefrom4' => 93,'certificatedateto4' => 94,'certificatestatus4' => 95,'certificationnumber4' => 96,'certificationtype4' => 97,'certificatedatefrom5' => 98,'certificatedateto5' => 99,'certificatestatus5' => 100,'certificationnumber5' => 101,'certificationtype5' => 102,'certificatedatefrom6' => 103,'certificatedateto6' => 104,'certificatestatus6' => 105,'certificationnumber6' => 106,'certificationtype6' => 107,'starrating' => 108,'assets' => 109,'biddescription' => 110,'competitiveadvantage' => 111,'cagecode' => 112,'capabilitiesnarrative' => 113,'category' => 114,'chtrclass' => 115,'productdescription1' => 116,'productdescription2' => 117,'productdescription3' => 118,'productdescription4' => 119,'productdescription5' => 120,'classdescription1' => 121,'subclassdescription1' => 122,'classdescription2' => 123,'subclassdescription2' => 124,'classdescription3' => 125,'subclassdescription3' => 126,'classdescription4' => 127,'subclassdescription4' => 128,'classdescription5' => 129,'subclassdescription5' => 130,'classifications' => 131,'commodity1' => 132,'commodity2' => 133,'commodity3' => 134,'commodity4' => 135,'commodity5' => 136,'commodity6' => 137,'commodity7' => 138,'commodity8' => 139,'completedate' => 140,'crossreference' => 141,'dateestablished' => 142,'businessage' => 143,'deposits' => 144,'dunsnumber' => 145,'enttype' => 146,'expirationdate' => 147,'extendeddate' => 148,'issuingauthority' => 149,'keywords' => 150,'licensenumber' => 151,'licensetype' => 152,'mincd' => 153,'minorityaffiliation' => 154,'minorityownershipdate' => 155,'siccode1' => 156,'siccode2' => 157,'siccode3' => 158,'siccode4' => 159,'siccode5' => 160,'siccode6' => 161,'siccode7' => 162,'siccode8' => 163,'naicscode1' => 164,'naicscode2' => 165,'naicscode3' => 166,'naicscode4' => 167,'naicscode5' => 168,'naicscode6' => 169,'naicscode7' => 170,'naicscode8' => 171,'prequalify' => 172,'procurementcategory1' => 173,'subprocurementcategory1' => 174,'procurementcategory2' => 175,'subprocurementcategory2' => 176,'procurementcategory3' => 177,'subprocurementcategory3' => 178,'procurementcategory4' => 179,'subprocurementcategory4' => 180,'procurementcategory5' => 181,'subprocurementcategory5' => 182,'renewal' => 183,'renewaldate' => 184,'unitedcertprogrampartner' => 185,'vendorkey' => 186,'vendornumber' => 187,'workcode1' => 188,'workcode2' => 189,'workcode3' => 190,'workcode4' => 191,'workcode5' => 192,'workcode6' => 193,'workcode7' => 194,'workcode8' => 195,'exporter' => 196,'exportbusinessactivities' => 197,'exportto' => 198,'exportbusinessrelationships' => 199,'exportobjectives' => 200,'reference1' => 201,'reference2' => 202,'reference3' => 203,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW'],['CUSTOM'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_dartid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_dartid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_dartid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_dateadded(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dateadded(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dateadded(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dateupdated(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dateupdated(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dateupdated(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_website(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_website(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_website(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_profilelastupdated(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_profilelastupdated(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_profilelastupdated(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_county(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_county(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_county(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_servicearea(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_servicearea(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_servicearea(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_region1(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_region1(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_region1(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_region2(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_region2(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_region2(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_region3(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_region3(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_region3(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_region4(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_region4(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_region4(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_region5(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_region5(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_region5(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_fname(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_fname(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_lname(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_lname(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_mname(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_mname(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_suffix(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_suffix(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_title(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_title(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_title(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_ethnicity(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_ethnicity(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_ethnicity(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_gender(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_gender(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_gender(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_address1(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_address1(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_address1(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_address2(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_address2(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_address2(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_addresscity(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_addresscity(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_addresscity(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_addressstate(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_addressstate(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_addressstate(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_addresszipcode(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_addresszipcode(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_addresszipcode(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_addresszip4(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_addresszip4(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_addresszip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_building(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_building(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_building(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_contact(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_contact(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_contact(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_phone1(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_phone1(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_phone1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_phone2(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_phone2(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_phone2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_phone3(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_phone3(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_phone3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_cell(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_cell(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_cell(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_fax(SALT311.StrType s0) := MakeFT_Invalid_Phone(s0);
EXPORT InValid_fax(SALT311.StrType s) := InValidFT_Invalid_Phone(s);
EXPORT InValidMessage_fax(UNSIGNED1 wh) := InValidMessageFT_Invalid_Phone(wh);
 
EXPORT Make_email1(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_email1(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_email1(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_email2(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_email2(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_email2(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_email3(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_email3(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_email3(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_webpage1(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_webpage1(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_webpage1(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_webpage2(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_webpage2(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_webpage2(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_webpage3(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_webpage3(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_webpage3(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_businessname(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_businessname(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_businessname(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_dba(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_dba(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_dba(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_businessid(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_businessid(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_businessid(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_businesstype1(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_businesstype1(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_businesstype1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_businesslocation1(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_businesslocation1(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_businesslocation1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_businesstype2(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_businesstype2(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_businesstype2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_businesslocation2(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_businesslocation2(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_businesslocation2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_businesstype3(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_businesstype3(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_businesstype3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_businesslocation3(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_businesslocation3(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_businesslocation3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_businesstype4(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_businesstype4(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_businesstype4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_businesslocation4(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_businesslocation4(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_businesslocation4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_businesstype5(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_businesstype5(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_businesstype5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_businesslocation5(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_businesslocation5(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_businesslocation5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_industry(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_industry(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_industry(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_trade(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_trade(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_trade(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_resourcedescription(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_resourcedescription(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_resourcedescription(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_natureofbusiness(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_natureofbusiness(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_natureofbusiness(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_businessstructure(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_businessstructure(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_businessstructure(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_totalemployees(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_totalemployees(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_totalemployees(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_avgcontractsize(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_avgcontractsize(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_avgcontractsize(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_firmid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_firmid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_firmid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_firmlocationaddress(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_firmlocationaddress(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_firmlocationaddress(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_firmlocationaddresscity(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_firmlocationaddresscity(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_firmlocationaddresscity(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_firmlocationaddresszip4(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_firmlocationaddresszip4(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_firmlocationaddresszip4(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_firmlocationaddresszipcode(SALT311.StrType s0) := MakeFT_Invalid_Zip(s0);
EXPORT InValid_firmlocationaddresszipcode(SALT311.StrType s) := InValidFT_Invalid_Zip(s);
EXPORT InValidMessage_firmlocationaddresszipcode(UNSIGNED1 wh) := InValidMessageFT_Invalid_Zip(wh);
 
EXPORT Make_firmlocationcounty(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_firmlocationcounty(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_firmlocationcounty(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_firmlocationstate(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_firmlocationstate(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_firmlocationstate(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_certfed(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_certfed(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_certfed(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_certstate(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_certstate(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_certstate(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_contractsfederal(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_contractsfederal(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_contractsfederal(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_contractsva(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_contractsva(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_contractsva(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_contractscommercial(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_contractscommercial(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_contractscommercial(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_contractorgovernmentprime(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_contractorgovernmentprime(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_contractorgovernmentprime(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_contractorgovernmentsub(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_contractorgovernmentsub(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_contractorgovernmentsub(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_contractornongovernment(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_contractornongovernment(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_contractornongovernment(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_registeredgovernmentbus(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_registeredgovernmentbus(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_registeredgovernmentbus(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_registerednongovernmentbus(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_registerednongovernmentbus(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_registerednongovernmentbus(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_clearancelevelpersonnel(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_clearancelevelpersonnel(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_clearancelevelpersonnel(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_clearancelevelfacility(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_clearancelevelfacility(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_clearancelevelfacility(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_certificatedatefrom1(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_certificatedatefrom1(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_certificatedatefrom1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_certificatedateto1(SALT311.StrType s0) := MakeFT_Invalid_Future(s0);
EXPORT InValid_certificatedateto1(SALT311.StrType s) := InValidFT_Invalid_Future(s);
EXPORT InValidMessage_certificatedateto1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future(wh);
 
EXPORT Make_certificatestatus1(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_certificatestatus1(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_certificatestatus1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_certificationnumber1(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_certificationnumber1(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_certificationnumber1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_certificationtype1(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_certificationtype1(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_certificationtype1(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_certificatedatefrom2(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_certificatedatefrom2(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_certificatedatefrom2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_certificatedateto2(SALT311.StrType s0) := MakeFT_Invalid_Future(s0);
EXPORT InValid_certificatedateto2(SALT311.StrType s) := InValidFT_Invalid_Future(s);
EXPORT InValidMessage_certificatedateto2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future(wh);
 
EXPORT Make_certificatestatus2(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_certificatestatus2(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_certificatestatus2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_certificationnumber2(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_certificationnumber2(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_certificationnumber2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_certificationtype2(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_certificationtype2(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_certificationtype2(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_certificatedatefrom3(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_certificatedatefrom3(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_certificatedatefrom3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_certificatedateto3(SALT311.StrType s0) := MakeFT_Invalid_Future(s0);
EXPORT InValid_certificatedateto3(SALT311.StrType s) := InValidFT_Invalid_Future(s);
EXPORT InValidMessage_certificatedateto3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future(wh);
 
EXPORT Make_certificatestatus3(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_certificatestatus3(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_certificatestatus3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_certificationnumber3(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_certificationnumber3(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_certificationnumber3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_certificationtype3(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_certificationtype3(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_certificationtype3(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_certificatedatefrom4(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_certificatedatefrom4(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_certificatedatefrom4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_certificatedateto4(SALT311.StrType s0) := MakeFT_Invalid_Future(s0);
EXPORT InValid_certificatedateto4(SALT311.StrType s) := InValidFT_Invalid_Future(s);
EXPORT InValidMessage_certificatedateto4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future(wh);
 
EXPORT Make_certificatestatus4(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_certificatestatus4(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_certificatestatus4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_certificationnumber4(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_certificationnumber4(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_certificationnumber4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_certificationtype4(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_certificationtype4(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_certificationtype4(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_certificatedatefrom5(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_certificatedatefrom5(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_certificatedatefrom5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_certificatedateto5(SALT311.StrType s0) := MakeFT_Invalid_Future(s0);
EXPORT InValid_certificatedateto5(SALT311.StrType s) := InValidFT_Invalid_Future(s);
EXPORT InValidMessage_certificatedateto5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future(wh);
 
EXPORT Make_certificatestatus5(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_certificatestatus5(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_certificatestatus5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_certificationnumber5(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_certificationnumber5(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_certificationnumber5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_certificationtype5(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_certificationtype5(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_certificationtype5(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_certificatedatefrom6(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_certificatedatefrom6(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_certificatedatefrom6(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_certificatedateto6(SALT311.StrType s0) := MakeFT_Invalid_Future(s0);
EXPORT InValid_certificatedateto6(SALT311.StrType s) := InValidFT_Invalid_Future(s);
EXPORT InValidMessage_certificatedateto6(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future(wh);
 
EXPORT Make_certificatestatus6(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_certificatestatus6(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_certificatestatus6(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_certificationnumber6(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_certificationnumber6(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_certificationnumber6(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_certificationtype6(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_certificationtype6(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_certificationtype6(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_starrating(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_starrating(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_starrating(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_assets(SALT311.StrType s0) := MakeFT_Invalid_Float(s0);
EXPORT InValid_assets(SALT311.StrType s) := InValidFT_Invalid_Float(s);
EXPORT InValidMessage_assets(UNSIGNED1 wh) := InValidMessageFT_Invalid_Float(wh);
 
EXPORT Make_biddescription(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_biddescription(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_biddescription(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_competitiveadvantage(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_competitiveadvantage(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_competitiveadvantage(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_cagecode(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_cagecode(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_cagecode(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_capabilitiesnarrative(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_capabilitiesnarrative(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_capabilitiesnarrative(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_category(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_category(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_category(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_chtrclass(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_chtrclass(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_chtrclass(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_productdescription1(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_productdescription1(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_productdescription1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_productdescription2(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_productdescription2(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_productdescription2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_productdescription3(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_productdescription3(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_productdescription3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_productdescription4(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_productdescription4(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_productdescription4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_productdescription5(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_productdescription5(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_productdescription5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_classdescription1(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_classdescription1(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_classdescription1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_subclassdescription1(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_subclassdescription1(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_subclassdescription1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_classdescription2(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_classdescription2(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_classdescription2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_subclassdescription2(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_subclassdescription2(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_subclassdescription2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_classdescription3(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_classdescription3(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_classdescription3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_subclassdescription3(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_subclassdescription3(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_subclassdescription3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_classdescription4(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_classdescription4(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_classdescription4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_subclassdescription4(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_subclassdescription4(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_subclassdescription4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_classdescription5(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_classdescription5(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_classdescription5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_subclassdescription5(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_subclassdescription5(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_subclassdescription5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_classifications(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_classifications(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_classifications(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_commodity1(SALT311.StrType s0) := MakeFT_Invalid_Commodity(s0);
EXPORT InValid_commodity1(SALT311.StrType s) := InValidFT_Invalid_Commodity(s);
EXPORT InValidMessage_commodity1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Commodity(wh);
 
EXPORT Make_commodity2(SALT311.StrType s0) := MakeFT_Invalid_Commodity(s0);
EXPORT InValid_commodity2(SALT311.StrType s) := InValidFT_Invalid_Commodity(s);
EXPORT InValidMessage_commodity2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Commodity(wh);
 
EXPORT Make_commodity3(SALT311.StrType s0) := MakeFT_Invalid_Commodity(s0);
EXPORT InValid_commodity3(SALT311.StrType s) := InValidFT_Invalid_Commodity(s);
EXPORT InValidMessage_commodity3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Commodity(wh);
 
EXPORT Make_commodity4(SALT311.StrType s0) := MakeFT_Invalid_Commodity(s0);
EXPORT InValid_commodity4(SALT311.StrType s) := InValidFT_Invalid_Commodity(s);
EXPORT InValidMessage_commodity4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Commodity(wh);
 
EXPORT Make_commodity5(SALT311.StrType s0) := MakeFT_Invalid_Commodity(s0);
EXPORT InValid_commodity5(SALT311.StrType s) := InValidFT_Invalid_Commodity(s);
EXPORT InValidMessage_commodity5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Commodity(wh);
 
EXPORT Make_commodity6(SALT311.StrType s0) := MakeFT_Invalid_Commodity(s0);
EXPORT InValid_commodity6(SALT311.StrType s) := InValidFT_Invalid_Commodity(s);
EXPORT InValidMessage_commodity6(UNSIGNED1 wh) := InValidMessageFT_Invalid_Commodity(wh);
 
EXPORT Make_commodity7(SALT311.StrType s0) := MakeFT_Invalid_Commodity(s0);
EXPORT InValid_commodity7(SALT311.StrType s) := InValidFT_Invalid_Commodity(s);
EXPORT InValidMessage_commodity7(UNSIGNED1 wh) := InValidMessageFT_Invalid_Commodity(wh);
 
EXPORT Make_commodity8(SALT311.StrType s0) := MakeFT_Invalid_Commodity(s0);
EXPORT InValid_commodity8(SALT311.StrType s) := InValidFT_Invalid_Commodity(s);
EXPORT InValidMessage_commodity8(UNSIGNED1 wh) := InValidMessageFT_Invalid_Commodity(wh);
 
EXPORT Make_completedate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_completedate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_completedate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_crossreference(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_crossreference(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_crossreference(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_dateestablished(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dateestablished(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dateestablished(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_businessage(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_businessage(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_businessage(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_deposits(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_deposits(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_deposits(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_dunsnumber(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_dunsnumber(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_dunsnumber(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_enttype(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_enttype(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_enttype(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_expirationdate(SALT311.StrType s0) := MakeFT_Invalid_Future(s0);
EXPORT InValid_expirationdate(SALT311.StrType s) := InValidFT_Invalid_Future(s);
EXPORT InValidMessage_expirationdate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future(wh);
 
EXPORT Make_extendeddate(SALT311.StrType s0) := MakeFT_Invalid_Future(s0);
EXPORT InValid_extendeddate(SALT311.StrType s) := InValidFT_Invalid_Future(s);
EXPORT InValidMessage_extendeddate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future(wh);
 
EXPORT Make_issuingauthority(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_issuingauthority(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_issuingauthority(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_keywords(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_keywords(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_keywords(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_licensenumber(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_licensenumber(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_licensenumber(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_licensetype(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_licensetype(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_licensetype(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_mincd(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_mincd(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_mincd(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_minorityaffiliation(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_minorityaffiliation(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_minorityaffiliation(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_minorityownershipdate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_minorityownershipdate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_minorityownershipdate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_siccode1(SALT311.StrType s0) := MakeFT_Invalid_Sic(s0);
EXPORT InValid_siccode1(SALT311.StrType s) := InValidFT_Invalid_Sic(s);
EXPORT InValidMessage_siccode1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Sic(wh);
 
EXPORT Make_siccode2(SALT311.StrType s0) := MakeFT_Invalid_Sic(s0);
EXPORT InValid_siccode2(SALT311.StrType s) := InValidFT_Invalid_Sic(s);
EXPORT InValidMessage_siccode2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Sic(wh);
 
EXPORT Make_siccode3(SALT311.StrType s0) := MakeFT_Invalid_Sic(s0);
EXPORT InValid_siccode3(SALT311.StrType s) := InValidFT_Invalid_Sic(s);
EXPORT InValidMessage_siccode3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Sic(wh);
 
EXPORT Make_siccode4(SALT311.StrType s0) := MakeFT_Invalid_Sic(s0);
EXPORT InValid_siccode4(SALT311.StrType s) := InValidFT_Invalid_Sic(s);
EXPORT InValidMessage_siccode4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Sic(wh);
 
EXPORT Make_siccode5(SALT311.StrType s0) := MakeFT_Invalid_Sic(s0);
EXPORT InValid_siccode5(SALT311.StrType s) := InValidFT_Invalid_Sic(s);
EXPORT InValidMessage_siccode5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Sic(wh);
 
EXPORT Make_siccode6(SALT311.StrType s0) := MakeFT_Invalid_Sic(s0);
EXPORT InValid_siccode6(SALT311.StrType s) := InValidFT_Invalid_Sic(s);
EXPORT InValidMessage_siccode6(UNSIGNED1 wh) := InValidMessageFT_Invalid_Sic(wh);
 
EXPORT Make_siccode7(SALT311.StrType s0) := MakeFT_Invalid_Sic(s0);
EXPORT InValid_siccode7(SALT311.StrType s) := InValidFT_Invalid_Sic(s);
EXPORT InValidMessage_siccode7(UNSIGNED1 wh) := InValidMessageFT_Invalid_Sic(wh);
 
EXPORT Make_siccode8(SALT311.StrType s0) := MakeFT_Invalid_Sic(s0);
EXPORT InValid_siccode8(SALT311.StrType s) := InValidFT_Invalid_Sic(s);
EXPORT InValidMessage_siccode8(UNSIGNED1 wh) := InValidMessageFT_Invalid_Sic(wh);
 
EXPORT Make_naicscode1(SALT311.StrType s0) := MakeFT_Invalid_NAICS(s0);
EXPORT InValid_naicscode1(SALT311.StrType s) := InValidFT_Invalid_NAICS(s);
EXPORT InValidMessage_naicscode1(UNSIGNED1 wh) := InValidMessageFT_Invalid_NAICS(wh);
 
EXPORT Make_naicscode2(SALT311.StrType s0) := MakeFT_Invalid_NAICS(s0);
EXPORT InValid_naicscode2(SALT311.StrType s) := InValidFT_Invalid_NAICS(s);
EXPORT InValidMessage_naicscode2(UNSIGNED1 wh) := InValidMessageFT_Invalid_NAICS(wh);
 
EXPORT Make_naicscode3(SALT311.StrType s0) := MakeFT_Invalid_NAICS(s0);
EXPORT InValid_naicscode3(SALT311.StrType s) := InValidFT_Invalid_NAICS(s);
EXPORT InValidMessage_naicscode3(UNSIGNED1 wh) := InValidMessageFT_Invalid_NAICS(wh);
 
EXPORT Make_naicscode4(SALT311.StrType s0) := MakeFT_Invalid_NAICS(s0);
EXPORT InValid_naicscode4(SALT311.StrType s) := InValidFT_Invalid_NAICS(s);
EXPORT InValidMessage_naicscode4(UNSIGNED1 wh) := InValidMessageFT_Invalid_NAICS(wh);
 
EXPORT Make_naicscode5(SALT311.StrType s0) := MakeFT_Invalid_NAICS(s0);
EXPORT InValid_naicscode5(SALT311.StrType s) := InValidFT_Invalid_NAICS(s);
EXPORT InValidMessage_naicscode5(UNSIGNED1 wh) := InValidMessageFT_Invalid_NAICS(wh);
 
EXPORT Make_naicscode6(SALT311.StrType s0) := MakeFT_Invalid_NAICS(s0);
EXPORT InValid_naicscode6(SALT311.StrType s) := InValidFT_Invalid_NAICS(s);
EXPORT InValidMessage_naicscode6(UNSIGNED1 wh) := InValidMessageFT_Invalid_NAICS(wh);
 
EXPORT Make_naicscode7(SALT311.StrType s0) := MakeFT_Invalid_NAICS(s0);
EXPORT InValid_naicscode7(SALT311.StrType s) := InValidFT_Invalid_NAICS(s);
EXPORT InValidMessage_naicscode7(UNSIGNED1 wh) := InValidMessageFT_Invalid_NAICS(wh);
 
EXPORT Make_naicscode8(SALT311.StrType s0) := MakeFT_Invalid_NAICS(s0);
EXPORT InValid_naicscode8(SALT311.StrType s) := InValidFT_Invalid_NAICS(s);
EXPORT InValidMessage_naicscode8(UNSIGNED1 wh) := InValidMessageFT_Invalid_NAICS(wh);
 
EXPORT Make_prequalify(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_prequalify(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_prequalify(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_procurementcategory1(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_procurementcategory1(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_procurementcategory1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_subprocurementcategory1(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_subprocurementcategory1(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_subprocurementcategory1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_procurementcategory2(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_procurementcategory2(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_procurementcategory2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_subprocurementcategory2(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_subprocurementcategory2(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_subprocurementcategory2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_procurementcategory3(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_procurementcategory3(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_procurementcategory3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_subprocurementcategory3(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_subprocurementcategory3(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_subprocurementcategory3(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_procurementcategory4(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_procurementcategory4(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_procurementcategory4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_subprocurementcategory4(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_subprocurementcategory4(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_subprocurementcategory4(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_procurementcategory5(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_procurementcategory5(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_procurementcategory5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_subprocurementcategory5(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_subprocurementcategory5(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_subprocurementcategory5(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_renewal(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_renewal(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_renewal(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_renewaldate(SALT311.StrType s0) := MakeFT_Invalid_Future(s0);
EXPORT InValid_renewaldate(SALT311.StrType s) := InValidFT_Invalid_Future(s);
EXPORT InValidMessage_renewaldate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future(wh);
 
EXPORT Make_unitedcertprogrampartner(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_unitedcertprogrampartner(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_unitedcertprogrampartner(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_vendorkey(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_vendorkey(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_vendorkey(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_vendornumber(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_vendornumber(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_vendornumber(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_workcode1(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_workcode1(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_workcode1(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_workcode2(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_workcode2(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_workcode2(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_workcode3(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_workcode3(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_workcode3(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_workcode4(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_workcode4(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_workcode4(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_workcode5(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_workcode5(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_workcode5(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_workcode6(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_workcode6(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_workcode6(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_workcode7(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_workcode7(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_workcode7(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_workcode8(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_workcode8(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_workcode8(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_exporter(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_exporter(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_exporter(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_exportbusinessactivities(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_exportbusinessactivities(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_exportbusinessactivities(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_exportto(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_exportto(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_exportto(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_exportbusinessrelationships(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_exportbusinessrelationships(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_exportbusinessrelationships(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_exportobjectives(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_exportobjectives(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_exportobjectives(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_reference1(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_reference1(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_reference1(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_reference2(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_reference2(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_reference2(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_reference3(SALT311.StrType s0) := s0;
EXPORT InValid_reference3(SALT311.StrType s) := 0;
EXPORT InValidMessage_reference3(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Diversity_Certification;
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
    BOOLEAN Diff_profilelastupdated;
    BOOLEAN Diff_county;
    BOOLEAN Diff_servicearea;
    BOOLEAN Diff_region1;
    BOOLEAN Diff_region2;
    BOOLEAN Diff_region3;
    BOOLEAN Diff_region4;
    BOOLEAN Diff_region5;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_title;
    BOOLEAN Diff_ethnicity;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_address1;
    BOOLEAN Diff_address2;
    BOOLEAN Diff_addresscity;
    BOOLEAN Diff_addressstate;
    BOOLEAN Diff_addresszipcode;
    BOOLEAN Diff_addresszip4;
    BOOLEAN Diff_building;
    BOOLEAN Diff_contact;
    BOOLEAN Diff_phone1;
    BOOLEAN Diff_phone2;
    BOOLEAN Diff_phone3;
    BOOLEAN Diff_cell;
    BOOLEAN Diff_fax;
    BOOLEAN Diff_email1;
    BOOLEAN Diff_email2;
    BOOLEAN Diff_email3;
    BOOLEAN Diff_webpage1;
    BOOLEAN Diff_webpage2;
    BOOLEAN Diff_webpage3;
    BOOLEAN Diff_businessname;
    BOOLEAN Diff_dba;
    BOOLEAN Diff_businessid;
    BOOLEAN Diff_businesstype1;
    BOOLEAN Diff_businesslocation1;
    BOOLEAN Diff_businesstype2;
    BOOLEAN Diff_businesslocation2;
    BOOLEAN Diff_businesstype3;
    BOOLEAN Diff_businesslocation3;
    BOOLEAN Diff_businesstype4;
    BOOLEAN Diff_businesslocation4;
    BOOLEAN Diff_businesstype5;
    BOOLEAN Diff_businesslocation5;
    BOOLEAN Diff_industry;
    BOOLEAN Diff_trade;
    BOOLEAN Diff_resourcedescription;
    BOOLEAN Diff_natureofbusiness;
    BOOLEAN Diff_businessstructure;
    BOOLEAN Diff_totalemployees;
    BOOLEAN Diff_avgcontractsize;
    BOOLEAN Diff_firmid;
    BOOLEAN Diff_firmlocationaddress;
    BOOLEAN Diff_firmlocationaddresscity;
    BOOLEAN Diff_firmlocationaddresszip4;
    BOOLEAN Diff_firmlocationaddresszipcode;
    BOOLEAN Diff_firmlocationcounty;
    BOOLEAN Diff_firmlocationstate;
    BOOLEAN Diff_certfed;
    BOOLEAN Diff_certstate;
    BOOLEAN Diff_contractsfederal;
    BOOLEAN Diff_contractsva;
    BOOLEAN Diff_contractscommercial;
    BOOLEAN Diff_contractorgovernmentprime;
    BOOLEAN Diff_contractorgovernmentsub;
    BOOLEAN Diff_contractornongovernment;
    BOOLEAN Diff_registeredgovernmentbus;
    BOOLEAN Diff_registerednongovernmentbus;
    BOOLEAN Diff_clearancelevelpersonnel;
    BOOLEAN Diff_clearancelevelfacility;
    BOOLEAN Diff_certificatedatefrom1;
    BOOLEAN Diff_certificatedateto1;
    BOOLEAN Diff_certificatestatus1;
    BOOLEAN Diff_certificationnumber1;
    BOOLEAN Diff_certificationtype1;
    BOOLEAN Diff_certificatedatefrom2;
    BOOLEAN Diff_certificatedateto2;
    BOOLEAN Diff_certificatestatus2;
    BOOLEAN Diff_certificationnumber2;
    BOOLEAN Diff_certificationtype2;
    BOOLEAN Diff_certificatedatefrom3;
    BOOLEAN Diff_certificatedateto3;
    BOOLEAN Diff_certificatestatus3;
    BOOLEAN Diff_certificationnumber3;
    BOOLEAN Diff_certificationtype3;
    BOOLEAN Diff_certificatedatefrom4;
    BOOLEAN Diff_certificatedateto4;
    BOOLEAN Diff_certificatestatus4;
    BOOLEAN Diff_certificationnumber4;
    BOOLEAN Diff_certificationtype4;
    BOOLEAN Diff_certificatedatefrom5;
    BOOLEAN Diff_certificatedateto5;
    BOOLEAN Diff_certificatestatus5;
    BOOLEAN Diff_certificationnumber5;
    BOOLEAN Diff_certificationtype5;
    BOOLEAN Diff_certificatedatefrom6;
    BOOLEAN Diff_certificatedateto6;
    BOOLEAN Diff_certificatestatus6;
    BOOLEAN Diff_certificationnumber6;
    BOOLEAN Diff_certificationtype6;
    BOOLEAN Diff_starrating;
    BOOLEAN Diff_assets;
    BOOLEAN Diff_biddescription;
    BOOLEAN Diff_competitiveadvantage;
    BOOLEAN Diff_cagecode;
    BOOLEAN Diff_capabilitiesnarrative;
    BOOLEAN Diff_category;
    BOOLEAN Diff_chtrclass;
    BOOLEAN Diff_productdescription1;
    BOOLEAN Diff_productdescription2;
    BOOLEAN Diff_productdescription3;
    BOOLEAN Diff_productdescription4;
    BOOLEAN Diff_productdescription5;
    BOOLEAN Diff_classdescription1;
    BOOLEAN Diff_subclassdescription1;
    BOOLEAN Diff_classdescription2;
    BOOLEAN Diff_subclassdescription2;
    BOOLEAN Diff_classdescription3;
    BOOLEAN Diff_subclassdescription3;
    BOOLEAN Diff_classdescription4;
    BOOLEAN Diff_subclassdescription4;
    BOOLEAN Diff_classdescription5;
    BOOLEAN Diff_subclassdescription5;
    BOOLEAN Diff_classifications;
    BOOLEAN Diff_commodity1;
    BOOLEAN Diff_commodity2;
    BOOLEAN Diff_commodity3;
    BOOLEAN Diff_commodity4;
    BOOLEAN Diff_commodity5;
    BOOLEAN Diff_commodity6;
    BOOLEAN Diff_commodity7;
    BOOLEAN Diff_commodity8;
    BOOLEAN Diff_completedate;
    BOOLEAN Diff_crossreference;
    BOOLEAN Diff_dateestablished;
    BOOLEAN Diff_businessage;
    BOOLEAN Diff_deposits;
    BOOLEAN Diff_dunsnumber;
    BOOLEAN Diff_enttype;
    BOOLEAN Diff_expirationdate;
    BOOLEAN Diff_extendeddate;
    BOOLEAN Diff_issuingauthority;
    BOOLEAN Diff_keywords;
    BOOLEAN Diff_licensenumber;
    BOOLEAN Diff_licensetype;
    BOOLEAN Diff_mincd;
    BOOLEAN Diff_minorityaffiliation;
    BOOLEAN Diff_minorityownershipdate;
    BOOLEAN Diff_siccode1;
    BOOLEAN Diff_siccode2;
    BOOLEAN Diff_siccode3;
    BOOLEAN Diff_siccode4;
    BOOLEAN Diff_siccode5;
    BOOLEAN Diff_siccode6;
    BOOLEAN Diff_siccode7;
    BOOLEAN Diff_siccode8;
    BOOLEAN Diff_naicscode1;
    BOOLEAN Diff_naicscode2;
    BOOLEAN Diff_naicscode3;
    BOOLEAN Diff_naicscode4;
    BOOLEAN Diff_naicscode5;
    BOOLEAN Diff_naicscode6;
    BOOLEAN Diff_naicscode7;
    BOOLEAN Diff_naicscode8;
    BOOLEAN Diff_prequalify;
    BOOLEAN Diff_procurementcategory1;
    BOOLEAN Diff_subprocurementcategory1;
    BOOLEAN Diff_procurementcategory2;
    BOOLEAN Diff_subprocurementcategory2;
    BOOLEAN Diff_procurementcategory3;
    BOOLEAN Diff_subprocurementcategory3;
    BOOLEAN Diff_procurementcategory4;
    BOOLEAN Diff_subprocurementcategory4;
    BOOLEAN Diff_procurementcategory5;
    BOOLEAN Diff_subprocurementcategory5;
    BOOLEAN Diff_renewal;
    BOOLEAN Diff_renewaldate;
    BOOLEAN Diff_unitedcertprogrampartner;
    BOOLEAN Diff_vendorkey;
    BOOLEAN Diff_vendornumber;
    BOOLEAN Diff_workcode1;
    BOOLEAN Diff_workcode2;
    BOOLEAN Diff_workcode3;
    BOOLEAN Diff_workcode4;
    BOOLEAN Diff_workcode5;
    BOOLEAN Diff_workcode6;
    BOOLEAN Diff_workcode7;
    BOOLEAN Diff_workcode8;
    BOOLEAN Diff_exporter;
    BOOLEAN Diff_exportbusinessactivities;
    BOOLEAN Diff_exportto;
    BOOLEAN Diff_exportbusinessrelationships;
    BOOLEAN Diff_exportobjectives;
    BOOLEAN Diff_reference1;
    BOOLEAN Diff_reference2;
    BOOLEAN Diff_reference3;
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
    SELF.Diff_profilelastupdated := le.profilelastupdated <> ri.profilelastupdated;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_servicearea := le.servicearea <> ri.servicearea;
    SELF.Diff_region1 := le.region1 <> ri.region1;
    SELF.Diff_region2 := le.region2 <> ri.region2;
    SELF.Diff_region3 := le.region3 <> ri.region3;
    SELF.Diff_region4 := le.region4 <> ri.region4;
    SELF.Diff_region5 := le.region5 <> ri.region5;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_ethnicity := le.ethnicity <> ri.ethnicity;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_address1 := le.address1 <> ri.address1;
    SELF.Diff_address2 := le.address2 <> ri.address2;
    SELF.Diff_addresscity := le.addresscity <> ri.addresscity;
    SELF.Diff_addressstate := le.addressstate <> ri.addressstate;
    SELF.Diff_addresszipcode := le.addresszipcode <> ri.addresszipcode;
    SELF.Diff_addresszip4 := le.addresszip4 <> ri.addresszip4;
    SELF.Diff_building := le.building <> ri.building;
    SELF.Diff_contact := le.contact <> ri.contact;
    SELF.Diff_phone1 := le.phone1 <> ri.phone1;
    SELF.Diff_phone2 := le.phone2 <> ri.phone2;
    SELF.Diff_phone3 := le.phone3 <> ri.phone3;
    SELF.Diff_cell := le.cell <> ri.cell;
    SELF.Diff_fax := le.fax <> ri.fax;
    SELF.Diff_email1 := le.email1 <> ri.email1;
    SELF.Diff_email2 := le.email2 <> ri.email2;
    SELF.Diff_email3 := le.email3 <> ri.email3;
    SELF.Diff_webpage1 := le.webpage1 <> ri.webpage1;
    SELF.Diff_webpage2 := le.webpage2 <> ri.webpage2;
    SELF.Diff_webpage3 := le.webpage3 <> ri.webpage3;
    SELF.Diff_businessname := le.businessname <> ri.businessname;
    SELF.Diff_dba := le.dba <> ri.dba;
    SELF.Diff_businessid := le.businessid <> ri.businessid;
    SELF.Diff_businesstype1 := le.businesstype1 <> ri.businesstype1;
    SELF.Diff_businesslocation1 := le.businesslocation1 <> ri.businesslocation1;
    SELF.Diff_businesstype2 := le.businesstype2 <> ri.businesstype2;
    SELF.Diff_businesslocation2 := le.businesslocation2 <> ri.businesslocation2;
    SELF.Diff_businesstype3 := le.businesstype3 <> ri.businesstype3;
    SELF.Diff_businesslocation3 := le.businesslocation3 <> ri.businesslocation3;
    SELF.Diff_businesstype4 := le.businesstype4 <> ri.businesstype4;
    SELF.Diff_businesslocation4 := le.businesslocation4 <> ri.businesslocation4;
    SELF.Diff_businesstype5 := le.businesstype5 <> ri.businesstype5;
    SELF.Diff_businesslocation5 := le.businesslocation5 <> ri.businesslocation5;
    SELF.Diff_industry := le.industry <> ri.industry;
    SELF.Diff_trade := le.trade <> ri.trade;
    SELF.Diff_resourcedescription := le.resourcedescription <> ri.resourcedescription;
    SELF.Diff_natureofbusiness := le.natureofbusiness <> ri.natureofbusiness;
    SELF.Diff_businessstructure := le.businessstructure <> ri.businessstructure;
    SELF.Diff_totalemployees := le.totalemployees <> ri.totalemployees;
    SELF.Diff_avgcontractsize := le.avgcontractsize <> ri.avgcontractsize;
    SELF.Diff_firmid := le.firmid <> ri.firmid;
    SELF.Diff_firmlocationaddress := le.firmlocationaddress <> ri.firmlocationaddress;
    SELF.Diff_firmlocationaddresscity := le.firmlocationaddresscity <> ri.firmlocationaddresscity;
    SELF.Diff_firmlocationaddresszip4 := le.firmlocationaddresszip4 <> ri.firmlocationaddresszip4;
    SELF.Diff_firmlocationaddresszipcode := le.firmlocationaddresszipcode <> ri.firmlocationaddresszipcode;
    SELF.Diff_firmlocationcounty := le.firmlocationcounty <> ri.firmlocationcounty;
    SELF.Diff_firmlocationstate := le.firmlocationstate <> ri.firmlocationstate;
    SELF.Diff_certfed := le.certfed <> ri.certfed;
    SELF.Diff_certstate := le.certstate <> ri.certstate;
    SELF.Diff_contractsfederal := le.contractsfederal <> ri.contractsfederal;
    SELF.Diff_contractsva := le.contractsva <> ri.contractsva;
    SELF.Diff_contractscommercial := le.contractscommercial <> ri.contractscommercial;
    SELF.Diff_contractorgovernmentprime := le.contractorgovernmentprime <> ri.contractorgovernmentprime;
    SELF.Diff_contractorgovernmentsub := le.contractorgovernmentsub <> ri.contractorgovernmentsub;
    SELF.Diff_contractornongovernment := le.contractornongovernment <> ri.contractornongovernment;
    SELF.Diff_registeredgovernmentbus := le.registeredgovernmentbus <> ri.registeredgovernmentbus;
    SELF.Diff_registerednongovernmentbus := le.registerednongovernmentbus <> ri.registerednongovernmentbus;
    SELF.Diff_clearancelevelpersonnel := le.clearancelevelpersonnel <> ri.clearancelevelpersonnel;
    SELF.Diff_clearancelevelfacility := le.clearancelevelfacility <> ri.clearancelevelfacility;
    SELF.Diff_certificatedatefrom1 := le.certificatedatefrom1 <> ri.certificatedatefrom1;
    SELF.Diff_certificatedateto1 := le.certificatedateto1 <> ri.certificatedateto1;
    SELF.Diff_certificatestatus1 := le.certificatestatus1 <> ri.certificatestatus1;
    SELF.Diff_certificationnumber1 := le.certificationnumber1 <> ri.certificationnumber1;
    SELF.Diff_certificationtype1 := le.certificationtype1 <> ri.certificationtype1;
    SELF.Diff_certificatedatefrom2 := le.certificatedatefrom2 <> ri.certificatedatefrom2;
    SELF.Diff_certificatedateto2 := le.certificatedateto2 <> ri.certificatedateto2;
    SELF.Diff_certificatestatus2 := le.certificatestatus2 <> ri.certificatestatus2;
    SELF.Diff_certificationnumber2 := le.certificationnumber2 <> ri.certificationnumber2;
    SELF.Diff_certificationtype2 := le.certificationtype2 <> ri.certificationtype2;
    SELF.Diff_certificatedatefrom3 := le.certificatedatefrom3 <> ri.certificatedatefrom3;
    SELF.Diff_certificatedateto3 := le.certificatedateto3 <> ri.certificatedateto3;
    SELF.Diff_certificatestatus3 := le.certificatestatus3 <> ri.certificatestatus3;
    SELF.Diff_certificationnumber3 := le.certificationnumber3 <> ri.certificationnumber3;
    SELF.Diff_certificationtype3 := le.certificationtype3 <> ri.certificationtype3;
    SELF.Diff_certificatedatefrom4 := le.certificatedatefrom4 <> ri.certificatedatefrom4;
    SELF.Diff_certificatedateto4 := le.certificatedateto4 <> ri.certificatedateto4;
    SELF.Diff_certificatestatus4 := le.certificatestatus4 <> ri.certificatestatus4;
    SELF.Diff_certificationnumber4 := le.certificationnumber4 <> ri.certificationnumber4;
    SELF.Diff_certificationtype4 := le.certificationtype4 <> ri.certificationtype4;
    SELF.Diff_certificatedatefrom5 := le.certificatedatefrom5 <> ri.certificatedatefrom5;
    SELF.Diff_certificatedateto5 := le.certificatedateto5 <> ri.certificatedateto5;
    SELF.Diff_certificatestatus5 := le.certificatestatus5 <> ri.certificatestatus5;
    SELF.Diff_certificationnumber5 := le.certificationnumber5 <> ri.certificationnumber5;
    SELF.Diff_certificationtype5 := le.certificationtype5 <> ri.certificationtype5;
    SELF.Diff_certificatedatefrom6 := le.certificatedatefrom6 <> ri.certificatedatefrom6;
    SELF.Diff_certificatedateto6 := le.certificatedateto6 <> ri.certificatedateto6;
    SELF.Diff_certificatestatus6 := le.certificatestatus6 <> ri.certificatestatus6;
    SELF.Diff_certificationnumber6 := le.certificationnumber6 <> ri.certificationnumber6;
    SELF.Diff_certificationtype6 := le.certificationtype6 <> ri.certificationtype6;
    SELF.Diff_starrating := le.starrating <> ri.starrating;
    SELF.Diff_assets := le.assets <> ri.assets;
    SELF.Diff_biddescription := le.biddescription <> ri.biddescription;
    SELF.Diff_competitiveadvantage := le.competitiveadvantage <> ri.competitiveadvantage;
    SELF.Diff_cagecode := le.cagecode <> ri.cagecode;
    SELF.Diff_capabilitiesnarrative := le.capabilitiesnarrative <> ri.capabilitiesnarrative;
    SELF.Diff_category := le.category <> ri.category;
    SELF.Diff_chtrclass := le.chtrclass <> ri.chtrclass;
    SELF.Diff_productdescription1 := le.productdescription1 <> ri.productdescription1;
    SELF.Diff_productdescription2 := le.productdescription2 <> ri.productdescription2;
    SELF.Diff_productdescription3 := le.productdescription3 <> ri.productdescription3;
    SELF.Diff_productdescription4 := le.productdescription4 <> ri.productdescription4;
    SELF.Diff_productdescription5 := le.productdescription5 <> ri.productdescription5;
    SELF.Diff_classdescription1 := le.classdescription1 <> ri.classdescription1;
    SELF.Diff_subclassdescription1 := le.subclassdescription1 <> ri.subclassdescription1;
    SELF.Diff_classdescription2 := le.classdescription2 <> ri.classdescription2;
    SELF.Diff_subclassdescription2 := le.subclassdescription2 <> ri.subclassdescription2;
    SELF.Diff_classdescription3 := le.classdescription3 <> ri.classdescription3;
    SELF.Diff_subclassdescription3 := le.subclassdescription3 <> ri.subclassdescription3;
    SELF.Diff_classdescription4 := le.classdescription4 <> ri.classdescription4;
    SELF.Diff_subclassdescription4 := le.subclassdescription4 <> ri.subclassdescription4;
    SELF.Diff_classdescription5 := le.classdescription5 <> ri.classdescription5;
    SELF.Diff_subclassdescription5 := le.subclassdescription5 <> ri.subclassdescription5;
    SELF.Diff_classifications := le.classifications <> ri.classifications;
    SELF.Diff_commodity1 := le.commodity1 <> ri.commodity1;
    SELF.Diff_commodity2 := le.commodity2 <> ri.commodity2;
    SELF.Diff_commodity3 := le.commodity3 <> ri.commodity3;
    SELF.Diff_commodity4 := le.commodity4 <> ri.commodity4;
    SELF.Diff_commodity5 := le.commodity5 <> ri.commodity5;
    SELF.Diff_commodity6 := le.commodity6 <> ri.commodity6;
    SELF.Diff_commodity7 := le.commodity7 <> ri.commodity7;
    SELF.Diff_commodity8 := le.commodity8 <> ri.commodity8;
    SELF.Diff_completedate := le.completedate <> ri.completedate;
    SELF.Diff_crossreference := le.crossreference <> ri.crossreference;
    SELF.Diff_dateestablished := le.dateestablished <> ri.dateestablished;
    SELF.Diff_businessage := le.businessage <> ri.businessage;
    SELF.Diff_deposits := le.deposits <> ri.deposits;
    SELF.Diff_dunsnumber := le.dunsnumber <> ri.dunsnumber;
    SELF.Diff_enttype := le.enttype <> ri.enttype;
    SELF.Diff_expirationdate := le.expirationdate <> ri.expirationdate;
    SELF.Diff_extendeddate := le.extendeddate <> ri.extendeddate;
    SELF.Diff_issuingauthority := le.issuingauthority <> ri.issuingauthority;
    SELF.Diff_keywords := le.keywords <> ri.keywords;
    SELF.Diff_licensenumber := le.licensenumber <> ri.licensenumber;
    SELF.Diff_licensetype := le.licensetype <> ri.licensetype;
    SELF.Diff_mincd := le.mincd <> ri.mincd;
    SELF.Diff_minorityaffiliation := le.minorityaffiliation <> ri.minorityaffiliation;
    SELF.Diff_minorityownershipdate := le.minorityownershipdate <> ri.minorityownershipdate;
    SELF.Diff_siccode1 := le.siccode1 <> ri.siccode1;
    SELF.Diff_siccode2 := le.siccode2 <> ri.siccode2;
    SELF.Diff_siccode3 := le.siccode3 <> ri.siccode3;
    SELF.Diff_siccode4 := le.siccode4 <> ri.siccode4;
    SELF.Diff_siccode5 := le.siccode5 <> ri.siccode5;
    SELF.Diff_siccode6 := le.siccode6 <> ri.siccode6;
    SELF.Diff_siccode7 := le.siccode7 <> ri.siccode7;
    SELF.Diff_siccode8 := le.siccode8 <> ri.siccode8;
    SELF.Diff_naicscode1 := le.naicscode1 <> ri.naicscode1;
    SELF.Diff_naicscode2 := le.naicscode2 <> ri.naicscode2;
    SELF.Diff_naicscode3 := le.naicscode3 <> ri.naicscode3;
    SELF.Diff_naicscode4 := le.naicscode4 <> ri.naicscode4;
    SELF.Diff_naicscode5 := le.naicscode5 <> ri.naicscode5;
    SELF.Diff_naicscode6 := le.naicscode6 <> ri.naicscode6;
    SELF.Diff_naicscode7 := le.naicscode7 <> ri.naicscode7;
    SELF.Diff_naicscode8 := le.naicscode8 <> ri.naicscode8;
    SELF.Diff_prequalify := le.prequalify <> ri.prequalify;
    SELF.Diff_procurementcategory1 := le.procurementcategory1 <> ri.procurementcategory1;
    SELF.Diff_subprocurementcategory1 := le.subprocurementcategory1 <> ri.subprocurementcategory1;
    SELF.Diff_procurementcategory2 := le.procurementcategory2 <> ri.procurementcategory2;
    SELF.Diff_subprocurementcategory2 := le.subprocurementcategory2 <> ri.subprocurementcategory2;
    SELF.Diff_procurementcategory3 := le.procurementcategory3 <> ri.procurementcategory3;
    SELF.Diff_subprocurementcategory3 := le.subprocurementcategory3 <> ri.subprocurementcategory3;
    SELF.Diff_procurementcategory4 := le.procurementcategory4 <> ri.procurementcategory4;
    SELF.Diff_subprocurementcategory4 := le.subprocurementcategory4 <> ri.subprocurementcategory4;
    SELF.Diff_procurementcategory5 := le.procurementcategory5 <> ri.procurementcategory5;
    SELF.Diff_subprocurementcategory5 := le.subprocurementcategory5 <> ri.subprocurementcategory5;
    SELF.Diff_renewal := le.renewal <> ri.renewal;
    SELF.Diff_renewaldate := le.renewaldate <> ri.renewaldate;
    SELF.Diff_unitedcertprogrampartner := le.unitedcertprogrampartner <> ri.unitedcertprogrampartner;
    SELF.Diff_vendorkey := le.vendorkey <> ri.vendorkey;
    SELF.Diff_vendornumber := le.vendornumber <> ri.vendornumber;
    SELF.Diff_workcode1 := le.workcode1 <> ri.workcode1;
    SELF.Diff_workcode2 := le.workcode2 <> ri.workcode2;
    SELF.Diff_workcode3 := le.workcode3 <> ri.workcode3;
    SELF.Diff_workcode4 := le.workcode4 <> ri.workcode4;
    SELF.Diff_workcode5 := le.workcode5 <> ri.workcode5;
    SELF.Diff_workcode6 := le.workcode6 <> ri.workcode6;
    SELF.Diff_workcode7 := le.workcode7 <> ri.workcode7;
    SELF.Diff_workcode8 := le.workcode8 <> ri.workcode8;
    SELF.Diff_exporter := le.exporter <> ri.exporter;
    SELF.Diff_exportbusinessactivities := le.exportbusinessactivities <> ri.exportbusinessactivities;
    SELF.Diff_exportto := le.exportto <> ri.exportto;
    SELF.Diff_exportbusinessrelationships := le.exportbusinessrelationships <> ri.exportbusinessrelationships;
    SELF.Diff_exportobjectives := le.exportobjectives <> ri.exportobjectives;
    SELF.Diff_reference1 := le.reference1 <> ri.reference1;
    SELF.Diff_reference2 := le.reference2 <> ri.reference2;
    SELF.Diff_reference3 := le.reference3 <> ri.reference3;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dartid,1,0)+ IF( SELF.Diff_dateadded,1,0)+ IF( SELF.Diff_dateupdated,1,0)+ IF( SELF.Diff_website,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_profilelastupdated,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_servicearea,1,0)+ IF( SELF.Diff_region1,1,0)+ IF( SELF.Diff_region2,1,0)+ IF( SELF.Diff_region3,1,0)+ IF( SELF.Diff_region4,1,0)+ IF( SELF.Diff_region5,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_ethnicity,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_address1,1,0)+ IF( SELF.Diff_address2,1,0)+ IF( SELF.Diff_addresscity,1,0)+ IF( SELF.Diff_addressstate,1,0)+ IF( SELF.Diff_addresszipcode,1,0)+ IF( SELF.Diff_addresszip4,1,0)+ IF( SELF.Diff_building,1,0)+ IF( SELF.Diff_contact,1,0)+ IF( SELF.Diff_phone1,1,0)+ IF( SELF.Diff_phone2,1,0)+ IF( SELF.Diff_phone3,1,0)+ IF( SELF.Diff_cell,1,0)+ IF( SELF.Diff_fax,1,0)+ IF( SELF.Diff_email1,1,0)+ IF( SELF.Diff_email2,1,0)+ IF( SELF.Diff_email3,1,0)+ IF( SELF.Diff_webpage1,1,0)+ IF( SELF.Diff_webpage2,1,0)+ IF( SELF.Diff_webpage3,1,0)+ IF( SELF.Diff_businessname,1,0)+ IF( SELF.Diff_dba,1,0)+ IF( SELF.Diff_businessid,1,0)+ IF( SELF.Diff_businesstype1,1,0)+ IF( SELF.Diff_businesslocation1,1,0)+ IF( SELF.Diff_businesstype2,1,0)+ IF( SELF.Diff_businesslocation2,1,0)+ IF( SELF.Diff_businesstype3,1,0)+ IF( SELF.Diff_businesslocation3,1,0)+ IF( SELF.Diff_businesstype4,1,0)+ IF( SELF.Diff_businesslocation4,1,0)+ IF( SELF.Diff_businesstype5,1,0)+ IF( SELF.Diff_businesslocation5,1,0)+ IF( SELF.Diff_industry,1,0)+ IF( SELF.Diff_trade,1,0)+ IF( SELF.Diff_resourcedescription,1,0)+ IF( SELF.Diff_natureofbusiness,1,0)+ IF( SELF.Diff_businessstructure,1,0)+ IF( SELF.Diff_totalemployees,1,0)+ IF( SELF.Diff_avgcontractsize,1,0)+ IF( SELF.Diff_firmid,1,0)+ IF( SELF.Diff_firmlocationaddress,1,0)+ IF( SELF.Diff_firmlocationaddresscity,1,0)+ IF( SELF.Diff_firmlocationaddresszip4,1,0)+ IF( SELF.Diff_firmlocationaddresszipcode,1,0)+ IF( SELF.Diff_firmlocationcounty,1,0)+ IF( SELF.Diff_firmlocationstate,1,0)+ IF( SELF.Diff_certfed,1,0)+ IF( SELF.Diff_certstate,1,0)+ IF( SELF.Diff_contractsfederal,1,0)+ IF( SELF.Diff_contractsva,1,0)+ IF( SELF.Diff_contractscommercial,1,0)+ IF( SELF.Diff_contractorgovernmentprime,1,0)+ IF( SELF.Diff_contractorgovernmentsub,1,0)+ IF( SELF.Diff_contractornongovernment,1,0)+ IF( SELF.Diff_registeredgovernmentbus,1,0)+ IF( SELF.Diff_registerednongovernmentbus,1,0)+ IF( SELF.Diff_clearancelevelpersonnel,1,0)+ IF( SELF.Diff_clearancelevelfacility,1,0)+ IF( SELF.Diff_certificatedatefrom1,1,0)+ IF( SELF.Diff_certificatedateto1,1,0)+ IF( SELF.Diff_certificatestatus1,1,0)+ IF( SELF.Diff_certificationnumber1,1,0)+ IF( SELF.Diff_certificationtype1,1,0)+ IF( SELF.Diff_certificatedatefrom2,1,0)+ IF( SELF.Diff_certificatedateto2,1,0)+ IF( SELF.Diff_certificatestatus2,1,0)+ IF( SELF.Diff_certificationnumber2,1,0)+ IF( SELF.Diff_certificationtype2,1,0)+ IF( SELF.Diff_certificatedatefrom3,1,0)+ IF( SELF.Diff_certificatedateto3,1,0)+ IF( SELF.Diff_certificatestatus3,1,0)+ IF( SELF.Diff_certificationnumber3,1,0)+ IF( SELF.Diff_certificationtype3,1,0)+ IF( SELF.Diff_certificatedatefrom4,1,0)+ IF( SELF.Diff_certificatedateto4,1,0)+ IF( SELF.Diff_certificatestatus4,1,0)+ IF( SELF.Diff_certificationnumber4,1,0)+ IF( SELF.Diff_certificationtype4,1,0)+ IF( SELF.Diff_certificatedatefrom5,1,0)+ IF( SELF.Diff_certificatedateto5,1,0)+ IF( SELF.Diff_certificatestatus5,1,0)+ IF( SELF.Diff_certificationnumber5,1,0)+ IF( SELF.Diff_certificationtype5,1,0)+ IF( SELF.Diff_certificatedatefrom6,1,0)+ IF( SELF.Diff_certificatedateto6,1,0)+ IF( SELF.Diff_certificatestatus6,1,0)+ IF( SELF.Diff_certificationnumber6,1,0)+ IF( SELF.Diff_certificationtype6,1,0)+ IF( SELF.Diff_starrating,1,0)+ IF( SELF.Diff_assets,1,0)+ IF( SELF.Diff_biddescription,1,0)+ IF( SELF.Diff_competitiveadvantage,1,0)+ IF( SELF.Diff_cagecode,1,0)+ IF( SELF.Diff_capabilitiesnarrative,1,0)+ IF( SELF.Diff_category,1,0)+ IF( SELF.Diff_chtrclass,1,0)+ IF( SELF.Diff_productdescription1,1,0)+ IF( SELF.Diff_productdescription2,1,0)+ IF( SELF.Diff_productdescription3,1,0)+ IF( SELF.Diff_productdescription4,1,0)+ IF( SELF.Diff_productdescription5,1,0)+ IF( SELF.Diff_classdescription1,1,0)+ IF( SELF.Diff_subclassdescription1,1,0)+ IF( SELF.Diff_classdescription2,1,0)+ IF( SELF.Diff_subclassdescription2,1,0)+ IF( SELF.Diff_classdescription3,1,0)+ IF( SELF.Diff_subclassdescription3,1,0)+ IF( SELF.Diff_classdescription4,1,0)+ IF( SELF.Diff_subclassdescription4,1,0)+ IF( SELF.Diff_classdescription5,1,0)+ IF( SELF.Diff_subclassdescription5,1,0)+ IF( SELF.Diff_classifications,1,0)+ IF( SELF.Diff_commodity1,1,0)+ IF( SELF.Diff_commodity2,1,0)+ IF( SELF.Diff_commodity3,1,0)+ IF( SELF.Diff_commodity4,1,0)+ IF( SELF.Diff_commodity5,1,0)+ IF( SELF.Diff_commodity6,1,0)+ IF( SELF.Diff_commodity7,1,0)+ IF( SELF.Diff_commodity8,1,0)+ IF( SELF.Diff_completedate,1,0)+ IF( SELF.Diff_crossreference,1,0)+ IF( SELF.Diff_dateestablished,1,0)+ IF( SELF.Diff_businessage,1,0)+ IF( SELF.Diff_deposits,1,0)+ IF( SELF.Diff_dunsnumber,1,0)+ IF( SELF.Diff_enttype,1,0)+ IF( SELF.Diff_expirationdate,1,0)+ IF( SELF.Diff_extendeddate,1,0)+ IF( SELF.Diff_issuingauthority,1,0)+ IF( SELF.Diff_keywords,1,0)+ IF( SELF.Diff_licensenumber,1,0)+ IF( SELF.Diff_licensetype,1,0)+ IF( SELF.Diff_mincd,1,0)+ IF( SELF.Diff_minorityaffiliation,1,0)+ IF( SELF.Diff_minorityownershipdate,1,0)+ IF( SELF.Diff_siccode1,1,0)+ IF( SELF.Diff_siccode2,1,0)+ IF( SELF.Diff_siccode3,1,0)+ IF( SELF.Diff_siccode4,1,0)+ IF( SELF.Diff_siccode5,1,0)+ IF( SELF.Diff_siccode6,1,0)+ IF( SELF.Diff_siccode7,1,0)+ IF( SELF.Diff_siccode8,1,0)+ IF( SELF.Diff_naicscode1,1,0)+ IF( SELF.Diff_naicscode2,1,0)+ IF( SELF.Diff_naicscode3,1,0)+ IF( SELF.Diff_naicscode4,1,0)+ IF( SELF.Diff_naicscode5,1,0)+ IF( SELF.Diff_naicscode6,1,0)+ IF( SELF.Diff_naicscode7,1,0)+ IF( SELF.Diff_naicscode8,1,0)+ IF( SELF.Diff_prequalify,1,0)+ IF( SELF.Diff_procurementcategory1,1,0)+ IF( SELF.Diff_subprocurementcategory1,1,0)+ IF( SELF.Diff_procurementcategory2,1,0)+ IF( SELF.Diff_subprocurementcategory2,1,0)+ IF( SELF.Diff_procurementcategory3,1,0)+ IF( SELF.Diff_subprocurementcategory3,1,0)+ IF( SELF.Diff_procurementcategory4,1,0)+ IF( SELF.Diff_subprocurementcategory4,1,0)+ IF( SELF.Diff_procurementcategory5,1,0)+ IF( SELF.Diff_subprocurementcategory5,1,0)+ IF( SELF.Diff_renewal,1,0)+ IF( SELF.Diff_renewaldate,1,0)+ IF( SELF.Diff_unitedcertprogrampartner,1,0)+ IF( SELF.Diff_vendorkey,1,0)+ IF( SELF.Diff_vendornumber,1,0)+ IF( SELF.Diff_workcode1,1,0)+ IF( SELF.Diff_workcode2,1,0)+ IF( SELF.Diff_workcode3,1,0)+ IF( SELF.Diff_workcode4,1,0)+ IF( SELF.Diff_workcode5,1,0)+ IF( SELF.Diff_workcode6,1,0)+ IF( SELF.Diff_workcode7,1,0)+ IF( SELF.Diff_workcode8,1,0)+ IF( SELF.Diff_exporter,1,0)+ IF( SELF.Diff_exportbusinessactivities,1,0)+ IF( SELF.Diff_exportto,1,0)+ IF( SELF.Diff_exportbusinessrelationships,1,0)+ IF( SELF.Diff_exportobjectives,1,0)+ IF( SELF.Diff_reference1,1,0)+ IF( SELF.Diff_reference2,1,0)+ IF( SELF.Diff_reference3,1,0);
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
    Count_Diff_profilelastupdated := COUNT(GROUP,%Closest%.Diff_profilelastupdated);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_servicearea := COUNT(GROUP,%Closest%.Diff_servicearea);
    Count_Diff_region1 := COUNT(GROUP,%Closest%.Diff_region1);
    Count_Diff_region2 := COUNT(GROUP,%Closest%.Diff_region2);
    Count_Diff_region3 := COUNT(GROUP,%Closest%.Diff_region3);
    Count_Diff_region4 := COUNT(GROUP,%Closest%.Diff_region4);
    Count_Diff_region5 := COUNT(GROUP,%Closest%.Diff_region5);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_ethnicity := COUNT(GROUP,%Closest%.Diff_ethnicity);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_address1 := COUNT(GROUP,%Closest%.Diff_address1);
    Count_Diff_address2 := COUNT(GROUP,%Closest%.Diff_address2);
    Count_Diff_addresscity := COUNT(GROUP,%Closest%.Diff_addresscity);
    Count_Diff_addressstate := COUNT(GROUP,%Closest%.Diff_addressstate);
    Count_Diff_addresszipcode := COUNT(GROUP,%Closest%.Diff_addresszipcode);
    Count_Diff_addresszip4 := COUNT(GROUP,%Closest%.Diff_addresszip4);
    Count_Diff_building := COUNT(GROUP,%Closest%.Diff_building);
    Count_Diff_contact := COUNT(GROUP,%Closest%.Diff_contact);
    Count_Diff_phone1 := COUNT(GROUP,%Closest%.Diff_phone1);
    Count_Diff_phone2 := COUNT(GROUP,%Closest%.Diff_phone2);
    Count_Diff_phone3 := COUNT(GROUP,%Closest%.Diff_phone3);
    Count_Diff_cell := COUNT(GROUP,%Closest%.Diff_cell);
    Count_Diff_fax := COUNT(GROUP,%Closest%.Diff_fax);
    Count_Diff_email1 := COUNT(GROUP,%Closest%.Diff_email1);
    Count_Diff_email2 := COUNT(GROUP,%Closest%.Diff_email2);
    Count_Diff_email3 := COUNT(GROUP,%Closest%.Diff_email3);
    Count_Diff_webpage1 := COUNT(GROUP,%Closest%.Diff_webpage1);
    Count_Diff_webpage2 := COUNT(GROUP,%Closest%.Diff_webpage2);
    Count_Diff_webpage3 := COUNT(GROUP,%Closest%.Diff_webpage3);
    Count_Diff_businessname := COUNT(GROUP,%Closest%.Diff_businessname);
    Count_Diff_dba := COUNT(GROUP,%Closest%.Diff_dba);
    Count_Diff_businessid := COUNT(GROUP,%Closest%.Diff_businessid);
    Count_Diff_businesstype1 := COUNT(GROUP,%Closest%.Diff_businesstype1);
    Count_Diff_businesslocation1 := COUNT(GROUP,%Closest%.Diff_businesslocation1);
    Count_Diff_businesstype2 := COUNT(GROUP,%Closest%.Diff_businesstype2);
    Count_Diff_businesslocation2 := COUNT(GROUP,%Closest%.Diff_businesslocation2);
    Count_Diff_businesstype3 := COUNT(GROUP,%Closest%.Diff_businesstype3);
    Count_Diff_businesslocation3 := COUNT(GROUP,%Closest%.Diff_businesslocation3);
    Count_Diff_businesstype4 := COUNT(GROUP,%Closest%.Diff_businesstype4);
    Count_Diff_businesslocation4 := COUNT(GROUP,%Closest%.Diff_businesslocation4);
    Count_Diff_businesstype5 := COUNT(GROUP,%Closest%.Diff_businesstype5);
    Count_Diff_businesslocation5 := COUNT(GROUP,%Closest%.Diff_businesslocation5);
    Count_Diff_industry := COUNT(GROUP,%Closest%.Diff_industry);
    Count_Diff_trade := COUNT(GROUP,%Closest%.Diff_trade);
    Count_Diff_resourcedescription := COUNT(GROUP,%Closest%.Diff_resourcedescription);
    Count_Diff_natureofbusiness := COUNT(GROUP,%Closest%.Diff_natureofbusiness);
    Count_Diff_businessstructure := COUNT(GROUP,%Closest%.Diff_businessstructure);
    Count_Diff_totalemployees := COUNT(GROUP,%Closest%.Diff_totalemployees);
    Count_Diff_avgcontractsize := COUNT(GROUP,%Closest%.Diff_avgcontractsize);
    Count_Diff_firmid := COUNT(GROUP,%Closest%.Diff_firmid);
    Count_Diff_firmlocationaddress := COUNT(GROUP,%Closest%.Diff_firmlocationaddress);
    Count_Diff_firmlocationaddresscity := COUNT(GROUP,%Closest%.Diff_firmlocationaddresscity);
    Count_Diff_firmlocationaddresszip4 := COUNT(GROUP,%Closest%.Diff_firmlocationaddresszip4);
    Count_Diff_firmlocationaddresszipcode := COUNT(GROUP,%Closest%.Diff_firmlocationaddresszipcode);
    Count_Diff_firmlocationcounty := COUNT(GROUP,%Closest%.Diff_firmlocationcounty);
    Count_Diff_firmlocationstate := COUNT(GROUP,%Closest%.Diff_firmlocationstate);
    Count_Diff_certfed := COUNT(GROUP,%Closest%.Diff_certfed);
    Count_Diff_certstate := COUNT(GROUP,%Closest%.Diff_certstate);
    Count_Diff_contractsfederal := COUNT(GROUP,%Closest%.Diff_contractsfederal);
    Count_Diff_contractsva := COUNT(GROUP,%Closest%.Diff_contractsva);
    Count_Diff_contractscommercial := COUNT(GROUP,%Closest%.Diff_contractscommercial);
    Count_Diff_contractorgovernmentprime := COUNT(GROUP,%Closest%.Diff_contractorgovernmentprime);
    Count_Diff_contractorgovernmentsub := COUNT(GROUP,%Closest%.Diff_contractorgovernmentsub);
    Count_Diff_contractornongovernment := COUNT(GROUP,%Closest%.Diff_contractornongovernment);
    Count_Diff_registeredgovernmentbus := COUNT(GROUP,%Closest%.Diff_registeredgovernmentbus);
    Count_Diff_registerednongovernmentbus := COUNT(GROUP,%Closest%.Diff_registerednongovernmentbus);
    Count_Diff_clearancelevelpersonnel := COUNT(GROUP,%Closest%.Diff_clearancelevelpersonnel);
    Count_Diff_clearancelevelfacility := COUNT(GROUP,%Closest%.Diff_clearancelevelfacility);
    Count_Diff_certificatedatefrom1 := COUNT(GROUP,%Closest%.Diff_certificatedatefrom1);
    Count_Diff_certificatedateto1 := COUNT(GROUP,%Closest%.Diff_certificatedateto1);
    Count_Diff_certificatestatus1 := COUNT(GROUP,%Closest%.Diff_certificatestatus1);
    Count_Diff_certificationnumber1 := COUNT(GROUP,%Closest%.Diff_certificationnumber1);
    Count_Diff_certificationtype1 := COUNT(GROUP,%Closest%.Diff_certificationtype1);
    Count_Diff_certificatedatefrom2 := COUNT(GROUP,%Closest%.Diff_certificatedatefrom2);
    Count_Diff_certificatedateto2 := COUNT(GROUP,%Closest%.Diff_certificatedateto2);
    Count_Diff_certificatestatus2 := COUNT(GROUP,%Closest%.Diff_certificatestatus2);
    Count_Diff_certificationnumber2 := COUNT(GROUP,%Closest%.Diff_certificationnumber2);
    Count_Diff_certificationtype2 := COUNT(GROUP,%Closest%.Diff_certificationtype2);
    Count_Diff_certificatedatefrom3 := COUNT(GROUP,%Closest%.Diff_certificatedatefrom3);
    Count_Diff_certificatedateto3 := COUNT(GROUP,%Closest%.Diff_certificatedateto3);
    Count_Diff_certificatestatus3 := COUNT(GROUP,%Closest%.Diff_certificatestatus3);
    Count_Diff_certificationnumber3 := COUNT(GROUP,%Closest%.Diff_certificationnumber3);
    Count_Diff_certificationtype3 := COUNT(GROUP,%Closest%.Diff_certificationtype3);
    Count_Diff_certificatedatefrom4 := COUNT(GROUP,%Closest%.Diff_certificatedatefrom4);
    Count_Diff_certificatedateto4 := COUNT(GROUP,%Closest%.Diff_certificatedateto4);
    Count_Diff_certificatestatus4 := COUNT(GROUP,%Closest%.Diff_certificatestatus4);
    Count_Diff_certificationnumber4 := COUNT(GROUP,%Closest%.Diff_certificationnumber4);
    Count_Diff_certificationtype4 := COUNT(GROUP,%Closest%.Diff_certificationtype4);
    Count_Diff_certificatedatefrom5 := COUNT(GROUP,%Closest%.Diff_certificatedatefrom5);
    Count_Diff_certificatedateto5 := COUNT(GROUP,%Closest%.Diff_certificatedateto5);
    Count_Diff_certificatestatus5 := COUNT(GROUP,%Closest%.Diff_certificatestatus5);
    Count_Diff_certificationnumber5 := COUNT(GROUP,%Closest%.Diff_certificationnumber5);
    Count_Diff_certificationtype5 := COUNT(GROUP,%Closest%.Diff_certificationtype5);
    Count_Diff_certificatedatefrom6 := COUNT(GROUP,%Closest%.Diff_certificatedatefrom6);
    Count_Diff_certificatedateto6 := COUNT(GROUP,%Closest%.Diff_certificatedateto6);
    Count_Diff_certificatestatus6 := COUNT(GROUP,%Closest%.Diff_certificatestatus6);
    Count_Diff_certificationnumber6 := COUNT(GROUP,%Closest%.Diff_certificationnumber6);
    Count_Diff_certificationtype6 := COUNT(GROUP,%Closest%.Diff_certificationtype6);
    Count_Diff_starrating := COUNT(GROUP,%Closest%.Diff_starrating);
    Count_Diff_assets := COUNT(GROUP,%Closest%.Diff_assets);
    Count_Diff_biddescription := COUNT(GROUP,%Closest%.Diff_biddescription);
    Count_Diff_competitiveadvantage := COUNT(GROUP,%Closest%.Diff_competitiveadvantage);
    Count_Diff_cagecode := COUNT(GROUP,%Closest%.Diff_cagecode);
    Count_Diff_capabilitiesnarrative := COUNT(GROUP,%Closest%.Diff_capabilitiesnarrative);
    Count_Diff_category := COUNT(GROUP,%Closest%.Diff_category);
    Count_Diff_chtrclass := COUNT(GROUP,%Closest%.Diff_chtrclass);
    Count_Diff_productdescription1 := COUNT(GROUP,%Closest%.Diff_productdescription1);
    Count_Diff_productdescription2 := COUNT(GROUP,%Closest%.Diff_productdescription2);
    Count_Diff_productdescription3 := COUNT(GROUP,%Closest%.Diff_productdescription3);
    Count_Diff_productdescription4 := COUNT(GROUP,%Closest%.Diff_productdescription4);
    Count_Diff_productdescription5 := COUNT(GROUP,%Closest%.Diff_productdescription5);
    Count_Diff_classdescription1 := COUNT(GROUP,%Closest%.Diff_classdescription1);
    Count_Diff_subclassdescription1 := COUNT(GROUP,%Closest%.Diff_subclassdescription1);
    Count_Diff_classdescription2 := COUNT(GROUP,%Closest%.Diff_classdescription2);
    Count_Diff_subclassdescription2 := COUNT(GROUP,%Closest%.Diff_subclassdescription2);
    Count_Diff_classdescription3 := COUNT(GROUP,%Closest%.Diff_classdescription3);
    Count_Diff_subclassdescription3 := COUNT(GROUP,%Closest%.Diff_subclassdescription3);
    Count_Diff_classdescription4 := COUNT(GROUP,%Closest%.Diff_classdescription4);
    Count_Diff_subclassdescription4 := COUNT(GROUP,%Closest%.Diff_subclassdescription4);
    Count_Diff_classdescription5 := COUNT(GROUP,%Closest%.Diff_classdescription5);
    Count_Diff_subclassdescription5 := COUNT(GROUP,%Closest%.Diff_subclassdescription5);
    Count_Diff_classifications := COUNT(GROUP,%Closest%.Diff_classifications);
    Count_Diff_commodity1 := COUNT(GROUP,%Closest%.Diff_commodity1);
    Count_Diff_commodity2 := COUNT(GROUP,%Closest%.Diff_commodity2);
    Count_Diff_commodity3 := COUNT(GROUP,%Closest%.Diff_commodity3);
    Count_Diff_commodity4 := COUNT(GROUP,%Closest%.Diff_commodity4);
    Count_Diff_commodity5 := COUNT(GROUP,%Closest%.Diff_commodity5);
    Count_Diff_commodity6 := COUNT(GROUP,%Closest%.Diff_commodity6);
    Count_Diff_commodity7 := COUNT(GROUP,%Closest%.Diff_commodity7);
    Count_Diff_commodity8 := COUNT(GROUP,%Closest%.Diff_commodity8);
    Count_Diff_completedate := COUNT(GROUP,%Closest%.Diff_completedate);
    Count_Diff_crossreference := COUNT(GROUP,%Closest%.Diff_crossreference);
    Count_Diff_dateestablished := COUNT(GROUP,%Closest%.Diff_dateestablished);
    Count_Diff_businessage := COUNT(GROUP,%Closest%.Diff_businessage);
    Count_Diff_deposits := COUNT(GROUP,%Closest%.Diff_deposits);
    Count_Diff_dunsnumber := COUNT(GROUP,%Closest%.Diff_dunsnumber);
    Count_Diff_enttype := COUNT(GROUP,%Closest%.Diff_enttype);
    Count_Diff_expirationdate := COUNT(GROUP,%Closest%.Diff_expirationdate);
    Count_Diff_extendeddate := COUNT(GROUP,%Closest%.Diff_extendeddate);
    Count_Diff_issuingauthority := COUNT(GROUP,%Closest%.Diff_issuingauthority);
    Count_Diff_keywords := COUNT(GROUP,%Closest%.Diff_keywords);
    Count_Diff_licensenumber := COUNT(GROUP,%Closest%.Diff_licensenumber);
    Count_Diff_licensetype := COUNT(GROUP,%Closest%.Diff_licensetype);
    Count_Diff_mincd := COUNT(GROUP,%Closest%.Diff_mincd);
    Count_Diff_minorityaffiliation := COUNT(GROUP,%Closest%.Diff_minorityaffiliation);
    Count_Diff_minorityownershipdate := COUNT(GROUP,%Closest%.Diff_minorityownershipdate);
    Count_Diff_siccode1 := COUNT(GROUP,%Closest%.Diff_siccode1);
    Count_Diff_siccode2 := COUNT(GROUP,%Closest%.Diff_siccode2);
    Count_Diff_siccode3 := COUNT(GROUP,%Closest%.Diff_siccode3);
    Count_Diff_siccode4 := COUNT(GROUP,%Closest%.Diff_siccode4);
    Count_Diff_siccode5 := COUNT(GROUP,%Closest%.Diff_siccode5);
    Count_Diff_siccode6 := COUNT(GROUP,%Closest%.Diff_siccode6);
    Count_Diff_siccode7 := COUNT(GROUP,%Closest%.Diff_siccode7);
    Count_Diff_siccode8 := COUNT(GROUP,%Closest%.Diff_siccode8);
    Count_Diff_naicscode1 := COUNT(GROUP,%Closest%.Diff_naicscode1);
    Count_Diff_naicscode2 := COUNT(GROUP,%Closest%.Diff_naicscode2);
    Count_Diff_naicscode3 := COUNT(GROUP,%Closest%.Diff_naicscode3);
    Count_Diff_naicscode4 := COUNT(GROUP,%Closest%.Diff_naicscode4);
    Count_Diff_naicscode5 := COUNT(GROUP,%Closest%.Diff_naicscode5);
    Count_Diff_naicscode6 := COUNT(GROUP,%Closest%.Diff_naicscode6);
    Count_Diff_naicscode7 := COUNT(GROUP,%Closest%.Diff_naicscode7);
    Count_Diff_naicscode8 := COUNT(GROUP,%Closest%.Diff_naicscode8);
    Count_Diff_prequalify := COUNT(GROUP,%Closest%.Diff_prequalify);
    Count_Diff_procurementcategory1 := COUNT(GROUP,%Closest%.Diff_procurementcategory1);
    Count_Diff_subprocurementcategory1 := COUNT(GROUP,%Closest%.Diff_subprocurementcategory1);
    Count_Diff_procurementcategory2 := COUNT(GROUP,%Closest%.Diff_procurementcategory2);
    Count_Diff_subprocurementcategory2 := COUNT(GROUP,%Closest%.Diff_subprocurementcategory2);
    Count_Diff_procurementcategory3 := COUNT(GROUP,%Closest%.Diff_procurementcategory3);
    Count_Diff_subprocurementcategory3 := COUNT(GROUP,%Closest%.Diff_subprocurementcategory3);
    Count_Diff_procurementcategory4 := COUNT(GROUP,%Closest%.Diff_procurementcategory4);
    Count_Diff_subprocurementcategory4 := COUNT(GROUP,%Closest%.Diff_subprocurementcategory4);
    Count_Diff_procurementcategory5 := COUNT(GROUP,%Closest%.Diff_procurementcategory5);
    Count_Diff_subprocurementcategory5 := COUNT(GROUP,%Closest%.Diff_subprocurementcategory5);
    Count_Diff_renewal := COUNT(GROUP,%Closest%.Diff_renewal);
    Count_Diff_renewaldate := COUNT(GROUP,%Closest%.Diff_renewaldate);
    Count_Diff_unitedcertprogrampartner := COUNT(GROUP,%Closest%.Diff_unitedcertprogrampartner);
    Count_Diff_vendorkey := COUNT(GROUP,%Closest%.Diff_vendorkey);
    Count_Diff_vendornumber := COUNT(GROUP,%Closest%.Diff_vendornumber);
    Count_Diff_workcode1 := COUNT(GROUP,%Closest%.Diff_workcode1);
    Count_Diff_workcode2 := COUNT(GROUP,%Closest%.Diff_workcode2);
    Count_Diff_workcode3 := COUNT(GROUP,%Closest%.Diff_workcode3);
    Count_Diff_workcode4 := COUNT(GROUP,%Closest%.Diff_workcode4);
    Count_Diff_workcode5 := COUNT(GROUP,%Closest%.Diff_workcode5);
    Count_Diff_workcode6 := COUNT(GROUP,%Closest%.Diff_workcode6);
    Count_Diff_workcode7 := COUNT(GROUP,%Closest%.Diff_workcode7);
    Count_Diff_workcode8 := COUNT(GROUP,%Closest%.Diff_workcode8);
    Count_Diff_exporter := COUNT(GROUP,%Closest%.Diff_exporter);
    Count_Diff_exportbusinessactivities := COUNT(GROUP,%Closest%.Diff_exportbusinessactivities);
    Count_Diff_exportto := COUNT(GROUP,%Closest%.Diff_exportto);
    Count_Diff_exportbusinessrelationships := COUNT(GROUP,%Closest%.Diff_exportbusinessrelationships);
    Count_Diff_exportobjectives := COUNT(GROUP,%Closest%.Diff_exportobjectives);
    Count_Diff_reference1 := COUNT(GROUP,%Closest%.Diff_reference1);
    Count_Diff_reference2 := COUNT(GROUP,%Closest%.Diff_reference2);
    Count_Diff_reference3 := COUNT(GROUP,%Closest%.Diff_reference3);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
