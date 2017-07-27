
import header,ut,RoxieKeyBuild,misc2;

// ut.mac_create_superkey_files('~thor_data400::key::DateCorrect::hval');

string filedate:='20100821';

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(misc2.key_DateCorrect_hval,'~thor_data400::key::DateCorrect::hval','~thor_data400::key::DateCorrect::'+filedate+'::hval',build_DateCorrect,true);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::DateCorrect::hval','~thor_data400::key::DateCorrect::'+filedate+'::hval',move_tobuilt_DateCorrect);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::DateCorrect::hval','Q',move_toqa_DateCorrect);

sequential(build_DateCorrect, move_tobuilt_DateCorrect, move_toqa_DateCorrect);
