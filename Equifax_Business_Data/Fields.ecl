IMPORT SALT37;
EXPORT Fields := MODULE
 
EXPORT SALT37.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dt_effective_first','dt_effective_last','process_date','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','did','did_score','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_type','EFX_ID','EFX_NAME','EFX_LEGAL_NAME','EFX_ADDRESS','EFX_CITY','EFX_STATE','EFX_STATEC','EFX_ZIPCODE','EFX_ZIP4','EFX_LAT','EFX_LON','EFX_GEOPREC','EFX_REGION','EFX_CTRYISOCD','EFX_CTRYNUM','EFX_CTRYNAME','EFX_COUNTYNM','EFX_COUNTY','EFX_CMSA','EFX_CMSADESC','EFX_SOHO','EFX_BIZ','EFX_RES','EFX_CMRA','EFX_CONGRESS','EFX_SECADR','EFX_SECCTY','EFX_SECSTAT','EFX_STATEC2','EFX_SECZIP','EFX_SECZIP4','EFX_SECLAT','EFX_SECLON','EFX_SECGEOPREC','EFX_SECREGION','EFX_SECCTRYISOCD','EFX_SECCTRYNUM','EFX_SECCTRYNAME','EFX_CTRYTELCD','EFX_PHONE','EFX_FAXPHONE','EFX_BUSSTAT','EFX_BUSSTATCD','EFX_WEB','EFX_YREST','EFX_CORPEMPCNT','EFX_LOCEMPCNT','EFX_CORPEMPCD','EFX_LOCEMPCD','EFX_CORPAMOUNT','EFX_CORPAMOUNTCD','EFX_CORPAMOUNTTP','EFX_CORPAMOUNTPREC','EFX_LOCAMOUNT','EFX_LOCAMOUNTCD','EFX_LOCAMOUNTTP','EFX_LOCAMOUNTPREC','EFX_PUBLIC','EFX_STKEXC','EFX_TCKSYM','EFX_PRIMSIC','EFX_SECSIC1','EFX_SECSIC2','EFX_SECSIC3','EFX_SECSIC4','EFX_PRIMSICDESC','EFX_SECSICDESC1','EFX_SECSICDESC2','EFX_SECSICDESC3','EFX_SECSICDESC4','EFX_PRIMNAICSCODE','EFX_SECNAICS1','EFX_SECNAICS2','EFX_SECNAICS3','EFX_SECNAICS4','EFX_PRIMNAICSDESC','EFX_SECNAICSDESC1','EFX_SECNAICSDESC2','EFX_SECNAICSDESC3','EFX_SECNAICSDESC4','EFX_DEAD','EFX_DEADDT','EFX_MRKT_TELEVER','EFX_MRKT_TELESCORE','EFX_MRKT_TOTALSCORE','EFX_MRKT_TOTALIND','EFX_MRKT_VACANT','EFX_MRKT_SEASONAL','EFX_MBE','EFX_WBE','EFX_MWBE','EFX_SDB','EFX_HUBZONE','EFX_DBE','EFX_VET','EFX_DVET','EFX_8a','EFX_8aEXPDT','EFX_DIS','EFX_SBE','EFX_BUSSIZE','EFX_LBE','EFX_GOV','EFX_FGOV','EFX_GOV1057','EFX_NONPROFIT','EFX_MERCTYPE','EFX_HBCU','EFX_GAYLESBIAN','EFX_WSBE','EFX_VSBE','EFX_DVSBE','EFX_MWBESTATUS','EFX_NMSDC','EFX_WBENC','EFX_CA_PUC','EFX_TX_HUB','EFX_TX_HUBCERTNUM','EFX_GSAX','EFX_CALTRANS','EFX_EDU','EFX_MI','EFX_ANC','AT_CERT1','AT_CERT2','AT_CERT3','AT_CERT4','AT_CERT5','AT_CERT6','AT_CERT7','AT_CERT8','AT_CERT9','AT_CERT10','AT_CERTDESC1','AT_CERTDESC2','AT_CERTDESC3','AT_CERTDESC4','AT_CERTDESC5','AT_CERTDESC6','AT_CERTDESC7','AT_CERTDESC8','AT_CERTDESC9','AT_CERTDESC10','AT_CERTSRC1','AT_CERTSRC2','AT_CERTSRC3','AT_CERTSRC4','AT_CERTSRC5','AT_CERTSRC6','AT_CERTSRC7','AT_CERTSRC8','AT_CERTSRC9','AT_CERTSRC10','AT_CERTLEV1','AT_CERTLEV2','AT_CERTLEV3','AT_CERTLEV4','AT_CERTLEV5','AT_CERTLEV6','AT_CERTLEV7','AT_CERTLEV8','AT_CERTLEV9','AT_CERTLEV10','AT_CERTNUM1','AT_CERTNUM2','AT_CERTNUM3','AT_CERTNUM4','AT_CERTNUM5','AT_CERTNUM6','AT_CERTNUM7','AT_CERTNUM8','AT_CERTNUM9','AT_CERTNUM10','AT_CERTEXP1','AT_CERTEXP2','AT_CERTEXP3','AT_CERTEXP4','AT_CERTEXP5','AT_CERTEXP6','AT_CERTEXP7','AT_CERTEXP8','AT_CERTEXP9','AT_CERTEXP10','EFX_EXTRACT_DATE','EFX_MERCHANT_ID','EFX_PROJECT_ID','EFX_FOREIGN','Record_Update_Refresh_Date','EFX_DATE_CREATED','normCompany_Name','normCompany_Type','Norm_Geo_Precision','Norm_Corporate_Amount_Precision','Norm_Location_Amount_Precision','Norm_Public_Co_Indicator','Norm_Stock_Exchange','Norm_Telemarketablity_Score','Norm_Telemarketablity_Total_Indicator','Norm_Telemarketablity_Total_Score','Norm_Government1057_Entity','Norm_Merchant_Type','NormAddress_Type','Norm_Address','Norm_City','Norm_State','Norm_StateC2','Norm_Zip','Norm_Zip4','Norm_Lat','Norm_Lon','Norm_Geoprec','Norm_Region','Norm_Ctryisocd','Norm_Ctrynum','Norm_Ctryname','clean_company_name','clean_phone','clean_secondary_phone','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','cart','cr_sort_sz');
EXPORT FieldNum(SALT37.StrType fn) := CASE(fn,'dt_effective_first' => 0,'dt_effective_last' => 1,'process_date' => 2,'dotid' => 3,'dotscore' => 4,'dotweight' => 5,'empid' => 6,'empscore' => 7,'empweight' => 8,'powid' => 9,'powscore' => 10,'powweight' => 11,'proxid' => 12,'proxscore' => 13,'proxweight' => 14,'selescore' => 15,'seleweight' => 16,'orgid' => 17,'orgscore' => 18,'orgweight' => 19,'ultid' => 20,'ultscore' => 21,'ultweight' => 22,'did' => 23,'did_score' => 24,'dt_first_seen' => 25,'dt_last_seen' => 26,'dt_vendor_first_reported' => 27,'dt_vendor_last_reported' => 28,'record_type' => 29,'EFX_ID' => 30,'EFX_NAME' => 31,'EFX_LEGAL_NAME' => 32,'EFX_ADDRESS' => 33,'EFX_CITY' => 34,'EFX_STATE' => 35,'EFX_STATEC' => 36,'EFX_ZIPCODE' => 37,'EFX_ZIP4' => 38,'EFX_LAT' => 39,'EFX_LON' => 40,'EFX_GEOPREC' => 41,'EFX_REGION' => 42,'EFX_CTRYISOCD' => 43,'EFX_CTRYNUM' => 44,'EFX_CTRYNAME' => 45,'EFX_COUNTYNM' => 46,'EFX_COUNTY' => 47,'EFX_CMSA' => 48,'EFX_CMSADESC' => 49,'EFX_SOHO' => 50,'EFX_BIZ' => 51,'EFX_RES' => 52,'EFX_CMRA' => 53,'EFX_CONGRESS' => 54,'EFX_SECADR' => 55,'EFX_SECCTY' => 56,'EFX_SECSTAT' => 57,'EFX_STATEC2' => 58,'EFX_SECZIP' => 59,'EFX_SECZIP4' => 60,'EFX_SECLAT' => 61,'EFX_SECLON' => 62,'EFX_SECGEOPREC' => 63,'EFX_SECREGION' => 64,'EFX_SECCTRYISOCD' => 65,'EFX_SECCTRYNUM' => 66,'EFX_SECCTRYNAME' => 67,'EFX_CTRYTELCD' => 68,'EFX_PHONE' => 69,'EFX_FAXPHONE' => 70,'EFX_BUSSTAT' => 71,'EFX_BUSSTATCD' => 72,'EFX_WEB' => 73,'EFX_YREST' => 74,'EFX_CORPEMPCNT' => 75,'EFX_LOCEMPCNT' => 76,'EFX_CORPEMPCD' => 77,'EFX_LOCEMPCD' => 78,'EFX_CORPAMOUNT' => 79,'EFX_CORPAMOUNTCD' => 80,'EFX_CORPAMOUNTTP' => 81,'EFX_CORPAMOUNTPREC' => 82,'EFX_LOCAMOUNT' => 83,'EFX_LOCAMOUNTCD' => 84,'EFX_LOCAMOUNTTP' => 85,'EFX_LOCAMOUNTPREC' => 86,'EFX_PUBLIC' => 87,'EFX_STKEXC' => 88,'EFX_TCKSYM' => 89,'EFX_PRIMSIC' => 90,'EFX_SECSIC1' => 91,'EFX_SECSIC2' => 92,'EFX_SECSIC3' => 93,'EFX_SECSIC4' => 94,'EFX_PRIMSICDESC' => 95,'EFX_SECSICDESC1' => 96,'EFX_SECSICDESC2' => 97,'EFX_SECSICDESC3' => 98,'EFX_SECSICDESC4' => 99,'EFX_PRIMNAICSCODE' => 100,'EFX_SECNAICS1' => 101,'EFX_SECNAICS2' => 102,'EFX_SECNAICS3' => 103,'EFX_SECNAICS4' => 104,'EFX_PRIMNAICSDESC' => 105,'EFX_SECNAICSDESC1' => 106,'EFX_SECNAICSDESC2' => 107,'EFX_SECNAICSDESC3' => 108,'EFX_SECNAICSDESC4' => 109,'EFX_DEAD' => 110,'EFX_DEADDT' => 111,'EFX_MRKT_TELEVER' => 112,'EFX_MRKT_TELESCORE' => 113,'EFX_MRKT_TOTALSCORE' => 114,'EFX_MRKT_TOTALIND' => 115,'EFX_MRKT_VACANT' => 116,'EFX_MRKT_SEASONAL' => 117,'EFX_MBE' => 118,'EFX_WBE' => 119,'EFX_MWBE' => 120,'EFX_SDB' => 121,'EFX_HUBZONE' => 122,'EFX_DBE' => 123,'EFX_VET' => 124,'EFX_DVET' => 125,'EFX_8a' => 126,'EFX_8aEXPDT' => 127,'EFX_DIS' => 128,'EFX_SBE' => 129,'EFX_BUSSIZE' => 130,'EFX_LBE' => 131,'EFX_GOV' => 132,'EFX_FGOV' => 133,'EFX_GOV1057' => 134,'EFX_NONPROFIT' => 135,'EFX_MERCTYPE' => 136,'EFX_HBCU' => 137,'EFX_GAYLESBIAN' => 138,'EFX_WSBE' => 139,'EFX_VSBE' => 140,'EFX_DVSBE' => 141,'EFX_MWBESTATUS' => 142,'EFX_NMSDC' => 143,'EFX_WBENC' => 144,'EFX_CA_PUC' => 145,'EFX_TX_HUB' => 146,'EFX_TX_HUBCERTNUM' => 147,'EFX_GSAX' => 148,'EFX_CALTRANS' => 149,'EFX_EDU' => 150,'EFX_MI' => 151,'EFX_ANC' => 152,'AT_CERT1' => 153,'AT_CERT2' => 154,'AT_CERT3' => 155,'AT_CERT4' => 156,'AT_CERT5' => 157,'AT_CERT6' => 158,'AT_CERT7' => 159,'AT_CERT8' => 160,'AT_CERT9' => 161,'AT_CERT10' => 162,'AT_CERTDESC1' => 163,'AT_CERTDESC2' => 164,'AT_CERTDESC3' => 165,'AT_CERTDESC4' => 166,'AT_CERTDESC5' => 167,'AT_CERTDESC6' => 168,'AT_CERTDESC7' => 169,'AT_CERTDESC8' => 170,'AT_CERTDESC9' => 171,'AT_CERTDESC10' => 172,'AT_CERTSRC1' => 173,'AT_CERTSRC2' => 174,'AT_CERTSRC3' => 175,'AT_CERTSRC4' => 176,'AT_CERTSRC5' => 177,'AT_CERTSRC6' => 178,'AT_CERTSRC7' => 179,'AT_CERTSRC8' => 180,'AT_CERTSRC9' => 181,'AT_CERTSRC10' => 182,'AT_CERTLEV1' => 183,'AT_CERTLEV2' => 184,'AT_CERTLEV3' => 185,'AT_CERTLEV4' => 186,'AT_CERTLEV5' => 187,'AT_CERTLEV6' => 188,'AT_CERTLEV7' => 189,'AT_CERTLEV8' => 190,'AT_CERTLEV9' => 191,'AT_CERTLEV10' => 192,'AT_CERTNUM1' => 193,'AT_CERTNUM2' => 194,'AT_CERTNUM3' => 195,'AT_CERTNUM4' => 196,'AT_CERTNUM5' => 197,'AT_CERTNUM6' => 198,'AT_CERTNUM7' => 199,'AT_CERTNUM8' => 200,'AT_CERTNUM9' => 201,'AT_CERTNUM10' => 202,'AT_CERTEXP1' => 203,'AT_CERTEXP2' => 204,'AT_CERTEXP3' => 205,'AT_CERTEXP4' => 206,'AT_CERTEXP5' => 207,'AT_CERTEXP6' => 208,'AT_CERTEXP7' => 209,'AT_CERTEXP8' => 210,'AT_CERTEXP9' => 211,'AT_CERTEXP10' => 212,'EFX_EXTRACT_DATE' => 213,'EFX_MERCHANT_ID' => 214,'EFX_PROJECT_ID' => 215,'EFX_FOREIGN' => 216,'Record_Update_Refresh_Date' => 217,'EFX_DATE_CREATED' => 218,'normCompany_Name' => 219,'normCompany_Type' => 220,'Norm_Geo_Precision' => 221,'Norm_Corporate_Amount_Precision' => 222,'Norm_Location_Amount_Precision' => 223,'Norm_Public_Co_Indicator' => 224,'Norm_Stock_Exchange' => 225,'Norm_Telemarketablity_Score' => 226,'Norm_Telemarketablity_Total_Indicator' => 227,'Norm_Telemarketablity_Total_Score' => 228,'Norm_Government1057_Entity' => 229,'Norm_Merchant_Type' => 230,'NormAddress_Type' => 231,'Norm_Address' => 232,'Norm_City' => 233,'Norm_State' => 234,'Norm_StateC2' => 235,'Norm_Zip' => 236,'Norm_Zip4' => 237,'Norm_Lat' => 238,'Norm_Lon' => 239,'Norm_Geoprec' => 240,'Norm_Region' => 241,'Norm_Ctryisocd' => 242,'Norm_Ctrynum' => 243,'Norm_Ctryname' => 244,'clean_company_name' => 245,'clean_phone' => 246,'clean_secondary_phone' => 247,'title' => 248,'fname' => 249,'mname' => 250,'lname' => 251,'name_suffix' => 252,'name_score' => 253,'prim_range' => 254,'predir' => 255,'prim_name' => 256,'addr_suffix' => 257,'postdir' => 258,'unit_desig' => 259,'sec_range' => 260,'p_city_name' => 261,'v_city_name' => 262,'st' => 263,'cart' => 264,'cr_sort_sz' => 265,0);
 
//Individual field level validation
 
