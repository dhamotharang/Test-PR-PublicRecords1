import Business_Header, SNA;
// Expand all business ln_fares that connect to deeds to people 
// Then measure business collusion.


//dDeedDetails := distribute(pull(LN_PropertyV2.key_deed_fid));

// fbc is the same as Business_Header.Key_Business_Contacts_BDID
//fbc := project( Business_Header.File_Prep_Business_Contacts_Plus(bdid > 0), Business_Header.Layout_Business_Contact_Full );


fbc := Business_Header.Key_Business_Contacts_BDID;

dBusinessContacts := fbc;
dBusinessFares := dedup(sort(SNA.prop_transaction_base(bdid>0), bdid, ln_fares_id, source_code), bdid, ln_fares_id, source_code); 

// This code is SPECIFICALLY to exclude clusters with only 2 members. 

TwoMemberClusters := sna.file_person_cluster_stats(totalcnt=2);

dReverseClusterPrep := SNA.file_person_cluster(cluster_id != 0 and associated_did != 0);
dReverseCluster := join(dReverseClusterPrep, TwoMemberClusters, left.cluster_id=right.cluster_id, 
                         transform(recordof(left), self := left), hash, left only);

// ln_fares_id, source_code, did

rFarePersons := record
	SNA.prop_transaction_base.did;
	SNA.prop_transaction_base.ln_fares_id;
	SNA.prop_transaction_base.source_code;
end;
	

dBusinessFaresContacts := join(dBusinessFares, dBusinessContacts(did != 0), left.bdid=right.bdid, transform(rFarePersons, self.did:=right.did, self := left), atmost(100), hash);
//output(dBusinessFaresContacts);

dPersonFares := project(SNA.prop_transaction_base(did != 0), transform(rFarePersons, self := left));

dAllFares := dedup(sort(dBusinessFaresContacts + dPersonFares, did, ln_fares_id, source_code), did, ln_fares_id, source_code);

// Calculate deeds where it is to add or subtract an owner.

// We exclude Interfamily and Quit Claims and transfers with exactly the same seller, buyer (which are predominantly between people who know each other and would skew results).
// NOTE I'm joining on ln_fares_id_to so it joins the stats from the selling end of the transaction edge!!!!

//base_property_sales := join(dAllFares, dDeedDetails,
//			left.ln_fares_id=right.ln_fares_id, transform({ recordof(left), LN_PropertyV2.key_deed_fid.recording_date, LN_PropertyV2.key_deed_fid.document_type_code, LN_PropertyV2.key_deed_fid.sales_price}, self := left, self := right), 
//			hash);

//base_property_sales := base_property_sales_prep(document_type_code!= 'Q' and document_type_code!= 'IT' and (unsigned6)sales_price > 40000 and to_sales_price > 1000 and (unsigned6)recording_date > 19970101);

property_network_rec := record
  recordof(dReverseCluster);
  recordof(dAllFares);
end;

// base_property_graph is sorted and deduped on cluster_id, ln_fares_id, source_code so that only 1 buyer row and 1 seller row can exist within a cluster for a ln_fares_id
// so if there are more than one then one of the buyers and one of the sellers must be within the cluster.

base_property_graph := dedup(sort(join(dAllFares, dReverseCluster, left.did=right.associated_did, transform(property_network_rec, self := left, self := right), atmost(10000), hash), 
                          cluster_id, ln_fares_id, source_code, degree), 
                          cluster_id, ln_fares_id, source_code);

// Cluster in_network if within a cluster it has more than one source_code for the same ln_fares_id
in_network_prep := table(sort(base_property_graph, cluster_id, ln_fares_id), {cluster_id, ln_fares_id, net_degree := sum(group, degree), in_network := map(count(group) > 1 => true, false) }, cluster_id, ln_fares_id);
file_ln_fare_indicators := dedup(sort(in_network_prep(in_network), ln_fares_id, net_degree), ln_fares_id);

export file_property_innetwork_fares := file_ln_fare_indicators;
