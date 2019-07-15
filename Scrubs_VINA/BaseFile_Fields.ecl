IMPORT SALT311;
EXPORT BaseFile_Fields := MODULE

EXPORT NumFields := 162;

// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_engine_information_cylinders','Invalid_Nums','Invalid_Num_Axles','Invalid_Tire_Size','Invalid_Decimal','Invalid_Nums_Blank','Invalid_Nums_Rotary','Invalid_Vehicle_Type','Invalid_Abbreviation','Invalid_Vin','Invalid_Body_Type','Invalid_Char','Invalid_Char_No_Spec','Invalid_Fuel','Invalid_HPC','Invalid_Wheel','Invalid_Ton','Invalid_Location','Invalid_Option_SOUNA','Invalid_Option_SOUN','Invalid_Radio','Invalid_Roof','Invalid_ALB','Invalid_Transmission','Invalid_Security','Invalid_Visrap','Invalid_Cab','Invalid_FAC','Invalid_RAC','Invalid_Brakes','Invalid_Engine_Type','Invalid_Trailer_Body','Invalid_Trailer_length','Invalid_Proactive_VIN_Ind','Invalid_VIN_Pattern','Invalid_Segmentation_Codes','Invalid_Country','Invalid_Liter','Invalid_Block_Type','Invalid_Carburetion','Invalid_Carburetion_Num','Invalid_Head_Configuration','Invalid_Valves','Invalid_Aspiration_Code','Invalid_Carburetion_Code','Invalid_VPC','Invalid_Transmission_Speed','Invalid_Transmission_Type','Invalid_Transmission_Code','Invalid_Transmission_Speed_Code','Invalid_Y_or_N','Invalid_Y_or_N_orBlank','Invalid_Battery_Type','Invalid_Battery_KW','Invalid_Battery_Volts','Invalid_Engine_Brand','Invalid_Supercharged','Invalid_Turbocharged');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_engine_information_cylinders' => 1,'Invalid_Nums' => 2,'Invalid_Num_Axles' => 3,'Invalid_Tire_Size' => 4,'Invalid_Decimal' => 5,'Invalid_Nums_Blank' => 6,'Invalid_Nums_Rotary' => 7,'Invalid_Vehicle_Type' => 8,'Invalid_Abbreviation' => 9,'Invalid_Vin' => 10,'Invalid_Body_Type' => 11,'Invalid_Char' => 12,'Invalid_Char_No_Spec' => 13,'Invalid_Fuel' => 14,'Invalid_HPC' => 15,'Invalid_Wheel' => 16,'Invalid_Ton' => 17,'Invalid_Location' => 18,'Invalid_Option_SOUNA' => 19,'Invalid_Option_SOUN' => 20,'Invalid_Radio' => 21,'Invalid_Roof' => 22,'Invalid_ALB' => 23,'Invalid_Transmission' => 24,'Invalid_Security' => 25,'Invalid_Visrap' => 26,'Invalid_Cab' => 27,'Invalid_FAC' => 28,'Invalid_RAC' => 29,'Invalid_Brakes' => 30,'Invalid_Engine_Type' => 31,'Invalid_Trailer_Body' => 32,'Invalid_Trailer_length' => 33,'Invalid_Proactive_VIN_Ind' => 34,'Invalid_VIN_Pattern' => 35,'Invalid_Segmentation_Codes' => 36,'Invalid_Country' => 37,'Invalid_Liter' => 38,'Invalid_Block_Type' => 39,'Invalid_Carburetion' => 40,'Invalid_Carburetion_Num' => 41,'Invalid_Head_Configuration' => 42,'Invalid_Valves' => 43,'Invalid_Aspiration_Code' => 44,'Invalid_Carburetion_Code' => 45,'Invalid_VPC' => 46,'Invalid_Transmission_Speed' => 47,'Invalid_Transmission_Type' => 48,'Invalid_Transmission_Code' => 49,'Invalid_Transmission_Speed_Code' => 50,'Invalid_Y_or_N' => 51,'Invalid_Y_or_N_orBlank' => 52,'Invalid_Battery_Type' => 53,'Invalid_Battery_KW' => 54,'Invalid_Battery_Volts' => 55,'Invalid_Engine_Brand' => 56,'Invalid_Supercharged' => 57,'Invalid_Turbocharged' => 58,0);

