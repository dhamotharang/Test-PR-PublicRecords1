IMPORT SALT311;
IMPORT Scrubs_YellowPages; // Import modules for FieldTypes attribute definitions
EXPORT Input_Fields := MODULE
 
EXPORT NumFields := 103;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_numeric','invalid_mandatory','invalid_date','invalid_orig_city','invalid_orig_state','invalid_orig_zip','invalid_sic_code','invalid_sic2','invalid_sic3','invalid_sic4','invalid_naics_code','invalid_orig_phone10');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_numeric' => 1,'invalid_mandatory' => 2,'invalid_date' => 3,'invalid_orig_city' => 4,'invalid_orig_state' => 5,'invalid_orig_zip' => 6,'invalid_sic_code' => 7,'invalid_sic2' => 8,'invalid_sic3' => 9,'invalid_sic4' => 10,'invalid_naics_code' => 11,'invalid_orig_phone10' => 12,0);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(~Scrubs_YellowPages.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_YellowPages.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mandatory(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT311.StrType s) := WHICH(~Scrubs_YellowPages.Functions.fn_populated_strings(s)>0);
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_YellowPages.Functions.fn_populated_strings'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_date(SALT311.StrType s) := WHICH(~Scrubs_YellowPages.Functions.fn_valid_date(s)>0);
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_YellowPages.Functions.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_city(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_city(SALT311.StrType s,SALT311.StrType orig_state,SALT311.StrType orig_zip) := WHICH(~Scrubs_YellowPages.Functions.fn_populated_strings(s,orig_state,orig_zip)>0);
EXPORT InValidMessageFT_invalid_orig_city(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_YellowPages.Functions.fn_populated_strings'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_state(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_state(SALT311.StrType s) := WHICH(~Scrubs_YellowPages.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_orig_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_YellowPages.Functions.fn_verify_state'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_zip(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_zip(SALT311.StrType s) := WHICH(~Scrubs_YellowPages.Functions.fn_verify_zip59(s)>0);
EXPORT InValidMessageFT_invalid_orig_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_YellowPages.Functions.fn_verify_zip59'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sic_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sic_code(SALT311.StrType s) := WHICH(~Scrubs_YellowPages.Functions.fn_valid_SicCode(s)>0);
EXPORT InValidMessageFT_invalid_sic_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_YellowPages.Functions.fn_valid_SicCode'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sic2(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sic2(SALT311.StrType s) := WHICH(~Scrubs_YellowPages.Functions.fn_valid_SicCode(s)>0);
EXPORT InValidMessageFT_invalid_sic2(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_YellowPages.Functions.fn_valid_SicCode'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sic3(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sic3(SALT311.StrType s) := WHICH(~Scrubs_YellowPages.Functions.fn_valid_SicCode(s)>0);
EXPORT InValidMessageFT_invalid_sic3(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_YellowPages.Functions.fn_valid_SicCode'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sic4(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sic4(SALT311.StrType s) := WHICH(~Scrubs_YellowPages.Functions.fn_valid_SicCode(s)>0);
EXPORT InValidMessageFT_invalid_sic4(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_YellowPages.Functions.fn_valid_SicCode'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_naics_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_naics_code(SALT311.StrType s) := WHICH(~Scrubs_YellowPages.Functions.fn_validate_NAICSCode(s)>0);
EXPORT InValidMessageFT_invalid_naics_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_YellowPages.Functions.fn_validate_NAICSCode'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_phone10(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_phone10(SALT311.StrType s) := WHICH(~Scrubs_YellowPages.Functions.fn_numeric(s,10)>0);
EXPORT InValidMessageFT_invalid_orig_phone10(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_YellowPages.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'primary_key','chainid','filler1','pub_date','busshortname','business_name','busdeptname','house','predir','street','streettype','postdir','apttype','aptnbr','boxnbr','exppubcity','orig_city','orig_state','orig_zip','dpc','carrierroute','fips','countycode','z4type','ctract','cblockgroup','cblockid','msa','cbsa','mcdcode','filler2','addrsensitivity','maildeliverabilitycode','sic1_4','sic_code','sic2','sic3','sic4','indstryclass','naics_code','mlsc','filler3','orig_phone10','nosolicitcode','dso','timezone','validationflag','validationdate','secvalidationcode','singleaddrflag','filler4','gender','execname','exectitlecode','exectitle','condtitlecode','condtitle','contfunctioncode','contfunction','profession','emplsizecode','annualsalescode','yrsinbus','ethniccode','filler5','latlongmatchlevel','orig_latitude','orig_longitude','filler6','heading_string','ypheading2','ypheading3','ypheading4','ypheading5','ypheading6','maxypadsize','filler7','faxac','faxexchge','faxphone','altac','altexchge','altphone','mobileac','mobileexchge','mobilephone','tollfreeac','tollfreeexchge','tollfreephone','creditcards','brands','stdhrs','hrsopen','web_address','filler8','email_address','services','condheading','tagline','filler9','totaladspend','filler10','crlf');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'primary_key','chainid','filler1','pub_date','busshortname','business_name','busdeptname','house','predir','street','streettype','postdir','apttype','aptnbr','boxnbr','exppubcity','orig_city','orig_state','orig_zip','dpc','carrierroute','fips','countycode','z4type','ctract','cblockgroup','cblockid','msa','cbsa','mcdcode','filler2','addrsensitivity','maildeliverabilitycode','sic1_4','sic_code','sic2','sic3','sic4','indstryclass','naics_code','mlsc','filler3','orig_phone10','nosolicitcode','dso','timezone','validationflag','validationdate','secvalidationcode','singleaddrflag','filler4','gender','execname','exectitlecode','exectitle','condtitlecode','condtitle','contfunctioncode','contfunction','profession','emplsizecode','annualsalescode','yrsinbus','ethniccode','filler5','latlongmatchlevel','orig_latitude','orig_longitude','filler6','heading_string','ypheading2','ypheading3','ypheading4','ypheading5','ypheading6','maxypadsize','filler7','faxac','faxexchge','faxphone','altac','altexchge','altphone','mobileac','mobileexchge','mobilephone','tollfreeac','tollfreeexchge','tollfreephone','creditcards','brands','stdhrs','hrsopen','web_address','filler8','email_address','services','condheading','tagline','filler9','totaladspend','filler10','crlf');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'primary_key' => 0,'chainid' => 1,'filler1' => 2,'pub_date' => 3,'busshortname' => 4,'business_name' => 5,'busdeptname' => 6,'house' => 7,'predir' => 8,'street' => 9,'streettype' => 10,'postdir' => 11,'apttype' => 12,'aptnbr' => 13,'boxnbr' => 14,'exppubcity' => 15,'orig_city' => 16,'orig_state' => 17,'orig_zip' => 18,'dpc' => 19,'carrierroute' => 20,'fips' => 21,'countycode' => 22,'z4type' => 23,'ctract' => 24,'cblockgroup' => 25,'cblockid' => 26,'msa' => 27,'cbsa' => 28,'mcdcode' => 29,'filler2' => 30,'addrsensitivity' => 31,'maildeliverabilitycode' => 32,'sic1_4' => 33,'sic_code' => 34,'sic2' => 35,'sic3' => 36,'sic4' => 37,'indstryclass' => 38,'naics_code' => 39,'mlsc' => 40,'filler3' => 41,'orig_phone10' => 42,'nosolicitcode' => 43,'dso' => 44,'timezone' => 45,'validationflag' => 46,'validationdate' => 47,'secvalidationcode' => 48,'singleaddrflag' => 49,'filler4' => 50,'gender' => 51,'execname' => 52,'exectitlecode' => 53,'exectitle' => 54,'condtitlecode' => 55,'condtitle' => 56,'contfunctioncode' => 57,'contfunction' => 58,'profession' => 59,'emplsizecode' => 60,'annualsalescode' => 61,'yrsinbus' => 62,'ethniccode' => 63,'filler5' => 64,'latlongmatchlevel' => 65,'orig_latitude' => 66,'orig_longitude' => 67,'filler6' => 68,'heading_string' => 69,'ypheading2' => 70,'ypheading3' => 71,'ypheading4' => 72,'ypheading5' => 73,'ypheading6' => 74,'maxypadsize' => 75,'filler7' => 76,'faxac' => 77,'faxexchge' => 78,'faxphone' => 79,'altac' => 80,'altexchge' => 81,'altphone' => 82,'mobileac' => 83,'mobileexchge' => 84,'mobilephone' => 85,'tollfreeac' => 86,'tollfreeexchge' => 87,'tollfreephone' => 88,'creditcards' => 89,'brands' => 90,'stdhrs' => 91,'hrsopen' => 92,'web_address' => 93,'filler8' => 94,'email_address' => 95,'services' => 96,'condheading' => 97,'tagline' => 98,'filler9' => 99,'totaladspend' => 100,'filler10' => 101,'crlf' => 102,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],[],[],['CUSTOM'],[],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],[],[],['CUSTOM'],[],[],[],[],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_primary_key(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_primary_key(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_primary_key(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_chainid(SALT311.StrType s0) := s0;
EXPORT InValid_chainid(SALT311.StrType s) := 0;
EXPORT InValidMessage_chainid(UNSIGNED1 wh) := '';
 
EXPORT Make_filler1(SALT311.StrType s0) := s0;
EXPORT InValid_filler1(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler1(UNSIGNED1 wh) := '';
 
EXPORT Make_pub_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_pub_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_pub_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_busshortname(SALT311.StrType s0) := s0;
EXPORT InValid_busshortname(SALT311.StrType s) := 0;
EXPORT InValidMessage_busshortname(UNSIGNED1 wh) := '';
 
EXPORT Make_business_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_business_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_business_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_busdeptname(SALT311.StrType s0) := s0;
EXPORT InValid_busdeptname(SALT311.StrType s) := 0;
EXPORT InValidMessage_busdeptname(UNSIGNED1 wh) := '';
 
EXPORT Make_house(SALT311.StrType s0) := s0;
EXPORT InValid_house(SALT311.StrType s) := 0;
EXPORT InValidMessage_house(UNSIGNED1 wh) := '';
 
EXPORT Make_predir(SALT311.StrType s0) := s0;
EXPORT InValid_predir(SALT311.StrType s) := 0;
EXPORT InValidMessage_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_street(SALT311.StrType s0) := s0;
EXPORT InValid_street(SALT311.StrType s) := 0;
EXPORT InValidMessage_street(UNSIGNED1 wh) := '';
 
EXPORT Make_streettype(SALT311.StrType s0) := s0;
EXPORT InValid_streettype(SALT311.StrType s) := 0;
EXPORT InValidMessage_streettype(UNSIGNED1 wh) := '';
 
EXPORT Make_postdir(SALT311.StrType s0) := s0;
EXPORT InValid_postdir(SALT311.StrType s) := 0;
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_apttype(SALT311.StrType s0) := s0;
EXPORT InValid_apttype(SALT311.StrType s) := 0;
EXPORT InValidMessage_apttype(UNSIGNED1 wh) := '';
 
EXPORT Make_aptnbr(SALT311.StrType s0) := s0;
EXPORT InValid_aptnbr(SALT311.StrType s) := 0;
EXPORT InValidMessage_aptnbr(UNSIGNED1 wh) := '';
 
EXPORT Make_boxnbr(SALT311.StrType s0) := s0;
EXPORT InValid_boxnbr(SALT311.StrType s) := 0;
EXPORT InValidMessage_boxnbr(UNSIGNED1 wh) := '';
 
EXPORT Make_exppubcity(SALT311.StrType s0) := s0;
EXPORT InValid_exppubcity(SALT311.StrType s) := 0;
EXPORT InValidMessage_exppubcity(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_city(SALT311.StrType s0) := MakeFT_invalid_orig_city(s0);
EXPORT InValid_orig_city(SALT311.StrType s,SALT311.StrType orig_state,SALT311.StrType orig_zip) := InValidFT_invalid_orig_city(s,orig_state,orig_zip);
EXPORT InValidMessage_orig_city(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_city(wh);
 
EXPORT Make_orig_state(SALT311.StrType s0) := MakeFT_invalid_orig_state(s0);
EXPORT InValid_orig_state(SALT311.StrType s) := InValidFT_invalid_orig_state(s);
EXPORT InValidMessage_orig_state(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_state(wh);
 
EXPORT Make_orig_zip(SALT311.StrType s0) := MakeFT_invalid_orig_zip(s0);
EXPORT InValid_orig_zip(SALT311.StrType s) := InValidFT_invalid_orig_zip(s);
EXPORT InValidMessage_orig_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_zip(wh);
 
EXPORT Make_dpc(SALT311.StrType s0) := s0;
EXPORT InValid_dpc(SALT311.StrType s) := 0;
EXPORT InValidMessage_dpc(UNSIGNED1 wh) := '';
 
EXPORT Make_carrierroute(SALT311.StrType s0) := s0;
EXPORT InValid_carrierroute(SALT311.StrType s) := 0;
EXPORT InValidMessage_carrierroute(UNSIGNED1 wh) := '';
 
EXPORT Make_fips(SALT311.StrType s0) := s0;
EXPORT InValid_fips(SALT311.StrType s) := 0;
EXPORT InValidMessage_fips(UNSIGNED1 wh) := '';
 
EXPORT Make_countycode(SALT311.StrType s0) := s0;
EXPORT InValid_countycode(SALT311.StrType s) := 0;
EXPORT InValidMessage_countycode(UNSIGNED1 wh) := '';
 
EXPORT Make_z4type(SALT311.StrType s0) := s0;
EXPORT InValid_z4type(SALT311.StrType s) := 0;
EXPORT InValidMessage_z4type(UNSIGNED1 wh) := '';
 
EXPORT Make_ctract(SALT311.StrType s0) := s0;
EXPORT InValid_ctract(SALT311.StrType s) := 0;
EXPORT InValidMessage_ctract(UNSIGNED1 wh) := '';
 
EXPORT Make_cblockgroup(SALT311.StrType s0) := s0;
EXPORT InValid_cblockgroup(SALT311.StrType s) := 0;
EXPORT InValidMessage_cblockgroup(UNSIGNED1 wh) := '';
 
EXPORT Make_cblockid(SALT311.StrType s0) := s0;
EXPORT InValid_cblockid(SALT311.StrType s) := 0;
EXPORT InValidMessage_cblockid(UNSIGNED1 wh) := '';
 
EXPORT Make_msa(SALT311.StrType s0) := s0;
EXPORT InValid_msa(SALT311.StrType s) := 0;
EXPORT InValidMessage_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_cbsa(SALT311.StrType s0) := s0;
EXPORT InValid_cbsa(SALT311.StrType s) := 0;
EXPORT InValidMessage_cbsa(UNSIGNED1 wh) := '';
 
EXPORT Make_mcdcode(SALT311.StrType s0) := s0;
EXPORT InValid_mcdcode(SALT311.StrType s) := 0;
EXPORT InValidMessage_mcdcode(UNSIGNED1 wh) := '';
 
EXPORT Make_filler2(SALT311.StrType s0) := s0;
EXPORT InValid_filler2(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler2(UNSIGNED1 wh) := '';
 
EXPORT Make_addrsensitivity(SALT311.StrType s0) := s0;
EXPORT InValid_addrsensitivity(SALT311.StrType s) := 0;
EXPORT InValidMessage_addrsensitivity(UNSIGNED1 wh) := '';
 
EXPORT Make_maildeliverabilitycode(SALT311.StrType s0) := s0;
EXPORT InValid_maildeliverabilitycode(SALT311.StrType s) := 0;
EXPORT InValidMessage_maildeliverabilitycode(UNSIGNED1 wh) := '';
 
EXPORT Make_sic1_4(SALT311.StrType s0) := s0;
EXPORT InValid_sic1_4(SALT311.StrType s) := 0;
EXPORT InValidMessage_sic1_4(UNSIGNED1 wh) := '';
 
EXPORT Make_sic_code(SALT311.StrType s0) := MakeFT_invalid_sic_code(s0);
EXPORT InValid_sic_code(SALT311.StrType s) := InValidFT_invalid_sic_code(s);
EXPORT InValidMessage_sic_code(UNSIGNED1 wh) := InValidMessageFT_invalid_sic_code(wh);
 
EXPORT Make_sic2(SALT311.StrType s0) := MakeFT_invalid_sic2(s0);
EXPORT InValid_sic2(SALT311.StrType s) := InValidFT_invalid_sic2(s);
EXPORT InValidMessage_sic2(UNSIGNED1 wh) := InValidMessageFT_invalid_sic2(wh);
 
EXPORT Make_sic3(SALT311.StrType s0) := MakeFT_invalid_sic3(s0);
EXPORT InValid_sic3(SALT311.StrType s) := InValidFT_invalid_sic3(s);
EXPORT InValidMessage_sic3(UNSIGNED1 wh) := InValidMessageFT_invalid_sic3(wh);
 
EXPORT Make_sic4(SALT311.StrType s0) := MakeFT_invalid_sic4(s0);
EXPORT InValid_sic4(SALT311.StrType s) := InValidFT_invalid_sic4(s);
EXPORT InValidMessage_sic4(UNSIGNED1 wh) := InValidMessageFT_invalid_sic4(wh);
 
EXPORT Make_indstryclass(SALT311.StrType s0) := s0;
EXPORT InValid_indstryclass(SALT311.StrType s) := 0;
EXPORT InValidMessage_indstryclass(UNSIGNED1 wh) := '';
 
EXPORT Make_naics_code(SALT311.StrType s0) := MakeFT_invalid_naics_code(s0);
EXPORT InValid_naics_code(SALT311.StrType s) := InValidFT_invalid_naics_code(s);
EXPORT InValidMessage_naics_code(UNSIGNED1 wh) := InValidMessageFT_invalid_naics_code(wh);
 
EXPORT Make_mlsc(SALT311.StrType s0) := s0;
EXPORT InValid_mlsc(SALT311.StrType s) := 0;
EXPORT InValidMessage_mlsc(UNSIGNED1 wh) := '';
 
EXPORT Make_filler3(SALT311.StrType s0) := s0;
EXPORT InValid_filler3(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler3(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_phone10(SALT311.StrType s0) := MakeFT_invalid_orig_phone10(s0);
EXPORT InValid_orig_phone10(SALT311.StrType s) := InValidFT_invalid_orig_phone10(s);
EXPORT InValidMessage_orig_phone10(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_phone10(wh);
 
EXPORT Make_nosolicitcode(SALT311.StrType s0) := s0;
EXPORT InValid_nosolicitcode(SALT311.StrType s) := 0;
EXPORT InValidMessage_nosolicitcode(UNSIGNED1 wh) := '';
 
EXPORT Make_dso(SALT311.StrType s0) := s0;
EXPORT InValid_dso(SALT311.StrType s) := 0;
EXPORT InValidMessage_dso(UNSIGNED1 wh) := '';
 
EXPORT Make_timezone(SALT311.StrType s0) := s0;
EXPORT InValid_timezone(SALT311.StrType s) := 0;
EXPORT InValidMessage_timezone(UNSIGNED1 wh) := '';
 
EXPORT Make_validationflag(SALT311.StrType s0) := s0;
EXPORT InValid_validationflag(SALT311.StrType s) := 0;
EXPORT InValidMessage_validationflag(UNSIGNED1 wh) := '';
 
EXPORT Make_validationdate(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_validationdate(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_validationdate(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_secvalidationcode(SALT311.StrType s0) := s0;
EXPORT InValid_secvalidationcode(SALT311.StrType s) := 0;
EXPORT InValidMessage_secvalidationcode(UNSIGNED1 wh) := '';
 
EXPORT Make_singleaddrflag(SALT311.StrType s0) := s0;
EXPORT InValid_singleaddrflag(SALT311.StrType s) := 0;
EXPORT InValidMessage_singleaddrflag(UNSIGNED1 wh) := '';
 
EXPORT Make_filler4(SALT311.StrType s0) := s0;
EXPORT InValid_filler4(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler4(UNSIGNED1 wh) := '';
 
EXPORT Make_gender(SALT311.StrType s0) := s0;
EXPORT InValid_gender(SALT311.StrType s) := 0;
EXPORT InValidMessage_gender(UNSIGNED1 wh) := '';
 
EXPORT Make_execname(SALT311.StrType s0) := s0;
EXPORT InValid_execname(SALT311.StrType s) := 0;
EXPORT InValidMessage_execname(UNSIGNED1 wh) := '';
 
EXPORT Make_exectitlecode(SALT311.StrType s0) := s0;
EXPORT InValid_exectitlecode(SALT311.StrType s) := 0;
EXPORT InValidMessage_exectitlecode(UNSIGNED1 wh) := '';
 
EXPORT Make_exectitle(SALT311.StrType s0) := s0;
EXPORT InValid_exectitle(SALT311.StrType s) := 0;
EXPORT InValidMessage_exectitle(UNSIGNED1 wh) := '';
 
EXPORT Make_condtitlecode(SALT311.StrType s0) := s0;
EXPORT InValid_condtitlecode(SALT311.StrType s) := 0;
EXPORT InValidMessage_condtitlecode(UNSIGNED1 wh) := '';
 
EXPORT Make_condtitle(SALT311.StrType s0) := s0;
EXPORT InValid_condtitle(SALT311.StrType s) := 0;
EXPORT InValidMessage_condtitle(UNSIGNED1 wh) := '';
 
EXPORT Make_contfunctioncode(SALT311.StrType s0) := s0;
EXPORT InValid_contfunctioncode(SALT311.StrType s) := 0;
EXPORT InValidMessage_contfunctioncode(UNSIGNED1 wh) := '';
 
EXPORT Make_contfunction(SALT311.StrType s0) := s0;
EXPORT InValid_contfunction(SALT311.StrType s) := 0;
EXPORT InValidMessage_contfunction(UNSIGNED1 wh) := '';
 
EXPORT Make_profession(SALT311.StrType s0) := s0;
EXPORT InValid_profession(SALT311.StrType s) := 0;
EXPORT InValidMessage_profession(UNSIGNED1 wh) := '';
 
EXPORT Make_emplsizecode(SALT311.StrType s0) := s0;
EXPORT InValid_emplsizecode(SALT311.StrType s) := 0;
EXPORT InValidMessage_emplsizecode(UNSIGNED1 wh) := '';
 
EXPORT Make_annualsalescode(SALT311.StrType s0) := s0;
EXPORT InValid_annualsalescode(SALT311.StrType s) := 0;
EXPORT InValidMessage_annualsalescode(UNSIGNED1 wh) := '';
 
EXPORT Make_yrsinbus(SALT311.StrType s0) := s0;
EXPORT InValid_yrsinbus(SALT311.StrType s) := 0;
EXPORT InValidMessage_yrsinbus(UNSIGNED1 wh) := '';
 
EXPORT Make_ethniccode(SALT311.StrType s0) := s0;
EXPORT InValid_ethniccode(SALT311.StrType s) := 0;
EXPORT InValidMessage_ethniccode(UNSIGNED1 wh) := '';
 
EXPORT Make_filler5(SALT311.StrType s0) := s0;
EXPORT InValid_filler5(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler5(UNSIGNED1 wh) := '';
 
EXPORT Make_latlongmatchlevel(SALT311.StrType s0) := s0;
EXPORT InValid_latlongmatchlevel(SALT311.StrType s) := 0;
EXPORT InValidMessage_latlongmatchlevel(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_latitude(SALT311.StrType s0) := s0;
EXPORT InValid_orig_latitude(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_latitude(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_longitude(SALT311.StrType s0) := s0;
EXPORT InValid_orig_longitude(SALT311.StrType s) := 0;
EXPORT InValidMessage_orig_longitude(UNSIGNED1 wh) := '';
 
EXPORT Make_filler6(SALT311.StrType s0) := s0;
EXPORT InValid_filler6(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler6(UNSIGNED1 wh) := '';
 
EXPORT Make_heading_string(SALT311.StrType s0) := s0;
EXPORT InValid_heading_string(SALT311.StrType s) := 0;
EXPORT InValidMessage_heading_string(UNSIGNED1 wh) := '';
 
EXPORT Make_ypheading2(SALT311.StrType s0) := s0;
EXPORT InValid_ypheading2(SALT311.StrType s) := 0;
EXPORT InValidMessage_ypheading2(UNSIGNED1 wh) := '';
 
EXPORT Make_ypheading3(SALT311.StrType s0) := s0;
EXPORT InValid_ypheading3(SALT311.StrType s) := 0;
EXPORT InValidMessage_ypheading3(UNSIGNED1 wh) := '';
 
EXPORT Make_ypheading4(SALT311.StrType s0) := s0;
EXPORT InValid_ypheading4(SALT311.StrType s) := 0;
EXPORT InValidMessage_ypheading4(UNSIGNED1 wh) := '';
 
EXPORT Make_ypheading5(SALT311.StrType s0) := s0;
EXPORT InValid_ypheading5(SALT311.StrType s) := 0;
EXPORT InValidMessage_ypheading5(UNSIGNED1 wh) := '';
 
EXPORT Make_ypheading6(SALT311.StrType s0) := s0;
EXPORT InValid_ypheading6(SALT311.StrType s) := 0;
EXPORT InValidMessage_ypheading6(UNSIGNED1 wh) := '';
 
EXPORT Make_maxypadsize(SALT311.StrType s0) := s0;
EXPORT InValid_maxypadsize(SALT311.StrType s) := 0;
EXPORT InValidMessage_maxypadsize(UNSIGNED1 wh) := '';
 
EXPORT Make_filler7(SALT311.StrType s0) := s0;
EXPORT InValid_filler7(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler7(UNSIGNED1 wh) := '';
 
EXPORT Make_faxac(SALT311.StrType s0) := s0;
EXPORT InValid_faxac(SALT311.StrType s) := 0;
EXPORT InValidMessage_faxac(UNSIGNED1 wh) := '';
 
EXPORT Make_faxexchge(SALT311.StrType s0) := s0;
EXPORT InValid_faxexchge(SALT311.StrType s) := 0;
EXPORT InValidMessage_faxexchge(UNSIGNED1 wh) := '';
 
EXPORT Make_faxphone(SALT311.StrType s0) := s0;
EXPORT InValid_faxphone(SALT311.StrType s) := 0;
EXPORT InValidMessage_faxphone(UNSIGNED1 wh) := '';
 
EXPORT Make_altac(SALT311.StrType s0) := s0;
EXPORT InValid_altac(SALT311.StrType s) := 0;
EXPORT InValidMessage_altac(UNSIGNED1 wh) := '';
 
EXPORT Make_altexchge(SALT311.StrType s0) := s0;
EXPORT InValid_altexchge(SALT311.StrType s) := 0;
EXPORT InValidMessage_altexchge(UNSIGNED1 wh) := '';
 
EXPORT Make_altphone(SALT311.StrType s0) := s0;
EXPORT InValid_altphone(SALT311.StrType s) := 0;
EXPORT InValidMessage_altphone(UNSIGNED1 wh) := '';
 
EXPORT Make_mobileac(SALT311.StrType s0) := s0;
EXPORT InValid_mobileac(SALT311.StrType s) := 0;
EXPORT InValidMessage_mobileac(UNSIGNED1 wh) := '';
 
EXPORT Make_mobileexchge(SALT311.StrType s0) := s0;
EXPORT InValid_mobileexchge(SALT311.StrType s) := 0;
EXPORT InValidMessage_mobileexchge(UNSIGNED1 wh) := '';
 
EXPORT Make_mobilephone(SALT311.StrType s0) := s0;
EXPORT InValid_mobilephone(SALT311.StrType s) := 0;
EXPORT InValidMessage_mobilephone(UNSIGNED1 wh) := '';
 
EXPORT Make_tollfreeac(SALT311.StrType s0) := s0;
EXPORT InValid_tollfreeac(SALT311.StrType s) := 0;
EXPORT InValidMessage_tollfreeac(UNSIGNED1 wh) := '';
 
EXPORT Make_tollfreeexchge(SALT311.StrType s0) := s0;
EXPORT InValid_tollfreeexchge(SALT311.StrType s) := 0;
EXPORT InValidMessage_tollfreeexchge(UNSIGNED1 wh) := '';
 
EXPORT Make_tollfreephone(SALT311.StrType s0) := s0;
EXPORT InValid_tollfreephone(SALT311.StrType s) := 0;
EXPORT InValidMessage_tollfreephone(UNSIGNED1 wh) := '';
 
EXPORT Make_creditcards(SALT311.StrType s0) := s0;
EXPORT InValid_creditcards(SALT311.StrType s) := 0;
EXPORT InValidMessage_creditcards(UNSIGNED1 wh) := '';
 
EXPORT Make_brands(SALT311.StrType s0) := s0;
EXPORT InValid_brands(SALT311.StrType s) := 0;
EXPORT InValidMessage_brands(UNSIGNED1 wh) := '';
 
EXPORT Make_stdhrs(SALT311.StrType s0) := s0;
EXPORT InValid_stdhrs(SALT311.StrType s) := 0;
EXPORT InValidMessage_stdhrs(UNSIGNED1 wh) := '';
 
EXPORT Make_hrsopen(SALT311.StrType s0) := s0;
EXPORT InValid_hrsopen(SALT311.StrType s) := 0;
EXPORT InValidMessage_hrsopen(UNSIGNED1 wh) := '';
 
EXPORT Make_web_address(SALT311.StrType s0) := s0;
EXPORT InValid_web_address(SALT311.StrType s) := 0;
EXPORT InValidMessage_web_address(UNSIGNED1 wh) := '';
 
EXPORT Make_filler8(SALT311.StrType s0) := s0;
EXPORT InValid_filler8(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler8(UNSIGNED1 wh) := '';
 
EXPORT Make_email_address(SALT311.StrType s0) := s0;
EXPORT InValid_email_address(SALT311.StrType s) := 0;
EXPORT InValidMessage_email_address(UNSIGNED1 wh) := '';
 
EXPORT Make_services(SALT311.StrType s0) := s0;
EXPORT InValid_services(SALT311.StrType s) := 0;
EXPORT InValidMessage_services(UNSIGNED1 wh) := '';
 
EXPORT Make_condheading(SALT311.StrType s0) := s0;
EXPORT InValid_condheading(SALT311.StrType s) := 0;
EXPORT InValidMessage_condheading(UNSIGNED1 wh) := '';
 
EXPORT Make_tagline(SALT311.StrType s0) := s0;
EXPORT InValid_tagline(SALT311.StrType s) := 0;
EXPORT InValidMessage_tagline(UNSIGNED1 wh) := '';
 
EXPORT Make_filler9(SALT311.StrType s0) := s0;
EXPORT InValid_filler9(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler9(UNSIGNED1 wh) := '';
 
EXPORT Make_totaladspend(SALT311.StrType s0) := s0;
EXPORT InValid_totaladspend(SALT311.StrType s) := 0;
EXPORT InValidMessage_totaladspend(UNSIGNED1 wh) := '';
 
EXPORT Make_filler10(SALT311.StrType s0) := s0;
EXPORT InValid_filler10(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler10(UNSIGNED1 wh) := '';
 
EXPORT Make_crlf(SALT311.StrType s0) := s0;
EXPORT InValid_crlf(SALT311.StrType s) := 0;
EXPORT InValidMessage_crlf(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_YellowPages;
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
    BOOLEAN Diff_primary_key;
    BOOLEAN Diff_chainid;
    BOOLEAN Diff_filler1;
    BOOLEAN Diff_pub_date;
    BOOLEAN Diff_busshortname;
    BOOLEAN Diff_business_name;
    BOOLEAN Diff_busdeptname;
    BOOLEAN Diff_house;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_street;
    BOOLEAN Diff_streettype;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_apttype;
    BOOLEAN Diff_aptnbr;
    BOOLEAN Diff_boxnbr;
    BOOLEAN Diff_exppubcity;
    BOOLEAN Diff_orig_city;
    BOOLEAN Diff_orig_state;
    BOOLEAN Diff_orig_zip;
    BOOLEAN Diff_dpc;
    BOOLEAN Diff_carrierroute;
    BOOLEAN Diff_fips;
    BOOLEAN Diff_countycode;
    BOOLEAN Diff_z4type;
    BOOLEAN Diff_ctract;
    BOOLEAN Diff_cblockgroup;
    BOOLEAN Diff_cblockid;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_cbsa;
    BOOLEAN Diff_mcdcode;
    BOOLEAN Diff_filler2;
    BOOLEAN Diff_addrsensitivity;
    BOOLEAN Diff_maildeliverabilitycode;
    BOOLEAN Diff_sic1_4;
    BOOLEAN Diff_sic_code;
    BOOLEAN Diff_sic2;
    BOOLEAN Diff_sic3;
    BOOLEAN Diff_sic4;
    BOOLEAN Diff_indstryclass;
    BOOLEAN Diff_naics_code;
    BOOLEAN Diff_mlsc;
    BOOLEAN Diff_filler3;
    BOOLEAN Diff_orig_phone10;
    BOOLEAN Diff_nosolicitcode;
    BOOLEAN Diff_dso;
    BOOLEAN Diff_timezone;
    BOOLEAN Diff_validationflag;
    BOOLEAN Diff_validationdate;
    BOOLEAN Diff_secvalidationcode;
    BOOLEAN Diff_singleaddrflag;
    BOOLEAN Diff_filler4;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_execname;
    BOOLEAN Diff_exectitlecode;
    BOOLEAN Diff_exectitle;
    BOOLEAN Diff_condtitlecode;
    BOOLEAN Diff_condtitle;
    BOOLEAN Diff_contfunctioncode;
    BOOLEAN Diff_contfunction;
    BOOLEAN Diff_profession;
    BOOLEAN Diff_emplsizecode;
    BOOLEAN Diff_annualsalescode;
    BOOLEAN Diff_yrsinbus;
    BOOLEAN Diff_ethniccode;
    BOOLEAN Diff_filler5;
    BOOLEAN Diff_latlongmatchlevel;
    BOOLEAN Diff_orig_latitude;
    BOOLEAN Diff_orig_longitude;
    BOOLEAN Diff_filler6;
    BOOLEAN Diff_heading_string;
    BOOLEAN Diff_ypheading2;
    BOOLEAN Diff_ypheading3;
    BOOLEAN Diff_ypheading4;
    BOOLEAN Diff_ypheading5;
    BOOLEAN Diff_ypheading6;
    BOOLEAN Diff_maxypadsize;
    BOOLEAN Diff_filler7;
    BOOLEAN Diff_faxac;
    BOOLEAN Diff_faxexchge;
    BOOLEAN Diff_faxphone;
    BOOLEAN Diff_altac;
    BOOLEAN Diff_altexchge;
    BOOLEAN Diff_altphone;
    BOOLEAN Diff_mobileac;
    BOOLEAN Diff_mobileexchge;
    BOOLEAN Diff_mobilephone;
    BOOLEAN Diff_tollfreeac;
    BOOLEAN Diff_tollfreeexchge;
    BOOLEAN Diff_tollfreephone;
    BOOLEAN Diff_creditcards;
    BOOLEAN Diff_brands;
    BOOLEAN Diff_stdhrs;
    BOOLEAN Diff_hrsopen;
    BOOLEAN Diff_web_address;
    BOOLEAN Diff_filler8;
    BOOLEAN Diff_email_address;
    BOOLEAN Diff_services;
    BOOLEAN Diff_condheading;
    BOOLEAN Diff_tagline;
    BOOLEAN Diff_filler9;
    BOOLEAN Diff_totaladspend;
    BOOLEAN Diff_filler10;
    BOOLEAN Diff_crlf;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_primary_key := le.primary_key <> ri.primary_key;
    SELF.Diff_chainid := le.chainid <> ri.chainid;
    SELF.Diff_filler1 := le.filler1 <> ri.filler1;
    SELF.Diff_pub_date := le.pub_date <> ri.pub_date;
    SELF.Diff_busshortname := le.busshortname <> ri.busshortname;
    SELF.Diff_business_name := le.business_name <> ri.business_name;
    SELF.Diff_busdeptname := le.busdeptname <> ri.busdeptname;
    SELF.Diff_house := le.house <> ri.house;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_street := le.street <> ri.street;
    SELF.Diff_streettype := le.streettype <> ri.streettype;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_apttype := le.apttype <> ri.apttype;
    SELF.Diff_aptnbr := le.aptnbr <> ri.aptnbr;
    SELF.Diff_boxnbr := le.boxnbr <> ri.boxnbr;
    SELF.Diff_exppubcity := le.exppubcity <> ri.exppubcity;
    SELF.Diff_orig_city := le.orig_city <> ri.orig_city;
    SELF.Diff_orig_state := le.orig_state <> ri.orig_state;
    SELF.Diff_orig_zip := le.orig_zip <> ri.orig_zip;
    SELF.Diff_dpc := le.dpc <> ri.dpc;
    SELF.Diff_carrierroute := le.carrierroute <> ri.carrierroute;
    SELF.Diff_fips := le.fips <> ri.fips;
    SELF.Diff_countycode := le.countycode <> ri.countycode;
    SELF.Diff_z4type := le.z4type <> ri.z4type;
    SELF.Diff_ctract := le.ctract <> ri.ctract;
    SELF.Diff_cblockgroup := le.cblockgroup <> ri.cblockgroup;
    SELF.Diff_cblockid := le.cblockid <> ri.cblockid;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_cbsa := le.cbsa <> ri.cbsa;
    SELF.Diff_mcdcode := le.mcdcode <> ri.mcdcode;
    SELF.Diff_filler2 := le.filler2 <> ri.filler2;
    SELF.Diff_addrsensitivity := le.addrsensitivity <> ri.addrsensitivity;
    SELF.Diff_maildeliverabilitycode := le.maildeliverabilitycode <> ri.maildeliverabilitycode;
    SELF.Diff_sic1_4 := le.sic1_4 <> ri.sic1_4;
    SELF.Diff_sic_code := le.sic_code <> ri.sic_code;
    SELF.Diff_sic2 := le.sic2 <> ri.sic2;
    SELF.Diff_sic3 := le.sic3 <> ri.sic3;
    SELF.Diff_sic4 := le.sic4 <> ri.sic4;
    SELF.Diff_indstryclass := le.indstryclass <> ri.indstryclass;
    SELF.Diff_naics_code := le.naics_code <> ri.naics_code;
    SELF.Diff_mlsc := le.mlsc <> ri.mlsc;
    SELF.Diff_filler3 := le.filler3 <> ri.filler3;
    SELF.Diff_orig_phone10 := le.orig_phone10 <> ri.orig_phone10;
    SELF.Diff_nosolicitcode := le.nosolicitcode <> ri.nosolicitcode;
    SELF.Diff_dso := le.dso <> ri.dso;
    SELF.Diff_timezone := le.timezone <> ri.timezone;
    SELF.Diff_validationflag := le.validationflag <> ri.validationflag;
    SELF.Diff_validationdate := le.validationdate <> ri.validationdate;
    SELF.Diff_secvalidationcode := le.secvalidationcode <> ri.secvalidationcode;
    SELF.Diff_singleaddrflag := le.singleaddrflag <> ri.singleaddrflag;
    SELF.Diff_filler4 := le.filler4 <> ri.filler4;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_execname := le.execname <> ri.execname;
    SELF.Diff_exectitlecode := le.exectitlecode <> ri.exectitlecode;
    SELF.Diff_exectitle := le.exectitle <> ri.exectitle;
    SELF.Diff_condtitlecode := le.condtitlecode <> ri.condtitlecode;
    SELF.Diff_condtitle := le.condtitle <> ri.condtitle;
    SELF.Diff_contfunctioncode := le.contfunctioncode <> ri.contfunctioncode;
    SELF.Diff_contfunction := le.contfunction <> ri.contfunction;
    SELF.Diff_profession := le.profession <> ri.profession;
    SELF.Diff_emplsizecode := le.emplsizecode <> ri.emplsizecode;
    SELF.Diff_annualsalescode := le.annualsalescode <> ri.annualsalescode;
    SELF.Diff_yrsinbus := le.yrsinbus <> ri.yrsinbus;
    SELF.Diff_ethniccode := le.ethniccode <> ri.ethniccode;
    SELF.Diff_filler5 := le.filler5 <> ri.filler5;
    SELF.Diff_latlongmatchlevel := le.latlongmatchlevel <> ri.latlongmatchlevel;
    SELF.Diff_orig_latitude := le.orig_latitude <> ri.orig_latitude;
    SELF.Diff_orig_longitude := le.orig_longitude <> ri.orig_longitude;
    SELF.Diff_filler6 := le.filler6 <> ri.filler6;
    SELF.Diff_heading_string := le.heading_string <> ri.heading_string;
    SELF.Diff_ypheading2 := le.ypheading2 <> ri.ypheading2;
    SELF.Diff_ypheading3 := le.ypheading3 <> ri.ypheading3;
    SELF.Diff_ypheading4 := le.ypheading4 <> ri.ypheading4;
    SELF.Diff_ypheading5 := le.ypheading5 <> ri.ypheading5;
    SELF.Diff_ypheading6 := le.ypheading6 <> ri.ypheading6;
    SELF.Diff_maxypadsize := le.maxypadsize <> ri.maxypadsize;
    SELF.Diff_filler7 := le.filler7 <> ri.filler7;
    SELF.Diff_faxac := le.faxac <> ri.faxac;
    SELF.Diff_faxexchge := le.faxexchge <> ri.faxexchge;
    SELF.Diff_faxphone := le.faxphone <> ri.faxphone;
    SELF.Diff_altac := le.altac <> ri.altac;
    SELF.Diff_altexchge := le.altexchge <> ri.altexchge;
    SELF.Diff_altphone := le.altphone <> ri.altphone;
    SELF.Diff_mobileac := le.mobileac <> ri.mobileac;
    SELF.Diff_mobileexchge := le.mobileexchge <> ri.mobileexchge;
    SELF.Diff_mobilephone := le.mobilephone <> ri.mobilephone;
    SELF.Diff_tollfreeac := le.tollfreeac <> ri.tollfreeac;
    SELF.Diff_tollfreeexchge := le.tollfreeexchge <> ri.tollfreeexchge;
    SELF.Diff_tollfreephone := le.tollfreephone <> ri.tollfreephone;
    SELF.Diff_creditcards := le.creditcards <> ri.creditcards;
    SELF.Diff_brands := le.brands <> ri.brands;
    SELF.Diff_stdhrs := le.stdhrs <> ri.stdhrs;
    SELF.Diff_hrsopen := le.hrsopen <> ri.hrsopen;
    SELF.Diff_web_address := le.web_address <> ri.web_address;
    SELF.Diff_filler8 := le.filler8 <> ri.filler8;
    SELF.Diff_email_address := le.email_address <> ri.email_address;
    SELF.Diff_services := le.services <> ri.services;
    SELF.Diff_condheading := le.condheading <> ri.condheading;
    SELF.Diff_tagline := le.tagline <> ri.tagline;
    SELF.Diff_filler9 := le.filler9 <> ri.filler9;
    SELF.Diff_totaladspend := le.totaladspend <> ri.totaladspend;
    SELF.Diff_filler10 := le.filler10 <> ri.filler10;
    SELF.Diff_crlf := le.crlf <> ri.crlf;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_primary_key,1,0)+ IF( SELF.Diff_chainid,1,0)+ IF( SELF.Diff_filler1,1,0)+ IF( SELF.Diff_pub_date,1,0)+ IF( SELF.Diff_busshortname,1,0)+ IF( SELF.Diff_business_name,1,0)+ IF( SELF.Diff_busdeptname,1,0)+ IF( SELF.Diff_house,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_street,1,0)+ IF( SELF.Diff_streettype,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_apttype,1,0)+ IF( SELF.Diff_aptnbr,1,0)+ IF( SELF.Diff_boxnbr,1,0)+ IF( SELF.Diff_exppubcity,1,0)+ IF( SELF.Diff_orig_city,1,0)+ IF( SELF.Diff_orig_state,1,0)+ IF( SELF.Diff_orig_zip,1,0)+ IF( SELF.Diff_dpc,1,0)+ IF( SELF.Diff_carrierroute,1,0)+ IF( SELF.Diff_fips,1,0)+ IF( SELF.Diff_countycode,1,0)+ IF( SELF.Diff_z4type,1,0)+ IF( SELF.Diff_ctract,1,0)+ IF( SELF.Diff_cblockgroup,1,0)+ IF( SELF.Diff_cblockid,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_cbsa,1,0)+ IF( SELF.Diff_mcdcode,1,0)+ IF( SELF.Diff_filler2,1,0)+ IF( SELF.Diff_addrsensitivity,1,0)+ IF( SELF.Diff_maildeliverabilitycode,1,0)+ IF( SELF.Diff_sic1_4,1,0)+ IF( SELF.Diff_sic_code,1,0)+ IF( SELF.Diff_sic2,1,0)+ IF( SELF.Diff_sic3,1,0)+ IF( SELF.Diff_sic4,1,0)+ IF( SELF.Diff_indstryclass,1,0)+ IF( SELF.Diff_naics_code,1,0)+ IF( SELF.Diff_mlsc,1,0)+ IF( SELF.Diff_filler3,1,0)+ IF( SELF.Diff_orig_phone10,1,0)+ IF( SELF.Diff_nosolicitcode,1,0)+ IF( SELF.Diff_dso,1,0)+ IF( SELF.Diff_timezone,1,0)+ IF( SELF.Diff_validationflag,1,0)+ IF( SELF.Diff_validationdate,1,0)+ IF( SELF.Diff_secvalidationcode,1,0)+ IF( SELF.Diff_singleaddrflag,1,0)+ IF( SELF.Diff_filler4,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_execname,1,0)+ IF( SELF.Diff_exectitlecode,1,0)+ IF( SELF.Diff_exectitle,1,0)+ IF( SELF.Diff_condtitlecode,1,0)+ IF( SELF.Diff_condtitle,1,0)+ IF( SELF.Diff_contfunctioncode,1,0)+ IF( SELF.Diff_contfunction,1,0)+ IF( SELF.Diff_profession,1,0)+ IF( SELF.Diff_emplsizecode,1,0)+ IF( SELF.Diff_annualsalescode,1,0)+ IF( SELF.Diff_yrsinbus,1,0)+ IF( SELF.Diff_ethniccode,1,0)+ IF( SELF.Diff_filler5,1,0)+ IF( SELF.Diff_latlongmatchlevel,1,0)+ IF( SELF.Diff_orig_latitude,1,0)+ IF( SELF.Diff_orig_longitude,1,0)+ IF( SELF.Diff_filler6,1,0)+ IF( SELF.Diff_heading_string,1,0)+ IF( SELF.Diff_ypheading2,1,0)+ IF( SELF.Diff_ypheading3,1,0)+ IF( SELF.Diff_ypheading4,1,0)+ IF( SELF.Diff_ypheading5,1,0)+ IF( SELF.Diff_ypheading6,1,0)+ IF( SELF.Diff_maxypadsize,1,0)+ IF( SELF.Diff_filler7,1,0)+ IF( SELF.Diff_faxac,1,0)+ IF( SELF.Diff_faxexchge,1,0)+ IF( SELF.Diff_faxphone,1,0)+ IF( SELF.Diff_altac,1,0)+ IF( SELF.Diff_altexchge,1,0)+ IF( SELF.Diff_altphone,1,0)+ IF( SELF.Diff_mobileac,1,0)+ IF( SELF.Diff_mobileexchge,1,0)+ IF( SELF.Diff_mobilephone,1,0)+ IF( SELF.Diff_tollfreeac,1,0)+ IF( SELF.Diff_tollfreeexchge,1,0)+ IF( SELF.Diff_tollfreephone,1,0)+ IF( SELF.Diff_creditcards,1,0)+ IF( SELF.Diff_brands,1,0)+ IF( SELF.Diff_stdhrs,1,0)+ IF( SELF.Diff_hrsopen,1,0)+ IF( SELF.Diff_web_address,1,0)+ IF( SELF.Diff_filler8,1,0)+ IF( SELF.Diff_email_address,1,0)+ IF( SELF.Diff_services,1,0)+ IF( SELF.Diff_condheading,1,0)+ IF( SELF.Diff_tagline,1,0)+ IF( SELF.Diff_filler9,1,0)+ IF( SELF.Diff_totaladspend,1,0)+ IF( SELF.Diff_filler10,1,0)+ IF( SELF.Diff_crlf,1,0);
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
    Count_Diff_primary_key := COUNT(GROUP,%Closest%.Diff_primary_key);
    Count_Diff_chainid := COUNT(GROUP,%Closest%.Diff_chainid);
    Count_Diff_filler1 := COUNT(GROUP,%Closest%.Diff_filler1);
    Count_Diff_pub_date := COUNT(GROUP,%Closest%.Diff_pub_date);
    Count_Diff_busshortname := COUNT(GROUP,%Closest%.Diff_busshortname);
    Count_Diff_business_name := COUNT(GROUP,%Closest%.Diff_business_name);
    Count_Diff_busdeptname := COUNT(GROUP,%Closest%.Diff_busdeptname);
    Count_Diff_house := COUNT(GROUP,%Closest%.Diff_house);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_street := COUNT(GROUP,%Closest%.Diff_street);
    Count_Diff_streettype := COUNT(GROUP,%Closest%.Diff_streettype);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_apttype := COUNT(GROUP,%Closest%.Diff_apttype);
    Count_Diff_aptnbr := COUNT(GROUP,%Closest%.Diff_aptnbr);
    Count_Diff_boxnbr := COUNT(GROUP,%Closest%.Diff_boxnbr);
    Count_Diff_exppubcity := COUNT(GROUP,%Closest%.Diff_exppubcity);
    Count_Diff_orig_city := COUNT(GROUP,%Closest%.Diff_orig_city);
    Count_Diff_orig_state := COUNT(GROUP,%Closest%.Diff_orig_state);
    Count_Diff_orig_zip := COUNT(GROUP,%Closest%.Diff_orig_zip);
    Count_Diff_dpc := COUNT(GROUP,%Closest%.Diff_dpc);
    Count_Diff_carrierroute := COUNT(GROUP,%Closest%.Diff_carrierroute);
    Count_Diff_fips := COUNT(GROUP,%Closest%.Diff_fips);
    Count_Diff_countycode := COUNT(GROUP,%Closest%.Diff_countycode);
    Count_Diff_z4type := COUNT(GROUP,%Closest%.Diff_z4type);
    Count_Diff_ctract := COUNT(GROUP,%Closest%.Diff_ctract);
    Count_Diff_cblockgroup := COUNT(GROUP,%Closest%.Diff_cblockgroup);
    Count_Diff_cblockid := COUNT(GROUP,%Closest%.Diff_cblockid);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_cbsa := COUNT(GROUP,%Closest%.Diff_cbsa);
    Count_Diff_mcdcode := COUNT(GROUP,%Closest%.Diff_mcdcode);
    Count_Diff_filler2 := COUNT(GROUP,%Closest%.Diff_filler2);
    Count_Diff_addrsensitivity := COUNT(GROUP,%Closest%.Diff_addrsensitivity);
    Count_Diff_maildeliverabilitycode := COUNT(GROUP,%Closest%.Diff_maildeliverabilitycode);
    Count_Diff_sic1_4 := COUNT(GROUP,%Closest%.Diff_sic1_4);
    Count_Diff_sic_code := COUNT(GROUP,%Closest%.Diff_sic_code);
    Count_Diff_sic2 := COUNT(GROUP,%Closest%.Diff_sic2);
    Count_Diff_sic3 := COUNT(GROUP,%Closest%.Diff_sic3);
    Count_Diff_sic4 := COUNT(GROUP,%Closest%.Diff_sic4);
    Count_Diff_indstryclass := COUNT(GROUP,%Closest%.Diff_indstryclass);
    Count_Diff_naics_code := COUNT(GROUP,%Closest%.Diff_naics_code);
    Count_Diff_mlsc := COUNT(GROUP,%Closest%.Diff_mlsc);
    Count_Diff_filler3 := COUNT(GROUP,%Closest%.Diff_filler3);
    Count_Diff_orig_phone10 := COUNT(GROUP,%Closest%.Diff_orig_phone10);
    Count_Diff_nosolicitcode := COUNT(GROUP,%Closest%.Diff_nosolicitcode);
    Count_Diff_dso := COUNT(GROUP,%Closest%.Diff_dso);
    Count_Diff_timezone := COUNT(GROUP,%Closest%.Diff_timezone);
    Count_Diff_validationflag := COUNT(GROUP,%Closest%.Diff_validationflag);
    Count_Diff_validationdate := COUNT(GROUP,%Closest%.Diff_validationdate);
    Count_Diff_secvalidationcode := COUNT(GROUP,%Closest%.Diff_secvalidationcode);
    Count_Diff_singleaddrflag := COUNT(GROUP,%Closest%.Diff_singleaddrflag);
    Count_Diff_filler4 := COUNT(GROUP,%Closest%.Diff_filler4);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_execname := COUNT(GROUP,%Closest%.Diff_execname);
    Count_Diff_exectitlecode := COUNT(GROUP,%Closest%.Diff_exectitlecode);
    Count_Diff_exectitle := COUNT(GROUP,%Closest%.Diff_exectitle);
    Count_Diff_condtitlecode := COUNT(GROUP,%Closest%.Diff_condtitlecode);
    Count_Diff_condtitle := COUNT(GROUP,%Closest%.Diff_condtitle);
    Count_Diff_contfunctioncode := COUNT(GROUP,%Closest%.Diff_contfunctioncode);
    Count_Diff_contfunction := COUNT(GROUP,%Closest%.Diff_contfunction);
    Count_Diff_profession := COUNT(GROUP,%Closest%.Diff_profession);
    Count_Diff_emplsizecode := COUNT(GROUP,%Closest%.Diff_emplsizecode);
    Count_Diff_annualsalescode := COUNT(GROUP,%Closest%.Diff_annualsalescode);
    Count_Diff_yrsinbus := COUNT(GROUP,%Closest%.Diff_yrsinbus);
    Count_Diff_ethniccode := COUNT(GROUP,%Closest%.Diff_ethniccode);
    Count_Diff_filler5 := COUNT(GROUP,%Closest%.Diff_filler5);
    Count_Diff_latlongmatchlevel := COUNT(GROUP,%Closest%.Diff_latlongmatchlevel);
    Count_Diff_orig_latitude := COUNT(GROUP,%Closest%.Diff_orig_latitude);
    Count_Diff_orig_longitude := COUNT(GROUP,%Closest%.Diff_orig_longitude);
    Count_Diff_filler6 := COUNT(GROUP,%Closest%.Diff_filler6);
    Count_Diff_heading_string := COUNT(GROUP,%Closest%.Diff_heading_string);
    Count_Diff_ypheading2 := COUNT(GROUP,%Closest%.Diff_ypheading2);
    Count_Diff_ypheading3 := COUNT(GROUP,%Closest%.Diff_ypheading3);
    Count_Diff_ypheading4 := COUNT(GROUP,%Closest%.Diff_ypheading4);
    Count_Diff_ypheading5 := COUNT(GROUP,%Closest%.Diff_ypheading5);
    Count_Diff_ypheading6 := COUNT(GROUP,%Closest%.Diff_ypheading6);
    Count_Diff_maxypadsize := COUNT(GROUP,%Closest%.Diff_maxypadsize);
    Count_Diff_filler7 := COUNT(GROUP,%Closest%.Diff_filler7);
    Count_Diff_faxac := COUNT(GROUP,%Closest%.Diff_faxac);
    Count_Diff_faxexchge := COUNT(GROUP,%Closest%.Diff_faxexchge);
    Count_Diff_faxphone := COUNT(GROUP,%Closest%.Diff_faxphone);
    Count_Diff_altac := COUNT(GROUP,%Closest%.Diff_altac);
    Count_Diff_altexchge := COUNT(GROUP,%Closest%.Diff_altexchge);
    Count_Diff_altphone := COUNT(GROUP,%Closest%.Diff_altphone);
    Count_Diff_mobileac := COUNT(GROUP,%Closest%.Diff_mobileac);
    Count_Diff_mobileexchge := COUNT(GROUP,%Closest%.Diff_mobileexchge);
    Count_Diff_mobilephone := COUNT(GROUP,%Closest%.Diff_mobilephone);
    Count_Diff_tollfreeac := COUNT(GROUP,%Closest%.Diff_tollfreeac);
    Count_Diff_tollfreeexchge := COUNT(GROUP,%Closest%.Diff_tollfreeexchge);
    Count_Diff_tollfreephone := COUNT(GROUP,%Closest%.Diff_tollfreephone);
    Count_Diff_creditcards := COUNT(GROUP,%Closest%.Diff_creditcards);
    Count_Diff_brands := COUNT(GROUP,%Closest%.Diff_brands);
    Count_Diff_stdhrs := COUNT(GROUP,%Closest%.Diff_stdhrs);
    Count_Diff_hrsopen := COUNT(GROUP,%Closest%.Diff_hrsopen);
    Count_Diff_web_address := COUNT(GROUP,%Closest%.Diff_web_address);
    Count_Diff_filler8 := COUNT(GROUP,%Closest%.Diff_filler8);
    Count_Diff_email_address := COUNT(GROUP,%Closest%.Diff_email_address);
    Count_Diff_services := COUNT(GROUP,%Closest%.Diff_services);
    Count_Diff_condheading := COUNT(GROUP,%Closest%.Diff_condheading);
    Count_Diff_tagline := COUNT(GROUP,%Closest%.Diff_tagline);
    Count_Diff_filler9 := COUNT(GROUP,%Closest%.Diff_filler9);
    Count_Diff_totaladspend := COUNT(GROUP,%Closest%.Diff_totaladspend);
    Count_Diff_filler10 := COUNT(GROUP,%Closest%.Diff_filler10);
    Count_Diff_crlf := COUNT(GROUP,%Closest%.Diff_crlf);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
