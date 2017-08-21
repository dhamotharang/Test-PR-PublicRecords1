import Scrubs_LN_PropertyV2_Assessor,ut,_control,std,tools,scrubs;
EXPORT fn_scrubs_assessor(string source = '', string version = '', string emailList='') := function 
vendor := if(source = 'O', 'SourceB', 'SourceA'); 
pProfileName:='Scrubs_LN_Property_Assessor';
F := Scrubs_LN_PropertyV2_Assessor.In_Property_Assessor(source, version);
none :=Scrubs_LN_PropertyV2_Assessor.Scrubs.FromNone(F);
S :=Scrubs_LN_PropertyV2_Assessor.Scrubs; // My scrubs module
dbuildbase :=none.BitmapInfile;
N := S.FromNone(F); // Generate the error flags
U := S.FromExpanded(N.ExpandedInFile); // Pass the expanded error flags into the Expanded module
summary_:= U.SummaryStats;
orbit_stat := U.OrbitStats();
PostedVersion				:=	if(version='',(string)std.date.today(),version);

H := Scrubs_LN_PropertyV2_Assessor.hygiene(F);	
ValidityErrors := H.ValidityErrors;

summary := join(summary_, Scrubs_LN_PropertyV2_Assessor.File_Fips,
								left.fips_code = right.fips_code,
								transform({string2 state_code,  string county_name, string status := '', recordof(summary_)},
								self.state_code := right.state_code,
								self.county_name := right.county_name,
								self.status := if(self.state_code = '', 'invalid', 'valid'),							
								self := left),
								lookup,
								left outer);	
								
summary_t := table(summary, {status, count(group), sum(group, totalcnt)}, status);															 
	
validity_ := join(ValidityErrors, Scrubs_LN_PropertyV2_Assessor.File_Fips,
								left.source = right.fips_code,
								transform({string2 state_code,  string county_name, recordof(ValidityErrors) -source },
								self.state_code := right.state_code,
								self.county_name := right.county_name,
								self := left),
								lookup,
								left outer);						

validity := project(validity_,
										transform({recordof (validity_), string pct},
															self.pct := (string) (decimal8_2) (((real)left.cnt / (real)left.numberofrecords) * 100.00),
															self := left));
															
//**********************Part 2****************************
  s2_l := RECORD
 unsigned8 recordstotal := 0; 
 string2 state := '';
 string50 county:= '';
 string50 fips := '';
 string fieldname := '';
 unsigned8 invalid_count;
 decimal10_2 pcnt;
 end;
 
//scrubs := dedup(sort(dataset('~thor::property_assessor_scrubs', s_l, csv), sourcecode, ruledesc),sourcecode, ruledesc);
scrubs := join(dedup(sort(orbit_stat, sourcecode, ruledesc),sourcecode, ruledesc),
							Scrubs_LN_PropertyV2_Assessor.File_Fips, 
							left.sourcecode = right.fips_code,
							transform(left));

//assessor_l := recordof(Scrubs_LN_PropertyV2_Assessor.In_Property_Assessor);

//scrub_bits_l := {(assessor_l ) unsigned8 scrubsbits1, unsigned8 scrubsbits2 };

//scrub_bits := dataset('~thor_data::prop_assessor_scrubs_bits_update', scrub_bits_l , thor);
scrub_bits := join(distribute(dbuildbase, hash(fips)),
							distribute(Scrubs_LN_PropertyV2_Assessor.File_Fips,	hash(fips_code)),								 
							left.fips = right.fips_code,
							transform(left), local);

//scrub_bits;

summary_l := record
scrub_bits.fips;
unsigned num_recs := count(group);
unsigned num_recs_with_errors := sum(group,if(scrub_bits.scrubsbits1 + scrub_bits.scrubsbits2 > 0, 1, 0));
decimal5_2 pcnt := 0.00;
end;

summary_tbl := table(scrub_bits, summary_l, fips, few);

add_pct_t := project(summary_tbl, transform(summary_l, self.pcnt := ((real)left.num_recs_with_errors/(real)left.num_recs) * 100.00, self := left));
 
