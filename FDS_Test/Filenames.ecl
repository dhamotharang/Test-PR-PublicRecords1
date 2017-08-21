import doxie, versioncontrol;

export Filenames(

	 string		pversion							= ''

) :=
module
	
	shared ldataset			:= 'FDS_Test'	;
	shared lversiondate	:= pversion		;
	shared lthor				:= '~thor_data400::';

	export Out := 
	module

		shared lTaxidroot		:= lthor + 'out::' + ldataset + '::@version@::' + 'TaxID';
		shared lEmproot			:= lthor + 'out::' + ldataset + '::@version@::' + 'Employment';
		shared lRelroot			:= lthor + 'out::' + ldataset + '::@version@::' + 'Relatives';
		shared lAssroot			:= lthor + 'out::' + ldataset + '::@version@::' + 'Associates';

		export TaxID_Extract	:= versioncontrol.mBuildFilenameVersions(lTaxidroot	+ '::Extract'	,lversiondate	);
		export TaxID_Append		:= versioncontrol.mBuildFilenameVersions(lTaxidroot	+ '::Append'	,lversiondate	);
		
		export Employment_Extract	:= versioncontrol.mBuildFilenameVersions(lEmproot	+ '::Extract'	,lversiondate	);
		export Employment_Append	:= versioncontrol.mBuildFilenameVersions(lEmproot	+ '::Append'	,lversiondate	);

		export Relatives_Extract	:= versioncontrol.mBuildFilenameVersions(lRelroot	+ '::Extract'	,lversiondate	);
		export Relatives_Append		:= versioncontrol.mBuildFilenameVersions(lRelroot	+ '::Append'	,lversiondate	);

		export Associates_Extract	:= versioncontrol.mBuildFilenameVersions(lAssroot	+ '::Extract'	,lversiondate	);
		export Associates_Append	:= versioncontrol.mBuildFilenameVersions(lAssroot	+ '::Append'	,lversiondate	);

		//**** Out files for Consumer
		shared lCnsroot			:= lthor + 'out::' + ldataset + '::@version@::' + 'Consumer';
		shared lSSNroot			:= lthor + 'out::' + ldataset + '::@version@::' + 'SSN';
		shared lCnsDemoroot		:= lthor + 'out::' + ldataset + '::@version@::' + 'CnsDemo';
		shared lAddrHistroot	:= lthor + 'out::' + ldataset + '::@version@::' + 'AddrHist';

		export Cns_Extract		:= versioncontrol.mBuildFilenameVersions(lCnsroot		+ '::Extract'	,lversiondate	);
		export SSN_Append		:= versioncontrol.mBuildFilenameVersions(lSSNroot		+ '::Append'	,lversiondate	);
		export CnsDemo_Append	:= versioncontrol.mBuildFilenameVersions(lCnsDemoroot	+ '::Append'	,lversiondate	);
		export AddrHist_Append	:= versioncontrol.mBuildFilenameVersions(lAddrHistroot	+ '::Append'	,lversiondate	);
		
		//**** Out files for UCC
		shared lUccroot		:= lthor + 'out::' + ldataset + '::@version@::' + 'UCC';

		export UCC_Extract	:= versioncontrol.mBuildFilenameVersions(lUccroot	+ '::Extract'	,lversiondate	);
		export UCC_Append		:= versioncontrol.mBuildFilenameVersions(lUccroot	+ '::Append'	,lversiondate	);
		
		//**** Out files for Prolic
		shared lPLroot		:= lthor + 'out::' + ldataset + '::@version@::' + 'Prolic';

		export PL_Extract	:= versioncontrol.mBuildFilenameVersions(lPLroot	+ '::Extract'	,lversiondate	);
		export PL_Append	:= versioncontrol.mBuildFilenameVersions(lPLroot	+ '::Append'	,lversiondate	);

	    //**** Out files for phones
		shared PrivatePhoneroot		:= lthor + 'out::' + ldataset + '::@version@::' + 'PrivatePhone';
		export PrivatePhone_Extract := versioncontrol.mBuildFilenameVersions(PrivatePhoneroot	+ '::Extract'	,lversiondate	);
		export PrivatePhone_Append  := versioncontrol.mBuildFilenameVersions(PrivatePhoneroot	+ '::Append'	,lversiondate	); 
		
		shared PhoneVerificationroot		:= lthor + 'out::' + ldataset + '::@version@::' + 'PhoneVerification';
		export PhoneVerification_Extract := versioncontrol.mBuildFilenameVersions(PhoneVerificationroot	+ '::Extract'	,lversiondate	); 
		export PhoneVerification_Append  := versioncontrol.mBuildFilenameVersions(PhoneVerificationroot	+ '::Append'	,lversiondate	); 
		
	end;

end;