IMPORT AutoStandardI, doxie,progressive_phone, addrbest;

EXPORT fn_WaterfallPhonesLookup(DATASET(doxie.layout_references_hh) dids,
                                    mod_Params.PersonSearch in_mod) := FUNCTION
                                    
    DIDsIn := PROJECT(dids , TRANSFORM(progressive_phone.layout_progressive_batch_in,
      SELF.did := LEFT.did,
      SELF.acctno := (STRING)LEFT.did,
      SELF := [] ));
                        
      
    ParamsDid :=
      MODULE(PROJECT(in_mod ,progressive_phone.iParam.Batch, opt))
        EXPORT BOOLEAN SkipPhoneScoring := FALSE;
        EXPORT BOOLEAN DedupInputPhones := FALSE;
        EXPORT BOOLEAN KeepAllPhones := FALSE;

          EXPORT BOOLEAN NameMatch := FALSE;
          EXPORT BOOLEAN StreetAddressMatch := FALSE;
        EXPORT BOOLEAN CityMatch := FALSE;
        EXPORT BOOLEAN StateMatch := FALSE;
        EXPORT BOOLEAN ZipMatch := FALSE;
        EXPORT BOOLEAN SSNMatch := FALSE;
        EXPORT BOOLEAN DIDMatch := TRUE;
      END;
      
    dsPhones_dids := addrbest.Progressive_phone_common(
                            DIDsIn, ParamsDid,,,FALSE , TRUE,FALSE ,FALSE ,in_mod.PhoneScoreModel,
                            0,0,0,0,0,0,in_mod.MaxNumPhoneSubject,0,FALSE);

    /*
       dsPhones := project(dsPhones_dids_pre ,
                   transform(doxie.layout_presentation,
                   self.did := left.did,
                   self.dt_first_seen := (integer)left.subj_date_first,
                   self.dt_last_seen := (integer)left.subj_date_last,
                   self.dt_vendor_last_reported := (integer)left.subj_date_first,
                   self.dt_vendor_first_reported := (integer)left.subj_date_last,
                   self.phone := left.subj_phone10,
                   self.ssn := left.ssn,
                   self.fname := left.subj_first,
                   self.mname := left.subj_middle,
                   self.lname := left.subj_last,
                   self.name_suffix := left.subj_suffix,
                   self.prim_range := left.prim_range,
                   self.predir := left.predir,
                   self.prim_name := left.prim_name,
                   self.suffix := left.addr_suffix,
                   self.postdir := left.postdir,
                   self.unit_desig := left.unit_desig,
                   self.sec_range := left.sec_range,
                   self.city_name := left.p_city_name,
                   self.st := left.st,
                   self.zip := left.zip5,
                   self.listed_name := left.subj_name_dual,
                   self.new_type := left.subj_phone_type_new,
                   self.carrier := left.phpl_phone_carrier,
                   self.carrier_city := left.phpl_carrier_city,
                   self.carrier_state := left.phpl_carrier_state,
                   self.phonetype := left.phpl_phones_plus_type,
                   self.phone_last_seen := (integer) left.subj_phone_date_last,
                   self.listed_timezone := left.subj_phone_possible_timezone,
                   self.listed_name_first := left.p_name_first,
                   self.listed_name_last := left.p_name_last,
                   self := [] ));
    */

 
  rec_phone_temp := RECORD
    UNSIGNED6 DID;
    DATASET({STRING30 Phone10}) Phones;
  END;
  
  dsPhones_pre := PROJECT(dsPhones_dids,TRANSFORM(rec_phone_temp,
                    SELF.did := LEFT.did, SELF.Phones := DATASET([{LEFT.subj_phone10}],{STRING30 Phone10})));
   
   dsPhones := ROLLUP(SORT(dsPhones_pre,did),LEFT.did = RIGHT.did,
                               TRANSFORM(rec_phone_temp,
                                      SELF.Did := LEFT.Did,
                                      SELF.Phones := LEFT.Phones + RIGHT.Phones;
                                      
                                      ));
   
   
#IF(Debug.debug_flag) OUTPUT(dsPhones,NAMED('dsPhones'));
  OUTPUT(in_mod.PhoneScoreModel,NAMED('PhoneScoreModel'));
#END

RETURN dsPhones;
END;
