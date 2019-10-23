IMPORT	Data_Services, Header;
EXPORT	Files	:=
MODULE
	
	EXPORT	STRING	vCaliforniaFileName			:=	Death_Master.Constants('').Cluster	+	'in::ca_deathm_raw::sprayed::data';
	EXPORT	STRING	vConnecticutFileName		:=	Death_Master.Constants('').Cluster	+	'in::ct_deathm_raw::sprayed::data';
	EXPORT	STRING	vFloridaFileName				:=	Death_Master.Constants('').Cluster	+	'in::fl_deathm_raw::sprayed::data';
	EXPORT	STRING	vGeorgiaFileName				:=	Death_Master.Constants('').Cluster	+	'in::ga_deathm_raw::sprayed::data';
	EXPORT	STRING	vKentuckyFileName				:=	Death_Master.Constants('').Cluster	+	'in::ky_deathm_raw::sprayed::data';
	EXPORT	STRING	vMassachusettsFileName	:=	Death_Master.Constants('').Cluster	+	'in::ma_deathm_raw::sprayed::data';
	EXPORT	STRING	vMichiganFileName				:=	Death_Master.Constants('').Cluster	+	'in::mi_deathm_raw::sprayed::data';
	EXPORT	STRING	vMinnesotaFileName			:=	Death_Master.Constants('').Cluster	+	'in::mn_deathm_raw::sprayed::data';
	EXPORT	STRING	vMontanaFileName				:=	Death_Master.Constants('').Cluster	+	'in::mt_deathm_raw::sprayed::data';
	EXPORT	STRING	vNevadaFileName					:=	Death_Master.Constants('').Cluster	+	'in::nv_deathm_raw::sprayed::data';
	EXPORT	STRING	vNorthCarolinaFileName	:=	Death_Master.Constants('').Cluster	+	'in::nc_deathm_raw::sprayed::data';
	EXPORT	STRING	vOhioFileName						:=	Death_Master.Constants('').Cluster	+	'in::oh_deathm_raw::sprayed::data';
	EXPORT	STRING	vVirginiaFileName				:=	Death_Master.Constants('').Cluster	+	'in::va_deathm_raw::sprayed::data';
	EXPORT	STRING	vSSARestrictedFileName	:=	Death_Master.Constants('').Cluster	+ 'in::ssa_deathm_Prepped_SSA';
	EXPORT	STRING	vSSAFileName						:=	Death_Master.Constants('').Cluster	+ 'in::ssa_deathm_Prepped';
	EXPORT	STRING	vStatesFileName					:=	Death_Master.Constants('').Cluster	+ 'in::states_deathm_Prepped';
	EXPORT	STRING	vDeletesFileName				:=	Death_Master.Constants('').Cluster	+	'in::death_master_delete';
	EXPORT	STRING	vDeletesDIDFileName			:=	Death_Master.Constants('').Cluster	+	'in::death_master_delete_did';
	EXPORT	STRING	vResurrections						:=	Death_Master.Constants('').Cluster	+	'base::resurrections_death_masterV3';

	EXPORT	California		:= 	IF(NOTHOR(FileServices.GetSuperFileSubCount(vCaliforniaFileName) <> 0),
																			DATASET(vCaliforniaFileName,Death_Master.Layout_States.California,
																			CSV(HEADING(0), SEPARATOR('\t'), QUOTE(''), MAXLENGTH(100000))));
	EXPORT	Connecticut		:=	IF(NOTHOR(FileServices.GetSuperFileSubCount(vConnecticutFileName) <> 0),
																			DATASET(vConnecticutFileName,Death_Master.Layout_States.Connecticut,
																			CSV(HEADING(0), SEPARATOR(','), QUOTE('"'), MAXLENGTH(100000))));
	EXPORT 	Florida				:=	IF(NOTHOR(FileServices.GetSuperFileSubCount(vFloridaFileName) <> 0),
																			DATASET(vFloridaFileName,Death_Master.Layout_States.Florida,THOR));
	EXPORT 	Georgia				:=	IF(NOTHOR(FileServices.GetSuperFileSubCount(vGeorgiaFileName) <> 0),
																			DATASET(vGeorgiaFileName,Death_Master.Layout_States.Georgia,
																			CSV(SEPARATOR('\t'), QUOTE('"'), MAXLENGTH(100000))));
	EXPORT 	Kentucky			:=	IF(NOTHOR(FileServices.GetSuperFileSubCount(vKentuckyFileName) <> 0),
																			DATASET(vKentuckyFileName,Death_Master.Layout_States.Kentucky,
																			CSV(HEADING(0), SEPARATOR(','), MAXLENGTH(100000))));
	EXPORT 	Massachusetts	:=	IF(NOTHOR(FileServices.GetSuperFileSubCount(vMassachusettsFileName) <> 0),
																			DATASET(vMassachusettsFileName,Death_Master.Layout_States.Massachusetts,
																			CSV(HEADING(0), SEPARATOR('|'), QUOTE('"'), MAXLENGTH(100000))));
	EXPORT	Michigan			:=	IF(NOTHOR(FileServices.GetSuperFileSubCount(vMichiganFileName) <> 0),
																			DATASET(vMichiganFileName,Death_Master.Layout_States.Michigan,THOR)(alias_code in [' ','0','1']));
	EXPORT	Minnesota			:=	IF(NOTHOR(FileServices.GetSuperFileSubCount(vMinnesotaFileName) <> 0),
																			DATASET(vMinnesotaFileName,Death_Master.Layout_States.Minnesota,THOR));
	EXPORT	Montana				:=	IF(NOTHOR(FileServices.GetSuperFileSubCount(vMontanaFileName) <> 0),
																			DATASET(vMontanaFileName,Death_Master.Layout_States.Montana,
																			CSV(SEPARATOR('|'), QUOTE('"'), MAXLENGTH(100000))));
	EXPORT	Nevada				:=	IF(NOTHOR(FileServices.GetSuperFileSubCount(vNevadaFileName) <> 0),
																			DATASET(vNevadaFileName,Death_Master.Layout_States.Nevada,
																			CSV(HEADING(1), SEPARATOR(','), QUOTE('"'), MAXLENGTH(100000))));
	EXPORT	NorthCarolina	:=	IF(NOTHOR(FileServices.GetSuperFileSubCount(vNorthCarolinaFileName) <> 0),
																			DATASET(vNorthCarolinaFileName,Death_Master.Layout_States.NorthCarolina,THOR)(void_flag='0' AND alias_flag='0'));
	EXPORT	Ohio					:=	IF(NOTHOR(FileServices.GetSuperFileSubCount(vOhioFileName) <> 0),
																			DATASET(vOhioFileName,Death_Master.Layout_States.Ohio,
																			CSV(SEPARATOR(','), QUOTE('"'), MAXLENGTH(100000))));					
	EXPORT	Virginia			:=	IF(NOTHOR(FileServices.GetSuperFileSubCount(vVirginiaFileName) <> 0),
																			DATASET(vVirginiaFileName,Death_Master.Layout_States.Virginia,
																			CSV(SEPARATOR('\t'), QUOTE('"'), MAXLENGTH(100000))));					
	EXPORT	SSA_File						:=	DATASET(vSSAFileName,Death_Master.Layout_States.Death_Master_Base,FLAT);
	EXPORT	SSA_File_Restricted	:=	DATASET(vSSARestrictedFileName,Death_Master.Layout_States.Death_Master_Base,FLAT);
	EXPORT	States_File					:=	DATASET(vStatesFileName,Header.layout_death_master_supplemental,FLAT);
	EXPORT	Deletes							:=	DATASET(vDeletesFileName,Death_Master.Layouts.Deletes,THOR);
	EXPORT	Deletes_DID					:=	DATASET(vDeletesDIDFileName,Death_Master.Layouts.DID_V1,THOR);
	EXPORT	Resurrections		:=	DATASET(vResurrections,	{Header.Layout_Did_Death_MasterV3;	STRING1 resurrect;},THOR);

	// To manually suppress a record add the the record in V3 Format to this dataset.
	EXPORT	dSuppressRecs				:=	Death_Master.File_Death_Master_Suppression;
	EXPORT	BadSSNSet						:=	SET(dSuppressRecs(TRIM(ssn,ALL)<>''),ssn);
	EXPORT	BadDIDSet						:=	SET(dSuppressRecs((UNSIGNED)did>0),(UNSIGNED)did);
	EXPORT	BadStateDIDSet			:=	SET(dSuppressRecs(TRIM(state_death_id,ALL)<>''),state_death_id);
	
END;
