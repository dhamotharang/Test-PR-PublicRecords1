IMPORT autokeyb2,doxie,ut,corp2,address,watercraft;

EXPORT proc_autokeybuild(STRING filedate) := FUNCTION

dis_watercraft :=DISTRIBUTE(watercraft.File_Base_search_Dev(watercraft_key <> ''),hash(watercraft_key));

layout_watercraft := RECORD
Watercraft.Layout_Watercraft_Search_Base;
  UNSIGNED6 ldid;
  UNSIGNED6 lbdid;
  STRING10 phone :='';
  UNSIGNED1 zero := 0;
  STRING25 city;
  STRING2 bstate :='';
  STRING25 bcity :='';
  STRING10 bphone :='';
  STRING10 bprim_range :='';
  STRING28 bprim_name :='';
  STRING8 bsec_range :='';
  STRING5 bzip5 :='';
  STRING9 fein_use :='';
  STRING9 ssn_use := '';
END;




layout_watercraft both_cities(Watercraft.Layout_Watercraft_Search_Base le,INTEGER C):=TRANSFORM
SELF.city :=CHOOSE(C,le.p_city_name,IF(le.v_city_name='' OR le.v_city_name=le.p_city_name,skip,le.v_city_name ));
SELF.ldid :=(UNSIGNED6) le.did;
SELF.lbdid :=(UNSIGNED6) le.bdid;
SELF :=le;
END;

//capture both city names
watercraft_both_cities :=normalize(dis_watercraft,2,both_cities(LEFT,COUNTER));


//capture all phones

layout_watercraft all_phones(layout_watercraft le,INTEGER C):=TRANSFORM
SELF.phone :=CHOOSE(C,le.phone_1,IF(le.phone_2='' OR le.phone_2=le.phone_1,skip,le.phone_2));
SELF :=le;
END;

watercraft_both_phones :=DEDUP(normalize(watercraft_both_cities,2, all_phones(LEFT,COUNTER)),RECORD,all,local );


layout_watercraft_use := RECORD
Watercraft.Layout_Watercraft_Search_Base.watercraft_key;
Watercraft.Layout_Watercraft_Search_Base.sequence_key;
Watercraft.Layout_Watercraft_Search_Base.state_origin;
Watercraft.Layout_Watercraft_Search_Base.fname;
Watercraft.Layout_Watercraft_Search_Base.lname;
Watercraft.Layout_Watercraft_Search_Base.mname;
Watercraft.Layout_Watercraft_Search_Base.dob;
Watercraft.Layout_Watercraft_Search_Base.prim_name;
Watercraft.Layout_Watercraft_Search_Base.prim_range;
Watercraft.Layout_Watercraft_Search_Base.st;
Watercraft.Layout_Watercraft_Search_Base.zip5;
Watercraft.Layout_Watercraft_Search_Base.sec_range;
Watercraft.Layout_Watercraft_Search_Base.company_name;
  UNSIGNED6 ldid;
  UNSIGNED6 lbdid;
  STRING10 phone :='';
  UNSIGNED1 zero := 0;
  STRING25 city;
  STRING2 bstate :='';
  STRING25 bcity :='';
  STRING10 bphone :='';
  STRING10 bprim_range :='';
  STRING28 bprim_name :='';
  STRING8 bsec_range :='';
  STRING5 bzip5 :='';
  STRING9 fein_use :='';
  STRING9 ssn_use := '';
END;

layout_watercraft_use w_bState(layout_watercraft le):=TRANSFORM
c :=le.company_name <> '';
SELF.fein_use :=IF(le.orig_fein <> '',le.orig_fein,le.fein);
SELF.ssn_use :=IF(le.orig_ssn <>'',le.orig_ssn,le.ssn);
SELF.bstate := IF(c,le.st,'');
SELF.bcity := IF(c,le.city,'');
SELF.bzip5 :=IF(c,le.zip5,'');
SELF.bprim_name := IF(c,le.prim_name,'');
SELF.bprim_range :=IF(c,le.prim_range,'');
SELF.bsec_range :=IF(c,le.sec_range,'');
SELF.bphone :=IF(c,le.phone,'');
SELF :=le;
END;

watercraft :=PROJECT(watercraft_both_phones,w_bState(LEFT));

persistname := '~thor_data400::' + 'persist::WaterCraftV2_services::BWR_buildautokey';
autokey_ready := watercraft :persist(persistname);

//autokey_ready :=dataset(persistname,layout_watercraft,flat);
/*
t:= WatercraftV2_Services.Constants(filedate).ak_keyname;
ut.mac_create_superkey_files(t + 'Address');
ut.mac_create_superkey_files(t + 'CityStName');
ut.mac_create_superkey_files(t + 'Name');
ut.mac_create_superkey_files(t + 'Phone');
ut.mac_create_superkey_files(t + 'SSN');
ut.mac_create_superkey_files(t + 'StName');
ut.mac_create_superkey_files(t + 'Zip');
ut.mac_create_superkey_files(t + 'Payload');
*/



AutoKeyB2.MAC_Build (autokey_ready,fname,mname,lname,
            ssn_use,
            dob,
            phone,
            prim_name,prim_range,st,city,zip5,sec_range,
            zero,
            zero,zero,zero,
            zero,zero,zero,
            zero,zero,zero,
            zero,
            ldid,
            company_name,
            fein_use,
            bphone,
            bprim_name,bprim_range, bstate,bcity, bzip5,bsec_range,
            lbdid,
            WatercraftV2_Services.Constants(filedate).ak_keyname,
            WatercraftV2_Services.Constants(filedate).ak_logical,
            outaction,FALSE,
            [],TRUE,WatercraftV2_Services.Constants(filedate).ak_typeStr,TRUE)



AutoKeyB2.MAC_AcceptSK_to_QA(WatercraftV2_Services.Constants(filedate).ak_keyname,mymove)


Autokey_ret := sequential(outaction,mymove);

RETURN Autokey_ret;

END;
