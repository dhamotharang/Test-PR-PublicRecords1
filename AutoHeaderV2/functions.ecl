IMPORT watchdog, ut, AutoStandardI, NID, doxie, AutoHeaderV2, dx_BestRecords;

EXPORT functions := MODULE

  EXPORT FetchConstraints (
    dataset(AutoheaderV2.layouts.search_out) indxread,
    unsigned8 limit_inner,
    unsigned8 limit_outer,
    boolean doSkip, // else fail
    unsigned4 errorCode,
    boolean doChoosen = false,
    integer fetch_hit =0,
    integer index_hit =0) := FUNCTION

      doxie.mac_FetchLimitLimitSkipFail(
        indxread,
        limit_inner,
        limit_outer,
        doSkip,
        errorCode,
        doChoosen,
        false,            //this option not valid when layout_references is the layout...no room for message
        outfile);
     
      return project(outfile, AutoheaderV2.layouts.search_out);

/*
    // future implementation: saving fail, skip, not found conditions  
    layouts.search_out SetErrors (boolean do_skip, integer errorcode) := transform
      Self.fetch_hit := ^.fetch_hit;
      Self.index_hit := ^.index_hit;
      Self.status := if (do_skip, Constants.STATUS._SKIP,  Constants.STATUS._FAIL);
      Self.err_code := errorcode;
      Self := []; //did, hhid
    end;
    thefail := limit (limit (indxread, limit_inner, ONFAIL(SetErrors (doSkip, errorCode)), keyed),
                      limit_outer, ONFAIL(SetErrors (doSkip, errorCode)));
    // return thefail;

    thekeep := choosen(indxread, limit_outer);

    outfile := if (doChoosen, thekeep, thefail);
    // return outfile;

    res := if (exists (outfile),
               outfile, 
               dataset ([transform (layouts.search_out, 
                                    Self.status := Constants.STATUS._NOT_FOUND,
                                    Self.fetch_hit := ^.fetch_hit,
                                    Self.index_hit := ^.index_hit,
                                    Self := [])]));
    return res;
*/
  end;


  EXPORT dataset (AutoheaderV2.layouts.search_out) ChooseBestDID (dataset (AutoheaderV2.layouts.search_out) adv_references,
                                                     dataset (AutoheaderV2.layouts.search) ds_search) := function

    _row := ds_search[1];
    _options := ds_search[1].options;

    temp_fname_value := _row.tname.fname;
    temp_lname_value := _row.tname.lname;
    temp_lname_set_value :=  _row.tname.lname_set;
    temp_ssn_value := _row.tssn.ssn;

    srec := record
      unsigned6 did;
      unsigned2 ssnscore;
      unsigned2 lnamescore;
      unsigned2 fnamescore;
      unsigned2 dobscore;
      unsigned2 recordcount;
      unsigned2 score;
      AutoheaderV2.layouts.search_out.fetch_hit;
      AutoheaderV2.layouts.search_out.index_hit;
    end;

    srec tra(AutoheaderV2.layouts.search_out l, dx_BestRecords.layout_best r) := transform
      //change: take ssn-valid indicator from best, not from header
      boolean is_good_ssn := length(trim(temp_ssn_value)) = 9 and r.ssn = temp_ssn_value and r.valid_ssn = 'G';
      ss := 
        if(temp_ssn_value = '', 
           0, 
           10 
            - ut.stringsimilar(temp_ssn_value, r.ssn) 
            - if(is_good_ssn, 0, 1)  //if they are not the valid user of the ssn, subtract 1 from ssn score
          );
      ll := if(temp_lname_value = '', 0, 10 - ut.stringsimilar(temp_lname_value, r.lname));
      lf := if(temp_lname_value = '', 0, 10 - ut.stringsimilar(temp_lname_value, r.fname));
      ff := if(temp_fname_value = '', 0, 10 - ut.stringsimilar(NID.PreferredFirstNew(temp_fname_value), NID.PreferredFirstNew(r.fname)));
      fl := if(temp_fname_value = '', 0, 10 - ut.stringsimilar(NID.PreferredFirstNew(temp_fname_value), NID.PreferredFirstNew(r.lname)));
      boolean NameIsFlipped := lf >= ll and fl >= ff;
      ls := if(NameIsFlipped, lf, ll);
      fs := if(NameIsFlipped, fl, ff);

      tempdmod := module(AutoStandardI.LIBIN.PenaltyI_DOB.full)
        export unsigned8 dob := (unsigned8) _row.tdob.dob;
        export unsigned1 agelow := _row.tdob.agelow;
        export unsigned1 agehigh := _row.tdob.agehigh;
        export string dob_field := (string8)r.dob;
      end;
      ds0 := AutoStandardI.LIBCALL_PenaltyI_DOB.val (tempdmod);
      ds := 10 - if(ds0 > 10, 10, ds0);
      rc := map(r.total_records > 10 => 10, 
                r.total_records = 1  => 0,  //frags even less desirable
                r.total_records);
      
      self.did := l.did;
      self.ssnscore := ss;
      self.lnamescore := ls;
      self.fnamescore := fs;
      self.dobscore := ds;
      self.recordcount := rc;
      self.score := ss + ls + fs + rc + ds;
      self.fetch_hit := l.fetch_hit;
      self.index_hit := l.index_hit;
    end;

    j := join(adv_references, 
							dx_BestRecords.fn_get_best_records(adv_references, did, dx_BestRecords.Constants.perm_type.glb),
              keyed (left.did = right.did), 
              tra(left, right), KEEP (1), limit (0));

    b := TOPN (j, 1, -score, did);
    bslim := project(b, AutoheaderV2.layouts.search_out);

    // check if there are search results found ONLY in ssn-quick-header and nowhere else;
    // such results will have ssn-score = 10, since there's nothing else to compare.
    qhdids := adv_references (index_hit = AutoheaderV2.Constants.FetchHit.QUICK_SSN);

    outf := 
      map(count(adv_references) < 2                                                       
            => adv_references,//no need to choose if less than 2
          count(j(ssnscore = 10)) = 1 and not exists(qhdids) and temp_lname_value = '' and temp_fname_value = ''                               
            => project(j(ssnscore = 10), AutoheaderV2.layouts.search_out),//ok to pick if only one matches ssn exactly, unless QH found a new one (which we should treat like a 10 even tho it wont have an SSN in the best file)
          count(adv_references) > 1  and temp_lname_value = '' and temp_fname_value = ''   
            => dataset([], AutoheaderV2.layouts.search_out),//too ambiguous
            bslim);
    return outf;
  END;


  // Remote call to the search library

  // record to keep Roxie exceptions. TODO: check if standard iesp/share records will do
  rec_exc := record
    string Source {xpath ('Source')} := '';
    integer Code {xpath ('Code')} := 0;
    string Message {xpath ('Message')} := '';
  end;      

  EXPORT GetDIDsRemote (dataset (AutoheaderV2.layouts.lib_search) ds_search, integer search_code=0, string url) := function

    gateway_rec := record 
      dataset (AutoheaderV2.layouts.lib_search) LexIDSearchRequest {maxcount(1)}; //at the moment only one row
      integer SearchCode := 0;
    end;
    gateway_rec Format () := transform
      Self.LexIDSearchRequest := ds_search;
      Self.SearchCode := search_code;
    end;
    ds_in := dataset ([Format()]);

    // OUTPUT: a choice of whether to return results plus diagnostics, etc.; see also XPATH in a soapcall
    // out_rec := layouts.search_out; //if we want just search results
    out_rec := record //if we want to imitate the library main module output
      dataset (AutoheaderV2.layouts.search_out) results {xpath ('Dataset[@name=\'search_results\']/Row')};
      dataset (AutoheaderV2.layouts.search_out) messages {xpath ('Dataset[@name=\'search_diagnostics\']/Row')};
      dataset (AutoheaderV2.layouts.search) _input {xpath ('Dataset[@name=\'search_input\']/Row')};
      // to keep query exceptions, like "too many found"
      rec_exc exceptions {xpath ('Exception')};
      // store SOAP-related errors
      integer err_soap;
      string err_soapmessage;
    end;

    out_rec SetError () := transform
      Self.err_soap := FAILCODE;
      Self.err_soapmessage := FAILMESSAGE;
      Self := [];
    end;

    dids_remote := soapcall (ds_in,
                             url,
                             AutoheaderV2.Constants.RemoteSearchServiceName,
                             {ds_in},
                             dataset (out_rec),
                             XPATH(AutoheaderV2.Constants.RemoteSearchServiceName + 'Response/Results/Result'),
                             // ... or, if just search results is enough:
                             // XPATH(Constants.RemoteSearchServiceName + 'Response/Results/Result/Dataset[@name=\'search_results\']/Row') 
                             onFail (SetError ()), RETRY (1), TIMEOUT (5)
                             );
    return dids_remote;
  END;
    
  export MakeDiagnosticDataset (unsigned fetch_hit, unsigned status) := function
    return dataset([{0, false, 0, fetch_hit, 0, status}], AutoheaderV2.layouts.search_out);
  end;


  // Returns a string pattern which will be further used for searching a purely numerical or 
  // purely alphabetical segment (atom) in the secondary range.
  // regexfind (pattern, secrange) will evaluated to :
  // a) TRUE, if secrange is blank or exactly same as atom;
  // b) TRUE, if numerical atom within secrange is delimited by non-numerical characters from either or both sides
  // c) TRUE, if alphabetical atom within secrange is delimited by non-alphabetical characters from either or both sides
  // d) FALSE in all other cases
  export string GetSecrangeAtomPattern (string sec_range) := function
    // find first consequtive character group, numerical or alphabetical
    str_number := regexfind ('[0-9]+', sec_range, 0);
    str_word := regexfind ('[A-Z]+', sec_range, 0); // should be just a letter, but if customer enters 'ABC', so be it.

    // if input contains both, numerical group will prevail
    boolean sec_range_is_a_number := str_number != '';
    purified_secrange := if (sec_range_is_a_number, str_number, str_word);

    res_pattern := '(^' + purified_secrange + '$)|' +
      if (sec_range_is_a_number,
          '([^0-9]+' + purified_secrange + '$)|(^' + purified_secrange + '[^0-9]+)|([^0-9]+' + purified_secrange + '[^0-9]+)',
          '([^A-Za-z]+' + purified_secrange + '$)|(^' + purified_secrange + '[^A-Za-z]+)|([^A-Za-z]+' + purified_secrange + '[^A-Za-z]+)');
    return res_pattern;
  end;

END;