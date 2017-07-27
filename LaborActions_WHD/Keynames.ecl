import versioncontrol;
export Keynames(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	shared cluster := _Dataset(pUseProd).thor_cluster_files;
	shared keyroot := cluster + 'key::' + _Dataset().name;
	
	export dAll_file		:= 
	
       module
	export	 lNewBdidKeyTemplate	:= keyroot + '::@version@::Bdid';
	export	 lNewLinkIDKeyTemplate	:= keyroot + '::@version@::LinkIDs';	
	export	 lNewAddrKeyTemplate	:= keyroot + '::autokey::@version@::addressb2';
	export	 lNewCityStKeyTemplate	:= keyroot + '::autokey::@version@::citystnameb2';
	export	 lNewZipKeyTemplate	:= keyroot + '::autokey::@version@::zipb2';
	export	 lNewNameKeyTemplate	:= keyroot + '::autokey::@version@::nameb2';
	export	 lNewNamewordsKeyTemplate	:= keyroot + '::autokey::@version@::namewords2';
	export	 lNewPayloadKeyTemplate	:= keyroot + '::autokey::@version@::payload';
	export	 lNewStnameKeyTemplate	:= keyroot + '::autokey::@version@::stnameb2';

     export bdid := VersionControl.mBuildFilenameVersions(lNewBdidKeyTemplate , pversion);
     export linkids := VersionControl.mBuildFilenameVersions(lNewLinkIDKeyTemplate , pversion);					 
	   export addrauto := VersionControl.mBuildFilenameVersions(lNewAddrKeyTemplate , pversion);
	   export citystauto := VersionControl.mBuildFilenameVersions(lNewCityStKeyTemplate , pversion);
	   export zipauto := VersionControl.mBuildFilenameVersions(lNewZipKeyTemplate , pversion);
	   export nameauto := VersionControl.mBuildFilenameVersions(lNewNameKeyTemplate , pversion);
	   export namewordsauto := VersionControl.mBuildFilenameVersions(lNewNamewordsKeyTemplate , pversion);
	   export payloadauto := VersionControl.mBuildFilenameVersions(lNewPayloadKeyTemplate , pversion);
	   export stauto := VersionControl.mBuildFilenameVersions(lNewStnameKeyTemplate , pversion);

          export dAll_filenames := 
		              bdid.dAll_filenames +
									linkids.dAll_filenames +		
								  addrauto.dAll_filenames +
								  citystauto.dAll_filenames +
								  zipauto.dAll_filenames +
								  nameauto.dAll_filenames +
								  namewordsauto.dAll_filenames +
								  payloadauto.dAll_filenames +
								  stauto.dAll_filenames;

	end;
	
end;
	
