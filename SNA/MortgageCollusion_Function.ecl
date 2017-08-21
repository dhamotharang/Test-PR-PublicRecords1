import LN_PropertyV2, RiskWise,Risk_Indicators, doxie, ut, gateway;


export MortgageCollusion_Function(dataset( sna.layouts.mortgage_collusion_input ) indata, string50 DataRestrictionMask, dataset(Gateway.Layouts.Config) gateways,
				 unsigned1 dppa, unsigned1 glb, unsigned1 AppendBest, boolean	isFCRA, integer	bsVersion ) := function


batch_in_seq := project(indata, transform(sna.layouts.mortgage_collusion_input, self.transaction_seq := counter, self := left));
	
	invalid_inputs := batch_in_seq(streetaddress='' or city='' or st='' or zip='');
	valid_inputs := batch_in_seq(streetaddress<>'' and city<>'' and st<>'' and zip<>'');
	
	layout_normed := record
		unsigned1 	transaction_seq;  // number from 1-100
	  unsigned1  	input_seq; // number from 1-10, this will be used for normalizing the input record into up to 10 records
		string30 		recordlabel;
		Risk_Indicators.Layout_Input;
	end;
	
	// this transform copied from RiskView_Batch_Service with minor cleanup and code to allow for retrieval of input seq and acctno
	layout_normed iidPrep( valid_inputs le, integer c ) := TRANSFORM
		self.input_seq := C;
		self.seq := (le.transaction_seq * 10) + C;
		self.transaction_seq := le.transaction_seq;
		self.recordlabel := choose(c,	'propery_address', 'buyer1', 'buyer2', 'buyer3', 'seller1', 'seller2', 'seller3', 'prof1', 'prof2', 'prof3');
		
		fname := choose( c, '', le.buyer1_First_Name, le.buyer2_First_Name, le.buyer3_First_Name, le.seller1_First_Name, le.seller2_First_Name, le.seller3_First_Name, le.professional1_First_Name, le.professional2_First_Name, le.professional3_First_Name );
		lname := choose( c, '', le.buyer1_Last_Name, le.buyer2_Last_Name, le.buyer3_Last_Name, le.seller1_Last_Name, le.seller2_Last_Name, le.seller3_Last_Name, le.professional1_Last_Name, le.professional2_Last_Name, le.professional3_Last_Name );

		ssn := choose( c, '', le.buyer1_ssn, le.buyer2_ssn, le.buyer3_ssn, le.seller1_ssn, le.seller2_ssn, le.seller3_ssn, le.professional1_ssn, le.professional2_ssn, le.professional3_ssn );
		dob := choose( c, '', le.buyer1_dateofbirth, le.buyer2_dateofbirth, le.buyer3_dateofbirth, le.seller1_dateofbirth, le.seller2_dateofbirth, le.seller3_dateofbirth, le.professional1_dateofbirth, le.professional2_dateofbirth, le.professional3_dateofbirth );

		street_addr := choose( c, le.streetaddress, le.buyer1_StreetAddress, le.buyer2_StreetAddress, le.buyer3_StreetAddress, le.seller1_StreetAddress, le.seller2_StreetAddress, le.seller3_StreetAddress, le.professional1_StreetAddress, le.professional2_StreetAddress, le.professional3_StreetAddress );
		city        := choose( c, le.city, le.buyer1_City, le.buyer2_City, le.buyer3_City, le.seller1_City, le.seller2_City, le.seller3_City, le.professional1_City, le.professional2_City, le.professional3_City );
		state       := choose( c, le.st, le.buyer1_St, le.buyer2_St, le.buyer3_St, le.seller1_St, le.seller2_St, le.seller3_St, le.professional1_St, le.professional2_St, le.professional3_St );
		zip         := choose( c, le.zip, le.buyer1_Zip, le.buyer2_Zip, le.buyer3_Zip, le.seller1_Zip, le.seller2_Zip, le.seller3_Zip, le.professional1_Zip, le.professional2_Zip, le.professional3_Zip );

		historydate := if(le.HistoryDateYYYYMM=0, 999999, le.HistoryDateYYYYMM);

		self.historydate := historydate;
		self.ssn := ssn;
		self.dob := dob;
		self.fname := fname;
		self.lname := lname;

		street_address := risk_indicators.MOD_AddressClean.street_address(street_addr);
		clean_a2 := risk_indicators.MOD_AddressClean.clean_addr( street_address, city, state, zip );											

		SELF.in_streetAddress := street_address;
		SELF.in_city          := city;
		SELF.in_state         := state;
		SELF.in_zipCode       := zip;
			
		self.prim_range    := clean_a2[1..10];
		self.predir        := clean_a2[11..12];
		self.prim_name     := clean_a2[13..40];
		self.addr_suffix   := clean_a2[41..44];
		self.postdir       := clean_a2[45..46];
		self.unit_desig    := clean_a2[47..56];
		self.sec_range     := clean_a2[57..65];
		self.p_city_name   := clean_a2[90..114];
		self.st            := clean_a2[115..116];
		self.z5            := clean_a2[117..121];
		self.zip4          := clean_a2[122..125];
		self.lat           := clean_a2[146..155];
		self.long          := clean_a2[156..166];
		self.addr_type     := clean_a2[139];
		self.addr_status   := clean_a2[179..182];
		self.county        := clean_a2[143..145];
		self.geo_blk       := clean_a2[171..177];

		self := [];
	END;
	normed_input := normalize(valid_inputs, 10, iidPrep(LEFT,COUNTER));

	
	property_addresses_only := normed_input(input_seq=1);
	
	individuals := normed_input(input_seq>1 and fname<>'' and lname<>'' and in_streetAddress<>'' and in_zipCode<>'');
			
	iid_prepped_individuals := project( individuals, transform(Risk_Indicators.Layout_Input, self := left ) );

	
	individuals_with_dids := Risk_Indicators.iid_getDID_prepOutput(iid_prepped_individuals, dppa, glb, isFCRA, BSversion, DataRestrictionMask, appendbest, gateways );
	
	
	individuals_with_dids_deduped := dedup(sort(ungroup(individuals_with_dids), seq, if(did=0,281474976710655, did)), seq);
	
	seq_layout := Record
	  unsigned1	rec_seq;
	END;
	
	seq_layout get_invalid_recs(individuals_with_dids_deduped le)  := TRANSFORM
		self.rec_seq := le.seq;
	END;
	
	seq_layout get_property_recs(property_addresses_only le)  := TRANSFORM
		self.rec_seq := le.seq;
	END;
	
	property_seq   := project(property_addresses_only, get_property_recs(left));
	
	valid_seq := project(individuals_with_dids_deduped(did<>0), get_invalid_recs(left));
	
	valid_seq_recs := property_seq + valid_seq;
	
	
property_layout := record
		string12 ln_fares_id;
		recordof(property_addresses_only);
		string8 archive_dt;  // hang on to for deduping and history date filtering
		string2 PropDefaultCurrent; 				
    string2 PropDefaultEver; 						
    string2 PropDefaultEverSuspActivity; 
    string2 PropForeclosureCurrent; 		
    string2 PropForeclosureEver;					
    string2 PropForeclosureEverSuspActivity;
    string4 PropPriceProfIndex; 	 					
    string2 PropFlip ; 											
    string2 PropFlip_30; 										
    string2 PropFlip_60 ; 									
    string2 PropFlip_90; 										
    string2 PropFlip_120;									
    string2 PropFlop; 										
    string2 PropFlop_30;									
    string2 PropFlop_60;									
    string2 PropFlop_90;									 
    string2 PropFlop_120;
		real4   Net_degree;
    string2 PropNetwork ; 							
    string2 PropHighProf ;					 
    string4 PropFlipProfIndex;					
    string2 PropNetwHighProf;						
    string4 PropNetwProfIndex; 						
    string2 PropNetwFlip ; 								
    string4 PropNetwFlipProfIndex;				 
    string5 PropDaysBetweenSale;					
    string5 PropEverDeedTransferCt; 				
    string3 PropEverFlipCt; 								
    string3 PropEverFlopCt ; 							
    string3 PropEverHighRiskCt;					
    string3 PropEverBusCt; 							
    string3 PropEverHighProfCt; 				
    string3 PropEverFlipHighProfCt; 			
    string3 PropEverNetwCt ; 							
    string3 PropEverNetwFlipCt; 					
    string3 PropEverNetwBusFlipCt; 					
    string3 PropEverNetwHighProfCt; 					
    string3 PropEverNetwFlipHighProfCt;	
		string2 PropertyStatusRiskIndex;
		string2 PropDeedRiskIndex;
		string2 PropertyHistoryRiskIndex;

end;

 property_layout getFares(property_addresses_only le, recordof(LN_PropertyV2.key_addr_fid()) ri) := TRANSFORM
    SELF.ln_fares_id := ri.ln_fares_id;
    SELF := le;
		self := [];
	END;

 property_addresses_with_fid := JOIN(property_addresses_only, LN_PropertyV2.key_addr_fid(),
						LEFT.prim_name<>'' AND left.z5 <>'' and
						keyed(LEFT.prim_name=RIGHT.prim_name) AND
						keyed(LEFT.prim_range=RIGHT.prim_range) AND
						keyed(LEFT.z5=RIGHT.zip) AND
						keyed(LEFT.predir=RIGHT.predir) AND
						keyed(LEFT.postdir=RIGHT.postdir) AND
						keyed(LEFT.addr_suffix=RIGHT.suffix) AND
						keyed(LEFT.sec_range=RIGHT.sec_range) and
						keyed(right.source_code_2 = 'P') ,
					   getFares(LEFT,RIGHT), KEEP(100), LEFT OUTER,
					   ATMOST(RiskWise.max_atmost));
						 
property_plus_layout := record
  recordof(property_layout);
		
end;
	
				

deduped_property_addresses_with_fids := dedup(sort(property_addresses_with_fid, seq, if(trim(ln_fares_id)='', '0',ln_fares_id)), seq, if(trim(ln_fares_id)='', '0',ln_fares_id));
 
  property_layout getPropertyAttributes( deduped_property_addresses_with_fids le, SNA.key_prop_transaction_stats ri ) := TRANSFORM
	  cap( integer val, unsigned maxVal ) :=  trim( if( trim(ri.ln_fares_id)='', '-1', (string)min(maxVal,val) ) ) ;
	  capr( real8 val, real8 maxVal ) :=  trim( if( trim(ri.ln_fares_id)='', '-1', (string)(decimal3_1)min(maxVal,val) ) );
		nohit := trim(ri.ln_fares_id)='';
    bool( boolean val ) := map(nohit => '-1', 
															 val => '1', 
															 '0' );
		network_degree_value                   := 1.75;
		    
    self.PropDefaultCurrent                := bool(ri.mortgage_default); // Indicates if the property mortgage is currently in default
    self.PropDefaultEver                   := bool(ri.has_mortgage_default); // Indicates if the property mortgage has ever been in default
    self.PropDefaultEverSuspActivity       := bool(ri.has_mortgage_default_preceeding_suspicious); // Indicates if the property mortgage has ever been in default with suspicious characteristics
    self.PropForeclosureCurrent            := bool(ri.mortgage_foreclosure); // Indicates if the property mortgage is currently in foreclosure
    self.PropForeclosureEver               := bool(ri.has_mortgage_foreclosure); // Indicates if the property mortgage has ever been in foreclosure
    self.PropForeclosureEverSuspActivity   := bool(ri.has_mortgage_foreclosure_preceeding_suspicious); // Indicates if the property mortgage has ever been in foreclosure with suspicious characteristics
    self.PropPriceProfIndex                := capr(if(nohit, -1,If(ri.price_change_percent<0,0.0,(ri.price_change_percent/100))), 99.9); // Percentage of profit derived from the most recent property transaction
    self.PropFlip                          := if(nohit, '-1',(string)bool(ri.flip)); // Indicates if the property was sold for a profit within 6 months of the property purchase (flip)
    self.PropFlip_30                       := bool(ri.price_change_percent >= 10 and ri.flip and ri.days > 0 and ri.days < 31); // Indicates the property was sold for 10% or more in 30 days
    self.PropFlip_60                       := bool(ri.price_change_percent >= 20 and ri.flip and ri.days > 31 and ri.days < 61); // Indicates the property was sold for 20% or more in 60 days
    self.PropFlip_90                       := bool(ri.price_change_percent >= 30 and ri.flip and ri.days > 61 and ri.days < 91); // Indicates the property was sold for 30% or more in 90 days
    self.PropFlip_120                      := bool(ri.price_change_percent >= 40 and ri.flip and ri.days > 91 and ri.days < 121); // Indicates the property was sold for 40% or more in 120 days
    self.PropFlop                          := bool(ri.flop); // Indicates the property was previously sold for less than prior sale amount, then was sold for a profit (flop)
    self.PropFlop_30                       := bool(ri.price_change_percent >= 10 and ri.flop and ri.days > 0 and ri.days < 31);  // Indicates the property was sold for 10% or more in 30 days, after a drop in price greater than 10% (flop)
    self.PropFlop_60                       := bool(ri.price_change_percent >= 20 and ri.flop and ri.days > 31 and ri.days < 61);  // Indicates the property was sold for 20% or more in 60 days, after a drop in price greater than 10% (flop)
    self.PropFlop_90                       := bool(ri.price_change_percent >= 30 and ri.flop and ri.days > 61 and ri.days < 91);  // Indicates the property was sold for 30% or more in 90 days after a drop in price greater than 10% (flop)
    self.PropFlop_120                      := bool(ri.price_change_percent >= 40 and ri.flop and ri.days > 91 and ri.days < 121);  // Indicates the property was sold for 40% or more in 120 days after a drop in price greater than 10% (flop)
 		self.Net_degree											   := ri.net_degree;
		
		self.PropHighProf                      := bool(ri.high_profit); // Indicates a transaction where the current buyer paid 20% or greater than what the seller paid.
    self.PropFlipProfIndex                 := capr(if(nohit, -1, map(ri.flip => if(ri.price_change_percent<0,0.0,(ri.price_change_percent/100)),0.0)),99.9); // Indicates the percentage of profit derived from flipping a property
