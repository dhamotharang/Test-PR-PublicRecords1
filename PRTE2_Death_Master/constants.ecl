IMPORT tools,ut, _control, Death_Master;


export	Constants	:=
module
	
	EXPORT DEATH_MASTER_IN := '~prte::in::Death_Master_plus';
	EXPORT DEATH_MASTER_BASE := '~prte::base::death_master_plus';

	EXPORT KEYNAME_DEATH_MASTER := 	'~prte::key::';
	
	// autokey
	export	autokey_keyname		:=	'~PRTE::key::death_masterV2::@version@::autokey::';
	export	autokey_logical(string	pFileDate)		:=	'~PRTE::key::death_masterV2::'	+	pFileDate	+	'::autokey::';
	
	export	autokey_keyname_ssa		:=	'~PRTE::key::death_masterV2_ssa::@version@::autokey::';
	export	autokey_logical_ssa(string	pFileDate)		:=	'~PRTE::key::death_masterV2_ssa::'	+	pFileDate	+	'::autokey::';
	
	export	autokey_typeStr		:=	'AK';
	export	autokey_skip_set	:=	['P','Q','F','B'];
	
	export	boolean	workHard			:=	true;
	export	boolean	Search_noFail	:=	false;
	
	
	export	STRING	srcType	:=	'DEATH_MASTER';
	
	export	STRING	srcType_ssa	:=	'DEATH_MASTER_ssa';
		
	export	STRING	qual		:=	'test';

	
	//for regular old search
	export	set_EmptySuppStates	:=	['CT','ME','OH','NV','MT','GA','VA'];
	EXPORT _constants(
	 STRING		state = 'state',
	 BOOLEAN	pUseOtherEnvironment	= FALSE
		) := 
		tools.Constants(
			 pDatasetName					:= state + '_deathm_raw',
			 pUseOtherEnvironment	:= pUseOtherEnvironment,
			 pGroupname						:= '',
			 pMaxRecordSize				:= 8192,
			 pIsTesting						:= Tools._Constants.IsDataland
		);

 //DF-22303: FCRA Consumer Data Field Depreciation:FCRA_DeathMasterSSAKeys
 EXPORT fields_to_clear := Death_Master.Constants('').fields_to_clear;	
end;