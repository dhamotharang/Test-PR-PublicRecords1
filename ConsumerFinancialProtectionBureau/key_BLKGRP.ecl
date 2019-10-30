import $, RoxieKeyBuild;
export key_BLKGRP(filedate, pUseProd = false, isfcra = false, seq_build, seq_move_built)  := macro
    RoxieKeyBuild.Mac_SK_BuildProcess_v2_local($.key_IDX_blkgrp(filedate,pUseProd,isfcra), $.Filenames(,pUseProd,isfcra).keyBLKGRP, $.Filenames(filedate,pUseProd,isfcra).keyBLKGRP, seq_build);
    Roxiekeybuild.Mac_SK_Move_to_Built_v2($.Filenames(,pUseProd,isfcra).keyBLKGRP, $.Filenames(filedate,pUseProd,isfcra).keyBLKGRP, seq_move_built);
endmacro;