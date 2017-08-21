/*--SOAP--
<message name="DIDAnalysisService" wuTimeout="300000">
  <part name="Did" type="xsd:integer"/>
  <part name="UsePropogation" type="xsd:boolean"/>
 </message>
*/
/*--INFO-- This service will analyse the DID that is entered based upon existing data. If UsePropogation is checked then the data will be 'extended' in the manner that the internal DID 
process propogates data prior to matching. This may find some matches that would <b>not</b> occur just from matching the records together.
*/

// Test cases
// Bad did - 955030805
// Marks version - 1081106860

export DidAnalysisService := MACRO

unsigned8 MyDid := 0 : stored('Did');
boolean Propogate := false : stored('UsePropogation');

base_recs := limit(doxie.Key_Header(s_did=MyDid), ut.limits.HEADER_PER_DID, skip);

// Produce the matching candidates - using propogation or otherwise
header.Layout_Header into_h(base_recs le) := transform
  self.jflag3 := le.valid_dob;
	self.dob := if ( le.valid_dob='M', 0, le.dob );
	self.ssn := if ( le.valid_ssn='M','',le.ssn );
  self := le;
  end;

hrecs := project(base_recs,into_h(left));

header.Layout_matchcandidates into(base_recs le) := transform
  self.head_cnt := 0;
	self.dob := if ( le.valid_dob='M',0,le.dob );
	self.ssn := if( le.valid_ssn='M','', le.ssn );
  self := le;
  end;

p0 := project(base_recs,into(left));

// Produce the 'best file' for purposes of propogation
watchdog.Layout_Best take_best(watchdog.Layout_Key le) := transform
  self := le;
  end;
	
bestfile := limit(project(watchdog.Key_watchdog_glb(did=MyDid),take_best(left)), ut.limits.default, skip);	

pop_recs := if ( propogate, header.fn_Populate_Matchrecs(hrecs,bestfile,'SKIPIT'), p0 );

// Get the scope files for the good/badly behaved markers
ssns := autochad.mod_ssn_scope(pop_recs).values;
ssn_recs := project(autochad.mod_ssn_scope(pop_recs).records(did<>MyDid),into(left));

addrs := autochad.Mod_Address_Scope(pop_recs).values;
addr_recs := project(autochad.mod_address_scope(pop_recs).records(did<>MyDid),into(left));

header.layout_matchcandidates split_did(header.Layout_matchcandidates le) := transform
	self.did := le.rid;
  self := le;
  end;

all_matched_recs := header.fn_match_candidates(pop_recs+ssn_recs+addr_recs,hrecs,'SKIPIT');
//all_matched_recs := header.fn_Populate_Matchrecs(hrecs+ssn_recs+addr_recs,bestfile,'SKIPIT');

matched_recs := join(all_matched_recs,base_recs,left.rid=right.rid,transform(left));

p := project( if ( propogate, matched_recs ,p0 ),split_did(left));

//Compute all of the match links between the raw records

matches0 := header.Did_Rules0(p,'SKIPIT' ,false).result;

// Transitively close the links forming 'best path' for each one

matches := autochad.fn_form_clusters(matches0);


//output(matches);
// Produce a rolled up view of the matches
r := record
  unsigned6 rid;
	string    rule;
	unsigned2 distance;
  end;
	
relat := record
  unsigned6 rid;
	dataset(r) related_to;
	end;
	
relat add_rels(matches ri) := transform
  self.rid := ri.rid1;
	self.related_to := dataset([{ri.rid2, (string)ri.pflag, ri.distance }],r );
  end;
	
mtch := project(matches,add_rels(left));	

relat combine(relat le, relat ri) := transform
  self.rid := le.rid;
	self.related_to := sort( le.related_to + ri.related_to, rid );
  end;

mtch0 := rollup( sort ( mtch, rid ), left.rid = right.rid, combine(left,right) );


// Now compute DID clusterings by the records we have

computed_dids := mtch0(rid<min(related_to,rid));

ncdr := record
  computed_dids;
	unsigned cluster;
  end;

ncdr add_cnum(computed_dids le, unsigned c) := transform
  self.cluster := c;
  self := le;
  end;

