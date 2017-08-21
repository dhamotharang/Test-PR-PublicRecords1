import RoxieKeyBuild,ut;
export proc_build_Smart_Jury(string filedate) := function

//build base file
ut.MAC_SF_BuildProcess(File_Smart_Jury
											 ,'~thor_data400::base::smart_jury'
											 ,aSmart_JuryBase,2);


//build key
build_key :=proc_build_Smart_Jury_key(filedate);

//boolean keys if needed
//strata if needed

// -- Actions
 build_all := sequential(aSmart_JuryBase,build_key):success(Send_Email(filedate).Build_Success), failure(Send_Email(filedate).Build_Failure);


return build_all;

end;



