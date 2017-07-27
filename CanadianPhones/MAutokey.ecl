import autokey;

export MAutokey := MODULE //(autokey.IBuildAutokey)

  export MAC_Address (indataset,infname,inmname,inlname, inssn,indob,phone,
                      inprim_name,inprim_range,inst,incity_name,inzip,insec_range,instates,
                      inlname1,inlname2,inlname3, incity1,incity2,incity3, inrel_fname1,inrel_fname2,inrel_fname3,
                      inlookups, indid, inkeyname, Address_Key, by_lookup=TRUE,rep_Addr=4) := MACRO
    CanadianPhones.MAC_Address_Can (indataset,infname,inmname,inlname, inssn,indob,phone,
                                    inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
                                    inlookups, indid, inkeyname, Address_Key, by_lookup,rep_addr); 
  ENDMACRO;

  export MAC_CityStName (indataset,infname,inmname,inlname,inssn,indob,phone,
                         inprim_name,inprim_range,inst,incity_name,inzip,insec_range,instates,
                         inlname1,inlname2,inlname3,incity1,incity2,incity3,inrel_fname1,inrel_fname2,inrel_fname3,
                         inlookups,indid,inkeyname,outkey,by_lookup=TRUE,favor_lookup=0) := MACRO
    autokey.MAC_CityStName (indataset,infname,inmname,inlname,inssn,indob,phone,
                            inprim_name,inprim_range,inst,incity_name,inzip,insec_range,instates,
                            inlname1,inlname2,inlname3,incity1,incity2,incity3,inrel_fname1,inrel_fname2,inrel_fname3,
                            inlookups,indid,inkeyname,outkey,by_lookup,favor_lookup);
  ENDMACRO;

  export MAC_Name (indataset,infname,inmname,inlname,inssn,indob,phone,
                   inprim_name,inprim_range,inst,incity_name,inzip,insec_range,instates,
                   inlname1,inlname2,inlname3,incity1,incity2,incity3,inrel_fname1,inrel_fname2,inrel_fname3,
                   inlookups,indid,inkeyname,outkey,by_lookup=TRUE,favor_lookup=1) := MACRO
    autokey.MAC_Name (indataset,infname,inmname,inlname,inssn,indob,phone,
                      inprim_name,inprim_range,inst,incity_name,inzip,insec_range,instates,
                      inlname1,inlname2,inlname3,incity1,incity2,incity3,inrel_fname1,inrel_fname2,inrel_fname3,
                      inlookups,indid,inkeyname,outkey,by_lookup,favor_lookup);
  ENDMACRO;

  export MAC_Phone (indataset,infname,inmname,inlname,inssn,indob,inphone,
                    inprim_name,inprim_range,inst,incity_name,inzip,insec_range,instates,
                    inlname1,inlname2,inlname3,incity1,incity2,incity3,inrel_fname1,inrel_fname2,inrel_fname3,
                    inlookups,indid,inkeyname,outkey) := MACRO
    autokey.MAC_Phone (indataset,infname,inmname,inlname,inssn,indob,inphone,
                       inprim_name,inprim_range,inst,incity_name,inzip,insec_range,instates,
                       inlname1,inlname2,inlname3,incity1,incity2,incity3,inrel_fname1,inrel_fname2,inrel_fname3,
                       inlookups,indid,inkeyname,outkey);
  ENDMACRO;

  export MAC_Phone2 (indataset,infname,inmname,inlname,inssn,indob,inphone,
                     inprim_name,inprim_range,inst,incity_name,inzip,insec_range,instates,
                     inlname1,inlname2,inlname3,incity1,incity2,incity3,inrel_fname1,inrel_fname2,inrel_fname3,
                     inlookups,indid,inkeyname,outkey,by_lookup=TRUE,favor_lookup=0) := MACRO
    autokey.MAC_Phone2 (indataset,infname,inmname,inlname,inssn,indob,inphone,
                        inprim_name,inprim_range,inst,incity_name,inzip,insec_range,instates,
                        inlname1,inlname2,inlname3,incity1,incity2,incity3,inrel_fname1,inrel_fname2,inrel_fname3,
                        inlookups,indid,inkeyname,outkey,by_lookup,favor_lookup);
  ENDMACRO;

  export MAC_SSN (indataset,infname,inmname,inlname,inssn,indob,inphone,
                  inprim_name,inprim_range,inst,incity_name,inzip,insec_range,instates,
                  inlname1,inlname2,inlname3,incity1,incity2,incity3,inrel_fname1,inrel_fname2,inrel_fname3,
                  inlookups,indid,inkeyname,outkey) := MACRO
    autokey.MAC_SSN (indataset,infname,inmname,inlname,inssn,indob,inphone,
                     inprim_name,inprim_range,inst,incity_name,inzip,insec_range,instates,
                     inlname1,inlname2,inlname3,incity1,incity2,incity3,inrel_fname1,inrel_fname2,inrel_fname3,
                     inlookups,indid,inkeyname,outkey);
  ENDMACRO;

  export MAC_SSN2 (indataset,infname,inmname,inlname,inssn,indob,inphone,
                   inprim_name,inprim_range,inst,incity_name,inzip,insec_range,instates,
                   inlname1,inlname2,inlname3,incity1,incity2,incity3,inrel_fname1,inrel_fname2,inrel_fname3,
                   inlookups,indid,inkeyname,outkey,by_lookup=TRUE,favor_lookup=0) := MACRO
    autokey.MAC_SSN2 (indataset,infname,inmname,inlname,inssn,indob,inphone,
                      inprim_name,inprim_range,inst,incity_name,inzip,insec_range,instates,
                      inlname1,inlname2,inlname3,incity1,incity2,incity3,inrel_fname1,inrel_fname2,inrel_fname3,
                      inlookups,indid,inkeyname,outkey,by_lookup,favor_lookup);
  ENDMACRO;

  export MAC_StName (indataset,infname,inmname,inlname,inssn,indob,phone,
                     inprim_name,inprim_range,inst,incity_name,inzip,insec_range,instates,
                     inlname1,inlname2,inlname3,incity1,incity2,incity3,inrel_fname1,inrel_fname2,inrel_fname3,
                     inlookups,indid,inkeyname,outkey,by_lookup=TRUE,favor_lookup=0) := MACRO
    autokey.MAC_StName (indataset,infname,inmname,inlname,inssn,indob,phone,
                        inprim_name,inprim_range,inst,incity_name,inzip,insec_range,instates,
                        inlname1,inlname2,inlname3,incity1,incity2,incity3,inrel_fname1,inrel_fname2,inrel_fname3,
                        inlookups,indid,inkeyname,outkey,by_lookup,favor_lookup);
  ENDMACRO;

  export MAC_ZipPRLName(indataset,infname,inmname,inlname,
						inssn,
						indob,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						instates,
						inlname1,inlname2,inlname3,
						incity1,incity2,incity3,
						inrel_fname1,inrel_fname2,inrel_fname3,
						inlookups,
						indid,
						inkeyname,ZipPRLName_Key,by_lookup,favor_lookup_person) := MACRO
    CanadianPhones.MAC_ZipPRLName_Can (indataset,infname,inmname,inlname,inssn,indob,phone,
                            inprim_name,inprim_range,inst,incity_name,inzip,insec_range,instates,
                            inlname1,inlname2,inlname3, incity1,incity2,incity3, inrel_fname1,inrel_fname2,inrel_fname3,
                            inlookups,indid,inkeyname,ZipPRLName_Key,by_lookup,favor_lookup_person);
  ENDMACRO;

  export MAC_Zip (indataset,infname,inmname,inlname,inssn,indob,phone,
                  inprim_name,inprim_range,inst,incity_name,inzip,insec_range,instates,
                  inlname1,inlname2,inlname3,incity1,incity2,incity3,inrel_fname1,inrel_fname2,inrel_fname3,
                  inlookups,indid,inkeyname,outkey,by_lookup=TRUE,favor_lookup=0) := MACRO

    CanadianPhones.MAC_Zip_Can (indataset,infname,inmname,inlname, inzip, inlookups, indid,inkeyname,outkey,by_lookup,favor_lookup);
  ENDMACRO;

  EXPORT MAC_Add_Cities (indataset, inzip, incity_name, outdataset) := MACRO
    outdataset := indataset;
    // #uniquename (AddFrenchCity);
    // indataset %AddFrenchCity% (indataset L, integer C) := TRANSFORM
      // SELF.p_city_name := CHOOSE (C, L.p_city_name, 'fr_' + L.p_city_name);
      // SELF := L;
    // END;
    // outdataset := NORMALIZE (indataset, 2, %AddFrenchCity% (Left, Counter));
  ENDMACRO;


END;