IMPORT PRTE2_infutor_cid, PRTE2_Common, PhonesPlus_V2, CellPhone, Address, ut, doxie, autokey, Data_Services;

EXPORT Files := MODULE

   //Input Files   
   EXPORT Alpharetta_base_in := DATASET(PRTE2_Common.Cross_Module_Files.PhonesPlus_Base_SF_Name, 
                                        PRTE2_infutor_cid.Layouts.Alpha_CSV_Layout, THOR);
   
   EXPORT Boca_GE_in := DATASET(PRTE2_Infutor_CID.Constants.IN_PREFIX + 'boca::ge', 
                                PRTE2_infutor_cid.Layouts.Base_in, 
                                CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')),opt);
   
   EXPORT PhonesHist_in := DATASET(PRTE2_Infutor_CID.Constants.IN_PREFIX + 'boca::hist', 
                                   PRTE2_infutor_cid.Layouts.Base_common, 
                                   CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')),opt);

   //Base File   
   EXPORT f_phonesplus_ext := DATASET(PRTE2_Infutor_CID.Constants.BASE_PREFIX + 'base_all', PRTE2_infutor_cid.Layouts.Base_ext, THOR);
   EXPORT f_phonesplus := PROJECT(f_phonesplus_ext, PRTE2_infutor_cid.Layouts.Layout_Phonesplus_Base);
   EXPORT fphonesplus_did := sort(f_phonesplus((unsigned)did<>0, (unsigned)cellphone<>0), did);
                                                         
   //prte::key::infutorcid::did and prte_fcra::key::infutorcid::did   
   EXPORT key_did(STRING FILEDATE) := FUNCTION;

            Infutor_did := PROJECT(fphonesplus_did, transform(PRTE2_infutor_cid.layouts.DID_key,
                                                              self.persistent_record_id := filedate + '_' + (string)intformat(counter, 10,1),
                                                              SELF.phone := LEFT.cellphone,
                                                              SELF.zip := LEFT.Zip5,
                                                              SELF.st := LEFT.state,
                                                              SELF.county := LEFT.ace_fips_county,
                                                              SELF.dt_first_seen := LEFT.datefirstseen,
                                                              SELF.dt_last_seen := LEFT.datelastseen,
                                                              SELF := LEFT,
                                                              SELF := []));
                                                                  
            PRTE2_Infutor_CID.layouts.did_key into_slim(infutor_did le) := 
                                                                           transform
                                                                               self := le;
                                                                           end;                                                         
            p1 := dedup(sort(project(infutor_did, into_slim(left)), record, except persistent_record_id, local), 
                                                                    record, except persistent_record_id,local);
      
   RETURN P1;
   END;
   
   
   //prte::key::infutorcid::phone and prte_fcra::key::infutorcid::phone
   EXPORT key_Phone(STRING FILEDATE) := FUNCTION;
   
            Infutor_phone := PROJECT(fphonesplus_did, transform(PRTE2_infutor_cid.layouts.Phone_key,
                                                                self.persistent_record_id := filedate + '_' + (string)intformat(counter, 10,1),
                                                                SELF.phone := LEFT.cellphone,
                                                                SELF.zip := LEFT.Zip5,
                                                                SELF.st := LEFT.state,
                                                                SELF.county := LEFT.ace_fips_county,
                                                                SELF.dt_first_seen := LEFT.datefirstseen,
                                                                SELF.dt_last_seen := LEFT.datelastseen,
                                                                SELF := LEFT,
                                                                SELF := []));
                                                                  
            PRTE2_Infutor_CID.layouts.Phone_key into_slim(Infutor_phone le) := 
                                                                               transform
                                                                                   self := le;
                                                                               end;                                                         
            p2 := project(Infutor_phone, into_slim(left));
      
   RETURN P2;
   END;


END;