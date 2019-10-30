import $, RoxieKeyBuild;
export Build_all(string filedate, boolean pUseProd = false, boolean isfcra = false) := function

   // built := buildindex($.key_BLKGRP_ID(filedate, pUseProd, isfcra));
    $.key_BLKGRP(filedate, pUseProd, isfcra, seq_build_blkgrp, seq_move_blkgrp);
    build_keys := sequential(seq_build_blkgrp, seq_move_blkgrp);
    return build_keys;
end;