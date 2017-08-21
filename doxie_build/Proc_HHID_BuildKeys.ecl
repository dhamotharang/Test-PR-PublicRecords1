//create HHID keys
import Promotesupers,header,RoxieKeybuild;

export Proc_HHID_BuildKeys(string filedate) := function

mv_build := if(Fileservices.getsuperfilesubcount('~thor_data400::base::HHID_Current_Building')>0,
	output('Base::HHID_Current_Building already contains a base file.  Addsuper was not executed.'),
	Fileservices.AddSuperFile('~thor_data400::base::HHID_Current_Building', '~thor_data400::base::HHID',,true));

chk_build := output('Checking Building superfile...') : SUCCESS(mv_build);

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie_build.Key_Prep_Did_HDid,'~thor_data400::key::did_hhid','~thor_data400::key::header::HHID::'+filedate+'::did.ver',SF1);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie_build.Key_Prep_HHID_Did,'~thor_data400::key::hhid_did','~thor_data400::key::header::HHID::'+filedate+'::hhid.ver',SF2);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::did_hhid','~thor_data400::key::header::HHID::'+filedate+'::did.ver',SF3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::hhid_did','~thor_data400::key::header::HHID::'+filedate+'::hhid.ver',SF4);

mv_built := Promotesupers.SF_MaintBuilt('~thor_data400::base::HHID_Current');

keys_out := sequential(chk_build,SF1,SF2,SF3,SF4,mv_built);

chk_built := if(fileservices.GetSuperFileSubName('~thor_data400::base::HHID_Current_Built',1)=fileservices.GetSuperFileSubName('~thor_data400::base::HHID',1),
	output('HHID file BASE = BUILT, Nothing done.'),keys_out);

initial_chk := output('Checking Built superfile...') : success(chk_built);

return initial_chk;

end;

