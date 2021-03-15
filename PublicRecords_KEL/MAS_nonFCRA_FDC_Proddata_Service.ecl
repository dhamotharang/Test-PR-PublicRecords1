/*--SOAP--
<message name="MAS_Business_nonFCRA_Service">
	<part name="input" type="tns:XmlDataSet" cols="100" rows="8"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="GLBPurpose" type="xsd:integer"/>
	<part name="DPPAPurpose" type="xsd:integer"/>
	<part name="IsMarketing" type="xsd:boolean"/>
	<part name="TurnOffHouseHolds" type="xsd:boolean"/>
	<part name="TurnOffRelatives" type="xsd:boolean"/>
	<part name="AllowedSourcesDataset" type="tns:XmlDataSet" cols="100" rows="8"/>
	<part name="ExcludeSourcesDataset" type="tns:XmlDataSet" cols="100" rows="8"/>
	<part name="LexIdSourceOptout" type="xsd:integer"/>
	<part name="IncludeAccident,"type=xsd:boolean"/>
	<part name="IncludeAddress,"type=xsd:boolean"/>
	<part name="IncludeAddressSummary,"type=xsd:boolean"/>
	<part name="IncludeAircraft,"type=xsd:boolean"/>
	<part name="IncludeBankruptcy,"type=xsd:boolean"/>
	<part name="IncludeBusinessSele,"type=xsd:boolean"/>
	<part name="IncludeBusinessProx,"type=xsd:boolean"/>
	<part name="IncludeCriminalOffender,"type=xsd:boolean"/>
	<part name="IncludeCriminalOffense,"type=xsd:boolean"/>
	<part name="IncludeCriminalPunishment,"type=xsd:boolean"/>
	<part name="IncludeDriversLicense,"type=xsd:boolean"/>
	<part name="IncludeEducation,"type=xsd:boolean"/>
	<part name="IncludeEmail,"type=xsd:boolean"/>
	<part name="IncludeEmployment,"type=xsd:boolean"/>
	<part name="IncludeGeolink,"type=xsd:boolean"/>
	<part name="IncludeHousehold,"type=xsd:boolean"/>
	<part name="IncludeInquiry,"type=xsd:boolean"/>
	<part name="IncludeLienJudgment,"type=xsd:boolean"/>
	<part name="IncludeNameSummary,"type=xsd:boolean"/>
	<part name="IncludePerson,"type=xsd:boolean"/>
	<part name="IncludePhone,"type=xsd:boolean"/>
	<part name="IncludePhoneSummary,"type=xsd:boolean"/>
	<part name="IncludeProfessionalLicense,"type=xsd:boolean"/>
	<part name="IncludeProperty,"type=xsd:boolean"/>
	<part name="IncludePropertyEvent,"type=xsd:boolean"/>
	<part name="IncludeSurname,"type=xsd:boolean"/>
	<part name="IncludeSocialSecurityNumber,"type=xsd:boolean"/>
	<part name="IncludeSSNSummary,"type=xsd:boolean"/>
	<part name="IncludeTIN,"type=xsd:boolean"/>
	<part name="IncludeTradeline,"type=xsd:boolean"/>
	<part name="IncludeUtility,"type=xsd:boolean"/>
	<part name="IncludeVehicle,"type=xsd:boolean"/>
	<part name="IncludeWatercraft,"type=xsd:boolean"/>
	<part name="IncludeZipCode,"type=xsd:boolean"/>
	<part name="IncludeUCC,"type=xsd:boolean"/>
	<part name="IncludeMini"type=xsd:boolean"/>

</message>
*/

IMPORT Std, PublicRecords_KEL;

