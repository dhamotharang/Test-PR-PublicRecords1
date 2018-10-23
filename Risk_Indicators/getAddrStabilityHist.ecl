/* 
 * Calculates the Address Stability 
 * A majority of this code has been adapted from Risk_Indicators.ADL_Risk_Table
 */

IMPORT _Control, Risk_Indicators, ut, STD;
onThor := _Control.Environment.OnThor;

EXPORT getAddrStabilityHist(DATASET(risk_indicators.layouts.layout_header_plus_hist_date) input) := FUNCTION
	
	mobi := RECORD
		integer2 currentYear;
    input.seq;
		input.did;
		input.dt_first_seen;
		input.dt_last_seen;
		input.prim_range;
		input.prim_name;
		input.zip;
		INTEGER3  first_ever        := -1;
		INTEGER3  last_ever         := -1;
		INTEGER2  num_addr_last_5yr := -1;
		INTEGER2  curr_years        := -1;
		INTEGER2  tot_stay_prior    := -1;
		INTEGER2  tot_stay_last2    := -1;
	END;
	
	stab_hdr := project(input, transform(mobi, 
															self.currentYear := IF(left.historydate = 999999, risk_indicators.iid_constants.todaydate DIV 10000, (INTEGER)((string) left.historydate)[1..4]),
															self := left));
	


	hdrFiltered := stab_hdr (dt_first_seen != 0, dt_last_seen != 0, prim_name[1..6] != 'PO BOX');
	
  hdr_sorted := SORT(hdrFiltered, seq, did, prim_range, prim_name, zip);
	
  mobi currRoll(mobi le, mobi ri) := TRANSFORM
    first_seen := MIN(le.dt_first_seen, ri.dt_first_seen);
    last_seen  := MAX(le.dt_last_seen,  ri.dt_last_seen);
    SELF.dt_first_seen := first_seen;
    SELF.dt_last_seen  := last_seen;
    thisYears := (INTEGER)(last_seen/100) - (INTEGER)(first_seen/100);
    SELF.curr_years := MAX(le.curr_years, thisYears);
    SELF := le;
  END;

  hdr_currRolled := ROLLUP(hdr_sorted, currRoll(LEFT,RIGHT), seq, did, prim_range, prim_name, zip);

  // Handle records that aren't duplicates (didn't go through the rollup)
  mobi currProject(mobi le) := TRANSFORM
    SELF.curr_years := (INTEGER)(le.dt_last_seen/100) - (INTEGER)(le.dt_first_seen/100);
    SELF := le;
  END;

  hdr_currProjected := PROJECT(hdr_currRolled( curr_years = -1 ), currProject(LEFT));
		
  hdr_current := hdr_currRolled(curr_years != -1) + hdr_currProjected;

	// Rollup into records for a particular DID
  hdr_currSorted_roxie := SORT(hdr_current, seq, did, -dt_first_seen, -dt_last_seen);
	hdr_currSorted_thor := SORT(distribute(hdr_current, hash64(seq, did)), seq, did, -dt_first_seen, -dt_last_seen, LOCAL);

	#IF(onThor)
		hdr_currSorted := hdr_currSorted_thor;
	#ELSE
		hdr_currSorted := hdr_currSorted_roxie;
	#END
  
  mobi everRoll(mobi le, mobi ri) := TRANSFORM		
    first_iteration := le.tot_stay_last2 = -1;

    SELF.first_ever     := MIN(IF(first_iteration, le.dt_first_seen, le.first_ever), ri.dt_first_seen);
    SELF.last_ever      := MAX(IF(first_iteration, le.dt_last_seen,  le.last_ever),  ri.dt_last_seen);
    SELF.tot_stay_last2 := IF(first_iteration, le.curr_years + ri.curr_years, le.tot_stay_last2);
    SELF.tot_stay_prior := IF(first_iteration, ri.curr_years, le.tot_stay_prior);

    newer := le.dt_last_seen > ri.dt_last_seen;
    dt_last_seen  := IF(newer, le.dt_last_seen, ri.dt_last_seen);
    dt_first_seen := IF(newer, le.dt_first_seen, ri.dt_first_seen);
			
    SELF.curr_years := le.curr_years;
    SELF.dt_last_seen := dt_last_seen;
    SELF.dt_first_seen := dt_first_seen;

    num_addr_left  := IF(le.num_addr_last_5yr = -1 AND (le.currentYear - (INTEGER)(le.dt_last_seen/100)) <= 5, 1, 0);
    num_addr_right := IF(ri.num_addr_last_5yr = -1 AND (ri.currentYear - (INTEGER)(ri.dt_last_seen/100)) <= 5, 1, 0);
			
    SELF.num_addr_last_5yr := IF(le.num_addr_last_5yr = -1, 0, le.num_addr_last_5yr) + num_addr_left + num_addr_right;
    SELF := le;
  END;
		
  hdr_everRolled := ROLLUP(hdr_currSorted, everRoll(LEFT,RIGHT), seq, did);

  // Handle records that aren't duplicates (Didn't go through the rollup)
  mobi everProject(mobi le) := TRANSFORM
    SELF.curr_years := le.curr_years;//le.dt_last_seen/100 - le.dt_first_seen/100;
    SELF.tot_stay_last2 := le.curr_years;
    SELF.tot_stay_prior := 0;
    SELF.num_addr_last_5yr := IF((le.currentYear - le.dt_last_seen/100) <= 5, 1, 0);
    SELF.first_ever := le.dt_first_seen;
    SELF.last_ever  := le.dt_last_seen;
    SELF := le;
  END;

  hdr_everProjected := PROJECT(hdr_everRolled( first_ever = -1 ), everProject(LEFT));
  hdr_ever := hdr_everRolled(first_ever != -1) + hdr_everProjected;


  // Main code
  resultrec := RECORD
    UNSIGNED4 seq;
    UNSIGNED6 did;
    INTEGER stability;
  END;
		
  resultrec calcStability(mobi le) := TRANSFORM
    last_ever_yr := (INTEGER)le.last_ever[1..4];
			
    length_curr_addr := MAP(
        le.curr_years >= 7   => 7,
        le.curr_years >= 4   => 4,
        le.curr_years >= 1   => 1,
        0
      );

    length_prior_addr := MAP(
        le.tot_stay_prior >= 6  => 6,
        le.tot_stay_prior >= 2  => 2,
        0
      );

    grp := IF(length_curr_addr=7, 70, length_curr_addr * 10 + length_prior_addr);

    stability_indicator_704 := MAP(
        grp = 70         => 6,
        grp IN [6,16,46] => 5,
        grp = 0 AND le.num_addr_last_5yr <= 4 => 2,
        grp = 0 AND le.num_addr_last_5yr >  4 => 1,
        le.tot_stay_last2                >= 5 => 4,
        le.tot_stay_last2                >= 4 => 3,
        le.num_addr_last_5yr             <= 4 => 2,
        le.num_addr_last_5yr             >  4 => 1,
        -9
      );
			
    SELF.stability := stability_indicator_704;
    SELF := le;
  END;

  hdr_recent := hdr_ever((currentYear - ((INTEGER)last_ever/100) <= 1 ));

  stability_flags := DEDUP(SORT(PROJECT(hdr_recent, calcStability(LEFT)), seq, DID, stability), seq, DID, stability);

  RETURN(stability_flags);

END;