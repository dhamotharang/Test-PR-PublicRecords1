IMPORT RoxieKeyBuild;
/*		SAMPLE
	DID_KEY		:= INDEX(dbase(did_out!=''),{unsigned6 did := (unsigned6)dbase.did_out},{rid},'~prte::key::hunting_fishing::did');
	kBuild1 := PRTE2_Common.IndexBuildTriplet(DID_KEY, '~prte::key::hunting_fishing::did', '~prte::key::hunting_fishing::20141212::did', '~prte::key::hunting_fishing::@version@::did');

*/

EXPORT IndexBuildTriplet( INDEXDEF, FNAME, FNAMEVER, FNAMEABSTRACT ) := FUNCTIONMACRO
		RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INDEXDEF,FNAME,FNAMEVER,key);
		RoxieKeyBuild.Mac_SK_Move_To_Built_V2(FNAMEABSTRACT,FNAMEVER,mv,3);
		RoxieKeyBuild.Mac_SK_Move_V2(FNAMEABSTRACT,'Q',toq,3);						
		return sequential(key,mv,toq);
ENDMACRO;