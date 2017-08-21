import RoxieKeyBuild,ut;
export proc_build_Easi(string filedate) := function

//build base file
ut.MAC_SF_BuildProcess(File_Easi_Census
											 ,'~thor_data400::base::Easi'
											 ,aEasiBase,2);


//build key
build_key :=proc_build_easi_key(filedate);

//boolean keys if needed
//strata if needed

// -- Actions
 build_all := sequential(aEasiBase,build_key):success(Send_Email(filedate).Build_Success), failure(Send_Email(filedate).Build_Failure);


return build_all;

end;



