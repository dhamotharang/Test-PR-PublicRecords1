IMPORT STD,data_services,VersionControl;
EXPORT Keynames(STRING version	=	(STRING8)Std.Date.Today())	:=	MODULE
  SHARED  STRING dataset_name := 'official_records';  
	SHARED  STRING prefix := data_services.Data_location.Prefix (dataset_name) + 'thor_200::key::' + dataset_name; 
	
	EXPORT i_document(STRING version = (STRING8)Std.Date.Today())               := prefix + '_document' + IF(version != '', '::@version@::', '_') + 'orid';
	EXPORT i_party(STRING version = (STRING8)Std.Date.Today())                  := prefix + '_party' + IF(version != '', '::@version@::', '_') + 'orid';
  
	//Autokey
	EXPORT i_auto_addressb2(STRING version = (STRING8)Std.Date.Today())         := prefix + IF(version != '', '::@version@::', '::') + 'autokey::addressb2';
  EXPORT i_auto_address(STRING version = (STRING8)Std.Date.Today())           := prefix + IF(version != '', '::@version@::', '::') + 'autokey::address';
  EXPORT i_auto_citystnameb2(STRING version = (STRING8)Std.Date.Today())      := prefix + IF(version != '', '::@version@::', '::') + 'autokey::citystnameb2';
  EXPORT i_auto_citystname(STRING version = (STRING8)Std.Date.Today())        := prefix + IF(version != '', '::@version@::', '::') + 'autokey::citystname';
  EXPORT i_auto_nameb2(STRING version = (STRING8)Std.Date.Today())            := prefix + IF(version != '', '::@version@::', '::') + 'autokey::nameb2';
  EXPORT i_auto_namewords2(STRING version = (STRING8)Std.Date.Today())        := prefix + IF(version != '', '::@version@::', '::') + 'autokey::namewords2';
  EXPORT i_auto_name(STRING version = (STRING8)Std.Date.Today())              := prefix + IF(version != '', '::@version@::', '::') + 'autokey::name';
  EXPORT i_auto_payload(STRING version = (STRING8)Std.Date.Today())           := prefix + IF(version != '', '::@version@::', '::') + 'autokey::payload';
  EXPORT i_auto_stnameb2(STRING version = (STRING8)Std.Date.Today())          := prefix + IF(version != '', '::@version@::', '::') + 'autokey::stnameb2';
  EXPORT i_auto_stname(STRING version = (STRING8)Std.Date.Today())            := prefix + IF(version != '', '::@version@::', '::') + 'autokey::stname';
  EXPORT i_auto_zipb2(STRING version = (STRING8)Std.Date.Today())             := prefix + IF(version != '', '::@version@::', '::') + 'autokey::zipb2';
  EXPORT i_auto_zip(STRING version = (STRING8)Std.Date.Today())               := prefix + IF(version != '', '::@version@::', '::') + 'autokey::zip';

  //all key filename versions
  EXPORT	k_document		      :=	VersionControl.mBuildFilenameVersions(i_document(''),version,i_document());
  EXPORT	k_party	            :=	VersionControl.mBuildFilenameVersions(i_party(''),version,i_party());	
	EXPORT	k_auto_addressb2		:=	VersionControl.mBuildFilenameVersions(i_auto_addressb2(''),version,i_auto_addressb2());
  EXPORT	k_auto_address	    :=	VersionControl.mBuildFilenameVersions(i_auto_address(''),version,i_auto_address());	
	EXPORT	k_auto_citystnameb2 :=	VersionControl.mBuildFilenameVersions(i_auto_citystnameb2(''),version,i_auto_citystnameb2());
  EXPORT	k_auto_citystname	  :=	VersionControl.mBuildFilenameVersions(i_auto_citystname(''),version,i_auto_citystname());	
	EXPORT	k_auto_nameb2		    :=	VersionControl.mBuildFilenameVersions(i_auto_nameb2(''),version,i_auto_nameb2());
  EXPORT	k_auto_namewords2	  :=	VersionControl.mBuildFilenameVersions(i_auto_namewords2(''),version,i_auto_namewords2());	
  EXPORT	k_auto_name		      :=	VersionControl.mBuildFilenameVersions(i_auto_name(''),version,i_auto_name());
  EXPORT	k_auto_payload	    :=	VersionControl.mBuildFilenameVersions(i_auto_payload(''),version,i_auto_payload());	
  EXPORT	k_auto_stnameb2		  :=	VersionControl.mBuildFilenameVersions(i_auto_stnameb2(''),version,i_auto_stnameb2());
  EXPORT	k_auto_stname	      :=	VersionControl.mBuildFilenameVersions(i_auto_stname(''),version,i_auto_stname());	
	EXPORT	k_auto_zipb2		    :=	VersionControl.mBuildFilenameVersions(i_auto_zipb2(''),version,i_auto_zipb2());
  EXPORT	k_auto_zip	        :=	VersionControl.mBuildFilenameVersions(i_auto_zip(''),version,i_auto_zip());	
	
	
	EXPORT	dAll_filenames				:=
		k_document.dAll_filenames +
		k_party.dAll_filenames + 
		k_auto_addressb2.dAll_filenames +
		k_auto_address.dAll_filenames +
		k_auto_citystnameb2.dAll_filenames +
		k_auto_citystname.dAll_filenames +
		k_auto_nameb2.dAll_filenames +
		k_auto_namewords2.dAll_filenames +
		k_auto_name.dAll_filenames +
		k_auto_payload.dAll_filenames +
		k_auto_stnameb2.dAll_filenames +
		k_auto_stname.dAll_filenames +
		k_auto_zipb2.dAll_filenames +
		k_auto_zip.dAll_filenames;
		
END;
	
	