IMPORT PRTE2_infutor_cid, PRTE2_PhonesPlus, PRTE2_Common, PhonesPlus_V2, CellPhone, Address, ut, doxie, autokey, Data_Services;

// EXPORT Files (STRING FILEDATE) := MODULE
EXPORT Files := MODULE

   //Input Files   
   EXPORT IN_PhonesPlus := dataset('~prte::base::phonesplusv2::base_all', PRTE2_infutor_cid.Layouts.phones_base, thor);
   
   //Base
   EXPORT Infutor_cid_Base := DATASET(PRTE2_infutor_cid.Constants.base, PRTE2_infutor_cid.layouts.Infutor_Base, thor);
   
   //prte::key::infutorcid::did and prte::key::infutorcid::fcra::phone
   EXPORT key_did := PROJECT(Infutor_cid_Base, transform(PRTE2_infutor_cid.layouts.DID_key,
                                                         SELF := LEFT,
                                                         SELF := []));
                                                                  
   //prte::key::infutorcid::phone and prte::key::infutorcid::fcra::phone
   EXPORT key_Phone := PROJECT(Infutor_cid_Base, transform(PRTE2_infutor_cid.layouts.Phone_key,
                                                           SELF := LEFT,                                                               
                                                           SELF := []));
                                                                  



END;