import $, RoxieKeyBuild;

export key_census_surnames_ID(string filedate, boolean pUseProd = false, boolean isfcra = false) :=  function
        return $.create_index('census_surnames', filedate, pUseProd, isfcra);
end;