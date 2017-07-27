import DayBatchPCNSR,roxiekeybuild;

export proc_build_keys(string file_date) := function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(DayBatchPCNSR.Key_PCNSR_DID,'','~thor_data::key::daybatch_pcnsr::'+file_date+'::pcnsr.did',did_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(DayBatchPCNSR.Key_PCNSR_LZ3,'','~thor_data::key::daybatch_pcnsr::'+file_date+'::pcnsr.lz3',lz3_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(DayBatchPCNSR.Key_PCNSR_Nbr,'','~thor_data::key::daybatch_pcnsr::'+file_date+'::pcnsr.zz4317_deduped',nbr_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(DayBatchPCNSR.Key_PCNSR_Phone,'','~thor_data::key::daybatch_pcnsr::'+file_date+'::pcnsr.phone.area_code.st',phone_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(DayBatchPCNSR.Key_PCNSR_Surnames,'','~thor_data::key::daybatch_pcnsr::'+file_date+'::pcnsr.lz3_deduped',sur_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(DayBatchPCNSR.Key_PCNSR_Z317LF,'','~thor_data::key::daybatch_pcnsr::'+file_date+'::pcnsr.z137lf',z3_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(DayBatchPCNSR.Key_PCNSR_HHID,'','~thor_data::key::daybatch_pcnsr::'+file_date+'::pcnsr.hhid',hhid_key);

mv1a := fileservices.addsuperfile('~thor_data::key::daybatch_pcnsr::built::pcnsr.did','~thor_data::key::daybatch_pcnsr::'+file_date+'::pcnsr.did');
mv2a := fileservices.addsuperfile('~thor_data::key::daybatch_pcnsr::built::pcnsr.lz3','~thor_data::key::daybatch_pcnsr::'+file_date+'::pcnsr.lz3');
mv3a := fileservices.addsuperfile('~thor_data::key::daybatch_pcnsr::built::pcnsr.zz4317_deduped','~thor_data::key::daybatch_pcnsr::'+file_date+'::pcnsr.zz4317_deduped');
mv4a := fileservices.addsuperfile('~thor_data::key::daybatch_pcnsr::built::pcnsr.phone.area_code.st','~thor_data::key::daybatch_pcnsr::'+file_date+'::pcnsr.phone.area_code.st');
mv5a := fileservices.addsuperfile('~thor_data::key::daybatch_pcnsr::built::pcnsr.lz3_deduped','~thor_data::key::daybatch_pcnsr::'+file_date+'::pcnsr.lz3_deduped');
mv6a := fileservices.addsuperfile('~thor_data::key::daybatch_pcnsr::built::pcnsr.z137lf','~thor_data::key::daybatch_pcnsr::'+file_date+'::pcnsr.z137lf');
mv7a := fileservices.addsuperfile('~thor_data::key::daybatch_pcnsr::built::pcnsr.hhid','~thor_data::key::daybatch_pcnsr::'+file_date+'::pcnsr.hhid');

mv1b := fileservices.addsuperfile('~thor_data::key::daybatch_pcnsr::qa::pcnsr.did','~thor_data::key::daybatch_pcnsr::'+file_date+'::pcnsr.did');
mv2b := fileservices.addsuperfile('~thor_data::key::daybatch_pcnsr::qa::pcnsr.lz3','~thor_data::key::daybatch_pcnsr::'+file_date+'::pcnsr.lz3');
mv3b := fileservices.addsuperfile('~thor_data::key::daybatch_pcnsr::qa::pcnsr.zz4317_deduped','~thor_data::key::daybatch_pcnsr::'+file_date+'::pcnsr.zz4317_deduped');
mv4b := fileservices.addsuperfile('~thor_data::key::daybatch_pcnsr::qa::pcnsr.phone.area_code.st','~thor_data::key::daybatch_pcnsr::'+file_date+'::pcnsr.phone.area_code.st');
mv5b := fileservices.addsuperfile('~thor_data::key::daybatch_pcnsr::qa::pcnsr.lz3_deduped','~thor_data::key::daybatch_pcnsr::'+file_date+'::pcnsr.lz3_deduped');
mv6b := fileservices.addsuperfile('~thor_data::key::daybatch_pcnsr::qa::pcnsr.z137lf','~thor_data::key::daybatch_pcnsr::'+file_date+'::pcnsr.z137lf');
mv7b := fileservices.addsuperfile('~thor_data::key::daybatch_pcnsr::qa::pcnsr.hhid','~thor_data::key::daybatch_pcnsr::'+file_date+'::pcnsr.hhid');


bk := sequential(parallel(did_key,lz3_key,nbr_key,phone_key,sur_key,z3_key, hhid_key),
					parallel(mv1a,mv2a,mv3a,mv4a,mv5a,mv6a,mv7a),
					parallel(mv1b,mv2b,mv3b,mv4b,mv5b,mv6b,mv7b));

return bk;

end;

