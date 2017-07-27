//create HHID keys
import ut,header;

mv_build := if(Fileservices.getsuperfilesubcount('~thor_data400::base::HHID_Current_Building')>0,
	output('Base::HHID_Current_Building already contains a base file.  Addsuper was not executed.'),
	Fileservices.AddSuperFile('~thor_data400::base::HHID_Current_Building', '~thor_data400::base::HHID',,true));

chk_build := output('Checking Building superfile...') : SUCCESS(mv_build);

ut.MAC_SK_BuildProcess(doxie_build.Key_Prep_Did_HDid,'~thor_data400::key::did_hhid_','~thor_data400::key::did_hhid',SF1,2)
ut.MAC_SK_BuildProcess(doxie_build.Key_Prep_HHID_Did,'~thor_data400::key::hhid_did_','~thor_data400::key::hhid_did',SF2,2)

mv_built := ut.SF_MaintBuilt('~thor_data400::base::HHID_Current');

keys_out := sequential(chk_build,SF1,SF2,mv_built);

chk_built := if(fileservices.GetSuperFileSubName('~thor_data400::base::HHID_Current_Built',1)=fileservices.GetSuperFileSubName('~thor_data400::base::HHID',1),
	output('HHID file BASE = BUILT, Nothing done.'),keys_out);

initial_chk := output('Checking Built superfile...') : success(chk_built);

export Proc_HHID_BuildKeys := initial_chk;