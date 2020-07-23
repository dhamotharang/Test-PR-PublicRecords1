import doxie_build, dx_header, header, header_quick, fcra, BankruptcyV2, doxie, address, ut, mdr, STD, Suppress;

todays_date := (string) risk_indicators.iid_constants.todaydate;
export SSN_Table_v4_2(boolean isFCRA) := function

h_full := if(isFCRA,doxie_build.file_FCRA_header_building,doxie_build.file_header_building)(~iid_constants.filtered_source(src, st));
h_quick := project( header_quick.file_header_quick (~iid_constants.filtered_source(src, st)), transform(header.Layout_Header, self.src := IF(left.src in ['QH', 'WH'], MDR.sourceTools.src_Equifax, left.src), self := left));
headerprod_building := ungroup(h_full + h_quick);

valid_header_uncorrected := if(isFCRA, header.fn_fcra_filter_src(headerprod_building), headerprod_building);

/* ****************************************************
 *                  Apply Corrections                 *
 ****************************************************** */
valid_header_corrected := Risk_Indicators.Header_Corrections_Function(valid_header_uncorrected);

valid_header_before_suppress := IF(isFCRA, valid_header_corrected, valid_header_uncorrected);

valid_header := fn_suppress_ccpa(valid_header_before_suppress, TRUE, 'RiskTable', 'src', 'global_sid', TRUE); // CCPA-795: OptOut Prefilter Data Layer

/* ****************************************************
 * Corrections have been applied - Continue as normal *
 ****************************************************** */
h := DISTRIBUTE(valid_header(LENGTH(TRIM(ssn))=9), HASH((STRING9)ssn));

lname_var := RECORD
	string20	fname;
	STRING20  lname;
	unsigned3 first_seen;
	unsigned3 last_seen;
END;

common_rec := RECORD
	// STRING9 ssn;
	unsigned3 header_first_seen;
	unsigned3 header_last_seen;
	INTEGER headerCount;
	INTEGER EqCount;
	INTEGER EnCount;
	INTEGER TnCount;
	INTEGER TuCount;
	INTEGER SrcCount;
	INTEGER DidCount;
	INTEGER DidCount_c6;//  number of dids created in the last 6 months
	
	// new fields for v4_2
		integer didcount_multiple_use; // ADLs per SSN that have more than just 1 record with that SSN
		integer addr_ct_multiple_use; //  addresses per SSN that have multiple records
		integer lname_ct;
		integer lname_ct_c6;
	//
	
	integer addr_ct;  // number of addresses associated with that SSN
	integer addr_ct_c6;  // number of addresses newly associated with that ssn within the last 6 months	
	INTEGER BestCount;
	INTEGER RecentCount;
	unsigned6 BestDid;
	lname_var lname1;
	lname_var lname2;
	lname_var lname3;
	lname_var lname4;
	
	// adding this here as well for customers that are ready for death v3 which has source restricted content
	boolean isDeceased;
	unsigned dt_first_deceased;
	unsigned decs_dob;
	string5 decs_zip_lastres;
	string5 decs_zip_lastpayment;
	string20 decs_last;
	string20 decs_first;
	unsigned6 deathDid;
END;


final_rec := RECORD
	STRING9 ssn;
	unsigned3 official_first_seen;
	unsigned3 official_last_seen;
	boolean isValidFormat;
	boolean isSequenceValid;
	boolean isBankrupt := false; // If using FCRA, hardcode to FALSE as Corrections File is not being taken into account.
	unsigned dt_first_bankrupt := 0;	// If using FCRA, hardcode to 0 as Corrections File is not being taken into account.
	STRING2 issue_state;
	common_rec combo;
	common_rec eq;
	common_rec en;
	common_rec tn;
	//CCPA-768
	UNSIGNED4	global_sid := 0;
	UNSIGNED8 record_sid := 0;
END;


combined_bureau_table := Risk_Indicators.SSN_Table(h, 'ALL', isFCRA);

// create unique credit bureau tables for each bureau
equifax_table := Risk_Indicators.SSN_Table(h(src not in [mdr.sourceTools.src_Experian_Credit_Header, mdr.sourceTools.src_TU_CreditHeader]), 
																						mdr.sourceTools.src_Equifax, 
																						isFCRA);
																						
experian_table := Risk_Indicators.SSN_Table(h(src not in [mdr.sourceTools.src_Equifax, mdr.sourceTools.src_TU_CreditHeader]), 
																						mdr.sourceTools.src_Experian_Credit_Header, 
																						isFCRA);
																						
transunion_table := Risk_Indicators.SSN_Table(h(src not in [mdr.sourceTools.src_Equifax,mdr.sourceTools.src_Experian_Credit_Header]), 
																						mdr.sourceTools.src_TU_CreditHeader, 
																						isFCRA);

j1 := join(distribute(combined_bureau_table, hash(ssn)), 
					 distribute(equifax_table, hash(ssn)), 
					left.ssn=right.ssn,
					transform(final_rec, self.ssn := left.ssn, self.combo := left, self.eq := right, self := []),
										left outer, local);

combined_snapshots := join(j1, 
					distribute(experian_table, hash(ssn)), 
					left.ssn=right.ssn,
					transform(final_rec, self.en := right, self := left),
										left outer, local);
										
combined_snapshots2 := join(combined_snapshots, 
					distribute(transunion_table, hash(ssn)), 
					left.ssn=right.ssn,
					transform(final_rec, self.tn := right, self := left),
										left outer, local);
										
// hang onto the DID on the bankruptcy file for use in pulling that data if on the pullid file
rec_temp := record
	final_rec;
	unsigned6 bansDid := 0;
end;

