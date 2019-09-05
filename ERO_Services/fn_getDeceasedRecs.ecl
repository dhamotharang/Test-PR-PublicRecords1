
import $,AutoStandardI, BatchServices, DeathV2_services, Doxie, dx_death_master, NID, STD;

export fn_getDeceasedRecs( dataset(Layouts.LookupId) ids = dataset([],Layouts.LookupId) ) :=
  function
    /*
      Requirement 4.1-19:
      Use the SSN, Name and DOB from the best subject being returned to ERO to conduct a deceased 
      search.  First search BatchServices.Death_BatchService by SSN and then by Name and DOB. 

      NOTE from Roberto Perez on how existing process works:
      The name comparison that was used for the deceased search allowed matches on nicknames for 
      the first name.  First, the BatchServices.Death_BatchService Roxie service was used to search 
      by SSN, then it was used to search by Name and DOB (relying on the name matching provided by 
      the Roxie service).  After the death data results were found by either method, the death 
      indicators were set based on the name comparisons performed using the datalib library (which 
      allows for nickname matching).

      Populate the 'Death_Indicator' field:
      This field represents a "match" found in the Death Master Data. This field will detail 
      how the match was made.    
        o   Update this field with a "Y" if the match was made using SSN and name comparison.
        o   Update this field with a "1" if the match was made using name and DOB.
        o   Update this field with a "2" if the match was made by SSN but the deceased name 
            does not match the input name. 
    */			
    /*
      Engineering notes (last update: 2/6/2013):
      The Deceased batch service (i.e. BatchServices.Death_BatchService_Records) provides the basis  
      for the logic being used here. We don't need all of the extra code for Autokey fetches, though,  
      so what we have below is simpler than what's in the batch service: the Deceased records can be 
      obtained adequately by a single join to the Deceased key (by did). We then compare the results 
      to the input SSN and Name + DOB, and the appropriate match-code is applied. 
    */
    // Local attributes.
    death_params := DeathV2_Services.IParam.GetDeathRestrictions(AutoStandardI.GlobalModule());
    ds_death_recs_raw := dx_death_master.Get.byDid(ids, did, death_params);

    PrefFirstMatch(string20 l, string20 r) :=
        NID.mod_PFirstTools.SUBPFLeqPFR(l,r) or NID.mod_PFirstTools.SUBPFLeqR(l,r);
    // Local functions.
    
    // The following function determines the value for the Death_Indicator field.
  fn_determine_death_indicator(Layouts.LookupId le, recordof(ds_death_recs_raw) ri) := 
      function
          
          // Convert date from Date.Day, Date.Month, Date.Year to YYYYMMDD.
          string8 date_yyyymmdd(ERO_Services.Layouts.Date dt) :=
              (string4)dt.Year + intformat(dt.Month,2,1) + intformat(dt.Day,2,1);

          boolean ssns_match := trim(le.input_ssn) = trim(ri.death.ssn);
          
          boolean dobs_match := date_yyyymmdd(le.input_dob) = trim(ri.death.dob8);
          
          // concatenate name data, capitalize, remove non-alpha chars; compare.
          llast := STD.STR.Filter(STD.STR.ToUpperCase(le.input_name.name_last), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 
          lfirst := STD.STR.Filter(STD.STR.ToUpperCase(le.input_name.name_first), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 
               
          rlast := STD.STR.Filter(STD.STR.ToUpperCase(ri.death.lname), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 
          rfirst := STD.STR.Filter(STD.STR.ToUpperCase(ri.death.fname), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); 
               
          lastMatch := llast = rlast;
          firstMatch := (lfirst = rfirst) or PrefFirstMatch(lfirst, rfirst);
          names_match := lastMatch and firstMatch;
              
          indicator := 
            map(
              ssns_match AND names_match     => 'Y',
              dobs_match AND names_match     => '1',
              ssns_match AND NOT names_match => '2',
              /* default.................... */ ''
            );
            
          return indicator;
      end;
    
    ds_death_recs := join(ids, ds_death_recs_raw, 
      left.did = right.did,
      transform(ERO_Services.Layouts.Deceased_out,
        self.acctno          := left.acctno;
        self.did             := left.did;
        self.Death_Indicator := fn_determine_death_indicator(left, right);
        self.Death_Name      := $.functions.fn_format_name(trim(right.death.lname), trim(right.death.fname), trim(right.death.mname));
        self.Death_DOD       := $.functions.fn_format_date(right.death.dod8);
        self.Death_DOB       := $.functions.fn_format_date(right.death.dob8);
        self.Death_SSN       := right.death.ssn;
      ), keep(1), limit(0));
    
    ds_death_recs_out := DEDUP(SORT(ds_death_recs, acctno, RECORD), acctno, RECORD);
    return ds_death_recs_out;
  end;