import dx_BancorpRCDList,Orbit3,RoxieKeyBuild,BancorpRCDList;
EXPORT procBuildKeys (STRING	pVersion, boolean isDelta):=function

	prefix := '~thor_data400::key::BancorpRCDList::' + pVersion + '::';
	
	name_ssn := prefix + 'ssn';
	
	RoxieKeybuild.MAC_build_logical(dx_BancorpRCDList.key_SSN(),BancorpRCDList.files.base,dx_BancorpRCDList.names('').i_ssn,name_ssn,BancorpRCDList_SSN);
	
	RoxieKeyBuild.Mac_SK_Move_v3('~thor_data400::key::BancorpRCDList::@version@::ssn','D',ma_BancorpRCDList_SSN_to_qa,pVersion,2);
	
	build_keys := sequential(
        BancorpRCDList_SSN,
		if(isDelta, 
            fileservices.addsuperfile(dx_BancorpRCDList.names().i_ssn,	name_ssn),
             ma_BancorpRCDList_SSN_to_qa));
    
    return build_keys;
end;