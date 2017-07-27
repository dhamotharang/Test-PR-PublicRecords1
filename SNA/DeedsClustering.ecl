/*2012-12-06T02:37:21Z (Michele Walklin)
changed in-network-risk to net-degree between 0 and 1.75
*/
// dBasePropertySales := SNA.prop_transaction_base(did != 0);

// dTransactionStats := SNA.file_prop_transaction_stats(ownership_change and (unsigned6)recording_date > 20000101);
dClusterDids := SNA.file_person_cluster(cluster_id != 0 and associated_did != 0);
dPersonClusterStats := SNA.file_person_cluster_stats;

cluster_fares := dedup(sort(join(dClusterDids, SNA.prop_transaction_base, left.associated_did=right.did, 
								transform({left.cluster_id, left.degree, right.ln_fares_id}, 
								self.cluster_id := left.cluster_id, self.degree := left.degree, self := right), 
								atmost(10000), hash), cluster_id, ln_fares_id), cluster_id, ln_fares_id);

cluster_fares_transactions_prep := join(cluster_fares, sna.file_prop_transaction_stats, left.ln_fares_id=right.ln_fares_id, 
			transform({left.cluster_id, left.degree,  decimal3_2 network_degree, right.flip, right.days, right.business_transaction, left.ln_fares_id, right.did,
			right.prim_name, right.prim_range, right.predir, right.suffix, right.sec_range, right.p_city_name, right.recording_date, right.source_code, 
			right.buyer_id_combination, right.flop,	right.person_transaction,	right.in_network_risk, right.high_profit,	right.in_network_high_profit,
			right.in_network_high_profit_flip, right.mortgage_default, right.mortgage_foreclosure, right.ownership_change, right.ends_in_default_or_foreclosure, right.first_td_loan_type_code,
			right.flip_count, right.in_network_count, right.in_network_flip_count, right.high_profit_count, right.in_network_high_profit_count, right.in_network_high_profit_flip_count
			}, 
				self.cluster_id := left.cluster_id, self.degree := left.degree, self.ln_fares_id := left.ln_fares_id, self.network_degree := 1.75, self := right), atmost(10000), left outer, hash);

cluster_fares_transactions := dedup(sort(cluster_fares_transactions_prep,
				cluster_id, prim_name, prim_range, predir, suffix, sec_range, recording_date, buyer_id_combination), 
				cluster_id, prim_name, prim_range, predir, suffix, sec_range, recording_date, buyer_id_combination);

// cluster city counts so we can append the predominant Property city for a cluster (provides jurisdiction for Feds and can be used for heatmap).

cluster_property_city := dedup(sort(table(sort(cluster_fares_transactions, cluster_id, p_city_name), {cluster_id, p_city_name, prop_city_count := count(group)}, cluster_id, p_city_name), cluster_id, -prop_city_count), cluster_id);

// this gives degree and sales counts per person in cluster for use in cluster cohesivity and stdd spread for sales counts.
cluster_people_counts := table(sort(cluster_fares_transactions, cluster_id, did), {cluster_id, did, degree, people_sales_count := count(group, ownership_change), people_flip_count := count(group, flip)}, cluster_id, did);
cluster_people_stats := table(cluster_people_counts, {cluster_id, prop_network_cohesivity := ave(group, degree), prop_people_count := count(group), prop_1st_degrees := count(group, degree=1), prop_2nd_degrees := count(group, degree=2), sales_count_stdd := sqrt(VARIANCE(group, people_sales_count)), flip_count_actors := count(group, people_flip_count > 0), flip_count_stdd := sqrt(VARIANCE(group, people_flip_count))}, cluster_id);

