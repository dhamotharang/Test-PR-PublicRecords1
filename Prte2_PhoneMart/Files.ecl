IMPORT PRTE2_Common, ut, doxie, Data_Services;

// EXPORT Files (STRING FILEDATE) := MODULE
EXPORT Files := MODULE

   //Input File from PRTE_PhonesPlus   
   EXPORT IN_PhonesPlus := dataset('~prte::base::phonesplusv2::base_all', PRTE2_PhoneMart.Layouts.phones_base, thor);
   
   //Base
   EXPORT PhoneMart_Base := DATASET(PRTE2_PhoneMart.Constants.base, PRTE2_PhoneMart.layouts.PhoneMart_Base, thor);
   
   //prte::key::phonemart::did
   EXPORT file_did := dedup(PROJECT(PhoneMart_Base, transform(PRTE2_PhoneMart.layouts.DID_key,
                                                       SELF.l_did := LEFT.DID,                                                       
                                                       SELF := LEFT,
                                                       SELF := [])),record, all);
                                                                  
   //prte::key::phonemart::phone
   EXPORT file_Phone := dedup(PROJECT(PhoneMart_Base, transform(PRTE2_PhoneMart.layouts.Phone_key,
                                                         SELF := LEFT,                                                               
                                                         SELF := [])),record, all);
                                                                  



END;