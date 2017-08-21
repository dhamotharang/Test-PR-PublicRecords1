IMPORT VersionControl,_Control, ut, lib_fileservices,hms, tools;

SEPARATOR := '::';
HmsDirName := 'hms_pm';
//HmsDirName := 'hms_Temp';
FullFilePathAndVersion(STRING fileName, STRING pVersion) :=
					'~thor400_data::in::' 
					+ HmsDirName + '::' 
					+ fileName 
					+ SEPARATOR 
					+ pVersion;

TabFileName(STRING fileName) :=
					fileName + '.tab';
FullFilePath(STRING fileName) :=
					'~thor400_data::in::' 
					+ HmsDirName + '::' 
					+ fileName;

SprayItem(STRING fileName, STRING pServerIP, STRING pDirectory, STRING pGroupName, STRING pVersion) :=
  DATASET([		
		{
		 pServerIP
		,pDirectory
		,TabFileName(fileName)
		,0
    ,FullFilePathAndVersion(fileName, pVersion)
		,[{FullFilePath(fileName)}]
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
	STRING    pIndividualFilename               = 'HMS_Individuals',
	STRING    pIndividualAddressesFilename      = 'HMS_Individual_Addresses',
	STRING    pIndividualStateLicensesFilename  = 'HMS_Individual_State_Licenses',
	STRING    pIndividualDeaFilename            = 'HMS_Individual_DEA',
	STRING    pIndividualStateCsrFilename       = 'HMS_Individual_State_CSR',
	STRING    pIndividualSanctionsFilename      = 'HMS_Individual_Sanctions',
	STRING    pIndividualGsaSanctionsFilename   = 'HMS_Individual_GSA_Sanctions',
	STRING    pStateLicenseTypesFilename        = 'HMS_State_License_Types',

  STRING		pIndividualAddressFaxes						= 'HMS_Individual_Address_Faxes',
  STRING		pIndividualAddressPhones					= 'HMS_Individual_Address_Phones',
  STRING		pIndividualCertifications					= 'HMS_Individual_Certifications',
  STRING		pIndividualCoveredRecipients			= 'HMS_Individual_Covered_Recipients',
  STRING		pIndividualEducation							= 'HMS_Individual_Education',
  STRING		pIndividualLanguages							= 'HMS_Individual_Languages',
  STRING		pIndividualSpecialty							= 'HMS_Individual_Specialty',
	STRING		pPiidMigration										= 'HMS_PIID_Migration',

	STRING		pDirectory												= '/hms/hms_pm/' + pVersion,
//	STRING		pDirectory												= '/enclarity/HMS/' + pVersion,
	STRING		pGroupName												= IF((tools._Constants.IsDataland),'thor400_dev01','thor400_44'),
	BOOLEAN		pIsTesting												= false,
	BOOLEAN		pOverwrite												= true,
	STRING		pNameOutput												= 'HMS Source Files Info Spray Report'

) :=

  SprayItem(pIndividualFilename, pServerIP, pDirectory, pGroupName, pVersion)
	+ SprayItem(pIndividualAddressesFilename, pServerIP, pDirectory, pGroupName, pVersion)
	+ SprayItem(pIndividualStateLicensesFilename, pServerIP, pDirectory, pGroupName, pVersion)
	+ SprayItem(pIndividualDeaFilename, pServerIP, pDirectory, pGroupName, pVersion)
	+ SprayItem(pIndividualStateCsrFilename, pServerIP, pDirectory, pGroupName, pVersion)
	+ SprayItem(pIndividualSanctionsFilename, pServerIP, pDirectory, pGroupName, pVersion)
	+ SprayItem(pIndividualGsaSanctionsFilename, pServerIP, pDirectory, pGroupName, pVersion)
	+ SprayItem(pStateLicenseTypesFilename, pServerIP, pDirectory, pGroupName, pVersion)
	
	+ SprayItem(pIndividualAddressFaxes, pServerIP, pDirectory, pGroupName, pVersion)
	+ SprayItem(pIndividualAddressPhones, pServerIP, pDirectory, pGroupName, pVersion)
	+ SprayItem(pIndividualCertifications, pServerIP, pDirectory, pGroupName, pVersion)
	+ SprayItem(pIndividualCoveredRecipients, pServerIP, pDirectory, pGroupName, pVersion)
	+ SprayItem(pIndividualEducation, pServerIP, pDirectory, pGroupName, pVersion)
	+ SprayItem(pIndividualLanguages, pServerIP, pDirectory, pGroupName, pVersion)
	+ SprayItem(pIndividualSpecialty, pServerIP, pDirectory, pGroupName, pVersion)
	+ SprayItem(pPiidMigration, pServerIP, pDirectory, pGroupName, pVersion)
	;
	