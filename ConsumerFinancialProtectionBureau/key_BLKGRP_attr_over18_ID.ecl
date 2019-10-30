import $, RoxieKeyBuild;

export key_BLKGRP_attr_over18_ID(string filedate, boolean pUseProd = false, boolean isfcra = false) :=  function
        return $.create_index('BLKGRP_attr_over18', filedate, pUseProd, isfcra);
end;