Import Riskwise, Prof_LicenseV2, Risk_Indicators, LN_PropertyV2;

export Cluster_stats_history(dataset(sna.layouts.cluster_stat_input) dids,  unsigned1 caller )  := Function

    
Layout_MC_Attributes_Person := record		
		unsigned seq;
    unsigned did;
		string3 PropertyCount;
    string3 FlipCount;
    string3 HighProfCount;
    string3 DefaultCount;
    string3 ForeclosureCount;
    string3 DefaultOrForeclosureCount;
    string3 NetworkCount;
    string3 NetworkFlipCount;
    string3 NetworkHighProfitCount;
    string2 HighRiskFlipNetwork;
    string2 HighRiskForeclosureNetwork;
		string3 RiskIndex;

    string3 ClusterTransferCount;
    string3 ClusterFlipCount;
    string3 ClusterFlopCount;
    string3 ClusterBusFlipCount;
    string3 ClusterHighProfCount;
    string3 ClusterDefaultCount;
    string3 ClusterForeclosureCount;
    string3 ClusterDefOrForeclosureCount;
    string3 ClusterNetworkTransferCount;
    string3 ClusterNetworkFlipCount;
    string3 ClusterNetworkFlopCount;
    string3 ClusterNetworkBusFlipCount;
    string3 ClusterNetworkHighProfCount;
    string3 ClusterNetworkHighProfFlipCount;
		string3 ClusterRiskIndex;
		string3 ProfRiskIndex;
		string2 LicenseStatus;
	  string3	TransactionsCount;
	END;
	
profLic_key := Prof_LicenseV2.Key_Proflic_Did(false);

did_plus := RECORD
    unsigned did;
		string45 status;
		string8  expiration_date;
		string8  date_last_seen;
		integer  seq;
		integer  history_date;
		string30 recordlabel;
		integer  prop_count;
END;

		
did_plus add_proflic(dids le, profLic_key ri) := Transform
    self.did := le.did;
		self.seq := le.seq;
		self.history_date := le.history_date;
		self.status := ri.status;
		self.expiration_date := ri.expiration_date;
		self.date_last_seen := ri.date_last_seen;
		self.recordlabel  := le.recordlabel;
		self.prop_count := 0;
END;

did_proflic := join(dids, profLic_key, 
										keyed(right.did=left.did) and
										(integer)right.date_last_seen[1..6] < left.history_date,
										add_proflic(left,right) ,  
										left outer, atmost(riskwise.max_atmost) );
										
did_proflic_sd := dedup(sort(did_proflic, did,seq, -date_last_seen),did, seq);




owner_recs := join(did_proflic_sd, ln_propertyv2.key_Property_did(),
							(keyed(right.s_did=left.did) and 
							 right.ln_fares_id[2] = 'D' and 
							 right.source_code = 'OP'),
							 transform({recordof(right), left.history_date}, self.history_date:=left.history_date, self:=right),
							 atmost(riskwise.max_atmost));
							 
							
							
seller_recs := join(did_proflic_sd, ln_propertyv2.key_Property_did(),
							(keyed(right.s_did=left.did) and 
							 right.ln_fares_id[2] = 'D' and 
							 right.source_code = 'SP'),
							 transform({recordof(right), left.history_date}, self.history_date:=left.history_date, self:=right),
							 atmost(riskwise.max_atmost));
							 

owner_deeds := join(owner_recs, LN_PropertyV2.key_search_fid(),
              keyed(left.ln_fares_id=right.ln_fares_id) and
							right.dt_first_seen < left.history_date and
							right.source_code_1 = 'O',
							transform(recordof(left), self := left),atmost(riskwise.max_atmost));
							
seller_deeds := join(seller_recs, LN_PropertyV2.key_search_fid(),
              keyed(left.ln_fares_id=right.ln_fares_id) and
							right.dt_first_seen < left.history_date and
							right.source_code_1 = 'S',
							transform(recordof(left), self := left),atmost(riskwise.max_atmost) );
							


owner_recs_sd := dedup(sort(owner_deeds, prim_range,prim_name,suffix,postdir,st,p_city_name,zip),prim_range,prim_name,suffix,postdir,st,p_city_name,zip);
seller_recs_sd := dedup(sort(seller_deeds, prim_range,prim_name,suffix,postdir,st,p_city_name,zip),prim_range,prim_name,suffix,postdir,st,p_city_name,zip);

owned_prop := join(owner_recs_sd, seller_recs_sd, 
										left.prim_range = right.prim_range and
										left.prim_name = right.prim_name and
										left.suffix = right.suffix and
										left.postdir = right.postdir and
										left.st = right.st and
										left.p_city_name = right.p_city_name and
										left.zip = right.zip,
										transform(recordof(left), self := left),
										left only);
										
