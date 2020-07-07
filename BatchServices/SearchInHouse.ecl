import BatchServices, doxie, gong_services, AutoHeaderI, STD, AutoStandardI;

in_layout := BatchServices.Layouts.RTPhones.rec_batch_RTPhones_input;

export SearchInHouse(BatchServices.RealTimePhones_Params.params in_mod,
                  dataset(in_layout) f_in):= FUNCTION

    doxie.MAC_Header_Field_Declare()
    GM := AutoStandardI.GlobalModule();
    mod_access := doxie.compliance.GetGlobalDataAccessModule();

    flat_out := BatchServices.Layouts.RTPhones.rec_output_internal;

    f_in  SearchLocalTrans ( f_in Lout) := transform
      tempmod := module(project(GM,AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,opt))
          export forceLocal := true;
          export noFail := true;
          export string11 ssn := Lout.ssn;
          export string14 did := Lout.did;
          export string15 phone := Lout.phoneno;
          export string30 firstname := Lout.name_first;
          export string30 lastname := Lout.name_last;
          export string200 addr := Lout.unparsedaddr1;
          export string10 prim_range := Lout.prim_range;
          export string28 prim_name := Lout.prim_name;
          export string25 city := Lout.p_city_name;
          export string2 state := Lout.st;
          export string6 zip := Lout.zip5;
      end;
      dids := if (Lout.resultcount >= in_mod.maxResults,dataset([],doxie.layout_references_hh),AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do(tempmod));

      IncludeFullPhonesPlus := true;
      ds_pp := doxie.MAC_Get_GLB_DPPA_PhonesPlus(dids, mod_access, true,,
                                                 if(IncludeFullPhonesPlus,0,11), company_name,,false);
      ds_qsent := doxie.MAC_Get_GLB_DPPA_Qsent(dids, mod_access, true,, company_name);
      unsigned1 lengthSSN := length(trim(SSN_value));
      UseAllDids := lengthSSN > 0; // if there is a ssn then use all dids
      gong_dids := if (UseAllDids, dids, dataset([{(unsigned6)did_value}],doxie.layout_references_hh));

      gong_recs := gong_services.Fetch_Gong_History(gong_dids, mod_access,
        includeParsedDifferences := true,
        SuppressNoncurrent := true,
        AllowFallBack := false,
        AllowBlankFnameMatch := if(~UseAllDids, true, false));

      doxie.layout_pp_raw_common gong2Pretty(gong_recs le) :=
      TRANSFORM
        SELF.did := le.did;
        SELF.src := 'PH';
        SELF.vendor_id := 'GH';
        SELF.fname := le.name_first;
        SELF.mname := le.name_middle;
        SELF.lname := le.name_last;
        SELF.name_suffix := le.name_suffix;
        SELF.city_name := le.p_city_name;
        SELF.zip := le.z5;
        SELF.zip4 := le.z4;
        SELF.phone := le.phone10;
        SELF.listed_phone := le.phone10;
        SELF.listed_name := le.listed_name;
        SELF.listing_type_bus := le.listing_type_bus;
        SELF.listing_type_gov := le.listing_type_gov;
        SELF.caption_text := le.caption_text;
        SELF.bdid := le.bdid;
        SELF.dt_first_seen := le.dt_first_seen;
        SELF.dt_last_seen := (string) STD.Date.Today ();
        SELF.TNT := 'V';
        self.ConfidenceScore := 30;
        self.Activeflag := 'Y';
        SELF := le;
        SELF := [];
      END;
      ds_gong := project(gong_recs((unsigned)phone10 > 10000000, current_record_flag='Y'), gong2Pretty(left));
      ds_total := ds_pp + ds_qsent + ds_gong;
      ds_sort := sort(ds_total(phone<>''),-dt_last_seen)           // no more dedup
                            ((LOUT.ZIP5 = '' OR zip = Lout.zip5) and
                          //  (LOUT.ssn = '' OR ssn = Lout.ssn) and
                            (LOUT.P_CITY_NAME = '' OR  LOUT.P_CITY_NAME = CITY_NAME) and
                            (LOUT.st = '' OR  LOUT.st = st) and
                            (LOUT.NAME_last = '' OR  LOUT.name_last = lname) and
                        (lout.prim_range = '' OR  lout.prim_range = prim_range) and
                        (lout.prim_name = ''  OR   lout.prim_name = prim_name) and
                        (LOUT.phoneno = ''  OR   LOUT.phoneno = phone));

      flat_out inbatch_trans( ds_sort L ) := transform
        self.acctno := Lout.acctno;
        self.ssn := l.ssn;
        Self.DID := intformat(L.did,12,1);
        self.phone := L.phone;
        self.name := stringlib.StringCleanSpaces(l.lname +' '+ l.fname +' '+ l.mname) ;//L.listed_name;
        self.address := StringLib.StringCleanSpaces(l.prim_range + ' ' + l.predir + ' ' + l.prim_name + ' ' + l.suffix +
                              ' ' + l.postdir + ' ' + l.sec_range);
        self.sec_range := l.sec_range;
        self.city := L.city_name;
        self.state := L.st;
        self.zip := L.zip;
        self.responsestatus := trim(lout.requeststatus)+'i' ;
        self := L;
        self := [];
      end;
      ds_results := project(ds_sort,inbatch_trans(left));
      ds_sort_results := choosen(sort(DEDUP(SORT(lout.results & ds_results,name,address,phone,-dt_last_seen,-dt_first_seen,did,responsestatus),name,address,phone,dt_last_seen,dt_first_seen,did),responseStatus,-dt_last_seen,-dt_first_seen),in_mod.maxResults );
      self.results := ds_sort_results;
      self.resultcount := count(ds_sort_results);
      self := Lout;

    end;
    ds_response := project(f_in, SearchLocalTrans(left));

    doxie.compliance.logSoldToSources(ds_response.results, mod_access);

    return ds_response;
END;
