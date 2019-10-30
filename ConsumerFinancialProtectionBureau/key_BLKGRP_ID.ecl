import $, RoxieKeyBuild;

export key_blkgrp_ID(string filedate, boolean pUseProd = false, boolean isfcra = false) :=  function
        return $.create_index('BLKGRP', filedate, pUseProd, isfcra);
end;