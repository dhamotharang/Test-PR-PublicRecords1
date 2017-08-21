import RoxieKeyBuild, Models;
#WORKUNIT('name','Models Keys');

export ProcBuildKeys(string p_version = '', boolean prte = false) := function

////////////////////////////////// BUILD KEYS
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Models.Key_MSA_Zip_Lookup(),'~thor_data400::key::models::@version@::msa_zip_lookup','~thor_data400::key::models::'+p_version+'::msa_zip_lookup',bk_key1);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Models.Key_MSA_Zip_Lookup(true),'~thor_data400::key::models::fcra::@version@::msa_zip_lookup','~thor_data400::key::models::fcra::'+p_version+'::msa_zip_lookup',bk_fcra_key1);

////////////////////////////////// MOVE KEYS to BUILT
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::models::@version@::msa_zip_lookup','~thor_data400::key::models::'+p_version+'::msa_zip_lookup',mv_key1,3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::models::fcra::@version@::msa_zip_lookup','~thor_data400::key::models::fcra::'+p_version+'::msa_zip_lookup',mv_fcra_key1,3);

////////////////////////////////// MOVE KEYS to QA
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::models::@version@::msa_zip_lookup','Q',mv2qa_key1);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::models::fcra::@version@::msa_zip_lookup','Q',mv2qa_fcra_key1);


///////////////////////////////////PRTE KEYS
df := dataset([], Models.File_MSA_Zip_Lookup.layout_msa_zip);
Key_msa_zip := index(df, {zip}, {df}, '~prte::key::models::'+p_version+'::msa_zip_lookup');
Key_msa_zip_fcra := index(df, {zip}, {df}, '~prte::key::models::fcra::'+p_version+'::msa_zip_lookup');


BuildKeys := 
					sequential(
					 parallel(bk_key1, bk_fcra_key1);
					 parallel(mv_key1, mv_fcra_key1);
					 parallel(mv2qa_key1, mv2qa_fcra_key1);			 
					 )
;		

BuildPrteKeys := 
				 sequential(build(Key_msa_zip,update),
										build(Key_msa_zip_fcra,update));
										
Keys := if(prte, BuildPrteKeys, BuildKeys);

return Keys;

end;
