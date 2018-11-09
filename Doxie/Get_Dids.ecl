IMPORT doxie, AutoStandardI, AutoHeaderI, AutoHeaderV2;

EXPORT dataset(doxie.layout_references) 
       Get_Dids(boolean forceLocal = true, boolean noFail = false) := function

  g_mod := AutoStandardI.GlobalModule();

  tempmod := module(project(g_mod,AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,opt))        
  end;

  // copy from global module to "extended" search interface; minimum translations are done here	
  ds_search := AutoHeaderV2.LIBCALL_conversions.GetPreprocessedInputDataset (tempmod);

  // library wrapper call
  search_code := if (noFail, AutoHeaderV2.Constants.SearchCode.NOFAIL, 0);
	dids := AutoHeaderV2.get_dids (ds_search, search_code, forceLocal);

  // slim down to comply with legacy usage;
  return project (dids, doxie.layout_references_hh);

END;