import AutoHeaderV2, AutoStandardI, AutoHeaderI;

export header_references(boolean noFail = false) := function
	tempmod := module(project(AutoStandardI.GlobalModule(),AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,opt))
		export noFail := ^.noFail;

    // .reference is the same as .do minus [pruning, filter minors, household]
    // to be backward compatible we'd need to set IncludeMinors=true, but this seems to be very questionable;
    // instead, let it be decided by a caller 

// I'm not comfortable with this, but it is backward compatible:
    export boolean IncludeMinors := true;

    export boolean household := false;
    export boolean KeepOldSsns := true;
	end;
  ds_search := AutoHeaderV2.LIBCALL_conversions.GetPreprocessedInputDataset (tempmod);

  // library wrapper call
  search_code := if (noFail, AutoHeaderV2.Constants.SearchCode.NOFAIL, 0);
	return AutoHeaderV2.get_dids (ds_search, search_code, ShowMessages := TRUE);

end;