owned_prop_t := table(owned_prop, {did := s_did, prop_total := count(group)}, s_did);

did_plus add_prop_count(did_proflic_sd le, owned_prop_t ri) := TRANSFORM
   self.prop_count := if(trim((string)ri.did)='', 0, (integer)ri.prop_total);
	 self            := le;
end;

prof_prop_join := join(did_proflic_sd, owned_prop_t,
                 right.did=left.did,
								 add_prop_count(left,right), 
								 left outer,atmost(riskwise.max_atmost) );
		
cluster_stats_out :=  sna.ClusterStats(dids, 2);

Layout_MC_Attributes_Person getPersonAttributes(prof_prop_join le, cluster_stats_out ri) := TRANSFORM

    cap( unsigned val, unsigned maxVal ) := if( ri.cluster_id=0, '-1', (string)min(maxVal,val) );
    self.seq                            := le.seq;
    self.did                            := le.did;
		prof_lic_status_cd                  := map( (stringlib.stringfind(le.status, 'DELINQUENT', 1) != 0)  => 'D',
																								// (stringlib.stringfind(le.status, 'INACTIVE', 1) != 0)     => 'I', 
																								// (stringlib.stringfind(le.status, 'ACTIVE', 1) != 0)       => 'A' ,
																								'-1');
	  label_set                           := ['prof1','prof2','prof3'];
    prof_lic_status                     := map(le.expiration_date < Risk_Indicators.iid_constants.myGetDate(le.history_date) and prof_lic_status_cd = 'D' => 'D',
		                                           le.expiration_date < Risk_Indicators.iid_constants.myGetDate(le.history_date)                              => 'I',
																							 le.expiration_date >= Risk_Indicators.iid_constants.myGetDate(le.history_date)                             => 'A',
																							 '-1');
    // PERSON ATTRIBUTES
		self.TransactionsCount              := cap(if(le.recordlabel in label_set, ri.cluster_in_network_count_0_degree, 0),999);
		self.LicenseStatus                  := if(le.recordlabel in label_set, prof_lic_status, '0');
    self.PropertyCount                  := cap(le.prop_count, 999); // Number of properties currently owned person the buyer
    self.FlipCount                      := cap(ri.cluster_flip_0_degree, 999); // Number of times the buyer has sold a property for a profit within 6 months of person property purchase
    self.HighProfCount                  := cap(ri.cluster_high_profit_count_0_degree, 999); // Number of times the buyer has sold a property for person high profit
    self.DefaultCount                   := cap(ri.cluster_default_count_0_degree, 999); // Number of transfers involving the buyer that person in default
    self.ForeclosureCount               := cap(ri.cluster_foreclosure_count_0_degree, 999); // Number of transfers involving the buyer that person in foreclosure
    self.DefaultOrForeclosureCount      := cap(ri.cluster_foreclosure_default_count_0_degree, 999); // Number of transfers involving the buyer that resulted in person or foreclosure
    self.NetworkCount                   := cap(ri.cluster_in_network_count_0_degree, 999); // Number of times the buyer has sold a property personn-network
    self.NetworkFlipCount               := cap(ri.cluster_in_network_flip_count_0_degree, 999); // Number of times the buyer has flipped a property personn-network
    self.NetworkHighProfitCount         := cap(ri.cluster_in_network_high_profit_0_degree, 999); // Number of times the buyer has sold a property in-network for person high profit
    HighRiskFlipNetwork                 := map(ri.cluster_id=0                                           => '-1',
																							(ri.prop_people_count < 10000 
																								and ri.prop_network_cohesivity < 1.8 and
																								ri.cluster_flip_count > 5 and
																								(ri.cluster_flip_count/ri.distinct_property_count > 0.10)) => '1', 
																								'0');//ri.; // Indicates the seller is a member of a high person flipping network
    self.HighRiskFlipNetwork            := HighRiskFlipNetwork;    
		HighRiskForeclosureNetwork          := map(ri.cluster_id=0                                           => '-1',
		                                           (ri.prop_people_count < 10000 and 
																							 ri.prop_network_cohesivity < 1.8 and
																							 ri.cluster_flip_count > 5 and
																							 (ri.cluster_foreclosure_count/ri.distinct_property_count > 0.10)) => '1', 
																							  '0');// Indicates the seller is a member of a high person foreclosure network
    self.HighRiskForeclosureNetwork       := HighRiskForeclosureNetwork;                                   
																					 

    // CLUSTER ATTRIBUTES
    self.ClusterTransferCount             := cap(ri.cluster_sales_count, 999 ); // Number of property transfers in the person's cluster
    self.ClusterFlipCount                 := cap(ri.cluster_flip_count, 999 ); // Number of property flips in the person's cluster
    self.ClusterFlopCount                 := cap(ri.cluster_flop_count, 999 ); // Number of property flops in the person's cluster
    self.ClusterBusFlipCount              := cap(ri.cluster_flip_business_count, 999 ); // Number of business flips in the person's cluster
    self.ClusterHighProfCount             := cap(ri.cluster_high_profit_count, 999 ); // Number of high profit property transfers in the person's cluster
    self.ClusterDefaultCount              := cap(ri.cluster_default_count, 999 ); // Number of property transfers resulting in default in the person's cluster
    self.ClusterForeclosureCount          := cap(ri.cluster_foreclosure_count, 999 ); // Number of property transfers resulting in foreclosure in the person's cluster
    self.ClusterDefOrForeclosureCount     := cap(ri.cluster_foreclosure_default_count, 999 ); // Number of property transfers resulting in default or foreclosure in the person's cluster
    self.ClusterNetworkTransferCount      := cap(ri.cluster_in_network_count, 999 ); // Number of in-network transfers in the person's cluster
    self.ClusterNetworkFlipCount          := cap(ri.cluster_in_network_flip_count, 999 ); // Number of in-network property flips in the person's cluster
    self.ClusterNetworkFlopCount          := cap(ri.cluster_in_network_flop, 999 ); // Number of in-network property flops in the person's cluster
    self.ClusterNetworkBusFlipCount       := cap(ri.cluster_in_network_flip_business_count, 999 ); // Number of in-network business flips in the person's cluster
    self.ClusterNetworkHighProfCount      := cap(ri.cluster_in_network_high_profit, 999 ); // Number of in-network high profit property transfers in the person's cluster
    self.ClusterNetworkHighProfFlipCount  := cap(ri.cluster_in_network_high_profit_flip_count, 999 ); // Number of in-network high profit property flips in the person's cluster
		self.RiskIndex                        := map(ri.cluster_id=0                                       => '-1',
			                                           ri.cluster_foreclosure_default_count_0_degree > 1     => '9',
																								 HighRiskForeclosureNetwork  = '1'            		     => '8',
		                                             HighRiskFlipNetwork   = '1'                           => '7',
																								 ri.cluster_foreclosure_default_count_0_degree > 0     => '6',
																								 ri.cluster_in_network_high_profit_0_degree   > 1 
																								 and ri.cluster_in_network_flip_count_0_degree > 1    => '5',
																								 ri.cluster_in_network_flip_count_0_degree > 1         => '4',
																								 ri.cluster_flip_0_degree > 1                          => '3',
																								 ri.cluster_high_profit_count_0_degree > 1             => '2',
																								 ri.cluster_id<>0                                      => '1',
																								 '0');
		self.ClusterRiskIndex                 := map(ri.cluster_id=0                                                    => '-1',
		                                             ri.cluster_foreclosure_default_count > 4                           => '9',
		                                             ri.cluster_foreclosure_default_count > 1                           => '8',
																								 (ri.cluster_in_network_flip_count + ri.cluster_in_network_flop)> 4 => '7',
																								 ri.cluster_in_network_high_profit_flip_count > 1                   => '6',
																								 ri.cluster_in_network_high_profit > 1                              => '5',
																								 ri.cluster_flop_count > 1                                          => '4',
																								 ri.cluster_flip_count > 1                                          => '3',
																								 ri.cluster_flip_business_count > 1                                 => '2',
																								 ri.cluster_id<>0                                                   => '1',
																								 '0');
		
	  self.ProfRiskIndex                    := map(ri.cluster_foreclosure_default_count_0_degree > 1     => '9',
		                                             HighRiskForeclosureNetwork = '1'                      => '8',
																								 HighRiskFlipNetwork = '1'                             => '7',
																								 ri.cluster_foreclosure_default_count_0_degree > 0     => '6',
																								 prof_lic_status <> 'A'                                => '5',
																								 ri.cluster_in_network_flip_count_0_degree > 1
																								 and ri.cluster_high_profit_count_0_degree > 1         => '4',
																								 ri.cluster_in_network_flip_count_0_degree > 1         => '3',
																								 ri.cluster_high_profit_count_0_degree >= 1            => '2',
																								 ri.cluster_id<>0                                      => '1',
																								 ri.cluster_id=0                                       => '0',
																								 '-1');
																								 																								 																							                                             
  END;
																								 																								 																							                                             

	
		cluster_attrib  :=	join(prof_prop_join, cluster_stats_out, 
												left.did = right.cluster_id,
												getPersonAttributes(left,right),left outer, atmost(riskwise.max_atmost),keep(1));
					
		
		return cluster_attrib;
		
END;