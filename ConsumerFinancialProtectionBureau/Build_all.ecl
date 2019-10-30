import $, RoxieKeyBuild;
export Build_all(string filedate, boolean pUseProd = false, boolean isfcra = false) := function
    $.key_BLKGRP(filedate, pUseProd, isfcra, seq_build_blkgrp, seq_move_blkgrp);
    $.key_BLKGRP_attr_over18(filedate, pUseProd, isfcra, seq_build_blkgrp_attr_over18, seq_move_blkgrp_attr_over18);
    $.key_census_surnames(filedate, pUseProd, isfcra, seq_build_census_surnames, seq_move_census_surnames);
    build_keys := sequential(seq_build_blkgrp, seq_move_blkgrp);
    return build_keys;
end;