//Build keys for DNM & DNC List and move to QA.
import ut, RoxieKeyBuild;

export Proc_build_DMA_keys(string filedate) :=
function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
											Marketing_Best.key_DNC_Phone,
											'~thor_data400::key::Marketing_Best::@version@::dnc_phone',
											'~thor_data400::key::Marketing_Best::'+Marketing_Best.Version+'::dnc_phone',
											MarketingBestDNCPhoneKeyOut);
		
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
									  '~thor_data400::key::Marketing_Best::@version@::dnc_phone',
									  '~thor_data400::key::Marketing_Best::'+Marketing_Best.Version+'::dnc_phone',
									  mv_dnc);
									  
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::Marketing_Best::@version@::dnc_phone', 'Q', mv_dnc_key);


RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(
											Marketing_Best.key_DNM_name_address,
											'~thor_data400::key::Marketing_Best::@version@::dnm_name_address',
											'~thor_data400::key::Marketing_Best::'+Marketing_Best.Version+'::dnm_name_address',
											MarketingBestDNMNameAddrKeyOut);
		
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
									  '~thor_data400::key::Marketing_Best::@version@::dnm_name_address',
									  '~thor_data400::key::Marketing_Best::'+Marketing_Best.Version+'::dnm_name_address',
									  mv_dnm);
									  
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::Marketing_Best::@version@::dnm_name_address', 'Q', mv_dnm_key);


return sequential(parallel(MarketingBestDNCPhoneKeyOut, MarketingBestDNMNameAddrKeyOut),
					parallel(mv_dnc, mv_dnm),
					parallel(mv_dnc_key, mv_dnm_key));	
					
end;