//      use  1.75 net degree
    self.PropNetwork                       := bool(ri.net_degree between 0 and network_degree_value); // Indicates a transaction between the participants, (such as a buyer and seller) where the parties are 1.75 degrees or less away.Â  This implies that they have multiple mutual associates or they are direct associates of each other.
    self.PropNetwHighProf                  := bool(ri.in_network_high_profit); // Indicates the property transfer occurred in-network and had high risk characteristics
    self.PropNetwProfIndex                 := capr(if(nohit, -1, map(ri.in_network_high_profit_flip  => if(ri.price_change_percent<0,0.0,(ri.price_change_percent/100)), 0.0)),99.9); // Percentage of profit derived from the in-network transaction
    self.PropNetwFlip                      := bool(ri.in_network_flip); // Indicates if the property was sold in-network for a profit within 6 months of the property purchase
		self.PropNetwFlipProfIndex             := capr(if(nohit, -1, map(ri.days > -1 and ri.days < 184 and  ri.net_degree <= network_degree_value and ri.net_degree >= 0 => if(ri.price_change_percent<0, 0.0,(ri.price_change_percent/100)), 0.0)),99.9); // Percentage of profit derived from the in-network transaction that occurred within 6 months of a previous transaction on the property
    self.PropEverNetwCt                    := cap(if(nohit, -1,ri.in_network_count),999); // Number of times the property was transferred in-network
    self.PropEverNetwFlipCt                := cap(if(nohit, -1,ri.in_network_flip_count),999); // Number of times the property was flipped in-network
    self.PropEverNetwBusFlipCt             := cap(if(nohit, -1,ri.in_network_flip_business_count),999); // Number of in-network business transfers involving the property
    self.PropEverNetwHighProfCt            := cap(if(nohit, -1,ri.in_network_high_profit_count),999); // Number of times the property was transferred in-network with high profit
    self.PropEverNetwFlipHighProfCt        := cap(if(nohit, -1,ri.in_network_high_profit_flip_count),999); // Number of times the property was flipped in-network with high profit 
// use 1.75    net degree
    self.PropDaysBetweenSale               := cap(if(nohit, -1,if(ri.days<0,0,ri.days)),99999); // Number of days between the last two deed transfers
// history    out to 2.0 degrees
		self.PropEverDeedTransferCt            := cap(if(nohit, -1,if(ri.ownership_changes<0,0,ri.ownership_changes)),99999); // Number of times the property was ever sold or changed owners
    self.PropEverFlipCt                    := cap(if(nohit, -1,ri.flip_count),999); // Number of times the property was sold for a profit within 6 months of the property purchase
    self.PropEverFlopCt                    := cap(if(nohit, -1,ri.flop_count),999); // Number of times the property was previously sold for less than prior sale amount, then was sold for a profit
    self.PropEverHighRiskCt                := cap(if(nohit, -1,ri.suspicious_deed_count),999); // Number of times the property was transferred with high risk transfer characteristics
    self.PropEverBusCt                     := cap(if(nohit, -1,ri.business_trans_count),999); // Number of business transfers involving the property
    self.PropEverHighProfCt                := cap(if(nohit, -1,ri.high_profit_count),999); // Number of times the property was transferred with high profit
		self.PropEverFlipHighProfCt            := cap(if(nohit, -1,ri.high_profit_flip_count),999); // Number of times the property was flipped with high profit
   
// history     
		self.archive_dt                     	 := (string)ri.recording_date;
		self.PropertyStatusRiskIndex           := map(nohit                                                         => '-1',
																									ri.mortgage_foreclosure 																			=> '9',
																									ri.mortgage_default     																			=> '8',
																									(ri.has_mortgage_foreclosure_preceeding_suspicious 
																									and ri.has_mortgage_default_preceeding_suspicious)            => '7',
																									ri.has_mortgage_foreclosure_preceeding_suspicious  						=> '6',
																									ri.has_mortgage_default_preceeding_suspicious      						=> '5',
																									ri.has_mortgage_foreclosure and ri.has_mortgage_default 			=> '4',
																									ri.has_mortgage_foreclosure                            				=> '3',
																									ri.has_mortgage_default                            						=> '2',
																									not(ri.has_mortgage_default and ri.has_mortgage_foreclosure)  => '1',
																									'0');
		self.PropDeedRiskIndex  								:= map(trim(ri.ln_fares_id)=''                                     => '-1',
																									((ri.days <= 60) and ri.high_profit and 
																										self.PropNetwork = '1' and
		                                               (ri.flip or ri.flop ))																				=> '9',
																				           ((ri.days <= 120) and ri.high_profit and 
																									  self.PropNetwork = '1' and
		                                               (ri.flip or ri.flop ) )                                      => '8',
																							     (ri.days <= 60 and ri.high_profit and
		                                               (ri.flip or ri.flop ) )                                      => '7',
																								   (ri.days <= 120 and ri.high_profit and
		                                               (ri.flip or ri.flop ))                                       => '6',
																									 ri.high_profit and self.PropNetwork = '1'         						=> '5',
																								   ri.high_profit and ri.net_degree <= network_degree_value     => '4',
																								   self.PropNetwork = '1'                                       => '3',
																									 trim(ri.ln_fares_id)<>''	                                    => '2',
																									 trim(ri.ln_fares_id)=''																		  => '1',
																								   '0');
		self.PropertyHistoryRiskIndex            := map(nohit                                                      	         => '-1', 
																										(integer)self.PropEverNetwFlipHighProfCt>1      										 => '9',
																								    ((integer)self.PropEverFlipCt + (integer)self.PropEverFlopCt) > 5    =>  '8',
																								     (integer)self.PropEverNetwBusFlipCt > 1                             => '7',
																								     (integer)self.PropEverFlipHighProfCt > 1                            => '6',
																										 (integer)self.PropEverNetwFlipCt  > 1                               => '5',
																										 (integer)self.PropEverNetwHighProfCt > 1                            => '4',
																										 (integer)self.PropEverHighRiskCt > 1                                => '3',
																										 (integer)self.PropEverNetwCt > 1                                    => '2',
																										 trim(ri.ln_fares_id)<>''                                            => '1',
																										 '0');
																														
		self 																	 := le;
  END;
 
	
withPropertyStats := join( deduped_property_addresses_with_fids, SNA.key_prop_transaction_stats, 
											keyed(left.ln_fares_id=right.ln_fares_id)
											and right.dt_first_seen[1..6] < (string)left.historydate,
											getPropertyAttributes(left,right), left outer, atmost(riskwise.max_atmost) );
		

sorted_property_stats  := sort(withPropertyStats, seq, -archive_dt, ln_fares_id);
//removed ln-fares_id to return the most recent record
deduped_property_stats := dedup(sorted_property_stats, seq);  


cluster_input_dids := join(individuals_with_dids_deduped, normed_input,
                       left.seq = right.seq,
											transform(sna.layouts.cluster_stat_input, self.did := left.did, 
											self.history_date := left.historydate, self.seq := left.seq, self.recordlabel := right.recordlabel));

cluster_realtime_mode := cluster_input_dids[1].history_date=Risk_Indicators.iid_constants.default_history_date;

cluster_attrib :=  if(cluster_realtime_mode, SNA.Cluster_stats_current(cluster_input_dids, 2), SNA.Cluster_stats_history(cluster_input_dids, 2));


layout_temp := record
	layout_normed input;
	sna.layouts.mortgage_collusion_output;
end;

layout_temp_default := record
	layout_normed input;
	sna.layouts.mortgage_collusion_output;
end;

categorized_person_attributes := join(normed_input, cluster_attrib, left.seq=right.seq,
	transform(layout_temp,
	  self.input := left;
		self.Buyer1_cluster := if(left.recordlabel='buyer1', right);
		self.Buyer2_cluster := if(left.recordlabel='buyer2', right);
		self.Buyer3_cluster := if(left.recordlabel='buyer3', right);
		self.Seller1_cluster := if(left.recordlabel='seller1', right);
		self.Seller2_cluster := if(left.recordlabel='seller2', right);
		self.Seller3_cluster := if(left.recordlabel='seller3', right);
		self.Prof1_cluster := if(left.recordlabel='prof1', right);
		self.Prof2_cluster := if(left.recordlabel='prof2', right);
		self.Prof3_cluster := if(left.recordlabel='prof3', right);
		self := [];  // property attributes are later
		), left outer);


full_attributes := join(categorized_person_attributes, 	deduped_property_stats, 
	left.input.transaction_seq=right.transaction_seq and
	left.input.seq = right.seq,
	transform(layout_temp,
		self.acctno := '';
		self.input := left.input;
		self.Buyer1_cluster :=  left.Buyer1_cluster ;               
		self.Buyer2_cluster := left.Buyer2_cluster;
		self.Buyer3_cluster := left.Buyer3_cluster ;
		self.Seller1_cluster := left.Seller1_cluster;
		self.Seller2_cluster := left.Seller2_cluster;
		self.Seller3_cluster := left.Seller3_cluster;
		self.Prof1_cluster := left.Prof1_cluster;
		self.Prof2_cluster := left.Prof2_cluster;
		self.Prof3_cluster := left.Prof3_cluster;
		self := right), left outer);


