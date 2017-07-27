// determine records to display
import doxie,suppress,Standard, driversv2, CriminalRecords_Services;

EXPORT DLSearchService_records(BOOLEAN enable_wild=FALSE) := FUNCTION

ids := DLSearchService_ids(enable_wild);

// narrow to just sequences
seqs := dedup( project( ids, layouts.seq ), all);

// retrieve results
rpen := DLRaw.narrow_view.by_seq(seqs);
rpenhist := rpen( DLRaw.histOK(history) );

// prepend deep dive status, and shift deep dives to the bottom of the results
rdd := join(
	rpenhist, dedup(sort(ids, dl_seq,if(isDeepDive, 1, 0)), dl_seq),
	left.dl_seq = right.dl_seq,	
	transform({ids.isDeepDive,rpen}, self.isDeepDive := right.isDeepDive, self := left),
	left outer
);

recs := rdd(penalt <= input.pThresh);
dmv := recs(source_code not in driversv2.Constants.nonDMVsources);
non_dmv := recs(source_code in driversv2.Constants.nonDMVsources);
rsrt := sort(dmv, if(isDeepDive, 1, 0), penalt, -lic_issue_date, -expiration_date, record) &
				sort(non_dmv, if(isDeepDive, 1, 0), penalt, -dt_last_seen, record);

// slim to final output format (preserving sort)
// final_fmt	:= project(rsrt, layouts.result_narrow); // no need to narrow -- it's the same plus IsDeepDive
pre_dobmasking := dedup(rsrt, except dl_seq);

// output(ids,	named('ids'));	// DEBUG
// output(seqs,	named('seqs'));	// DEBUG
// output(rpen,	named('rpen'));	// DEBUG
// output(rsrt,	named('rsrt'));	// DEBUG


  doxie.MAC_Selection_Declare()
	doxie.MAC_Header_Field_Declare()
	
	layout_dobmask := record
		pre_dobmasking;
		Standard.Date.Datestr dob_masked;
	end;
	layout_dobmask pre_dm_trans(pre_dobmasking l) := transform
	  self.dob_masked := ROW ({'', '', ''}, Standard.Date.Datestr);
		self := L;
	end;
	
	pre_dobmask_ready := project(pre_dobmasking,pre_dm_trans(left));
	
	unsigned1  edobmask := DriversV2_Services.input.edobmask;
	
	Suppress.MAC_Mask_Date(pre_dobmask_ready, post_dobmasking, dob, dob_masked, edobmask);
	
// apply county post-filtering
do_county_filt := map(
	input.county=''	=> false,
	input.state=''	=> error(301, doxie.ErrorCodes(301) + ' - State required to search by County'),
	true
);
filtRecords := if(do_county_filt, post_dobmasking(county_name=input.county), post_dobmasking);

// apply gender post-filtering
genderRecords := if(input.gender='',filtRecords,filtRecords(input.gender not in ['M','F'] or sex_flag=input.gender or sex_flag=''));

// add crim indicators
layout_crim_ind := record
  genderRecords;
  boolean HasCriminalConviction;
  boolean IsSexualOffender;
end;

recsIn := PROJECT(genderRecords,TRANSFORM({layout_crim_ind,STRING12 UniqueId},SELF.UniqueId:=(STRING)LEFT.did,SELF:=LEFT,SELF:=[]));
CriminalRecords_Services.MAC_Indicators(recsIn,recsOut);
final_d := PROJECT(if(include_CriminalIndicators_val,recsOut,recsIn),layout_crim_ind);

RETURN final_d;

END;