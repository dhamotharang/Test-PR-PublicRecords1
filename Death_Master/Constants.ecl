import	ut, Data_Services;

export	Constants(string	pFileDate)	:=
module
	// cluster name
	export	Cluster	:=	Data_Services.Data_location.Prefix('DeathMaster')+'thor_data400::';
	
	// autokey
	export	autokey_keyname		:=	Cluster + 'key::death_masterV2::autokey::';
	export	autokey_logical		:=	Cluster + 'key::death_masterV2::'	+	pFileDate	+	'::autokey::';
	
  export	autokey_keyname_ssa		:=	Cluster + 'key::death_masterV2_ssa::autokey::';
	export	autokey_logical_ssa		:=	Cluster + 'key::death_masterV2_ssa::'	+	pFileDate	+	'::autokey::';
	
	export	autokey_typeStr		:=	'AK';
	export	autokey_skip_set	:=	['P','Q','F','B'];
	
	export	boolean	workHard			:=	true;
	export	boolean	Search_noFail	:=	false;
	
	// boolean search
	export	STRING	stem		:=	'~thor_data400';
	export	STRING	srcType	:=	'DEATH_MASTER';
	
	export	STRING	srcType_ssa	:=	'DEATH_MASTER_ssa';
		
	export	STRING	qual		:=	'test';

	
	//for regular old search
	export	set_EmptySuppStates	:=	['CT','ME','OH','NV','MT','GA','VA'];

	//DF-21696 - list of fields to be deprecated in thor_data400::key::fcra::did_death_masterv2_ssa_qa and thor_data400::key::fcra::death_master_ssa::ssn_qa
	EXPORT fields_to_clear := 'st_country_code,zip_lastpayment';
	
end;