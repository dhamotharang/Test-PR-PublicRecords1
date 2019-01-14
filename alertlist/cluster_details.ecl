import AlertList;

//alert_in := dataset('~thordev_socialthor_50::in::alertlist::12341237', AlertList.Files.Layout_Batch_Input, csv);
alert_in := dataset('~thordev_socialthor_50::in::alertlist::12348', AlertList.Files.Layout_Batch_Input, csv);

Stats := table(Alert_in, 
             {
						  flag1_active_count := count(group, flag1_active = true), 
						  flag2_alert_count := count(group, flag2_alert=true),
							flag3_count := count(group, flag3=true),
							flag4_count := count(group, flag4=true),
							flag5_count := count(group, flag5=true)}, few, merge);

output(Stats, named('InputStats'));							
                                
alert_out_rec := RECORD
  string id;
  string customer_id;
  string product_id;
  string lid_type;
  unsigned8 lid;
  string120 original_company_name;
  unsigned3 original_company_zip;
  string20 original_fname;
  string20 original_mname;
  string20 original_lname;
  string5 original_name_suffix;
  unsigned8 cluster_id;
  unsigned2 totalcnt;
  unsigned2 firstdegrees;
  unsigned2 seconddegrees;
  real4 cohesivity;
  integer8 active_company_count;
  integer8 active_company_0;
  integer8 active_company_1;
  integer8 active_company_2;
  integer8 alert_company_count;
  integer8 alert_company_0;
  integer8 alert_company_1;
  integer8 alert_company_2;
  integer8 flag3_company_count;
  integer8 flag3_company_0;
  integer8 flag3_company_1;
  integer8 flag3_company_2;
  integer8 flag4_company_count;
  integer8 flag4_company_0;
  integer8 flag4_company_1;
  integer8 flag4_company_2;
  integer8 flag5_company_count;
  integer8 flag5_company_0;
  integer8 flag5_company_1;
  integer8 flag5_company_2;
  integer8 active_person_count;
  integer8 active_person_0;
  integer8 active_person_1;
  integer8 active_person_2;
  integer8 alert_person_count;
  integer8 alert_person_0;
  integer8 alert_person_1;
  integer8 alert_person_2;
  integer8 flag3_person_count;
  integer8 flag3_person_0;
  integer8 flag3_person_1;
  integer8 flag3_person_2;
  integer8 flag4_person_count;
  integer8 flag4_person_0;
  integer8 flag4_person_1;
  integer8 flag4_person_2;
  integer8 flag5_person_count;
  integer8 flag5_person_0;
  integer8 flag5_person_1;
  integer8 flag5_person_2;
 END;

//alert_out := dataset('~thordev_socialthor_50::out::social_person_clusters::12341211', alert_out_rec, thor);
alert_out := dataset('~thordev_socialthor_50::out::social_alert_results::12348', alert_out_rec, thor);


// Which of the original are businesses according to business_contacts

// Score the bads 

AlertBads := topn(dedup(sort(Alert_out(cohesivity < 1.6 and totalcnt < 600), lid_type, lid, original_company_name), lid_type, lid, original_company_name), 200, -alert_company_1);
output(AlertBads, named('AlertBads'));
//output(topn(AlertBads, 100, -alert_person_1), named('ScoreSearchPeople'));


// Distribution of Scores Summary.
h1 := dataset([{1, 'Alert Company', 'Total'}], {unsigned seq, string Label, string Total});

AlertCompanyDist := table(sort(dedup(sort(AlertBadsPrep, lid_type, lid, original_company_name), lid_type, lid, original_company_name), alert_company_count, skew(1)), {unsigned seq := 2, string Label := (string)alert_company_count, string Total := (string)count(group)}, alert_company_count, few, skew(1.2));

h2 := dataset([{3, 'Alert Company 1', 'Total'}], {unsigned seq, string Label, string Total});
AlertCompany1Dist := table(sort(dedup(sort(AlertBadsPrep, lid_type, lid, original_company_name), lid_type, lid, original_company_name), alert_company_1, skew(1)), {unsigned seq := 4, string Label := (string)alert_company_1, string Total := (string)count(group)}, alert_company_1, few, skew(1.2));

DistributionsOutput := h1 + topn(AlertCompanyDist, 100, Label) + h2 + topn(AlertCompany1Dist, 100, Label);
output(sort(DistributionsOutput, seq), named('AlertDistributions'));

// What companies for a given centroid


in_cluster_id := 40153524008;

// Find all people in the cluster
ClusterPeople1 := AlertList.Key_Person_Cluster(cluster_id = in_cluster_id and degree <= 1);
ClusterPeople2 := join(ClusterPeople1, AlertList.Key_Person_Cluster, left.associated_did = right.cluster_id and degree <= 1);


// Join to their businesses

ClusterPeopleAllBusinesses := join(ClusterPeople, AlertList.Key_Business_Contacts_did, left.associated_did=right.did);
ClusterPeopleAllCustomersBusinesses := dedup(sort(join(ClusterPeopleAllBusinesses, alert_in(bdid > 0), left.bdid=right.bdid, hash, skew(1)), bdid, degree, skew(1)), bdid);
output(ClusterPeopleAllCustomersBusinesses, named('AlertBusinessCase'), all);

// Labels for businesses and people.

