// Extract external linking test records from base file
IMPORT MyModule, SALTnn;
test_sample_init := enth(MyModule.File_Sample, 1000);
layout_test_seq := record
unsigned4 UniqueID;
test_sample_init;
end;
// Add Unique IDs
test_sample_seq := project(test_sample_init,
                           transform(layout_test_seq,
						             self.UniqueId := counter,
									 self := left));
// Remove existing entity identifiers from sample									 
test_sample := project(test_sample_seq,
                       transform(MyModule.Process_XSAMPL_Layouts.InputLayout,
					             self.locale := '',
								 self.address := '',
								 self.vin := '',
								 self.ln_fares_id := '',
								 self.court_case_number := '',
								 self := left));
// Use external linking online process
MyModule.MAC_MEOW_XSAMPL_Online(test_sample,UniqueID,city,state,company_name,
  prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,zip,zip4,
  county,msa,phone,fein,,,,,,results_out);
// Process errors
output(results_out(errorcode!=''),{UniqueID, errorcode});
// Process timing
output(results_out(errorcode='', UniqueID <> 0),{UniqueID, transaction_time});
// Process results
// Strip off error code and timing information
results := sort(project(results_out(errorcode='', UniqueID <> 0),
                               MyModule.Process_XSAMPL_Layouts.OutputLayout),UniqueID);
output(results,,'MyModule::sample_external_data_linked_online',overwrite);
// output sample results
output(results(resolved));
output(results(~resolved));
// Summary entity resolution stats
layout_resolved_stats := record
cnt_total := count(group);
cnt_Verified := count(group, results.Verified);   // has found possible results
cnt_Ambiguous := count(group, results.Ambiguous); // has >= 20 IDs within an order of magnitude of best
cnt_ShortList := count(group, results.ShortList); // has < 20 IDs within an order of magnitude of best
cnt_Handful := count(group, results.Handful);     // has <6 IDs within two orders of magnitude of best
cnt_Resolved := count(group, results.Resolved);   // certain with 3 nines of accuracy
cnt_Records_with_Candidate_IDs := count(group, count(results.results) > 0);
end;
fstats := table(results, layout_resolved_stats, few);
output(fstats);
// Compare resolved BDIDs to Test Sample BDIDs
layout_resolved_bdid := record
MyModule.Process_XSAMPL_Layouts.InputLayout;
unsigned6 bdid;
end;
// Use BDID on first record in results child dataset
layout_resolved_bdid GetResolvedBDID(results l) := transform
self.bdid := l.Results[1].bdid;
self := l;
end;
test_resolved_bdid := project(results(resolved), GetResolvedBDID(left));
layout_sample_compare := record
test_sample_seq;
unsigned6 meow_bdid;
end;
// Exact matches on BDID
bdid_matches := join(test_sample_seq,
                     test_resolved_bdid,
					 left.UniqueID = right.UniqueID,
					 transform(layout_sample_compare,
					           self.meow_bdid := right.bdid,
							  self := left),
					 hash);
// output sample BDID matches				
count(bdid_matches((unsigned6)bdid = meow_bdid));
output(enth(bdid_matches((unsigned6)bdid = meow_bdid),100));
// output sample BDID non-matches
count(bdid_matches((unsigned6)bdid <> meow_bdid));
output(enth(bdid_matches((unsigned6)bdid <> meow_bdid),100));
// Records which did not match
layout_nonmatches := record,maxlength(32000)
unsigned6 test_bdid;
results;
end;
non_matches := join(results(resolved),
                    bdid_matches((unsigned6)bdid <> meow_bdid),
					left.UniqueID = right.UniqueID,
					transform(layout_nonmatches,
					          self.test_bdid := (unsigned6)right.bdid,
							  self := left),
					hash);
// output sample non-matching meow results
output(enth(non_matches,100));			
