import autokeyi,doxie,ut,AutoheaderV2;

export fetch_zipPRLname (dataset (AutoheaderV2.layouts.search) ds_search, integer search_code=0) := function

  _row := ds_search[1];
  _options := ds_search[1].options;
  boolean no_fail := search_code & AutoheaderV2.Constants.SearchCode.NOFAIL > 0;

  tempmod := module (autokeyi.FetchI_Indv_ZipPRLname.old.params.full)
    export autokey_keyname_root := ut.foreign_prod+'thor_data400::key::header.';
    export noFail := false;
    export lname_value := _row.tname.lname;
    export fname_value := _row.tname.fname;
    export zip_value := _row.taddress.zip_set;
    export prange_value := _row.taddress.prim_range;
    export pname_value :=  _row.taddress.prim_name;
    export lookup_value := _options._lookup;
  end;
  ak := autokeyi.FetchI_Indv_ZipPRLname.old.do(tempmod);

  ec := ak[1].error_code;  //unsigned

  search_res := if (not no_fail or ec = 0,
                    project (ak(error_code = 0), 
                             transform (AutoheaderV2.layouts.search_out,
                                        self.did := left.did, Self.fetch_hit := AutoheaderV2.Constants.FetchHit.ZIP_PRLNAME)),
                    fail(AutoheaderV2.layouts.search_out, ec, doxie.ErrorCodes(ec)));

  return search_res;

end;
