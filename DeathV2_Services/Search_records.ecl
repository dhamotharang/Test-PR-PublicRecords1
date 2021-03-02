import $, doxie;

unsigned2 pt := 10 : stored('PenaltThreshold');
boolean IncludeBlankDOD := false : stored('IncludeBlankDOD');

doxie.MAC_Header_Field_Declare()

//***** GET IDS
sids := $.Search_ids(not noDeepDive, false);

//***** GENERATE REPORT
rpen := $.raw.get_report.from_death_ids(sids, ssn_mask_value);

//***** MARK DEEP DIVE
rdd := join(rpen, sids,
            left.state_death_id = right.state_death_id,
            transform($.layouts.report_external,
              self.isDeepDive := right.isDeepDive,
              self.SearchIndicator := right.SearchIndicator,
              self := left),
            left outer);

//***** FILTER BY PENALT AND SORT
penaltyFilter(unsigned2 pen, unsigned1 indicator) := indicator <> $.Constants.SearchIndicators.OTHERS OR pen <= pt;
rsrt := sort(rdd(penaltyFilter(penalt, SearchIndicator) and (includeBlankDOD or (integer)dod8 > 0)), if(isDeepDive, 1, 0), penalt, -dod8, record);
// doxie.MAC_Marshall_Results(rsrt,rmar);

// export Search_records := rmar;

EXPORT Search_records := rsrt;
