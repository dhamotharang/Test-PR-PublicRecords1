IMPORT doxie,AutoStandardI,iesp,ut, NID;

// This module scores responses against a set of inputs. Scores are returned
// in the range of 0..100, where 0 is a complete mismatch and 100 is a
// perfect match.
//
// Scores are weighted such that some components of the input record are
// counted as being more significant than others. Default weights are
// provided in the various weights interfaces, and may be overridden.

IMPORT AutoStandardI, UPS_Services;

EXPORT mod_Score(UPS_Services.SearchParams search_mod) := MODULE
  
  SHARED commonLayout := UPS_Services.layout_Common;
  SHARED IT := AutoStandardI.InterfaceTranslator;
  
  SHARED nameInput := search_mod.nameQueryInputs;
  SHARED inFirstName := TRIM(nameInput.First);
  SHARED inMiddleName := TRIM(nameInput.Middle);
  SHARED inLastName := TRIM(nameInput.Last);
  SHARED inCompanyName := TRIM(nameInput.CompanyName);

  SHARED STRING PreferredFirst(STRING n) := TRIM(NID.PreferredFirstNew(n));
  SHARED inPreferredFirstName := PreferredFirst(inFirstName);
  // shared inPhoneticLastName := TRIM(if(inLastName <> '', metaphonelib.DMetaphone1(inLastName)[1..6], ''));

  SHARED addrInput := search_mod.addrQueryInputs;
  SHARED inPrimRange := TRIM(addrInput.StreetNumber);
  SHARED inPredir := TRIM(addrInput.StreetPredirection);
  SHARED inPrimName := TRIM(addrInput.StreetName);
  SHARED inSuffix := TRIM(addrInput.StreetSuffix);
  SHARED inPostdir := TRIM(addrInput.StreetPostdirection);
  SHARED inSecRange := TRIM(addrInput.UnitNumber);
  SHARED inCity := TRIM(addrInput.City);
  SHARED inState := TRIM(addrInput.State);
  SHARED inZip5 := (INTEGER) addrInput.Zip5;
  
  SHARED inPhone := TRIM(search_mod.phoneQueryInput);

  SHARED hasFirstName := inFirstName <> '';
  SHARED hasMiddleName := inMiddleName <> '';
  SHARED hasLastName := inLastName <> '';
  SHARED hasIndName := hasFirstName OR hasLastName;
  SHARED hasBizName := inCompanyName <> '';
  SHARED hasName := hasIndName OR hasBizName;
  
  SHARED hasStreet := inPrimRange <> '' AND inPrimName <> '';
  SHARED hasCity := inCity <> '';
  SHARED hasState := inState <> '';
  SHARED hasCityState := hasCity AND hasState;
  SHARED hasZip := inZip5 <> 0;
  SHARED hasAddr := hasStreet OR hasCity OR hasState OR hasZip;
  
  SHARED hasPhone := inPhone <> '' AND (LENGTH(inPhone) = 7 OR LENGTH(inPhone) = 10);
      
  // Scoring is done at three levels:
  //
  // 1. At the individual field level. This is returned as an edit distance
  // normalized for the length of the string.
  // 2. Fields within a "group". For instance, first, middle and last name
  // each contribute to the name score. The contribution of each
  // individual field within a group of fields is given in the
  // weightsStreet, weightsCityStateZip, weightsIndName, weightsBizName,
  // and weightsPhone interfaces.
  // 3. At the record level. Name score, address score, and phone score
  // are each combined to come up with an aggregate record score. The
  // relative weights of components is given in the weightsRecord
  // interface.
  //
  // The weights of all fields within a group (at level 1) should should sum
  // to 100. This is a CONVENTION and not an absolute REQIREMENT.

  EXPORT input_vals := INTERFACE(AutoStandardI.GlobalModule())
  END;

  EXPORT weightsStreet := INTERFACE
    EXPORT UNSIGNED2 wt_prim_range := 30;
    EXPORT UNSIGNED2 wt_dir := 10; // either predir OR postdir
    EXPORT UNSIGNED2 wt_prim_name := 30;
    EXPORT UNSIGNED2 wt_suffix := 10;
    EXPORT UNSIGNED2 wt_sec_range := 20;
  END;
  
  EXPORT defWeightsStreet := MODULE(weightsStreet)
  END;
  
  EXPORT weightsCityStateZip := INTERFACE
    EXPORT UNSIGNED2 wt_city := 33;
    EXPORT UNSIGNED2 wt_state := 33;
    EXPORT UNSIGNED2 wt_zip := 34;
  END;

  EXPORT defWeightsCityStateZip := MODULE(weightsCityStateZip)
  END;
  
  EXPORT weightsIndName := INTERFACE
    EXPORT UNSIGNED2 wt_fname := 40;
    EXPORT UNSIGNED2 wt_mname := 10;
    EXPORT UNSIGNED2 wt_lname := 50;
    EXPORT UNSIGNED2 wt_cname := 100;
  END;

  EXPORT defWeightsIndName := MODULE(weightsIndName)
  END;

  EXPORT weightsBizName := INTERFACE
    EXPORT UNSIGNED2 wt_cname := 100;
  END;

  EXPORT defWeightsBizName := MODULE(weightsBizName)
  END;

  EXPORT weightsName := INTERFACE(weightsIndName, weightsBizName)
  END;

  EXPORT defWeightsName := MODULE(weightsName)
  END;

  EXPORT weightsPhone := INTERFACE
    EXPORT UNSIGNED2 wt_phone := 100;
  END;

  EXPORT defWeightsPhone := MODULE(weightsPhone)
  END;

  EXPORT weightsAddress := INTERFACE(weightsStreet, weightsCityStateZip)
    EXPORT UNSIGNED2 wt_street := 50;
    EXPORT UNSIGNED2 wt_citystatezip := 50;
  END;

  EXPORT defWeightsAddress := MODULE(weightsAddress)
  END;

  EXPORT weightsRecord := INTERFACE(weightsAddress, weightsName, weightsPhone)
    EXPORT UNSIGNED2 wt_grp_name := 40;
    EXPORT UNSIGNED2 wt_grp_addr := 40;
    EXPORT UNSIGNED2 wt_grp_phone := 20;
  END;

  EXPORT defWeightsRecord := MODULE(weightsRecord)
  END;
  
  // a few shortcuts used EVERYWHERE :)
  SHARED ned(STRING s1, STRING s2) := fn_NormalizedEditDistance(s1, s2);
  SHARED points(UNSIGNED score, UNSIGNED weight) := score * weight;
  
  // determine what to return from the scoring routines.
  SHARED reduce_points(UNSIGNED tot_points, UNSIGNED max_points) :=
      MAP(tot_points = 0 AND max_points > 0 => 0, // we have inputs, but scored a 0
          max_points = 0 => Constants.DEFAULT_RANGE, // we have no inputs, a perfect match
          tot_points / max_points); // otherwise, normalize

  EXPORT UNSIGNED2 fn_ScoreIndName(commonLayout rec,
                                   weightsIndName weights = defWeightsIndName) := FUNCTION
    BOOLEAN hasFirstName := inFirstName <> '';
    BOOLEAN useFirstInitial := hasFirstName AND LENGTH(inFirstName) = 1;
    BOOLEAN initialsMatch(STRING s1, STRING s2) := s1 <> '' AND s2 <> '' AND s1[1] = s2[1];

    fname_ned := MAP(useFirstInitial AND initialsMatch(inFirstName, rec.fname) => Constants.DEFAULT_RANGE,
                     useFirstInitial /* AND NOT initialsMatch */ => 0,
                     hasFirstName AND inPreferredFirstName = PreferredFirst(rec.fname) => Constants.DEFAULT_RANGE,
                     hasFirstName => ned(inFirstName, rec.fname), // NED on full first name
                     0); // no first name input defaults to no score

    fname_points := points(fname_ned, weights.wt_fname);
    mname_points := points(IF(inMiddleName <> '', ned(inMiddleName, rec.mname), 0), weights.wt_mname);
    lname_points := points(IF(inLastName <> '', ned(inLastName, rec.lname), 0), weights.wt_lname);

    tot_points := fname_points + mname_points + lname_points;

    max_points := IF(inFirstName <> '', weights.wt_fname, 0) +
                  IF(inMiddleName <> '', weights.wt_mname, 0) +
                  IF(inLastName <> '', weights.wt_lname, 0);

    RETURN reduce_points(tot_points, max_points);
  END;
  
  EXPORT UNSIGNED2 fn_ScoreBizName(commonLayout rec,
                                   weightsBizName weights = defWeightsBizName) := FUNCTION
    RETURN IF(inCompanyName <> '', ned(ut.mod_AmpersandTools.SimpleReplace(inCompanyName), ut.mod_AmpersandTools.SimpleReplace(rec.company_name)), Constants.DEFAULT_RANGE);
  END;

  EXPORT UNSIGNED2 fn_ScoreName(commonLayout rec,
                                weightsName weights = defWeightsName) := FUNCTION
    ind_score := fn_ScoreIndName(rec, weights);
    biz_score := fn_ScoreBizName(rec, weights);

    RETURN MAP(hasIndName AND hasBizName => MAX(ind_score, biz_score),
               hasIndName => ind_score,
               hasBizName => biz_score,
               Constants.DEFAULT_RANGE); // a match of nothing to nothing is perfect
  END;

  EXPORT UNSIGNED2 fn_ScoreStreet(commonLayout rec,
                                  weightsStreet weights = defWeightsStreet) := FUNCTION
    
    prim_range_points := points(IF(inPrimRange <> '', ned(inPrimRange, rec.prim_range), 0), weights.wt_prim_range);

    // predirection and postdirection should be scored as if they were the
    // same. For instance, "123 MAIN ST NE" is the same as "123 NE MAIN ST".
    inDir := IF (inPredir <> '', inPredir, inPostdir);
    recDir := IF(rec.predir <> '', rec.predir, rec.postdir);
    dir_points := points(IF(inDir <> '', ned(inDir, recDir), 0), weights.wt_dir);

    prim_name_points := points(IF(inPrimName <> '', ned(inPrimName, rec.prim_name), 0), weights.wt_prim_name);
    suffix_points := points(IF(inSuffix <> '' AND inSuffix = rec.suffix, Constants.DEFAULT_RANGE, 0), weights.wt_suffix);
    sec_range_points := points(IF(inSecRange <> '', ned(inSecRange, rec.sec_range), 0), weights.wt_sec_range);

    tot_points := prim_range_points + dir_points + prim_name_points +
                  suffix_points + sec_range_points;

    max_points := IF(inPrimRange <> '', weights.wt_prim_range, 0) +
                  IF(inDir <> '', weights.wt_dir, 0) +
                  IF(inPrimName <> '', weights.wt_prim_name, 0) +
                  IF(inSuffix <> '', weights.wt_suffix, 0) +
                  IF(inSecRange <> '', weights.wt_sec_range, 0);

    RETURN reduce_points(tot_points, max_points);
  END;
  
  EXPORT UNSIGNED2 fn_ScoreCityStateZip(commonLayout rec,
                                        weightsCityStateZip weights = defWeightsCityStateZip) := FUNCTION
    city_points := points(IF(inCity <> '', ned(inCity, rec.city_name), 0), weights.wt_city);
    state_points := points(IF(inState <> '' AND inState = rec.state, Constants.DEFAULT_RANGE, 0), weights.wt_state);
    zip_points := points(IF(inZip5 <> 0, ned((STRING) inZip5, rec.zip), 0), weights.wt_zip);

    tot_points := city_points + state_points + zip_points;

    max_points := IF(inCity <> '', weights.wt_city, 0) +
                  IF(inState <> '', weights.wt_state, 0) +
                  IF(inZip5 <> 0, weights.wt_zip, 0);

    RETURN reduce_points(tot_points, max_points);
  END;

  EXPORT UNSIGNED2 fn_ScoreAddress(commonLayout rec,
                                   weightsAddress weights = defWeightsAddress) := FUNCTION
    street_points := points(fn_ScoreStreet(rec, weights), weights.wt_street);
    citystatezip_points := points(fn_ScoreCityStateZip(rec, weights), weights.wt_citystatezip);

    tot_points := street_points + citystatezip_points;
    max_points := weights.wt_street + weights.wt_citystatezip;

    // here, max_points cannot be zero, and tot_points will only be zero if
    // the street and the city/state/zip both returned inexact matches.
    RETURN tot_points / max_points;
  END;
  
  EXPORT UNSIGNED2 fn_ScorePhone(commonLayout rec,
                                 weightsPhone weights = defWeightsPhone) := FUNCTION
    RETURN IF(inPhone <> '', ned(inPhone, rec.phone), Constants.DEFAULT_RANGE);
  END;
  
  EXPORT UNSIGNED2 fn_Score(commonLayout rec,
                            weightsRecord weights = defWeightsRecord) := FUNCTION

    doCityStateZip := hasCity OR hasState OR hasZip;
    
    name_score := IF(hasName, fn_ScoreName(rec), 0);
    addr_score := IF(hasStreet, fn_ScoreAddress(rec, weights), 0);
    phone_score := IF(hasPhone, fn_ScorePhone(rec, weights), 0);

    tot_points := points(name_score, weights.wt_grp_name) +
                  points(addr_score, weights.wt_grp_addr) +
                  points(phone_score, weights.wt_grp_phone);
                 
    max_points := IF(hasName, weights.wt_grp_name, 0) +
                  IF(hasAddr, weights.wt_grp_addr, 0) +
                  IF(hasPhone, weights.wt_grp_phone, 0);

    RETURN IF(max_points = 0, Constants.DEFAULT_RANGE, // is this even possible? No inputs?
                              tot_points / max_points);
  END;

  EXPORT DATASET(commonLayout) score(DATASET(commonLayout) in_recs,
                                     weightsRecord weights = defWeightsRecord) := FUNCTION
    
    in_recs ScoreRecords(in_recs L) := TRANSFORM
      SELF.score_name := fn_ScoreName(L, weights);
      SELF.score_addr := fn_ScoreAddress(L, weights);
      SELF.score_phone := fn_ScorePhone(L, weights);
      SELF := L;
    END;
    
    out_recs := PROJECT(in_recs, ScoreRecords(LEFT));
    RETURN out_recs;
  END;
END;
