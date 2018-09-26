IMPORT alertlist;

EXPORT AlertListNetworkPeople(InDid,  InJobId) := MACRO

  pInput := dataset('', AlertList.Files.Layout_Batch_Input, thor);
	Social_did_key := INDEX(pInput, {did},  {entity_id, original_fname, original_mname, original_lname, original_name_suffix, Flag1_Active, Flag2_Alert, Flag3, Flag4, Flag5}, '~thordev_socialthor_50::out::social_did_key::'+InJobId);
	
  ClusterPeople := AlertList.Key_Person_Cluster(cluster_id=InDid);


 ClusterPeople2 := join(ClusterPeople, Social_did_key, left.associated_did=right.did, TRANSFORM(recordof(LEFT), self := LEFT), keyed);
	

  PeopleLabelsPrep1 := join(ClusterPeople2, Watchdog.Key_Watchdog_nonglb, 
	                            left.associated_did=right.did, transform({left.degree, recordof(right), integer group := 0}, self.degree := left.degree, self := right), ATMOST(10000), hash, keyed);

	
  PeopleLabelsPrep2 := dedup(sort(join(PeopleLabelsPrep1, Social_did_key, left.did=right.did, 
	                           TRANSFORM({
																	 right.Entity_Id, // Unique ID supplied by the customer 
                                   left.degree, left.did,left.phone,left.ssn,left.dob,left.title,left.fname,left.mname,left.lname,
                                   right.Flag1_Active, right.Flag2_Alert, right.Flag3, right.Flag4, right.Flag5},
														              self.title :=  MAP(left.title=''=>'.', left.title), self.lname := MAP(left.lname=''=>'.', left.lname), self.mname := MAP(left.mname=''=> '.', left.mname), self.ssn := ' ', self.phone := ' ', self.dob := 0,
																					self := left, self := right), atmost(10000), hash), entity_id), entity_id);
	topn(PeopleLabelsPrep2, 1000, degree);
	
	
ENDMACRO;

