EXPORT proc_build_autokeys(STRING version) := FUNCTION
  IMPORT AutokeyB2;

  layout_autokey:=RECORD
    AlloyMedia_student_list.Files.File_Base.clean_p_city_name;
		AlloyMedia_student_list.Files.File_Base.home_phone_number;
		AlloyMedia_student_list.Files.File_Base.did;
		AlloyMedia_student_list.Files.File_Base.clean_fname;
		AlloyMedia_student_list.Files.File_Base.clean_mname;
		AlloyMedia_student_list.Files.File_Base.clean_lname;
		AlloyMedia_student_list.Files.File_Base.clean_name_suffix;
		AlloyMedia_student_list.Files.File_Base.clean_prim_range;
		AlloyMedia_student_list.Files.File_Base.clean_prim_name;
		AlloyMedia_student_list.Files.File_Base.clean_sec_range;
		AlloyMedia_student_list.Files.File_Base.clean_st;
		clean_zip	:=	AlloyMedia_student_list.Files.File_Base.clean_zip5;
    STRING blank:='';
    INTEGER zero:=0;
  END;
  autokeydata:=TABLE(Files.File_Base,layout_autokey);
  SET OF STRING skipset:=['Q','S','F','B'];
  AutoKeyB2.MAC_Build(autokeydata,clean_fname,clean_mname,clean_lname,blank,blank,
    home_phone_number,clean_prim_name,clean_prim_range,clean_st,clean_p_city_name,clean_zip,clean_sec_range,
    zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,did,blank,zero,
    zero,blank,blank,blank,blank,blank,blank,zero,
    thor_cluster+'key::alloymedia_student_list::autokey::',thor_cluster+'key::alloymedia_student_list::'+version+'::autokey::',
    createautokey,false,skipset,true,,false,,,zero);

   AutoKeyB2.MAC_AcceptSK_to_QA(thor_cluster+'key::alloymedia_student_list::autokey::',move,, skipset)
  alloymedia_student_list_Autokey := sequential(createautokey,move);
	RETURN alloymedia_student_list_Autokey;   
END;