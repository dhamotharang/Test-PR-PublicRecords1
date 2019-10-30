import $, RoxieKeyBuild;

export key_census_surnames(filedate, pUseProd = false, isfcra = false, seq_build, seq_move_built) := macro
        census_surnames_index := $.create_index('census_surnames', filedate, pUseProd, isfcra);
        RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(census_surnames_index, $.Filenames.keycensus_surnames(,pUseProd,isfcra), $.Filenames.keycensus_surnames(filedate,pUseProd,isfcra), seq_build);
        Roxiekeybuild.Mac_SK_Move_to_Built_v2($.Filenames.keycensus_surnames(,pUseProd,isfcra), $.Filenames.keycensus_surnames(filedate,pUseProd,isfcra), seq_move_built)
endmacro;