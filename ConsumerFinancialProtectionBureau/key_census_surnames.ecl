import $, RoxieKeyBuild;

export key_census_surnames(filedate, pUseProd = false, isfcra = false, seq_build, seq_move_built) := macro
        RoxieKeyBuild.Mac_SK_BuildProcess_v2_local($.key_IDX_census_surnames(filedate,pUseProd,isfcra), $.Filenames(,pUseProd,isfcra).keycensus_surnames, $.Filenames(filedate,pUseProd,isfcra).keycensus_surnames, seq_build);
        Roxiekeybuild.Mac_SK_Move_to_Built_v2($.Filenames(,pUseProd,isfcra).keycensus_surnames, $.Filenames(filedate,pUseProd,isfcra).keycensus_surnames, seq_move_built)
endmacro;