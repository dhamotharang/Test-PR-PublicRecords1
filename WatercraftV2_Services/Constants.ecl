IMPORT data_services;

EXPORT Constants(STRING filedate) := MODULE
  // autokey
  EXPORT ak_keyname := Data_services.Data_location.prefix('Watercraft') + 'thor_data400::' + 'key::watercraft::autokey::';
  EXPORT ak_logical := Data_services.Data_location.prefix('Watercraft') + 'thor_data400::' + 'key::watercraft::' + filedate + '::autokey::';
  EXPORT ak_typeStr := 'VESS';
  
  // autokey for BIDs
  EXPORT ak_keyname_bid := Data_services.Data_location.prefix('Watercraft') + 'thor_data400::' + 'key::watercraft::autokey::bid::';
  EXPORT ak_logical_bid := Data_services.Data_location.prefix('Watercraft') + 'thor_data400::' + 'key::watercraft::' + filedate + '::autokey::bid::';
  EXPORT ak_typeStr_bid := 'VESS';
  
  // boolean search
  EXPORT STRING stem := Data_services.Data_location.prefix('Watercraft') + 'thor_data400';
  EXPORT STRING srcType := 'WATERCRAFT';
  EXPORT STRING qual := 'test';
  
END;
