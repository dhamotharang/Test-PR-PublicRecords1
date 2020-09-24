// determine records to display
IMPORT doxie,suppress,Standard, driversv2, CriminalRecords_Services;

EXPORT DLSearchService_records(BOOLEAN enable_wild=FALSE) := FUNCTION

ids := DLSearchService_ids(enable_wild);

// narrow to just sequences
seqs := DEDUP( PROJECT( ids, layouts.seq ), ALL);

// retrieve results
rpen := DLRaw.narrow_view.by_seq(seqs);
rpenhist := rpen( DLRaw.histOK(history) );

// prepend deep dive status, and shift deep dives to the bottom of the results
rdd := JOIN(
  rpenhist, DEDUP(SORT(ids, dl_seq,IF(isDeepDive, 1, 0)), dl_seq),
  LEFT.dl_seq = RIGHT.dl_seq,
  TRANSFORM({ids.isDeepDive,rpen}, SELF.isDeepDive := RIGHT.isDeepDive, SELF := LEFT),
  LEFT OUTER
);

recs := rdd(penalt <= input.pThresh);
dmv := recs(source_code NOT IN driversv2.Constants.nonDMVsources);
non_dmv := recs(source_code IN driversv2.Constants.nonDMVsources);
rsrt := SORT(dmv, IF(isDeepDive, 1, 0), penalt, -lic_issue_date, -expiration_date, RECORD) &
        SORT(non_dmv, IF(isDeepDive, 1, 0), penalt, -dt_last_seen, RECORD);

// slim to final output format (preserving sort)
// final_fmt := project(rsrt, layouts.result_narrow); // no need to narrow -- it's the same plus IsDeepDive
pre_dobmasking := DEDUP(rsrt, EXCEPT dl_seq);


  doxie.MAC_Selection_Declare()
  doxie.MAC_Header_Field_Declare()
  
  layout_dobmask := RECORD
    pre_dobmasking;
    Standard.Date.Datestr dob_masked;
  END;
  layout_dobmask pre_dm_trans(pre_dobmasking l) := TRANSFORM
    SELF.dob_masked := ROW ({'', '', ''}, Standard.Date.Datestr);
    SELF := L;
  END;
  
  pre_dobmask_ready := PROJECT(pre_dobmasking,pre_dm_trans(LEFT));
  
  UNSIGNED1 edobmask := DriversV2_Services.input.edobmask;
  
  Suppress.MAC_Mask_Date(pre_dobmask_ready, post_dobmasking, dob, dob_masked, edobmask);
  
// apply county post-filtering
do_county_filt := MAP(
  input.county='' => FALSE,
  input.state='' => ERROR(301, doxie.ErrorCodes(301) + ' - State required to search by County'),
  TRUE
);
filtRecords := IF(do_county_filt, post_dobmasking(county_name=input.county), post_dobmasking);

// apply gender post-filtering
genderRecords := IF(input.gender='',filtRecords,filtRecords(input.gender NOT in ['M','F'] OR sex_flag=input.gender OR sex_flag=''));

// add crim indicators
layout_crim_ind := RECORD
  genderRecords;
  BOOLEAN HasCriminalConviction;
  BOOLEAN IsSexualOffender;
END;

recsIn := PROJECT(genderRecords,TRANSFORM({layout_crim_ind,STRING12 UniqueId},SELF.UniqueId:=(STRING)LEFT.did,SELF:=LEFT,SELF:=[]));
CriminalRecords_Services.MAC_Indicators(recsIn,recsOut);
final_d := PROJECT(IF(include_CriminalIndicators_val,recsOut,recsIn),layout_crim_ind);

RETURN final_d;

END;
