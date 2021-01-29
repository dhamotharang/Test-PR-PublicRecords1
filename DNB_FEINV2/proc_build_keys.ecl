
import dnb_feinv2,roxiekeybuild,ut,autokey,doxie;

export proc_build_keys(string filedate) := function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(dnb_feinv2.key_dnb_fein_BDID,'~thor_data400::key::DnbFein::bdid','~thor_data400::key::DnbFein::'+filedate+'::BDID',dnbfein_BDID_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::DnbFein::bdid', '~thor_data400::key::DnbFein::'+filedate+'::BDID', mv_bdid_key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(DNB_FEINV2.key_dnb_fein_tmsid,'~thor_data400::key::dnbfein::TMSID','~thor_data400::key::DnbFein::'+filedate+'::TMSID',dnbfein_TMSID_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::DnbFein::TMSID', '~thor_data400::key::DnbFein::'+filedate+'::TMSID', mv_TMSID_key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(DNB_FEINV2.Key_LinkIds.Key,'~thor_data400::key::dnbfein::linkids','~thor_data400::key::DnbFein::'+filedate+'::linkids',dnbfein_BIPV2_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::dnbfein::linkids', '~thor_data400::key::DnbFein::'+filedate+'::linkids', mv_BIPV2_key);

build_keys := sequential(parallel(dnbfein_BDID_key,dnbfein_TMSID_key,dnbfein_BIPV2_key),parallel(mv_BDID_key,mv_TMSID_key,mv_BIPV2_key));
						 

autokeys := dnb_feinv2.proc_build_autokeys(filedate);

return parallel(build_keys,autokeys);

end;

