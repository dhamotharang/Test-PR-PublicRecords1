EXPORT constants := MODULE
  
  EXPORT ak_keyname := $.names().i_ak_payload;
  EXPORT ak_dataset := DATASET([], $.layouts.ak_rec);
  EXPORT ak_skipSet := ['P','Q','S','F'];
  EXPORT ak_typeStr := '\'AK\'';
  
END;
