import DayBatchPCNSR,roxiekeybuild;

export proc_build_keys(string file_date) := function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(DayBatchPCNSR.Key_PCNSR_Address,'~thor_data400::key::daybatch_pcnsr::pcnsr.address','~thor_data400::key::daybatch_pcnsr::'+file_date+'::pcnsr.address',address_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(DayBatchPCNSR.Key_PCNSR_DID,'~thor_data400::key::daybatch_pcnsr::pcnsr.did','~thor_data400::key::daybatch_pcnsr::'+file_date+'::pcnsr.did',did_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(DayBatchPCNSR.Key_PCNSR_LZ3,'~thor_data400::key::daybatch_pcnsr::pcnsr.lz3','~thor_data400::key::daybatch_pcnsr::'+file_date+'::pcnsr.lz3',lz3_key);
//RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(DayBatchPCNSR.Key_PCNSR_Nbr,'~thor_data400::key::daybatch_pcnsr::pcnsr.zz4317_deduped','~thor_data400::key::daybatch_pcnsr::'+file_date+'::pcnsr.zz4317_deduped',nbr_key);
//RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(DayBatchPCNSR.Key_PCNSR_Phone,'~thor_data400::key::daybatch_pcnsr::pcnsr.phone.area_code.st','~thor_data400::key::daybatch_pcnsr::'+file_date+'::pcnsr.phone.area_code.st',phone_key);
//RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(DayBatchPCNSR.Key_PCNSR_Surnames,'~thor_data400::key::daybatch_pcnsr::pcnsr.lz3_deduped','~thor_data400::key::daybatch_pcnsr::'+file_date+'::pcnsr.lz3_deduped',sur_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(DayBatchPCNSR.Key_PCNSR_Z317LF,'~thor_data400::key::daybatch_pcnsr::pcnsr.z137lf','~thor_data400::key::daybatch_pcnsr::'+file_date+'::pcnsr.z137lf',z3_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(DayBatchPCNSR.Key_PCNSR_HHID,'~thor_data400::key::daybatch_pcnsr::pcnsr.hhid','~thor_data400::key::daybatch_pcnsr::'+file_date+'::pcnsr.hhid',hhid_key);

Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::daybatch_pcnsr::pcnsr.address','~thor_data400::key::daybatch_pcnsr::'+file_date+'::pcnsr.address', mv_address_key);
// Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data::key::daybatch_pcnsr::@version@::pcnsr.address','~thor_data400::key::daybatch_pcnsr::'+file_date+'::pcnsr.address', mv_address_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data::key::daybatch_pcnsr::@version@::pcnsr.did','~thor_data400::key::daybatch_pcnsr::'+file_date+'::pcnsr.did', mv_did_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data::key::daybatch_pcnsr::@version@::pcnsr.lz3','~thor_data400::key::daybatch_pcnsr::'+file_date+'::pcnsr.lz3', mv_lz3_key);
//Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data::key::daybatch_pcnsr::@version@::pcnsr.zz4317_deduped','~thor_data400::key::daybatch_pcnsr::'+file_date+'::pcnsr.zz4317_deduped', mv_nbr_key);
//Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data::key::daybatch_pcnsr::@version@::pcnsr.phone.area_code.st','~thor_data400::key::daybatch_pcnsr::'+file_date+'::pcnsr.phone.area_code.st', mv_phone_key);
//Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data::key::daybatch_pcnsr::@version@::pcnsr.lz3_deduped','~thor_data400::key::daybatch_pcnsr::'+file_date+'::pcnsr.lz3_deduped', mv_sur_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data::key::daybatch_pcnsr::@version@::pcnsr.z137lf','~thor_data400::key::daybatch_pcnsr::'+file_date+'::pcnsr.z137lf', mv_z3_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data::key::daybatch_pcnsr::@version@::pcnsr.hhid','~thor_data400::key::daybatch_pcnsr::'+file_date+'::pcnsr.hhid', mv_hhid_key);

bk := sequential(parallel(address_key,did_key,lz3_key,/*nbr_key,phone_key,sur_key,*/z3_key, hhid_key),
				  parallel(mv_address_key,mv_did_key,mv_lz3_key,/*mv_nbr_key,mv_phone_key, mv_sur_key,*/mv_z3_key,mv_hhid_key));
					
return bk;

end;

