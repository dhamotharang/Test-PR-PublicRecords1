import Promotesupers, roxiekeybuild;

pre := Promotesupers.SF_MaintBuilding('~thor_Data400::base::ms_workers_comp');

roxiekeybuild.Mac_SK_BuildProcess_v2(govdata.key_ms_workers_comp_BDID,'~thor_data400::key::ms_workers_comp_bdid',do1);
promotesupers.Mac_SK_Move_v2('~thor_data400::key::ms_workers_comp_bdid','Q',do2,2);

roxiekeybuild.Mac_SK_BuildProcess_v2(govdata.key_ms_workers_comp_LinkIDS.key,'~thor_data400::key::ms_workers_comp_linkids',linkidsdo1);
promotesupers.Mac_SK_Move_v2('~thor_data400::key::ms_workers_comp_linkids','Q',linkidsdo2,2);

post := Promotesupers.SF_MaintBuilt('~thor_data400::base::ms_workers_comp');

export proc_build_ms_workers_comp_key := sequential(
	pre,
	parallel(
		sequential(do1,do2),
		sequential(linkidsdo1,linkidsdo2)
		),
	post
	);