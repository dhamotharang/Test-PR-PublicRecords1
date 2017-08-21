EXPORT proc_build_autokey(STRING version) := FUNCTION
  IMPORT AutokeyB2;

  layout_autokey:=RECORD
    Mediaone.file_base.file.clean_p_city_name;
    Mediaone.file_base.file.phone;
    Mediaone.file_base.file.dob;
    Mediaone.file_base.file.did;
    Mediaone.file_base.file.clean_fname;
    Mediaone.file_base.file.clean_mname;
    Mediaone.file_base.file.clean_lname;
    Mediaone.file_base.file.clean_name_suffix;
    Mediaone.file_base.file.clean_prim_range;
    Mediaone.file_base.file.clean_prim_name;
    Mediaone.file_base.file.clean_sec_range;
    Mediaone.file_base.file.clean_st;
    Mediaone.file_base.file.clean_zip;
    Mediaone.file_base.file.email;
    STRING blank:='';
    INTEGER zero:=0;
  END;
  autokeydata:=TABLE(Mediaone.file_base.file,layout_autokey);
  SET OF STRING skipset:=['Q','S','F','B'];
  AutoKeyB2.MAC_Build(autokeydata,clean_fname,clean_mname,clean_lname,blank,dob,
    phone,clean_prim_name,clean_prim_range,clean_st,clean_p_city_name,clean_zip,clean_sec_range,
    zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,did,blank,zero,
    zero,blank,blank,blank,blank,blank,blank,zero,
    '~thor::key::mediaone::autokey::','~thor::key::mediaone::'+version+'::autokey::',
    createautokey,false,skipset,true,,false,,,zero);

  AutoKeyB2.MAC_AcceptSK_to_QA('~thor::key::mediaone::autokey::',move,,skipset)
  mediaoneAutokey := sequential(createautokey,move);
	RETURN mediaoneAutokey;   
END;