//sort(add_pct_t, pcnt);

//count(add_pct_t(pcnt <3));
//count(add_pct_t(pcnt >3));

fortmat_scrubs_rpt := project(scrubs, transform( s2_l, self.fieldname :=  stringlib.stringfindreplace(ut.Word(left.ruledesc,1,':'), '_', ' '),
																									     self.pcnt := ((real)left.rulecnt/(real)left.recordstotal)*100.00,
																											 self.fips := left.sourcecode,
																											 self.invalid_count := left.rulecnt,																					 
																											 self := left));

append_county_info1 := join(fortmat_scrubs_rpt, Scrubs_LN_PropertyV2_Assessor.File_Fips,
								left.fips = right.fips_code,
								transform( s2_l,
								self.state := right.state_code,
								self.county := self.state + '-' + trim(right.county_name, left, right) + '-' + left.fips,
								self := left),
								lookup);
append_county_info1;
	
append_county_info2 := join(add_pct_t, Scrubs_LN_PropertyV2_Assessor.File_Fips,
								left.fips = right.fips_code,
								transform( s2_l,
								self.recordstotal := left.num_recs; 
								self.fieldname := '_Total Recs With Errors %';
								self.invalid_count := left.num_recs_with_errors;
								self.state := right.state_code,
								self.county := self.state + '-' + trim(right.county_name, left, right) + '-' + left.fips,
								self := left),
								lookup);
								
append_county_info3 := project(append_county_info2, transform( s2_l,
																self.fieldname := '__Total Recs With Errors',
																self.pcnt := left.invalid_count,
																self := left)) ;

append_county_info4 := project(append_county_info3, transform( s2_l,
																self.fieldname := '___Total Recs',
																self.pcnt := left.recordstotal,
																self := left));
																
all_data := 	append_county_info1 + append_county_info2 + append_county_info3 + append_county_info4;															
					
buckets := project(add_pct_t, transform({recordof(add_pct_t), string bucket}, 
																															self.bucket := map(left.pcnt between 0 and 3.99 => '1blank',
																																								left.pcnt between 4 and 10 => '2green',	
																																								left.pcnt between 10.01 and 25 => '3yellow',
																																								left.pcnt between 25.01 and 50 => '4orange',
																																								left.pcnt between 50.01 and 100 => '5red',
																																								''),
																															self := left));

buckets_tbl := table(buckets, { bucket, counties := count(group), recs := sum(group,num_recs), recs_with_error := sum(group,num_recs_with_errors)}, bucket);
empty_buckets := dataset( [{'1blank',0,0,0},	{'2green',0,0,0}	,	{'3yellow',0,0,0}	,	{'4orange',0,0,0}, {'5red',0,0,0}], recordof(buckets_tbl));	 																													
final_bucket := dedup(sort(buckets_tbl+ empty_buckets, bucket, -recs), bucket);

//***********************************************************
rpts := sequential(
output(summary_t, named(pProfileName+'SummaryPart1' + vendor)),
output(summary(state_code <> ''), all,named(pProfileName+'SummaryStatsValidCountiesDetails'+ vendor)), // Show errors by field and type
output(summary(state_code = ''), all, named(pProfileName+'SummaryStatsInvalidCountiesDetails'+ vendor)), // Show errors by field and type
output(final_bucket, named(pProfileName+'SummaryPart2'+ vendor)),
output(choosen(sort(validity, -numberofrecords), 5000),named(pProfileName+'ValidityErrors'+ vendor)), // Just eyeball some errors
output(choosen(U.BadValues, 5000), named(pProfileName+'BiggestOffenders'+ vendor)), // See my nastiest field values
output(choosen(U.AllErrors, 5000), named(pProfileName+'InvalidValuesExamples'+ vendor)), // Just eyeball some errors
//************output(orbit_stat,,'~thor::property_assessor_scrubs_ln2', csv(QUOTE('"')), overwrite),
//P := H.AllProfiles;
output(H.InvSummary, all, named(pProfileName+'PopulationStats'+ vendor)),
);
return rpts;

end;