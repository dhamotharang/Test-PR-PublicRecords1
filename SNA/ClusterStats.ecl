/*2012-12-06T02:10:58Z (Michele Walklin)
removed in-network-risk and replaced with degree between 0 and 1.75
*/
import doxie, riskwise, risk_indicators, ln_propertyv2;

/* caller:
	1=SNA (proper);
	2=mortgage collusion;
	other=invalid -- abandon all hope, ye who enter here
*/
export ClusterStats( dataset(sna.layouts.cluster_stat_input) dids,  unsigned1 caller ) := FUNCTION
	isMortgageCollusion := caller=2;
	
	dPersonClusterStats := sna.Key_Person_Cluster_Attributes;
	dTransactionStats := sna.key_prop_transaction_stats;
	network_degree := 1.75;
	
	layout_temp := record
		recordof(sna.Key_Person_Cluster);
		unsigned history_date;
		string12 ln_fares_id;
	end;
	
	clusters := join( dids, sna.Key_Person_Cluster, 
									left.did != 0 and keyed(left.did=right.cluster_id), 
									transform(layout_temp, 
										self.history_date := left.history_date, 
										self := right,
										self.ln_fares_id := ''), 
									// keep(100), atmost(riskwise.max_atmost) );   /// todo
									 atmost(10000) );
	cluster_dids := dedup(sort(clusters, cluster_id, associated_did), cluster_id, associated_did);

// include fares restriction - depending on if we are allowed to use Fares
	cluster_fares := dedup(sort(
	
	join(cluster_dids, ln_propertyv2.key_Property_did(), 
		left.cluster_id<>0 and keyed(left.associated_did=right.s_did) and
		right.ln_fares_id[2] = 'D' and (right.source_code in ['OP', 'SP']),
		transform( layout_temp,
			self.ln_fares_id := right.ln_fares_id,
			self := left),
		 // atmost(riskwise.max_atmost)), 
		 atmost(10000)), 
		 cluster_id, ln_fares_id), cluster_id, ln_fares_id);
		
		cluster_fares_transactions_prep := join(cluster_fares, dTransactionStats, 
			keyed(left.ln_fares_id=right.ln_fares_id)
			and (integer)right.recording_date[1..6] < left.history_date, 
			transform({left.cluster_id, left.degree, right.flip, right.days, right.business_transaction, left.ln_fares_id, unsigned8 did,
			right.prim_name, right.prim_range, right.predir, right.suffix, right.sec_range, right.v_city_name, right.recording_date, right.source_code, right.buyer_id_combination,
			right.flop,	right.person_transaction,	right.in_network_risk, right.high_profit,	right.in_network_high_profit,
			right.in_network_high_profit_flip, right.mortgage_default, right.mortgage_foreclosure, right.ownership_change, right.ends_in_default_or_foreclosure, right.first_td_loan_type_code,
			right.flip_count, right.in_network_count, right.in_network_flip_count, right.high_profit_count, right.in_network_high_profit_count, right.in_network_high_profit_flip_count,
			right.net_degree
			}, 
				self.cluster_id := left.cluster_id, self.degree := left.degree, self.did := left.associated_did, self.ln_fares_id := left.ln_fares_id, self := right), atmost(10000), left outer, hash);

		cluster_fares_transactions := dedup(sort(cluster_fares_transactions_prep,
				cluster_id, prim_name, prim_range, predir, suffix, sec_range, recording_date, buyer_id_combination), 
				cluster_id, prim_name, prim_range, predir, suffix, sec_range, recording_date, buyer_id_combination);

	
				
  cluster_property_city := dedup(sort(table(sort(cluster_fares_transactions, cluster_id, v_city_name), {cluster_id, v_city_name, prop_city_count := count(group)}, cluster_id, v_city_name), cluster_id, -prop_city_count), cluster_id);

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
			cluster_in_network_count := count(group, ownership_change and (net_degree between 0 and network_degree) and (degree between 0 and network_degree)), 
			cluster_in_network_count_0_degree := count(group, ownership_change and degree = 0 and (net_degree between 0 and network_degree)), 
			cluster_in_network_count_1_degree := count(group, ownership_change and  degree > 0 and degree <= 1 and (net_degree between 0 and network_degree)), 
			cluster_in_network_count_2_degree := count(group, ownership_change and  degree > 1 and degree <= 2 and (net_degree between 0 and network_degree)), 
			cluster_in_network_flip_business_count := count(group, degree between 0 and network_degree and flip and business_transaction and (net_degree between 0 and network_degree)), 
			cluster_in_network_flop := count(group, flop and degree between 0 and network_degree and (net_degree between 0 and network_degree)),
			cluster_in_network_flip_count := count(group, degree between 0 and network_degree and flip and (net_degree between 0 and network_degree)), 
			cluster_in_network_flip_count_0_degree := count(group,  flip and degree = 0 and (net_degree between 0 and network_degree)), 
			cluster_in_network_flip_count_1_degree := count(group,  flip and degree > 0 and degree <= 1 and (net_degree between 0 and network_degree)), 
			cluster_in_network_flip_count_2_degree := count(group,  flip and degree > 1 and degree <= 2 and (net_degree between 0 and network_degree)), 
			cluster_high_profit_count := count(group, high_profit and ownership_change), 
			cluster_high_profit_count_0_degree := count(group, ownership_change and high_profit and degree = 0), 
			cluster_high_profit_count_1_degree := count(group, ownership_change and high_profit and degree > 0 and degree <= 1), 
			cluster_high_profit_count_2_degree := count(group, ownership_change and high_profit and degree > 1 and degree <= 2), 
			cluster_in_network_high_profit := count(group, ownership_change and in_network_high_profit and (degree between 0 and network_degree) and (net_degree between 0 and network_degree)), 
			cluster_in_network_high_profit_0_degree := count(group, ownership_change and in_network_high_profit and degree = 0 and (net_degree between 0 and network_degree)), 
			cluster_in_network_high_profit_1_degree := count(group, ownership_change and in_network_high_profit and  degree > 0 and degree <= 1 and (net_degree between 0 and network_degree)), 
			cluster_in_network_high_profit_2_degree := count(group, ownership_change and in_network_high_profit and degree > 1 and degree <= 2 and (net_degree between 0 and network_degree)),
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
								self := left, self := right, 
								self.prop_people_count := 0, 
								self.prop_network_cohesivity := 0, self.prop_1st_degrees := 0, 
								self.prop_2nd_degrees := 0, self.sales_count_stdd := 0, 
								self.flip_count_actors := 0, self.flip_count_stdd := 0)
								,left outer);

cluster_property_city_stat := join(cluster_with_person_stats, cluster_property_city, left.cluster_id=right.cluster_id, transform({recordof(left), cluster_property_city.v_city_name}, self := left, self := right), left outer);

cluster_people_property_stats := join(cluster_property_city_stat, cluster_people_stats, left.cluster_id=right.cluster_id, transform(recordof(cluster_property_city_stat), self := right, self := left), left outer);

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



dClusterStatsOut := join(cluster_people_property_stats, dClusterPropertyStats, left.cluster_id=right.cluster_id, transform(rPropertyStatsAppend, self := left, self := right), left outer);

	return dClusterStatsOut;
END;