EXPORT Make_dt_effective_first(SALT37.StrType s0) := s0;
EXPORT InValid_dt_effective_first(SALT37.StrType s) := 0;
EXPORT InValidMessage_dt_effective_first(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_effective_last(SALT37.StrType s0) := s0;
EXPORT InValid_dt_effective_last(SALT37.StrType s) := 0;
EXPORT InValidMessage_dt_effective_last(UNSIGNED1 wh) := '';
 
EXPORT Make_process_date(SALT37.StrType s0) := s0;
EXPORT InValid_process_date(SALT37.StrType s) := 0;
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := '';
 
EXPORT Make_dotid(SALT37.StrType s0) := s0;
EXPORT InValid_dotid(SALT37.StrType s) := 0;
EXPORT InValidMessage_dotid(UNSIGNED1 wh) := '';
 
EXPORT Make_dotscore(SALT37.StrType s0) := s0;
EXPORT InValid_dotscore(SALT37.StrType s) := 0;
EXPORT InValidMessage_dotscore(UNSIGNED1 wh) := '';
 
EXPORT Make_dotweight(SALT37.StrType s0) := s0;
EXPORT InValid_dotweight(SALT37.StrType s) := 0;
EXPORT InValidMessage_dotweight(UNSIGNED1 wh) := '';
 
EXPORT Make_empid(SALT37.StrType s0) := s0;
EXPORT InValid_empid(SALT37.StrType s) := 0;
EXPORT InValidMessage_empid(UNSIGNED1 wh) := '';
 
EXPORT Make_empscore(SALT37.StrType s0) := s0;
EXPORT InValid_empscore(SALT37.StrType s) := 0;
EXPORT InValidMessage_empscore(UNSIGNED1 wh) := '';
 
EXPORT Make_empweight(SALT37.StrType s0) := s0;
EXPORT InValid_empweight(SALT37.StrType s) := 0;
EXPORT InValidMessage_empweight(UNSIGNED1 wh) := '';
 
EXPORT Make_powid(SALT37.StrType s0) := s0;
EXPORT InValid_powid(SALT37.StrType s) := 0;
EXPORT InValidMessage_powid(UNSIGNED1 wh) := '';
 
EXPORT Make_powscore(SALT37.StrType s0) := s0;
EXPORT InValid_powscore(SALT37.StrType s) := 0;
EXPORT InValidMessage_powscore(UNSIGNED1 wh) := '';
 
EXPORT Make_powweight(SALT37.StrType s0) := s0;
EXPORT InValid_powweight(SALT37.StrType s) := 0;
EXPORT InValidMessage_powweight(UNSIGNED1 wh) := '';
 
EXPORT Make_proxid(SALT37.StrType s0) := s0;
EXPORT InValid_proxid(SALT37.StrType s) := 0;
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := '';
 
EXPORT Make_proxscore(SALT37.StrType s0) := s0;
EXPORT InValid_proxscore(SALT37.StrType s) := 0;
EXPORT InValidMessage_proxscore(UNSIGNED1 wh) := '';
 
EXPORT Make_proxweight(SALT37.StrType s0) := s0;
EXPORT InValid_proxweight(SALT37.StrType s) := 0;
EXPORT InValidMessage_proxweight(UNSIGNED1 wh) := '';
 
EXPORT Make_selescore(SALT37.StrType s0) := s0;
EXPORT InValid_selescore(SALT37.StrType s) := 0;
EXPORT InValidMessage_selescore(UNSIGNED1 wh) := '';
 
EXPORT Make_seleweight(SALT37.StrType s0) := s0;
EXPORT InValid_seleweight(SALT37.StrType s) := 0;
EXPORT InValidMessage_seleweight(UNSIGNED1 wh) := '';
 
EXPORT Make_orgid(SALT37.StrType s0) := s0;
EXPORT InValid_orgid(SALT37.StrType s) := 0;
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := '';
 
EXPORT Make_orgscore(SALT37.StrType s0) := s0;
EXPORT InValid_orgscore(SALT37.StrType s) := 0;
EXPORT InValidMessage_orgscore(UNSIGNED1 wh) := '';
 
EXPORT Make_orgweight(SALT37.StrType s0) := s0;
EXPORT InValid_orgweight(SALT37.StrType s) := 0;
EXPORT InValidMessage_orgweight(UNSIGNED1 wh) := '';
 
EXPORT Make_ultid(SALT37.StrType s0) := s0;
EXPORT InValid_ultid(SALT37.StrType s) := 0;
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := '';
 
EXPORT Make_ultscore(SALT37.StrType s0) := s0;
EXPORT InValid_ultscore(SALT37.StrType s) := 0;
EXPORT InValidMessage_ultscore(UNSIGNED1 wh) := '';
 
EXPORT Make_ultweight(SALT37.StrType s0) := s0;
EXPORT InValid_ultweight(SALT37.StrType s) := 0;
EXPORT InValidMessage_ultweight(UNSIGNED1 wh) := '';
 
EXPORT Make_did(SALT37.StrType s0) := s0;
EXPORT InValid_did(SALT37.StrType s) := 0;
EXPORT InValidMessage_did(UNSIGNED1 wh) := '';
 
EXPORT Make_did_score(SALT37.StrType s0) := s0;
EXPORT InValid_did_score(SALT37.StrType s) := 0;
EXPORT InValidMessage_did_score(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_first_seen(SALT37.StrType s0) := s0;
EXPORT InValid_dt_first_seen(SALT37.StrType s) := 0;
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_last_seen(SALT37.StrType s0) := s0;
EXPORT InValid_dt_last_seen(SALT37.StrType s) := 0;
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_vendor_first_reported(SALT37.StrType s0) := s0;
EXPORT InValid_dt_vendor_first_reported(SALT37.StrType s) := 0;
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := '';
 
EXPORT Make_dt_vendor_last_reported(SALT37.StrType s0) := s0;
EXPORT InValid_dt_vendor_last_reported(SALT37.StrType s) := 0;
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := '';
 
EXPORT Make_record_type(SALT37.StrType s0) := s0;
EXPORT InValid_record_type(SALT37.StrType s) := 0;
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_ID(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_ID(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_ID(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_NAME(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_NAME(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_NAME(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_LEGAL_NAME(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_LEGAL_NAME(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_LEGAL_NAME(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_ADDRESS(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_ADDRESS(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_ADDRESS(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_CITY(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_CITY(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_CITY(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_STATE(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_STATE(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_STATE(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_STATEC(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_STATEC(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_STATEC(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_ZIPCODE(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_ZIPCODE(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_ZIPCODE(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_ZIP4(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_ZIP4(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_ZIP4(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_LAT(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_LAT(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_LAT(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_LON(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_LON(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_LON(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_GEOPREC(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_GEOPREC(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_GEOPREC(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_REGION(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_REGION(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_REGION(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_CTRYISOCD(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_CTRYISOCD(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_CTRYISOCD(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_CTRYNUM(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_CTRYNUM(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_CTRYNUM(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_CTRYNAME(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_CTRYNAME(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_CTRYNAME(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_COUNTYNM(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_COUNTYNM(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_COUNTYNM(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_COUNTY(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_COUNTY(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_COUNTY(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_CMSA(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_CMSA(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_CMSA(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_CMSADESC(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_CMSADESC(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_CMSADESC(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SOHO(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SOHO(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SOHO(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_BIZ(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_BIZ(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_BIZ(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_RES(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_RES(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_RES(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_CMRA(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_CMRA(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_CMRA(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_CONGRESS(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_CONGRESS(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_CONGRESS(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECADR(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECADR(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECADR(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECCTY(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECCTY(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECCTY(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECSTAT(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECSTAT(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECSTAT(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_STATEC2(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_STATEC2(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_STATEC2(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECZIP(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECZIP(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECZIP(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECZIP4(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECZIP4(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECZIP4(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECLAT(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECLAT(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECLAT(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECLON(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECLON(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECLON(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECGEOPREC(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECGEOPREC(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECGEOPREC(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECREGION(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECREGION(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECREGION(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECCTRYISOCD(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECCTRYISOCD(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECCTRYISOCD(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECCTRYNUM(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECCTRYNUM(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECCTRYNUM(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECCTRYNAME(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECCTRYNAME(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECCTRYNAME(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_CTRYTELCD(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_CTRYTELCD(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_CTRYTELCD(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_PHONE(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_PHONE(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_PHONE(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_FAXPHONE(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_FAXPHONE(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_FAXPHONE(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_BUSSTAT(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_BUSSTAT(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_BUSSTAT(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_BUSSTATCD(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_BUSSTATCD(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_BUSSTATCD(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_WEB(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_WEB(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_WEB(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_YREST(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_YREST(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_YREST(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_CORPEMPCNT(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_CORPEMPCNT(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_CORPEMPCNT(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_LOCEMPCNT(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_LOCEMPCNT(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_LOCEMPCNT(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_CORPEMPCD(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_CORPEMPCD(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_CORPEMPCD(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_LOCEMPCD(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_LOCEMPCD(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_LOCEMPCD(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_CORPAMOUNT(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_CORPAMOUNT(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_CORPAMOUNT(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_CORPAMOUNTCD(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_CORPAMOUNTCD(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_CORPAMOUNTCD(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_CORPAMOUNTTP(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_CORPAMOUNTTP(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_CORPAMOUNTTP(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_CORPAMOUNTPREC(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_CORPAMOUNTPREC(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_CORPAMOUNTPREC(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_LOCAMOUNT(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_LOCAMOUNT(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_LOCAMOUNT(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_LOCAMOUNTCD(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_LOCAMOUNTCD(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_LOCAMOUNTCD(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_LOCAMOUNTTP(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_LOCAMOUNTTP(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_LOCAMOUNTTP(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_LOCAMOUNTPREC(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_LOCAMOUNTPREC(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_LOCAMOUNTPREC(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_PUBLIC(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_PUBLIC(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_PUBLIC(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_STKEXC(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_STKEXC(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_STKEXC(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_TCKSYM(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_TCKSYM(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_TCKSYM(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_PRIMSIC(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_PRIMSIC(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_PRIMSIC(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECSIC1(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECSIC1(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECSIC1(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECSIC2(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECSIC2(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECSIC2(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECSIC3(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECSIC3(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECSIC3(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECSIC4(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECSIC4(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECSIC4(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_PRIMSICDESC(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_PRIMSICDESC(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_PRIMSICDESC(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECSICDESC1(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECSICDESC1(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECSICDESC1(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECSICDESC2(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECSICDESC2(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECSICDESC2(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECSICDESC3(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECSICDESC3(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECSICDESC3(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECSICDESC4(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECSICDESC4(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECSICDESC4(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_PRIMNAICSCODE(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_PRIMNAICSCODE(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_PRIMNAICSCODE(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECNAICS1(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECNAICS1(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECNAICS1(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECNAICS2(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECNAICS2(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECNAICS2(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECNAICS3(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECNAICS3(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECNAICS3(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECNAICS4(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECNAICS4(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECNAICS4(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_PRIMNAICSDESC(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_PRIMNAICSDESC(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_PRIMNAICSDESC(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECNAICSDESC1(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECNAICSDESC1(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECNAICSDESC1(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECNAICSDESC2(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECNAICSDESC2(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECNAICSDESC2(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECNAICSDESC3(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECNAICSDESC3(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECNAICSDESC3(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SECNAICSDESC4(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SECNAICSDESC4(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SECNAICSDESC4(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_DEAD(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_DEAD(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_DEAD(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_DEADDT(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_DEADDT(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_DEADDT(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_MRKT_TELEVER(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_MRKT_TELEVER(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_MRKT_TELEVER(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_MRKT_TELESCORE(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_MRKT_TELESCORE(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_MRKT_TELESCORE(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_MRKT_TOTALSCORE(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_MRKT_TOTALSCORE(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_MRKT_TOTALSCORE(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_MRKT_TOTALIND(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_MRKT_TOTALIND(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_MRKT_TOTALIND(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_MRKT_VACANT(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_MRKT_VACANT(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_MRKT_VACANT(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_MRKT_SEASONAL(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_MRKT_SEASONAL(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_MRKT_SEASONAL(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_MBE(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_MBE(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_MBE(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_WBE(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_WBE(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_WBE(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_MWBE(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_MWBE(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_MWBE(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SDB(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SDB(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SDB(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_HUBZONE(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_HUBZONE(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_HUBZONE(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_DBE(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_DBE(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_DBE(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_VET(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_VET(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_VET(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_DVET(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_DVET(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_DVET(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_8a(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_8a(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_8a(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_8aEXPDT(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_8aEXPDT(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_8aEXPDT(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_DIS(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_DIS(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_DIS(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_SBE(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_SBE(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_SBE(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_BUSSIZE(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_BUSSIZE(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_BUSSIZE(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_LBE(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_LBE(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_LBE(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_GOV(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_GOV(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_GOV(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_FGOV(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_FGOV(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_FGOV(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_GOV1057(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_GOV1057(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_GOV1057(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_NONPROFIT(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_NONPROFIT(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_NONPROFIT(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_MERCTYPE(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_MERCTYPE(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_MERCTYPE(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_HBCU(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_HBCU(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_HBCU(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_GAYLESBIAN(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_GAYLESBIAN(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_GAYLESBIAN(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_WSBE(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_WSBE(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_WSBE(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_VSBE(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_VSBE(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_VSBE(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_DVSBE(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_DVSBE(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_DVSBE(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_MWBESTATUS(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_MWBESTATUS(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_MWBESTATUS(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_NMSDC(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_NMSDC(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_NMSDC(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_WBENC(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_WBENC(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_WBENC(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_CA_PUC(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_CA_PUC(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_CA_PUC(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_TX_HUB(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_TX_HUB(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_TX_HUB(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_TX_HUBCERTNUM(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_TX_HUBCERTNUM(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_TX_HUBCERTNUM(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_GSAX(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_GSAX(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_GSAX(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_CALTRANS(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_CALTRANS(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_CALTRANS(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_EDU(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_EDU(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_EDU(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_MI(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_MI(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_MI(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_ANC(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_ANC(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_ANC(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERT1(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERT1(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERT1(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERT2(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERT2(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERT2(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERT3(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERT3(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERT3(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERT4(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERT4(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERT4(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERT5(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERT5(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERT5(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERT6(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERT6(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERT6(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERT7(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERT7(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERT7(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERT8(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERT8(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERT8(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERT9(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERT9(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERT9(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERT10(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERT10(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERT10(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTDESC1(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTDESC1(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTDESC1(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTDESC2(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTDESC2(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTDESC2(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTDESC3(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTDESC3(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTDESC3(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTDESC4(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTDESC4(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTDESC4(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTDESC5(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTDESC5(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTDESC5(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTDESC6(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTDESC6(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTDESC6(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTDESC7(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTDESC7(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTDESC7(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTDESC8(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTDESC8(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTDESC8(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTDESC9(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTDESC9(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTDESC9(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTDESC10(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTDESC10(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTDESC10(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTSRC1(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTSRC1(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTSRC1(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTSRC2(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTSRC2(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTSRC2(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTSRC3(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTSRC3(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTSRC3(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTSRC4(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTSRC4(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTSRC4(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTSRC5(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTSRC5(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTSRC5(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTSRC6(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTSRC6(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTSRC6(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTSRC7(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTSRC7(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTSRC7(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTSRC8(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTSRC8(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTSRC8(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTSRC9(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTSRC9(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTSRC9(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTSRC10(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTSRC10(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTSRC10(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTLEV1(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTLEV1(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTLEV1(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTLEV2(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTLEV2(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTLEV2(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTLEV3(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTLEV3(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTLEV3(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTLEV4(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTLEV4(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTLEV4(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTLEV5(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTLEV5(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTLEV5(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTLEV6(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTLEV6(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTLEV6(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTLEV7(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTLEV7(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTLEV7(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTLEV8(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTLEV8(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTLEV8(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTLEV9(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTLEV9(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTLEV9(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTLEV10(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTLEV10(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTLEV10(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTNUM1(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTNUM1(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTNUM1(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTNUM2(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTNUM2(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTNUM2(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTNUM3(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTNUM3(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTNUM3(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTNUM4(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTNUM4(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTNUM4(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTNUM5(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTNUM5(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTNUM5(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTNUM6(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTNUM6(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTNUM6(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTNUM7(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTNUM7(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTNUM7(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTNUM8(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTNUM8(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTNUM8(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTNUM9(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTNUM9(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTNUM9(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTNUM10(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTNUM10(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTNUM10(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTEXP1(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTEXP1(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTEXP1(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTEXP2(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTEXP2(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTEXP2(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTEXP3(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTEXP3(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTEXP3(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTEXP4(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTEXP4(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTEXP4(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTEXP5(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTEXP5(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTEXP5(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTEXP6(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTEXP6(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTEXP6(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTEXP7(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTEXP7(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTEXP7(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTEXP8(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTEXP8(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTEXP8(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTEXP9(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTEXP9(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTEXP9(UNSIGNED1 wh) := '';
 
EXPORT Make_AT_CERTEXP10(SALT37.StrType s0) := s0;
EXPORT InValid_AT_CERTEXP10(SALT37.StrType s) := 0;
EXPORT InValidMessage_AT_CERTEXP10(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_EXTRACT_DATE(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_EXTRACT_DATE(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_EXTRACT_DATE(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_MERCHANT_ID(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_MERCHANT_ID(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_MERCHANT_ID(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_PROJECT_ID(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_PROJECT_ID(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_PROJECT_ID(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_FOREIGN(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_FOREIGN(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_FOREIGN(UNSIGNED1 wh) := '';
 
EXPORT Make_Record_Update_Refresh_Date(SALT37.StrType s0) := s0;
EXPORT InValid_Record_Update_Refresh_Date(SALT37.StrType s) := 0;
EXPORT InValidMessage_Record_Update_Refresh_Date(UNSIGNED1 wh) := '';
 
EXPORT Make_EFX_DATE_CREATED(SALT37.StrType s0) := s0;
EXPORT InValid_EFX_DATE_CREATED(SALT37.StrType s) := 0;
EXPORT InValidMessage_EFX_DATE_CREATED(UNSIGNED1 wh) := '';
 
EXPORT Make_normCompany_Name(SALT37.StrType s0) := s0;
EXPORT InValid_normCompany_Name(SALT37.StrType s) := 0;
EXPORT InValidMessage_normCompany_Name(UNSIGNED1 wh) := '';
 
EXPORT Make_normCompany_Type(SALT37.StrType s0) := s0;
EXPORT InValid_normCompany_Type(SALT37.StrType s) := 0;
EXPORT InValidMessage_normCompany_Type(UNSIGNED1 wh) := '';
 
EXPORT Make_Norm_Geo_Precision(SALT37.StrType s0) := s0;
EXPORT InValid_Norm_Geo_Precision(SALT37.StrType s) := 0;
EXPORT InValidMessage_Norm_Geo_Precision(UNSIGNED1 wh) := '';
 
EXPORT Make_Norm_Corporate_Amount_Precision(SALT37.StrType s0) := s0;
EXPORT InValid_Norm_Corporate_Amount_Precision(SALT37.StrType s) := 0;
EXPORT InValidMessage_Norm_Corporate_Amount_Precision(UNSIGNED1 wh) := '';
 
EXPORT Make_Norm_Location_Amount_Precision(SALT37.StrType s0) := s0;
EXPORT InValid_Norm_Location_Amount_Precision(SALT37.StrType s) := 0;
EXPORT InValidMessage_Norm_Location_Amount_Precision(UNSIGNED1 wh) := '';
 
EXPORT Make_Norm_Public_Co_Indicator(SALT37.StrType s0) := s0;
EXPORT InValid_Norm_Public_Co_Indicator(SALT37.StrType s) := 0;
EXPORT InValidMessage_Norm_Public_Co_Indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_Norm_Stock_Exchange(SALT37.StrType s0) := s0;
EXPORT InValid_Norm_Stock_Exchange(SALT37.StrType s) := 0;
EXPORT InValidMessage_Norm_Stock_Exchange(UNSIGNED1 wh) := '';
 
EXPORT Make_Norm_Telemarketablity_Score(SALT37.StrType s0) := s0;
EXPORT InValid_Norm_Telemarketablity_Score(SALT37.StrType s) := 0;
EXPORT InValidMessage_Norm_Telemarketablity_Score(UNSIGNED1 wh) := '';
 
EXPORT Make_Norm_Telemarketablity_Total_Indicator(SALT37.StrType s0) := s0;
EXPORT InValid_Norm_Telemarketablity_Total_Indicator(SALT37.StrType s) := 0;
EXPORT InValidMessage_Norm_Telemarketablity_Total_Indicator(UNSIGNED1 wh) := '';
 
EXPORT Make_Norm_Telemarketablity_Total_Score(SALT37.StrType s0) := s0;
EXPORT InValid_Norm_Telemarketablity_Total_Score(SALT37.StrType s) := 0;
EXPORT InValidMessage_Norm_Telemarketablity_Total_Score(UNSIGNED1 wh) := '';
 
EXPORT Make_Norm_Government1057_Entity(SALT37.StrType s0) := s0;
EXPORT InValid_Norm_Government1057_Entity(SALT37.StrType s) := 0;
EXPORT InValidMessage_Norm_Government1057_Entity(UNSIGNED1 wh) := '';
 
EXPORT Make_Norm_Merchant_Type(SALT37.StrType s0) := s0;
EXPORT InValid_Norm_Merchant_Type(SALT37.StrType s) := 0;
EXPORT InValidMessage_Norm_Merchant_Type(UNSIGNED1 wh) := '';
 
EXPORT Make_NormAddress_Type(SALT37.StrType s0) := s0;
EXPORT InValid_NormAddress_Type(SALT37.StrType s) := 0;
EXPORT InValidMessage_NormAddress_Type(UNSIGNED1 wh) := '';
 
EXPORT Make_Norm_Address(SALT37.StrType s0) := s0;
EXPORT InValid_Norm_Address(SALT37.StrType s) := 0;
EXPORT InValidMessage_Norm_Address(UNSIGNED1 wh) := '';
 
EXPORT Make_Norm_City(SALT37.StrType s0) := s0;
EXPORT InValid_Norm_City(SALT37.StrType s) := 0;
EXPORT InValidMessage_Norm_City(UNSIGNED1 wh) := '';
 
EXPORT Make_Norm_State(SALT37.StrType s0) := s0;
EXPORT InValid_Norm_State(SALT37.StrType s) := 0;
EXPORT InValidMessage_Norm_State(UNSIGNED1 wh) := '';
 
EXPORT Make_Norm_StateC2(SALT37.StrType s0) := s0;
EXPORT InValid_Norm_StateC2(SALT37.StrType s) := 0;
EXPORT InValidMessage_Norm_StateC2(UNSIGNED1 wh) := '';
 
EXPORT Make_Norm_Zip(SALT37.StrType s0) := s0;
EXPORT InValid_Norm_Zip(SALT37.StrType s) := 0;
EXPORT InValidMessage_Norm_Zip(UNSIGNED1 wh) := '';
 
EXPORT Make_Norm_Zip4(SALT37.StrType s0) := s0;
EXPORT InValid_Norm_Zip4(SALT37.StrType s) := 0;
EXPORT InValidMessage_Norm_Zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_Norm_Lat(SALT37.StrType s0) := s0;
EXPORT InValid_Norm_Lat(SALT37.StrType s) := 0;
EXPORT InValidMessage_Norm_Lat(UNSIGNED1 wh) := '';
 
EXPORT Make_Norm_Lon(SALT37.StrType s0) := s0;
EXPORT InValid_Norm_Lon(SALT37.StrType s) := 0;
EXPORT InValidMessage_Norm_Lon(UNSIGNED1 wh) := '';
 
EXPORT Make_Norm_Geoprec(SALT37.StrType s0) := s0;
EXPORT InValid_Norm_Geoprec(SALT37.StrType s) := 0;
EXPORT InValidMessage_Norm_Geoprec(UNSIGNED1 wh) := '';
 
EXPORT Make_Norm_Region(SALT37.StrType s0) := s0;
EXPORT InValid_Norm_Region(SALT37.StrType s) := 0;
EXPORT InValidMessage_Norm_Region(UNSIGNED1 wh) := '';
 
EXPORT Make_Norm_Ctryisocd(SALT37.StrType s0) := s0;
EXPORT InValid_Norm_Ctryisocd(SALT37.StrType s) := 0;
EXPORT InValidMessage_Norm_Ctryisocd(UNSIGNED1 wh) := '';
 
EXPORT Make_Norm_Ctrynum(SALT37.StrType s0) := s0;
EXPORT InValid_Norm_Ctrynum(SALT37.StrType s) := 0;
EXPORT InValidMessage_Norm_Ctrynum(UNSIGNED1 wh) := '';
 
EXPORT Make_Norm_Ctryname(SALT37.StrType s0) := s0;
EXPORT InValid_Norm_Ctryname(SALT37.StrType s) := 0;
EXPORT InValidMessage_Norm_Ctryname(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_company_name(SALT37.StrType s0) := s0;
EXPORT InValid_clean_company_name(SALT37.StrType s) := 0;
EXPORT InValidMessage_clean_company_name(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_phone(SALT37.StrType s0) := s0;
EXPORT InValid_clean_phone(SALT37.StrType s) := 0;
EXPORT InValidMessage_clean_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_secondary_phone(SALT37.StrType s0) := s0;
EXPORT InValid_clean_secondary_phone(SALT37.StrType s) := 0;
EXPORT InValidMessage_clean_secondary_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_title(SALT37.StrType s0) := s0;
EXPORT InValid_title(SALT37.StrType s) := 0;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT37.StrType s0) := s0;
EXPORT InValid_fname(SALT37.StrType s) := 0;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_mname(SALT37.StrType s0) := s0;
EXPORT InValid_mname(SALT37.StrType s) := 0;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_lname(SALT37.StrType s0) := s0;
EXPORT InValid_lname(SALT37.StrType s) := 0;
EXPORT InValidMessage_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_name_suffix(SALT37.StrType s0) := s0;
EXPORT InValid_name_suffix(SALT37.StrType s) := 0;
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_name_score(SALT37.StrType s0) := s0;
EXPORT InValid_name_score(SALT37.StrType s) := 0;
EXPORT InValidMessage_name_score(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT37.StrType s0) := s0;
EXPORT InValid_prim_range(SALT37.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_predir(SALT37.StrType s0) := s0;
EXPORT InValid_predir(SALT37.StrType s) := 0;
EXPORT InValidMessage_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT37.StrType s0) := s0;
EXPORT InValid_prim_name(SALT37.StrType s) := 0;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_suffix(SALT37.StrType s0) := s0;
EXPORT InValid_addr_suffix(SALT37.StrType s) := 0;
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_postdir(SALT37.StrType s0) := s0;
EXPORT InValid_postdir(SALT37.StrType s) := 0;
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_unit_desig(SALT37.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT37.StrType s) := 0;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT37.StrType s0) := s0;
EXPORT InValid_sec_range(SALT37.StrType s) := 0;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_p_city_name(SALT37.StrType s0) := s0;
EXPORT InValid_p_city_name(SALT37.StrType s) := 0;
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_v_city_name(SALT37.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT37.StrType s) := 0;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT37.StrType s0) := s0;
EXPORT InValid_st(SALT37.StrType s) := 0;
EXPORT InValidMessage_st(UNSIGNED1 wh) := '';
 
EXPORT Make_cart(SALT37.StrType s0) := s0;
EXPORT InValid_cart(SALT37.StrType s) := 0;
EXPORT InValidMessage_cart(UNSIGNED1 wh) := '';
 
EXPORT Make_cr_sort_sz(SALT37.StrType s0) := s0;
EXPORT InValid_cr_sort_sz(SALT37.StrType s) := 0;
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT37,Equifax_Business_Data;
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
    BOOLEAN Diff_dt_effective_first;
    BOOLEAN Diff_dt_effective_last;
    BOOLEAN Diff_process_date;
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
    BOOLEAN Diff_selescore;
    BOOLEAN Diff_seleweight;
    BOOLEAN Diff_orgid;
    BOOLEAN Diff_orgscore;
    BOOLEAN Diff_orgweight;
    BOOLEAN Diff_ultid;
    BOOLEAN Diff_ultscore;
    BOOLEAN Diff_ultweight;
    BOOLEAN Diff_did;
    BOOLEAN Diff_did_score;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_EFX_ID;
    BOOLEAN Diff_EFX_NAME;
    BOOLEAN Diff_EFX_LEGAL_NAME;
    BOOLEAN Diff_EFX_ADDRESS;
    BOOLEAN Diff_EFX_CITY;
    BOOLEAN Diff_EFX_STATE;
    BOOLEAN Diff_EFX_STATEC;
    BOOLEAN Diff_EFX_ZIPCODE;
    BOOLEAN Diff_EFX_ZIP4;
    BOOLEAN Diff_EFX_LAT;
    BOOLEAN Diff_EFX_LON;
    BOOLEAN Diff_EFX_GEOPREC;
    BOOLEAN Diff_EFX_REGION;
    BOOLEAN Diff_EFX_CTRYISOCD;
    BOOLEAN Diff_EFX_CTRYNUM;
    BOOLEAN Diff_EFX_CTRYNAME;
    BOOLEAN Diff_EFX_COUNTYNM;
    BOOLEAN Diff_EFX_COUNTY;
    BOOLEAN Diff_EFX_CMSA;
    BOOLEAN Diff_EFX_CMSADESC;
    BOOLEAN Diff_EFX_SOHO;
    BOOLEAN Diff_EFX_BIZ;
    BOOLEAN Diff_EFX_RES;
    BOOLEAN Diff_EFX_CMRA;
    BOOLEAN Diff_EFX_CONGRESS;
    BOOLEAN Diff_EFX_SECADR;
    BOOLEAN Diff_EFX_SECCTY;
    BOOLEAN Diff_EFX_SECSTAT;
    BOOLEAN Diff_EFX_STATEC2;
    BOOLEAN Diff_EFX_SECZIP;
    BOOLEAN Diff_EFX_SECZIP4;
    BOOLEAN Diff_EFX_SECLAT;
    BOOLEAN Diff_EFX_SECLON;
    BOOLEAN Diff_EFX_SECGEOPREC;
    BOOLEAN Diff_EFX_SECREGION;
    BOOLEAN Diff_EFX_SECCTRYISOCD;
    BOOLEAN Diff_EFX_SECCTRYNUM;
    BOOLEAN Diff_EFX_SECCTRYNAME;
    BOOLEAN Diff_EFX_CTRYTELCD;
    BOOLEAN Diff_EFX_PHONE;
    BOOLEAN Diff_EFX_FAXPHONE;
    BOOLEAN Diff_EFX_BUSSTAT;
    BOOLEAN Diff_EFX_BUSSTATCD;
    BOOLEAN Diff_EFX_WEB;
    BOOLEAN Diff_EFX_YREST;
    BOOLEAN Diff_EFX_CORPEMPCNT;
    BOOLEAN Diff_EFX_LOCEMPCNT;
    BOOLEAN Diff_EFX_CORPEMPCD;
    BOOLEAN Diff_EFX_LOCEMPCD;
    BOOLEAN Diff_EFX_CORPAMOUNT;
    BOOLEAN Diff_EFX_CORPAMOUNTCD;
    BOOLEAN Diff_EFX_CORPAMOUNTTP;
    BOOLEAN Diff_EFX_CORPAMOUNTPREC;
    BOOLEAN Diff_EFX_LOCAMOUNT;
    BOOLEAN Diff_EFX_LOCAMOUNTCD;
    BOOLEAN Diff_EFX_LOCAMOUNTTP;
    BOOLEAN Diff_EFX_LOCAMOUNTPREC;
    BOOLEAN Diff_EFX_PUBLIC;
    BOOLEAN Diff_EFX_STKEXC;
    BOOLEAN Diff_EFX_TCKSYM;
    BOOLEAN Diff_EFX_PRIMSIC;
    BOOLEAN Diff_EFX_SECSIC1;
    BOOLEAN Diff_EFX_SECSIC2;
    BOOLEAN Diff_EFX_SECSIC3;
    BOOLEAN Diff_EFX_SECSIC4;
    BOOLEAN Diff_EFX_PRIMSICDESC;
    BOOLEAN Diff_EFX_SECSICDESC1;
    BOOLEAN Diff_EFX_SECSICDESC2;
    BOOLEAN Diff_EFX_SECSICDESC3;
    BOOLEAN Diff_EFX_SECSICDESC4;
    BOOLEAN Diff_EFX_PRIMNAICSCODE;
    BOOLEAN Diff_EFX_SECNAICS1;
    BOOLEAN Diff_EFX_SECNAICS2;
    BOOLEAN Diff_EFX_SECNAICS3;
    BOOLEAN Diff_EFX_SECNAICS4;
    BOOLEAN Diff_EFX_PRIMNAICSDESC;
    BOOLEAN Diff_EFX_SECNAICSDESC1;
    BOOLEAN Diff_EFX_SECNAICSDESC2;
    BOOLEAN Diff_EFX_SECNAICSDESC3;
    BOOLEAN Diff_EFX_SECNAICSDESC4;
    BOOLEAN Diff_EFX_DEAD;
    BOOLEAN Diff_EFX_DEADDT;
    BOOLEAN Diff_EFX_MRKT_TELEVER;
    BOOLEAN Diff_EFX_MRKT_TELESCORE;
    BOOLEAN Diff_EFX_MRKT_TOTALSCORE;
    BOOLEAN Diff_EFX_MRKT_TOTALIND;
    BOOLEAN Diff_EFX_MRKT_VACANT;
    BOOLEAN Diff_EFX_MRKT_SEASONAL;
    BOOLEAN Diff_EFX_MBE;
    BOOLEAN Diff_EFX_WBE;
    BOOLEAN Diff_EFX_MWBE;
    BOOLEAN Diff_EFX_SDB;
    BOOLEAN Diff_EFX_HUBZONE;
    BOOLEAN Diff_EFX_DBE;
    BOOLEAN Diff_EFX_VET;
    BOOLEAN Diff_EFX_DVET;
    BOOLEAN Diff_EFX_8a;
    BOOLEAN Diff_EFX_8aEXPDT;
    BOOLEAN Diff_EFX_DIS;
    BOOLEAN Diff_EFX_SBE;
    BOOLEAN Diff_EFX_BUSSIZE;
    BOOLEAN Diff_EFX_LBE;
    BOOLEAN Diff_EFX_GOV;
    BOOLEAN Diff_EFX_FGOV;
    BOOLEAN Diff_EFX_GOV1057;
    BOOLEAN Diff_EFX_NONPROFIT;
    BOOLEAN Diff_EFX_MERCTYPE;
    BOOLEAN Diff_EFX_HBCU;
    BOOLEAN Diff_EFX_GAYLESBIAN;
    BOOLEAN Diff_EFX_WSBE;
    BOOLEAN Diff_EFX_VSBE;
    BOOLEAN Diff_EFX_DVSBE;
    BOOLEAN Diff_EFX_MWBESTATUS;
    BOOLEAN Diff_EFX_NMSDC;
    BOOLEAN Diff_EFX_WBENC;
    BOOLEAN Diff_EFX_CA_PUC;
    BOOLEAN Diff_EFX_TX_HUB;
    BOOLEAN Diff_EFX_TX_HUBCERTNUM;
    BOOLEAN Diff_EFX_GSAX;
    BOOLEAN Diff_EFX_CALTRANS;
    BOOLEAN Diff_EFX_EDU;
    BOOLEAN Diff_EFX_MI;
    BOOLEAN Diff_EFX_ANC;
    BOOLEAN Diff_AT_CERT1;
    BOOLEAN Diff_AT_CERT2;
    BOOLEAN Diff_AT_CERT3;
    BOOLEAN Diff_AT_CERT4;
    BOOLEAN Diff_AT_CERT5;
    BOOLEAN Diff_AT_CERT6;
    BOOLEAN Diff_AT_CERT7;
    BOOLEAN Diff_AT_CERT8;
    BOOLEAN Diff_AT_CERT9;
    BOOLEAN Diff_AT_CERT10;
    BOOLEAN Diff_AT_CERTDESC1;
    BOOLEAN Diff_AT_CERTDESC2;
    BOOLEAN Diff_AT_CERTDESC3;
    BOOLEAN Diff_AT_CERTDESC4;
    BOOLEAN Diff_AT_CERTDESC5;
    BOOLEAN Diff_AT_CERTDESC6;
    BOOLEAN Diff_AT_CERTDESC7;
    BOOLEAN Diff_AT_CERTDESC8;
    BOOLEAN Diff_AT_CERTDESC9;
    BOOLEAN Diff_AT_CERTDESC10;
    BOOLEAN Diff_AT_CERTSRC1;
    BOOLEAN Diff_AT_CERTSRC2;
    BOOLEAN Diff_AT_CERTSRC3;
    BOOLEAN Diff_AT_CERTSRC4;
    BOOLEAN Diff_AT_CERTSRC5;
    BOOLEAN Diff_AT_CERTSRC6;
    BOOLEAN Diff_AT_CERTSRC7;
    BOOLEAN Diff_AT_CERTSRC8;
    BOOLEAN Diff_AT_CERTSRC9;
    BOOLEAN Diff_AT_CERTSRC10;
    BOOLEAN Diff_AT_CERTLEV1;
    BOOLEAN Diff_AT_CERTLEV2;
    BOOLEAN Diff_AT_CERTLEV3;
    BOOLEAN Diff_AT_CERTLEV4;
    BOOLEAN Diff_AT_CERTLEV5;
    BOOLEAN Diff_AT_CERTLEV6;
    BOOLEAN Diff_AT_CERTLEV7;
    BOOLEAN Diff_AT_CERTLEV8;
    BOOLEAN Diff_AT_CERTLEV9;
    BOOLEAN Diff_AT_CERTLEV10;
    BOOLEAN Diff_AT_CERTNUM1;
    BOOLEAN Diff_AT_CERTNUM2;
    BOOLEAN Diff_AT_CERTNUM3;
    BOOLEAN Diff_AT_CERTNUM4;
    BOOLEAN Diff_AT_CERTNUM5;
    BOOLEAN Diff_AT_CERTNUM6;
    BOOLEAN Diff_AT_CERTNUM7;
    BOOLEAN Diff_AT_CERTNUM8;
    BOOLEAN Diff_AT_CERTNUM9;
    BOOLEAN Diff_AT_CERTNUM10;
    BOOLEAN Diff_AT_CERTEXP1;
    BOOLEAN Diff_AT_CERTEXP2;
    BOOLEAN Diff_AT_CERTEXP3;
    BOOLEAN Diff_AT_CERTEXP4;
    BOOLEAN Diff_AT_CERTEXP5;
    BOOLEAN Diff_AT_CERTEXP6;
    BOOLEAN Diff_AT_CERTEXP7;
    BOOLEAN Diff_AT_CERTEXP8;
    BOOLEAN Diff_AT_CERTEXP9;
    BOOLEAN Diff_AT_CERTEXP10;
    BOOLEAN Diff_EFX_EXTRACT_DATE;
    BOOLEAN Diff_EFX_MERCHANT_ID;
    BOOLEAN Diff_EFX_PROJECT_ID;
    BOOLEAN Diff_EFX_FOREIGN;
    BOOLEAN Diff_Record_Update_Refresh_Date;
    BOOLEAN Diff_EFX_DATE_CREATED;
    BOOLEAN Diff_normCompany_Name;
    BOOLEAN Diff_normCompany_Type;
    BOOLEAN Diff_Norm_Geo_Precision;
    BOOLEAN Diff_Norm_Corporate_Amount_Precision;
    BOOLEAN Diff_Norm_Location_Amount_Precision;
    BOOLEAN Diff_Norm_Public_Co_Indicator;
    BOOLEAN Diff_Norm_Stock_Exchange;
    BOOLEAN Diff_Norm_Telemarketablity_Score;
    BOOLEAN Diff_Norm_Telemarketablity_Total_Indicator;
    BOOLEAN Diff_Norm_Telemarketablity_Total_Score;
    BOOLEAN Diff_Norm_Government1057_Entity;
    BOOLEAN Diff_Norm_Merchant_Type;
    BOOLEAN Diff_NormAddress_Type;
    BOOLEAN Diff_Norm_Address;
    BOOLEAN Diff_Norm_City;
    BOOLEAN Diff_Norm_State;
    BOOLEAN Diff_Norm_StateC2;
    BOOLEAN Diff_Norm_Zip;
    BOOLEAN Diff_Norm_Zip4;
    BOOLEAN Diff_Norm_Lat;
    BOOLEAN Diff_Norm_Lon;
    BOOLEAN Diff_Norm_Geoprec;
    BOOLEAN Diff_Norm_Region;
    BOOLEAN Diff_Norm_Ctryisocd;
    BOOLEAN Diff_Norm_Ctrynum;
    BOOLEAN Diff_Norm_Ctryname;
    BOOLEAN Diff_clean_company_name;
    BOOLEAN Diff_clean_phone;
    BOOLEAN Diff_clean_secondary_phone;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_name_score;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_addr_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_p_city_name;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_cart;
    BOOLEAN Diff_cr_sort_sz;
    SALT37.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT37.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dt_effective_first := le.dt_effective_first <> ri.dt_effective_first;
    SELF.Diff_dt_effective_last := le.dt_effective_last <> ri.dt_effective_last;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
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
    SELF.Diff_selescore := le.selescore <> ri.selescore;
    SELF.Diff_seleweight := le.seleweight <> ri.seleweight;
    SELF.Diff_orgid := le.orgid <> ri.orgid;
    SELF.Diff_orgscore := le.orgscore <> ri.orgscore;
    SELF.Diff_orgweight := le.orgweight <> ri.orgweight;
    SELF.Diff_ultid := le.ultid <> ri.ultid;
    SELF.Diff_ultscore := le.ultscore <> ri.ultscore;
    SELF.Diff_ultweight := le.ultweight <> ri.ultweight;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score := le.did_score <> ri.did_score;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_EFX_ID := le.EFX_ID <> ri.EFX_ID;
    SELF.Diff_EFX_NAME := le.EFX_NAME <> ri.EFX_NAME;
    SELF.Diff_EFX_LEGAL_NAME := le.EFX_LEGAL_NAME <> ri.EFX_LEGAL_NAME;
    SELF.Diff_EFX_ADDRESS := le.EFX_ADDRESS <> ri.EFX_ADDRESS;
    SELF.Diff_EFX_CITY := le.EFX_CITY <> ri.EFX_CITY;
    SELF.Diff_EFX_STATE := le.EFX_STATE <> ri.EFX_STATE;
    SELF.Diff_EFX_STATEC := le.EFX_STATEC <> ri.EFX_STATEC;
    SELF.Diff_EFX_ZIPCODE := le.EFX_ZIPCODE <> ri.EFX_ZIPCODE;
    SELF.Diff_EFX_ZIP4 := le.EFX_ZIP4 <> ri.EFX_ZIP4;
    SELF.Diff_EFX_LAT := le.EFX_LAT <> ri.EFX_LAT;
    SELF.Diff_EFX_LON := le.EFX_LON <> ri.EFX_LON;
    SELF.Diff_EFX_GEOPREC := le.EFX_GEOPREC <> ri.EFX_GEOPREC;
    SELF.Diff_EFX_REGION := le.EFX_REGION <> ri.EFX_REGION;
    SELF.Diff_EFX_CTRYISOCD := le.EFX_CTRYISOCD <> ri.EFX_CTRYISOCD;
    SELF.Diff_EFX_CTRYNUM := le.EFX_CTRYNUM <> ri.EFX_CTRYNUM;
    SELF.Diff_EFX_CTRYNAME := le.EFX_CTRYNAME <> ri.EFX_CTRYNAME;
    SELF.Diff_EFX_COUNTYNM := le.EFX_COUNTYNM <> ri.EFX_COUNTYNM;
    SELF.Diff_EFX_COUNTY := le.EFX_COUNTY <> ri.EFX_COUNTY;
    SELF.Diff_EFX_CMSA := le.EFX_CMSA <> ri.EFX_CMSA;
    SELF.Diff_EFX_CMSADESC := le.EFX_CMSADESC <> ri.EFX_CMSADESC;
    SELF.Diff_EFX_SOHO := le.EFX_SOHO <> ri.EFX_SOHO;
    SELF.Diff_EFX_BIZ := le.EFX_BIZ <> ri.EFX_BIZ;
    SELF.Diff_EFX_RES := le.EFX_RES <> ri.EFX_RES;
    SELF.Diff_EFX_CMRA := le.EFX_CMRA <> ri.EFX_CMRA;
    SELF.Diff_EFX_CONGRESS := le.EFX_CONGRESS <> ri.EFX_CONGRESS;
    SELF.Diff_EFX_SECADR := le.EFX_SECADR <> ri.EFX_SECADR;
    SELF.Diff_EFX_SECCTY := le.EFX_SECCTY <> ri.EFX_SECCTY;
    SELF.Diff_EFX_SECSTAT := le.EFX_SECSTAT <> ri.EFX_SECSTAT;
    SELF.Diff_EFX_STATEC2 := le.EFX_STATEC2 <> ri.EFX_STATEC2;
    SELF.Diff_EFX_SECZIP := le.EFX_SECZIP <> ri.EFX_SECZIP;
    SELF.Diff_EFX_SECZIP4 := le.EFX_SECZIP4 <> ri.EFX_SECZIP4;
    SELF.Diff_EFX_SECLAT := le.EFX_SECLAT <> ri.EFX_SECLAT;
    SELF.Diff_EFX_SECLON := le.EFX_SECLON <> ri.EFX_SECLON;
    SELF.Diff_EFX_SECGEOPREC := le.EFX_SECGEOPREC <> ri.EFX_SECGEOPREC;
    SELF.Diff_EFX_SECREGION := le.EFX_SECREGION <> ri.EFX_SECREGION;
    SELF.Diff_EFX_SECCTRYISOCD := le.EFX_SECCTRYISOCD <> ri.EFX_SECCTRYISOCD;
    SELF.Diff_EFX_SECCTRYNUM := le.EFX_SECCTRYNUM <> ri.EFX_SECCTRYNUM;
    SELF.Diff_EFX_SECCTRYNAME := le.EFX_SECCTRYNAME <> ri.EFX_SECCTRYNAME;
    SELF.Diff_EFX_CTRYTELCD := le.EFX_CTRYTELCD <> ri.EFX_CTRYTELCD;
    SELF.Diff_EFX_PHONE := le.EFX_PHONE <> ri.EFX_PHONE;
    SELF.Diff_EFX_FAXPHONE := le.EFX_FAXPHONE <> ri.EFX_FAXPHONE;
    SELF.Diff_EFX_BUSSTAT := le.EFX_BUSSTAT <> ri.EFX_BUSSTAT;
    SELF.Diff_EFX_BUSSTATCD := le.EFX_BUSSTATCD <> ri.EFX_BUSSTATCD;
    SELF.Diff_EFX_WEB := le.EFX_WEB <> ri.EFX_WEB;
    SELF.Diff_EFX_YREST := le.EFX_YREST <> ri.EFX_YREST;
    SELF.Diff_EFX_CORPEMPCNT := le.EFX_CORPEMPCNT <> ri.EFX_CORPEMPCNT;
    SELF.Diff_EFX_LOCEMPCNT := le.EFX_LOCEMPCNT <> ri.EFX_LOCEMPCNT;
    SELF.Diff_EFX_CORPEMPCD := le.EFX_CORPEMPCD <> ri.EFX_CORPEMPCD;
    SELF.Diff_EFX_LOCEMPCD := le.EFX_LOCEMPCD <> ri.EFX_LOCEMPCD;
    SELF.Diff_EFX_CORPAMOUNT := le.EFX_CORPAMOUNT <> ri.EFX_CORPAMOUNT;
    SELF.Diff_EFX_CORPAMOUNTCD := le.EFX_CORPAMOUNTCD <> ri.EFX_CORPAMOUNTCD;
    SELF.Diff_EFX_CORPAMOUNTTP := le.EFX_CORPAMOUNTTP <> ri.EFX_CORPAMOUNTTP;
    SELF.Diff_EFX_CORPAMOUNTPREC := le.EFX_CORPAMOUNTPREC <> ri.EFX_CORPAMOUNTPREC;
    SELF.Diff_EFX_LOCAMOUNT := le.EFX_LOCAMOUNT <> ri.EFX_LOCAMOUNT;
    SELF.Diff_EFX_LOCAMOUNTCD := le.EFX_LOCAMOUNTCD <> ri.EFX_LOCAMOUNTCD;
    SELF.Diff_EFX_LOCAMOUNTTP := le.EFX_LOCAMOUNTTP <> ri.EFX_LOCAMOUNTTP;
    SELF.Diff_EFX_LOCAMOUNTPREC := le.EFX_LOCAMOUNTPREC <> ri.EFX_LOCAMOUNTPREC;
    SELF.Diff_EFX_PUBLIC := le.EFX_PUBLIC <> ri.EFX_PUBLIC;
    SELF.Diff_EFX_STKEXC := le.EFX_STKEXC <> ri.EFX_STKEXC;
    SELF.Diff_EFX_TCKSYM := le.EFX_TCKSYM <> ri.EFX_TCKSYM;
    SELF.Diff_EFX_PRIMSIC := le.EFX_PRIMSIC <> ri.EFX_PRIMSIC;
    SELF.Diff_EFX_SECSIC1 := le.EFX_SECSIC1 <> ri.EFX_SECSIC1;
    SELF.Diff_EFX_SECSIC2 := le.EFX_SECSIC2 <> ri.EFX_SECSIC2;
    SELF.Diff_EFX_SECSIC3 := le.EFX_SECSIC3 <> ri.EFX_SECSIC3;
    SELF.Diff_EFX_SECSIC4 := le.EFX_SECSIC4 <> ri.EFX_SECSIC4;
    SELF.Diff_EFX_PRIMSICDESC := le.EFX_PRIMSICDESC <> ri.EFX_PRIMSICDESC;
    SELF.Diff_EFX_SECSICDESC1 := le.EFX_SECSICDESC1 <> ri.EFX_SECSICDESC1;
    SELF.Diff_EFX_SECSICDESC2 := le.EFX_SECSICDESC2 <> ri.EFX_SECSICDESC2;
    SELF.Diff_EFX_SECSICDESC3 := le.EFX_SECSICDESC3 <> ri.EFX_SECSICDESC3;
    SELF.Diff_EFX_SECSICDESC4 := le.EFX_SECSICDESC4 <> ri.EFX_SECSICDESC4;
    SELF.Diff_EFX_PRIMNAICSCODE := le.EFX_PRIMNAICSCODE <> ri.EFX_PRIMNAICSCODE;
    SELF.Diff_EFX_SECNAICS1 := le.EFX_SECNAICS1 <> ri.EFX_SECNAICS1;
    SELF.Diff_EFX_SECNAICS2 := le.EFX_SECNAICS2 <> ri.EFX_SECNAICS2;
    SELF.Diff_EFX_SECNAICS3 := le.EFX_SECNAICS3 <> ri.EFX_SECNAICS3;
    SELF.Diff_EFX_SECNAICS4 := le.EFX_SECNAICS4 <> ri.EFX_SECNAICS4;
    SELF.Diff_EFX_PRIMNAICSDESC := le.EFX_PRIMNAICSDESC <> ri.EFX_PRIMNAICSDESC;
    SELF.Diff_EFX_SECNAICSDESC1 := le.EFX_SECNAICSDESC1 <> ri.EFX_SECNAICSDESC1;
    SELF.Diff_EFX_SECNAICSDESC2 := le.EFX_SECNAICSDESC2 <> ri.EFX_SECNAICSDESC2;
    SELF.Diff_EFX_SECNAICSDESC3 := le.EFX_SECNAICSDESC3 <> ri.EFX_SECNAICSDESC3;
    SELF.Diff_EFX_SECNAICSDESC4 := le.EFX_SECNAICSDESC4 <> ri.EFX_SECNAICSDESC4;
    SELF.Diff_EFX_DEAD := le.EFX_DEAD <> ri.EFX_DEAD;
    SELF.Diff_EFX_DEADDT := le.EFX_DEADDT <> ri.EFX_DEADDT;
    SELF.Diff_EFX_MRKT_TELEVER := le.EFX_MRKT_TELEVER <> ri.EFX_MRKT_TELEVER;
    SELF.Diff_EFX_MRKT_TELESCORE := le.EFX_MRKT_TELESCORE <> ri.EFX_MRKT_TELESCORE;
    SELF.Diff_EFX_MRKT_TOTALSCORE := le.EFX_MRKT_TOTALSCORE <> ri.EFX_MRKT_TOTALSCORE;
    SELF.Diff_EFX_MRKT_TOTALIND := le.EFX_MRKT_TOTALIND <> ri.EFX_MRKT_TOTALIND;
    SELF.Diff_EFX_MRKT_VACANT := le.EFX_MRKT_VACANT <> ri.EFX_MRKT_VACANT;
    SELF.Diff_EFX_MRKT_SEASONAL := le.EFX_MRKT_SEASONAL <> ri.EFX_MRKT_SEASONAL;
    SELF.Diff_EFX_MBE := le.EFX_MBE <> ri.EFX_MBE;
    SELF.Diff_EFX_WBE := le.EFX_WBE <> ri.EFX_WBE;
    SELF.Diff_EFX_MWBE := le.EFX_MWBE <> ri.EFX_MWBE;
    SELF.Diff_EFX_SDB := le.EFX_SDB <> ri.EFX_SDB;
    SELF.Diff_EFX_HUBZONE := le.EFX_HUBZONE <> ri.EFX_HUBZONE;
    SELF.Diff_EFX_DBE := le.EFX_DBE <> ri.EFX_DBE;
    SELF.Diff_EFX_VET := le.EFX_VET <> ri.EFX_VET;
    SELF.Diff_EFX_DVET := le.EFX_DVET <> ri.EFX_DVET;
    SELF.Diff_EFX_8a := le.EFX_8a <> ri.EFX_8a;
    SELF.Diff_EFX_8aEXPDT := le.EFX_8aEXPDT <> ri.EFX_8aEXPDT;
    SELF.Diff_EFX_DIS := le.EFX_DIS <> ri.EFX_DIS;
    SELF.Diff_EFX_SBE := le.EFX_SBE <> ri.EFX_SBE;
    SELF.Diff_EFX_BUSSIZE := le.EFX_BUSSIZE <> ri.EFX_BUSSIZE;
    SELF.Diff_EFX_LBE := le.EFX_LBE <> ri.EFX_LBE;
    SELF.Diff_EFX_GOV := le.EFX_GOV <> ri.EFX_GOV;
    SELF.Diff_EFX_FGOV := le.EFX_FGOV <> ri.EFX_FGOV;
    SELF.Diff_EFX_GOV1057 := le.EFX_GOV1057 <> ri.EFX_GOV1057;
    SELF.Diff_EFX_NONPROFIT := le.EFX_NONPROFIT <> ri.EFX_NONPROFIT;
    SELF.Diff_EFX_MERCTYPE := le.EFX_MERCTYPE <> ri.EFX_MERCTYPE;
    SELF.Diff_EFX_HBCU := le.EFX_HBCU <> ri.EFX_HBCU;
    SELF.Diff_EFX_GAYLESBIAN := le.EFX_GAYLESBIAN <> ri.EFX_GAYLESBIAN;
    SELF.Diff_EFX_WSBE := le.EFX_WSBE <> ri.EFX_WSBE;
    SELF.Diff_EFX_VSBE := le.EFX_VSBE <> ri.EFX_VSBE;
    SELF.Diff_EFX_DVSBE := le.EFX_DVSBE <> ri.EFX_DVSBE;
    SELF.Diff_EFX_MWBESTATUS := le.EFX_MWBESTATUS <> ri.EFX_MWBESTATUS;
    SELF.Diff_EFX_NMSDC := le.EFX_NMSDC <> ri.EFX_NMSDC;
    SELF.Diff_EFX_WBENC := le.EFX_WBENC <> ri.EFX_WBENC;
    SELF.Diff_EFX_CA_PUC := le.EFX_CA_PUC <> ri.EFX_CA_PUC;
    SELF.Diff_EFX_TX_HUB := le.EFX_TX_HUB <> ri.EFX_TX_HUB;
    SELF.Diff_EFX_TX_HUBCERTNUM := le.EFX_TX_HUBCERTNUM <> ri.EFX_TX_HUBCERTNUM;
    SELF.Diff_EFX_GSAX := le.EFX_GSAX <> ri.EFX_GSAX;
    SELF.Diff_EFX_CALTRANS := le.EFX_CALTRANS <> ri.EFX_CALTRANS;
    SELF.Diff_EFX_EDU := le.EFX_EDU <> ri.EFX_EDU;
    SELF.Diff_EFX_MI := le.EFX_MI <> ri.EFX_MI;
    SELF.Diff_EFX_ANC := le.EFX_ANC <> ri.EFX_ANC;
    SELF.Diff_AT_CERT1 := le.AT_CERT1 <> ri.AT_CERT1;
    SELF.Diff_AT_CERT2 := le.AT_CERT2 <> ri.AT_CERT2;
    SELF.Diff_AT_CERT3 := le.AT_CERT3 <> ri.AT_CERT3;
    SELF.Diff_AT_CERT4 := le.AT_CERT4 <> ri.AT_CERT4;
    SELF.Diff_AT_CERT5 := le.AT_CERT5 <> ri.AT_CERT5;
    SELF.Diff_AT_CERT6 := le.AT_CERT6 <> ri.AT_CERT6;
    SELF.Diff_AT_CERT7 := le.AT_CERT7 <> ri.AT_CERT7;
    SELF.Diff_AT_CERT8 := le.AT_CERT8 <> ri.AT_CERT8;
    SELF.Diff_AT_CERT9 := le.AT_CERT9 <> ri.AT_CERT9;
    SELF.Diff_AT_CERT10 := le.AT_CERT10 <> ri.AT_CERT10;
    SELF.Diff_AT_CERTDESC1 := le.AT_CERTDESC1 <> ri.AT_CERTDESC1;
    SELF.Diff_AT_CERTDESC2 := le.AT_CERTDESC2 <> ri.AT_CERTDESC2;
    SELF.Diff_AT_CERTDESC3 := le.AT_CERTDESC3 <> ri.AT_CERTDESC3;
    SELF.Diff_AT_CERTDESC4 := le.AT_CERTDESC4 <> ri.AT_CERTDESC4;
    SELF.Diff_AT_CERTDESC5 := le.AT_CERTDESC5 <> ri.AT_CERTDESC5;
    SELF.Diff_AT_CERTDESC6 := le.AT_CERTDESC6 <> ri.AT_CERTDESC6;
    SELF.Diff_AT_CERTDESC7 := le.AT_CERTDESC7 <> ri.AT_CERTDESC7;
    SELF.Diff_AT_CERTDESC8 := le.AT_CERTDESC8 <> ri.AT_CERTDESC8;
    SELF.Diff_AT_CERTDESC9 := le.AT_CERTDESC9 <> ri.AT_CERTDESC9;
    SELF.Diff_AT_CERTDESC10 := le.AT_CERTDESC10 <> ri.AT_CERTDESC10;
    SELF.Diff_AT_CERTSRC1 := le.AT_CERTSRC1 <> ri.AT_CERTSRC1;
    SELF.Diff_AT_CERTSRC2 := le.AT_CERTSRC2 <> ri.AT_CERTSRC2;
    SELF.Diff_AT_CERTSRC3 := le.AT_CERTSRC3 <> ri.AT_CERTSRC3;
    SELF.Diff_AT_CERTSRC4 := le.AT_CERTSRC4 <> ri.AT_CERTSRC4;
    SELF.Diff_AT_CERTSRC5 := le.AT_CERTSRC5 <> ri.AT_CERTSRC5;
    SELF.Diff_AT_CERTSRC6 := le.AT_CERTSRC6 <> ri.AT_CERTSRC6;
    SELF.Diff_AT_CERTSRC7 := le.AT_CERTSRC7 <> ri.AT_CERTSRC7;
    SELF.Diff_AT_CERTSRC8 := le.AT_CERTSRC8 <> ri.AT_CERTSRC8;
    SELF.Diff_AT_CERTSRC9 := le.AT_CERTSRC9 <> ri.AT_CERTSRC9;
    SELF.Diff_AT_CERTSRC10 := le.AT_CERTSRC10 <> ri.AT_CERTSRC10;
    SELF.Diff_AT_CERTLEV1 := le.AT_CERTLEV1 <> ri.AT_CERTLEV1;
    SELF.Diff_AT_CERTLEV2 := le.AT_CERTLEV2 <> ri.AT_CERTLEV2;
    SELF.Diff_AT_CERTLEV3 := le.AT_CERTLEV3 <> ri.AT_CERTLEV3;
    SELF.Diff_AT_CERTLEV4 := le.AT_CERTLEV4 <> ri.AT_CERTLEV4;
    SELF.Diff_AT_CERTLEV5 := le.AT_CERTLEV5 <> ri.AT_CERTLEV5;
    SELF.Diff_AT_CERTLEV6 := le.AT_CERTLEV6 <> ri.AT_CERTLEV6;
    SELF.Diff_AT_CERTLEV7 := le.AT_CERTLEV7 <> ri.AT_CERTLEV7;
    SELF.Diff_AT_CERTLEV8 := le.AT_CERTLEV8 <> ri.AT_CERTLEV8;
    SELF.Diff_AT_CERTLEV9 := le.AT_CERTLEV9 <> ri.AT_CERTLEV9;
    SELF.Diff_AT_CERTLEV10 := le.AT_CERTLEV10 <> ri.AT_CERTLEV10;
    SELF.Diff_AT_CERTNUM1 := le.AT_CERTNUM1 <> ri.AT_CERTNUM1;
    SELF.Diff_AT_CERTNUM2 := le.AT_CERTNUM2 <> ri.AT_CERTNUM2;
    SELF.Diff_AT_CERTNUM3 := le.AT_CERTNUM3 <> ri.AT_CERTNUM3;
    SELF.Diff_AT_CERTNUM4 := le.AT_CERTNUM4 <> ri.AT_CERTNUM4;
    SELF.Diff_AT_CERTNUM5 := le.AT_CERTNUM5 <> ri.AT_CERTNUM5;
    SELF.Diff_AT_CERTNUM6 := le.AT_CERTNUM6 <> ri.AT_CERTNUM6;
    SELF.Diff_AT_CERTNUM7 := le.AT_CERTNUM7 <> ri.AT_CERTNUM7;
    SELF.Diff_AT_CERTNUM8 := le.AT_CERTNUM8 <> ri.AT_CERTNUM8;
    SELF.Diff_AT_CERTNUM9 := le.AT_CERTNUM9 <> ri.AT_CERTNUM9;
    SELF.Diff_AT_CERTNUM10 := le.AT_CERTNUM10 <> ri.AT_CERTNUM10;
    SELF.Diff_AT_CERTEXP1 := le.AT_CERTEXP1 <> ri.AT_CERTEXP1;
    SELF.Diff_AT_CERTEXP2 := le.AT_CERTEXP2 <> ri.AT_CERTEXP2;
    SELF.Diff_AT_CERTEXP3 := le.AT_CERTEXP3 <> ri.AT_CERTEXP3;
    SELF.Diff_AT_CERTEXP4 := le.AT_CERTEXP4 <> ri.AT_CERTEXP4;
    SELF.Diff_AT_CERTEXP5 := le.AT_CERTEXP5 <> ri.AT_CERTEXP5;
    SELF.Diff_AT_CERTEXP6 := le.AT_CERTEXP6 <> ri.AT_CERTEXP6;
    SELF.Diff_AT_CERTEXP7 := le.AT_CERTEXP7 <> ri.AT_CERTEXP7;
    SELF.Diff_AT_CERTEXP8 := le.AT_CERTEXP8 <> ri.AT_CERTEXP8;
    SELF.Diff_AT_CERTEXP9 := le.AT_CERTEXP9 <> ri.AT_CERTEXP9;
    SELF.Diff_AT_CERTEXP10 := le.AT_CERTEXP10 <> ri.AT_CERTEXP10;
    SELF.Diff_EFX_EXTRACT_DATE := le.EFX_EXTRACT_DATE <> ri.EFX_EXTRACT_DATE;
    SELF.Diff_EFX_MERCHANT_ID := le.EFX_MERCHANT_ID <> ri.EFX_MERCHANT_ID;
    SELF.Diff_EFX_PROJECT_ID := le.EFX_PROJECT_ID <> ri.EFX_PROJECT_ID;
    SELF.Diff_EFX_FOREIGN := le.EFX_FOREIGN <> ri.EFX_FOREIGN;
    SELF.Diff_Record_Update_Refresh_Date := le.Record_Update_Refresh_Date <> ri.Record_Update_Refresh_Date;
    SELF.Diff_EFX_DATE_CREATED := le.EFX_DATE_CREATED <> ri.EFX_DATE_CREATED;
    SELF.Diff_normCompany_Name := le.normCompany_Name <> ri.normCompany_Name;
    SELF.Diff_normCompany_Type := le.normCompany_Type <> ri.normCompany_Type;
    SELF.Diff_Norm_Geo_Precision := le.Norm_Geo_Precision <> ri.Norm_Geo_Precision;
    SELF.Diff_Norm_Corporate_Amount_Precision := le.Norm_Corporate_Amount_Precision <> ri.Norm_Corporate_Amount_Precision;
    SELF.Diff_Norm_Location_Amount_Precision := le.Norm_Location_Amount_Precision <> ri.Norm_Location_Amount_Precision;
    SELF.Diff_Norm_Public_Co_Indicator := le.Norm_Public_Co_Indicator <> ri.Norm_Public_Co_Indicator;
    SELF.Diff_Norm_Stock_Exchange := le.Norm_Stock_Exchange <> ri.Norm_Stock_Exchange;
    SELF.Diff_Norm_Telemarketablity_Score := le.Norm_Telemarketablity_Score <> ri.Norm_Telemarketablity_Score;
    SELF.Diff_Norm_Telemarketablity_Total_Indicator := le.Norm_Telemarketablity_Total_Indicator <> ri.Norm_Telemarketablity_Total_Indicator;
    SELF.Diff_Norm_Telemarketablity_Total_Score := le.Norm_Telemarketablity_Total_Score <> ri.Norm_Telemarketablity_Total_Score;
    SELF.Diff_Norm_Government1057_Entity := le.Norm_Government1057_Entity <> ri.Norm_Government1057_Entity;
    SELF.Diff_Norm_Merchant_Type := le.Norm_Merchant_Type <> ri.Norm_Merchant_Type;
    SELF.Diff_NormAddress_Type := le.NormAddress_Type <> ri.NormAddress_Type;
    SELF.Diff_Norm_Address := le.Norm_Address <> ri.Norm_Address;
    SELF.Diff_Norm_City := le.Norm_City <> ri.Norm_City;
    SELF.Diff_Norm_State := le.Norm_State <> ri.Norm_State;
    SELF.Diff_Norm_StateC2 := le.Norm_StateC2 <> ri.Norm_StateC2;
    SELF.Diff_Norm_Zip := le.Norm_Zip <> ri.Norm_Zip;
    SELF.Diff_Norm_Zip4 := le.Norm_Zip4 <> ri.Norm_Zip4;
    SELF.Diff_Norm_Lat := le.Norm_Lat <> ri.Norm_Lat;
    SELF.Diff_Norm_Lon := le.Norm_Lon <> ri.Norm_Lon;
    SELF.Diff_Norm_Geoprec := le.Norm_Geoprec <> ri.Norm_Geoprec;
    SELF.Diff_Norm_Region := le.Norm_Region <> ri.Norm_Region;
    SELF.Diff_Norm_Ctryisocd := le.Norm_Ctryisocd <> ri.Norm_Ctryisocd;
    SELF.Diff_Norm_Ctrynum := le.Norm_Ctrynum <> ri.Norm_Ctrynum;
    SELF.Diff_Norm_Ctryname := le.Norm_Ctryname <> ri.Norm_Ctryname;
    SELF.Diff_clean_company_name := le.clean_company_name <> ri.clean_company_name;
    SELF.Diff_clean_phone := le.clean_phone <> ri.clean_phone;
    SELF.Diff_clean_secondary_phone := le.clean_secondary_phone <> ri.clean_secondary_phone;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_name_score := le.name_score <> ri.name_score;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_addr_suffix := le.addr_suffix <> ri.addr_suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_p_city_name := le.p_city_name <> ri.p_city_name;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_cr_sort_sz := le.cr_sort_sz <> ri.cr_sort_sz;
    SELF.Val := (SALT37.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.source;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_dotid,1,0)+ IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_selescore,1,0)+ IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ IF( SELF.Diff_ultweight,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_EFX_ID,1,0)+ IF( SELF.Diff_EFX_NAME,1,0)+ IF( SELF.Diff_EFX_LEGAL_NAME,1,0)+ IF( SELF.Diff_EFX_ADDRESS,1,0)+ IF( SELF.Diff_EFX_CITY,1,0)+ IF( SELF.Diff_EFX_STATE,1,0)+ IF( SELF.Diff_EFX_STATEC,1,0)+ IF( SELF.Diff_EFX_ZIPCODE,1,0)+ IF( SELF.Diff_EFX_ZIP4,1,0)+ IF( SELF.Diff_EFX_LAT,1,0)+ IF( SELF.Diff_EFX_LON,1,0)+ IF( SELF.Diff_EFX_GEOPREC,1,0)+ IF( SELF.Diff_EFX_REGION,1,0)+ IF( SELF.Diff_EFX_CTRYISOCD,1,0)+ IF( SELF.Diff_EFX_CTRYNUM,1,0)+ IF( SELF.Diff_EFX_CTRYNAME,1,0)+ IF( SELF.Diff_EFX_COUNTYNM,1,0)+ IF( SELF.Diff_EFX_COUNTY,1,0)+ IF( SELF.Diff_EFX_CMSA,1,0)+ IF( SELF.Diff_EFX_CMSADESC,1,0)+ IF( SELF.Diff_EFX_SOHO,1,0)+ IF( SELF.Diff_EFX_BIZ,1,0)+ IF( SELF.Diff_EFX_RES,1,0)+ IF( SELF.Diff_EFX_CMRA,1,0)+ IF( SELF.Diff_EFX_CONGRESS,1,0)+ IF( SELF.Diff_EFX_SECADR,1,0)+ IF( SELF.Diff_EFX_SECCTY,1,0)+ IF( SELF.Diff_EFX_SECSTAT,1,0)+ IF( SELF.Diff_EFX_STATEC2,1,0)+ IF( SELF.Diff_EFX_SECZIP,1,0)+ IF( SELF.Diff_EFX_SECZIP4,1,0)+ IF( SELF.Diff_EFX_SECLAT,1,0)+ IF( SELF.Diff_EFX_SECLON,1,0)+ IF( SELF.Diff_EFX_SECGEOPREC,1,0)+ IF( SELF.Diff_EFX_SECREGION,1,0)+ IF( SELF.Diff_EFX_SECCTRYISOCD,1,0)+ IF( SELF.Diff_EFX_SECCTRYNUM,1,0)+ IF( SELF.Diff_EFX_SECCTRYNAME,1,0)+ IF( SELF.Diff_EFX_CTRYTELCD,1,0)+ IF( SELF.Diff_EFX_PHONE,1,0)+ IF( SELF.Diff_EFX_FAXPHONE,1,0)+ IF( SELF.Diff_EFX_BUSSTAT,1,0)+ IF( SELF.Diff_EFX_BUSSTATCD,1,0)+ IF( SELF.Diff_EFX_WEB,1,0)+ IF( SELF.Diff_EFX_YREST,1,0)+ IF( SELF.Diff_EFX_CORPEMPCNT,1,0)+ IF( SELF.Diff_EFX_LOCEMPCNT,1,0)+ IF( SELF.Diff_EFX_CORPEMPCD,1,0)+ IF( SELF.Diff_EFX_LOCEMPCD,1,0)+ IF( SELF.Diff_EFX_CORPAMOUNT,1,0)+ IF( SELF.Diff_EFX_CORPAMOUNTCD,1,0)+ IF( SELF.Diff_EFX_CORPAMOUNTTP,1,0)+ IF( SELF.Diff_EFX_CORPAMOUNTPREC,1,0)+ IF( SELF.Diff_EFX_LOCAMOUNT,1,0)+ IF( SELF.Diff_EFX_LOCAMOUNTCD,1,0)+ IF( SELF.Diff_EFX_LOCAMOUNTTP,1,0)+ IF( SELF.Diff_EFX_LOCAMOUNTPREC,1,0)+ IF( SELF.Diff_EFX_PUBLIC,1,0)+ IF( SELF.Diff_EFX_STKEXC,1,0)+ IF( SELF.Diff_EFX_TCKSYM,1,0)+ IF( SELF.Diff_EFX_PRIMSIC,1,0)+ IF( SELF.Diff_EFX_SECSIC1,1,0)+ IF( SELF.Diff_EFX_SECSIC2,1,0)+ IF( SELF.Diff_EFX_SECSIC3,1,0)+ IF( SELF.Diff_EFX_SECSIC4,1,0)+ IF( SELF.Diff_EFX_PRIMSICDESC,1,0)+ IF( SELF.Diff_EFX_SECSICDESC1,1,0)+ IF( SELF.Diff_EFX_SECSICDESC2,1,0)+ IF( SELF.Diff_EFX_SECSICDESC3,1,0)+ IF( SELF.Diff_EFX_SECSICDESC4,1,0)+ IF( SELF.Diff_EFX_PRIMNAICSCODE,1,0)+ IF( SELF.Diff_EFX_SECNAICS1,1,0)+ IF( SELF.Diff_EFX_SECNAICS2,1,0)+ IF( SELF.Diff_EFX_SECNAICS3,1,0)+ IF( SELF.Diff_EFX_SECNAICS4,1,0)+ IF( SELF.Diff_EFX_PRIMNAICSDESC,1,0)+ IF( SELF.Diff_EFX_SECNAICSDESC1,1,0)+ IF( SELF.Diff_EFX_SECNAICSDESC2,1,0)+ IF( SELF.Diff_EFX_SECNAICSDESC3,1,0)+ IF( SELF.Diff_EFX_SECNAICSDESC4,1,0)+ IF( SELF.Diff_EFX_DEAD,1,0)+ IF( SELF.Diff_EFX_DEADDT,1,0)+ IF( SELF.Diff_EFX_MRKT_TELEVER,1,0)+ IF( SELF.Diff_EFX_MRKT_TELESCORE,1,0)+ IF( SELF.Diff_EFX_MRKT_TOTALSCORE,1,0)+ IF( SELF.Diff_EFX_MRKT_TOTALIND,1,0)+ IF( SELF.Diff_EFX_MRKT_VACANT,1,0)+ IF( SELF.Diff_EFX_MRKT_SEASONAL,1,0)+ IF( SELF.Diff_EFX_MBE,1,0)+ IF( SELF.Diff_EFX_WBE,1,0)+ IF( SELF.Diff_EFX_MWBE,1,0)+ IF( SELF.Diff_EFX_SDB,1,0)+ IF( SELF.Diff_EFX_HUBZONE,1,0)+ IF( SELF.Diff_EFX_DBE,1,0)+ IF( SELF.Diff_EFX_VET,1,0)+ IF( SELF.Diff_EFX_DVET,1,0)+ IF( SELF.Diff_EFX_8a,1,0)+ IF( SELF.Diff_EFX_8aEXPDT,1,0)+ IF( SELF.Diff_EFX_DIS,1,0)+ IF( SELF.Diff_EFX_SBE,1,0)+ IF( SELF.Diff_EFX_BUSSIZE,1,0)+ IF( SELF.Diff_EFX_LBE,1,0)+ IF( SELF.Diff_EFX_GOV,1,0)+ IF( SELF.Diff_EFX_FGOV,1,0)+ IF( SELF.Diff_EFX_GOV1057,1,0)+ IF( SELF.Diff_EFX_NONPROFIT,1,0)+ IF( SELF.Diff_EFX_MERCTYPE,1,0)+ IF( SELF.Diff_EFX_HBCU,1,0)+ IF( SELF.Diff_EFX_GAYLESBIAN,1,0)+ IF( SELF.Diff_EFX_WSBE,1,0)+ IF( SELF.Diff_EFX_VSBE,1,0)+ IF( SELF.Diff_EFX_DVSBE,1,0)+ IF( SELF.Diff_EFX_MWBESTATUS,1,0)+ IF( SELF.Diff_EFX_NMSDC,1,0)+ IF( SELF.Diff_EFX_WBENC,1,0)+ IF( SELF.Diff_EFX_CA_PUC,1,0)+ IF( SELF.Diff_EFX_TX_HUB,1,0)+ IF( SELF.Diff_EFX_TX_HUBCERTNUM,1,0)+ IF( SELF.Diff_EFX_GSAX,1,0)+ IF( SELF.Diff_EFX_CALTRANS,1,0)+ IF( SELF.Diff_EFX_EDU,1,0)+ IF( SELF.Diff_EFX_MI,1,0)+ IF( SELF.Diff_EFX_ANC,1,0)+ IF( SELF.Diff_AT_CERT1,1,0)+ IF( SELF.Diff_AT_CERT2,1,0)+ IF( SELF.Diff_AT_CERT3,1,0)+ IF( SELF.Diff_AT_CERT4,1,0)+ IF( SELF.Diff_AT_CERT5,1,0)+ IF( SELF.Diff_AT_CERT6,1,0)+ IF( SELF.Diff_AT_CERT7,1,0)+ IF( SELF.Diff_AT_CERT8,1,0)+ IF( SELF.Diff_AT_CERT9,1,0)+ IF( SELF.Diff_AT_CERT10,1,0)+ IF( SELF.Diff_AT_CERTDESC1,1,0)+ IF( SELF.Diff_AT_CERTDESC2,1,0)+ IF( SELF.Diff_AT_CERTDESC3,1,0)+ IF( SELF.Diff_AT_CERTDESC4,1,0)+ IF( SELF.Diff_AT_CERTDESC5,1,0)+ IF( SELF.Diff_AT_CERTDESC6,1,0)+ IF( SELF.Diff_AT_CERTDESC7,1,0)+ IF( SELF.Diff_AT_CERTDESC8,1,0)+ IF( SELF.Diff_AT_CERTDESC9,1,0)+ IF( SELF.Diff_AT_CERTDESC10,1,0)+ IF( SELF.Diff_AT_CERTSRC1,1,0)+ IF( SELF.Diff_AT_CERTSRC2,1,0)+ IF( SELF.Diff_AT_CERTSRC3,1,0)+ IF( SELF.Diff_AT_CERTSRC4,1,0)+ IF( SELF.Diff_AT_CERTSRC5,1,0)+ IF( SELF.Diff_AT_CERTSRC6,1,0)+ IF( SELF.Diff_AT_CERTSRC7,1,0)+ IF( SELF.Diff_AT_CERTSRC8,1,0)+ IF( SELF.Diff_AT_CERTSRC9,1,0)+ IF( SELF.Diff_AT_CERTSRC10,1,0)+ IF( SELF.Diff_AT_CERTLEV1,1,0)+ IF( SELF.Diff_AT_CERTLEV2,1,0)+ IF( SELF.Diff_AT_CERTLEV3,1,0)+ IF( SELF.Diff_AT_CERTLEV4,1,0)+ IF( SELF.Diff_AT_CERTLEV5,1,0)+ IF( SELF.Diff_AT_CERTLEV6,1,0)+ IF( SELF.Diff_AT_CERTLEV7,1,0)+ IF( SELF.Diff_AT_CERTLEV8,1,0)+ IF( SELF.Diff_AT_CERTLEV9,1,0)+ IF( SELF.Diff_AT_CERTLEV10,1,0)+ IF( SELF.Diff_AT_CERTNUM1,1,0)+ IF( SELF.Diff_AT_CERTNUM2,1,0)+ IF( SELF.Diff_AT_CERTNUM3,1,0)+ IF( SELF.Diff_AT_CERTNUM4,1,0)+ IF( SELF.Diff_AT_CERTNUM5,1,0)+ IF( SELF.Diff_AT_CERTNUM6,1,0)+ IF( SELF.Diff_AT_CERTNUM7,1,0)+ IF( SELF.Diff_AT_CERTNUM8,1,0)+ IF( SELF.Diff_AT_CERTNUM9,1,0)+ IF( SELF.Diff_AT_CERTNUM10,1,0)+ IF( SELF.Diff_AT_CERTEXP1,1,0)+ IF( SELF.Diff_AT_CERTEXP2,1,0)+ IF( SELF.Diff_AT_CERTEXP3,1,0)+ IF( SELF.Diff_AT_CERTEXP4,1,0)+ IF( SELF.Diff_AT_CERTEXP5,1,0)+ IF( SELF.Diff_AT_CERTEXP6,1,0)+ IF( SELF.Diff_AT_CERTEXP7,1,0)+ IF( SELF.Diff_AT_CERTEXP8,1,0)+ IF( SELF.Diff_AT_CERTEXP9,1,0)+ IF( SELF.Diff_AT_CERTEXP10,1,0)+ IF( SELF.Diff_EFX_EXTRACT_DATE,1,0)+ IF( SELF.Diff_EFX_MERCHANT_ID,1,0)+ IF( SELF.Diff_EFX_PROJECT_ID,1,0)+ IF( SELF.Diff_EFX_FOREIGN,1,0)+ IF( SELF.Diff_Record_Update_Refresh_Date,1,0)+ IF( SELF.Diff_EFX_DATE_CREATED,1,0)+ IF( SELF.Diff_normCompany_Name,1,0)+ IF( SELF.Diff_normCompany_Type,1,0)+ IF( SELF.Diff_Norm_Geo_Precision,1,0)+ IF( SELF.Diff_Norm_Corporate_Amount_Precision,1,0)+ IF( SELF.Diff_Norm_Location_Amount_Precision,1,0)+ IF( SELF.Diff_Norm_Public_Co_Indicator,1,0)+ IF( SELF.Diff_Norm_Stock_Exchange,1,0)+ IF( SELF.Diff_Norm_Telemarketablity_Score,1,0)+ IF( SELF.Diff_Norm_Telemarketablity_Total_Indicator,1,0)+ IF( SELF.Diff_Norm_Telemarketablity_Total_Score,1,0)+ IF( SELF.Diff_Norm_Government1057_Entity,1,0)+ IF( SELF.Diff_Norm_Merchant_Type,1,0)+ IF( SELF.Diff_NormAddress_Type,1,0)+ IF( SELF.Diff_Norm_Address,1,0)+ IF( SELF.Diff_Norm_City,1,0)+ IF( SELF.Diff_Norm_State,1,0)+ IF( SELF.Diff_Norm_StateC2,1,0)+ IF( SELF.Diff_Norm_Zip,1,0)+ IF( SELF.Diff_Norm_Zip4,1,0)+ IF( SELF.Diff_Norm_Lat,1,0)+ IF( SELF.Diff_Norm_Lon,1,0)+ IF( SELF.Diff_Norm_Geoprec,1,0)+ IF( SELF.Diff_Norm_Region,1,0)+ IF( SELF.Diff_Norm_Ctryisocd,1,0)+ IF( SELF.Diff_Norm_Ctrynum,1,0)+ IF( SELF.Diff_Norm_Ctryname,1,0)+ IF( SELF.Diff_clean_company_name,1,0)+ IF( SELF.Diff_clean_phone,1,0)+ IF( SELF.Diff_clean_secondary_phone,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0);
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
    Count_Diff_dt_effective_first := COUNT(GROUP,%Closest%.Diff_dt_effective_first);
    Count_Diff_dt_effective_last := COUNT(GROUP,%Closest%.Diff_dt_effective_last);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
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
    Count_Diff_selescore := COUNT(GROUP,%Closest%.Diff_selescore);
    Count_Diff_seleweight := COUNT(GROUP,%Closest%.Diff_seleweight);
    Count_Diff_orgid := COUNT(GROUP,%Closest%.Diff_orgid);
    Count_Diff_orgscore := COUNT(GROUP,%Closest%.Diff_orgscore);
    Count_Diff_orgweight := COUNT(GROUP,%Closest%.Diff_orgweight);
    Count_Diff_ultid := COUNT(GROUP,%Closest%.Diff_ultid);
    Count_Diff_ultscore := COUNT(GROUP,%Closest%.Diff_ultscore);
    Count_Diff_ultweight := COUNT(GROUP,%Closest%.Diff_ultweight);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_did_score := COUNT(GROUP,%Closest%.Diff_did_score);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_EFX_ID := COUNT(GROUP,%Closest%.Diff_EFX_ID);
    Count_Diff_EFX_NAME := COUNT(GROUP,%Closest%.Diff_EFX_NAME);
    Count_Diff_EFX_LEGAL_NAME := COUNT(GROUP,%Closest%.Diff_EFX_LEGAL_NAME);
    Count_Diff_EFX_ADDRESS := COUNT(GROUP,%Closest%.Diff_EFX_ADDRESS);
    Count_Diff_EFX_CITY := COUNT(GROUP,%Closest%.Diff_EFX_CITY);
    Count_Diff_EFX_STATE := COUNT(GROUP,%Closest%.Diff_EFX_STATE);
    Count_Diff_EFX_STATEC := COUNT(GROUP,%Closest%.Diff_EFX_STATEC);
    Count_Diff_EFX_ZIPCODE := COUNT(GROUP,%Closest%.Diff_EFX_ZIPCODE);
    Count_Diff_EFX_ZIP4 := COUNT(GROUP,%Closest%.Diff_EFX_ZIP4);
    Count_Diff_EFX_LAT := COUNT(GROUP,%Closest%.Diff_EFX_LAT);
    Count_Diff_EFX_LON := COUNT(GROUP,%Closest%.Diff_EFX_LON);
    Count_Diff_EFX_GEOPREC := COUNT(GROUP,%Closest%.Diff_EFX_GEOPREC);
    Count_Diff_EFX_REGION := COUNT(GROUP,%Closest%.Diff_EFX_REGION);
    Count_Diff_EFX_CTRYISOCD := COUNT(GROUP,%Closest%.Diff_EFX_CTRYISOCD);
    Count_Diff_EFX_CTRYNUM := COUNT(GROUP,%Closest%.Diff_EFX_CTRYNUM);
    Count_Diff_EFX_CTRYNAME := COUNT(GROUP,%Closest%.Diff_EFX_CTRYNAME);
    Count_Diff_EFX_COUNTYNM := COUNT(GROUP,%Closest%.Diff_EFX_COUNTYNM);
    Count_Diff_EFX_COUNTY := COUNT(GROUP,%Closest%.Diff_EFX_COUNTY);
    Count_Diff_EFX_CMSA := COUNT(GROUP,%Closest%.Diff_EFX_CMSA);
    Count_Diff_EFX_CMSADESC := COUNT(GROUP,%Closest%.Diff_EFX_CMSADESC);
    Count_Diff_EFX_SOHO := COUNT(GROUP,%Closest%.Diff_EFX_SOHO);
    Count_Diff_EFX_BIZ := COUNT(GROUP,%Closest%.Diff_EFX_BIZ);
    Count_Diff_EFX_RES := COUNT(GROUP,%Closest%.Diff_EFX_RES);
    Count_Diff_EFX_CMRA := COUNT(GROUP,%Closest%.Diff_EFX_CMRA);
    Count_Diff_EFX_CONGRESS := COUNT(GROUP,%Closest%.Diff_EFX_CONGRESS);
    Count_Diff_EFX_SECADR := COUNT(GROUP,%Closest%.Diff_EFX_SECADR);
    Count_Diff_EFX_SECCTY := COUNT(GROUP,%Closest%.Diff_EFX_SECCTY);
    Count_Diff_EFX_SECSTAT := COUNT(GROUP,%Closest%.Diff_EFX_SECSTAT);
    Count_Diff_EFX_STATEC2 := COUNT(GROUP,%Closest%.Diff_EFX_STATEC2);
    Count_Diff_EFX_SECZIP := COUNT(GROUP,%Closest%.Diff_EFX_SECZIP);
    Count_Diff_EFX_SECZIP4 := COUNT(GROUP,%Closest%.Diff_EFX_SECZIP4);
    Count_Diff_EFX_SECLAT := COUNT(GROUP,%Closest%.Diff_EFX_SECLAT);
    Count_Diff_EFX_SECLON := COUNT(GROUP,%Closest%.Diff_EFX_SECLON);
    Count_Diff_EFX_SECGEOPREC := COUNT(GROUP,%Closest%.Diff_EFX_SECGEOPREC);
    Count_Diff_EFX_SECREGION := COUNT(GROUP,%Closest%.Diff_EFX_SECREGION);
    Count_Diff_EFX_SECCTRYISOCD := COUNT(GROUP,%Closest%.Diff_EFX_SECCTRYISOCD);
    Count_Diff_EFX_SECCTRYNUM := COUNT(GROUP,%Closest%.Diff_EFX_SECCTRYNUM);
    Count_Diff_EFX_SECCTRYNAME := COUNT(GROUP,%Closest%.Diff_EFX_SECCTRYNAME);
    Count_Diff_EFX_CTRYTELCD := COUNT(GROUP,%Closest%.Diff_EFX_CTRYTELCD);
    Count_Diff_EFX_PHONE := COUNT(GROUP,%Closest%.Diff_EFX_PHONE);
    Count_Diff_EFX_FAXPHONE := COUNT(GROUP,%Closest%.Diff_EFX_FAXPHONE);
    Count_Diff_EFX_BUSSTAT := COUNT(GROUP,%Closest%.Diff_EFX_BUSSTAT);
    Count_Diff_EFX_BUSSTATCD := COUNT(GROUP,%Closest%.Diff_EFX_BUSSTATCD);
    Count_Diff_EFX_WEB := COUNT(GROUP,%Closest%.Diff_EFX_WEB);
    Count_Diff_EFX_YREST := COUNT(GROUP,%Closest%.Diff_EFX_YREST);
    Count_Diff_EFX_CORPEMPCNT := COUNT(GROUP,%Closest%.Diff_EFX_CORPEMPCNT);
    Count_Diff_EFX_LOCEMPCNT := COUNT(GROUP,%Closest%.Diff_EFX_LOCEMPCNT);
    Count_Diff_EFX_CORPEMPCD := COUNT(GROUP,%Closest%.Diff_EFX_CORPEMPCD);
    Count_Diff_EFX_LOCEMPCD := COUNT(GROUP,%Closest%.Diff_EFX_LOCEMPCD);
    Count_Diff_EFX_CORPAMOUNT := COUNT(GROUP,%Closest%.Diff_EFX_CORPAMOUNT);
    Count_Diff_EFX_CORPAMOUNTCD := COUNT(GROUP,%Closest%.Diff_EFX_CORPAMOUNTCD);
    Count_Diff_EFX_CORPAMOUNTTP := COUNT(GROUP,%Closest%.Diff_EFX_CORPAMOUNTTP);
    Count_Diff_EFX_CORPAMOUNTPREC := COUNT(GROUP,%Closest%.Diff_EFX_CORPAMOUNTPREC);
    Count_Diff_EFX_LOCAMOUNT := COUNT(GROUP,%Closest%.Diff_EFX_LOCAMOUNT);
    Count_Diff_EFX_LOCAMOUNTCD := COUNT(GROUP,%Closest%.Diff_EFX_LOCAMOUNTCD);
    Count_Diff_EFX_LOCAMOUNTTP := COUNT(GROUP,%Closest%.Diff_EFX_LOCAMOUNTTP);
    Count_Diff_EFX_LOCAMOUNTPREC := COUNT(GROUP,%Closest%.Diff_EFX_LOCAMOUNTPREC);
    Count_Diff_EFX_PUBLIC := COUNT(GROUP,%Closest%.Diff_EFX_PUBLIC);
    Count_Diff_EFX_STKEXC := COUNT(GROUP,%Closest%.Diff_EFX_STKEXC);
    Count_Diff_EFX_TCKSYM := COUNT(GROUP,%Closest%.Diff_EFX_TCKSYM);
    Count_Diff_EFX_PRIMSIC := COUNT(GROUP,%Closest%.Diff_EFX_PRIMSIC);
    Count_Diff_EFX_SECSIC1 := COUNT(GROUP,%Closest%.Diff_EFX_SECSIC1);
    Count_Diff_EFX_SECSIC2 := COUNT(GROUP,%Closest%.Diff_EFX_SECSIC2);
    Count_Diff_EFX_SECSIC3 := COUNT(GROUP,%Closest%.Diff_EFX_SECSIC3);
    Count_Diff_EFX_SECSIC4 := COUNT(GROUP,%Closest%.Diff_EFX_SECSIC4);
    Count_Diff_EFX_PRIMSICDESC := COUNT(GROUP,%Closest%.Diff_EFX_PRIMSICDESC);
    Count_Diff_EFX_SECSICDESC1 := COUNT(GROUP,%Closest%.Diff_EFX_SECSICDESC1);
    Count_Diff_EFX_SECSICDESC2 := COUNT(GROUP,%Closest%.Diff_EFX_SECSICDESC2);
    Count_Diff_EFX_SECSICDESC3 := COUNT(GROUP,%Closest%.Diff_EFX_SECSICDESC3);
    Count_Diff_EFX_SECSICDESC4 := COUNT(GROUP,%Closest%.Diff_EFX_SECSICDESC4);
    Count_Diff_EFX_PRIMNAICSCODE := COUNT(GROUP,%Closest%.Diff_EFX_PRIMNAICSCODE);
    Count_Diff_EFX_SECNAICS1 := COUNT(GROUP,%Closest%.Diff_EFX_SECNAICS1);
    Count_Diff_EFX_SECNAICS2 := COUNT(GROUP,%Closest%.Diff_EFX_SECNAICS2);
    Count_Diff_EFX_SECNAICS3 := COUNT(GROUP,%Closest%.Diff_EFX_SECNAICS3);
    Count_Diff_EFX_SECNAICS4 := COUNT(GROUP,%Closest%.Diff_EFX_SECNAICS4);
    Count_Diff_EFX_PRIMNAICSDESC := COUNT(GROUP,%Closest%.Diff_EFX_PRIMNAICSDESC);
    Count_Diff_EFX_SECNAICSDESC1 := COUNT(GROUP,%Closest%.Diff_EFX_SECNAICSDESC1);
    Count_Diff_EFX_SECNAICSDESC2 := COUNT(GROUP,%Closest%.Diff_EFX_SECNAICSDESC2);
    Count_Diff_EFX_SECNAICSDESC3 := COUNT(GROUP,%Closest%.Diff_EFX_SECNAICSDESC3);
    Count_Diff_EFX_SECNAICSDESC4 := COUNT(GROUP,%Closest%.Diff_EFX_SECNAICSDESC4);
    Count_Diff_EFX_DEAD := COUNT(GROUP,%Closest%.Diff_EFX_DEAD);
    Count_Diff_EFX_DEADDT := COUNT(GROUP,%Closest%.Diff_EFX_DEADDT);
    Count_Diff_EFX_MRKT_TELEVER := COUNT(GROUP,%Closest%.Diff_EFX_MRKT_TELEVER);
    Count_Diff_EFX_MRKT_TELESCORE := COUNT(GROUP,%Closest%.Diff_EFX_MRKT_TELESCORE);
    Count_Diff_EFX_MRKT_TOTALSCORE := COUNT(GROUP,%Closest%.Diff_EFX_MRKT_TOTALSCORE);
    Count_Diff_EFX_MRKT_TOTALIND := COUNT(GROUP,%Closest%.Diff_EFX_MRKT_TOTALIND);
    Count_Diff_EFX_MRKT_VACANT := COUNT(GROUP,%Closest%.Diff_EFX_MRKT_VACANT);
    Count_Diff_EFX_MRKT_SEASONAL := COUNT(GROUP,%Closest%.Diff_EFX_MRKT_SEASONAL);
    Count_Diff_EFX_MBE := COUNT(GROUP,%Closest%.Diff_EFX_MBE);
    Count_Diff_EFX_WBE := COUNT(GROUP,%Closest%.Diff_EFX_WBE);
    Count_Diff_EFX_MWBE := COUNT(GROUP,%Closest%.Diff_EFX_MWBE);
    Count_Diff_EFX_SDB := COUNT(GROUP,%Closest%.Diff_EFX_SDB);
    Count_Diff_EFX_HUBZONE := COUNT(GROUP,%Closest%.Diff_EFX_HUBZONE);
    Count_Diff_EFX_DBE := COUNT(GROUP,%Closest%.Diff_EFX_DBE);
    Count_Diff_EFX_VET := COUNT(GROUP,%Closest%.Diff_EFX_VET);
    Count_Diff_EFX_DVET := COUNT(GROUP,%Closest%.Diff_EFX_DVET);
    Count_Diff_EFX_8a := COUNT(GROUP,%Closest%.Diff_EFX_8a);
    Count_Diff_EFX_8aEXPDT := COUNT(GROUP,%Closest%.Diff_EFX_8aEXPDT);
    Count_Diff_EFX_DIS := COUNT(GROUP,%Closest%.Diff_EFX_DIS);
    Count_Diff_EFX_SBE := COUNT(GROUP,%Closest%.Diff_EFX_SBE);
    Count_Diff_EFX_BUSSIZE := COUNT(GROUP,%Closest%.Diff_EFX_BUSSIZE);
    Count_Diff_EFX_LBE := COUNT(GROUP,%Closest%.Diff_EFX_LBE);
    Count_Diff_EFX_GOV := COUNT(GROUP,%Closest%.Diff_EFX_GOV);
    Count_Diff_EFX_FGOV := COUNT(GROUP,%Closest%.Diff_EFX_FGOV);
    Count_Diff_EFX_GOV1057 := COUNT(GROUP,%Closest%.Diff_EFX_GOV1057);
    Count_Diff_EFX_NONPROFIT := COUNT(GROUP,%Closest%.Diff_EFX_NONPROFIT);
    Count_Diff_EFX_MERCTYPE := COUNT(GROUP,%Closest%.Diff_EFX_MERCTYPE);
    Count_Diff_EFX_HBCU := COUNT(GROUP,%Closest%.Diff_EFX_HBCU);
    Count_Diff_EFX_GAYLESBIAN := COUNT(GROUP,%Closest%.Diff_EFX_GAYLESBIAN);
    Count_Diff_EFX_WSBE := COUNT(GROUP,%Closest%.Diff_EFX_WSBE);
    Count_Diff_EFX_VSBE := COUNT(GROUP,%Closest%.Diff_EFX_VSBE);
    Count_Diff_EFX_DVSBE := COUNT(GROUP,%Closest%.Diff_EFX_DVSBE);
    Count_Diff_EFX_MWBESTATUS := COUNT(GROUP,%Closest%.Diff_EFX_MWBESTATUS);
    Count_Diff_EFX_NMSDC := COUNT(GROUP,%Closest%.Diff_EFX_NMSDC);
    Count_Diff_EFX_WBENC := COUNT(GROUP,%Closest%.Diff_EFX_WBENC);
    Count_Diff_EFX_CA_PUC := COUNT(GROUP,%Closest%.Diff_EFX_CA_PUC);
    Count_Diff_EFX_TX_HUB := COUNT(GROUP,%Closest%.Diff_EFX_TX_HUB);
    Count_Diff_EFX_TX_HUBCERTNUM := COUNT(GROUP,%Closest%.Diff_EFX_TX_HUBCERTNUM);
    Count_Diff_EFX_GSAX := COUNT(GROUP,%Closest%.Diff_EFX_GSAX);
    Count_Diff_EFX_CALTRANS := COUNT(GROUP,%Closest%.Diff_EFX_CALTRANS);
    Count_Diff_EFX_EDU := COUNT(GROUP,%Closest%.Diff_EFX_EDU);
    Count_Diff_EFX_MI := COUNT(GROUP,%Closest%.Diff_EFX_MI);
    Count_Diff_EFX_ANC := COUNT(GROUP,%Closest%.Diff_EFX_ANC);
    Count_Diff_AT_CERT1 := COUNT(GROUP,%Closest%.Diff_AT_CERT1);
    Count_Diff_AT_CERT2 := COUNT(GROUP,%Closest%.Diff_AT_CERT2);
    Count_Diff_AT_CERT3 := COUNT(GROUP,%Closest%.Diff_AT_CERT3);
    Count_Diff_AT_CERT4 := COUNT(GROUP,%Closest%.Diff_AT_CERT4);
    Count_Diff_AT_CERT5 := COUNT(GROUP,%Closest%.Diff_AT_CERT5);
    Count_Diff_AT_CERT6 := COUNT(GROUP,%Closest%.Diff_AT_CERT6);
    Count_Diff_AT_CERT7 := COUNT(GROUP,%Closest%.Diff_AT_CERT7);
    Count_Diff_AT_CERT8 := COUNT(GROUP,%Closest%.Diff_AT_CERT8);
    Count_Diff_AT_CERT9 := COUNT(GROUP,%Closest%.Diff_AT_CERT9);
    Count_Diff_AT_CERT10 := COUNT(GROUP,%Closest%.Diff_AT_CERT10);
    Count_Diff_AT_CERTDESC1 := COUNT(GROUP,%Closest%.Diff_AT_CERTDESC1);
    Count_Diff_AT_CERTDESC2 := COUNT(GROUP,%Closest%.Diff_AT_CERTDESC2);
    Count_Diff_AT_CERTDESC3 := COUNT(GROUP,%Closest%.Diff_AT_CERTDESC3);
    Count_Diff_AT_CERTDESC4 := COUNT(GROUP,%Closest%.Diff_AT_CERTDESC4);
    Count_Diff_AT_CERTDESC5 := COUNT(GROUP,%Closest%.Diff_AT_CERTDESC5);
    Count_Diff_AT_CERTDESC6 := COUNT(GROUP,%Closest%.Diff_AT_CERTDESC6);
    Count_Diff_AT_CERTDESC7 := COUNT(GROUP,%Closest%.Diff_AT_CERTDESC7);
    Count_Diff_AT_CERTDESC8 := COUNT(GROUP,%Closest%.Diff_AT_CERTDESC8);
    Count_Diff_AT_CERTDESC9 := COUNT(GROUP,%Closest%.Diff_AT_CERTDESC9);
    Count_Diff_AT_CERTDESC10 := COUNT(GROUP,%Closest%.Diff_AT_CERTDESC10);
    Count_Diff_AT_CERTSRC1 := COUNT(GROUP,%Closest%.Diff_AT_CERTSRC1);
    Count_Diff_AT_CERTSRC2 := COUNT(GROUP,%Closest%.Diff_AT_CERTSRC2);
    Count_Diff_AT_CERTSRC3 := COUNT(GROUP,%Closest%.Diff_AT_CERTSRC3);
    Count_Diff_AT_CERTSRC4 := COUNT(GROUP,%Closest%.Diff_AT_CERTSRC4);
    Count_Diff_AT_CERTSRC5 := COUNT(GROUP,%Closest%.Diff_AT_CERTSRC5);
    Count_Diff_AT_CERTSRC6 := COUNT(GROUP,%Closest%.Diff_AT_CERTSRC6);
    Count_Diff_AT_CERTSRC7 := COUNT(GROUP,%Closest%.Diff_AT_CERTSRC7);
    Count_Diff_AT_CERTSRC8 := COUNT(GROUP,%Closest%.Diff_AT_CERTSRC8);
    Count_Diff_AT_CERTSRC9 := COUNT(GROUP,%Closest%.Diff_AT_CERTSRC9);
    Count_Diff_AT_CERTSRC10 := COUNT(GROUP,%Closest%.Diff_AT_CERTSRC10);
    Count_Diff_AT_CERTLEV1 := COUNT(GROUP,%Closest%.Diff_AT_CERTLEV1);
    Count_Diff_AT_CERTLEV2 := COUNT(GROUP,%Closest%.Diff_AT_CERTLEV2);
    Count_Diff_AT_CERTLEV3 := COUNT(GROUP,%Closest%.Diff_AT_CERTLEV3);
    Count_Diff_AT_CERTLEV4 := COUNT(GROUP,%Closest%.Diff_AT_CERTLEV4);
    Count_Diff_AT_CERTLEV5 := COUNT(GROUP,%Closest%.Diff_AT_CERTLEV5);
    Count_Diff_AT_CERTLEV6 := COUNT(GROUP,%Closest%.Diff_AT_CERTLEV6);
    Count_Diff_AT_CERTLEV7 := COUNT(GROUP,%Closest%.Diff_AT_CERTLEV7);
    Count_Diff_AT_CERTLEV8 := COUNT(GROUP,%Closest%.Diff_AT_CERTLEV8);
    Count_Diff_AT_CERTLEV9 := COUNT(GROUP,%Closest%.Diff_AT_CERTLEV9);
    Count_Diff_AT_CERTLEV10 := COUNT(GROUP,%Closest%.Diff_AT_CERTLEV10);
    Count_Diff_AT_CERTNUM1 := COUNT(GROUP,%Closest%.Diff_AT_CERTNUM1);
    Count_Diff_AT_CERTNUM2 := COUNT(GROUP,%Closest%.Diff_AT_CERTNUM2);
    Count_Diff_AT_CERTNUM3 := COUNT(GROUP,%Closest%.Diff_AT_CERTNUM3);
    Count_Diff_AT_CERTNUM4 := COUNT(GROUP,%Closest%.Diff_AT_CERTNUM4);
    Count_Diff_AT_CERTNUM5 := COUNT(GROUP,%Closest%.Diff_AT_CERTNUM5);
    Count_Diff_AT_CERTNUM6 := COUNT(GROUP,%Closest%.Diff_AT_CERTNUM6);
    Count_Diff_AT_CERTNUM7 := COUNT(GROUP,%Closest%.Diff_AT_CERTNUM7);
    Count_Diff_AT_CERTNUM8 := COUNT(GROUP,%Closest%.Diff_AT_CERTNUM8);
    Count_Diff_AT_CERTNUM9 := COUNT(GROUP,%Closest%.Diff_AT_CERTNUM9);
    Count_Diff_AT_CERTNUM10 := COUNT(GROUP,%Closest%.Diff_AT_CERTNUM10);
    Count_Diff_AT_CERTEXP1 := COUNT(GROUP,%Closest%.Diff_AT_CERTEXP1);
    Count_Diff_AT_CERTEXP2 := COUNT(GROUP,%Closest%.Diff_AT_CERTEXP2);
    Count_Diff_AT_CERTEXP3 := COUNT(GROUP,%Closest%.Diff_AT_CERTEXP3);
    Count_Diff_AT_CERTEXP4 := COUNT(GROUP,%Closest%.Diff_AT_CERTEXP4);
    Count_Diff_AT_CERTEXP5 := COUNT(GROUP,%Closest%.Diff_AT_CERTEXP5);
    Count_Diff_AT_CERTEXP6 := COUNT(GROUP,%Closest%.Diff_AT_CERTEXP6);
    Count_Diff_AT_CERTEXP7 := COUNT(GROUP,%Closest%.Diff_AT_CERTEXP7);
    Count_Diff_AT_CERTEXP8 := COUNT(GROUP,%Closest%.Diff_AT_CERTEXP8);
    Count_Diff_AT_CERTEXP9 := COUNT(GROUP,%Closest%.Diff_AT_CERTEXP9);
    Count_Diff_AT_CERTEXP10 := COUNT(GROUP,%Closest%.Diff_AT_CERTEXP10);
    Count_Diff_EFX_EXTRACT_DATE := COUNT(GROUP,%Closest%.Diff_EFX_EXTRACT_DATE);
    Count_Diff_EFX_MERCHANT_ID := COUNT(GROUP,%Closest%.Diff_EFX_MERCHANT_ID);
    Count_Diff_EFX_PROJECT_ID := COUNT(GROUP,%Closest%.Diff_EFX_PROJECT_ID);
    Count_Diff_EFX_FOREIGN := COUNT(GROUP,%Closest%.Diff_EFX_FOREIGN);
    Count_Diff_Record_Update_Refresh_Date := COUNT(GROUP,%Closest%.Diff_Record_Update_Refresh_Date);
    Count_Diff_EFX_DATE_CREATED := COUNT(GROUP,%Closest%.Diff_EFX_DATE_CREATED);
    Count_Diff_normCompany_Name := COUNT(GROUP,%Closest%.Diff_normCompany_Name);
    Count_Diff_normCompany_Type := COUNT(GROUP,%Closest%.Diff_normCompany_Type);
    Count_Diff_Norm_Geo_Precision := COUNT(GROUP,%Closest%.Diff_Norm_Geo_Precision);
    Count_Diff_Norm_Corporate_Amount_Precision := COUNT(GROUP,%Closest%.Diff_Norm_Corporate_Amount_Precision);
    Count_Diff_Norm_Location_Amount_Precision := COUNT(GROUP,%Closest%.Diff_Norm_Location_Amount_Precision);
    Count_Diff_Norm_Public_Co_Indicator := COUNT(GROUP,%Closest%.Diff_Norm_Public_Co_Indicator);
    Count_Diff_Norm_Stock_Exchange := COUNT(GROUP,%Closest%.Diff_Norm_Stock_Exchange);
    Count_Diff_Norm_Telemarketablity_Score := COUNT(GROUP,%Closest%.Diff_Norm_Telemarketablity_Score);
    Count_Diff_Norm_Telemarketablity_Total_Indicator := COUNT(GROUP,%Closest%.Diff_Norm_Telemarketablity_Total_Indicator);
    Count_Diff_Norm_Telemarketablity_Total_Score := COUNT(GROUP,%Closest%.Diff_Norm_Telemarketablity_Total_Score);
    Count_Diff_Norm_Government1057_Entity := COUNT(GROUP,%Closest%.Diff_Norm_Government1057_Entity);
    Count_Diff_Norm_Merchant_Type := COUNT(GROUP,%Closest%.Diff_Norm_Merchant_Type);
    Count_Diff_NormAddress_Type := COUNT(GROUP,%Closest%.Diff_NormAddress_Type);
    Count_Diff_Norm_Address := COUNT(GROUP,%Closest%.Diff_Norm_Address);
    Count_Diff_Norm_City := COUNT(GROUP,%Closest%.Diff_Norm_City);
    Count_Diff_Norm_State := COUNT(GROUP,%Closest%.Diff_Norm_State);
    Count_Diff_Norm_StateC2 := COUNT(GROUP,%Closest%.Diff_Norm_StateC2);
    Count_Diff_Norm_Zip := COUNT(GROUP,%Closest%.Diff_Norm_Zip);
    Count_Diff_Norm_Zip4 := COUNT(GROUP,%Closest%.Diff_Norm_Zip4);
    Count_Diff_Norm_Lat := COUNT(GROUP,%Closest%.Diff_Norm_Lat);
    Count_Diff_Norm_Lon := COUNT(GROUP,%Closest%.Diff_Norm_Lon);
    Count_Diff_Norm_Geoprec := COUNT(GROUP,%Closest%.Diff_Norm_Geoprec);
    Count_Diff_Norm_Region := COUNT(GROUP,%Closest%.Diff_Norm_Region);
    Count_Diff_Norm_Ctryisocd := COUNT(GROUP,%Closest%.Diff_Norm_Ctryisocd);
    Count_Diff_Norm_Ctrynum := COUNT(GROUP,%Closest%.Diff_Norm_Ctrynum);
    Count_Diff_Norm_Ctryname := COUNT(GROUP,%Closest%.Diff_Norm_Ctryname);
    Count_Diff_clean_company_name := COUNT(GROUP,%Closest%.Diff_clean_company_name);
    Count_Diff_clean_phone := COUNT(GROUP,%Closest%.Diff_clean_phone);
    Count_Diff_clean_secondary_phone := COUNT(GROUP,%Closest%.Diff_clean_secondary_phone);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_name_score := COUNT(GROUP,%Closest%.Diff_name_score);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_addr_suffix := COUNT(GROUP,%Closest%.Diff_addr_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_p_city_name := COUNT(GROUP,%Closest%.Diff_p_city_name);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cr_sort_sz);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
// Now determine the consistency of the identifiers
EXPORT UIDConsistency(infile) := FUNCTIONMACRO
  f := TABLE(infile,{rcid,seleid}) : GLOBAL; // Consistent type independent of input
  m := MODULE
    r := RECORD
      UNSIGNED rcid_null0 := COUNT(GROUP,(UNSIGNED)f.rcid=0);
      UNSIGNED rcid_belowparent0 := COUNT(GROUP,(UNSIGNED)f.rcid<(UNSIGNED)f.seleid);
      UNSIGNED rcid_atparent := COUNT(GROUP,(UNSIGNED)f.seleid=(UNSIGNED)f.rcid);
      UNSIGNED seleid_null0 := COUNT(GROUP,(UNSIGNED)f.seleid=0);
    END;
  EXPORT Basic0 := TABLE(f,r);
  EXPORT rcid_Clusters := SALT37.MOD_ClusterStats.Counts(f,rcid);
  EXPORT seleid_Clusters := SALT37.MOD_ClusterStats.Counts(f,seleid);
  EXPORT IdCounts := DATASET([{'rcid_Cnt', SUM(rcid_Clusters,NumberOfClusters)},{'seleid_Cnt', SUM(seleid_Clusters,NumberOfClusters)}],{STRING10 Count_Type, UNSIGNED Cnt}); // The counts of each ID
 // For deeper debugging; provide the unbased parents
    bases := f((UNSIGNED)seleid=(UNSIGNED)rcid); // Get the bases
  EXPORT seleid_Unbased := JOIN(f(seleid<>0),bases,LEFT.seleid=RIGHT.seleid,TRANSFORM(LEFT),LEFT ONLY,HASH);
 // Children with two parents
    f_thin := TABLE(f(rcid<>0,seleid<>0),{rcid,seleid},rcid,seleid,MERGE);
  EXPORT rcid_Twoparents := DEDUP(JOIN(f_thin,f_thin,LEFT.rcid=RIGHT.rcid AND LEFT.seleid>RIGHT.seleid,TRANSFORM({SALT37.UIDType seleid1,SALT37.UIDType rcid,SALT37.UIDType seleid2},SELF.seleid1:=LEFT.seleid,SELF.seleid2:=RIGHT.seleid,SELF.rcid:=LEFT.rcid),HASH),WHOLE RECORD,ALL);
 // Now compute the more involved consistency checks
    r := RECORD
      {Basic0} AND NOT [rcid_atparent];
      INTEGER seleid_unbased0 := IdCounts[2].Cnt-Basic0.rcid_atparent-IF(Basic0.seleid_null0>0,1,0);
      INTEGER rcid_Twoparents0 := COUNT(rcid_Twoparents);
    END;
  Advanced00 := TABLE(Basic0,r);
  Advanced0Layout := {STRING label, INTEGER null0, INTEGER belowparent0, INTEGER unbased0, INTEGER Twoparents0};
  EXPORT Advanced0 := SORT(SALT37.MAC_Pivot(Advanced00,Advanced0Layout), MAP(label='rcid'=>0,1));
  END;
  RETURN m;
ENDMACRO;
END;
