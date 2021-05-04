IMPORT $;

EXPORT Constants := MODULE

//***************************************************************
//           autokeys constants for Fraud Defense Network
//***************************************************************
  EXPORT ak_keyname := $.Names.KEY_AUTOKEY_PREFIX; 
  EXPORT ak_dataset := DATASET([], $.Layouts.autokey_payload);   
	
  EXPORT ak_skipSet := ['N', 'T', 'J', 'M', 'U', 'Y', 'W'];
   //N in this set to skip Indv Name
   //T in this set to skip Indv StName
   //J in this set to skip Biz CityStName
   //M in this set to skip Biz Name
   //U in this set to skip Biz StName
   //Y in this set to skip Biz Zip
   //W in this set to skip Biz NameWords
  EXPORT ak_typeStr := '\'AK\''; 
	
END;
