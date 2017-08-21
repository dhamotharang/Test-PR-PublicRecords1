

Layout_additional_information_Offender_key := Layout_additional_information_cp;

Layout_additional_information_Offender_key tr_generate_adin_id_key(MapOffenderToAdditionalInformation L, INTEGER C) := TRANSFORM
SELF.ADIN_ID := C;
SELF := L;
END;

ds_add_info_with_adin_key := PROJECT(MapOffenderToAdditionalInformation,tr_generate_adin_id_key(LEFT,COUNTER));

export MapCreateAddInfoKeys :=  SORT(ds_add_info_with_adin_key,ecl_cade_id);