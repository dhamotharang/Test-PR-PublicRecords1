import RoxieKeyBuild,PRTE, _control, STD,prte2,tools;

EXPORT proc_build_keys(string filedate) := function

//Foreclosures Keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.Key_FI_Geo11, Constants.key_foreclosure_prefix + 'index_geo11',	Constants.key_foreclosure_prefix+filedate+ '::index_geo11',do1);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.Key_FI_Geo12,	Constants.key_foreclosure_prefix + 'index_geo12',	Constants.key_foreclosure_prefix+filedate+ '::index_geo12',do2);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.Key_FI_fips,	Constants.key_foreclosure_prefix + 'index_fips',	Constants.key_foreclosure_prefix+filedate+ '::index_fips',do3);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.Key_Foreclosures_FID,					Constants.key_foreclosure_prefix 	+'fid',						Constants.key_foreclosure_prefix+ filedate+'::fid',do4);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.Key_Foreclosures_DID,					Constants.key_foreclosure_prefix	+'did',						Constants.key_foreclosure_prefix+ filedate+'::did',do5);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.Key_Foreclosures_BDID,				Constants.key_foreclosure_prefix 	+'bdid',					Constants.key_foreclosure_prefix+ filedate+'::bdid',do6);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.Key_Foreclosures_Addr,				Constants.key_foreclosure_prefix 	+'address',				Constants.key_foreclosure_prefix+ filedate+'::address',do7);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.Key_Foreclosures_FID_Linkids,	Constants.key_foreclosure_prefix 	+'fid::linkids',	Constants.key_foreclosure_prefix+ filedate+'::fid::linkids',do8);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.Key_Foreclosures_Linkids.Key,	Constants.key_foreclosure_prefix + 'linkids',				Constants.key_foreclosure_prefix+ filedate +'::linkids', do9);


//NOD Keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.Key_NOD_FID,					Constants.key_nod_prefix +'fid',					Constants.key_nod_prefix+filedate+'::fid',do10);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.Key_NOD_DID,					Constants.key_nod_prefix +'did',					Constants.key_nod_prefix+filedate+'::did',do11);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.Key_NOD_BDID,					Constants.key_nod_prefix +'bdid',					Constants.key_nod_prefix+filedate+'::bdid',do12);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.Key_NOD_FID_Linkids,	Constants.key_nod_prefix +'fid::linkids',	Constants.key_nod_prefix+filedate+'::fid::linkids',do13);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.Key_NOD_Linkids.Key,	Constants.key_nod_prefix +'linkids',			Constants.key_nod_prefix+ filedate +'::linkids', do14);

build_roxie_keys	:=	parallel(	do1, do2, do3, do4, do5, do6, do7, do8, do9, do10, do11, do12, do13, do14);


// Move keys to built superfile
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Constants.foreclosure_SuperKeyName+'index_geo11',	Constants.key_foreclosure_prefix+filedate+'::index_geo11',	mv1);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Constants.foreclosure_SuperKeyName+'index_geo12',	Constants.key_foreclosure_prefix+filedate+'::index_geo12',	mv2);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Constants.foreclosure_SuperKeyName+'index_fips',	Constants.key_foreclosure_prefix+filedate+'::index_fips',		mv3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Constants.foreclosure_SuperKeyName+'fid',					Constants.key_foreclosure_prefix+filedate+'::fid',					mv4);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Constants.foreclosure_SuperKeyName+'did',					Constants.key_foreclosure_prefix+filedate+'::did',					mv5);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Constants.foreclosure_SuperKeyName+'bdid',				Constants.key_foreclosure_prefix+filedate+'::bdid',					mv6);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Constants.foreclosure_SuperKeyName+'address',			Constants.key_foreclosure_prefix+filedate+'::address',			mv7);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Constants.foreclosure_SuperKeyName+'fid::linkids',Constants.key_foreclosure_prefix+filedate+'::fid::linkids',	mv8);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Constants.foreclosure_SuperKeyName+'linkids',			Constants.key_foreclosure_prefix+filedate+'::linkids',			mv9);

//Move NOD Keys
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Constants.nod_SuperKeyName+'fid',					Constants.key_nod_prefix+filedate+'::fid',					mv10);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Constants.nod_SuperKeyName+'did',					Constants.key_nod_prefix+filedate+'::did',					mv11);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Constants.nod_SuperKeyName+'bdid',				Constants.key_nod_prefix+filedate+'::bdid',					mv12);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Constants.nod_SuperKeyName+'fid::linkids',Constants.key_nod_prefix+filedate+'::fid::linkids',	mv13);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Constants.nod_SuperKeyName+'linkids',			Constants.key_nod_prefix+filedate+'::linkids',			mv14);


Move_keys	:=	parallel(	mv1, mv2, mv3, mv4, mv5,mv6, mv7, mv8, mv9, mv10, mv11, mv12, mv13, mv14);



// Move keys to QA superfile
RoxieKeyBuild.MAC_SK_Move_V2(Constants.foreclosure_SuperKeyName+'index_geo11',	'Q',mv_qa1,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.foreclosure_SuperKeyName+'index_geo12',	'Q',mv_qa2,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.foreclosure_SuperKeyName+'index_fips',		'Q',mv_qa3,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.foreclosure_SuperKeyName+'fid',					'Q',mv_qa4,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.foreclosure_SuperKeyName+'did',					'Q',mv_qa5,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.foreclosure_SuperKeyName+'bdid',					'Q',mv_qa6,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.foreclosure_SuperKeyName+'address',			'Q',mv_qa7,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.foreclosure_SuperKeyName+'fid::linkids',	'Q',mv_qa8,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.foreclosure_SuperKeyName+'linkids',			'Q',mv_qa9,2);


RoxieKeyBuild.MAC_SK_Move_V2(Constants.nod_SuperKeyName+'fid',					'Q',mv_qa10,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.nod_SuperKeyName+'did',					'Q',mv_qa11,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.nod_SuperKeyName+'bdid',					'Q',mv_qa12,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.nod_SuperKeyName+'fid::linkids',	'Q',mv_qa13,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.nod_SuperKeyName+'linkids',			'Q',mv_qa14,2);

To_qa	:=	parallel(mv_qa1, mv_qa2, mv_qa3, mv_qa4, mv_qa5, mv_qa6, mv_qa7, mv_qa8, mv_qa9, mv_qa10, mv_qa11, mv_qa12, mv_qa13, mv_qa14);

// -- Build Autokeys
build_autokeys_foreclosure 	:= Keys.foreclosure_autokeys('F',filedate);
build_autokeys_nod					:= Keys.foreclosure_autokeys('N',filedate);

// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION 
updatedops   		 := PRTE.UpdateVersion('ForeclosureKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','N','N');


// -- Actions
buildKey	:=	sequential(
												build_roxie_keys
												,Move_keys
												,to_qa
												,build_autokeys_foreclosure
												,build_autokeys_nod
												// ,updatedops
												);	

return	buildKey;

end;
