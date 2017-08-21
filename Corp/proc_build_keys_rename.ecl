import ut,roxiekeybuild;
roxiekeybuild.Mac_SK_BuildProcess_v2_local(corp.key_Corp_base_bdid,'~thor_data400::key::corp_base_bdid','~thor_data400::key::corp::'+corp.version_development+'::base.bdid', do1);
roxiekeybuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::corp_base_bdid','~thor_data400::key::corp::'+corp.version_development+'::base.bdid', do1a);

roxiekeybuild.Mac_SK_BuildProcess_v2_local(corp.key_Corp_base_bdid_pl,'~thor_data400::key::corp_base_bdid_pl','~thor_data400::key::corp::'+corp.version_development+'::base.bdid.pl',do2);
roxiekeybuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::corp_base_bdid_pl','~thor_data400::key::corp::'+corp.version_development+'::base.bdid.pl',do2a);

roxiekeybuild.Mac_SK_BuildProcess_v2_local(corp.key_corp_base_corpkey,'~thor_data400::key::corp_base_corpkey','~thor_data400::key::corp::'+corp.version_development+'::base.corpkey',do3);
roxiekeybuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::corp_base_corpkey','~thor_data400::key::corp::'+corp.version_development+'::base.corpkey',do3a);

export proc_build_keys_rename := sequential(
		parallel(do1,do2,do3),
		do1a,do2a,do3a);		 
		 