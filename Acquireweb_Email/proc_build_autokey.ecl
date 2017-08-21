EXPORT proc_build_autokey(STRING version) := FUNCTION
  IMPORT AutokeyB2;

  layout_autokey:=RECORD
    Acquireweb_Email.files.file_Acquireweb_Base.clean_p_city_name;
    Acquireweb_Email.files.file_Acquireweb_Base.phone;
    Acquireweb_Email.files.file_Acquireweb_Base.dob;
    Acquireweb_Email.files.file_Acquireweb_Base.did;
    Acquireweb_Email.files.file_Acquireweb_Base.clean_fname;
    Acquireweb_Email.files.file_Acquireweb_Base.clean_mname;
    Acquireweb_Email.files.file_Acquireweb_Base.clean_lname;
    Acquireweb_Email.files.file_Acquireweb_Base.clean_name_suffix;
    Acquireweb_Email.files.file_Acquireweb_Base.clean_prim_range;
    Acquireweb_Email.files.file_Acquireweb_Base.clean_prim_name;
    Acquireweb_Email.files.file_Acquireweb_Base.clean_sec_range;
    Acquireweb_Email.files.file_Acquireweb_Base.clean_st;
    Acquireweb_Email.files.file_Acquireweb_Base.clean_zip;
    Acquireweb_Email.files.file_Acquireweb_Base.email;
    Acquireweb_Email.files.file_Acquireweb_Base.activecode;
    STRING blank:='';
    INTEGER zero:=0;
  END;
  autokeydata:=TABLE(Acquireweb_Email.files.file_Acquireweb_Base,layout_autokey);
  SET OF STRING skipset:=['Q','S','F','B'];
  AutoKeyB2.MAC_Build(autokeydata,clean_fname,clean_mname,clean_lname,blank,dob,
    phone,clean_prim_name,clean_prim_range,clean_st,clean_p_city_name,clean_zip,clean_sec_range,
    zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,did,blank,zero,
    zero,blank,blank,blank,blank,blank,blank,zero,
    '~thor::key::acquireweb::autokey::','~thor::key::acquireweb::'+version+'::autokey::',
    createautokey,false,skipset,true,,false,,,zero);

  AutoKeyB2.MAC_AcceptSK_to_QA('~thor::key::acquireweb::autokey::',move,,skipset)
  acquirewebAutokey := sequential(createautokey,move);
	RETURN acquirewebAutokey;   
END;