export MAS_nonFCRA_FDC_Proddata_Service() := MACRO
	IMPORT KEL11 AS KEL;

	#WEBSERVICE(FIELDS(
    'input',
    'InputArchiveDateClean',
    'DataRestrictionMask',
    'DataPermissionMask',
    'GLBA',
    'DPPA',
		'AllowedSourcesDataset',
		'ExcludeSourcesDataset',
		'LexIdSourceOptout',
		'ViewFDC',
		'IsMarketing',
		'TurnOffHouseHolds',
		'TurnOffRelatives',
		'IncludeAccident',
		'IncludeAddress',
		'IncludeAddressSummary',
		'IncludeAircraft',
		'IncludeBankruptcy',
		'IncludeBusinessSele',
		'IncludeBusinessProx',
		'IncludeCriminalOffender',
		'IncludeCriminalOffense',
		'IncludeCriminalPunishment',
		'IncludeDriversLicense',
		'IncludeEducation',
		'IncludeEmail',
		'IncludeEmployment',
		'IncludeForeclosure',
		'IncludeGeolink',
		'IncludeHousehold',
		'IncludeInquiry',
		'IncludeLienJudgment',
		'IncludeNameSummary',
		'IncludePerson',
		'IncludePhone',
		'IncludePhoneSummary',
		'IncludeProfessionalLicense',
		'IncludeProperty',
		'IncludePropertyEvent',
		'IncludeSurname',
		'IncludeSocialSecurityNumber',
		'IncludeSSNSummary',
		'IncludeTIN',
		'IncludeTradeline',
		'IncludeUtility',
		'IncludeVehicle',
		'IncludeWatercraft',
		'IncludeZipCode',
		'IncludeUCC',
		'IncludeMini'
  ));
		STRING100 Default_data_permission_mask := '11111111111111111111111111111111111111111111111111';	
		#stored('DataPermissionMask',Default_data_permission_mask);

		STRING100 Default_data_restriction_mask := '00000000000000000000000000000000000000000000000000';	
		#stored('DataRestrictionMask',Default_data_restriction_mask);

		layout_input_combined := RECORD
			PublicRecords_KEL.ECL_Functions.Input_Layout;
			PublicRecords_KEL.ECL_Functions.Input_Bus_Layout;
		END;

						UNSIGNED1 _LexIdSourceOptout := 1 : STORED ('LexIdSourceOptout');


		ds_input := DATASET([],layout_input_combined) : STORED('input');
		

		is_fcra := FALSE;

		BOOLEAN ViewFDC := FALSE : STORED('ViewFDC');
		STD.Date.Date_t dtArchiveDate := STD.Date.Today() : STORED('InputArchiveDateClean');

	BOOLEAN IsInsuranceProduct := FALSE : STORED('IsInsuranceProduct');
	BOOLEAN AllowDNBDMI        := FALSE : STORED('AllowDNBDMI');
	STRING100 DataRestrictionMask      := Default_data_restriction_mask : STORED('DataRestrictionMask');
	STRING100 DataPermissionMask       := Default_data_permission_mask : STORED('DataPermissionMask');
	UNSIGNED GLBA              := 1 : STORED('GLBA');
	UNSIGNED DPPA              := 2 : STORED('DPPA');
	BOOLEAN is_Marketing               := FALSE : STORED('IsMarketing');
	BOOLEAN Turn_Off_Relatives               := FALSE : STORED('TurnOffRelatives');
	BOOLEAN Turn_Off_HouseHolds               := FALSE : STORED('TurnOffHouseHolds');
	BOOLEAN OverrideExperianRestriction := FALSE : STORED('OverrideExperianRestriction');
	AllowedSourcesDataset := DATASET([],PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) : STORED('AllowedSourcesDataset');
	ExcludeSourcesDataset := DATASET([],PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) : STORED('ExcludeSourcesDataset');
	// If allowed sources aren't passed in, use default list of allowed sources
	SetAllowedSources := IF(COUNT(AllowedSourcesDataset) = 0, PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_ALLOWED_SOURCES_NONFCRA, AllowedSourcesDataset);
	// If a source is on the Exclude list, remove it from the allowed sources list. 
	FinalAllowedSources := JOIN(SetAllowedSources, ExcludeSourcesDataset, LEFT=RIGHT, TRANSFORM(RECORDOF(LEFT), SELF := LEFT), LEFT ONLY);
	
	Options := MODULE(PublicRecords_KEL.Interface_Options)
		EXPORT STRING100 AttributeSetName           := '';
		EXPORT STRING100 VersionName                := '';
		EXPORT BOOLEAN isFCRA                   		 := is_fcra;
		EXPORT STRING8 ArchiveDate               		 := (STRING)dtArchiveDate;
		EXPORT STRING250 InputFileName              := '';
		EXPORT STRING5 IndustryClass        					 := '';
		EXPORT UNSIGNED1 LexIdSourceOptout := _LexIdSourceOptout;
		EXPORT STRING100 Data_Restriction_Mask      := DataRestrictionMask;
		EXPORT STRING100 Data_Permission_Mask       := DataPermissionMask;
		EXPORT UNSIGNED GLBAPurpose              := GLBA;
		EXPORT UNSIGNED DPPAPurpose              := DPPA;
		EXPORT BOOLEAN Override_Experian_Restriction := OverrideExperianRestriction;
		EXPORT STRING100 Allowed_Sources            := '';
		EXPORT INTEGER ScoreThreshold            := 80 : STORED('ScoreThreshold');
		EXPORT BOOLEAN ExcludeConsumerShell      := FALSE;
		EXPORT BOOLEAN isMarketing               := is_Marketing;
		EXPORT BOOLEAN TurnOffRelatives := Turn_Off_Relatives; 
		EXPORT BOOLEAN TurnOffHouseHolds := Turn_Off_HouseHolds;
		EXPORT DATASET(PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) Allowed_Sources_Dataset := FinalAllowedSources;
		EXPORT DATA57 KEL_Permissions_Mask    := PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.Generate(
				DataRestrictionMask, 
				DataPermissionMask, 
				GLBA, 
				DPPA, 
				is_fcra, 
				is_Marketing, 
				AllowDNBDMI, 
				OverrideExperianRestriction, 
				'', // IntendedPurpose
				'', // IndustryClass
				PublicRecords_KEL.CFG_Compile,
				IsInsuranceProduct,
				FinalAllowedSources);
				
		EXPORT BOOLEAN OutputMasterResults       := FALSE;
		EXPORT UNSIGNED BIPAppendScoreThreshold  := 75;
		EXPORT UNSIGNED BIPAppendWeightThreshold := 0;
		EXPORT BOOLEAN BIPAppendPrimForce        := FALSE;
		EXPORT BOOLEAN BIPAppendReAppend         := TRUE;
		EXPORT BOOLEAN BIPAppendIncludeAuthRep   := TRUE;

		EXPORT BOOLEAN IncludeAccident := TRUE: STORED('IncludeAccident');
		EXPORT BOOLEAN IncludeAddress := TRUE: STORED('IncludeAddress');
		EXPORT BOOLEAN IncludeAddressSummary := TRUE: STORED('IncludeAddressSummary');
		EXPORT BOOLEAN IncludeAircraft := TRUE: STORED('IncludeAircraft');
		EXPORT BOOLEAN IncludeBankruptcy := TRUE: STORED('IncludeBankruptcy');
		EXPORT BOOLEAN IncludeBusinessSele := TRUE: STORED('IncludeBusinessSele');
		EXPORT BOOLEAN IncludeBusinessProx := TRUE: STORED('IncludeBusinessProx');
		EXPORT BOOLEAN IncludeCriminalOffender := TRUE: STORED('IncludeCriminalOffender');
		EXPORT BOOLEAN IncludeCriminalOffense := TRUE: STORED('IncludeCriminalOffense');
		EXPORT BOOLEAN IncludeCriminalPunishment := TRUE: STORED('IncludeCriminalPunishment');
		EXPORT BOOLEAN IncludeDriversLicense := TRUE: STORED('IncludeDriversLicense');
		EXPORT BOOLEAN IncludeEducation := TRUE: STORED('IncludeEducation');
		EXPORT BOOLEAN IncludeEmail := TRUE: STORED('IncludeEmail');
		EXPORT BOOLEAN IncludeEmployment := TRUE: STORED('IncludeEmployment');
		EXPORT BOOLEAN IncludeForeclosure := TRUE: STORED('IncludeForeclosure');
		EXPORT BOOLEAN IncludeGeolink := TRUE: STORED('IncludeGeolink');
		EXPORT BOOLEAN IncludeHousehold := TRUE: STORED('IncludeHousehold');
		EXPORT BOOLEAN IncludeInquiry := TRUE: STORED('IncludeInquiry');
		EXPORT BOOLEAN IncludeLienJudgment := TRUE: STORED('IncludeLienJudgment');
		EXPORT BOOLEAN IncludeNameSummary := TRUE: STORED('IncludeNameSummary');
		EXPORT BOOLEAN IncludePerson := TRUE: STORED('IncludePerson');
		EXPORT BOOLEAN IncludePhone := TRUE: STORED('IncludePhone');
		EXPORT BOOLEAN IncludePhoneSummary := TRUE: STORED('IncludePhoneSummary');
		EXPORT BOOLEAN IncludeProfessionalLicense := TRUE: STORED('IncludeProfessionalLicense');
		EXPORT BOOLEAN IncludeProperty := TRUE: STORED('IncludeProperty');
		EXPORT BOOLEAN IncludePropertyEvent := TRUE: STORED('IncludePropertyEvent');
		EXPORT BOOLEAN IncludeSocialSecurityNumber := TRUE: STORED('IncludeSocialSecurityNumber');
		EXPORT BOOLEAN IncludeSSNSummary := TRUE: STORED('IncludeSSNSummary');
		EXPORT BOOLEAN IncludeSurname := TRUE: STORED('IncludeSurname');
		EXPORT BOOLEAN IncludeTIN := TRUE: STORED('IncludeTIN');
		EXPORT BOOLEAN IncludeTradeline := TRUE: STORED('IncludeTradeline');
		EXPORT BOOLEAN IncludeUtility := TRUE: STORED('IncludeUtility');
		EXPORT BOOLEAN IncludeVehicle := TRUE: STORED('IncludeVehicle');
		EXPORT BOOLEAN IncludeWatercraft := TRUE: STORED('IncludeWatercraft');
		EXPORT BOOLEAN IncludeZipCode := TRUE: STORED('IncludeZipCode');
		EXPORT BOOLEAN IncludeUCC := TRUE: STORED('IncludeUCC');
	END;	

	ds_input_bus := 
		PROJECT(ds_input,
			TRANSFORM( PublicRecords_KEL.ECL_Functions.Input_UID_Bus_Layout,
				SELF.G_ProcBusUID := COUNTER,
				SELF := LEFT;
				SELF := []));		
				
	echoReps := SORT(PublicRecords_KEL.ECL_Functions.Fn_InputEchoBusReps_Roxie( ds_input_bus ), G_ProcBusUID);

	cleanReps := PublicRecords_KEL.ECL_Functions.Fn_CleanInput_Roxie( echoReps );	

	echoBusiness := PublicRecords_KEL.ECL_Functions.Fn_InputEchoBus_Roxie( ds_input_bus );

	cleanBusiness := PublicRecords_KEL.ECL_Functions.Fn_CleanInputBus_Roxie( echoBusiness );	

	withRepLexIDs := PublicRecords_KEL.ECL_Functions.Fn_AppendLexid_Roxie( cleanReps, Options );
	Rep1Input := withRepLexIDs(RepNumber = 1);

	withBIPIDs := PublicRecords_KEL.ECL_Functions.Fn_AppendBIPIDs_Roxie( cleanBusiness, Rep1Input, Options );
	
	FDCDatasetMini := PublicRecords_KEL.Fn_MAS_FDC_Mini( Rep1Input, Options, withBIPIDs);		

	MiniAttributes := PublicRecords_KEL.FnRoxie_GetMiniFDCAttributes(Rep1Input, FDCDatasetMini, Options, options.BestPIIAppend); 

	FDCDataset := PublicRecords_KEL.Fn_MAS_FDC( MiniAttributes, Options,withBIPIDs,FDCDatasetMini );

	ds_slim := project(FDCDataset, transform(PublicRecords_KEL.ECL_Functions.Layouts_FDC(Options).Layout_FDC, self.UIDAppend := left.UIDAppend, self :=[]));

	ds_out := if(ViewFDC, FDCDataset, ds_slim);

	OUTPUT(ds_out, NAMED('FDCDataset'));
			
ENDMACRO;			