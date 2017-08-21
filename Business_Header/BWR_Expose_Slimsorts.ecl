#workunit ('name', 'Build Business Header Expose Slimsorts');
#workunit ('protect', true);

regex				:= '^.*?base::business_header.*?(search|best|companyname|BDL2).*$';
pIsTesting	:= false;

sequential(
	 business_header.promote(,regex,pIsTesting := pIsTesting).QA2Prod
//	,business_header.promote(,,true,pIsTesting := pIsTesting).VersionIntegrityCheck
	,parallel(
		 output(Business_Header.Files().Base.Business_headers.prod			,named('Business_Header_Base'			))
		,output(Business_Header.Files().Base.Business_Header_Best.prod	,named('Business_Header_Best_Base'))
		,output(business_header.files().Base.CompanyNameAddress.prod		,named('CompanyNameAddress_Base'	))
		,output(business_header.files().Base.CompanyNameFein.prod				,named('CompanyNameFein_Base'			))
		,output(business_header.files().Base.CompanyNamePhone.prod			,named('CompanyNamePhone_Base'		))
		,output(Business_Header.Files().Base.CompanyName.prod						,named('CompanyName_Base'					))
		,output(Business_Header.files().base.bdl2.prod									,named('Bdl2_Base'								))
	)
);

/*
Files used in bdid macros--no keys used in those macros
%pBHFile%						:= Business_Header.Files(pFileVersion,pUseOtherEnvironment).Base.Business_headers.logical			;
%pBHBFile%					:= Business_Header.Files(pFileVersion,pUseOtherEnvironment).Base.Business_Header_Best.logical	;
%pCnameAddressBase%	:= business_header.files(pFileVersion,pUseOtherEnvironment).Base.CompanyNameAddress.logical		;
%pCnameFeinBase%		:= business_header.files(pFileVersion,pUseOtherEnvironment).Base.CompanyNameFein.logical			;
%pCnamePhoneBase%		:= business_header.files(pFileVersion,pUseOtherEnvironment).Base.CompanyNamePhone.logical			;
%pCnameBase%				:= Business_Header.Files(pFileVersion,pUseOtherEnvironment).Base.CompanyName.logical					;
%dbdl2% 						:= Business_Header.files(pFileVersion,pUseOtherEnvironment).base.bdl2.logical									;
*/