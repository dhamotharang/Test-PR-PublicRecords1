IMPORT alertlist;

EXPORT AlertListNetwork(InDid, InJobId) := MACRO

//	integer in_cluster_id := 384520705 : STORED('cluster_id');
	
// 	string FileID := '12341210';

  pInput := dataset('', AlertList.Files.Layout_Batch_Input, thor);
	Social_did_key := INDEX(pInput, {did},  {entity_id, original_fname, original_mname, original_lname, original_name_suffix, Flag1_Active, Flag2_Alert, Flag3, Flag4, Flag5}, '~thordev_socialthor_50::out::social_did_key::'+InJobId);

	
  ClusterPeople1 := dedup(sort(AlertList.Key_Person_Cluster(cluster_id=InDid and degree <= 1), associated_did), associated_did);
	ClusterPeople2 := sort(join(ClusterPeople1, AlertList.Key_Person_Cluster, left.associated_did = right.cluster_id and right.degree <= 1, transform({recordof(right), integer source := 0, integer target := 0}, self := right), hash), cluster_id, degree);

  PeopleLabelsPrep1 := join(dedup(sort(ClusterPeople2, associated_did), associated_did), Watchdog.Key_Watchdog_nonglb, 
	                            left.associated_did=right.did, transform({recordof(right), integer group := 0}, self := right), hash, keyed);

	
  PeopleLabelsPrep2 := join(PeopleLabelsPrep1, Social_did_key, left.did=right.did, 
	                           TRANSFORM(recordof(left), 
														              self.group := MAP(right.flag1_active => 1, MAP(right.flag2_alert => 2, MAP(right.flag3 => 3, MAP(right.flag4 => 4, MAP(right.flag5 => 5, 0))))), self := left), left outer, hash);
	
  NodeLabels := RECORD
	  integer nodeid := 0;
	  string Name;
		integer group;
		integer nodetype := 1;
		integer id := 0;
	END;
	
	PeopleLabels := project(PeopleLabelsPrep2, 
	                  transform(NodeLabels, 
										          self.NodeId := COUNTER-1, 
															self.id := left.did, 
															self.Name := trim(left.fname) + ' ' + trim(left.mname) + ' ' + trim(left.lname), self.group := left.group
															));
	
  EdgePrep1 := join(ClusterPeople2, PeopleLabels, left.cluster_id = right.id, TRANSFORM(recordof(LEFT), self.source := right.nodeid, self := left), hash, left outer);
  EdgePrep2 := join(EdgePrep1, PeopleLabels, left.associated_did = right.id, TRANSFORM(recordof(LEFT), self.target := right.nodeid, self := left), hash, left outer);

  Edge_rec := RECORD
	  integer source;
		integer target;
		integer value;
	END;
	
	Edges := PROJECT(EdgePrep2, TRANSFORM(Edge_rec, self.value := 1, self := left));
  sequential(
  output(PeopleLabels, all, named('nodes'));
	output(Edges, all, named('links')));
	
ENDMACRO;

