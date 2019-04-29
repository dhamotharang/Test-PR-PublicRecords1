import promotesupers, roxiekeybuild, ut;

pre1 := promotesupers.SF_MaintBuilding('~thor_Data400::base::ska_nixie');
pre2 := promotesupers.SF_MaintBuilding('~thor_Data400::base::ska_verified');

roxiekeybuild.Mac_SK_BuildProcess_v2(busdata.Key_SKA_Nixie_BDID,'~thor_data400::key::ska_nixie_bdid',do1);
roxiekeybuild.Mac_SK_BuildProcess_v2(busdata.Key_SKA_Nixie_Linkids.Key,'~thor_data400::key::ska_nixie_linkids',do2);
roxiekeybuild.Mac_SK_BuildProcess_v2(busdata.Key_SKA_Verified_BDID,'~thor_Data400::key::ska_verified_bdid',do3);
roxiekeybuild.Mac_SK_BuildProcess_v2(busdata.Key_SKA_Verified_Linkids.Key,'~thor_Data400::key::ska_verified_linkids',do4);

promotesupers.Mac_SK_Move_v2('~thor_data400::key::ska_nixie_bdid','Q',do5,2);
promotesupers.Mac_SK_Move_v2('~thor_data400::key::ska_nixie_linkids','Q',do6,2);
promotesupers.Mac_SK_Move_v2('~thor_data400::key::ska_verified_bdid','Q',do7,2);
promotesupers.Mac_SK_Move_v2('~thor_data400::key::ska_verified_linkids','Q',do8,2);

post1 := promotesupers.SF_MaintBuilt('~thor_data400::base::ska_nixie');
post2 := promotesupers.SF_MaintBuilt('~thor_data400::base::ska_verified');

export proc_build_ska_keys := sequential(sequential(pre1,do1,do2,do5,do6,post1),sequential(pre2,do3,do4,do7,do8,post2));
