//Build key for Equifax and move to QA.
import ut, RoxieKeyBuild;

export Proc_build_Equifax_keys(string filedate) := 
function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
																					Marketing_Best.key_equifax_DID,
																					'~thor_data400::key::Marketing_Best::@version@::equifax_did',
																					'~thor_data400::key::Marketing_Best::'+filedate+'::equifax_did',
																					MarketingBestEquifaxDIDKeyOut);
		
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																			'~thor_data400::key::Marketing_Best::@version@::equifax_did',
																			'~thor_data400::key::Marketing_Best::'+filedate+'::equifax_did',
																			mv_equifax);
									  
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::Marketing_Best::@version@::equifax_did', 'Q', mv_equifax_key);

update_dops := roxiekeybuild.updateversion('EquifaxTotalSolutionKeys',filedate,'kgummadi@seisint.com',,'N');

return sequential(MarketingBestEquifaxDIDKeyOut,
									mv_equifax,
									mv_equifax_key,
									update_dops
									);	
end;
