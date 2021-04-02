IMPORT LN_PropertyV2;

EXPORT verify_fakeid_are_unique := FUNCTION

  kfullkey := INDEX(LN_PropertyV2.Key_Property_Payload,'~thor_data400::key::ln_propertyv2::autokey::payload_qa');
  kdeltakey := INDEX(LN_PropertyV2.Key_Property_Payload,'~thor_data400::key::property_fast::autokey::payload_qa');

  dups_fakeid := JOIN(kfullkey,kdeltakey,LEFT.fakeid=RIGHT.fakeid);

  dup_count := COUNT(dups_fakeid);

  there_are_no_dups := dup_count = 0;

  ifdups := if(~there_are_no_dups, OUTPUT(CHOOSEN(dups_fakeid, 1000), NAMED('Duplicate_autokey_payload_fakeids_sample')));

  RETURN SEQUENTIAL(ifdups,ASSERT(there_are_no_dups, 'autokey_payload_fakeids_are_not_unique', FAIL));

END;