cluster_stats := table(cluster_fares_transactions, 
		{ cluster_id,
		  cluster_sales_count := count(group, ownership_change), 
      cluster_flip_count := count(group, flip), 
			cluster_flip_count10 := count(group, days > -1 and days < 11 and flip), 
			cluster_flip_count30 := count(group, days > 10 and days < 31 and flip), 
			cluster_flip_count60 := count(group, days > 30 and days < 61 and flip), 
			cluster_flip_count120 := count(group, days > 60 and days < 121 and flip), 
			cluster_flip_count180 := count(group, days > 120 and days < 181 and flip),
			cluster_flop_count180 := count(group, days > 120 and days < 181 and flop),
			cluster_flip_0_degree := count(group, degree = 0  and flip),
			cluster_flip_1_degree := count(group, degree > 0 and degree <= 1 and flip),
			cluster_flip_2_degree := count(group, degree > 1 and degree <= 2 and flip),
			cluster_flip_business_count := count(group, flip and business_transaction), 
			cluster_flop_count := count(group, flop), 
  		cluster_flop_0_degree := count(group, degree = 0 and days < 181 and flip),
			cluster_flop_person_count := count(group, flop and person_transaction and not business_transaction), 
			cluster_flop_person_busines_count := count(group, flop and business_transaction), 
			cluster_in_network_count := count(group, ownership_change and degree between 0 and network_degree), 
			cluster_in_network_count_0_degree := count(group, ownership_change and degree = 0), 
			cluster_in_network_count_1_degree := count(group, ownership_change and  degree > 0 and degree <= 1), 
			cluster_in_network_count_2_degree := count(group, ownership_change and  degree > 1 and degree <= 2), 
			cluster_in_network_flip_business_count := count(group, degree between 0 and network_degree and flip and business_transaction), 
			cluster_in_network_flop := count(group, flop and degree between 0 and network_degree),
			cluster_in_network_flip_count := count(group, degree between 0 and network_degree and flip), 
			cluster_in_network_flip_count_0_degree := count(group,  flip and degree = 0), 
			cluster_in_network_flip_count_1_degree := count(group,  flip and degree > 0 and degree <= 1), 
			cluster_in_network_flip_count_2_degree := count(group,  flip and degree > 1 and degree <= 2), 
			cluster_high_profit_count := count(group, high_profit and ownership_change), 
			cluster_high_profit_count_0_degree := count(group, ownership_change and high_profit and degree = 0), 
			cluster_high_profit_count_1_degree := count(group, ownership_change and high_profit and degree > 0 and degree <= 1), 
			cluster_high_profit_count_2_degree := count(group, ownership_change and high_profit and degree > 1 and degree <= 2), 
			cluster_in_network_high_profit := count(group, ownership_change and in_network_high_profit and degree between 0 and network_degree), 
			cluster_in_network_high_profit_0_degree := count(group, ownership_change and in_network_high_profit and degree = 0), 
			cluster_in_network_high_profit_1_degree := count(group, ownership_change and in_network_high_profit and  degree > 0 and degree <= 1), 
			cluster_in_network_high_profit_2_degree := count(group, ownership_change and in_network_high_profit and degree > 1 and degree <= 2),
			cluster_in_network_high_profit_flip_count := count(group, in_network_high_profit_flip),
			cluster_default_count := count(group, mortgage_default),
			cluster_default_count_0_degree := count(group, degree = 0 and mortgage_default),
			cluster_foreclosure_count := count(group, mortgage_foreclosure),
			cluster_foreclosure_count_0_degree := count(group, degree = 0 and mortgage_foreclosure),
			cluster_foreclosure_default_count_0_degree := count(group, (degree = 0 and mortgage_default) or (degree = 0 and mortgage_foreclosure)),
			cluster_foreclosure_default_count := count(group, mortgage_foreclosure or mortgage_default),
			cluster_ends_in_default_foreclosure := count(group, ownership_change and ends_in_default_or_foreclosure),
			cluster_fha_count := count(group, ownership_change and first_td_loan_type_code = 'FHA'),
			cluster_va_count := count(group, ownership_change and first_td_loan_type_code = 'VA'),
      cluster_suspicious_govt_loan_count := count(group, ownership_change and (first_td_loan_type_code = 'FHA' or first_td_loan_type_code = 'VA') and (flip or in_network_risk or high_profit)),
			cluster_deeds_past_3yrs_cnt_0_degree_count := count(group, ownership_change and days < 1095 and degree=0),
			cluster_property_0_degree_count := count(group, degree = 0 and source_code = 'OP'),
			cluster_sales_180day_0_degree_count := count(group, degree = 0 and days < 181 and ownership_change and source_code = 'SP'),
			cluster_sold_high_prof_count := count(group, degree = 0 and high_profit and ownership_change and source_code = 'SP'),
			}, 
			cluster_id);