cnum_rec := record
	unsigned cluster;
  unsigned6 rid;
	end;
	
cnum_rec note_cnums(ncdr le,unsigned c) := transform
  self.rid := if ( c > count(le.related_to),le.rid,le.related_to[c].rid);
  self.cluster := le.cluster;
  end;	

nclusters := normalize( project(computed_dids,add_cnum(left,counter)), count(left.related_to)+1,note_cnums(left,counter));	

// Add cluster numbers to raw records and match records

hrecs_c := sort(join(nclusters,hrecs,left.rid=right.rid),cluster,rid);
p_c := sort(join(nclusters,p,left.rid=right.did),cluster,rid);
matches_c := join(nclusters,matches,left.rid=right.rid1);

// Compute stats on the spanning distances of the distinct clusters
clust_dist := record
  matches_c.cluster;
  matches_c.distance;
	unsigned2 cnt := count(group);
  end;
	
spans := sort(table(matches_c,clust_dist,cluster,distance),cluster,distance);	

// Compute some distances between the names in the records

names := dedup( table( p, {fname,mname,lname} ),all );

names_rec := record
  string30 fname_1;
  string30 mname_1;
  string30 lname_1;
  string30 fname_2;
  string30 mname_2;
  string30 lname_2;
	unsigned namematch_distance;
  end;

names_rec note_namematch(names le, names ri) := transform
  self.fname_1 := le.fname;
  self.mname_1 := le.mname;
  self.lname_1 := le.lname;
  self.fname_2 := ri.fname;
  self.mname_2 := ri.mname;
  self.lname_2 := ri.lname;
	self.namematch_distance := ut.NameMatch(le.fname,le.mname,le.lname,ri.fname,ri.mname,ri.lname);
  end;
	
nds := join(names,names,left.fname<>right.fname or
                        left.mname<>right.mname or
												left.lname<>right.lname,note_namematch(left,right),all);	

// Now compute and display some sanity checks
ddg := header.Mod_DodgyDids(hrecs).Result;

prelim_rec := record
  boolean rid_gt_did;
	boolean rid_in_did;
	boolean officially_dodgy;
	boolean mismatching_names;
	unsigned number_ssns;
	unsigned distinct_clusters;
	unsigned num_records;
	unsigned orphans;
	unsigned singletons;
	unsigned largest_span;
  end;
	
prelims := dataset( [{
											~exists(hrecs(rid<did)),
											exists(hrecs(rid=did)),
											exists(ddg),
											exists(nds(namematch_distance>4)),
											count(ssns),
											count(computed_dids),
											count(hrecs),
											count(mtch0(~exists(related_to(distance=1)))),
											count(mtch0(count(related_to(distance=1))=1)),
											max(spans,distance)
										  }], prelim_rec );


output(prelims,named('Summary'));
output(computed_dids,named('ComputedDids'));
output(bestfile,named('BestInformation'));
output(ddg,named('DodgyDids'));
// Now perform some DodgyDid analysis
output(header.Mod_DodgyDids(hrecs).did_tab,named('DodgyDidTable'));
//output(header.Mod_DodgyDids(hrecs).rts,named('DodgyDidSSNRecords'));
output(header.Mod_DodgyDids(hrecs).did_ssn,named('DodgyDidSSNTable'));
output(header.Mod_DodgyDids(hrecs).did_gender,named('DodgyDidGenderTable'));
output(header.Mod_DodgyDids(hrecs).did_ssn_group,named('DodgyDidSSNGroupTable'));


output(spans,named('MinClusterDistances'));
output(hrecs_c,named('RawRecords'));
output(choosen(nds,1000),named('NameDistances'));
output(sort(ssns,ssn),named('SSNs'));
output(choosen(sort(ssn_recs,ssn),1000),named('AdditionalSSNRecords'));
output(addrs,named('Addresses'));
output(choosen(sort(addr_recs,prim_range,prim_name,zip),1000),named('AdditionalAddressRecords'));
output(choosen(p_c,1000),named('MatchRecords'));
output(mtch0,named('LinkedRecords'));
  ENDMACRO;