/* If the data is non-filtered perform the bankruptcy calculation.  
 * If it is filtered (AKA is FCRA), do not perform the bankruptcy calculation as the Corrections File is not taken into account and so the results 
 * cannot be used anyways.  In this case isBankrupt is hardcoded to FALSE, and dt_First_Bankrupt is hardcoded to 0.  We are then relying on
 * other code to properly set the Bankruptcy calculation using the Corrections File.
 */
rec_temp getBk(final_rec le, BankruptcyV2.file_bankruptcy_search_v3 ri) :=
TRANSFORM
    SELF.isBankrupt := ri.ssn<>'';
    SELF.bansdid := (unsigned)ri.did;
    SELF.dt_first_bankrupt := (unsigned)ri.date_filed;
    SELF := le;
END;
rec_temp transformBk(final_rec le) := TRANSFORM
    SELF := le;
END;

bk_search := IF(isFCRA=false, 
														distribute(BankruptcyV2.file_bankruptcy_search_v3(name_type='D' and LENGTH(TRIM(ssn))=9),hash(ssn)));
with_bk := IF(isFCRA=false, 
														JOIN(combined_snapshots2,bk_search, LEFT.ssn=RIGHT.ssn, getBk(LEFT,RIGHT), LEFT OUTER, local), 
														PROJECT(combined_snapshots2, transformBk(LEFT)));

all_again := distribute(with_bk, hash(ssn));

// Get info from SSA table
rec_temp get_ssa(rec_temp le, header.Layout_SSN_Map ri) := TRANSFORM
	SELF.issue_state := Address.Map_State_Name_To_Abbrev(Stringlib.StringToUpperCase(ri.state));
	SELF.official_first_seen := (unsigned3) (ri.start_date[1..6]); //YYYYMM

  // new ssn-issue data have '20990101' for the current date intervals
  r_end := IF (Ri.end_date='20990101', '', Ri.end_date[1..6]);
	SELF.official_last_seen  := (unsigned3) r_end; //YYYYMM
	SELF.isSequenceValid := true;
	
	vssn := Validate_SSN(le.ssn,'');
	
	SELF.isValidFormat := ~(vssn.invalid OR vssn.begin_invalid OR
					  vssn.middle_invalid OR vssn.last_invalid OR vssn.invalid_666s);
						
	SELF := le;
END;

with_ssa := JOIN(all_again, header.File_SSN_Map, 
                 (LEFT.ssn[1..5]=RIGHT.ssn5) AND
                 (Left.ssn[6..9] between Right.start_serial and Right.end_serial),
                 get_ssa(LEFT,RIGHT), 
                 LEFT OUTER, LOOKUP);

rec_temp pickdates(rec_temp le, rec_temp ri) := TRANSFORM
	SELF.dt_first_bankrupt := ut.Min2(le.dt_first_bankrupt,ri.dt_first_bankrupt);
	SELF := le;
END;
deduped_base_file := ROLLUP(SORT(with_ssa,ssn,-bansdid),pickdates(LEFT,RIGHT),ssn);


pull_file := doxie.File_pullSSN;

rec_temp pull_data(rec_temp le, pull_file rt) := transform
	self.ssn := le.ssn;
	/* The following accounts for randomized socials:
				ssnLowIssue - If possibly randomized, set low issue to the first date of randomization - June 25th, 2011
				ssnHighIssue - If possibly randomized, set to the current date (Or archive date if running in archive mode)
				We really only care about socsvalflag_temp being = '1'.
	*/
	vssn := Validate_SSN(le.ssn,'');
	socsvalflag_temp := MAP(
													(le.ssn<>'' and ~le.isValidFormat) or 
													vssn.begin_invalid or vssn.middle_invalid or vssn.last_invalid or 
													vssn.invalid_666s or vssn.pocketbook_ssn => '1',
																																			'0'
												);
	randomizedSocial := Risk_Indicators.rcSet.isCodeRS(le.ssn, socsvalflag_temp, TRIM((STRING)le.official_first_seen), '0');
	ssnLowIssue := IF(randomizedSocial, '20110625', TRIM((STRING)le.official_first_seen));
	ssnHighIssue := IF(randomizedSocial, todays_date, TRIM((STRING)le.official_last_seen));
	self.official_first_seen := (INTEGER)(ssnLowIssue[1..6]);
	self.official_last_seen := (INTEGER)(ssnHighIssue[1..6]);
	self.isValidFormat := le.isValidFormat;
	self.isSequenceValid := le.isSequenceValid;
	self.issue_state := le.issue_state;
	
	self := if(rt.ssn='', le);// blank out all of the other fields if we get a hit on pullid file
END;

pull_j1 := join(deduped_base_file, pull_file, left.ssn=right.ssn,
			pull_data(left, right), left outer, lookup);

pull_j2 := join(pull_j1, pull_file, 
			left.combo.bestdid!=0 and
				intformat(left.combo.bestdid,12,1)=right.ssn,
				pull_data(left, right), left outer, lookup);

pull_j3 := join(pull_j2, pull_file, 
			left.combo.deathdid!=0 and
				intformat(left.combo.deathdid,12,1)=right.ssn,
				pull_data(left, right), left outer, lookup);

pull_j4 := join(pull_j3, pull_file, 
			left.bansdid!=0 and
				intformat(left.bansdid,12,1)=right.ssn,
				pull_data(left, right), left outer, lookup);				

// put it back into original layout without the bans and death dids
  persist_name := IF (IsFCRA, 'persist::ssn_table_v4_2_filtered', 'persist::ssn_table_v4_2'); 
  final := project(pull_j4, final_rec) : persist (persist_name);	
	addGlobalSID := mdr.macGetGlobalSID(final,'RiskTable_Virtual','','global_sid'); //DF-26530: Populate Global_SID Field
	
return addGlobalSID;

end;