
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
		'PDPM',
		'LexIdSourceOptout',
    'ViewFDC',
		'IncludeAccident',
		'IncludeAddress',
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
		'IncludeGeolink',
		'IncludeHousehold',
		'IncludeInquiry',
		'IncludeLienJudgment',
		'IncludePerson',
		'IncludePhone',
		'IncludeProfessionalLicense',
		'IncludeProperty',
		'IncludePropertyEvent',
		'IncludeSurname',
		'IncludeSocialSecurityNumber',
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

		UNSIGNED8 PDPM := 0  : STORED('PDPM');
		BOOLEAN ViewFDC := FALSE : STORED('ViewFDC');
		STD.Date.Date_t dtArchiveDate := STD.Date.Today() : STORED('InputArchiveDateClean');

	Options := MODULE(PublicRecords_KEL.Interface_Options)
		EXPORT STRING100 AttributeSetName           := '';
		EXPORT STRING100 VersionName                := '';
		EXPORT BOOLEAN isFCRA                   		 := is_fcra;
		EXPORT STRING8 ArchiveDate               		 := (STRING)dtArchiveDate;
		EXPORT STRING250 InputFileName              := '';
		EXPORT STRING100 PermissiblePurpose         := '';
		EXPORT STRING IndustryClass        					 := '';
		EXPORT UNSIGNED1 LexIdSourceOptout := _LexIdSourceOptout;
		EXPORT STRING100 Data_Restriction_Mask      := Default_data_restriction_mask : STORED('DataRestrictionMask');
		EXPORT STRING100 Data_Permission_Mask       := Default_data_permission_mask : STORED('DataPermissionMask');
		EXPORT UNSIGNED GLBAPurpose              := 1 : STORED('GLBA');
		EXPORT UNSIGNED DPPAPurpose              := 2 : STORED('DPPA');
		EXPORT BOOLEAN Override_Experian_Restriction := FALSE;
		EXPORT STRING100 Allowed_Sources            := '';
		EXPORT INTEGER ScoreThreshold            := 80 : STORED('ScoreThreshold');
		EXPORT BOOLEAN ExcludeConsumerShell      := FALSE;
		EXPORT BOOLEAN isMarketing               := FALSE : STORED('IsMarketing');
		EXPORT UNSIGNED8 KEL_Permissions_Mask    := 0; // Set by PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.Generate()
		EXPORT BOOLEAN OutputMasterResults       := FALSE;
		EXPORT UNSIGNED BIPAppendScoreThreshold  := 75;
		EXPORT UNSIGNED BIPAppendWeightThreshold := 0;
		EXPORT BOOLEAN BIPAppendPrimForce        := FALSE;
		EXPORT BOOLEAN BIPAppendReAppend         := TRUE;
		EXPORT BOOLEAN BIPAppendIncludeAuthRep   := TRUE;

		EXPORT BOOLEAN IncludeAccident := TRUE: STORED('IncludeAccident');
		EXPORT BOOLEAN IncludeAddress := TRUE: STORED('IncludeAddress');
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
		EXPORT BOOLEAN IncludeGeolink := TRUE: STORED('IncludeGeolink');
		EXPORT BOOLEAN IncludeHousehold := TRUE: STORED('IncludeHousehold');
		EXPORT BOOLEAN IncludeInquiry := TRUE: STORED('IncludeInquiry');
		EXPORT BOOLEAN IncludeLienJudgment := TRUE: STORED('IncludeLienJudgment');
		EXPORT BOOLEAN IncludePerson := TRUE: STORED('IncludePerson');
		EXPORT BOOLEAN IncludePhone := TRUE: STORED('IncludePhone');
		EXPORT BOOLEAN IncludeProfessionalLicense := TRUE: STORED('IncludeProfessionalLicense');
		EXPORT BOOLEAN IncludeProperty := TRUE: STORED('IncludeProperty');
		EXPORT BOOLEAN IncludePropertyEvent := TRUE: STORED('IncludePropertyEvent');
		EXPORT BOOLEAN IncludeSocialSecurityNumber := TRUE: STORED('IncludeSocialSecurityNumber');
		EXPORT BOOLEAN IncludeSurname := TRUE: STORED('IncludeSurname');
		EXPORT BOOLEAN IncludeTIN := TRUE: STORED('IncludeTIN');
		EXPORT BOOLEAN IncludeTradeline := TRUE: STORED('IncludeTradeline');
		EXPORT BOOLEAN IncludeUtility := TRUE: STORED('IncludeUtility');
		EXPORT BOOLEAN IncludeVehicle := TRUE: STORED('IncludeVehicle');
		EXPORT BOOLEAN IncludeWatercraft := TRUE: STORED('IncludeWatercraft');
		EXPORT BOOLEAN IncludeZipCode := TRUE: STORED('IncludeZipCode');
		EXPORT BOOLEAN IncludeUCC := TRUE: STORED('IncludeUCC');
		EXPORT BOOLEAN IncludeMini := TRUE: STORED('IncludeMini');
	END;	
	
	BOOLEAN IsInsuranceProduct := FALSE : STORED('IsInsuranceProduct');
	BOOLEAN AllowDNBDMI        := FALSE : STORED('AllowDNBDMI');

	UNSIGNED8 __PDPM_Generated := PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.Generate(
				Options.Data_Restriction_Mask, 
				Options.Data_Permission_Mask, 
				Options.GLBAPurpose, 
				Options.DPPAPurpose, 
				Options.isFCRA, 
				Options.isMarketing, 
				AllowDNBDMI, 
				Options.Override_Experian_Restriction, 
				Options.PermissiblePurpose, 
				Options.IndustryClass, 
				PublicRecords_KEL.CFG_Compile,
				IsInsuranceProduct );

	UNSIGNED8 __PDPM := IF( PDPM != 0, PDPM, __PDPM_Generated );
			
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

	OptionsMini := PublicRecords_KEL.Interface_Mini_Options(Options);
	
	FDCDatasetMini := PublicRecords_KEL.Fn_MAS_FDC( Rep1Input, OptionsMini, withBIPIDs);		

	MiniAttributes := PublicRecords_KEL.FnRoxie_GetMiniFDCAttributes(Rep1Input, FDCDatasetMini, OptionsMini); 

	FDCDataset := PublicRecords_KEL.Fn_MAS_FDC( Rep1Input, Options,withBIPIDs,FDCDatasetMini );

	ds_slim := project(FDCDataset, transform(PublicRecords_KEL.ECL_Functions.Layouts_FDC(Options).Layout_FDC, self.UIDAppend := left.UIDAppend, self :=[]));

	ds_out := if(ViewFDC, FDCDataset, ds_slim);

	OUTPUT(ds_out, NAMED('FDCDataset'));
			
ENDMACRO;			