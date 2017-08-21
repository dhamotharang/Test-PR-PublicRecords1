import	Autokey,DID_Add,Doxie,Risk_Indicators,RoxieKeyBuild,Ut;
	
export	proc_build_keydiff(string	pVersion)	:=
function

	lVersionCurrent		:=	pVersion;
	lVersionPrevious	:=	did_add.get_EnvVariable('DeathMaster_Build_Version')	:	independent;
	
	kOld_key_death_master_did						:=	index(doxie.key_death_master_did,'~thor_data400::key::death_master::'	+	lVersionPrevious	+	'::did');
	kNew_key_death_master_did						:=	index(doxie.key_death_master_did,'~thor_data400::key::death_master::'	+	lVersionCurrent		+	'::did');
	
	kOld_key_death_id_base							:=	index(death_master.key_death_id_base,'~thor_data400::key::death_masterv2::'	+	lVersionPrevious	+	'::death_id');
	kNew_key_death_id_base							:=	index(death_master.key_death_id_base,'~thor_data400::key::death_masterv2::'	+	lVersionCurrent		+	'::death_id');
	
	kOld_key_death_id_supplemental			:=	index(death_master.key_death_id_supplemental,'~thor_data400::key::death_supplemental::'	+	lVersionPrevious	+	'::death_id');
	kNew_key_death_id_supplemental			:=	index(death_master.key_death_id_supplemental,'~thor_data400::key::death_supplemental::'	+	lVersionCurrent		+	'::death_id');
	
	kOld_key_death_masterV2_DID					:=	index(Doxie.key_death_masterV2_DID,'~thor_data400::key::death_masterv2::'	+	lVersionPrevious	+	'::did');
	kNew_key_death_masterV2_DID					:=	index(Doxie.key_death_masterV2_DID,'~thor_data400::key::death_masterv2::'	+	lVersionCurrent		+	'::did');
	
	kOld_Key_dod												:=	index(Death_Master.key_dod,'~thor_data400::key::death_masterv2::'	+	lVersionPrevious	+	'::dod');
	kNew_Key_dod												:=	index(Death_Master.key_dod,'~thor_data400::key::death_masterv2::'	+	lVersionCurrent		+	'::dod');
	
	kOld_Key_dob												:=	index(Death_Master.key_dob,'~thor_data400::key::death_masterv2::'	+	lVersionPrevious	+	'::dob');
	kNew_Key_dob												:=	index(Death_Master.key_dob,'~thor_data400::key::death_masterv2::'	+	lVersionCurrent		+	'::dob');
		
	kOld_Key_Address_Table_V4						:=	index(Risk_Indicators.Key_Address_Table_v4,'~thor_data400::key::death_master::'	+	lVersionPrevious	+	'::address_table_v4');
	kNew_Key_Address_Table_V4						:=	index(Risk_Indicators.Key_Address_Table_v4,'~thor_data400::key::death_master::'	+	lVersionCurrent		+	'::address_table_v4');
	
	kOld_Key_ADL_Risk_Table_v4					:=	index(Risk_Indicators.Key_ADL_Risk_Table_v4,'~thor_data400::key::death_master::'	+	lVersionPrevious	+	'::adl_risk_table_v4');
	kNew_Key_ADL_Risk_Table_v4					:=	index(Risk_Indicators.Key_ADL_Risk_Table_v4,'~thor_data400::key::death_master::'	+	lVersionCurrent		+	'::adl_risk_table_v4');
	
	kOld_Key_SSN_Table_v4								:=	index(Risk_Indicators.Key_SSN_Table_v4,'~thor_data400::key::death_master::'	+	lVersionPrevious	+	'::ssn_table_v4');
	kNew_Key_SSN_Table_v4								:=	index(Risk_Indicators.Key_SSN_Table_v4,'~thor_data400::key::death_master::'	+	lVersionCurrent		+	'::ssn_table_v4');
	
	kOld_Key_SSN_Table_v4_filtered			:=	index(Risk_Indicators.Key_SSN_Table_v4_filtered,'~thor_data400::key::death_master::'	+	lVersionPrevious	+	'::ssn_table_v4_filtered');
	kNew_Key_SSN_Table_v4_filtered			:=	index(Risk_Indicators.Key_SSN_Table_v4_filtered,'~thor_data400::key::death_master::'	+	lVersionCurrent		+	'::ssn_table_v4_filtered');

	// Autokeys
	kOld_key_AutokeyPayload							:=	index(Death_Master.key_AutokeyPayload,'~thor_data400::key::death_masterv2::'	+	lVersionPrevious	+	'::autokey::payload');
	kNew_key_AutokeyPayload							:=	index(Death_Master.key_AutokeyPayload,'~thor_data400::key::death_masterv2::'	+	lVersionCurrent		+	'::autokey::payload');

	dAddress						:=	DATASET([],Autokey.Layout_Address);
	Key_Address					:=	INDEX(dAddress,{dAddress},'Address');
	kOld_Key_Address		:=	index(Key_Address,'~thor_data400::key::death_masterv2::'	+	lVersionPrevious	+	'::autokey::address');
	kNew_Key_Address		:=	index(Key_Address,'~thor_data400::key::death_masterv2::'	+	lVersionCurrent		+	'::autokey::address');

	dCityStName					:=	DATASET([],Autokey.Layout_CityStName);
	Key_CityStName			:=	INDEX(dCityStName,{dCityStName},'CityStName');
	kOld_Key_CityStName	:=	index(Key_CityStName,'~thor_data400::key::death_masterv2::'	+	lVersionPrevious	+	'::autokey::citystname');
	kNew_Key_CityStName	:=	index(Key_CityStName,'~thor_data400::key::death_masterv2::'	+	lVersionCurrent		+	'::autokey::citystname');

	dName								:=	DATASET([],Autokey.Layout_Name);
	Key_Name						:=	INDEX(dName,{dName},'Name');
	kOld_Key_Name				:=	index(Key_Name,'~thor_data400::key::death_masterv2::'	+	lVersionPrevious	+	'::autokey::name');
	kNew_Key_Name				:=	index(Key_Name,'~thor_data400::key::death_masterv2::'	+	lVersionCurrent		+	'::autokey::name');

	dStName							:=	DATASET([],Autokey.Layout_StName);
	Key_StName					:=	INDEX(dStName,{dStName},'StName');
	kOld_Key_StName			:=	index(Key_StName,'~thor_data400::key::death_masterv2::'	+	lVersionPrevious	+	'::autokey::stname');
	kNew_Key_StName			:=	index(Key_StName,'~thor_data400::key::death_masterv2::'	+	lVersionCurrent		+	'::autokey::stname');

	dZip								:=	DATASET([],Autokey.Layout_Zip);
	Key_Zip							:=	INDEX(dZip,{dZip},'Zip');
	kOld_Key_Zip				:=	index(Key_Zip,'~thor_data400::key::death_masterv2::'	+	lVersionPrevious	+	'::autokey::zip');
	kNew_Key_Zip				:=	index(Key_Zip,'~thor_data400::key::death_masterv2::'	+	lVersionCurrent		+	'::autokey::zip');

	dSSN2								:=	DATASET([],Autokey.Layout_SSN2);
	Key_SSN2						:=	INDEX(dSSN2,{dSSN2},'SSN2');
	kOld_Key_SSN2				:=	index(Key_SSN2,'~thor_data400::key::death_masterv2::'	+	lVersionPrevious	+	'::autokey::ssn2');
	kNew_Key_SSN2				:=	index(Key_SSN2,'~thor_data400::key::death_masterv2::'	+	lVersionCurrent		+	'::autokey::ssn2');

	// Build Keydiff indexes
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(kOld_key_death_master_did,kNew_key_death_master_did,'~thor_data400::keydiff::death_master::'	+	lVersionCurrent	+	'::did',kd1);
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(kOld_key_death_id_base,kNew_key_death_id_base,'~thor_data400::keydiff::death_masterv2::'	+	lVersionCurrent	+	'::death_id',kd2);
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(kOld_key_death_id_supplemental,kNew_key_death_id_supplemental,'~thor_data400::keydiff::death_supplemental::'	+	lVersionCurrent	+	'::death_id',kd3);
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(kOld_key_death_masterV2_DID,kNew_key_death_masterV2_DID,'~thor_data400::keydiff::death_masterv2::'	+	lVersionCurrent	+	'::did',kd4);
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(kOld_key_AutokeyPayload,kNew_key_AutokeyPayload,'~thor_data400::keydiff::death_masterv2::'	+	lVersionCurrent	+	'::autokey::payload',kd5);
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(kOld_Key_Address,kNew_Key_Address,'~thor_data400::keydiff::death_masterv2::'	+	lVersionCurrent	+	'::autokey::address',kd6);
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(kOld_Key_CityStName,kNew_Key_CityStName,'~thor_data400::keydiff::death_masterv2::'	+	lVersionCurrent	+	'::autokey::citystname',kd7);
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(kOld_Key_Name,kNew_Key_Name,'~thor_data400::keydiff::death_masterv2::'	+	lVersionCurrent	+	'::autokey::name',kd8);
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(kOld_Key_StName,kNew_Key_StName,'~thor_data400::keydiff::death_masterv2::'	+	lVersionCurrent	+	'::autokey::stname',kd9);
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(kOld_Key_Zip,kNew_Key_Zip,'~thor_data400::keydiff::death_masterv2::'	+	lVersionCurrent	+	'::autokey::zip',kd10);
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(kOld_Key_SSN2,kNew_Key_SSN2,'~thor_data400::keydiff::death_masterv2::'	+	lVersionCurrent	+	'::autokey::ssn2',kd11);
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(kOld_Key_dod,kNew_Key_dod,'~thor_data400::keydiff::death_masterv2::'	+	lVersionCurrent	+	'::dod',kd12);
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(kOld_Key_dob,kNew_Key_dob,'~thor_data400::keydiff::death_masterv2::'	+	lVersionCurrent	+	'::dob',kd13);
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(kOld_Key_Address_Table_V4,kNew_Key_Address_Table_v4,'~thor_data400::keydiff::death_master::'	+	lVersionCurrent	+	'::address_table_v4',kd19);
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(kOld_Key_ADL_Risk_Table_v4,kNew_Key_ADL_Risk_Table_v4,'~thor_data400::keydiff::death_master::'	+	lVersionCurrent	+	'::adl_risk_table_v4',kd21);
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(kOld_Key_SSN_Table_v4,kNew_Key_SSN_Table_v4,'~thor_data400::keydiff::death_master::'	+	lVersionCurrent	+	'::ssn_table_v4',kd23);
	RoxieKeyBuild.Mac_SKDiff_BuildProcess(kOld_Key_SSN_Table_v4_filtered,kNew_Key_SSN_Table_v4_filtered,'~thor_data400::keydiff::death_master::'	+	lVersionCurrent	+	'::ssn_table_v4_filtered',kd24);
	
	// Move to Built superfiles
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::keydiff::death_master::@version@::did','~thor_data400::keydiff::death_master::'	+	lVersionCurrent	+	'::did',mv_built_kd1);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::keydiff::death_masterv2::@version@::death_id','~thor_data400::keydiff::death_masterv2::'	+	lVersionCurrent	+	'::death_id',mv_built_kd2);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::keydiff::death_supplemental::@version@::death_id','~thor_data400::keydiff::death_supplemental::'	+	lVersionCurrent	+	'::death_id',mv_built_kd3);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::keydiff::death_masterv2::@version@::did','~thor_data400::keydiff::death_masterv2::'	+	lVersionCurrent	+	'::did',mv_built_kd4);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::keydiff::death_masterv2::@version@::autokey::payload','~thor_data400::keydiff::death_masterv2::'	+	lVersionCurrent	+	'::autokey::payload',mv_built_kd5);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::keydiff::death_masterv2::@version@::autokey::address','~thor_data400::keydiff::death_masterv2::'	+	lVersionCurrent	+	'::autokey::address',mv_built_kd6);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::keydiff::death_masterv2::@version@::autokey::citystname','~thor_data400::keydiff::death_masterv2::'	+	lVersionCurrent	+	'::autokey::citystname',mv_built_kd7);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::keydiff::death_masterv2::@version@::autokey::name','~thor_data400::keydiff::death_masterv2::'	+	lVersionCurrent	+	'::autokey::name',mv_built_kd8);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::keydiff::death_masterv2::@version@::autokey::stname','~thor_data400::keydiff::death_masterv2::'	+	lVersionCurrent	+	'::autokey::stname',mv_built_kd9);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::keydiff::death_masterv2::@version@::autokey::zip','~thor_data400::keydiff::death_masterv2::'	+	lVersionCurrent	+	'::autokey::zip',mv_built_kd10);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::keydiff::death_masterv2::@version@::autokey::ssn2','~thor_data400::keydiff::death_masterv2::'	+	lVersionCurrent	+	'::autokey::ssn2',mv_built_kd11);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::keydiff::death_masterv2::@version@::dod','~thor_data400::keydiff::death_masterv2::'	+	lVersionCurrent	+	'::dod',mv_built_kd12);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::keydiff::death_masterv2::@version@::dob','~thor_data400::keydiff::death_masterv2::'	+	lVersionCurrent	+	'::dob',mv_built_kd13);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::keydiff::death_master::@version@::address_table_v4','~thor_data400::keydiff::death_master::'	+	lVersionCurrent	+	'::address_table_v4',mv_built_kd19);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::keydiff::death_master::@version@::adl_risk_table_v4','~thor_data400::keydiff::death_master::'	+	lVersionCurrent	+	'::adl_risk_table_v4',mv_built_kd21);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::keydiff::death_master::@version@::ssn_table_v4','~thor_data400::keydiff::death_master::'	+	lVersionCurrent	+	'::ssn_table_v4',mv_built_kd23);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::keydiff::death_master::@version@::ssn_table_v4_filtered','~thor_data400::keydiff::death_master::'	+	lVersionCurrent	+	'::ssn_table_v4_filtered',mv_built_kd24);
	
	// Move to QA superfiles
	RoxieKeyBuild.Mac_SK_Move_v3('~thor_data400::keydiff::death_master::@version@::did','Q',mv_qa_kd1,lVersionCurrent);
	RoxieKeyBuild.Mac_SK_Move_v3('~thor_data400::keydiff::death_masterv2::@version@::death_id','Q',mv_qa_kd2,lVersionCurrent);
	RoxieKeyBuild.Mac_SK_Move_v3('~thor_data400::keydiff::death_supplemental::@version@::death_id','Q',mv_qa_kd3,lVersionCurrent);
	RoxieKeyBuild.Mac_SK_Move_v3('~thor_data400::keydiff::death_masterv2::@version@::did','Q',mv_qa_kd4,lVersionCurrent);
	RoxieKeyBuild.Mac_SK_Move_v3('~thor_data400::keydiff::death_masterv2::@version@::autokey::payload','Q',mv_qa_kd5,lVersionCurrent);
	RoxieKeyBuild.Mac_SK_Move_v3('~thor_data400::keydiff::death_masterv2::@version@::autokey::address','Q',mv_qa_kd6,lVersionCurrent);
	RoxieKeyBuild.Mac_SK_Move_v3('~thor_data400::keydiff::death_masterv2::@version@::autokey::citystname','Q',mv_qa_kd7,lVersionCurrent);
	RoxieKeyBuild.Mac_SK_Move_v3('~thor_data400::keydiff::death_masterv2::@version@::autokey::name','Q',mv_qa_kd8,lVersionCurrent);
	RoxieKeyBuild.Mac_SK_Move_v3('~thor_data400::keydiff::death_masterv2::@version@::autokey::stname','Q',mv_qa_kd9,lVersionCurrent);
	RoxieKeyBuild.Mac_SK_Move_v3('~thor_data400::keydiff::death_masterv2::@version@::autokey::zip','Q',mv_qa_kd10,lVersionCurrent);
	RoxieKeyBuild.Mac_SK_Move_v3('~thor_data400::keydiff::death_masterv2::@version@::autokey::ssn2','Q',mv_qa_kd11,lVersionCurrent);
	RoxieKeyBuild.Mac_SK_Move_v3('~thor_data400::keydiff::death_masterv2::@version@::dod','Q',mv_qa_kd12,lVersionCurrent);
	RoxieKeyBuild.Mac_SK_Move_v3('~thor_data400::keydiff::death_masterv2::@version@::dob','Q',mv_qa_kd13,lVersionCurrent);
	RoxieKeyBuild.Mac_SK_Move_v3('~thor_data400::keydiff::death_master::@version@::address_table_v4','Q',mv_qa_kd19,lVersionCurrent);
	RoxieKeyBuild.Mac_SK_Move_v3('~thor_data400::keydiff::death_master::@version@::adl_risk_table_v4','Q',mv_qa_kd21,lVersionCurrent);
	RoxieKeyBuild.Mac_SK_Move_v3('~thor_data400::keydiff::death_master::@version@::ssn_table_v4','Q',mv_qa_kd23,lVersionCurrent);
	RoxieKeyBuild.Mac_SK_Move_v3('~thor_data400::keydiff::death_master::@version@::ssn_table_v4_filtered','Q',mv_qa_kd24,lVersionCurrent);
	
	build_keydiff	:=	sequential(	parallel(	kd1,kd2,kd3,kd4,kd5,kd6,kd7,kd8,kd9,kd10,kd11,kd12,kd13,kd19,kd21,kd23,kd24
																				),
																parallel(	mv_built_kd1,mv_built_kd2,mv_built_kd3,mv_built_kd4,mv_built_kd5,
																					mv_built_kd6,mv_built_kd7,mv_built_kd8,mv_built_kd9,mv_built_kd10,
																					mv_built_kd11,mv_built_kd12,mv_built_kd13,mv_built_kd19,
																					mv_built_kd21,mv_built_kd23,mv_built_kd24
																				),
																parallel(	mv_qa_kd1,mv_qa_kd2,mv_qa_kd3,mv_qa_kd4,mv_qa_kd5,mv_qa_kd6,mv_qa_kd7,
																					mv_qa_kd8,mv_qa_kd9,mv_qa_kd10,mv_qa_kd11,mv_qa_kd12,mv_qa_kd13,mv_qa_kd19,
																					mv_qa_kd21,mv_qa_kd23,mv_qa_kd24
																				)
															);

	return build_keydiff;
end;