cluster_in_network_rec := record
    recordof(cluster_stats); 
		cluster_people_stats.prop_people_count;
		cluster_people_stats.prop_network_cohesivity;
		cluster_people_stats.prop_1st_degrees;
		cluster_people_stats.prop_2nd_degrees;
		cluster_people_stats.sales_count_stdd;		
		cluster_people_stats.flip_count_actors;
		cluster_people_stats.flip_count_stdd;
		dPersonClusterStats.totalcnt;
		dPersonClusterStats.firstdegrees; 
		dPersonClusterStats.seconddegrees; 
		dPersonClusterStats.cohesivity;
end;

cluster_with_person_stats := join(cluster_stats, dPersonClusterStats, left.cluster_id=right.cluster_id, 
							transform(cluster_in_network_rec, 
								self := left, self := right, self.prop_people_count := 0, self.prop_network_cohesivity := 0, self.prop_1st_degrees := 0, self.prop_2nd_degrees := 0, self.sales_count_stdd := 0, self.flip_count_actors := 0, self.flip_count_stdd := 0)
								,left outer, hash);

cluster_property_city_stat := join(cluster_with_person_stats, cluster_property_city, left.cluster_id=right.cluster_id, transform({recordof(left), cluster_property_city.p_city_name}, self := left, self := right), left outer, hash);

cluster_people_property_stats := join(cluster_property_city_stat, cluster_people_stats, left.cluster_id=right.cluster_id, transform(recordof(cluster_property_city_stat), self := right, self := left), left outer, hash);

dClusterPropertyStats := table(dedup(sort(cluster_fares_transactions,
														cluster_id, prim_name, prim_range, predir, suffix, sec_range, -recording_date), 
														cluster_id, prim_name, prim_range, predir, suffix, sec_range), 
														{cluster_id, 
																 distinct_property_count := count(group), 
														     high_incidence_flip_count := count(group, flip_count > 1), 
																 high_incidence_in_network_count := count(group, in_network_count > 1), 
																 high_incidence_in_network_flip_count := count(group, in_network_flip_count > 1), 
																 high_incidence_high_profit_count := count(group, high_profit_count > 1), 
																 high_incidence_in_network_high_profit_count := count(group, in_network_high_profit_count > 1),
																 high_incidence_in_network_high_profit_flip_count := count(group, in_network_high_profit_flip_count > 1)}, cluster_id);

rPropertyStatsAppend := record
    recordof(cluster_people_property_stats); 
		dClusterPropertyStats.distinct_property_count;
		dClusterPropertyStats.high_incidence_flip_count;
		dClusterPropertyStats.high_incidence_in_network_count;
		dClusterPropertyStats.high_incidence_in_network_flip_count;
		dClusterPropertyStats.high_incidence_high_profit_count;
		dClusterPropertyStats.high_incidence_in_network_high_profit_count;
		dClusterPropertyStats.high_incidence_in_network_high_profit_flip_count;
end;

dClusterStatsOut := join(cluster_people_property_stats, dClusterPropertyStats, left.cluster_id=right.cluster_id, transform(rPropertyStatsAppend, self := left, self := right), left outer, hash)
                      : persist('~thor_data400::persist::property_ownership_cluster_stats');

export DeedsClustering := dClusterStatsOut;