 #workunit('name', 'OutwardMediaAutoKeys');

EXPORT proc_build_autokey(STRING version) := FUNCTION
  IMPORT AutokeyB2;

  layout_autokey:=RECORD
    OutwardMedia.Files.File_OutwardMedia_Base.clean_p_city_name;
		OutwardMedia.Files.File_OutwardMedia_Base.phone;
		OutwardMedia.Files.File_OutwardMedia_Base.did;
		OutwardMedia.Files.File_OutwardMedia_Base.clean_fname;
		OutwardMedia.Files.File_OutwardMedia_Base.clean_mname;
		OutwardMedia.Files.File_OutwardMedia_Base.clean_lname;
		OutwardMedia.Files.File_OutwardMedia_Base.clean_name_suffix;
		OutwardMedia.Files.File_OutwardMedia_Base.clean_prim_range;
		OutwardMedia.Files.File_OutwardMedia_Base.clean_prim_name;
		OutwardMedia.Files.File_OutwardMedia_Base.clean_sec_range;
		OutwardMedia.Files.File_OutwardMedia_Base.clean_st;
		OutwardMedia.Files.File_OutwardMedia_Base.clean_zip;
		OutwardMedia.Files.File_OutwardMedia_Base.email;
    STRING blank:='';
    INTEGER zero:=0;
  END;
  autokeydata:=TABLE(OutwardMedia.Files.File_OutwardMedia_Base,layout_autokey);
  SET OF STRING skipset:=['Q','S','F','B'];
  AutoKeyB2.MAC_Build(autokeydata,clean_fname,clean_mname,clean_lname,blank,blank,
    phone,clean_prim_name,clean_prim_range,clean_st,clean_p_city_name,clean_zip,clean_sec_range,
    zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,did,blank,zero,
    zero,blank,blank,blank,blank,blank,blank,zero,
    OutwardMedia.cluster+'key::outwardmedia::autokey::',OutwardMedia.cluster+'key::outwardmedia::'+version+'::autokey::',
    createautokey,false,skipset,true,,false,,,zero);

   AutoKeyB2.MAC_AcceptSK_to_QA(OutwardMedia.cluster+'key::outwardmedia::autokey::',move)
  OutwardMediaAutokey := sequential(createautokey,move);
	RETURN OutwardMediaAutokey;   
END;