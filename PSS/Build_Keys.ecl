import doxie, tools;

export Build_Keys(
 	 string		pversion
	,boolean	pUseOtherEnvironment	= false
) :=
module
	
	tools.mac_WriteIndex('Keys(pversion,,pUseOtherEnvironment).Bdid.New'							,BuildBdidKey	);
	tools.mac_WriteIndex('Keys(pversion,,pUseOtherEnvironment).Did.New'								,BuildDidKey	);
	tools.mac_WriteIndex('Keys(pversion,,pUseOtherEnvironment).Bdid_phone.New'								,BuildDidPhoneKey	);																	  
	export full_build :=
	sequential(
		 parallel(
			 BuildBdidKey
			,BuildDidKey
			,BuildDidPhoneKey
	 )
		,Promote(pversion).New2Built
	);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping PSS.Build_Keys atribute')
	);

end;