layout_temp default_values(full_attributes le) := Transform
			 self.acctno 														:= le.acctno, 
			 SELF.propdefaultcurrent 								:= '-1';
			 SELF.propdefaultever 									:= '-1';
			 SELF.propdefaulteversuspactivity 			:= '-1';
			 SELF.propforeclosurecurrent 						:= '-1';
			 SELF.propforeclosureever 							:= '-1';
			 SELF.propforeclosureeversuspactivity 	:= '-1';
			 SELF.proppriceprofindex 								:= '-1';
			 SELF.propflip 													:= '-1';
			 SELF.propflip_30 											:= '-1';
			 SELF.propflip_60 											:= '-1';
			 SELF.propflip_90 											:= '-1';
			 SELF.propflip_120 											:= '-1';
			 SELF.propflop 													:= '-1';
			 SELF.propflop_30 											:= '-1';
			 SELF.propflop_60 											:= '-1';
			 SELF.propflop_90 											:= '-1';
			 SELF.propflop_120 											:= '-1';
			 SELF.PropNetwork 											:= '-1';
			 SELF.prophighprof 											:= '-1';
			 SELF.propflipprofindex 								:= '-1';
			 SELF.propnetwhighprof 									:= '-1';
			 SELF.propnetwprofindex 								:= '-1';
			 SELF.propnetwflip 											:= '-1';
			 SELF.propnetwflipprofindex 						:= '-1';
			 SELF.propdaysbetweensale 							:= '-1';
			 SELF.propeverdeedtransferct 						:= '-1';
			 SELF.propeverflipct 										:= '-1';
			 SELF.propeverflopct 										:= '-1';
			 SELF.propeverhighriskct 								:= '-1';
			 SELF.propeverbusct 										:= '-1';
			 SELF.propeverhighprofct 								:= '-1';
			 SELF.propeverfliphighprofct 						:= '-1';
			 SELF.propevernetwct 										:= '-1';
			 SELF.propevernetwflipct 								:= '-1';
			 SELF.propevernetwbusflipct 						:= '-1';
			 SELF.propevernetwhighprofct 						:= '-1';
			 SELF.propevernetwfliphighprofct 				:= '-1';
			 SELF.PropertyStatusRiskIndex           := '-1';
       SELF.PropDeedRiskIndex                 := '-1';
       SELF.PropertyHistoryRiskIndex          := '-1';
			 SELF.buyer1_cluster.propertycount 			:= '-1';
			 SELF.buyer1_cluster.flipcount 					:= '-1';
			 SELF.buyer1_cluster.highprofcount 			:= '-1';
			 SELF.buyer1_cluster.defaultcount 			:= '-1';
			 SELF.buyer1_cluster.foreclosurecount 	:= '-1';
			 SELF.buyer1_cluster.defaultorforeclosurecount 		:= '-1';
			 SELF.buyer1_cluster.networkcount 			:= '-1';
			 SELF.buyer1_cluster.networkflipcount 	:= '-1';
			 SELF.buyer1_cluster.networkhighprofitcount 			:= '-1';
			 SELF.buyer1_cluster.highriskflipnetwork 					:= '-1';
			 SELF.buyer1_cluster.highriskforeclosurenetwork 	:= '-1';
			 SELF.buyer1_cluster.RiskIndex                    := '-1';
			 SELF.buyer1_cluster.clustertransfercount 				:= '-1';
			 SELF.buyer1_cluster.clusterflipcount 						:= '-1';
			 SELF.buyer1_cluster.clusterflopcount 						:= '-1';
			 SELF.buyer1_cluster.clusterbusflipcount 					:= '-1';
			 SELF.buyer1_cluster.clusterhighprofcount 				:= '-1';
			 SELF.buyer1_cluster.clusterdefaultcount 					:= '-1';
			 SELF.buyer1_cluster.clusterforeclosurecount 			:= '-1';
			 SELF.buyer1_cluster.clusterdeforforeclosurecount := '-1';
			 SELF.buyer1_cluster.clusternetworktransfercount 	:= '-1';
			 SELF.buyer1_cluster.clusternetworkflipcount 			:= '-1';
			 SELF.buyer1_cluster.clusternetworkflopcount 			:= '-1';
			 SELF.buyer1_cluster.clusternetworkbusflipcount 	:= '-1';
			 SELF.buyer1_cluster.clusternetworkhighprofcount 	:= '-1';
			 SELF.buyer1_cluster.clusternetworkhighprofflipcount := '-1';
			 self.buyer1_cluster.ClusterRiskIndex             :=  '-1';
			 SELF.buyer2_cluster.propertycount 								:= '-1';
			 SELF.buyer2_cluster.flipcount 										:= '-1';
			 SELF.buyer2_cluster.highprofcount 								:= '-1';
			 SELF.buyer2_cluster.defaultcount 								:= '-1';
			 SELF.buyer2_cluster.foreclosurecount 						:= '-1';
			 SELF.buyer2_cluster.defaultorforeclosurecount 		:= '-1';
			 SELF.buyer2_cluster.networkcount 								:= '-1';
			 SELF.buyer2_cluster.networkflipcount 						:= '-1';
			 SELF.buyer2_cluster.networkhighprofitcount 			:= '-1';
			 SELF.buyer2_cluster.highriskflipnetwork 					:= '-1';
			 SELF.buyer2_cluster.highriskforeclosurenetwork 	:= '-1';
			 SELF.buyer2_cluster.RiskIndex                    := '-1';
			 SELF.buyer2_cluster.clustertransfercount 				:= '-1';
			 SELF.buyer2_cluster.clusterflipcount 						:= '-1';
			 SELF.buyer2_cluster.clusterflopcount 						:= '-1';
			 SELF.buyer2_cluster.clusterbusflipcount 					:= '-1';
			 SELF.buyer2_cluster.clusterhighprofcount 				:= '-1';
			 SELF.buyer2_cluster.clusterdefaultcount 					:= '-1';
			 SELF.buyer2_cluster.clusterforeclosurecount 			:= '-1';
			 SELF.buyer2_cluster.clusterdeforforeclosurecount := '-1';
			 SELF.buyer2_cluster.clusternetworktransfercount 	:= '-1';
			 SELF.buyer2_cluster.clusternetworkflipcount 			:= '-1';
			 SELF.buyer2_cluster.clusternetworkflopcount 			:= '-1';
			 SELF.buyer2_cluster.clusternetworkbusflipcount 	:= '-1';
			 SELF.buyer2_cluster.clusternetworkhighprofcount 	:= '-1';
			 SELF.buyer2_cluster.clusternetworkhighprofflipcount := '-1';
			 self.buyer2_cluster.ClusterRiskIndex                     := '-1';
			 SELF.buyer3_cluster.propertycount 								:= '-1';
			 SELF.buyer3_cluster.flipcount 										:= '-1';
			 SELF.buyer3_cluster.highprofcount 								:= '-1';
			 SELF.buyer3_cluster.defaultcount 								:= '-1';
			 SELF.buyer3_cluster.foreclosurecount 						:= '-1';
			 SELF.buyer3_cluster.defaultorforeclosurecount 		:= '-1';
			 SELF.buyer3_cluster.networkcount 								:= '-1';
			 SELF.buyer3_cluster.networkflipcount 						:= '-1';
			 SELF.buyer3_cluster.networkhighprofitcount 			:= '-1';
			 SELF.buyer3_cluster.highriskflipnetwork 					:= '-1';
			 SELF.buyer3_cluster.highriskforeclosurenetwork 	:= '-1';
			 SELF.buyer3_cluster.RiskIndex                    := '-1';
			 SELF.buyer3_cluster.clustertransfercount 				:= '-1';
			 SELF.buyer3_cluster.clusterflipcount              := '-1';
			SELF.buyer3_cluster.clusterflopcount               := '-1';
			SELF.buyer3_cluster.clusterbusflipcount            := '-1';
			SELF.buyer3_cluster.clusterhighprofcount            := '-1';
			SELF.buyer3_cluster.clusterdefaultcount             := '-1';
			SELF.buyer3_cluster.clusterforeclosurecount         := '-1';
			SELF.buyer3_cluster.clusterdeforforeclosurecount    := '-1';
			SELF.buyer3_cluster.clusternetworktransfercount     := '-1';
			SELF.buyer3_cluster.clusternetworkflipcount         := '-1';
			SELF.buyer3_cluster.clusternetworkflopcount         := '-1';
			SELF.buyer3_cluster.clusternetworkbusflipcount      := '-1';
			SELF.buyer3_cluster.clusternetworkhighprofcount     := '-1';
			SELF.buyer3_cluster.clusternetworkhighprofflipcount  := '-1';
			self.buyer3_cluster.ClusterRiskIndex                 := '-1';
			SELF.seller1_cluster.propertycount                   := '-1';
			SELF.seller1_cluster.flipcount                       := '-1';
			SELF.seller1_cluster.highprofcount                   := '-1';
			SELF.seller1_cluster.defaultcount                    := '-1';
			SELF.seller1_cluster.foreclosurecount                := '-1';
			SELF.seller1_cluster.defaultorforeclosurecount       := '-1';
			SELF.seller1_cluster.networkcount                    := '-1';
			SELF.seller1_cluster.networkflipcount                := '-1';
			SELF.seller1_cluster.networkhighprofitcount          := '-1';
			SELF.seller1_cluster.highriskflipnetwork             := '-1';
			SELF.seller1_cluster.highriskforeclosurenetwork      := '-1';
			SELF.seller1_cluster.RiskIndex                       := '-1';
			SELF.seller1_cluster.clustertransfercount            := '-1';
			SELF.seller1_cluster.clusterflipcount                := '-1';
			SELF.seller1_cluster.clusterflopcount                := '-1';
			SELF.seller1_cluster.clusterbusflipcount             := '-1';
			SELF.seller1_cluster.clusterhighprofcount            := '-1';
			SELF.seller1_cluster.clusterdefaultcount             := '-1';
			SELF.seller1_cluster.clusterforeclosurecount         := '-1';
			SELF.seller1_cluster.clusterdeforforeclosurecount    := '-1';
			SELF.seller1_cluster.clusternetworktransfercount     := '-1';
			SELF.seller1_cluster.clusternetworkflipcount         := '-1';
			SELF.seller1_cluster.clusternetworkflopcount         := '-1';
			SELF.seller1_cluster.clusternetworkbusflipcount      := '-1';
			SELF.seller1_cluster.clusternetworkhighprofcount     := '-1';
			SELF.seller1_cluster.clusternetworkhighprofflipcount := '-1';
			self.seller1_cluster.ClusterRiskIndex                := '-1';
			SELF.seller2_cluster.propertycount                   := '-1';
			SELF.seller2_cluster.flipcount                       := '-1';
			SELF.seller2_cluster.highprofcount                   := '-1';
			SELF.seller2_cluster.defaultcount                    := '-1';
			SELF.seller2_cluster.foreclosurecount                := '-1';
			SELF.seller2_cluster.defaultorforeclosurecount       := '-1';
			SELF.seller2_cluster.networkcount                    := '-1';
			SELF.seller2_cluster.networkflipcount                := '-1';
			SELF.seller2_cluster.networkhighprofitcount          := '-1';
			SELF.seller2_cluster.highriskflipnetwork             := '-1';
			SELF.seller2_cluster.highriskforeclosurenetwork      := '-1';
			SELF.seller2_cluster.RiskIndex                       := '-1';
			SELF.seller2_cluster.clustertransfercount            := '-1';
			SELF.seller2_cluster.clusterflipcount                := '-1';
			SELF.seller2_cluster.clusterflopcount                := '-1';
			SELF.seller2_cluster.clusterbusflipcount             := '-1';
			SELF.seller2_cluster.clusterhighprofcount            := '-1';
			SELF.seller2_cluster.clusterdefaultcount             := '-1';
			SELF.seller2_cluster.clusterforeclosurecount         := '-1';
			SELF.seller2_cluster.clusterdeforforeclosurecount    := '-1';
			SELF.seller2_cluster.clusternetworktransfercount     := '-1';
			SELF.seller2_cluster.clusternetworkflipcount         := '-1';
			SELF.seller2_cluster.clusternetworkflopcount         := '-1';
			SELF.seller2_cluster.clusternetworkbusflipcount      := '-1';
			SELF.seller2_cluster.clusternetworkhighprofcount     := '-1';
			SELF.seller2_cluster.clusternetworkhighprofflipcount := '-1';
			self.seller2_cluster.ClusterRiskIndex                := '-1';
			SELF.seller3_cluster.propertycount                   := '-1';
			SELF.seller3_cluster.flipcount                       := '-1';
			SELF.seller3_cluster.highprofcount                   := '-1';
			SELF.seller3_cluster.defaultcount                    := '-1';
			SELF.seller3_cluster.foreclosurecount                := '-1';
			SELF.seller3_cluster.defaultorforeclosurecount       := '-1';
			SELF.seller3_cluster.networkcount                    := '-1';
			SELF.seller3_cluster.networkflipcount                := '-1';
			SELF.seller3_cluster.networkhighprofitcount          := '-1';
			SELF.seller3_cluster.highriskflipnetwork             := '-1';
			SELF.seller3_cluster.highriskforeclosurenetwork      := '-1';
			SELF.seller3_cluster.RiskIndex                       := '-1';
			SELF.seller3_cluster.clustertransfercount            := '-1';
			SELF.seller3_cluster.clusterflipcount                := '-1';
			SELF.seller3_cluster.clusterflopcount                := '-1';
			SELF.seller3_cluster.clusterbusflipcount             := '-1';
			SELF.seller3_cluster.clusterhighprofcount            := '-1';
			SELF.seller3_cluster.clusterdefaultcount             := '-1';
			SELF.seller3_cluster.clusterforeclosurecount         := '-1';
			SELF.seller3_cluster.clusterdeforforeclosurecount    := '-1';
			SELF.seller3_cluster.clusternetworktransfercount     := '-1';
			SELF.seller3_cluster.clusternetworkflipcount         := '-1';
			SELF.seller3_cluster.clusternetworkflopcount         := '-1';
			SELF.seller3_cluster.clusternetworkbusflipcount      := '-1';
			SELF.seller3_cluster.clusternetworkhighprofcount     := '-1';
			SELF.seller3_cluster.clusternetworkhighprofflipcount := '-1';
			self.seller3_cluster.ClusterRiskIndex                := '-1';
			SELF.prof1_cluster.flipcount                         := '-1';
			SELF.prof1_cluster.highprofcount                     := '-1';
			SELF.prof1_cluster.defaultcount                      := '-1';
			SELF.prof1_cluster.foreclosurecount                  := '-1';
			SELF.prof1_cluster.defaultorforeclosurecount         := '-1';
			SELF.prof1_cluster.networkcount                      := '-1';
			SELF.prof1_cluster.networkflipcount                  := '-1';
			SELF.prof1_cluster.networkhighprofitcount            := '-1';
			SELF.prof1_cluster.highriskflipnetwork               := '-1';
			SELF.prof1_cluster.highriskforeclosurenetwork        := '-1';
			SELF.prof1_cluster.RiskIndex                         := '-1';
			SELF.prof1_cluster.clustertransfercount              := '-1';
		 SELF.prof1_cluster.clusterflipcount                	:= '-1';
		 SELF.prof1_cluster.clusterflopcount                	:= '-1';
		 SELF.prof1_cluster.clusterbusflipcount              	:= '-1';
		 SELF.prof1_cluster.clusterhighprofcount             	:= '-1';
		 SELF.prof1_cluster.clusterdefaultcount              	:= '-1';
		 SELF.prof1_cluster.clusterforeclosurecount         	 := '-1';
		 SELF.prof1_cluster.clusterdeforforeclosurecount     	:= '-1';
		 SELF.prof1_cluster.clusternetworktransfercount      	:= '-1';
		 SELF.prof1_cluster.clusternetworkflipcount          	:= '-1';
		 SELF.prof1_cluster.clusternetworkflopcount          	:= '-1';
		 SELF.prof1_cluster.clusternetworkbusflipcount       	:= '-1';
		 SELF.prof1_cluster.clusternetworkhighprofcount      	:= '-1';
		 SELF.prof1_cluster.clusternetworkhighprofflipcount  	:= '-1';
		 SELF.prof1_cluster.licensestatus                			:= '-1';
		 SELF.prof1_cluster.transactionscount                	:= '-1';
		 self.prof1_cluster.ProfRiskIndex                     := '-1';
		 self.prof1_cluster.ClusterRiskIndex                  := '-1';
		 SELF.prof2_cluster.flipcount                					:= '-1';
		 SELF.prof2_cluster.highprofcount                			:= '-1';
		 SELF.prof2_cluster.defaultcount                			:= '-1';
		 SELF.prof2_cluster.foreclosurecount                	:= '-1';
		 SELF.prof2_cluster.defaultorforeclosurecount         := '-1';
		 SELF.prof2_cluster.networkcount                			:= '-1';
		 SELF.prof2_cluster.networkflipcount                	:= '-1';
		 SELF.prof2_cluster.networkhighprofitcount            := '-1';
		 SELF.prof2_cluster.highriskflipnetwork               := '-1';
		 SELF.prof2_cluster.highriskforeclosurenetwork        := '-1';
		 SELF.prof2_cluster.RiskIndex                         := '-1';
		 SELF.prof2_cluster.clustertransfercount              := '-1';
		 SELF.prof2_cluster.clusterflipcount                	:= '-1';
		 SELF.prof2_cluster.clusterflopcount                	:= '-1';
		 SELF.prof2_cluster.clusterbusflipcount               := '-1';
		 SELF.prof2_cluster.clusterhighprofcount              := '-1';
		 SELF.prof2_cluster.clusterdefaultcount               := '-1';
		 SELF.prof2_cluster.clusterforeclosurecount           := '-1';
		 SELF.prof2_cluster.clusterdeforforeclosurecount      := '-1';
		 SELF.prof2_cluster.clusternetworktransfercount       := '-1';
		 SELF.prof2_cluster.clusternetworkflipcount           := '-1';
		 SELF.prof2_cluster.clusternetworkflopcount           := '-1';
		 SELF.prof2_cluster.clusternetworkbusflipcount        := '-1';
		 SELF.prof2_cluster.clusternetworkhighprofcount       := '-1';
		 SELF.prof2_cluster.clusternetworkhighprofflipcount   := '-1';
		 SELF.prof2_cluster.licensestatus                			:= '-1';
		 SELF.prof2_cluster.transactionscount                	:= '-1';
		 self.prof2_cluster.ProfRiskIndex                    := '-1';
		 self.prof2_cluster.ClusterRiskIndex                  := '-1';
		 SELF.prof3_cluster.flipcount                					:= '-1';
		 SELF.prof3_cluster.highprofcount                			:= '-1';
		 SELF.prof3_cluster.defaultcount                			:= '-1';
		 SELF.prof3_cluster.foreclosurecount                	:= '-1';
		 SELF.prof3_cluster.defaultorforeclosurecount         := '-1';
		 SELF.prof3_cluster.networkcount                			:= '-1';
		 SELF.prof3_cluster.networkflipcount                	:= '-1';
		 SELF.prof3_cluster.networkhighprofitcount            := '-1';
		 SELF.prof3_cluster.highriskflipnetwork               := '-1';
		 SELF.prof3_cluster.highriskforeclosurenetwork        := '-1';
		 SELF.prof3_cluster.RiskIndex                         := '-1';
		 SELF.prof3_cluster.clustertransfercount              := '-1';
		 SELF.prof3_cluster.clusterflipcount                	:= '-1';
		 SELF.prof3_cluster.clusterflopcount                	:= '-1';
		 SELF.prof3_cluster.clusterbusflipcount               := '-1';
		 SELF.prof3_cluster.clusterhighprofcount              := '-1';
		 SELF.prof3_cluster.clusterdefaultcount               := '-1';
		 SELF.prof3_cluster.clusterforeclosurecount           := '-1';
		 SELF.prof3_cluster.clusterdeforforeclosurecount      := '-1';
		 SELF.prof3_cluster.clusternetworktransfercount       := '-1';
		 SELF.prof3_cluster.clusternetworkflipcount           := '-1';
		 SELF.prof3_cluster.clusternetworkflopcount           := '-1';
		 SELF.prof3_cluster.clusternetworkbusflipcount        := '-1';
		 SELF.prof3_cluster.clusternetworkhighprofcount       := '-1';
		 SELF.prof3_cluster.clusternetworkhighprofflipcount   := '-1';
		 SELF.prof3_cluster.licensestatus                			:= '-1';
		 SELF.prof3_cluster.transactionscount                	:= '-1';
		 self.prof3_cluster.ProfRiskIndex                     := '-1';
		 self.prof3_cluster.ClusterRiskIndex                  := '-1';
		 SELF																									:= le;
		END;

