import $, RoxieKeyBuild;

export key_IDX_census_surnames(string filedate, boolean pUseProd = false, boolean isfcra = false) :=  function
        return $.create_index('census_surnames', filedate, pUseProd, isfcra);
end;