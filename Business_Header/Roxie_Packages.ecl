import versioncontrol, Marketing_Best, govdata,aca,risk_indicators,paw;

export Roxie_Packages(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
	,string		pPrefix								= 'thor_data400'

) :=
module
	
	export lkeynames := keynames(pversion,pUseOtherEnvironment,,pPrefix);
	
	export ACAInstitutionsKeys	:= 
		ACA.keynames(pversion).dAll_filenames
	;

	export AddressHRIKeys			:=   
		risk_indicators.keynames(pversion).dAll_filenames
	;

	export BusinessBestKeys			:=   
		Marketing_Best.keynames(pversion).dAll_filenames
	;

	export BusinessHeaderKeys 				:=
			lkeynames.Supergroup.dAll_filenames
		+ lkeynames.Contacts.Bdid.dAll_filenames
		+ lkeynames.Contacts.Did.dAll_filenames
		+ lkeynames.Contacts.Ssn.dAll_filenames
		+ lkeynames.Contacts.StateLfmname.dAll_filenames
		+ lkeynames.Contacts.BdidScore.dAll_filenames
		+ lkeynames.Contacts.Companytitle.dAll_filenames
		+ lkeynames.Contacts.Filepos.dAll_filenames
		+ lkeynames.Base.Phone.dAll_filenames
		+ lkeynames.Base.Conamewords.dAll_filenames
		+ lkeynames.Base.CoNameWordsMetaphone.dAll_filenames
		+ lkeynames.Base.Fein.dAll_filenames
		+ lkeynames.Base.CompanynameBdidCnBdids.dAll_filenames
		+ lkeynames.Base.Companyname.dAll_filenames
		+ lkeynames.Base.BdidSeq.dAll_filenames
		+ lkeynames.Base.BdidCityZipFeinPhone.dAll_filenames
		+ lkeynames.Base.BdidPl.dAll_filenames
		+ lkeynames.Base.AddrPrPnZip.dAll_filenames
		+ lkeynames.Base.AddrPrPnSrSt.dAll_filenames
		+ lkeynames.Base.Siccode.dAll_filenames
		+ lkeynames.Base.Addr.dAll_filenames
		+ lkeynames.Base.ZipPRLName.dAll_filenames
		+ lkeynames.Base.AddrZip.dAll_filenames
		+ lkeynames.Base.AddrSt.dAll_filenames
		+ lkeynames.Base.RCID.dAll_filenames
		+ lkeynames.Base.Commercial.dAll_filenames
		+ lkeynames.HeaderBest.dAll_filenames
		+ lkeynames.Relatives.dAll_filenames
		+ lkeynames.RelativesGroup.dAll_filenames
		+ lkeynames.Risk.dAll_filenames
		+ lkeynames.EDA.dAll_filenames
		+ lkeynames.NewFetch.dAll_filenames
		+ lkeynames.BDL2.dAll_filenames		
	;
	
	export PAWV2Keys 				:=
			paw.keynames(pversion).dAll_filenames
	;

	export GovdataKeys 				:=
			govdata.keynames(pversion).dAll_filenames
	;

	export All_package_keys :=
			ACAInstitutionsKeys
		+ AddressHRIKeys
		+ BusinessBestKeys
		+ lkeynames.dall_filenames
		+ PAWV2Keys
		+ GovdataKeys
		;
	

end;