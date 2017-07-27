IMPORT VersionControl,_Control, ut, lib_fileservices,Org_Mast, tools;

tabFileNamePrefix := '';                          //prefix for files BEING copied (source files)
//tabFileNamePrefix := 'org_master_',
destFileNamePrefix := 'org_master_';              //prefix for filename of destination files
destSuperFileNamePrefix := 'org_master_';         //prefix for name of superfile 
                                                  // In-File Name = thor400_data::in::EEEEEE::PPPPPPNNNNNN
                                                  // where: 
																									//    EEEEEE = OrganizationDirName
																									//    PPPPPP = destSuperFileNamePrefix
																									//    NNNNNN = filename in list below; i.e. ahaFilename

SEPARATOR := '::';
OrganizationDirName := 'org_master';  //Org_Mast spray dir destination
FullFilePathAndVersion(STRING fileName, STRING pVersion) :=   //full name of the in-file on the cluster
					'~thor400_data::in::' 
					+ OrganizationDirName + '::' 
					+ destFileNamePrefix 
					+ fileName 
					+ SEPARATOR 
					+ pVersion;

TabFileName(STRING fileName) :=                  // the tab files are the files TO BE COPIED from the windows server
					fileName + '.tab';
FullFilePath(STRING fileName) :=                 // full pathname of the superfile to which the in-file will be copied
					'~thor400_data::in::' 
					+ OrganizationDirName + '::' 
					+ destSuperFileNamePrefix
					+ fileName;

SprayItem(STRING fileName, STRING pServerIP, STRING pDirectory, STRING pGroupName, STRING pVersion) :=
  DATASET([		
		{
		 pServerIP
		,pDirectory
		,TabFileName(fileName)                       //tab file name in the landing zone
		,0
    ,FullFilePathAndVersion(fileName, pVersion)  //full filename of in-file on the cluster
		,[{FullFilePath(fileName)}]                  //full pathname of the superfile to which the in-file will be copied
		,pGroupName
		,pVersion
		,''
		,'VARIABLE'
		,''
		,8192
		,'\\t'
		}
	], VersionControl.Layout_Sprays.Info);

EXPORT fSpray(
	STRING		pVersion              						= '',
	BOOLEAN   pUseProd              						= false,
	STRING		pServerIP							            = _control.IPAddress.edata12, //'edata12-bld.br.seisint.com'
//	STRING		pServerIP												= 'edata12.br.seisint.com',
	STRING    ahaFilename               				= tabFileNamePrefix + 'aha',
	STRING    crosswalkFilename               	= tabFileNamePrefix + 'crosswalk',
	STRING    deaFilename               				= tabFileNamePrefix + 'dea',
	STRING    npiFilename               				= tabFileNamePrefix + 'npi',
	STRING    organizationFilename              = tabFileNamePrefix + 'organization',
	STRING    posFilename               				= tabFileNamePrefix + 'pos',
	STRING    affiliationsFilename							= tabFileNamePrefix + 'affiliations',

	STRING		pDirectory												= '/hms/org_mf/' + pVersion,   //'/enclarity/HMS/' + pVersion,
	STRING		pGroupName												= IF((tools._Constants.IsDataland),'thor400_dev01','thor400_30'),
	BOOLEAN		pIsTesting												= false,
	BOOLEAN		pOverwrite												= true,
	STRING		pNameOutput												= 'Organization Master Files Source Files Info Spray Report'

) :=

    SprayItem(ahaFilename,       			pServerIP, pDirectory, pGroupName, pVersion)
	+ SprayItem(crosswalkFilename, 			pServerIP, pDirectory, pGroupName, pVersion)
	+ SprayItem(deaFilename,       			pServerIP, pDirectory, pGroupName, pVersion)
	+ SprayItem(npiFilename,       			pServerIP, pDirectory, pGroupName, pVersion)
	+ SprayItem(organizationFilename, 	pServerIP, pDirectory, pGroupName, pVersion)
	+ SprayItem(posFilename,            pServerIP, pDirectory, pGroupName, pVersion)
	+ SprayItem(affiliationsFilename,   pServerIP, pDirectory, pGroupName, pVersion)
	;