full_attributes_invalid := join( full_attributes, valid_seq_recs,
																right.rec_seq = left.input.seq  ,
																default_values(left), left only, all);
																
full_attributes_valid := join( full_attributes, valid_seq_recs,
														   right.rec_seq = left.input.seq , 
															 transform(layout_temp, self := left),  all, Keep(1));

layout_temp_invalid := RECORD
		sna.layouts.mortgage_collusion_output_flat;
END;
															 
layout_temp_invalid invalid_rec_defaults(invalid_inputs le) := Transform
			 self.acctno 														:= le.acctno, 
			 SELF.propdefaultcurrent 								:= '-1';
			 SELF.propdefaultever 									:= '-1';
			 SELF.propdefaulteversuspactivity 			:= '-1';
			 SELF.propforeclosurecurrent 						:= '-1';
			 SELF.propforeclosureever 							:= '-1';
			 SELF.propforeclosureeversuspactivity 	:= '-1';
			 SELF.proppriceprofindex 								:= '-1';
			 SELF.propflip 													:= '-1';
			 SELF.propflip_30 											:= '-1';
			 SELF.propflip_60 											:= '-1';
			 SELF.propflip_90 											:= '-1';
			 SELF.propflip_120 											:= '-1';
			 SELF.propflop 													:= '-1';
			 SELF.propflop_30 											:= '-1';
			 SELF.propflop_60 											:= '-1';
			 SELF.propflop_90 											:= '-1';
			 SELF.propflop_120 											:= '-1';
			 SELF.PropNetwork 											:= '-1';
			 SELF.prophighprof 											:= '-1';
			 SELF.propflipprofindex 								:= '-1';
			 SELF.propnetwhighprof 									:= '-1';
			 SELF.propnetwprofindex 								:= '-1';
			 SELF.propnetwflip 											:= '-1';
			 SELF.propnetwflipprofindex 						:= '-1';
			 SELF.propdaysbetweensale 							:= '-1';
			 SELF.propeverdeedtransferct 						:= '-1';
			 SELF.propeverflipct 										:= '-1';
			 SELF.propeverflopct 										:= '-1';
			 SELF.propeverhighriskct 								:= '-1';
			 SELF.propeverbusct 										:= '-1';
			 SELF.propeverhighprofct 								:= '-1';
			 SELF.propeverfliphighprofct 						:= '-1';
			 SELF.propevernetwct 										:= '-1';
			 SELF.propevernetwflipct 								:= '-1';
			 SELF.propevernetwbusflipct 						:= '-1';
			 SELF.propevernetwhighprofct 						:= '-1';
			 SELF.propevernetwfliphighprofct 				:= '-1';
			 SELF.PropertyStatusRiskIndex           := '-1';
       SELF.PropDeedRiskIndex                 := '-1';
       SELF.PropertyHistoryRiskIndex          := '-1';
			 	self.buyerPropertyCt_1    						:=  '-1';
				self.buyerFlipCt_1    										:=  '-1';
				self.buyerHighProfCt_1    								:=  '-1';
				self.buyerDefaultCt_1    									:=  '-1';
				self.buyerForeclosureCt_1    							:=  '-1';
				self.buyerDefaultOrForeclosureCt_1    		:=  '-1';
				self.buyerNetwCt_1    										:=  '-1';
				self.buyerNetwFlipCt_1    								:=  '-1';
				self.buyerNetwHighProfCt_1    						:=  '-1';
				self.BuyerHighRiskFlipNetw_1    					:=  '-1';    
				self.BuyerHighRiskForeclosureNetw_1    		:=  '-1';
				self.BuyerRiskIndex_1                     :=  '-1';
				self.buyerClusterTransferCt_1    					:=  '-1';
				self.buyerClusterFlipCt_1    							:=  '-1';
				self.buyerClusterFlopCt_1    							:=  '-1';
				self.buyerClusterBusFlipCt_1    					:=  '-1';
				self.buyerClusterHighProfCt_1    					:=  '-1';
				self.buyerClusterDefaultCt_1    					:=  '-1';
				self.buyerClusterForeclosureCt_1    			:=  '-1';
				self.buyerClsterDefOrForeclosureCt_1    	:=  '-1';
				self.buyerClusterNetwTransferCt_1    			:=  '-1';
				self.buyerClusterNetwFlipCt_1    					:=  '-1';
				self.buyerClusterNetwFlopCt_1    					:=  '-1';
				self.buyerClsterNetwBusFlipCt_1    				:=  '-1';
				self.buyerClsterNetwHighProfCt_1    			:=  '-1';
				self.buyerClsterNetwHighProfFlipCt_1    	:=  '-1';
				self.buyerClusterRiskIndex_1              :=  '-1';
		
				self.buyerPropertyCt_2    				:=  '-1';
				self.buyerFlipCt_2    					:=  '-1';
				self.buyerHighProfCt_2    				:=  '-1';
				self.buyerDefaultCt_2    				:=  '-1';
				self.buyerForeclosureCt_2    			:=  '-1';
				self.buyerDefaultOrForeclosureCt_2    	:=  '-1';
				self.buyerNetwCt_2    					:=  '-1';
				self.buyerNetwFlipCt_2    				:=  '-1';
				self.buyerNetwHighProfCt_2    			:=  '-1';
				self.BuyerHighRiskFlipNetw_2    		:=  '-1';
				self.BuyerHighRiskForeclosureNetw_2    :=  '-1';	
				self.BuyerRiskIndex_2                     :=  '-1';  
				self.buyerClusterTransferCt_2    		:=  '-1';
				self.buyerClusterFlipCt_2    			:=  '-1';
				self.buyerClusterFlopCt_2    			:=  '-1';
				self.buyerClusterBusFlipCt_2    		:=  '-1';
				self.buyerClusterHighProfCt_2    		:=  '-1';
				self.buyerClusterDefaultCt_2    		:=  '-1';
				self.buyerClusterForeclosureCt_2    	:=  '-1';
				self.buyerClusterNetwTransferCt_2    	:=  '-1';
				self.buyerClsterDefOrForeclosureCt_2    :=  '-1';
				self.buyerClusterNetwFlipCt_2    		:=  '-1';
				self.buyerClusterNetwFlopCt_2    		:=  '-1';
				self.buyerClsterNetwBusFlipCt_2    		:=  '-1';
				self.buyerClsterNetwHighProfCt_2    	:=  '-1';
				self.buyerClsterNetwHighProfFlipCt_2    :=  '-1';
				self.buyerClusterRiskIndex_2              :=  '-1';
		
				self.buyerPropertyCt_3    				:=  '-1';
				self.buyerFlipCt_3    					:=  '-1';
				self.buyerHighProfCt_3    				:=  '-1';
				self.buyerDefaultCt_3    				:=  '-1';
				self.buyerForeclosureCt_3    			:=  '-1';
				self.buyerDefaultOrForeclosureCt_3    	:=  '-1';
				self.buyerNetwCt_3    					:=  '-1';
				self.buyerNetwFlipCt_3    				:=  '-1';
				self.buyerNetwHighProfCt_3    			:=  '-1';
				self.BuyerHighRiskFlipNetw_3    		:=  '-1';
				self.BuyerHighRiskForeclosureNetw_3    :=  '-1';		
				self.BuyerRiskIndex_3                :=  '-1';
				self.buyerClusterTransferCt_3    		:=  '-1';
				self.buyerClusterFlipCt_3    			:=  '-1';
				self.buyerClusterFlopCt_3    			:=  '-1';
				self.buyerClusterBusFlipCt_3    		:=  '-1';
				self.buyerClusterHighProfCt_3    		:=  '-1';
				self.buyerClusterDefaultCt_3    		:=  '-1';
				self.buyerClusterForeclosureCt_3    	:=  '-1';
				self.buyerClsterDefOrForeclosureCt_3    :=  '-1';
				self.buyerClusterNetwTransferCt_3    	:=  '-1';
				self.buyerClusterNetwFlipCt_3    		:=  '-1';
				self.buyerClusterNetwFlopCt_3    		:=  '-1';
				self.buyerClsterNetwBusFlipCt_3    		:=  '-1';
				self.buyerClsterNetwHighProfCt_3    	:=  '-1';
				self.buyerClsterNetwHighProfFlipCt_3    :=  '-1';
				self.buyerClusterRiskIndex_3              :=  '-1';
				
				self.SellerPropertyCt_1    				:=  '-1';
				self.SellerFlipCt_1    					:=  '-1';
				self.SellerHighProfCt_1    				:=  '-1';
				self.SellerDefaultCt_1    				:=  '-1';
				self.SellerForeclosureCt_1    			:=  '-1';
				self.SellerDefaultOrForeclosureCt_1    :=  '-1';
				self.SellerNetwCt_1    					:=  '-1';
				self.SellerNetwFlipCt_1    				:=  '-1';
				self.SellerNetwHighProfCt_1    			:=  '-1';
				self.SellerHighRiskFlipNetw_1    		:=  '-1';
				self.SellerHighRiskForeclosureNetw_1    :=  '-1';
				self.SellerRiskIndex_1                  :=  '-1';
				self.SellerClusterTransferCt_1    		:=  '-1';
				self.SellerClusterFlipCt_1    			:=  '-1';
				self.SellerClusterFlopCt_1    			:=  '-1';
				self.SellerClusterBusFlipCt_1    		:=  '-1';
				self.SellerClusterHighProfCt_1    		:=  '-1';
				self.SellerClusterDefaultCt_1    		:=  '-1';
				self.SellerClusterForeclosureCt_1    	:=  '-1';
				self.SellerClsterDefOrForeclosureCt_1    :=  '-1';
				self.SellerClusterNetwTransferCt_1    	:=  '-1';
				self.SellerClusterNetwFlipCt_1    		:=  '-1';
				self.SellerClusterNetwFlopCt_1    		:=  '-1';
				self.SellerClsterNetwBusFlipCt_1    	:=  '-1';
				self.SellerClsterNetwHighProfCt_1    	:=  '-1';
				self.SellerClsterNetwHighProfFlipCt_1    :=  '-1';		
				self.sellerClusterRiskIndex_1              :=  '-1';
		
				self.SellerPropertyCt_2    				:=  '-1';
				self.SellerFlipCt_2    					:=  '-1';
				self.SellerHighProfCt_2    				:=  '-1';
				self.SellerDefaultCt_2    				:=  '-1';
				self.SellerForeclosureCt_2    			:=  '-1';
				self.SellerDefaultOrForeclosureCt_2    :=  '-1';
				self.SellerNetwCt_2    					:=  '-1';
				self.SellerNetwFlipCt_2    				:=  '-1';
				self.SellerNetwHighProfCt_2    			:=  '-1';
				self.SellerHighRiskFlipNetw_2    		:=  '-1';
				self.SellerHighRiskForeclosureNetw_2    :=  '-1';
				self.SellerRiskIndex_2                  :=  '-1';
				self.SellerClusterTransferCt_2    		:=  '-1';
				self.SellerClusterFlipCt_2    			:=  '-1';
				self.SellerClusterFlopCt_2    			:=  '-1';
				self.SellerClusterBusFlipCt_2    		:=  '-1';
				self.SellerClusterHighProfCt_2    		:=  '-1';
				self.SellerClusterDefaultCt_2    		:=  '-1';
				self.SellerClusterForeclosureCt_2    	:=  '-1';
				self.SellerClsterDefOrForeclosureCt_2    :=  '-1';
				self.SellerClusterNetwTransferCt_2    	:=  '-1';
				self.SellerClusterNetwFlipCt_2    		:=  '-1';
				self.SellerClusterNetwFlopCt_2    		:=  '-1';
				self.SellerClsterNetwBusFlipCt_2    	:=  '-1';
				self.SellerClsterNetwHighProfCt_2    	:=  '-1';
				self.SellerClsterNetwHighProfFlipCt_2    :=  '-1';
				self.sellerClusterRiskIndex_2              :=  '-1';
		
				self.SellerPropertyCt_3    				:=  '-1';
				self.SellerFlipCt_3    					:=  '-1';
				self.SellerHighProfCt_3    				:=  '-1';
				self.SellerDefaultCt_3    				:=  '-1';
				self.SellerForeclosureCt_3    			:=  '-1';
				self.SellerDefaultOrForeclosureCt_3    :=  '-1';
				self.SellerNetwCt_3    					:=  '-1';
				self.SellerNetwFlipCt_3    				:=  '-1';
				self.SellerNetwHighProfCt_3    			:=  '-1';
				self.SellerHighRiskFlipNetw_3    		:=  '-1';
				self.SellerHighRiskForeclosureNetw_3    :=  '-1';
				self.SellerRiskIndex_3                  :=  '-1';
				self.SellerClusterTransferCt_3    		:=  '-1';
				self.SellerClusterFlipCt_3    			:=  '-1';
				self.SellerClusterFlopCt_3    			:=  '-1';
				self.SellerClusterBusFlipCt_3    		:=  '-1';
				self.SellerClusterHighProfCt_3    		:=  '-1';
				self.SellerClusterDefaultCt_3    		:=  '-1';
				self.SellerClusterForeclosureCt_3    	:=  '-1';
				self.SellerClsterDefOrForeclosureCt_3    :=  '-1';
				self.SellerClusterNetwTransferCt_3    	:=  '-1';
				self.SellerClusterNetwFlipCt_3    		:=  '-1';
				self.SellerClusterNetwFlopCt_3    		:=  '-1';
				self.SellerClsterNetwBusFlipCt_3   		 :=  '-1';
				self.SellerClsterNetwHighProfCt_3   	 :=  '-1';
				self.SellerClsterNetwHighProfFlipCt_3    :=  '-1';
				self.sellerClusterRiskIndex_3              :=  '-1';

				self.ProfLicenseStatus_1    			:=  '-1';
				self.ProfTransactionCt_1    			:=  '-1';
				self.ProfFlipCt_1    					:=  '-1';
				self.ProfHighProfCt_1    				:=  '-1';
				self.ProfDefaultCt_1    				:=  '-1';
				self.ProfForeclosureCt_1    			:=  '-1';
				self.ProfDefaultOrForeclosureCt_1    	:=  '-1';
				self.ProfNetwCt_1    					:=  '-1';
				self.ProfNetwFlipCt_1    				:=  '-1';
				self.ProfNetwHighProfCt_1    			:=  '-1';
				self.ProfHighRiskFlipNetw_1    			:=  '-1';
				self.ProfHighRiskForeclosureNetw_1    	:=  '-1';
				self.ProfRiskIndex_1                  :=  '-1';
				self.ProfClusterTransferCt_1    		:=  '-1';
				self.ProfClusterFlipCt_1    			:=  '-1';
				self.ProfClusterFlopCt_1    			:=  '-1';
				self.ProfClusterBusFlipCt_1    			:=  '-1';
				self.ProfClusterHighProfCt_1    		:=  '-1';
				self.ProfClusterDefaultCt_1    			:=  '-1';
				self.ProfClusterForeclosureCt_1    		:=  '-1';
				self.ProfClsterDefOrForeclosureCt_1    	:=  '-1';
				self.ProfClusterNetwTransferCt_1    	:=  '-1';
				self.ProfClusterNetwFlipCt_1    		:=  '-1';
				self.ProfClusterNetwFlopCt_1    		:=  '-1';
				self.ProfClsterNetwBusFlipCt_1    		:=  '-1';
				self.ProfClsterNetwHighProfCt_1    		:=  '-1';
				self.ProfClsterNetwHighProfFlipCt_1    :=  '-1';
				self.ProfClusterRiskIndex_1              :=  '-1';
				
				self.ProfLicenseStatus_2    		:=  '-1';
				self.ProfTransactionCt_2    			:=  '-1';
				self.ProfFlipCt_2    					:=  '-1';
				self.ProfHighProfCt_2    				:=  '-1';
				self.ProfDefaultCt_2    				:=  '-1';
				self.ProfForeclosureCt_2    			:=  '-1';
				self.ProfDefaultOrForeclosureCt_2    	:=  '-1';
				self.ProfNetwCt_2    					:=  '-1';
				self.ProfNetwFlipCt_2    				:=  '-1';
				self.ProfNetwHighProfCt_2    			:=  '-1';
				self.ProfHighRiskFlipNetw_2    			:=  '-1';
				self.ProfHighRiskForeclosureNetw_2    	:=  '-1';
				self.ProfRiskIndex_2                  :=  '-1';
				self.ProfClusterTransferCt_2    		:=  '-1';
				self.ProfClusterFlipCt_2    			:=  '-1';
				self.ProfClusterFlopCt_2    			:=  '-1';
				self.ProfClusterBusFlipCt_2    			:=  '-1';
				self.ProfClusterHighProfCt_2    		:=  '-1';
				self.ProfClusterDefaultCt_2    			:=  '-1';
				self.ProfClusterForeclosureCt_2    		:=  '-1';
				self.ProfClsterDefOrForeclosureCt_2    :=  '-1';
				self.ProfClusterNetwTransferCt_2    	:=  '-1';
				self.ProfClusterNetwFlipCt_2    		:=  '-1';
				self.ProfClusterNetwFlopCt_2    		:=  '-1';
				self.ProfClsterNetwBusFlipCt_2    		:=  '-1';
				self.ProfClsterNetwHighProfCt_2    		:=  '-1';
				self.ProfClsterNetwHighProfFlipCt_2    :=  '-1';
				self.ProfClusterRiskIndex_2              :=  '-1';
				
				self.ProfLicenseStatus_3    			:=  '-1';
				self.ProfTransactionCt_3    			:=  '-1';
				self.ProfFlipCt_3    					:=  '-1';
				self.ProfHighProfCt_3    				:=  '-1';
				self.ProfDefaultCt_3    				:=  '-1';
				self.ProfForeclosureCt_3    			:=  '-1';
				self.ProfDefaultOrForeclosureCt_3    	:=  '-1';
				self.ProfNetwCt_3    					:=  '-1';
				self.ProfNetwFlipCt_3    				:=  '-1';
				self.ProfNetwHighProfCt_3    			:=  '-1';
				self.ProfHighRiskFlipNetw_3    			:=  '-1';
				self.ProfHighRiskForeclosureNetw_3    	:=  '-1';
				self.ProfRiskIndex_3                  :=  '-1';
				self.ProfClusterTransferCt_3    		:=  '-1';
				self.ProfClusterFlipCt_3    			:=  '-1';
				self.ProfClusterFlopCt_3    			:=  '-1';
				self.ProfClusterBusFlipCt_3    			:=  '-1';
				self.ProfClusterHighProfCt_3    		:=  '-1';
				self.ProfClusterDefaultCt_3    			:=  '-1';
				self.ProfClusterForeclosureCt_3    		:=  '-1';
				self.ProfClsterDefOrForeclosureCt_3    	:=  '-1';
				self.ProfClusterNetwTransferCt_3    	:=  '-1';
				self.ProfClusterNetwFlipCt_3    		:=  '-1';
				self.ProfClusterNetwFlopCt_3    		:=  '-1';
				self.ProfClsterNetwBusFlipCt_3    		:=  '-1';
				self.ProfClsterNetwHighProfCt_3    		:=  '-1';
				self.ProfClsterNetwHighProfFlipCt_3    	:=  '-1';
				self.ProfClusterRiskIndex_3              :=  '-1';
				SELF 																		:= le;
		END;

