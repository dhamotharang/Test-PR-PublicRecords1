import _Control,AutoHeaderV2;

shared LIBCALL_header (dataset (AutoHeaderV2.layouts.lib_search) ds_search_in, integer search_code=0) := module

  // Example of calculating derived search criteria
  // Note: values the derived criteria are based upon must be "cleaned"
  // ds_search := project (ds_search_in, LIBCALL_conversions.DeriveSearchInput (Left));
  ds_search := ds_search_in;

#if(_Control.LibraryUse.ForceOff_AutoHeaderI__LIB_FetchI_Hdr_Indv)
  shared lib := AutoHeaderV2.LIB_header (ds_search, search_code);
#else
  shared lib := library (Constants.SearchLibraryName, AutoHeaderV2.ILIB.IHeaderSearch (ds_search, search_code));
#end

  export results := lib.results;

  export messages := lib.messages;

  export _input := lib._input;
end;