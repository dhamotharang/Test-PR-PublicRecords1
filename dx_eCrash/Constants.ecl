IMPORT $;

EXPORT Constants := MODULE

//***************************************************************
//           autokeys constants for eCrashV2
//***************************************************************
  EXPORT ak_keyname := $.Names.KEY_AUTOKEY_PREFIX; 
  EXPORT ak_dataset := DATASET([], $.Layouts.autokey_payload);   
  EXPORT ak_skipSet := ['P','Q','S','F'];
   //P in this set to skip personal phones
   //Q in this set to skip business phones
   //S in this set to skip SSN
   //F in this set to skip FEIN
   //C in this set to skip ALL personal (Contact) data
   //B in this set to skip ALL Business data
  EXPORT ak_typeStr := '\'AK\''; 
END;
