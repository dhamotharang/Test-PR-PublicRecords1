import $, RoxieKeyBuild;

export key_BLKGRP_attr_over18(filedate, pUseProd = false, isfcra = false, seq_build, seq_move_built) := macro
        RoxieKeyBuild.Mac_SK_BuildProcess_v2_local($.key_IDX_BLKGRP_attr_over18(filedate,pUseProd,isfcra), $.Filenames(,pUseProd,isfcra).keyBLKGRP_attr_over18, $.Filenames(filedate,pUseProd,isfcra).keyBLKGRP_attr_over18, seq_build);
        Roxiekeybuild.Mac_SK_Move_to_Built_v2($.Filenames(,pUseProd,isfcra).keyBLKGRP_attr_over18, $.Filenames(filedate,pUseProd,isfcra).keyBLKGRP_attr_over18, seq_move_built);
endmacro;