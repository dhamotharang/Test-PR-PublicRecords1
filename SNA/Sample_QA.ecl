import Data_Services;
export Sample_QA := module

//Diff Person cluster

Key_PC_QA := pull(SNA.Key_Person_Cluster);
key_PC_father := INDEX(SNA.File_Person_Cluster,{cluster_id}, {degree, associated_did,global_sid,record_sid}, Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::sna::person_cluster_father');

key_PC_father_pull := pull(key_PC_father);

Key_PC_QA trecs(Key_PC_QA L, key_PC_father_pull R) := transform
self := L;
end;

jrecs := join(distribute(Key_PC_QA,HASH(cluster_id)),distribute(key_PC_father_pull,HASH(cluster_id)),LEFT.cluster_id=RIGHT.cluster_id,trecs(LEFT,RIGHT),LEFT ONLY,LOCAL);

pcsample := output(choosen(jrecs,500),named('Person_Cluster_Sample'));

//Diff Person cluster Attributes

Key_PCAtr_QA := pull(SNA.Key_Person_Cluster_Attributes);
cohesivity_table := SNA.file_person_cluster_stats;
Key_PCAtr_father := index( cohesivity_table, {cluster_id}, {cohesivity_table}, Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::sna::person_cluster_attributes_father' );

key_PCAtr_father_pull := pull(Key_PCAtr_father);

Key_PCAtr_QA trecs_atr(Key_PCAtr_QA L, key_PCAtr_father_pull R) := transform
self := L;
end;

jrecs_atr := join(distribute(Key_PCAtr_QA,HASH(cluster_id)),distribute(key_PCAtr_father_pull,HASH(cluster_id)),LEFT.cluster_id=RIGHT.cluster_id,trecs_atr(LEFT,RIGHT),LEFT ONLY,LOCAL);

pcasample := output(choosen(jrecs_atr,500),named('Person_Cluster_Attributes_Sample'));

//Diff Property cluster Stats

Key_PtyStats_QA := pull(SNA.Key_Prop_Cluster_Stats);
dc := SNA.DeedsClustering(cluster_id != 0);

L := record
	dc.cluster_id;
	dc.cluster_sales_count;
	dc.cluster_flip_count;
	dc.cluster_flip_count10;
	dc.cluster_flip_count30;
	dc.cluster_flip_count60;
	dc.cluster_flip_count120;
	dc.cluster_flip_count180;
	dc.cluster_flip_0_degree;
	dc.cluster_flip_1_degree;
	dc.cluster_flip_2_degree;
	dc.cluster_flip_business_count;
	dc.cluster_flop_count;
	dc.cluster_flop_person_count;
	dc.cluster_flop_person_busines_count;
	dc.cluster_in_network_count;
	dc.cluster_in_network_count_0_degree;
	dc.cluster_in_network_count_1_degree;
	dc.cluster_in_network_count_2_degree;
	dc.cluster_in_network_flip_business_count;
	dc.cluster_in_network_flop;
	dc.cluster_in_network_flip_count;
	dc.cluster_in_network_flip_count_0_degree;
	dc.cluster_in_network_flip_count_1_degree;
	dc.cluster_in_network_flip_count_2_degree;
	dc.cluster_high_profit_count;
	dc.cluster_high_profit_count_0_degree;
	dc.cluster_high_profit_count_1_degree;
	dc.cluster_high_profit_count_2_degree;
	dc.cluster_in_network_high_profit;
	dc.cluster_in_network_high_profit_0_degree;
	dc.cluster_in_network_high_profit_1_degree;
	dc.cluster_in_network_high_profit_2_degree;
	dc.cluster_in_network_high_profit_flip_count;
	dc.cluster_default_count;
	dc.cluster_default_count_0_degree;
	dc.cluster_foreclosure_count;
	dc.cluster_foreclosure_count_0_degree;
	dc.cluster_foreclosure_default_count;
	dc.cluster_foreclosure_default_count_0_degree;
	dc.prop_network_cohesivity;
	dc.prop_1st_degrees;
	dc.prop_2nd_degrees;
	dc.sales_count_stdd;
	dc.flip_count_actors;
	dc.flip_count_stdd;
	dc.cluster_ends_in_default_foreclosure;
	dc.cluster_fha_count;
	dc.cluster_va_count;
	dc.prop_people_count;
	dc.cluster_suspicious_govt_loan_count;
	dc.distinct_property_count;
	dc.high_incidence_flip_count;
	dc.high_incidence_in_network_count;
	dc.high_incidence_in_network_flip_count;
	dc.high_incidence_high_profit_count;
	dc.high_incidence_in_network_high_profit_count;
	dc.high_incidence_in_network_high_profit_flip_count;
	dc.totalcnt;
	dc.firstdegrees;
	dc.seconddegrees;
	dc.cohesivity;
	dc.p_city_name;
	//CCPA-767
	UNSIGNED4 global_sid		:= 0;
	UNSIGNED8 record_sid		:= 0;
	UNSIGNED4 did 						:= 0;

end;

t := table( dc, L );



Key_prop_cluster_stats_father := index(t, {cluster_id}, {t}, Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::sna::property_ownership_cluster_stats_father');

Key_PtyStats_father_pull := pull(Key_prop_cluster_stats_father);

Key_PtyStats_QA trecs_stats(Key_PtyStats_QA L, Key_PtyStats_father_pull R) := transform
self := L;
end;

jrecs_stats := join(distribute(Key_PtyStats_QA,HASH(cluster_id)),distribute(Key_PtyStats_father_pull,HASH(cluster_id)),LEFT.cluster_id=RIGHT.cluster_id,trecs_stats(LEFT,RIGHT),LEFT ONLY,LOCAL);

pcssample := output(choosen(jrecs_stats,500),named('Property_Cluster_Stats_Sample'));

export out := Sequential( pcsample,
                          pcasample,
													pcssample ) : success( FileServices.SendEmail ( 'sudhir.kasavajjala@lexisnexis.com; Melanie.Jackson@lexisnexis.com; RISBCTQualityAssurance@lexisnexis.com','SNA -- QA Samples','QA -- Please view the following workunit for SNA Samples'+workunit )),
													              failure( FileServices.SendEmail ( 'sudhir.kasavajjala@lexisnexis.com; Melanie.Jackson@lexisnexis.com' ,'SNA -- QA Sample failure','SNA QA Sample WU failed :'+workunit));

end;