invalid_inputs_defaults := project(invalid_inputs, invalid_rec_defaults(left));
																

// rollup down to 1 record per input transaction
layout_temp roll_full_attributes(layout_temp le, layout_temp rt) := transform
  self.PropDefaultCurrent := if(rt.input.recordlabel='propery_address', rt.PropDefaultCurrent, le.PropDefaultCurrent); 				
    self.PropDefaultEver   := if(rt.input.recordlabel='propery_address', rt.PropDefaultEver, le.PropDefaultEver); 						
    self.PropDefaultEverSuspActivity:= if(rt.input.recordlabel='propery_address', rt.PropDefaultEverSuspActivity, le.PropDefaultEverSuspActivity); 
    self.PropForeclosureCurrent:= if(rt.input.recordlabel='propery_address', rt.PropForeclosureCurrent, le.PropForeclosureCurrent); 		
    self.PropForeclosureEver:= if(rt.input.recordlabel='propery_address', rt.PropForeclosureEver, le.PropForeclosureEver);					
    self.PropForeclosureEverSuspActivity:= if(rt.input.recordlabel='propery_address', rt.PropForeclosureEverSuspActivity, le.PropForeclosureEverSuspActivity);
		self.PropPriceProfIndex:= if(rt.input.recordlabel='propery_address', rt.PropPriceProfIndex, le.PropPriceProfIndex); 							
    self.PropFlip := if(rt.input.recordlabel='propery_address', rt.PropFlip, le.PropFlip); 											
    self.PropFlip_30:= if(rt.input.recordlabel='propery_address', rt.PropFlip_30, le.PropFlip_30); 										
    self.PropFlip_60 := if(rt.input.recordlabel='propery_address', rt.PropFlip_60, le.PropFlip_60); 									
    self.PropFlip_90:= if(rt.input.recordlabel='propery_address', rt.PropFlip_90, le.PropFlip_90); 										
    self.PropFlip_120:= if(rt.input.recordlabel='propery_address', rt.PropFlip_120, le.PropFlip_120);									
    self.PropFlop:= if(rt.input.recordlabel='propery_address', rt.PropFlop, le.PropFlop); 										
    self.PropFlop_30:= if(rt.input.recordlabel='propery_address', rt.PropFlop_30, le.PropFlop_30);									
    self.PropFlop_60:= if(rt.input.recordlabel='propery_address', rt.PropFlop_60, le.PropFlop_60);									
    self.PropFlop_90:= if(rt.input.recordlabel='propery_address', rt.PropFlop_90, le.PropFlop_90);									 
    self.PropFlop_120:= if(rt.input.recordlabel='propery_address', rt.PropFlop_120, le.PropFlop_120); 								
    self.PropNetwork:= if(rt.input.recordlabel='propery_address', rt.PropNetwork, le.PropNetwork);						
    self.PropHighProf := if(rt.input.recordlabel='propery_address', rt.PropHighProf, le.PropHighProf);					 
    self.PropFlipProfIndex:= if(rt.input.recordlabel='propery_address', rt.PropFlipProfIndex, le.PropFlipProfIndex);					
    self.PropNetwHighProf:= if(rt.input.recordlabel='propery_address', rt.PropNetwHighProf, le.PropNetwHighProf);						
    self.PropNetwProfIndex:= if(rt.input.recordlabel='propery_address', rt.PropNetwProfIndex, le.PropNetwProfIndex); 						
    self.PropNetwFlip := if(rt.input.recordlabel='propery_address', rt.PropNetwFlip, le.PropNetwFlip); 								
    self.PropNetwFlipProfIndex:= if(rt.input.recordlabel='propery_address', rt.PropNetwFlipProfIndex, le.PropNetwFlipProfIndex);				 
    self.PropDaysBetweenSale:= if(rt.input.recordlabel='propery_address', rt.PropDaysBetweenSale, le.PropDaysBetweenSale);					
    self.PropEverDeedTransferCt := if(rt.input.recordlabel='propery_address', rt.PropEverDeedTransferCt, le.PropEverDeedTransferCt); 				
    self.PropEverFlipCt:= if(rt.input.recordlabel='propery_address', rt.PropEverFlipCt, le.PropEverFlipCt); 								
    self.PropEverFlopCt := if(rt.input.recordlabel='propery_address', rt.PropEverFlopCt, le.PropEverFlopCt); 							
    self.PropEverHighRiskCt:= if(rt.input.recordlabel='propery_address', rt.PropEverHighRiskCt, le.PropEverHighRiskCt);					
    self.PropEverBusCt:= if(rt.input.recordlabel='propery_address', rt.PropEverBusCt, le.PropEverBusCt); 							
    self.PropEverHighProfCt:= if(rt.input.recordlabel='propery_address', rt.PropEverHighProfCt, le.PropEverHighProfCt); 				
    self.PropEverFlipHighProfCt:= if(rt.input.recordlabel='propery_address', rt.PropEverFlipHighProfCt, le.PropEverFlipHighProfCt); 			
    self.PropEverNetwCt := if(rt.input.recordlabel='propery_address', rt.PropEverNetwCt, le.PropEverNetwCt); 							
    self.PropEverNetwFlipCt:= if(rt.input.recordlabel='propery_address', rt.PropEverNetwFlipCt, le.PropEverNetwFlipCt); 					
    self.PropEverNetwBusFlipCt:= if(rt.input.recordlabel='propery_address', rt.PropEverNetwBusFlipCt, le.PropEverNetwBusFlipCt); 					
    self.PropEverNetwHighProfCt:= if(rt.input.recordlabel='propery_address', rt.PropEverNetwHighProfCt, le.PropEverNetwHighProfCt); 					
    self.PropEverNetwFlipHighProfCt:= if(rt.input.recordlabel='propery_address', rt.PropEverNetwFlipHighProfCt, le.PropEverNetwFlipHighProfCt); 
		self.PropertyStatusRiskIndex:= if(rt.input.recordlabel='propery_address', rt.PropertyStatusRiskIndex, le.PropertyStatusRiskIndex);
    self.PropDeedRiskIndex:= if(rt.input.recordlabel='propery_address', rt.PropDeedRiskIndex, le.PropDeedRiskIndex);
    self.PropertyHistoryRiskIndex:= if(rt.input.recordlabel='propery_address', rt.PropertyHistoryRiskIndex, le.PropertyHistoryRiskIndex);
		self.Buyer1_cluster := if(rt.input.recordlabel='buyer1', rt.Buyer1_cluster, le.Buyer1_cluster);
		self.Buyer2_cluster := if(rt.input.recordlabel='buyer2', rt.Buyer2_cluster, le.buyer2_cluster);
		self.Buyer3_cluster := if(rt.input.recordlabel='buyer3', rt.Buyer3_cluster, le.buyer3_cluster) ;
		self.Seller1_cluster := if(rt.input.recordlabel='seller1', rt.Seller1_cluster, le.seller1_cluster);
		self.Seller2_cluster := if(rt.input.recordlabel='seller2', rt.Seller2_cluster, le.seller2_cluster);
		self.Seller3_cluster := if(rt.input.recordlabel='seller3', rt.Seller3_cluster, le.seller3_cluster);
		self.Prof1_cluster := if(rt.input.recordlabel='prof1', rt.Prof1_cluster, le.prof1_cluster);
		self.Prof2_cluster := if(rt.input.recordlabel='prof2', rt.Prof2_cluster, le.prof2_cluster);
		self.Prof3_cluster := if(rt.input.recordlabel='prof3', rt.Prof3_cluster, le.prof3_cluster);
	
	  self := rt;
