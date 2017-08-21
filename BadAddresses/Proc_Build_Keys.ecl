Import Data_Services, doxie, ut, RoxieKeyBuild;

Export Proc_Build_Keys(String filedate) :=  function
KeyAddress_Create := BadAddresses.Keys(filedate).Key_Address;

//Build the Address key
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(KeyAddress_Create,
											   '~thor400_92::key::BadAddresses::@version@::Address',
											   '~thor400_92::key::BadAddresses::'+filedate+'::Address',
											   build_Address_key);
											   
//Move Address key to Built
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor400_92::key::BadAddresses::@version@::Address',
										  '~thor400_92::key::BadAddresses::'+filedate+'::Address',
										  mv_Address_key);     											   
//Move Address key to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor400_92::key::BadAddresses::@version@::Address', 'Q', mv_Address_key_to_qa);
	
	Return sequential(build_Address_key,
										    mv_Address_key,	
											mv_Address_key_to_qa);
End;