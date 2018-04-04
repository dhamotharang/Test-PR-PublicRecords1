IMPORT RoxieKeybuild,tris_lnssi_build;
EXPORT proc_build_keys(string filedate) := function

        RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(tris_lnssi_build.key_field_value_prep,'~thor_data400::key::tris_lnssi::field_value','~thor_data400::key::tris_lnssi::'+filedate+'::field_value',bld1);

    build_them:=sequential(bld1);

        RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::tris_lnssi::@version@::field_value','~thor_data400::key::tris_lnssi::'+filedate+'::field_value',mb1,,,true);

    move2built:=sequential(mb1);
    
        RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::tris_lnssi::@version@::field_value', 'Q', mq1, 2);
        
    move2qa := sequential(mq1);

    return sequential(build_them,move2built,move2qa);

END;