end;

all_attributes   := sort(ungroup(full_attributes_valid + full_attributes_invalid), input.transaction_seq);

rolled_valid_attributes := rollup(group(all_attributes, input.transaction_seq), true, roll_full_attributes(left, right));


results_valid := join(rolled_valid_attributes, batch_in_seq, left.input.transaction_seq=right.transaction_seq,
	transform(SNA.layouts.mortgage_collusion_output, 
		self.acctno := right.acctno,
		self := left));



// TODO:  ADD search against MIDEX data to populate the license status and transaction counts for the 3 prof individuals

SNA.Layouts.mortgage_collusion_output_flat  flatten_results(SNA.layouts.mortgage_collusion_output le, valid_inputs ri) := TRANSFORM
		self.PropDefaultCurrent            							:= le.propdefaultcurrent;  				
    self.PropDefaultEver            								:= le.propdefaultever ;  						
    self.PropDefaultEverSuspActivity            		:= le.propdefaulteversuspactivity ;  
    self.PropForeclosureCurrent            					:= le.propforeclosurecurrent ;  		
    self.PropForeclosureEver            						:= le.propforeclosureever ; 					
    self.PropForeclosureEverSuspActivity            := le.propforeclosureeversuspactivity; 
		self.PropPriceProfIndex            							:=  le.proppriceprofindex;  							
    self.PropFlip             											:= le.propflip;  											
    self.PropFlip_30           										  := le.propflip_30;  										
    self.PropFlip_60             										:= le.propflip_60;  									
    self.PropFlip_90            										:= le.propflip_90;  										
    self.PropFlip_120            										:=  le.propflip_120; 									
    self.PropFlop            												:= le.propflop;  										
    self.PropFlop_30            										:= le.propflop_30; 									
    self.PropFlop_60            										:= le.propflop_60 ; 									
    self.PropFlop_90            										:= le.propflop_90; 									 
    self.PropFlop_120            										:= le.propflop_120;  								
    self.PropNetwork             									  := le.propnetwork;  							
    self.PropHighProf             									:= le.prophighprof  ; 					 
    self.PropFlipProfIndex            							:= le.propflipprofindex; 					
    self.PropNetwHighProf            								:= le.propnetwhighprof; 						
    self.PropNetwProfIndex            							:= le.propnetwprofindex ;  						
    self.PropNetwFlip             									:= le.propnetwflip;  								
    self.PropNetwFlipProfIndex            					:= le.propnetwflipprofindex; 				 
    self.PropDaysBetweenSale            						:= le.propdaysbetweensale ; 					
    self.PropEverDeedTransferCt            					:= le.propeverdeedtransferct;  				
    self.PropEverFlipCt            									:= le.propeverflipct;  								
    self.PropEverFlopCt             								:= le.propeverflopct;  							
    self.PropEverHighRiskCt            							:= le.propeverhighriskct; 					
    self.PropEverBusCt            									:=  le.propeverbusct;  							
    self.PropEverHighProfCt            							:=  le.propeverhighprofct;  				
    self.PropEverFlipHighProfCt            					:= le.propeverfliphighprofct;  			
    self.PropEverNetwCt             								:= le.propevernetwct;  							
    self.PropEverNetwFlipCt            							:= le.propevernetwflipct ;  					
    self.PropEverNetwBusFlipCt            					:= le.propevernetwbusflipct ;  					
    self.PropEverNetwHighProfCt            					:= le.propevernetwhighprofct;  					
    self.PropEverNetwFlipHighProfCt            			:= le.propevernetwfliphighprofct; 
		self.PropertyStatusRiskIndex                    := le.PropertyStatusRiskIndex;
    self.PropDeedRiskIndex                          := le.PropDeedRiskIndex;
    self.PropertyHistoryRiskIndex                   := le.PropertyHistoryRiskIndex;
		
		self.BuyerPropertyCt_1            							:= le.buyer1_cluster.propertycount; 
    self.BuyerFlipCt_1            									:= le.buyer1_cluster.flipcount ; 
    self.BuyerHighProfCt_1            							:= le.buyer1_cluster.highprofcount; 
    self.BuyerDefaultCt_1            								:= le.buyer1_cluster.defaultcount; 
    self.BuyerForeclosureCt_1            						:=  le.buyer1_cluster.foreclosurecount; 
    self.BuyerDefaultOrForeclosureCt_1            	:= le.buyer1_cluster.defaultorforeclosurecount ; 
    self.BuyerNetwCt_1            									:= le.buyer1_cluster.networkcount ; 
    self.BuyerNetwFlipCt_1            							:= le.buyer1_cluster.networkflipcount; 
    self.BuyerNetwHighProfCt_1            					:= le.buyer1_cluster.networkhighprofitcount  ; 
    self.BuyerHighRiskFlipNetw_1            				:= le.buyer1_cluster.highriskflipnetwork ;     
    self.BuyerHighRiskForeclosureNetw_1            	:= le.buyer1_cluster.highriskforeclosurenetwork; 
		self.BuyerRiskIndex_1                           := le.buyer1_cluster.RiskIndex;
    self.BuyerClusterTransferCt_1            				:= le.buyer1_cluster.clustertransfercount; 
    self.BuyerClusterFlipCt_1            						:= le.buyer1_cluster.clusterflipcount; 
    self.BuyerClusterFlopCt_1            						:= le.buyer1_cluster.clusterflopcount ; 
    self.BuyerClusterBusFlipCt_1            				:= le.buyer1_cluster.clusterbusflipcount; 
    self.BuyerClusterHighProfCt_1            				:= le.buyer1_cluster.clusterhighprofcount; 
    self.BuyerClusterDefaultCt_1            				:= le.buyer1_cluster.clusterdefaultcount; 
    self.BuyerClusterForeclosureCt_1            		:= le.buyer1_cluster.clusterforeclosurecount; 
    self.BuyerClsterDefOrForeclosureCt_1            := le.buyer1_cluster.ClusterDefOrForeclosureCount ; 
    self.BuyerClusterNetwTransferCt_1            		:= le.buyer1_cluster.clusternetworktransfercount; 
    self.BuyerClusterNetwFlipCt_1            				:= le.buyer1_cluster.clusternetworkflipcount; 
    self.BuyerClusterNetwFlopCt_1            				:= le.buyer1_cluster.clusternetworkflopcount ; 
    self.BuyerClsterNetwBusFlipCt_1            			:= le.buyer1_cluster.clusternetworkbusflipcount ; 
    self.BuyerClsterNetwHighProfCt_1            		:= le.buyer1_cluster.clusternetworkhighprofcount; 
    self.BuyerClsterNetwHighProfFlipCt_1            := le.buyer1_cluster.clusternetworkhighprofflipcount; 
		self.buyerClusterRiskIndex_1                    := le.buyer1_cluster.ClusterRiskIndex ;
		self.BuyerPropertyCt_2            							:= le.buyer2_cluster.propertycount; 
    self.BuyerFlipCt_2            									:= le.buyer2_cluster.flipcount; 
    self.BuyerHighProfCt_2            							:= le.buyer2_cluster.highprofcount; 
    self.BuyerDefaultCt_2            								:= le.buyer2_cluster.defaultcount; 
    self.BuyerForeclosureCt_2            						:= le.buyer2_cluster.foreclosurecount  ; 
    self.BuyerDefaultOrForeclosureCt_2            	:= le.buyer2_cluster.defaultorforeclosurecount ; 
    self.BuyerNetwCt_2            									:=  le.buyer2_cluster.networkcount ; 
    self.BuyerNetwFlipCt_2            							:=  le.buyer2_cluster.networkflipcount ; 
    self.BuyerNetwHighProfCt_2            					:=  le.buyer2_cluster.networkhighprofitcount  ; 
    self.BuyerHighRiskFlipNetw_2            				:=  le.buyer2_cluster.highriskflipnetwork ; 
    self.BuyerHighRiskForeclosureNetw_2            	:= le.buyer2_cluster.highriskforeclosurenetwork ; 
		self.BuyerRiskIndex_2                           := le.buyer2_cluster.RiskIndex;
    self.BuyerClusterTransferCt_2            				:=  le.buyer2_cluster.clustertransfercount; 
    self.BuyerClusterFlipCt_2            						:=  le.buyer2_cluster.clusterflipcount ; 
    self.BuyerClusterFlopCt_2            						:= le.buyer2_cluster.clusterflopcount ; 
    self.BuyerClusterBusFlipCt_2            				:=  le.buyer2_cluster.clusterbusflipcount ; 
    self.BuyerClusterHighProfCt_2            				:= le.buyer2_cluster.clusterhighprofcount; 
    self.BuyerClusterDefaultCt_2            				:= le.buyer2_cluster.clusterdefaultcount  ; 
    self.BuyerClusterForeclosureCt_2            		:=  le.buyer2_cluster.clusterforeclosurecount; 
    self.BuyerClsterDefOrForeclosureCt_2            :=  le.buyer2_cluster.clusterdeforforeclosurecount ; 
    self.BuyerClusterNetwTransferCt_2            		:=  le.buyer2_cluster.clusternetworktransfercount; 
    self.BuyerClusterNetwFlipCt_2            				:= le.buyer2_cluster.clusternetworkflipcount ; 
    self.BuyerClusterNetwFlopCt_2            				:= le.buyer2_cluster.clusternetworkflopcount  ; 
    self.BuyerClsterNetwBusFlipCt_2            			:= le.buyer2_cluster.clusternetworkbusflipcount ; 
    self.BuyerClsterNetwHighProfCt_2            		:= le.buyer2_cluster.clusternetworkhighprofcount  ; 
    self.BuyerClsterNetwHighProfFlipCt_2            :=  le.buyer2_cluster.clusternetworkhighprofflipcount;
		self.buyerClusterRiskIndex_2                    := le.buyer2_cluster.ClusterRiskIndex ;
		
		self.BuyerPropertyCt_3            							:= le.buyer3_cluster.propertycount  ; 
    self.BuyerFlipCt_3            									:= le.buyer3_cluster.flipcount ; 
    self.BuyerHighProfCt_3            							:= le.buyer3_cluster.highprofcount ; 
    self.BuyerDefaultCt_3            								:= le.buyer3_cluster.defaultcount  ; 
    self.BuyerForeclosureCt_3            						:= le.buyer3_cluster.foreclosurecount  ; 
    self.BuyerDefaultOrForeclosureCt_3            	:= le.buyer3_cluster.defaultorforeclosurecount  ; 
    self.BuyerNetwCt_3            									:=   le.buyer3_cluster.networkcount; 
    self.BuyerNetwFlipCt_3            							:= le.buyer3_cluster.networkflipcount ; 
    self.BuyerNetwHighProfCt_3            					:=  le.buyer3_cluster.networkhighprofitcount; 
    self.BuyerHighRiskFlipNetw_3            				:= le.buyer3_cluster.highriskflipnetwork ; 
    self.BuyerHighRiskForeclosureNetw_3            	:= le.buyer3_cluster.highriskforeclosurenetwork ; 
		self.BuyerRiskIndex_3                           :=  le.buyer3_cluster.RiskIndex;
    self.BuyerClusterTransferCt_3            				:= le.buyer3_cluster.clustertransfercount ; 
    self.BuyerClusterFlipCt_3            						:= le.buyer3_cluster.clusterflipcount  ; 
    self.BuyerClusterFlopCt_3            						:= le.buyer3_cluster.clusterflopcount; 
    self.BuyerClusterBusFlipCt_3            				:= le.buyer3_cluster.clusterbusflipcount ; 
    self.BuyerClusterHighProfCt_3            				:= le.buyer3_cluster.clusterhighprofcount ; 
    self.BuyerClusterDefaultCt_3            				:= le.buyer3_cluster.clusterdefaultcount; 
    self.BuyerClusterForeclosureCt_3            		:= le.buyer3_cluster.clusterforeclosurecount  ; 
    self.BuyerClsterDefOrForeclosureCt_3            := le.buyer3_cluster.clusterdeforforeclosurecount ; 
    self.BuyerClusterNetwTransferCt_3            		:= le.buyer3_cluster.clusternetworktransfercount ; 
    self.BuyerClusterNetwFlipCt_3            				:= le.buyer3_cluster.clusternetworkflipcount; 
    self.BuyerClusterNetwFlopCt_3            				:= le.buyer3_cluster.clusternetworkflopcount; 
    self.BuyerClsterNetwBusFlipCt_3            			:= le.buyer3_cluster.clusternetworkbusflipcount; 
    self.BuyerClsterNetwHighProfCt_3            		:= le.buyer3_cluster.clusternetworkhighprofcount ; 
    self.BuyerClsterNetwHighProfFlipCt_3            := le.buyer3_cluster.clusternetworkhighprofflipcount  ; 
		self.buyerClusterRiskIndex_3                    := le.buyer3_cluster.ClusterRiskIndex ;
		
		self.SellerPropertyCt_1            							:= le.seller1_cluster.propertycount ; 
    self.SellerFlipCt_1            									:= le.seller1_cluster.flipcount  ; 
    self.SellerHighProfCt_1            							:= le.seller1_cluster.highprofcount  ; 
    self.SellerDefaultCt_1            							:=  le.seller1_cluster.defaultcount; 
    self.SellerForeclosureCt_1            					:= le.seller1_cluster.foreclosurecount ; 
    self.SellerDefaultOrForeclosureCt_1            	:= le.seller1_cluster.defaultorforeclosurecount ; 
    self.SellerNetwCt_1            									:= le.seller1_cluster.networkcount ; 
    self.SellerNetwFlipCt_1            							:=  le.seller1_cluster.networkflipcount ; 
    self.SellerNetwHighProfCt_1            					:= le.seller1_cluster.networkhighprofitcount ; 
    self.SellerHighRiskFlipNetw_1            				:= le.seller1_cluster.highriskflipnetwork ; 
    self.SellerHighRiskForeclosureNetw_1            := le.seller1_cluster.highriskforeclosurenetwork ;
		self.SellerRiskIndex_1                           :=  le.seller1_cluster.RiskIndex;	
    self.SellerClusterTransferCt_1            			:= le.seller1_cluster.clustertransfercount; 
    self.SellerClusterFlipCt_1            					:= le.seller1_cluster.clusterflipcount; 
    self.SellerClusterFlopCt_1            					:= le.seller1_cluster.clusterflopcount; 
    self.SellerClusterBusFlipCt_1            				:= le.seller1_cluster.clusterbusflipcount ; 
    self.SellerClusterHighProfCt_1            			:= le.seller1_cluster.clusterhighprofcount ; 
    self.SellerClusterDefaultCt_1            				:= le.seller1_cluster.clusterdefaultcount; 
    self.SellerClusterForeclosureCt_1            		:= le.seller1_cluster.clusterforeclosurecount; 
    self.SellerClsterDefOrForeclosureCt_1           := le.seller1_cluster.clusterdeforforeclosurecount  ; 
    self.SellerClusterNetwTransferCt_1            	:= le.seller1_cluster.clusternetworktransfercount ; 
    self.SellerClusterNetwFlipCt_1            			:= le.seller1_cluster.clusternetworkflipcount  ; 
    self.SellerClusterNetwFlopCt_1            			:= le.seller1_cluster.clusternetworkflopcount; 
    self.SellerClsterNetwBusFlipCt_1            		:= le.seller1_cluster.clusternetworkbusflipcount ; 
    self.SellerClsterNetwHighProfCt_1            		:= le.seller1_cluster.clusternetworkhighprofcount ; 
    self.SellerClsterNetwHighProfFlipCt_1            := le.seller1_cluster.clusternetworkhighprofflipcount;
		self.SellerClusterRiskIndex_1                    := le.seller1_cluster.ClusterRiskIndex ;
		
		self.SellerPropertyCt_2            							:= le.seller2_cluster.propertycount ; 
    self.SellerFlipCt_2            									:= le.seller2_cluster.flipcount; 
    self.SellerHighProfCt_2            							:= le.seller2_cluster.highprofcount ; 
    self.SellerDefaultCt_2            							:= le.seller2_cluster.defaultcount ; 
    self.SellerForeclosureCt_2            					:= le.seller2_cluster.foreclosurecount ; 
    self.SellerDefaultOrForeclosureCt_2            	:= le.seller2_cluster.defaultorforeclosurecount ; 
    self.SellerNetwCt_2            									:= le.seller2_cluster.networkcount ; 
    self.SellerNetwFlipCt_2            							:= le.seller2_cluster.networkflipcount ; 
    self.SellerNetwHighProfCt_2            					:= le.seller2_cluster.networkhighprofitcount ; 
    self.SellerHighRiskFlipNetw_2            				:= le.seller2_cluster.highriskflipnetwork; 
    self.SellerHighRiskForeclosureNetw_2            := le.seller2_cluster.highriskforeclosurenetwork ; 
		self.SellerRiskIndex_2                          :=  le.seller2_cluster.RiskIndex;
    self.SellerClusterTransferCt_2            			:= le.seller2_cluster.clustertransfercount ; 
    self.SellerClusterFlipCt_2            					:= le.seller2_cluster.clusterflipcount  ; 
    self.SellerClusterFlopCt_2            					:= le.seller2_cluster.clusterflopcount  ; 
    self.SellerClusterBusFlipCt_2            				:= le.seller2_cluster.clusterbusflipcount ; 
    self.SellerClusterHighProfCt_2            			:= le.seller2_cluster.clusterhighprofcount; 
    self.SellerClusterDefaultCt_2            				:= le.seller2_cluster.clusterdefaultcount ; 
    self.SellerClusterForeclosureCt_2            		:= le.seller2_cluster.clusterforeclosurecount; 
    self.SellerClsterDefOrForeclosureCt_2           := le.seller2_cluster.clusterdeforforeclosurecount; 
    self.SellerClusterNetwTransferCt_2            	:= le.seller2_cluster.clusternetworktransfercount  ; 
    self.SellerClusterNetwFlipCt_2            			:= le.seller2_cluster.clusternetworkflipcount ; 
    self.SellerClusterNetwFlopCt_2            			:= le.seller2_cluster.clusternetworkflopcount  ; 
    self.SellerClsterNetwBusFlipCt_2            		:= le.seller2_cluster.clusternetworkbusflipcount ; 
    self.SellerClsterNetwHighProfCt_2            		:= le.seller2_cluster.clusternetworkhighprofcount; 
    self.SellerClsterNetwHighProfFlipCt_2           := le.seller2_cluster.clusternetworkhighprofflipcount; 
		self.SellerClusterRiskIndex_2                    := le.seller2_cluster.ClusterRiskIndex ;
		
		self.SellerPropertyCt_3            							:= le.seller3_cluster.propertycount; 
    self.SellerFlipCt_3            									:= le.seller3_cluster.flipcount; 
    self.SellerHighProfCt_3            							:= le.seller3_cluster.highprofcount; 
    self.SellerDefaultCt_3            							:= le.seller3_cluster.defaultcount ; 
    self.SellerForeclosureCt_3            					:= le.seller3_cluster.foreclosurecount; 
    self.SellerDefaultOrForeclosureCt_3            	:= le.seller3_cluster.defaultorforeclosurecount ; 
    self.SellerNetwCt_3            									:= le.seller3_cluster.networkcount  ; 
    self.SellerNetwFlipCt_3            							:= le.seller3_cluster.networkflipcount ; 
    self.SellerNetwHighProfCt_3            					:= le.seller3_cluster.networkhighprofitcount ; 
    self.SellerHighRiskFlipNetw_3            				:= le.seller3_cluster.highriskflipnetwork ; 
    self.SellerHighRiskForeclosureNetw_3            := le.seller3_cluster.highriskforeclosurenetwork  ; 
		self.SellerRiskIndex_3                          :=  le.seller3_cluster.RiskIndex;
    self.SellerClusterTransferCt_3            			:= le.seller3_cluster.clustertransfercount; 
    self.SellerClusterFlipCt_3            					:=  le.seller3_cluster.clusterflipcount  ; 
    self.SellerClusterFlopCt_3            					:= le.seller3_cluster.clusterflopcount  ; 
    self.SellerClusterBusFlipCt_3            				:= le.seller3_cluster.clusterbusflipcount; 
    self.SellerClusterHighProfCt_3            			:= le.seller3_cluster.clusterhighprofcount ; 
    self.SellerClusterDefaultCt_3            				:= le.seller3_cluster.clusterdefaultcount ; 
    self.SellerClusterForeclosureCt_3            		:= le.seller3_cluster.clusterforeclosurecount ; 
    self.SellerClsterDefOrForeclosureCt_3           := le.seller3_cluster.clusterdeforforeclosurecount ; 
    self.SellerClusterNetwTransferCt_3            	:= le.seller3_cluster.clusternetworktransfercount; 
    self.SellerClusterNetwFlipCt_3            			:= le.seller3_cluster.clusternetworkflipcount; 
    self.SellerClusterNetwFlopCt_3            			:= le.seller3_cluster.clusternetworkflopcount; 
    self.SellerClsterNetwBusFlipCt_3            		:= le.seller3_cluster.clusternetworkbusflipcount ; 
    self.SellerClsterNetwHighProfCt_3            		:= le.seller3_cluster.clusternetworkhighprofcount; 
    self.SellerClsterNetwHighProfFlipCt_3           := le.seller3_cluster.clusternetworkhighprofflipcount ;
		self.SellerClusterRiskIndex_3                    := le.seller3_cluster.ClusterRiskIndex ;

		self.ProfLicenseStatus_1            						:= le.prof1_cluster.licensestatus   ; 
    self.ProfTransactionCt_1            						:= le.prof1_cluster.transactionscount ; 
		self.ProfFlipCt_1            										:= le.prof1_cluster.flipcount ; 
		self.ProfHighProfCt_1            								:= le.prof1_cluster.highprofcount  ; 
		self.ProfDefaultCt_1            								:= le.prof1_cluster.defaultcount ; 
		self.ProfForeclosureCt_1            						:= le.prof1_cluster.foreclosurecount; 
		self.ProfDefaultOrForeclosureCt_1           		:= le.prof1_cluster.defaultorforeclosurecount; 
		self.ProfNetwCt_1            										:= le.prof1_cluster.networkcount ; 
		self.ProfNetwFlipCt_1            								:= le.prof1_cluster.networkflipcount; 
		self.ProfNetwHighProfCt_1            						:= le.prof1_cluster.networkhighprofitcount; 
		self.ProfHighRiskFlipNetw_1            					:= le.prof1_cluster.highriskflipnetwork ; 
		self.ProfHighRiskForeclosureNetw_1            	:= le.prof1_cluster.highriskforeclosurenetwork ; 
		self.ProfRiskIndex_1                          	:= le.prof1_cluster.ProfRiskIndex ;
		self.ProfClusterTransferCt_1            				:= le.prof1_cluster.clustertransfercount ; 
		self.ProfClusterFlipCt_1            						:=   le.prof1_cluster.clusterflipcount ; 
		self.ProfClusterFlopCt_1            						:= le.prof1_cluster.clusterflopcount ; 
		self.ProfClusterBusFlipCt_1            					:=  le.prof1_cluster.clusterbusflipcount; 
		self.ProfClusterHighProfCt_1            				:= le.prof1_cluster.clusterhighprofcount ; 
		self.ProfClusterDefaultCt_1            					:= le.prof1_cluster.clusterdefaultcount ; 
		self.ProfClusterForeclosureCt_1            			:= le.prof1_cluster.clusterforeclosurecount ; 
		self.ProfClsterDefOrForeclosureCt_1            	:= le.prof1_cluster.clusterdeforforeclosurecount; 
		self.ProfClusterNetwTransferCt_1            		:= le.prof1_cluster.clusternetworktransfercount; 
		self.ProfClusterNetwFlipCt_1            				:= le.prof1_cluster.clusternetworkflipcount; 
		self.ProfClusterNetwFlopCt_1            				:=  le.prof1_cluster.clusternetworkflopcount; 
		self.ProfClsterNetwBusFlipCt_1            			:= le.prof1_cluster.clusternetworkbusflipcount; 
		self.ProfClsterNetwHighProfCt_1            			:= le.prof1_cluster.clusternetworkhighprofcount; 
		self.ProfClsterNetwHighProfFlipCt_1            	:= le.prof1_cluster.clusternetworkhighprofflipcount;
		self.ProfClusterRiskIndex_1                     := le.prof1_cluster.ClusterRiskIndex ;


		
		self.ProfLicenseStatus_2            						:= le.prof2_cluster.licensestatus   ; 
    self.ProfTransactionCt_2            						:= le.prof2_cluster.transactionscount ;
		self.ProfFlipCt_2            										:= le.prof2_cluster.flipcount ; 
		self.ProfHighProfCt_2            								:= le.prof2_cluster.highprofcount  ; 
		self.ProfDefaultCt_2            								:= le.prof2_cluster.defaultcount ; 
		self.ProfForeclosureCt_2            						:= le.prof2_cluster.foreclosurecount; 
		self.ProfDefaultOrForeclosureCt_2           		:= le.prof2_cluster.defaultorforeclosurecount; 
		self.ProfNetwCt_2            										:= le.prof2_cluster.networkcount ; 
		self.ProfNetwFlipCt_2            								:= le.prof2_cluster.networkflipcount; 
		self.ProfNetwHighProfCt_2            						:= le.prof2_cluster.networkhighprofitcount; 
		self.ProfHighRiskFlipNetw_2            					:= le.prof2_cluster.highriskflipnetwork ; 
		self.ProfHighRiskForeclosureNetw_2            	:= le.prof2_cluster.highriskforeclosurenetwork ; 
		self.ProfRiskIndex_2                          	:= le.prof2_cluster.ProfRiskIndex ;
		self.ProfClusterTransferCt_2            				:= le.prof2_cluster.clustertransfercount ; 
		self.ProfClusterFlipCt_2            						:=   le.prof2_cluster.clusterflipcount ; 
		self.ProfClusterFlopCt_2            						:= le.prof2_cluster.clusterflopcount ; 
		self.ProfClusterBusFlipCt_2            					:=  le.prof2_cluster.clusterbusflipcount; 
		self.ProfClusterHighProfCt_2            				:= le.prof2_cluster.clusterhighprofcount ; 
		self.ProfClusterDefaultCt_2            					:= le.prof2_cluster.clusterdefaultcount ; 
		self.ProfClusterForeclosureCt_2            			:= le.prof2_cluster.clusterforeclosurecount ; 
		self.ProfClsterDefOrForeclosureCt_2            	:= le.prof2_cluster.clusterdeforforeclosurecount; 
		self.ProfClusterNetwTransferCt_2            		:= le.prof2_cluster.clusternetworktransfercount; 
		self.ProfClusterNetwFlipCt_2            				:= le.prof2_cluster.clusternetworkflipcount; 
		self.ProfClusterNetwFlopCt_2            				:=  le.prof2_cluster.clusternetworkflopcount; 
		self.ProfClsterNetwBusFlipCt_2            			:= le.prof2_cluster.clusternetworkbusflipcount; 
		self.ProfClsterNetwHighProfCt_2            			:= le.prof2_cluster.clusternetworkhighprofcount; 
		self.ProfClsterNetwHighProfFlipCt_2            	:= le.prof2_cluster.clusternetworkhighprofflipcount;
		self.ProfClusterRiskIndex_2                    := le.prof2_cluster.ClusterRiskIndex ;


		self.ProfLicenseStatus_3            						:= le.prof3_cluster.licensestatus   ; 
		self.ProfTransactionCt_3            					:= le.prof3_cluster.transactionscount ; 
		self.ProfFlipCt_3            									:= le.prof3_cluster.flipcount ; 
		self.ProfHighProfCt_3            							:= le.prof3_cluster.highprofcount  ; 
		self.ProfDefaultCt_3            							:= le.prof3_cluster.defaultcount ; 
		self.ProfForeclosureCt_3            					:= le.prof3_cluster.foreclosurecount; 
		self.ProfDefaultOrForeclosureCt_3           	:= le.prof3_cluster.defaultorforeclosurecount; 
		self.ProfNetwCt_3            									:= le.prof3_cluster.networkcount ; 
		self.ProfNetwFlipCt_3            							:= le.prof3_cluster.networkflipcount; 
		self.ProfNetwHighProfCt_3            					:= le.prof3_cluster.networkhighprofitcount; 
		self.ProfHighRiskFlipNetw_3           				:= le.prof3_cluster.highriskflipnetwork ; 
		self.ProfHighRiskForeclosureNetw_3            := le.prof3_cluster.highriskforeclosurenetwork ; 
		self.ProfRiskIndex_3                          := le.prof3_cluster.ProfRiskIndex ;
		self.ProfClusterTransferCt_3            			:= le.prof3_cluster.clustertransfercount ; 
		self.ProfClusterFlipCt_3            					:=  le.prof3_cluster.clusterflipcount ; 
		self.ProfClusterFlopCt_3            					:= le.prof3_cluster.clusterflopcount ; 
		self.ProfClusterBusFlipCt_3            				:=  le.prof3_cluster.clusterbusflipcount; 
		self.ProfClusterHighProfCt_3            			:= le.prof3_cluster.clusterhighprofcount ; 
		self.ProfClusterDefaultCt_3            				:= le.prof3_cluster.clusterdefaultcount ; 
		self.ProfClusterForeclosureCt_3            		:= le.prof3_cluster.clusterforeclosurecount ; 
		self.ProfClsterDefOrForeclosureCt_3           := le.prof3_cluster.clusterdeforforeclosurecount; 
		self.ProfClusterNetwTransferCt_3            	:= le.prof3_cluster.clusternetworktransfercount; 
		self.ProfClusterNetwFlipCt_3            			:= le.prof3_cluster.clusternetworkflipcount; 
		self.ProfClusterNetwFlopCt_3            			:=  le.prof3_cluster.clusternetworkflopcount; 
		self.ProfClsterNetwBusFlipCt_3            		:= le.prof3_cluster.clusternetworkbusflipcount; 
		self.ProfClsterNetwHighProfCt_3            		:= le.prof3_cluster.clusternetworkhighprofcount; 
		self.ProfClsterNetwHighProfFlipCt_3            	:= le.prof3_cluster.clusternetworkhighprofflipcount; 
		self.ProfClusterRiskIndex_3                    := le.prof3_cluster.ClusterRiskIndex ;
		self 																						:= ri;

END;


flat_results_valid := join(results_valid , valid_inputs , left.acctno = right.acctno,
											flatten_results(left,right));


all_results :=  (flat_results_valid +  invalid_inputs_defaults );
final := sort(ungroup(all_results), acctno);

// output(withPropertyStats, named('withPropertyStats'));
// output(sorted_property_stats, named('sorted_property_stats'));
// output(deduped_property_stats, named('deduped_property_stats'));
// output(cluster_attrib, named('cluster_attrib'));

return final;

END;