import $, RoxieKeyBuild;

export key_IDX_blkgrp(string filedate, boolean pUseProd = false, boolean isfcra = false) :=  function
        return $.create_index('BLKGRP', filedate, pUseProd, isfcra);
end;