EXPORT MakeFT_Invalid_engine_information_cylinders(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789U'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_engine_information_cylinders(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789U'))));
EXPORT InValidMessageFT_Invalid_engine_information_cylinders(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789U'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Nums(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Nums(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Nums(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Num_Axles(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'FTUYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Num_Axles(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'FTUYZ0123456789'))));
EXPORT InValidMessageFT_Invalid_Num_Axles(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('FTUYZ0123456789'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Tire_Size(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789.-ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Tire_Size(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789.-ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_Invalid_Tire_Size(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789.-ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Decimal(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789.'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Decimal(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789.'))));
EXPORT InValidMessageFT_Invalid_Decimal(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789.'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Nums_Blank(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Nums_Blank(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_Invalid_Nums_Blank(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Nums_Rotary(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'R0123456789 U'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Nums_Rotary(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'R0123456789 U'))));
EXPORT InValidMessageFT_Invalid_Nums_Rotary(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('R0123456789 U'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Vehicle_Type(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'PTMC'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Vehicle_Type(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'PTMC'))));
EXPORT InValidMessageFT_Invalid_Vehicle_Type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('PTMC'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Abbreviation(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Abbreviation(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))));
EXPORT InValidMessageFT_Invalid_Abbreviation(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Vin(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789*'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Vin(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789*'))));
EXPORT InValidMessageFT_Invalid_Vin(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789*'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Body_Type(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Body_Type(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'))));
EXPORT InValidMessageFT_Invalid_Body_Type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Char(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .-:*&"\'`()/+!,'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Char(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .-:*&"\'`()/+!,'))));
EXPORT InValidMessageFT_Invalid_Char(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .-:*&"\'`()/+!,'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Char_No_Spec(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .-:*&"\'`()/+!,'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Char_No_Spec(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .-:*&"\'`()/+!,'))));
EXPORT InValidMessageFT_Invalid_Char_No_Spec(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .-:*&"\'`()/+!,'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Fuel(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'BCEFGHMNPDU'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Fuel(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'BCEFGHMNPDU'))));
EXPORT InValidMessageFT_Invalid_Fuel(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('BCEFGHMNPDU'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_HPC(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ACDHJLMN03 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_HPC(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ACDHJLMN03 '))));
EXPORT InValidMessageFT_Invalid_HPC(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ACDHJLMN03 '),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Wheel(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'F4A '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Wheel(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'F4A '))));
EXPORT InValidMessageFT_Invalid_Wheel(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('F4A '),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Ton(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDJKLMNOPQRFGHI'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Ton(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDJKLMNOPQRFGHI'))));
EXPORT InValidMessageFT_Invalid_Ton(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDJKLMNOPQRFGHI'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Location(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'CPM '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Location(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'CPM '))));
EXPORT InValidMessageFT_Invalid_Location(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('CPM '),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Option_SOUNA(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'SOUNA '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Option_SOUNA(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'SOUNA '))));
EXPORT InValidMessageFT_Invalid_Option_SOUNA(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('SOUNA '),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Option_SOUN(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'SOUN A'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Option_SOUN(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'SOUN A'))));
EXPORT InValidMessageFT_Invalid_Option_SOUN(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('SOUN A'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Radio(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'123456789A'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Radio(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'123456789A'))));
EXPORT InValidMessageFT_Invalid_Radio(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('123456789A'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Roof(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'1234567'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Roof(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'1234567'))));
EXPORT InValidMessageFT_Invalid_Roof(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('1234567'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_ALB(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'12345678U'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_ALB(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'12345678U'))));
EXPORT InValidMessageFT_Invalid_ALB(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('12345678U'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Transmission(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRST'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Transmission(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRST'))));
EXPORT InValidMessageFT_Invalid_Transmission(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRST'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Security(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ESKABCDFGHJONUZPITUN'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Security(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ESKABCDFGHJONUZPITUN'))));
EXPORT InValidMessageFT_Invalid_Security(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ESKABCDFGHJONUZPITUN'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Visrap(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMPRSTUVWXY347'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Visrap(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMPRSTUVWXY347'))));
EXPORT InValidMessageFT_Invalid_Visrap(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMPRSTUVWXY347'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Cab(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOU'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Cab(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOU'))));
EXPORT InValidMessageFT_Invalid_Cab(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOU'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_FAC(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCU'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_FAC(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCU'))));
EXPORT InValidMessageFT_Invalid_FAC(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCU'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_RAC(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'STU'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_RAC(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'STU'))));
EXPORT InValidMessageFT_Invalid_RAC(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('STU'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Brakes(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFU'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Brakes(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFU'))));
EXPORT InValidMessageFT_Invalid_Brakes(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFU'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Engine_Type(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'HLMU'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Engine_Type(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'HLMU'))));
EXPORT InValidMessageFT_Invalid_Engine_Type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('HLMU'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Trailer_Body(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Trailer_Body(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['407','412','AUT','BEV','CCH','CHP','CUR','DMP','DOL','ENB','ENT','ENU','FBD','FDD','GRN','HPR','LBD','LDD','LGO','LIV','LOG','ROL','SPE','TAG','TNK','TPN','TRN','T06','T07','T12','T13','T19','T20','T21','T22','T23','T24','T25','T26','T27','T28','T29','T31','T53','T54','T55','T56','T57','T58','T69','T75','UNK','UOC','UTL','VAN','VDR','VOT','VRF',' ','U','N']);
EXPORT InValidMessageFT_Invalid_Trailer_Body(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('407|412|AUT|BEV|CCH|CHP|CUR|DMP|DOL|ENB|ENT|ENU|FBD|FDD|GRN|HPR|LBD|LDD|LGO|LIV|LOG|ROL|SPE|TAG|TNK|TPN|TRN|T06|T07|T12|T13|T19|T20|T21|T22|T23|T24|T25|T26|T27|T28|T29|T31|T53|T54|T55|T56|T57|T58|T69|T75|UNK|UOC|UTL|VAN|VDR|VOT|VRF| |U|N'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Trailer_length(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789XUNKLG'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Trailer_length(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789XUNKLG'))));
EXPORT InValidMessageFT_Invalid_Trailer_length(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789XUNKLG'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Proactive_VIN_Ind(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'YNU'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Proactive_VIN_Ind(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'YNU'))));
EXPORT InValidMessageFT_Invalid_Proactive_VIN_Ind(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('YNU'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_VIN_Pattern(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEGHIKMNOPRSTVWXYZU'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_VIN_Pattern(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEGHIKMNOPRSTVWXYZU'))));
EXPORT InValidMessageFT_Invalid_VIN_Pattern(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEGHIKMNOPRSTVWXYZU'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Segmentation_Codes(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'AB0DEFGHIJKLMNOPQRSTUVWCYZ123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Segmentation_Codes(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'AB0DEFGHIJKLMNOPQRSTUVWCYZ123456789'))));
EXPORT InValidMessageFT_Invalid_Segmentation_Codes(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('AB0DEFGHIJKLMNOPQRSTUVWCYZ123456789'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Country(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Country(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_Invalid_Country(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Liter(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789L.'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Liter(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789L.'))));
EXPORT InValidMessageFT_Invalid_Liter(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789L.'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Block_Type(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'VILHWRU'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Block_Type(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'VILHWRU'))));
EXPORT InValidMessageFT_Invalid_Block_Type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('VILHWRU'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Carburetion(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Carburetion(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['1BL','2BL','3BL','4BL','CPI','DIR','FI','HSC','IDI','MPI','PFI','SFI','TBI','TPI',' ']);
EXPORT InValidMessageFT_Invalid_Carburetion(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('1BL|2BL|3BL|4BL|CPI|DIR|FI|HSC|IDI|MPI|PFI|SFI|TBI|TPI| '),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Carburetion_Num(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789CFLTUVYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Carburetion_Num(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789CFLTUVYZ'))));
EXPORT InValidMessageFT_Invalid_Carburetion_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789CFLTUVYZ'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Head_Configuration(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Head_Configuration(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['SOHC','DOHC','OHV',' ','U']);
EXPORT InValidMessageFT_Invalid_Head_Configuration(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('SOHC|DOHC|OHV| |U'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Valves(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789V'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Valves(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789V'))));
EXPORT InValidMessageFT_Invalid_Valves(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789V'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Aspiration_Code(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'EHNUYI'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Aspiration_Code(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'EHNUYI'))));
EXPORT InValidMessageFT_Invalid_Aspiration_Code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('EHNUYI'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Carburetion_Code(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'01234BCDFHIMPSTUX'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Carburetion_Code(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'01234BCDFHIMPSTUX'))));
EXPORT InValidMessageFT_Invalid_Carburetion_Code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('01234BCDFHIMPSTUX'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_VPC(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'12345 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_VPC(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'12345 '))));
EXPORT InValidMessageFT_Invalid_VPC(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('12345 '),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Transmission_Speed(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789SPDCVT '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Transmission_Speed(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789SPDCVT '))));
EXPORT InValidMessageFT_Invalid_Transmission_Speed(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789SPDCVT '),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Transmission_Type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Transmission_Type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['MANUAL','AUTO',' ']);
EXPORT InValidMessageFT_Invalid_Transmission_Type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('MANUAL|AUTO| '),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Transmission_Code(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'AM '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Transmission_Code(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'AM '))));
EXPORT InValidMessageFT_Invalid_Transmission_Code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('AM '),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Transmission_Speed_Code(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Transmission_Speed_Code(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_Transmission_Speed_Code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Y_or_N(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'YN'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Y_or_N(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'YN'))));
EXPORT InValidMessageFT_Invalid_Y_or_N(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('YN'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Y_or_N_orBlank(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'YN '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Y_or_N_orBlank(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'YN '))));
EXPORT InValidMessageFT_Invalid_Y_or_N_orBlank(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('YN '),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Battery_Type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Battery_Type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['NIMH','PBA','HYB','LIPO','LTHI',' ']);
EXPORT InValidMessageFT_Invalid_Battery_Type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('NIMH|PBA|HYB|LIPO|LTHI| '),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Battery_KW(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789KW'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Battery_KW(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789KW'))));
EXPORT InValidMessageFT_Invalid_Battery_KW(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789KW'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Battery_Volts(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789V'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Battery_Volts(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789V'))));
EXPORT InValidMessageFT_Invalid_Battery_Volts(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789V'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Engine_Brand(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'HV '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Engine_Brand(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'HV '))));
EXPORT InValidMessageFT_Invalid_Engine_Brand(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('HV '),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Supercharged(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'YNIU '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Supercharged(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'YNIU '))));
EXPORT InValidMessageFT_Invalid_Supercharged(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('YNIU '),SALT311.HygieneErrors.Good);

EXPORT MakeFT_Invalid_Turbocharged(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'YNIU '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Turbocharged(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'YNIU '))));
EXPORT InValidMessageFT_Invalid_Turbocharged(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('YNIU '),SALT311.HygieneErrors.Good);


EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'match_make','match_year','match_vin','make_abbreviation','model_year','vehicle_type','make_name','series_name','body_type','wheels','displacement','cylinders','fuel','carburetion','gvw','wheel_base','tire_size','ton_rating','base_shipping_weight','variance_weight','base_list_price','price_variance','high_performance_code','driving_wheels','iso_physical_damage','location_indicator','air_conditioning','power_steering','power_brakes','power_windows','tilt_wheel','roof','optional_roof1','optional_roof2','radio','optional_radio1','optional_radio2','transmission','optional_transmission1','optional_transmission2','anti_lock_brakes','security_system','daytime_running_lights','visrap','cab_configuration','front_axle_code','rear_axle_code','brakes_code','engine_manufacturer','engine_model','engine_type_code','trailer_body_style','trailer_number_of_axles','trailer_length','proactive_vin','ma_state_exceptions','filler_1','series_abbreviation','vin_pattern','ncic_data','full_body_style_name','nvpp_make_code','nvpp_make_abbreviation','nvpp_series_model','nvpp_series_name','segmentation_code','country_of_origin','engine_liter_information','engine_information_filler1','engine_information_block_type','engine_information_cylinders','engine_information_filler2','engine_information_carburetion','engine_information_filler3','engine_information_head_configuration','engine_information_filler4','engine_information_total_valves','engine_information_filler5','engine_information_aspiration_code','engine_information_carburetion_code','engine_information_valves_per_cylinder','transmission_speed','transmission_filler1','transmission_type','transmission_filler2','transmission_code','transmission_filler3','transmission_speed_code','base_model','complete_prefix_file_id','series_name_full_spelling','vis_theft_code','base_list_price_expanded','default_nada_vehicle_id','default_nada_model','default_nada_body_style','default_nada_msrp','default_nada_gvwr','default_nada_gcwr','alt_1_nada_vehicle_id','alt_1_nada_model','alt_1_nada_body_style','alt_1_nada_msrp','alt_1_nada_gvwr','alt_1_nada_gcwr','alt_2_nada_vehicle_id','alt_2_nada_model','alt_2_nada_body_style','alt_2_nada_msrp','alt_2_nada_gvwr','alt_2_nada_gcwr','alt_3_nada_vehicle_id','alt_3_nada_model','alt_3_nada_body_style','alt_3_nada_msrp','alt_3_nada_gvwr','alt_3_nada_gcwr','alt_4_nada_vehicle_id','alt_4_nada_model','alt_4_nada_body_style','alt_4_nada_msrp','alt_4_nada_gvwr','alt_4_nada_gcwr','alt_5_nada_vehicle_id','alt_5_nada_model','alt_5_nada_body_style','alt_5_nada_msrp','alt_5_nada_gvwr','alt_5_nada_gcwr','alt_6_nada_vehicle_id','alt_6_nada_model','alt_6_nada_body_style','alt_6_nada_msrp','alt_6_nada_gvwr','alt_6_nada_gcwr','alt_7_nada_vehicle_id','alt_7_nada_model','alt_7_nada_body_style','alt_7_nada_msrp','alt_7_nada_gvwr','alt_7_nada_gcwr','aaia_codes','incomplete_vehicle_flag','filler2','electric_battery_info_type','filler3','electric_battery_kilowatts','filler4','electric_battery_volts','filler5','engine_info_proprietary_engine_brand','filler6','engine_info_high_output_engine','engine_info_supercharged','engine_info_turbocharged','engine_info_vvtl','iso_liability','series_name_condensed','aces_data','base_shipping_weight_expanded','filler7','customer_defined_data');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'match_make','match_year','match_vin','make_abbreviation','model_year','vehicle_type','make_name','series_name','body_type','wheels','displacement','cylinders','fuel','carburetion','gvw','wheel_base','tire_size','ton_rating','base_shipping_weight','variance_weight','base_list_price','price_variance','high_performance_code','driving_wheels','iso_physical_damage','location_indicator','air_conditioning','power_steering','power_brakes','power_windows','tilt_wheel','roof','optional_roof1','optional_roof2','radio','optional_radio1','optional_radio2','transmission','optional_transmission1','optional_transmission2','anti_lock_brakes','security_system','daytime_running_lights','visrap','cab_configuration','front_axle_code','rear_axle_code','brakes_code','engine_manufacturer','engine_model','engine_type_code','trailer_body_style','trailer_number_of_axles','trailer_length','proactive_vin','ma_state_exceptions','filler_1','series_abbreviation','vin_pattern','ncic_data','full_body_style_name','nvpp_make_code','nvpp_make_abbreviation','nvpp_series_model','nvpp_series_name','segmentation_code','country_of_origin','engine_liter_information','engine_information_filler1','engine_information_block_type','engine_information_cylinders','engine_information_filler2','engine_information_carburetion','engine_information_filler3','engine_information_head_configuration','engine_information_filler4','engine_information_total_valves','engine_information_filler5','engine_information_aspiration_code','engine_information_carburetion_code','engine_information_valves_per_cylinder','transmission_speed','transmission_filler1','transmission_type','transmission_filler2','transmission_code','transmission_filler3','transmission_speed_code','base_model','complete_prefix_file_id','series_name_full_spelling','vis_theft_code','base_list_price_expanded','default_nada_vehicle_id','default_nada_model','default_nada_body_style','default_nada_msrp','default_nada_gvwr','default_nada_gcwr','alt_1_nada_vehicle_id','alt_1_nada_model','alt_1_nada_body_style','alt_1_nada_msrp','alt_1_nada_gvwr','alt_1_nada_gcwr','alt_2_nada_vehicle_id','alt_2_nada_model','alt_2_nada_body_style','alt_2_nada_msrp','alt_2_nada_gvwr','alt_2_nada_gcwr','alt_3_nada_vehicle_id','alt_3_nada_model','alt_3_nada_body_style','alt_3_nada_msrp','alt_3_nada_gvwr','alt_3_nada_gcwr','alt_4_nada_vehicle_id','alt_4_nada_model','alt_4_nada_body_style','alt_4_nada_msrp','alt_4_nada_gvwr','alt_4_nada_gcwr','alt_5_nada_vehicle_id','alt_5_nada_model','alt_5_nada_body_style','alt_5_nada_msrp','alt_5_nada_gvwr','alt_5_nada_gcwr','alt_6_nada_vehicle_id','alt_6_nada_model','alt_6_nada_body_style','alt_6_nada_msrp','alt_6_nada_gvwr','alt_6_nada_gcwr','alt_7_nada_vehicle_id','alt_7_nada_model','alt_7_nada_body_style','alt_7_nada_msrp','alt_7_nada_gvwr','alt_7_nada_gcwr','aaia_codes','incomplete_vehicle_flag','filler2','electric_battery_info_type','filler3','electric_battery_kilowatts','filler4','electric_battery_volts','filler5','engine_info_proprietary_engine_brand','filler6','engine_info_high_output_engine','engine_info_supercharged','engine_info_turbocharged','engine_info_vvtl','iso_liability','series_name_condensed','aces_data','base_shipping_weight_expanded','filler7','customer_defined_data');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'match_make' => 0,'match_year' => 1,'match_vin' => 2,'make_abbreviation' => 3,'model_year' => 4,'vehicle_type' => 5,'make_name' => 6,'series_name' => 7,'body_type' => 8,'wheels' => 9,'displacement' => 10,'cylinders' => 11,'fuel' => 12,'carburetion' => 13,'gvw' => 14,'wheel_base' => 15,'tire_size' => 16,'ton_rating' => 17,'base_shipping_weight' => 18,'variance_weight' => 19,'base_list_price' => 20,'price_variance' => 21,'high_performance_code' => 22,'driving_wheels' => 23,'iso_physical_damage' => 24,'location_indicator' => 25,'air_conditioning' => 26,'power_steering' => 27,'power_brakes' => 28,'power_windows' => 29,'tilt_wheel' => 30,'roof' => 31,'optional_roof1' => 32,'optional_roof2' => 33,'radio' => 34,'optional_radio1' => 35,'optional_radio2' => 36,'transmission' => 37,'optional_transmission1' => 38,'optional_transmission2' => 39,'anti_lock_brakes' => 40,'security_system' => 41,'daytime_running_lights' => 42,'visrap' => 43,'cab_configuration' => 44,'front_axle_code' => 45,'rear_axle_code' => 46,'brakes_code' => 47,'engine_manufacturer' => 48,'engine_model' => 49,'engine_type_code' => 50,'trailer_body_style' => 51,'trailer_number_of_axles' => 52,'trailer_length' => 53,'proactive_vin' => 54,'ma_state_exceptions' => 55,'filler_1' => 56,'series_abbreviation' => 57,'vin_pattern' => 58,'ncic_data' => 59,'full_body_style_name' => 60,'nvpp_make_code' => 61,'nvpp_make_abbreviation' => 62,'nvpp_series_model' => 63,'nvpp_series_name' => 64,'segmentation_code' => 65,'country_of_origin' => 66,'engine_liter_information' => 67,'engine_information_filler1' => 68,'engine_information_block_type' => 69,'engine_information_cylinders' => 70,'engine_information_filler2' => 71,'engine_information_carburetion' => 72,'engine_information_filler3' => 73,'engine_information_head_configuration' => 74,'engine_information_filler4' => 75,'engine_information_total_valves' => 76,'engine_information_filler5' => 77,'engine_information_aspiration_code' => 78,'engine_information_carburetion_code' => 79,'engine_information_valves_per_cylinder' => 80,'transmission_speed' => 81,'transmission_filler1' => 82,'transmission_type' => 83,'transmission_filler2' => 84,'transmission_code' => 85,'transmission_filler3' => 86,'transmission_speed_code' => 87,'base_model' => 88,'complete_prefix_file_id' => 89,'series_name_full_spelling' => 90,'vis_theft_code' => 91,'base_list_price_expanded' => 92,'default_nada_vehicle_id' => 93,'default_nada_model' => 94,'default_nada_body_style' => 95,'default_nada_msrp' => 96,'default_nada_gvwr' => 97,'default_nada_gcwr' => 98,'alt_1_nada_vehicle_id' => 99,'alt_1_nada_model' => 100,'alt_1_nada_body_style' => 101,'alt_1_nada_msrp' => 102,'alt_1_nada_gvwr' => 103,'alt_1_nada_gcwr' => 104,'alt_2_nada_vehicle_id' => 105,'alt_2_nada_model' => 106,'alt_2_nada_body_style' => 107,'alt_2_nada_msrp' => 108,'alt_2_nada_gvwr' => 109,'alt_2_nada_gcwr' => 110,'alt_3_nada_vehicle_id' => 111,'alt_3_nada_model' => 112,'alt_3_nada_body_style' => 113,'alt_3_nada_msrp' => 114,'alt_3_nada_gvwr' => 115,'alt_3_nada_gcwr' => 116,'alt_4_nada_vehicle_id' => 117,'alt_4_nada_model' => 118,'alt_4_nada_body_style' => 119,'alt_4_nada_msrp' => 120,'alt_4_nada_gvwr' => 121,'alt_4_nada_gcwr' => 122,'alt_5_nada_vehicle_id' => 123,'alt_5_nada_model' => 124,'alt_5_nada_body_style' => 125,'alt_5_nada_msrp' => 126,'alt_5_nada_gvwr' => 127,'alt_5_nada_gcwr' => 128,'alt_6_nada_vehicle_id' => 129,'alt_6_nada_model' => 130,'alt_6_nada_body_style' => 131,'alt_6_nada_msrp' => 132,'alt_6_nada_gvwr' => 133,'alt_6_nada_gcwr' => 134,'alt_7_nada_vehicle_id' => 135,'alt_7_nada_model' => 136,'alt_7_nada_body_style' => 137,'alt_7_nada_msrp' => 138,'alt_7_nada_gvwr' => 139,'alt_7_nada_gcwr' => 140,'aaia_codes' => 141,'incomplete_vehicle_flag' => 142,'filler2' => 143,'electric_battery_info_type' => 144,'filler3' => 145,'electric_battery_kilowatts' => 146,'filler4' => 147,'electric_battery_volts' => 148,'filler5' => 149,'engine_info_proprietary_engine_brand' => 150,'filler6' => 151,'engine_info_high_output_engine' => 152,'engine_info_supercharged' => 153,'engine_info_turbocharged' => 154,'engine_info_vvtl' => 155,'iso_liability' => 156,'series_name_condensed' => 157,'aces_data' => 158,'base_shipping_weight_expanded' => 159,'filler7' => 160,'customer_defined_data' => 161,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ENUM'],['ALLOW'],['ALLOW'],['ALLOW'],[],[],[],['ALLOW'],['ALLOW'],['ALLOW'],[],[],[],[],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],[],['ENUM'],[],['ENUM'],[],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ENUM'],[],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ENUM'],[],['ALLOW'],[],['ALLOW'],[],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);

//Individual field level validation


EXPORT Make_match_make(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_match_make(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_match_make(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_match_year(SALT311.StrType s0) := MakeFT_Invalid_Nums(s0);
EXPORT InValid_match_year(SALT311.StrType s) := InValidFT_Invalid_Nums(s);
EXPORT InValidMessage_match_year(UNSIGNED1 wh) := InValidMessageFT_Invalid_Nums(wh);


EXPORT Make_match_vin(SALT311.StrType s0) := MakeFT_Invalid_Vin(s0);
EXPORT InValid_match_vin(SALT311.StrType s) := InValidFT_Invalid_Vin(s);
EXPORT InValidMessage_match_vin(UNSIGNED1 wh) := InValidMessageFT_Invalid_Vin(wh);


EXPORT Make_make_abbreviation(SALT311.StrType s0) := MakeFT_Invalid_Abbreviation(s0);
EXPORT InValid_make_abbreviation(SALT311.StrType s) := InValidFT_Invalid_Abbreviation(s);
EXPORT InValidMessage_make_abbreviation(UNSIGNED1 wh) := InValidMessageFT_Invalid_Abbreviation(wh);


EXPORT Make_model_year(SALT311.StrType s0) := MakeFT_Invalid_Nums(s0);
EXPORT InValid_model_year(SALT311.StrType s) := InValidFT_Invalid_Nums(s);
EXPORT InValidMessage_model_year(UNSIGNED1 wh) := InValidMessageFT_Invalid_Nums(wh);


EXPORT Make_vehicle_type(SALT311.StrType s0) := MakeFT_Invalid_Vehicle_Type(s0);
EXPORT InValid_vehicle_type(SALT311.StrType s) := InValidFT_Invalid_Vehicle_Type(s);
EXPORT InValidMessage_vehicle_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Vehicle_Type(wh);


EXPORT Make_make_name(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_make_name(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_make_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_series_name(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_series_name(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_series_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_body_type(SALT311.StrType s0) := MakeFT_Invalid_Body_Type(s0);
EXPORT InValid_body_type(SALT311.StrType s) := InValidFT_Invalid_Body_Type(s);
EXPORT InValidMessage_body_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Body_Type(wh);


EXPORT Make_wheels(SALT311.StrType s0) := MakeFT_Invalid_Nums(s0);
EXPORT InValid_wheels(SALT311.StrType s) := InValidFT_Invalid_Nums(s);
EXPORT InValidMessage_wheels(UNSIGNED1 wh) := InValidMessageFT_Invalid_Nums(wh);


EXPORT Make_displacement(SALT311.StrType s0) := MakeFT_Invalid_Nums_Blank(s0);
EXPORT InValid_displacement(SALT311.StrType s) := InValidFT_Invalid_Nums_Blank(s);
EXPORT InValidMessage_displacement(UNSIGNED1 wh) := InValidMessageFT_Invalid_Nums_Blank(wh);


EXPORT Make_cylinders(SALT311.StrType s0) := MakeFT_Invalid_Nums_Rotary(s0);
EXPORT InValid_cylinders(SALT311.StrType s) := InValidFT_Invalid_Nums_Rotary(s);
EXPORT InValidMessage_cylinders(UNSIGNED1 wh) := InValidMessageFT_Invalid_Nums_Rotary(wh);


EXPORT Make_fuel(SALT311.StrType s0) := MakeFT_Invalid_Fuel(s0);
EXPORT InValid_fuel(SALT311.StrType s) := InValidFT_Invalid_Fuel(s);
EXPORT InValidMessage_fuel(UNSIGNED1 wh) := InValidMessageFT_Invalid_Fuel(wh);


EXPORT Make_carburetion(SALT311.StrType s0) := MakeFT_Invalid_Carburetion_Num(s0);
EXPORT InValid_carburetion(SALT311.StrType s) := InValidFT_Invalid_Carburetion_Num(s);
EXPORT InValidMessage_carburetion(UNSIGNED1 wh) := InValidMessageFT_Invalid_Carburetion_Num(wh);


EXPORT Make_gvw(SALT311.StrType s0) := MakeFT_Invalid_Nums_Rotary(s0);
EXPORT InValid_gvw(SALT311.StrType s) := InValidFT_Invalid_Nums_Rotary(s);
EXPORT InValidMessage_gvw(UNSIGNED1 wh) := InValidMessageFT_Invalid_Nums_Rotary(wh);


EXPORT Make_wheel_base(SALT311.StrType s0) := MakeFT_Invalid_Decimal(s0);
EXPORT InValid_wheel_base(SALT311.StrType s) := InValidFT_Invalid_Decimal(s);
EXPORT InValidMessage_wheel_base(UNSIGNED1 wh) := InValidMessageFT_Invalid_Decimal(wh);


EXPORT Make_tire_size(SALT311.StrType s0) := MakeFT_Invalid_Tire_Size(s0);
EXPORT InValid_tire_size(SALT311.StrType s) := InValidFT_Invalid_Tire_Size(s);
EXPORT InValidMessage_tire_size(UNSIGNED1 wh) := InValidMessageFT_Invalid_Tire_Size(wh);


EXPORT Make_ton_rating(SALT311.StrType s0) := MakeFT_Invalid_Char_No_Spec(s0);
EXPORT InValid_ton_rating(SALT311.StrType s) := InValidFT_Invalid_Char_No_Spec(s);
EXPORT InValidMessage_ton_rating(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char_No_Spec(wh);


EXPORT Make_base_shipping_weight(SALT311.StrType s0) := MakeFT_Invalid_Decimal(s0);
EXPORT InValid_base_shipping_weight(SALT311.StrType s) := InValidFT_Invalid_Decimal(s);
EXPORT InValidMessage_base_shipping_weight(UNSIGNED1 wh) := InValidMessageFT_Invalid_Decimal(wh);


EXPORT Make_variance_weight(SALT311.StrType s0) := MakeFT_Invalid_Nums(s0);
EXPORT InValid_variance_weight(SALT311.StrType s) := InValidFT_Invalid_Nums(s);
EXPORT InValidMessage_variance_weight(UNSIGNED1 wh) := InValidMessageFT_Invalid_Nums(wh);


EXPORT Make_base_list_price(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_base_list_price(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_base_list_price(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_price_variance(SALT311.StrType s0) := MakeFT_Invalid_Nums(s0);
EXPORT InValid_price_variance(SALT311.StrType s) := InValidFT_Invalid_Nums(s);
EXPORT InValidMessage_price_variance(UNSIGNED1 wh) := InValidMessageFT_Invalid_Nums(wh);


EXPORT Make_high_performance_code(SALT311.StrType s0) := MakeFT_Invalid_HPC(s0);
EXPORT InValid_high_performance_code(SALT311.StrType s) := InValidFT_Invalid_HPC(s);
EXPORT InValidMessage_high_performance_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_HPC(wh);


EXPORT Make_driving_wheels(SALT311.StrType s0) := MakeFT_Invalid_Wheel(s0);
EXPORT InValid_driving_wheels(SALT311.StrType s) := InValidFT_Invalid_Wheel(s);
EXPORT InValidMessage_driving_wheels(UNSIGNED1 wh) := InValidMessageFT_Invalid_Wheel(wh);


EXPORT Make_iso_physical_damage(SALT311.StrType s0) := s0;
EXPORT InValid_iso_physical_damage(SALT311.StrType s) := 0;
EXPORT InValidMessage_iso_physical_damage(UNSIGNED1 wh) := '';


EXPORT Make_location_indicator(SALT311.StrType s0) := MakeFT_Invalid_Location(s0);
EXPORT InValid_location_indicator(SALT311.StrType s) := InValidFT_Invalid_Location(s);
EXPORT InValidMessage_location_indicator(UNSIGNED1 wh) := InValidMessageFT_Invalid_Location(wh);


EXPORT Make_air_conditioning(SALT311.StrType s0) := MakeFT_Invalid_Option_SOUN(s0);
EXPORT InValid_air_conditioning(SALT311.StrType s) := InValidFT_Invalid_Option_SOUN(s);
EXPORT InValidMessage_air_conditioning(UNSIGNED1 wh) := InValidMessageFT_Invalid_Option_SOUN(wh);


EXPORT Make_power_steering(SALT311.StrType s0) := MakeFT_Invalid_Option_SOUN(s0);
EXPORT InValid_power_steering(SALT311.StrType s) := InValidFT_Invalid_Option_SOUN(s);
EXPORT InValidMessage_power_steering(UNSIGNED1 wh) := InValidMessageFT_Invalid_Option_SOUN(wh);


EXPORT Make_power_brakes(SALT311.StrType s0) := MakeFT_Invalid_Option_SOUN(s0);
EXPORT InValid_power_brakes(SALT311.StrType s) := InValidFT_Invalid_Option_SOUN(s);
EXPORT InValidMessage_power_brakes(UNSIGNED1 wh) := InValidMessageFT_Invalid_Option_SOUN(wh);


EXPORT Make_power_windows(SALT311.StrType s0) := MakeFT_Invalid_Option_SOUN(s0);
EXPORT InValid_power_windows(SALT311.StrType s) := InValidFT_Invalid_Option_SOUN(s);
EXPORT InValidMessage_power_windows(UNSIGNED1 wh) := InValidMessageFT_Invalid_Option_SOUN(wh);


EXPORT Make_tilt_wheel(SALT311.StrType s0) := MakeFT_Invalid_Option_SOUN(s0);
EXPORT InValid_tilt_wheel(SALT311.StrType s) := InValidFT_Invalid_Option_SOUN(s);
EXPORT InValidMessage_tilt_wheel(UNSIGNED1 wh) := InValidMessageFT_Invalid_Option_SOUN(wh);


EXPORT Make_roof(SALT311.StrType s0) := MakeFT_Invalid_Roof(s0);
EXPORT InValid_roof(SALT311.StrType s) := InValidFT_Invalid_Roof(s);
EXPORT InValidMessage_roof(UNSIGNED1 wh) := InValidMessageFT_Invalid_Roof(wh);


EXPORT Make_optional_roof1(SALT311.StrType s0) := MakeFT_Invalid_Roof(s0);
EXPORT InValid_optional_roof1(SALT311.StrType s) := InValidFT_Invalid_Roof(s);
EXPORT InValidMessage_optional_roof1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Roof(wh);


EXPORT Make_optional_roof2(SALT311.StrType s0) := MakeFT_Invalid_Roof(s0);
EXPORT InValid_optional_roof2(SALT311.StrType s) := InValidFT_Invalid_Roof(s);
EXPORT InValidMessage_optional_roof2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Roof(wh);


EXPORT Make_radio(SALT311.StrType s0) := MakeFT_Invalid_Radio(s0);
EXPORT InValid_radio(SALT311.StrType s) := InValidFT_Invalid_Radio(s);
EXPORT InValidMessage_radio(UNSIGNED1 wh) := InValidMessageFT_Invalid_Radio(wh);


EXPORT Make_optional_radio1(SALT311.StrType s0) := MakeFT_Invalid_Radio(s0);
EXPORT InValid_optional_radio1(SALT311.StrType s) := InValidFT_Invalid_Radio(s);
EXPORT InValidMessage_optional_radio1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Radio(wh);


EXPORT Make_optional_radio2(SALT311.StrType s0) := MakeFT_Invalid_Radio(s0);
EXPORT InValid_optional_radio2(SALT311.StrType s) := InValidFT_Invalid_Radio(s);
EXPORT InValidMessage_optional_radio2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Radio(wh);


EXPORT Make_transmission(SALT311.StrType s0) := MakeFT_Invalid_Transmission(s0);
EXPORT InValid_transmission(SALT311.StrType s) := InValidFT_Invalid_Transmission(s);
EXPORT InValidMessage_transmission(UNSIGNED1 wh) := InValidMessageFT_Invalid_Transmission(wh);


EXPORT Make_optional_transmission1(SALT311.StrType s0) := MakeFT_Invalid_Transmission(s0);
EXPORT InValid_optional_transmission1(SALT311.StrType s) := InValidFT_Invalid_Transmission(s);
EXPORT InValidMessage_optional_transmission1(UNSIGNED1 wh) := InValidMessageFT_Invalid_Transmission(wh);


EXPORT Make_optional_transmission2(SALT311.StrType s0) := MakeFT_Invalid_Transmission(s0);
EXPORT InValid_optional_transmission2(SALT311.StrType s) := InValidFT_Invalid_Transmission(s);
EXPORT InValidMessage_optional_transmission2(UNSIGNED1 wh) := InValidMessageFT_Invalid_Transmission(wh);


EXPORT Make_anti_lock_brakes(SALT311.StrType s0) := MakeFT_Invalid_ALB(s0);
EXPORT InValid_anti_lock_brakes(SALT311.StrType s) := InValidFT_Invalid_ALB(s);
EXPORT InValidMessage_anti_lock_brakes(UNSIGNED1 wh) := InValidMessageFT_Invalid_ALB(wh);


EXPORT Make_security_system(SALT311.StrType s0) := MakeFT_Invalid_Security(s0);
EXPORT InValid_security_system(SALT311.StrType s) := InValidFT_Invalid_Security(s);
EXPORT InValidMessage_security_system(UNSIGNED1 wh) := InValidMessageFT_Invalid_Security(wh);


EXPORT Make_daytime_running_lights(SALT311.StrType s0) := MakeFT_Invalid_Option_SOUN(s0);
EXPORT InValid_daytime_running_lights(SALT311.StrType s) := InValidFT_Invalid_Option_SOUN(s);
EXPORT InValidMessage_daytime_running_lights(UNSIGNED1 wh) := InValidMessageFT_Invalid_Option_SOUN(wh);


EXPORT Make_visrap(SALT311.StrType s0) := MakeFT_Invalid_Visrap(s0);
EXPORT InValid_visrap(SALT311.StrType s) := InValidFT_Invalid_Visrap(s);
EXPORT InValidMessage_visrap(UNSIGNED1 wh) := InValidMessageFT_Invalid_Visrap(wh);


EXPORT Make_cab_configuration(SALT311.StrType s0) := MakeFT_Invalid_Cab(s0);
EXPORT InValid_cab_configuration(SALT311.StrType s) := InValidFT_Invalid_Cab(s);
EXPORT InValidMessage_cab_configuration(UNSIGNED1 wh) := InValidMessageFT_Invalid_Cab(wh);


EXPORT Make_front_axle_code(SALT311.StrType s0) := MakeFT_Invalid_FAC(s0);
EXPORT InValid_front_axle_code(SALT311.StrType s) := InValidFT_Invalid_FAC(s);
EXPORT InValidMessage_front_axle_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_FAC(wh);


EXPORT Make_rear_axle_code(SALT311.StrType s0) := MakeFT_Invalid_RAC(s0);
EXPORT InValid_rear_axle_code(SALT311.StrType s) := InValidFT_Invalid_RAC(s);
EXPORT InValidMessage_rear_axle_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_RAC(wh);


EXPORT Make_brakes_code(SALT311.StrType s0) := MakeFT_Invalid_Brakes(s0);
EXPORT InValid_brakes_code(SALT311.StrType s) := InValidFT_Invalid_Brakes(s);
EXPORT InValidMessage_brakes_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Brakes(wh);


EXPORT Make_engine_manufacturer(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_engine_manufacturer(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_engine_manufacturer(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_engine_model(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_engine_model(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_engine_model(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_engine_type_code(SALT311.StrType s0) := MakeFT_Invalid_Engine_Type(s0);
EXPORT InValid_engine_type_code(SALT311.StrType s) := InValidFT_Invalid_Engine_Type(s);
EXPORT InValidMessage_engine_type_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Engine_Type(wh);


EXPORT Make_trailer_body_style(SALT311.StrType s0) := MakeFT_Invalid_Trailer_Body(s0);
EXPORT InValid_trailer_body_style(SALT311.StrType s) := InValidFT_Invalid_Trailer_Body(s);
EXPORT InValidMessage_trailer_body_style(UNSIGNED1 wh) := InValidMessageFT_Invalid_Trailer_Body(wh);


EXPORT Make_trailer_number_of_axles(SALT311.StrType s0) := MakeFT_Invalid_Num_Axles(s0);
EXPORT InValid_trailer_number_of_axles(SALT311.StrType s) := InValidFT_Invalid_Num_Axles(s);
EXPORT InValidMessage_trailer_number_of_axles(UNSIGNED1 wh) := InValidMessageFT_Invalid_Num_Axles(wh);


EXPORT Make_trailer_length(SALT311.StrType s0) := MakeFT_Invalid_Trailer_length(s0);
EXPORT InValid_trailer_length(SALT311.StrType s) := InValidFT_Invalid_Trailer_length(s);
EXPORT InValidMessage_trailer_length(UNSIGNED1 wh) := InValidMessageFT_Invalid_Trailer_length(wh);


EXPORT Make_proactive_vin(SALT311.StrType s0) := MakeFT_Invalid_Proactive_VIN_Ind(s0);
EXPORT InValid_proactive_vin(SALT311.StrType s) := InValidFT_Invalid_Proactive_VIN_Ind(s);
EXPORT InValidMessage_proactive_vin(UNSIGNED1 wh) := InValidMessageFT_Invalid_Proactive_VIN_Ind(wh);


EXPORT Make_ma_state_exceptions(SALT311.StrType s0) := s0;
EXPORT InValid_ma_state_exceptions(SALT311.StrType s) := 0;
EXPORT InValidMessage_ma_state_exceptions(UNSIGNED1 wh) := '';


EXPORT Make_filler_1(SALT311.StrType s0) := s0;
EXPORT InValid_filler_1(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler_1(UNSIGNED1 wh) := '';


EXPORT Make_series_abbreviation(SALT311.StrType s0) := s0;
EXPORT InValid_series_abbreviation(SALT311.StrType s) := 0;
EXPORT InValidMessage_series_abbreviation(UNSIGNED1 wh) := '';


EXPORT Make_vin_pattern(SALT311.StrType s0) := MakeFT_Invalid_VIN_Pattern(s0);
EXPORT InValid_vin_pattern(SALT311.StrType s) := InValidFT_Invalid_VIN_Pattern(s);
EXPORT InValidMessage_vin_pattern(UNSIGNED1 wh) := InValidMessageFT_Invalid_VIN_Pattern(wh);


EXPORT Make_ncic_data(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_ncic_data(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_ncic_data(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_full_body_style_name(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_full_body_style_name(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_full_body_style_name(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_nvpp_make_code(SALT311.StrType s0) := s0;
EXPORT InValid_nvpp_make_code(SALT311.StrType s) := 0;
EXPORT InValidMessage_nvpp_make_code(UNSIGNED1 wh) := '';


EXPORT Make_nvpp_make_abbreviation(SALT311.StrType s0) := s0;
EXPORT InValid_nvpp_make_abbreviation(SALT311.StrType s) := 0;
EXPORT InValidMessage_nvpp_make_abbreviation(UNSIGNED1 wh) := '';


EXPORT Make_nvpp_series_model(SALT311.StrType s0) := s0;
EXPORT InValid_nvpp_series_model(SALT311.StrType s) := 0;
EXPORT InValidMessage_nvpp_series_model(UNSIGNED1 wh) := '';


EXPORT Make_nvpp_series_name(SALT311.StrType s0) := s0;
EXPORT InValid_nvpp_series_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_nvpp_series_name(UNSIGNED1 wh) := '';


EXPORT Make_segmentation_code(SALT311.StrType s0) := MakeFT_Invalid_Segmentation_Codes(s0);
EXPORT InValid_segmentation_code(SALT311.StrType s) := InValidFT_Invalid_Segmentation_Codes(s);
EXPORT InValidMessage_segmentation_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Segmentation_Codes(wh);


EXPORT Make_country_of_origin(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_country_of_origin(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_country_of_origin(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_engine_liter_information(SALT311.StrType s0) := MakeFT_Invalid_Liter(s0);
EXPORT InValid_engine_liter_information(SALT311.StrType s) := InValidFT_Invalid_Liter(s);
EXPORT InValidMessage_engine_liter_information(UNSIGNED1 wh) := InValidMessageFT_Invalid_Liter(wh);


EXPORT Make_engine_information_filler1(SALT311.StrType s0) := s0;
EXPORT InValid_engine_information_filler1(SALT311.StrType s) := 0;
EXPORT InValidMessage_engine_information_filler1(UNSIGNED1 wh) := '';


EXPORT Make_engine_information_block_type(SALT311.StrType s0) := MakeFT_Invalid_Block_Type(s0);
EXPORT InValid_engine_information_block_type(SALT311.StrType s) := InValidFT_Invalid_Block_Type(s);
EXPORT InValidMessage_engine_information_block_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Block_Type(wh);


EXPORT Make_engine_information_cylinders(SALT311.StrType s0) := MakeFT_Invalid_engine_information_cylinders(s0);
EXPORT InValid_engine_information_cylinders(SALT311.StrType s) := InValidFT_Invalid_engine_information_cylinders(s);
EXPORT InValidMessage_engine_information_cylinders(UNSIGNED1 wh) := InValidMessageFT_Invalid_engine_information_cylinders(wh);


EXPORT Make_engine_information_filler2(SALT311.StrType s0) := s0;
EXPORT InValid_engine_information_filler2(SALT311.StrType s) := 0;
EXPORT InValidMessage_engine_information_filler2(UNSIGNED1 wh) := '';


EXPORT Make_engine_information_carburetion(SALT311.StrType s0) := MakeFT_Invalid_Carburetion(s0);
EXPORT InValid_engine_information_carburetion(SALT311.StrType s) := InValidFT_Invalid_Carburetion(s);
EXPORT InValidMessage_engine_information_carburetion(UNSIGNED1 wh) := InValidMessageFT_Invalid_Carburetion(wh);


EXPORT Make_engine_information_filler3(SALT311.StrType s0) := s0;
EXPORT InValid_engine_information_filler3(SALT311.StrType s) := 0;
EXPORT InValidMessage_engine_information_filler3(UNSIGNED1 wh) := '';


EXPORT Make_engine_information_head_configuration(SALT311.StrType s0) := MakeFT_Invalid_Head_Configuration(s0);
EXPORT InValid_engine_information_head_configuration(SALT311.StrType s) := InValidFT_Invalid_Head_Configuration(s);
EXPORT InValidMessage_engine_information_head_configuration(UNSIGNED1 wh) := InValidMessageFT_Invalid_Head_Configuration(wh);


EXPORT Make_engine_information_filler4(SALT311.StrType s0) := s0;
EXPORT InValid_engine_information_filler4(SALT311.StrType s) := 0;
EXPORT InValidMessage_engine_information_filler4(UNSIGNED1 wh) := '';


EXPORT Make_engine_information_total_valves(SALT311.StrType s0) := MakeFT_Invalid_Valves(s0);
EXPORT InValid_engine_information_total_valves(SALT311.StrType s) := InValidFT_Invalid_Valves(s);
EXPORT InValidMessage_engine_information_total_valves(UNSIGNED1 wh) := InValidMessageFT_Invalid_Valves(wh);


EXPORT Make_engine_information_filler5(SALT311.StrType s0) := s0;
EXPORT InValid_engine_information_filler5(SALT311.StrType s) := 0;
EXPORT InValidMessage_engine_information_filler5(UNSIGNED1 wh) := '';


EXPORT Make_engine_information_aspiration_code(SALT311.StrType s0) := MakeFT_Invalid_Aspiration_Code(s0);
EXPORT InValid_engine_information_aspiration_code(SALT311.StrType s) := InValidFT_Invalid_Aspiration_Code(s);
EXPORT InValidMessage_engine_information_aspiration_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Aspiration_Code(wh);


EXPORT Make_engine_information_carburetion_code(SALT311.StrType s0) := MakeFT_Invalid_Carburetion_Code(s0);
EXPORT InValid_engine_information_carburetion_code(SALT311.StrType s) := InValidFT_Invalid_Carburetion_Code(s);
EXPORT InValidMessage_engine_information_carburetion_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Carburetion_Code(wh);


EXPORT Make_engine_information_valves_per_cylinder(SALT311.StrType s0) := MakeFT_Invalid_VPC(s0);
EXPORT InValid_engine_information_valves_per_cylinder(SALT311.StrType s) := InValidFT_Invalid_VPC(s);
EXPORT InValidMessage_engine_information_valves_per_cylinder(UNSIGNED1 wh) := InValidMessageFT_Invalid_VPC(wh);


EXPORT Make_transmission_speed(SALT311.StrType s0) := MakeFT_Invalid_Transmission_Speed(s0);
EXPORT InValid_transmission_speed(SALT311.StrType s) := InValidFT_Invalid_Transmission_Speed(s);
EXPORT InValidMessage_transmission_speed(UNSIGNED1 wh) := InValidMessageFT_Invalid_Transmission_Speed(wh);


EXPORT Make_transmission_filler1(SALT311.StrType s0) := s0;
EXPORT InValid_transmission_filler1(SALT311.StrType s) := 0;
EXPORT InValidMessage_transmission_filler1(UNSIGNED1 wh) := '';


EXPORT Make_transmission_type(SALT311.StrType s0) := MakeFT_Invalid_Transmission_Type(s0);
EXPORT InValid_transmission_type(SALT311.StrType s) := InValidFT_Invalid_Transmission_Type(s);
EXPORT InValidMessage_transmission_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Transmission_Type(wh);


EXPORT Make_transmission_filler2(SALT311.StrType s0) := s0;
EXPORT InValid_transmission_filler2(SALT311.StrType s) := 0;
EXPORT InValidMessage_transmission_filler2(UNSIGNED1 wh) := '';


EXPORT Make_transmission_code(SALT311.StrType s0) := MakeFT_Invalid_Transmission_Code(s0);
EXPORT InValid_transmission_code(SALT311.StrType s) := InValidFT_Invalid_Transmission_Code(s);
EXPORT InValidMessage_transmission_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Transmission_Code(wh);


EXPORT Make_transmission_filler3(SALT311.StrType s0) := s0;
EXPORT InValid_transmission_filler3(SALT311.StrType s) := 0;
EXPORT InValidMessage_transmission_filler3(UNSIGNED1 wh) := '';


EXPORT Make_transmission_speed_code(SALT311.StrType s0) := MakeFT_Invalid_Transmission_Speed_Code(s0);
EXPORT InValid_transmission_speed_code(SALT311.StrType s) := InValidFT_Invalid_Transmission_Speed_Code(s);
EXPORT InValidMessage_transmission_speed_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Transmission_Speed_Code(wh);


EXPORT Make_base_model(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_base_model(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_base_model(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_complete_prefix_file_id(SALT311.StrType s0) := MakeFT_Invalid_Nums(s0);
EXPORT InValid_complete_prefix_file_id(SALT311.StrType s) := InValidFT_Invalid_Nums(s);
EXPORT InValidMessage_complete_prefix_file_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Nums(wh);


EXPORT Make_series_name_full_spelling(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_series_name_full_spelling(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_series_name_full_spelling(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_vis_theft_code(SALT311.StrType s0) := MakeFT_Invalid_Y_or_N(s0);
EXPORT InValid_vis_theft_code(SALT311.StrType s) := InValidFT_Invalid_Y_or_N(s);
EXPORT InValidMessage_vis_theft_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_Y_or_N(wh);


EXPORT Make_base_list_price_expanded(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_base_list_price_expanded(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_base_list_price_expanded(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_default_nada_vehicle_id(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_default_nada_vehicle_id(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_default_nada_vehicle_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_default_nada_model(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_default_nada_model(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_default_nada_model(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_default_nada_body_style(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_default_nada_body_style(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_default_nada_body_style(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_default_nada_msrp(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_default_nada_msrp(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_default_nada_msrp(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_default_nada_gvwr(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_default_nada_gvwr(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_default_nada_gvwr(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_default_nada_gcwr(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_default_nada_gcwr(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_default_nada_gcwr(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_1_nada_vehicle_id(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_1_nada_vehicle_id(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_1_nada_vehicle_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_1_nada_model(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_1_nada_model(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_1_nada_model(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_1_nada_body_style(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_1_nada_body_style(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_1_nada_body_style(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_1_nada_msrp(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_1_nada_msrp(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_1_nada_msrp(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_1_nada_gvwr(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_1_nada_gvwr(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_1_nada_gvwr(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_1_nada_gcwr(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_1_nada_gcwr(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_1_nada_gcwr(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_2_nada_vehicle_id(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_2_nada_vehicle_id(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_2_nada_vehicle_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_2_nada_model(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_2_nada_model(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_2_nada_model(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_2_nada_body_style(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_2_nada_body_style(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_2_nada_body_style(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_2_nada_msrp(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_2_nada_msrp(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_2_nada_msrp(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_2_nada_gvwr(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_2_nada_gvwr(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_2_nada_gvwr(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_2_nada_gcwr(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_2_nada_gcwr(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_2_nada_gcwr(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_3_nada_vehicle_id(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_3_nada_vehicle_id(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_3_nada_vehicle_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_3_nada_model(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_3_nada_model(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_3_nada_model(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_3_nada_body_style(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_3_nada_body_style(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_3_nada_body_style(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_3_nada_msrp(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_3_nada_msrp(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_3_nada_msrp(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_3_nada_gvwr(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_3_nada_gvwr(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_3_nada_gvwr(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_3_nada_gcwr(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_3_nada_gcwr(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_3_nada_gcwr(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_4_nada_vehicle_id(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_4_nada_vehicle_id(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_4_nada_vehicle_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_4_nada_model(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_4_nada_model(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_4_nada_model(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_4_nada_body_style(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_4_nada_body_style(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_4_nada_body_style(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_4_nada_msrp(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_4_nada_msrp(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_4_nada_msrp(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_4_nada_gvwr(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_4_nada_gvwr(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_4_nada_gvwr(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_4_nada_gcwr(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_4_nada_gcwr(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_4_nada_gcwr(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_5_nada_vehicle_id(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_5_nada_vehicle_id(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_5_nada_vehicle_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_5_nada_model(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_5_nada_model(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_5_nada_model(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_5_nada_body_style(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_5_nada_body_style(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_5_nada_body_style(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_5_nada_msrp(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_5_nada_msrp(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_5_nada_msrp(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_5_nada_gvwr(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_5_nada_gvwr(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_5_nada_gvwr(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_5_nada_gcwr(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_5_nada_gcwr(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_5_nada_gcwr(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_6_nada_vehicle_id(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_6_nada_vehicle_id(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_6_nada_vehicle_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_6_nada_model(SALT311.StrType s0) := s0;
EXPORT InValid_alt_6_nada_model(SALT311.StrType s) := 0;
EXPORT InValidMessage_alt_6_nada_model(UNSIGNED1 wh) := '';


EXPORT Make_alt_6_nada_body_style(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_6_nada_body_style(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_6_nada_body_style(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_6_nada_msrp(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_6_nada_msrp(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_6_nada_msrp(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_6_nada_gvwr(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_6_nada_gvwr(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_6_nada_gvwr(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_6_nada_gcwr(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_6_nada_gcwr(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_6_nada_gcwr(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_7_nada_vehicle_id(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_7_nada_vehicle_id(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_7_nada_vehicle_id(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_7_nada_model(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_7_nada_model(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_7_nada_model(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_7_nada_body_style(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_7_nada_body_style(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_7_nada_body_style(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_7_nada_msrp(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_7_nada_msrp(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_7_nada_msrp(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_7_nada_gvwr(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_7_nada_gvwr(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_7_nada_gvwr(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_alt_7_nada_gcwr(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_alt_7_nada_gcwr(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_alt_7_nada_gcwr(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_aaia_codes(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_aaia_codes(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_aaia_codes(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_incomplete_vehicle_flag(SALT311.StrType s0) := MakeFT_Invalid_Y_or_N(s0);
EXPORT InValid_incomplete_vehicle_flag(SALT311.StrType s) := InValidFT_Invalid_Y_or_N(s);
EXPORT InValidMessage_incomplete_vehicle_flag(UNSIGNED1 wh) := InValidMessageFT_Invalid_Y_or_N(wh);


EXPORT Make_filler2(SALT311.StrType s0) := s0;
EXPORT InValid_filler2(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler2(UNSIGNED1 wh) := '';


EXPORT Make_electric_battery_info_type(SALT311.StrType s0) := MakeFT_Invalid_Battery_Type(s0);
EXPORT InValid_electric_battery_info_type(SALT311.StrType s) := InValidFT_Invalid_Battery_Type(s);
EXPORT InValidMessage_electric_battery_info_type(UNSIGNED1 wh) := InValidMessageFT_Invalid_Battery_Type(wh);


EXPORT Make_filler3(SALT311.StrType s0) := s0;
EXPORT InValid_filler3(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler3(UNSIGNED1 wh) := '';


EXPORT Make_electric_battery_kilowatts(SALT311.StrType s0) := MakeFT_Invalid_Battery_KW(s0);
EXPORT InValid_electric_battery_kilowatts(SALT311.StrType s) := InValidFT_Invalid_Battery_KW(s);
EXPORT InValidMessage_electric_battery_kilowatts(UNSIGNED1 wh) := InValidMessageFT_Invalid_Battery_KW(wh);


EXPORT Make_filler4(SALT311.StrType s0) := s0;
EXPORT InValid_filler4(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler4(UNSIGNED1 wh) := '';


EXPORT Make_electric_battery_volts(SALT311.StrType s0) := MakeFT_Invalid_Battery_Volts(s0);
EXPORT InValid_electric_battery_volts(SALT311.StrType s) := InValidFT_Invalid_Battery_Volts(s);
EXPORT InValidMessage_electric_battery_volts(UNSIGNED1 wh) := InValidMessageFT_Invalid_Battery_Volts(wh);


EXPORT Make_filler5(SALT311.StrType s0) := s0;
EXPORT InValid_filler5(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler5(UNSIGNED1 wh) := '';


EXPORT Make_engine_info_proprietary_engine_brand(SALT311.StrType s0) := MakeFT_Invalid_Engine_Brand(s0);
EXPORT InValid_engine_info_proprietary_engine_brand(SALT311.StrType s) := InValidFT_Invalid_Engine_Brand(s);
EXPORT InValidMessage_engine_info_proprietary_engine_brand(UNSIGNED1 wh) := InValidMessageFT_Invalid_Engine_Brand(wh);


EXPORT Make_filler6(SALT311.StrType s0) := s0;
EXPORT InValid_filler6(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler6(UNSIGNED1 wh) := '';


EXPORT Make_engine_info_high_output_engine(SALT311.StrType s0) := MakeFT_Invalid_Y_or_N(s0);
EXPORT InValid_engine_info_high_output_engine(SALT311.StrType s) := InValidFT_Invalid_Y_or_N(s);
EXPORT InValidMessage_engine_info_high_output_engine(UNSIGNED1 wh) := InValidMessageFT_Invalid_Y_or_N(wh);


EXPORT Make_engine_info_supercharged(SALT311.StrType s0) := MakeFT_Invalid_Supercharged(s0);
EXPORT InValid_engine_info_supercharged(SALT311.StrType s) := InValidFT_Invalid_Supercharged(s);
EXPORT InValidMessage_engine_info_supercharged(UNSIGNED1 wh) := InValidMessageFT_Invalid_Supercharged(wh);


EXPORT Make_engine_info_turbocharged(SALT311.StrType s0) := MakeFT_Invalid_Turbocharged(s0);
EXPORT InValid_engine_info_turbocharged(SALT311.StrType s) := InValidFT_Invalid_Turbocharged(s);
EXPORT InValidMessage_engine_info_turbocharged(UNSIGNED1 wh) := InValidMessageFT_Invalid_Turbocharged(wh);


EXPORT Make_engine_info_vvtl(SALT311.StrType s0) := MakeFT_Invalid_Y_or_N_orBlank(s0);
EXPORT InValid_engine_info_vvtl(SALT311.StrType s) := InValidFT_Invalid_Y_or_N_orBlank(s);
EXPORT InValidMessage_engine_info_vvtl(UNSIGNED1 wh) := InValidMessageFT_Invalid_Y_or_N_orBlank(wh);


EXPORT Make_iso_liability(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_iso_liability(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_iso_liability(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_series_name_condensed(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_series_name_condensed(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_series_name_condensed(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_aces_data(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_aces_data(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_aces_data(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);


EXPORT Make_base_shipping_weight_expanded(SALT311.StrType s0) := MakeFT_Invalid_Decimal(s0);
EXPORT InValid_base_shipping_weight_expanded(SALT311.StrType s) := InValidFT_Invalid_Decimal(s);
EXPORT InValidMessage_base_shipping_weight_expanded(UNSIGNED1 wh) := InValidMessageFT_Invalid_Decimal(wh);


EXPORT Make_filler7(SALT311.StrType s0) := s0;
EXPORT InValid_filler7(SALT311.StrType s) := 0;
EXPORT InValidMessage_filler7(UNSIGNED1 wh) := '';


EXPORT Make_customer_defined_data(SALT311.StrType s0) := MakeFT_Invalid_Char(s0);
EXPORT InValid_customer_defined_data(SALT311.StrType s) := InValidFT_Invalid_Char(s);
EXPORT InValidMessage_customer_defined_data(UNSIGNED1 wh) := InValidMessageFT_Invalid_Char(wh);

// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_VINA;
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
    BOOLEAN Diff_match_make;
    BOOLEAN Diff_match_year;
    BOOLEAN Diff_match_vin;
    BOOLEAN Diff_make_abbreviation;
    BOOLEAN Diff_model_year;
    BOOLEAN Diff_vehicle_type;
    BOOLEAN Diff_make_name;
    BOOLEAN Diff_series_name;
    BOOLEAN Diff_body_type;
    BOOLEAN Diff_wheels;
    BOOLEAN Diff_displacement;
    BOOLEAN Diff_cylinders;
    BOOLEAN Diff_fuel;
    BOOLEAN Diff_carburetion;
    BOOLEAN Diff_gvw;
    BOOLEAN Diff_wheel_base;
    BOOLEAN Diff_tire_size;
    BOOLEAN Diff_ton_rating;
    BOOLEAN Diff_base_shipping_weight;
    BOOLEAN Diff_variance_weight;
    BOOLEAN Diff_base_list_price;
    BOOLEAN Diff_price_variance;
    BOOLEAN Diff_high_performance_code;
    BOOLEAN Diff_driving_wheels;
    BOOLEAN Diff_iso_physical_damage;
    BOOLEAN Diff_location_indicator;
    BOOLEAN Diff_air_conditioning;
    BOOLEAN Diff_power_steering;
    BOOLEAN Diff_power_brakes;
    BOOLEAN Diff_power_windows;
    BOOLEAN Diff_tilt_wheel;
    BOOLEAN Diff_roof;
    BOOLEAN Diff_optional_roof1;
    BOOLEAN Diff_optional_roof2;
    BOOLEAN Diff_radio;
    BOOLEAN Diff_optional_radio1;
    BOOLEAN Diff_optional_radio2;
    BOOLEAN Diff_transmission;
    BOOLEAN Diff_optional_transmission1;
    BOOLEAN Diff_optional_transmission2;
    BOOLEAN Diff_anti_lock_brakes;
    BOOLEAN Diff_security_system;
    BOOLEAN Diff_daytime_running_lights;
    BOOLEAN Diff_visrap;
    BOOLEAN Diff_cab_configuration;
    BOOLEAN Diff_front_axle_code;
    BOOLEAN Diff_rear_axle_code;
    BOOLEAN Diff_brakes_code;
    BOOLEAN Diff_engine_manufacturer;
    BOOLEAN Diff_engine_model;
    BOOLEAN Diff_engine_type_code;
    BOOLEAN Diff_trailer_body_style;
    BOOLEAN Diff_trailer_number_of_axles;
    BOOLEAN Diff_trailer_length;
    BOOLEAN Diff_proactive_vin;
    BOOLEAN Diff_ma_state_exceptions;
    BOOLEAN Diff_filler_1;
    BOOLEAN Diff_series_abbreviation;
    BOOLEAN Diff_vin_pattern;
    BOOLEAN Diff_ncic_data;
    BOOLEAN Diff_full_body_style_name;
    BOOLEAN Diff_nvpp_make_code;
    BOOLEAN Diff_nvpp_make_abbreviation;
    BOOLEAN Diff_nvpp_series_model;
    BOOLEAN Diff_nvpp_series_name;
    BOOLEAN Diff_segmentation_code;
    BOOLEAN Diff_country_of_origin;
    BOOLEAN Diff_engine_liter_information;
    BOOLEAN Diff_engine_information_filler1;
    BOOLEAN Diff_engine_information_block_type;
    BOOLEAN Diff_engine_information_cylinders;
    BOOLEAN Diff_engine_information_filler2;
    BOOLEAN Diff_engine_information_carburetion;
    BOOLEAN Diff_engine_information_filler3;
    BOOLEAN Diff_engine_information_head_configuration;
    BOOLEAN Diff_engine_information_filler4;
    BOOLEAN Diff_engine_information_total_valves;
    BOOLEAN Diff_engine_information_filler5;
    BOOLEAN Diff_engine_information_aspiration_code;
    BOOLEAN Diff_engine_information_carburetion_code;
    BOOLEAN Diff_engine_information_valves_per_cylinder;
    BOOLEAN Diff_transmission_speed;
    BOOLEAN Diff_transmission_filler1;
    BOOLEAN Diff_transmission_type;
    BOOLEAN Diff_transmission_filler2;
    BOOLEAN Diff_transmission_code;
    BOOLEAN Diff_transmission_filler3;
    BOOLEAN Diff_transmission_speed_code;
    BOOLEAN Diff_base_model;
    BOOLEAN Diff_complete_prefix_file_id;
    BOOLEAN Diff_series_name_full_spelling;
    BOOLEAN Diff_vis_theft_code;
    BOOLEAN Diff_base_list_price_expanded;
    BOOLEAN Diff_default_nada_vehicle_id;
    BOOLEAN Diff_default_nada_model;
    BOOLEAN Diff_default_nada_body_style;
    BOOLEAN Diff_default_nada_msrp;
    BOOLEAN Diff_default_nada_gvwr;
    BOOLEAN Diff_default_nada_gcwr;
    BOOLEAN Diff_alt_1_nada_vehicle_id;
    BOOLEAN Diff_alt_1_nada_model;
    BOOLEAN Diff_alt_1_nada_body_style;
    BOOLEAN Diff_alt_1_nada_msrp;
    BOOLEAN Diff_alt_1_nada_gvwr;
    BOOLEAN Diff_alt_1_nada_gcwr;
    BOOLEAN Diff_alt_2_nada_vehicle_id;
    BOOLEAN Diff_alt_2_nada_model;
    BOOLEAN Diff_alt_2_nada_body_style;
    BOOLEAN Diff_alt_2_nada_msrp;
    BOOLEAN Diff_alt_2_nada_gvwr;
    BOOLEAN Diff_alt_2_nada_gcwr;
    BOOLEAN Diff_alt_3_nada_vehicle_id;
    BOOLEAN Diff_alt_3_nada_model;
    BOOLEAN Diff_alt_3_nada_body_style;
    BOOLEAN Diff_alt_3_nada_msrp;
    BOOLEAN Diff_alt_3_nada_gvwr;
    BOOLEAN Diff_alt_3_nada_gcwr;
    BOOLEAN Diff_alt_4_nada_vehicle_id;
    BOOLEAN Diff_alt_4_nada_model;
    BOOLEAN Diff_alt_4_nada_body_style;
    BOOLEAN Diff_alt_4_nada_msrp;
    BOOLEAN Diff_alt_4_nada_gvwr;
    BOOLEAN Diff_alt_4_nada_gcwr;
    BOOLEAN Diff_alt_5_nada_vehicle_id;
    BOOLEAN Diff_alt_5_nada_model;
    BOOLEAN Diff_alt_5_nada_body_style;
    BOOLEAN Diff_alt_5_nada_msrp;
    BOOLEAN Diff_alt_5_nada_gvwr;
    BOOLEAN Diff_alt_5_nada_gcwr;
    BOOLEAN Diff_alt_6_nada_vehicle_id;
    BOOLEAN Diff_alt_6_nada_model;
    BOOLEAN Diff_alt_6_nada_body_style;
    BOOLEAN Diff_alt_6_nada_msrp;
    BOOLEAN Diff_alt_6_nada_gvwr;
    BOOLEAN Diff_alt_6_nada_gcwr;
    BOOLEAN Diff_alt_7_nada_vehicle_id;
    BOOLEAN Diff_alt_7_nada_model;
    BOOLEAN Diff_alt_7_nada_body_style;
    BOOLEAN Diff_alt_7_nada_msrp;
    BOOLEAN Diff_alt_7_nada_gvwr;
    BOOLEAN Diff_alt_7_nada_gcwr;
    BOOLEAN Diff_aaia_codes;
    BOOLEAN Diff_incomplete_vehicle_flag;
    BOOLEAN Diff_filler2;
    BOOLEAN Diff_electric_battery_info_type;
    BOOLEAN Diff_filler3;
    BOOLEAN Diff_electric_battery_kilowatts;
    BOOLEAN Diff_filler4;
    BOOLEAN Diff_electric_battery_volts;
    BOOLEAN Diff_filler5;
    BOOLEAN Diff_engine_info_proprietary_engine_brand;
    BOOLEAN Diff_filler6;
    BOOLEAN Diff_engine_info_high_output_engine;
    BOOLEAN Diff_engine_info_supercharged;
    BOOLEAN Diff_engine_info_turbocharged;
    BOOLEAN Diff_engine_info_vvtl;
    BOOLEAN Diff_iso_liability;
    BOOLEAN Diff_series_name_condensed;
    BOOLEAN Diff_aces_data;
    BOOLEAN Diff_base_shipping_weight_expanded;
    BOOLEAN Diff_filler7;
    BOOLEAN Diff_customer_defined_data;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_match_make := le.match_make <> ri.match_make;
    SELF.Diff_match_year := le.match_year <> ri.match_year;
    SELF.Diff_match_vin := le.match_vin <> ri.match_vin;
    SELF.Diff_make_abbreviation := le.make_abbreviation <> ri.make_abbreviation;
    SELF.Diff_model_year := le.model_year <> ri.model_year;
    SELF.Diff_vehicle_type := le.vehicle_type <> ri.vehicle_type;
    SELF.Diff_make_name := le.make_name <> ri.make_name;
    SELF.Diff_series_name := le.series_name <> ri.series_name;
    SELF.Diff_body_type := le.body_type <> ri.body_type;
    SELF.Diff_wheels := le.wheels <> ri.wheels;
    SELF.Diff_displacement := le.displacement <> ri.displacement;
    SELF.Diff_cylinders := le.cylinders <> ri.cylinders;
    SELF.Diff_fuel := le.fuel <> ri.fuel;
    SELF.Diff_carburetion := le.carburetion <> ri.carburetion;
    SELF.Diff_gvw := le.gvw <> ri.gvw;
    SELF.Diff_wheel_base := le.wheel_base <> ri.wheel_base;
    SELF.Diff_tire_size := le.tire_size <> ri.tire_size;
    SELF.Diff_ton_rating := le.ton_rating <> ri.ton_rating;
    SELF.Diff_base_shipping_weight := le.base_shipping_weight <> ri.base_shipping_weight;
    SELF.Diff_variance_weight := le.variance_weight <> ri.variance_weight;
    SELF.Diff_base_list_price := le.base_list_price <> ri.base_list_price;
    SELF.Diff_price_variance := le.price_variance <> ri.price_variance;
    SELF.Diff_high_performance_code := le.high_performance_code <> ri.high_performance_code;
    SELF.Diff_driving_wheels := le.driving_wheels <> ri.driving_wheels;
    SELF.Diff_iso_physical_damage := le.iso_physical_damage <> ri.iso_physical_damage;
    SELF.Diff_location_indicator := le.location_indicator <> ri.location_indicator;
    SELF.Diff_air_conditioning := le.air_conditioning <> ri.air_conditioning;
    SELF.Diff_power_steering := le.power_steering <> ri.power_steering;
    SELF.Diff_power_brakes := le.power_brakes <> ri.power_brakes;
    SELF.Diff_power_windows := le.power_windows <> ri.power_windows;
    SELF.Diff_tilt_wheel := le.tilt_wheel <> ri.tilt_wheel;
    SELF.Diff_roof := le.roof <> ri.roof;
    SELF.Diff_optional_roof1 := le.optional_roof1 <> ri.optional_roof1;
    SELF.Diff_optional_roof2 := le.optional_roof2 <> ri.optional_roof2;
    SELF.Diff_radio := le.radio <> ri.radio;
    SELF.Diff_optional_radio1 := le.optional_radio1 <> ri.optional_radio1;
    SELF.Diff_optional_radio2 := le.optional_radio2 <> ri.optional_radio2;
    SELF.Diff_transmission := le.transmission <> ri.transmission;
    SELF.Diff_optional_transmission1 := le.optional_transmission1 <> ri.optional_transmission1;
    SELF.Diff_optional_transmission2 := le.optional_transmission2 <> ri.optional_transmission2;
    SELF.Diff_anti_lock_brakes := le.anti_lock_brakes <> ri.anti_lock_brakes;
    SELF.Diff_security_system := le.security_system <> ri.security_system;
    SELF.Diff_daytime_running_lights := le.daytime_running_lights <> ri.daytime_running_lights;
    SELF.Diff_visrap := le.visrap <> ri.visrap;
    SELF.Diff_cab_configuration := le.cab_configuration <> ri.cab_configuration;
    SELF.Diff_front_axle_code := le.front_axle_code <> ri.front_axle_code;
    SELF.Diff_rear_axle_code := le.rear_axle_code <> ri.rear_axle_code;
    SELF.Diff_brakes_code := le.brakes_code <> ri.brakes_code;
    SELF.Diff_engine_manufacturer := le.engine_manufacturer <> ri.engine_manufacturer;
    SELF.Diff_engine_model := le.engine_model <> ri.engine_model;
    SELF.Diff_engine_type_code := le.engine_type_code <> ri.engine_type_code;
    SELF.Diff_trailer_body_style := le.trailer_body_style <> ri.trailer_body_style;
    SELF.Diff_trailer_number_of_axles := le.trailer_number_of_axles <> ri.trailer_number_of_axles;
    SELF.Diff_trailer_length := le.trailer_length <> ri.trailer_length;
    SELF.Diff_proactive_vin := le.proactive_vin <> ri.proactive_vin;
    SELF.Diff_ma_state_exceptions := le.ma_state_exceptions <> ri.ma_state_exceptions;
    SELF.Diff_filler_1 := le.filler_1 <> ri.filler_1;
    SELF.Diff_series_abbreviation := le.series_abbreviation <> ri.series_abbreviation;
    SELF.Diff_vin_pattern := le.vin_pattern <> ri.vin_pattern;
    SELF.Diff_ncic_data := le.ncic_data <> ri.ncic_data;
    SELF.Diff_full_body_style_name := le.full_body_style_name <> ri.full_body_style_name;
    SELF.Diff_nvpp_make_code := le.nvpp_make_code <> ri.nvpp_make_code;
    SELF.Diff_nvpp_make_abbreviation := le.nvpp_make_abbreviation <> ri.nvpp_make_abbreviation;
    SELF.Diff_nvpp_series_model := le.nvpp_series_model <> ri.nvpp_series_model;
    SELF.Diff_nvpp_series_name := le.nvpp_series_name <> ri.nvpp_series_name;
    SELF.Diff_segmentation_code := le.segmentation_code <> ri.segmentation_code;
    SELF.Diff_country_of_origin := le.country_of_origin <> ri.country_of_origin;
    SELF.Diff_engine_liter_information := le.engine_liter_information <> ri.engine_liter_information;
    SELF.Diff_engine_information_filler1 := le.engine_information_filler1 <> ri.engine_information_filler1;
    SELF.Diff_engine_information_block_type := le.engine_information_block_type <> ri.engine_information_block_type;
    SELF.Diff_engine_information_cylinders := le.engine_information_cylinders <> ri.engine_information_cylinders;
    SELF.Diff_engine_information_filler2 := le.engine_information_filler2 <> ri.engine_information_filler2;
    SELF.Diff_engine_information_carburetion := le.engine_information_carburetion <> ri.engine_information_carburetion;
    SELF.Diff_engine_information_filler3 := le.engine_information_filler3 <> ri.engine_information_filler3;
    SELF.Diff_engine_information_head_configuration := le.engine_information_head_configuration <> ri.engine_information_head_configuration;
    SELF.Diff_engine_information_filler4 := le.engine_information_filler4 <> ri.engine_information_filler4;
    SELF.Diff_engine_information_total_valves := le.engine_information_total_valves <> ri.engine_information_total_valves;
    SELF.Diff_engine_information_filler5 := le.engine_information_filler5 <> ri.engine_information_filler5;
    SELF.Diff_engine_information_aspiration_code := le.engine_information_aspiration_code <> ri.engine_information_aspiration_code;
    SELF.Diff_engine_information_carburetion_code := le.engine_information_carburetion_code <> ri.engine_information_carburetion_code;
    SELF.Diff_engine_information_valves_per_cylinder := le.engine_information_valves_per_cylinder <> ri.engine_information_valves_per_cylinder;
    SELF.Diff_transmission_speed := le.transmission_speed <> ri.transmission_speed;
    SELF.Diff_transmission_filler1 := le.transmission_filler1 <> ri.transmission_filler1;
    SELF.Diff_transmission_type := le.transmission_type <> ri.transmission_type;
    SELF.Diff_transmission_filler2 := le.transmission_filler2 <> ri.transmission_filler2;
    SELF.Diff_transmission_code := le.transmission_code <> ri.transmission_code;
    SELF.Diff_transmission_filler3 := le.transmission_filler3 <> ri.transmission_filler3;
    SELF.Diff_transmission_speed_code := le.transmission_speed_code <> ri.transmission_speed_code;
    SELF.Diff_base_model := le.base_model <> ri.base_model;
    SELF.Diff_complete_prefix_file_id := le.complete_prefix_file_id <> ri.complete_prefix_file_id;
    SELF.Diff_series_name_full_spelling := le.series_name_full_spelling <> ri.series_name_full_spelling;
    SELF.Diff_vis_theft_code := le.vis_theft_code <> ri.vis_theft_code;
    SELF.Diff_base_list_price_expanded := le.base_list_price_expanded <> ri.base_list_price_expanded;
    SELF.Diff_default_nada_vehicle_id := le.default_nada_vehicle_id <> ri.default_nada_vehicle_id;
    SELF.Diff_default_nada_model := le.default_nada_model <> ri.default_nada_model;
    SELF.Diff_default_nada_body_style := le.default_nada_body_style <> ri.default_nada_body_style;
    SELF.Diff_default_nada_msrp := le.default_nada_msrp <> ri.default_nada_msrp;
    SELF.Diff_default_nada_gvwr := le.default_nada_gvwr <> ri.default_nada_gvwr;
    SELF.Diff_default_nada_gcwr := le.default_nada_gcwr <> ri.default_nada_gcwr;
    SELF.Diff_alt_1_nada_vehicle_id := le.alt_1_nada_vehicle_id <> ri.alt_1_nada_vehicle_id;
    SELF.Diff_alt_1_nada_model := le.alt_1_nada_model <> ri.alt_1_nada_model;
    SELF.Diff_alt_1_nada_body_style := le.alt_1_nada_body_style <> ri.alt_1_nada_body_style;
    SELF.Diff_alt_1_nada_msrp := le.alt_1_nada_msrp <> ri.alt_1_nada_msrp;
    SELF.Diff_alt_1_nada_gvwr := le.alt_1_nada_gvwr <> ri.alt_1_nada_gvwr;
    SELF.Diff_alt_1_nada_gcwr := le.alt_1_nada_gcwr <> ri.alt_1_nada_gcwr;
    SELF.Diff_alt_2_nada_vehicle_id := le.alt_2_nada_vehicle_id <> ri.alt_2_nada_vehicle_id;
    SELF.Diff_alt_2_nada_model := le.alt_2_nada_model <> ri.alt_2_nada_model;
    SELF.Diff_alt_2_nada_body_style := le.alt_2_nada_body_style <> ri.alt_2_nada_body_style;
    SELF.Diff_alt_2_nada_msrp := le.alt_2_nada_msrp <> ri.alt_2_nada_msrp;
    SELF.Diff_alt_2_nada_gvwr := le.alt_2_nada_gvwr <> ri.alt_2_nada_gvwr;
    SELF.Diff_alt_2_nada_gcwr := le.alt_2_nada_gcwr <> ri.alt_2_nada_gcwr;
    SELF.Diff_alt_3_nada_vehicle_id := le.alt_3_nada_vehicle_id <> ri.alt_3_nada_vehicle_id;
    SELF.Diff_alt_3_nada_model := le.alt_3_nada_model <> ri.alt_3_nada_model;
    SELF.Diff_alt_3_nada_body_style := le.alt_3_nada_body_style <> ri.alt_3_nada_body_style;
    SELF.Diff_alt_3_nada_msrp := le.alt_3_nada_msrp <> ri.alt_3_nada_msrp;
    SELF.Diff_alt_3_nada_gvwr := le.alt_3_nada_gvwr <> ri.alt_3_nada_gvwr;
    SELF.Diff_alt_3_nada_gcwr := le.alt_3_nada_gcwr <> ri.alt_3_nada_gcwr;
    SELF.Diff_alt_4_nada_vehicle_id := le.alt_4_nada_vehicle_id <> ri.alt_4_nada_vehicle_id;
    SELF.Diff_alt_4_nada_model := le.alt_4_nada_model <> ri.alt_4_nada_model;
    SELF.Diff_alt_4_nada_body_style := le.alt_4_nada_body_style <> ri.alt_4_nada_body_style;
    SELF.Diff_alt_4_nada_msrp := le.alt_4_nada_msrp <> ri.alt_4_nada_msrp;
    SELF.Diff_alt_4_nada_gvwr := le.alt_4_nada_gvwr <> ri.alt_4_nada_gvwr;
    SELF.Diff_alt_4_nada_gcwr := le.alt_4_nada_gcwr <> ri.alt_4_nada_gcwr;
    SELF.Diff_alt_5_nada_vehicle_id := le.alt_5_nada_vehicle_id <> ri.alt_5_nada_vehicle_id;
    SELF.Diff_alt_5_nada_model := le.alt_5_nada_model <> ri.alt_5_nada_model;
    SELF.Diff_alt_5_nada_body_style := le.alt_5_nada_body_style <> ri.alt_5_nada_body_style;
    SELF.Diff_alt_5_nada_msrp := le.alt_5_nada_msrp <> ri.alt_5_nada_msrp;
    SELF.Diff_alt_5_nada_gvwr := le.alt_5_nada_gvwr <> ri.alt_5_nada_gvwr;
    SELF.Diff_alt_5_nada_gcwr := le.alt_5_nada_gcwr <> ri.alt_5_nada_gcwr;
    SELF.Diff_alt_6_nada_vehicle_id := le.alt_6_nada_vehicle_id <> ri.alt_6_nada_vehicle_id;
    SELF.Diff_alt_6_nada_model := le.alt_6_nada_model <> ri.alt_6_nada_model;
    SELF.Diff_alt_6_nada_body_style := le.alt_6_nada_body_style <> ri.alt_6_nada_body_style;
    SELF.Diff_alt_6_nada_msrp := le.alt_6_nada_msrp <> ri.alt_6_nada_msrp;
    SELF.Diff_alt_6_nada_gvwr := le.alt_6_nada_gvwr <> ri.alt_6_nada_gvwr;
    SELF.Diff_alt_6_nada_gcwr := le.alt_6_nada_gcwr <> ri.alt_6_nada_gcwr;
    SELF.Diff_alt_7_nada_vehicle_id := le.alt_7_nada_vehicle_id <> ri.alt_7_nada_vehicle_id;
    SELF.Diff_alt_7_nada_model := le.alt_7_nada_model <> ri.alt_7_nada_model;
    SELF.Diff_alt_7_nada_body_style := le.alt_7_nada_body_style <> ri.alt_7_nada_body_style;
    SELF.Diff_alt_7_nada_msrp := le.alt_7_nada_msrp <> ri.alt_7_nada_msrp;
    SELF.Diff_alt_7_nada_gvwr := le.alt_7_nada_gvwr <> ri.alt_7_nada_gvwr;
    SELF.Diff_alt_7_nada_gcwr := le.alt_7_nada_gcwr <> ri.alt_7_nada_gcwr;
    SELF.Diff_aaia_codes := le.aaia_codes <> ri.aaia_codes;
    SELF.Diff_incomplete_vehicle_flag := le.incomplete_vehicle_flag <> ri.incomplete_vehicle_flag;
    SELF.Diff_filler2 := le.filler2 <> ri.filler2;
    SELF.Diff_electric_battery_info_type := le.electric_battery_info_type <> ri.electric_battery_info_type;
    SELF.Diff_filler3 := le.filler3 <> ri.filler3;
    SELF.Diff_electric_battery_kilowatts := le.electric_battery_kilowatts <> ri.electric_battery_kilowatts;
    SELF.Diff_filler4 := le.filler4 <> ri.filler4;
    SELF.Diff_electric_battery_volts := le.electric_battery_volts <> ri.electric_battery_volts;
    SELF.Diff_filler5 := le.filler5 <> ri.filler5;
    SELF.Diff_engine_info_proprietary_engine_brand := le.engine_info_proprietary_engine_brand <> ri.engine_info_proprietary_engine_brand;
    SELF.Diff_filler6 := le.filler6 <> ri.filler6;
    SELF.Diff_engine_info_high_output_engine := le.engine_info_high_output_engine <> ri.engine_info_high_output_engine;
    SELF.Diff_engine_info_supercharged := le.engine_info_supercharged <> ri.engine_info_supercharged;
    SELF.Diff_engine_info_turbocharged := le.engine_info_turbocharged <> ri.engine_info_turbocharged;
    SELF.Diff_engine_info_vvtl := le.engine_info_vvtl <> ri.engine_info_vvtl;
    SELF.Diff_iso_liability := le.iso_liability <> ri.iso_liability;
    SELF.Diff_series_name_condensed := le.series_name_condensed <> ri.series_name_condensed;
    SELF.Diff_aces_data := le.aces_data <> ri.aces_data;
    SELF.Diff_base_shipping_weight_expanded := le.base_shipping_weight_expanded <> ri.base_shipping_weight_expanded;
    SELF.Diff_filler7 := le.filler7 <> ri.filler7;
    SELF.Diff_customer_defined_data := le.customer_defined_data <> ri.customer_defined_data;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_match_make,1,0)+ IF( SELF.Diff_match_year,1,0)+ IF( SELF.Diff_match_vin,1,0)+ IF( SELF.Diff_make_abbreviation,1,0)+ IF( SELF.Diff_model_year,1,0)+ IF( SELF.Diff_vehicle_type,1,0)+ IF( SELF.Diff_make_name,1,0)+ IF( SELF.Diff_series_name,1,0)+ IF( SELF.Diff_body_type,1,0)+ IF( SELF.Diff_wheels,1,0)+ IF( SELF.Diff_displacement,1,0)+ IF( SELF.Diff_cylinders,1,0)+ IF( SELF.Diff_fuel,1,0)+ IF( SELF.Diff_carburetion,1,0)+ IF( SELF.Diff_gvw,1,0)+ IF( SELF.Diff_wheel_base,1,0)+ IF( SELF.Diff_tire_size,1,0)+ IF( SELF.Diff_ton_rating,1,0)+ IF( SELF.Diff_base_shipping_weight,1,0)+ IF( SELF.Diff_variance_weight,1,0)+ IF( SELF.Diff_base_list_price,1,0)+ IF( SELF.Diff_price_variance,1,0)+ IF( SELF.Diff_high_performance_code,1,0)+ IF( SELF.Diff_driving_wheels,1,0)+ IF( SELF.Diff_iso_physical_damage,1,0)+ IF( SELF.Diff_location_indicator,1,0)+ IF( SELF.Diff_air_conditioning,1,0)+ IF( SELF.Diff_power_steering,1,0)+ IF( SELF.Diff_power_brakes,1,0)+ IF( SELF.Diff_power_windows,1,0)+ IF( SELF.Diff_tilt_wheel,1,0)+ IF( SELF.Diff_roof,1,0)+ IF( SELF.Diff_optional_roof1,1,0)+ IF( SELF.Diff_optional_roof2,1,0)+ IF( SELF.Diff_radio,1,0)+ IF( SELF.Diff_optional_radio1,1,0)+ IF( SELF.Diff_optional_radio2,1,0)+ IF( SELF.Diff_transmission,1,0)+ IF( SELF.Diff_optional_transmission1,1,0)+ IF( SELF.Diff_optional_transmission2,1,0)+ IF( SELF.Diff_anti_lock_brakes,1,0)+ IF( SELF.Diff_security_system,1,0)+ IF( SELF.Diff_daytime_running_lights,1,0)+ IF( SELF.Diff_visrap,1,0)+ IF( SELF.Diff_cab_configuration,1,0)+ IF( SELF.Diff_front_axle_code,1,0)+ IF( SELF.Diff_rear_axle_code,1,0)+ IF( SELF.Diff_brakes_code,1,0)+ IF( SELF.Diff_engine_manufacturer,1,0)+ IF( SELF.Diff_engine_model,1,0)+ IF( SELF.Diff_engine_type_code,1,0)+ IF( SELF.Diff_trailer_body_style,1,0)+ IF( SELF.Diff_trailer_number_of_axles,1,0)+ IF( SELF.Diff_trailer_length,1,0)+ IF( SELF.Diff_proactive_vin,1,0)+ IF( SELF.Diff_ma_state_exceptions,1,0)+ IF( SELF.Diff_filler_1,1,0)+ IF( SELF.Diff_series_abbreviation,1,0)+ IF( SELF.Diff_vin_pattern,1,0)+ IF( SELF.Diff_ncic_data,1,0)+ IF( SELF.Diff_full_body_style_name,1,0)+ IF( SELF.Diff_nvpp_make_code,1,0)+ IF( SELF.Diff_nvpp_make_abbreviation,1,0)+ IF( SELF.Diff_nvpp_series_model,1,0)+ IF( SELF.Diff_nvpp_series_name,1,0)+ IF( SELF.Diff_segmentation_code,1,0)+ IF( SELF.Diff_country_of_origin,1,0)+ IF( SELF.Diff_engine_liter_information,1,0)+ IF( SELF.Diff_engine_information_filler1,1,0)+ IF( SELF.Diff_engine_information_block_type,1,0)+ IF( SELF.Diff_engine_information_cylinders,1,0)+ IF( SELF.Diff_engine_information_filler2,1,0)+ IF( SELF.Diff_engine_information_carburetion,1,0)+ IF( SELF.Diff_engine_information_filler3,1,0)+ IF( SELF.Diff_engine_information_head_configuration,1,0)+ IF( SELF.Diff_engine_information_filler4,1,0)+ IF( SELF.Diff_engine_information_total_valves,1,0)+ IF( SELF.Diff_engine_information_filler5,1,0)+ IF( SELF.Diff_engine_information_aspiration_code,1,0)+ IF( SELF.Diff_engine_information_carburetion_code,1,0)+ IF( SELF.Diff_engine_information_valves_per_cylinder,1,0)+ IF( SELF.Diff_transmission_speed,1,0)+ IF( SELF.Diff_transmission_filler1,1,0)+ IF( SELF.Diff_transmission_type,1,0)+ IF( SELF.Diff_transmission_filler2,1,0)+ IF( SELF.Diff_transmission_code,1,0)+ IF( SELF.Diff_transmission_filler3,1,0)+ IF( SELF.Diff_transmission_speed_code,1,0)+ IF( SELF.Diff_base_model,1,0)+ IF( SELF.Diff_complete_prefix_file_id,1,0)+ IF( SELF.Diff_series_name_full_spelling,1,0)+ IF( SELF.Diff_vis_theft_code,1,0)+ IF( SELF.Diff_base_list_price_expanded,1,0)+ IF( SELF.Diff_default_nada_vehicle_id,1,0)+ IF( SELF.Diff_default_nada_model,1,0)+ IF( SELF.Diff_default_nada_body_style,1,0)+ IF( SELF.Diff_default_nada_msrp,1,0)+ IF( SELF.Diff_default_nada_gvwr,1,0)+ IF( SELF.Diff_default_nada_gcwr,1,0)+ IF( SELF.Diff_alt_1_nada_vehicle_id,1,0)+ IF( SELF.Diff_alt_1_nada_model,1,0)+ IF( SELF.Diff_alt_1_nada_body_style,1,0)+ IF( SELF.Diff_alt_1_nada_msrp,1,0)+ IF( SELF.Diff_alt_1_nada_gvwr,1,0)+ IF( SELF.Diff_alt_1_nada_gcwr,1,0)+ IF( SELF.Diff_alt_2_nada_vehicle_id,1,0)+ IF( SELF.Diff_alt_2_nada_model,1,0)+ IF( SELF.Diff_alt_2_nada_body_style,1,0)+ IF( SELF.Diff_alt_2_nada_msrp,1,0)+ IF( SELF.Diff_alt_2_nada_gvwr,1,0)+ IF( SELF.Diff_alt_2_nada_gcwr,1,0)+ IF( SELF.Diff_alt_3_nada_vehicle_id,1,0)+ IF( SELF.Diff_alt_3_nada_model,1,0)+ IF( SELF.Diff_alt_3_nada_body_style,1,0)+ IF( SELF.Diff_alt_3_nada_msrp,1,0)+ IF( SELF.Diff_alt_3_nada_gvwr,1,0)+ IF( SELF.Diff_alt_3_nada_gcwr,1,0)+ IF( SELF.Diff_alt_4_nada_vehicle_id,1,0)+ IF( SELF.Diff_alt_4_nada_model,1,0)+ IF( SELF.Diff_alt_4_nada_body_style,1,0)+ IF( SELF.Diff_alt_4_nada_msrp,1,0)+ IF( SELF.Diff_alt_4_nada_gvwr,1,0)+ IF( SELF.Diff_alt_4_nada_gcwr,1,0)+ IF( SELF.Diff_alt_5_nada_vehicle_id,1,0)+ IF( SELF.Diff_alt_5_nada_model,1,0)+ IF( SELF.Diff_alt_5_nada_body_style,1,0)+ IF( SELF.Diff_alt_5_nada_msrp,1,0)+ IF( SELF.Diff_alt_5_nada_gvwr,1,0)+ IF( SELF.Diff_alt_5_nada_gcwr,1,0)+ IF( SELF.Diff_alt_6_nada_vehicle_id,1,0)+ IF( SELF.Diff_alt_6_nada_model,1,0)+ IF( SELF.Diff_alt_6_nada_body_style,1,0)+ IF( SELF.Diff_alt_6_nada_msrp,1,0)+ IF( SELF.Diff_alt_6_nada_gvwr,1,0)+ IF( SELF.Diff_alt_6_nada_gcwr,1,0)+ IF( SELF.Diff_alt_7_nada_vehicle_id,1,0)+ IF( SELF.Diff_alt_7_nada_model,1,0)+ IF( SELF.Diff_alt_7_nada_body_style,1,0)+ IF( SELF.Diff_alt_7_nada_msrp,1,0)+ IF( SELF.Diff_alt_7_nada_gvwr,1,0)+ IF( SELF.Diff_alt_7_nada_gcwr,1,0)+ IF( SELF.Diff_aaia_codes,1,0)+ IF( SELF.Diff_incomplete_vehicle_flag,1,0)+ IF( SELF.Diff_filler2,1,0)+ IF( SELF.Diff_electric_battery_info_type,1,0)+ IF( SELF.Diff_filler3,1,0)+ IF( SELF.Diff_electric_battery_kilowatts,1,0)+ IF( SELF.Diff_filler4,1,0)+ IF( SELF.Diff_electric_battery_volts,1,0)+ IF( SELF.Diff_filler5,1,0)+ IF( SELF.Diff_engine_info_proprietary_engine_brand,1,0)+ IF( SELF.Diff_filler6,1,0)+ IF( SELF.Diff_engine_info_high_output_engine,1,0)+ IF( SELF.Diff_engine_info_supercharged,1,0)+ IF( SELF.Diff_engine_info_turbocharged,1,0)+ IF( SELF.Diff_engine_info_vvtl,1,0)+ IF( SELF.Diff_iso_liability,1,0)+ IF( SELF.Diff_series_name_condensed,1,0)+ IF( SELF.Diff_aces_data,1,0)+ IF( SELF.Diff_base_shipping_weight_expanded,1,0)+ IF( SELF.Diff_filler7,1,0)+ IF( SELF.Diff_customer_defined_data,1,0);
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
    Count_Diff_match_make := COUNT(GROUP,%Closest%.Diff_match_make);
    Count_Diff_match_year := COUNT(GROUP,%Closest%.Diff_match_year);
    Count_Diff_match_vin := COUNT(GROUP,%Closest%.Diff_match_vin);
    Count_Diff_make_abbreviation := COUNT(GROUP,%Closest%.Diff_make_abbreviation);
    Count_Diff_model_year := COUNT(GROUP,%Closest%.Diff_model_year);
    Count_Diff_vehicle_type := COUNT(GROUP,%Closest%.Diff_vehicle_type);
    Count_Diff_make_name := COUNT(GROUP,%Closest%.Diff_make_name);
    Count_Diff_series_name := COUNT(GROUP,%Closest%.Diff_series_name);
    Count_Diff_body_type := COUNT(GROUP,%Closest%.Diff_body_type);
    Count_Diff_wheels := COUNT(GROUP,%Closest%.Diff_wheels);
    Count_Diff_displacement := COUNT(GROUP,%Closest%.Diff_displacement);
    Count_Diff_cylinders := COUNT(GROUP,%Closest%.Diff_cylinders);
    Count_Diff_fuel := COUNT(GROUP,%Closest%.Diff_fuel);
    Count_Diff_carburetion := COUNT(GROUP,%Closest%.Diff_carburetion);
    Count_Diff_gvw := COUNT(GROUP,%Closest%.Diff_gvw);
    Count_Diff_wheel_base := COUNT(GROUP,%Closest%.Diff_wheel_base);
    Count_Diff_tire_size := COUNT(GROUP,%Closest%.Diff_tire_size);
    Count_Diff_ton_rating := COUNT(GROUP,%Closest%.Diff_ton_rating);
    Count_Diff_base_shipping_weight := COUNT(GROUP,%Closest%.Diff_base_shipping_weight);
    Count_Diff_variance_weight := COUNT(GROUP,%Closest%.Diff_variance_weight);
    Count_Diff_base_list_price := COUNT(GROUP,%Closest%.Diff_base_list_price);
    Count_Diff_price_variance := COUNT(GROUP,%Closest%.Diff_price_variance);
    Count_Diff_high_performance_code := COUNT(GROUP,%Closest%.Diff_high_performance_code);
    Count_Diff_driving_wheels := COUNT(GROUP,%Closest%.Diff_driving_wheels);
    Count_Diff_iso_physical_damage := COUNT(GROUP,%Closest%.Diff_iso_physical_damage);
    Count_Diff_location_indicator := COUNT(GROUP,%Closest%.Diff_location_indicator);
    Count_Diff_air_conditioning := COUNT(GROUP,%Closest%.Diff_air_conditioning);
    Count_Diff_power_steering := COUNT(GROUP,%Closest%.Diff_power_steering);
    Count_Diff_power_brakes := COUNT(GROUP,%Closest%.Diff_power_brakes);
    Count_Diff_power_windows := COUNT(GROUP,%Closest%.Diff_power_windows);
    Count_Diff_tilt_wheel := COUNT(GROUP,%Closest%.Diff_tilt_wheel);
    Count_Diff_roof := COUNT(GROUP,%Closest%.Diff_roof);
    Count_Diff_optional_roof1 := COUNT(GROUP,%Closest%.Diff_optional_roof1);
    Count_Diff_optional_roof2 := COUNT(GROUP,%Closest%.Diff_optional_roof2);
    Count_Diff_radio := COUNT(GROUP,%Closest%.Diff_radio);
    Count_Diff_optional_radio1 := COUNT(GROUP,%Closest%.Diff_optional_radio1);
    Count_Diff_optional_radio2 := COUNT(GROUP,%Closest%.Diff_optional_radio2);
    Count_Diff_transmission := COUNT(GROUP,%Closest%.Diff_transmission);
    Count_Diff_optional_transmission1 := COUNT(GROUP,%Closest%.Diff_optional_transmission1);
    Count_Diff_optional_transmission2 := COUNT(GROUP,%Closest%.Diff_optional_transmission2);
    Count_Diff_anti_lock_brakes := COUNT(GROUP,%Closest%.Diff_anti_lock_brakes);
    Count_Diff_security_system := COUNT(GROUP,%Closest%.Diff_security_system);
    Count_Diff_daytime_running_lights := COUNT(GROUP,%Closest%.Diff_daytime_running_lights);
    Count_Diff_visrap := COUNT(GROUP,%Closest%.Diff_visrap);
    Count_Diff_cab_configuration := COUNT(GROUP,%Closest%.Diff_cab_configuration);
    Count_Diff_front_axle_code := COUNT(GROUP,%Closest%.Diff_front_axle_code);
    Count_Diff_rear_axle_code := COUNT(GROUP,%Closest%.Diff_rear_axle_code);
    Count_Diff_brakes_code := COUNT(GROUP,%Closest%.Diff_brakes_code);
    Count_Diff_engine_manufacturer := COUNT(GROUP,%Closest%.Diff_engine_manufacturer);
    Count_Diff_engine_model := COUNT(GROUP,%Closest%.Diff_engine_model);
    Count_Diff_engine_type_code := COUNT(GROUP,%Closest%.Diff_engine_type_code);
    Count_Diff_trailer_body_style := COUNT(GROUP,%Closest%.Diff_trailer_body_style);
    Count_Diff_trailer_number_of_axles := COUNT(GROUP,%Closest%.Diff_trailer_number_of_axles);
    Count_Diff_trailer_length := COUNT(GROUP,%Closest%.Diff_trailer_length);
    Count_Diff_proactive_vin := COUNT(GROUP,%Closest%.Diff_proactive_vin);
    Count_Diff_ma_state_exceptions := COUNT(GROUP,%Closest%.Diff_ma_state_exceptions);
    Count_Diff_filler_1 := COUNT(GROUP,%Closest%.Diff_filler_1);
    Count_Diff_series_abbreviation := COUNT(GROUP,%Closest%.Diff_series_abbreviation);
    Count_Diff_vin_pattern := COUNT(GROUP,%Closest%.Diff_vin_pattern);
    Count_Diff_ncic_data := COUNT(GROUP,%Closest%.Diff_ncic_data);
    Count_Diff_full_body_style_name := COUNT(GROUP,%Closest%.Diff_full_body_style_name);
    Count_Diff_nvpp_make_code := COUNT(GROUP,%Closest%.Diff_nvpp_make_code);
    Count_Diff_nvpp_make_abbreviation := COUNT(GROUP,%Closest%.Diff_nvpp_make_abbreviation);
    Count_Diff_nvpp_series_model := COUNT(GROUP,%Closest%.Diff_nvpp_series_model);
    Count_Diff_nvpp_series_name := COUNT(GROUP,%Closest%.Diff_nvpp_series_name);
    Count_Diff_segmentation_code := COUNT(GROUP,%Closest%.Diff_segmentation_code);
    Count_Diff_country_of_origin := COUNT(GROUP,%Closest%.Diff_country_of_origin);
    Count_Diff_engine_liter_information := COUNT(GROUP,%Closest%.Diff_engine_liter_information);
    Count_Diff_engine_information_filler1 := COUNT(GROUP,%Closest%.Diff_engine_information_filler1);
    Count_Diff_engine_information_block_type := COUNT(GROUP,%Closest%.Diff_engine_information_block_type);
    Count_Diff_engine_information_cylinders := COUNT(GROUP,%Closest%.Diff_engine_information_cylinders);
    Count_Diff_engine_information_filler2 := COUNT(GROUP,%Closest%.Diff_engine_information_filler2);
    Count_Diff_engine_information_carburetion := COUNT(GROUP,%Closest%.Diff_engine_information_carburetion);
    Count_Diff_engine_information_filler3 := COUNT(GROUP,%Closest%.Diff_engine_information_filler3);
    Count_Diff_engine_information_head_configuration := COUNT(GROUP,%Closest%.Diff_engine_information_head_configuration);
    Count_Diff_engine_information_filler4 := COUNT(GROUP,%Closest%.Diff_engine_information_filler4);
    Count_Diff_engine_information_total_valves := COUNT(GROUP,%Closest%.Diff_engine_information_total_valves);
    Count_Diff_engine_information_filler5 := COUNT(GROUP,%Closest%.Diff_engine_information_filler5);
    Count_Diff_engine_information_aspiration_code := COUNT(GROUP,%Closest%.Diff_engine_information_aspiration_code);
    Count_Diff_engine_information_carburetion_code := COUNT(GROUP,%Closest%.Diff_engine_information_carburetion_code);
    Count_Diff_engine_information_valves_per_cylinder := COUNT(GROUP,%Closest%.Diff_engine_information_valves_per_cylinder);
    Count_Diff_transmission_speed := COUNT(GROUP,%Closest%.Diff_transmission_speed);
    Count_Diff_transmission_filler1 := COUNT(GROUP,%Closest%.Diff_transmission_filler1);
    Count_Diff_transmission_type := COUNT(GROUP,%Closest%.Diff_transmission_type);
    Count_Diff_transmission_filler2 := COUNT(GROUP,%Closest%.Diff_transmission_filler2);
    Count_Diff_transmission_code := COUNT(GROUP,%Closest%.Diff_transmission_code);
    Count_Diff_transmission_filler3 := COUNT(GROUP,%Closest%.Diff_transmission_filler3);
    Count_Diff_transmission_speed_code := COUNT(GROUP,%Closest%.Diff_transmission_speed_code);
    Count_Diff_base_model := COUNT(GROUP,%Closest%.Diff_base_model);
    Count_Diff_complete_prefix_file_id := COUNT(GROUP,%Closest%.Diff_complete_prefix_file_id);
    Count_Diff_series_name_full_spelling := COUNT(GROUP,%Closest%.Diff_series_name_full_spelling);
    Count_Diff_vis_theft_code := COUNT(GROUP,%Closest%.Diff_vis_theft_code);
    Count_Diff_base_list_price_expanded := COUNT(GROUP,%Closest%.Diff_base_list_price_expanded);
    Count_Diff_default_nada_vehicle_id := COUNT(GROUP,%Closest%.Diff_default_nada_vehicle_id);
    Count_Diff_default_nada_model := COUNT(GROUP,%Closest%.Diff_default_nada_model);
    Count_Diff_default_nada_body_style := COUNT(GROUP,%Closest%.Diff_default_nada_body_style);
    Count_Diff_default_nada_msrp := COUNT(GROUP,%Closest%.Diff_default_nada_msrp);
    Count_Diff_default_nada_gvwr := COUNT(GROUP,%Closest%.Diff_default_nada_gvwr);
    Count_Diff_default_nada_gcwr := COUNT(GROUP,%Closest%.Diff_default_nada_gcwr);
    Count_Diff_alt_1_nada_vehicle_id := COUNT(GROUP,%Closest%.Diff_alt_1_nada_vehicle_id);
    Count_Diff_alt_1_nada_model := COUNT(GROUP,%Closest%.Diff_alt_1_nada_model);
    Count_Diff_alt_1_nada_body_style := COUNT(GROUP,%Closest%.Diff_alt_1_nada_body_style);
    Count_Diff_alt_1_nada_msrp := COUNT(GROUP,%Closest%.Diff_alt_1_nada_msrp);
    Count_Diff_alt_1_nada_gvwr := COUNT(GROUP,%Closest%.Diff_alt_1_nada_gvwr);
    Count_Diff_alt_1_nada_gcwr := COUNT(GROUP,%Closest%.Diff_alt_1_nada_gcwr);
    Count_Diff_alt_2_nada_vehicle_id := COUNT(GROUP,%Closest%.Diff_alt_2_nada_vehicle_id);
    Count_Diff_alt_2_nada_model := COUNT(GROUP,%Closest%.Diff_alt_2_nada_model);
    Count_Diff_alt_2_nada_body_style := COUNT(GROUP,%Closest%.Diff_alt_2_nada_body_style);
    Count_Diff_alt_2_nada_msrp := COUNT(GROUP,%Closest%.Diff_alt_2_nada_msrp);
    Count_Diff_alt_2_nada_gvwr := COUNT(GROUP,%Closest%.Diff_alt_2_nada_gvwr);
    Count_Diff_alt_2_nada_gcwr := COUNT(GROUP,%Closest%.Diff_alt_2_nada_gcwr);
    Count_Diff_alt_3_nada_vehicle_id := COUNT(GROUP,%Closest%.Diff_alt_3_nada_vehicle_id);
    Count_Diff_alt_3_nada_model := COUNT(GROUP,%Closest%.Diff_alt_3_nada_model);
    Count_Diff_alt_3_nada_body_style := COUNT(GROUP,%Closest%.Diff_alt_3_nada_body_style);
    Count_Diff_alt_3_nada_msrp := COUNT(GROUP,%Closest%.Diff_alt_3_nada_msrp);
    Count_Diff_alt_3_nada_gvwr := COUNT(GROUP,%Closest%.Diff_alt_3_nada_gvwr);
    Count_Diff_alt_3_nada_gcwr := COUNT(GROUP,%Closest%.Diff_alt_3_nada_gcwr);
    Count_Diff_alt_4_nada_vehicle_id := COUNT(GROUP,%Closest%.Diff_alt_4_nada_vehicle_id);
    Count_Diff_alt_4_nada_model := COUNT(GROUP,%Closest%.Diff_alt_4_nada_model);
    Count_Diff_alt_4_nada_body_style := COUNT(GROUP,%Closest%.Diff_alt_4_nada_body_style);
    Count_Diff_alt_4_nada_msrp := COUNT(GROUP,%Closest%.Diff_alt_4_nada_msrp);
    Count_Diff_alt_4_nada_gvwr := COUNT(GROUP,%Closest%.Diff_alt_4_nada_gvwr);
    Count_Diff_alt_4_nada_gcwr := COUNT(GROUP,%Closest%.Diff_alt_4_nada_gcwr);
    Count_Diff_alt_5_nada_vehicle_id := COUNT(GROUP,%Closest%.Diff_alt_5_nada_vehicle_id);
    Count_Diff_alt_5_nada_model := COUNT(GROUP,%Closest%.Diff_alt_5_nada_model);
    Count_Diff_alt_5_nada_body_style := COUNT(GROUP,%Closest%.Diff_alt_5_nada_body_style);
    Count_Diff_alt_5_nada_msrp := COUNT(GROUP,%Closest%.Diff_alt_5_nada_msrp);
    Count_Diff_alt_5_nada_gvwr := COUNT(GROUP,%Closest%.Diff_alt_5_nada_gvwr);
    Count_Diff_alt_5_nada_gcwr := COUNT(GROUP,%Closest%.Diff_alt_5_nada_gcwr);
    Count_Diff_alt_6_nada_vehicle_id := COUNT(GROUP,%Closest%.Diff_alt_6_nada_vehicle_id);
    Count_Diff_alt_6_nada_model := COUNT(GROUP,%Closest%.Diff_alt_6_nada_model);
    Count_Diff_alt_6_nada_body_style := COUNT(GROUP,%Closest%.Diff_alt_6_nada_body_style);
    Count_Diff_alt_6_nada_msrp := COUNT(GROUP,%Closest%.Diff_alt_6_nada_msrp);
    Count_Diff_alt_6_nada_gvwr := COUNT(GROUP,%Closest%.Diff_alt_6_nada_gvwr);
    Count_Diff_alt_6_nada_gcwr := COUNT(GROUP,%Closest%.Diff_alt_6_nada_gcwr);
    Count_Diff_alt_7_nada_vehicle_id := COUNT(GROUP,%Closest%.Diff_alt_7_nada_vehicle_id);
    Count_Diff_alt_7_nada_model := COUNT(GROUP,%Closest%.Diff_alt_7_nada_model);
    Count_Diff_alt_7_nada_body_style := COUNT(GROUP,%Closest%.Diff_alt_7_nada_body_style);
    Count_Diff_alt_7_nada_msrp := COUNT(GROUP,%Closest%.Diff_alt_7_nada_msrp);
    Count_Diff_alt_7_nada_gvwr := COUNT(GROUP,%Closest%.Diff_alt_7_nada_gvwr);
    Count_Diff_alt_7_nada_gcwr := COUNT(GROUP,%Closest%.Diff_alt_7_nada_gcwr);
    Count_Diff_aaia_codes := COUNT(GROUP,%Closest%.Diff_aaia_codes);
    Count_Diff_incomplete_vehicle_flag := COUNT(GROUP,%Closest%.Diff_incomplete_vehicle_flag);
    Count_Diff_filler2 := COUNT(GROUP,%Closest%.Diff_filler2);
    Count_Diff_electric_battery_info_type := COUNT(GROUP,%Closest%.Diff_electric_battery_info_type);
    Count_Diff_filler3 := COUNT(GROUP,%Closest%.Diff_filler3);
    Count_Diff_electric_battery_kilowatts := COUNT(GROUP,%Closest%.Diff_electric_battery_kilowatts);
    Count_Diff_filler4 := COUNT(GROUP,%Closest%.Diff_filler4);
    Count_Diff_electric_battery_volts := COUNT(GROUP,%Closest%.Diff_electric_battery_volts);
    Count_Diff_filler5 := COUNT(GROUP,%Closest%.Diff_filler5);
    Count_Diff_engine_info_proprietary_engine_brand := COUNT(GROUP,%Closest%.Diff_engine_info_proprietary_engine_brand);
    Count_Diff_filler6 := COUNT(GROUP,%Closest%.Diff_filler6);
    Count_Diff_engine_info_high_output_engine := COUNT(GROUP,%Closest%.Diff_engine_info_high_output_engine);
    Count_Diff_engine_info_supercharged := COUNT(GROUP,%Closest%.Diff_engine_info_supercharged);
    Count_Diff_engine_info_turbocharged := COUNT(GROUP,%Closest%.Diff_engine_info_turbocharged);
    Count_Diff_engine_info_vvtl := COUNT(GROUP,%Closest%.Diff_engine_info_vvtl);
    Count_Diff_iso_liability := COUNT(GROUP,%Closest%.Diff_iso_liability);
    Count_Diff_series_name_condensed := COUNT(GROUP,%Closest%.Diff_series_name_condensed);
    Count_Diff_aces_data := COUNT(GROUP,%Closest%.Diff_aces_data);
    Count_Diff_base_shipping_weight_expanded := COUNT(GROUP,%Closest%.Diff_base_shipping_weight_expanded);
    Count_Diff_filler7 := COUNT(GROUP,%Closest%.Diff_filler7);
    Count_Diff_customer_defined_data := COUNT(GROUP,%Closest%.Diff_customer_defined_data);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
