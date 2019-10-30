import $, RoxieKeyBuild;

export key_BLKGRP_attr_over18(filedate, pUseProd = false, isfcra = false, seq_build, seq_move_built) := macro
        BLKGRP_attr_over18_index := $.create_index('BLKGRP_attr_over18', filedate, pUseProd, isfcra);
        RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(BLKGRP_attr_over18_index, $.Filenames.keyBLKGRP_attr_over18(,pUseProd,isfcra), $.Filenames.keyBLKGRP_attr_over18(filedate,pUseProd,isfcra), seq_build);
        Roxiekeybuild.Mac_SK_Move_to_Built_v2($.Filenames.keyBLKGRP_attr_over18(,pUseProd,isfcra), $.Filenames.keyBLKGRP_attr_over18(filedate,pUseProd,isfcra), seq_move_built)
endmacro;