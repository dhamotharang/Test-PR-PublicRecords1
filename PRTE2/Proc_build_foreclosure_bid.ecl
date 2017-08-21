//*Proc_build_foreclosure_bid 

IMPORT PRTE2,AutoKeyB2,ut, roxiekeybuild, Data_Services,Doxie;

EXPORT proc_build_foreclosure_bid (string filedate):= FUNCTION

dfx := PRTE2.new_proc_build_autokeys_bid(filedate).df3;
EXPORT Key_Foreclosures_BIDx := index(dfx,{bdid},{string70 fid := foreclosure_id},'~prte::key::foreclosure_bid_' + doxie.Version_SuperKey);		

dfx_bdid := PRTE2.NEW_proc_build_autokeys_bid(filedate).df3_bdid;

EXPORT Key_Foreclosures_BDIDx := index (dfx_bdid,{bdid},{string70 fid := foreclosure_id},'~prte::key::foreclosure_bdid_' + doxie.Version_SuperKey);		

dfx_did := PRTE2.NEW_Proc_Build_Autokeys_bid(filedate).df3_did;
export Key_Foreclosure_DIDx := index(dfx_did,{did},{string70 fid := foreclosure_id},'~prte::key::foreclosures_did_' + doxie.Version_SuperKey);

dfx_fid := PRTE2.NEW_proc_build_autokeys(filedate).foreclosure_ak_dataset2;

export Key_Foreclosure_FIDx := index(dfx_fid,{fid},{dfx_fid},'~prte::key::foreclosures_fid_' + doxie.Version_SuperKey);


RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_Foreclosures_BDIDx,'~prte::key::foreclosure_bdid','~prte::key::foreclosure::'+filedate+'::bdid',do5);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_Foreclosure_DIDx,'~prte::key::foreclosures_did','~prte::key::foreclosure::'+filedate+'::did',do7);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_Foreclosure_FIDx,'~prte::key::foreclosures_fid','~prte::key::foreclosure::'+filedate+'::fid',do8);
// Move keys to built superfile

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~prte::key::foreclosure_bdid','~prte::key::foreclosure::'+filedate+'::bdid',do25);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~prte::key::foreclosure_did','~prte::key::foreclosure::'+filedate+'::did',do27);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~prte::key::foreclosure_fid','~prte::key::foreclosure::'+filedate+'::fid',do28);

// Move keys to QA superfile

ut.mac_sk_move_v2('~prte::key::foreclosure_bdid','Q',do35,2);
ut.mac_sk_move_v2('~prte::key::foreclosure_did','Q',do37,2);
ut.mac_sk_move_v2('~prte::key::foreclosure_fid','Q',do38,2);


// autokeys

buildkey := sequential(
	     			parallel(do5,do7,do8),
						do25,
						do27,
						do28,
						parallel(do35,do37,do38)
					);
					
return buildkey;

end;