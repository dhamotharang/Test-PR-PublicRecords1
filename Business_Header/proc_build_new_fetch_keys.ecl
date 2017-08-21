import  tools,VersionControl;

export proc_build_new_fetch_keys(
	 const string																		pversion							= ''
	,dataset(Layouts.File_Hdr_Biz_Keybuild_Layout)	pBh										= File_business_header_fetch()
	,boolean																				pUseOtherEnvironment	= false
	,string																					pkeystring						= 'key'
	,string																					pPrefix								= 'thor_data400'
	,boolean																				pShouldPromote				= true
) := 
module

	shared keyName			:= keynames(pversion,,pkeystring,pPrefix).NewFetch;
	shared rkeys				:= roxiekeys(pversion,pBH,pUseOtherEnvironment,pkeystring,pPrefix).newfetch;

	shared Build_Key1	:= tools.macf_WriteIndex('rkeys.key_Address.New'		);
	shared Build_Key2	:= tools.macf_WriteIndex('rkeys.key_Fein.New'			  );
	shared Build_Key3	:= tools.macf_WriteIndex('rkeys.key_Name.New'			  );
	shared Build_Key4	:= tools.macf_WriteIndex('rkeys.key_Phone.New'			);
	shared Build_Key5	:= tools.macf_WriteIndex('rkeys.key_Stcityname.New' );
	shared Build_Key6	:= tools.macf_WriteIndex('rkeys.key_Stname.New'		  );
	shared Build_Key7	:= tools.macf_WriteIndex('rkeys.key_Street.New'		  );
	shared Build_Key8	:= tools.macf_WriteIndex('rkeys.key_Zip.New'				);
		                                                                          
	shared keygroupnames := 
				keyName.dAll_filenames                                                                           
			; 
	export Build_All_Keys :=
	if(not VersionControl.DoAllFilesExist.fNamesBuilds(keygroupnames)
		,parallel(

			 Build_Key1
			,Build_Key2
			,Build_Key3
			,Build_Key4
			,Build_Key5
			,Build_Key6
			,Build_Key7
			,Build_Key8

		));

	export All :=
	sequential(
		 Build_All_Keys
		,if(pShouldPromote = true	,promote(pversion,'^(?!.*moxie)(.*?)key(.*?)$').new2built)
	);

end;
