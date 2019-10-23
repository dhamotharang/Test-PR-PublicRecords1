//create HHID keys
import Promotesupers,header,RoxieKeybuild;
IMPORT dx_Header;


export Proc_HHID_BuildKeys_dx(string filedate) := function

//prefix := '~thor_data400::key::' + dx_Header.Constants.DataSetName + '::HHID::' + filedate + '::';
prefix := '~thor_data400::key::header::HHID::' + filedate + '::';

mv_build := if(Fileservices.getsuperfilesubcount('~thor_data400::base::HHID_Current_Building')>0,
	output('Base::HHID_Current_Building already contains a base file.  Addsuper was not executed.'),
	Fileservices.AddSuperFile('~thor_data400::base::HHID_Current_Building', '~thor_data400::base::HHID',,true));

chk_build := output('Checking Building superfile...') : SUCCESS(mv_build);

name_did := prefix + 'did.ver';
name_hhid := prefix + 'hhid.ver';

RoxieKeybuild.MAC_build_logical (dx_Header.key_did_hhid(), header.data_key_did_hhid, dx_Header.names('').i_did_hhid, name_did, SF1);
RoxieKeybuild.MAC_build_logical (dx_Header.key_hhid_did(), header.data_key_HHID_did, dx_Header.names('').i_hhid_did, name_hhid, SF2);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_did_hhid, name_did, SF3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2 (dx_Header.names('').i_hhid_did, name_hhid, SF4);

mv_built := Promotesupers.SF_MaintBuilt('~thor_data400::base::HHID_Current');

keys_out := sequential(chk_build,SF1,SF2,SF3,SF4,mv_built);

chk_built := if(fileservices.GetSuperFileSubName('~thor_data400::base::HHID_Current_Built',1)=fileservices.GetSuperFileSubName('~thor_data400::base::HHID',1),
	output('HHID file BASE = BUILT, Nothing done.'),keys_out);

initial_chk := output('Checking Built superfile...') : success(chk_built);

return initial_chk;

end;

