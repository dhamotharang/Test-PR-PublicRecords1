IMPORT AutoKeyI, American_student_list, American_Student_Services;

EXPORT AutoKeyIds(American_Student_Services.IParam.searchParams input) := FUNCTION

      // SEARCH THE AUTOKEYS
    str_autokeyname := American_student_list.Constants.autokey_qa_keyname;
    typestr := American_student_list.Constants.autokey_typeStr;
    ds := dataset([],American_Student_Services.Layouts.Payload);
          
    tempmod := module(project(input,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
      export string autokey_keyname_root := str_autokeyname;
      export string typestr := ^.typestr;
      export set of string1 get_skip_set := American_student_list.Constants.autokey_skipSet;
      export boolean useAllLookups := true;
      export boolean workHard := true;
    end;
  
    ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;
  RETURN ids;
  
END;
