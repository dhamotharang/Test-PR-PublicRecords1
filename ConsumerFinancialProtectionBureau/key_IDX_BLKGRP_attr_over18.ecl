import $, RoxieKeyBuild;

export key_IDX_BLKGRP_attr_over18(string filedate, boolean pUseProd = false, boolean isfcra = false) :=  function
        return $.create_index('BLKGRP_attr_over18', filedate, pUseProd, isfcra);
end;