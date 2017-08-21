import Promotesupers, roxiekeybuild;

pre := Promotesupers.SF_MaintBuilding('~thor_data400::base::or_workers_comp');

roxiekeybuild.Mac_SK_BuildProcess_v2(govdata.key_or_workers_comp_bdid,'~thor_data400::key::or_workers_comp_bdid',do1);
promotesupers.Mac_SK_Move_v2('~thor_data400::key::or_workers_comp_bdid','Q',do2,2);

roxiekeybuild.Mac_SK_BuildProcess_v2(govdata.key_or_workers_comp_linkids.key,'~thor_data400::key::or_workers_comp_linkids',linkidsdo1);
promotesupers.Mac_SK_Move_v2('~thor_data400::key::or_workers_comp_linkids','Q',linkidsdo2,2);

post := Promotesupers.SF_MaintBuilt('~thor_data400::base::or_workers_comp');

export proc_build_or_workers_comp_key :=
	sequential(
		pre,
		do1,do2,
		linkidsdo1,linkidsdo2,
		post);