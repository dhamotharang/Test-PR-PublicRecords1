import  AutoheaderV2, doxie;

export LIBCALL_FetchI_Hdr_Indv := module

	export do_hhid (LIBIN.FetchI_Hdr_Indv.full in_mod) :=  function
    ds_search := AutoheaderV2.LIBCALL_conversions.GetPreprocessedInputDataset (in_mod);
    // library wrapper call
    search_code := if (in_mod.noFail, AutoHeaderV2.Constants.SearchCode.NOFAIL, 0);
    dids_res := AutoHeaderV2.get_dids (ds_search, search_code);
    return project (dids_res, doxie.layout_references_hh);
  end;

	export do (LIBIN.FetchI_Hdr_Indv.full in_mod) :=  function
    ds_search := AutoheaderV2.LIBCALL_conversions.GetPreprocessedInputDataset (in_mod);
    // library wrapper call
    search_code := if (in_mod.noFail, AutoHeaderV2.Constants.SearchCode.NOFAIL, 0);
    dids_res := AutoHeaderV2.get_dids (ds_search, search_code);
    return project (dids_res, doxie.layout_references);
  end;

  export references := do;

end;