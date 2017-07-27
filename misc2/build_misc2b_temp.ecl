
import header,ut,RoxieKeyBuild,misc2;

// ut.mac_create_superkey_files('~thor_data400::key::misc2b::hval');

string filedate:='20100721a';

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(misc2.key_misc2b_hval,'~thor_data400::key::misc2b::hval','~thor_data400::key::misc2b::'+filedate+'::hval',build_misc2b,true);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::misc2b::hval','~thor_data400::key::misc2b::'+filedate+'::hval',move_tobuilt_misc2b);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::misc2b::hval','Q',move_toqa_misc2b);

sequential(build_misc2b, move_tobuilt_misc2b, move_toqa_misc2b);
