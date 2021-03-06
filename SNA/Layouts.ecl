EXPORT Layouts := MODULE
  export Layout_PersonToPerson := record
    unsigned seq;
    unsigned8 person1; // the 'left' person on input
    unsigned8 person2; // the 'right' person on input
    unsigned8 associate;
    real4 associate_degree1;
    real4 associate_degree2;

    qstring10    prim_range;
    qstring28    prim_name;
    qstring8     sec_range;
    qstring5     zip;
    unsigned1    shared_did_count;
    real4        best_combined_degree;
    unsigned1    connected_associate_paths;
  end;

 Export  cluster_stat_input := Record
		unsigned6 did;
		integer   seq;
		integer history_date;
		string30 recordlabel;
 END;
 
  export Layout_PersonToPerson3 := record
    unsigned seq;
    // these attributes relate to the input individuals, but not to the intersection of their clusters.
    // they're more "person attributes" than "person-to-person attributes"
      unsigned8 Person1; // the 'left' person on input
      unsigned2 TotalCnt1;
      unsigned2 FirstDegrees1;
      unsigned2 SecondDegrees1;
      real4 Cohesivity1;

      unsigned8 Person2; // the 'right' person on input
      unsigned2 TotalCnt2;
      unsigned2 FirstDegrees2;
      unsigned2 SecondDegrees2;
      real4 Cohesivity2;
    //
    
    // attributes relating to the intersection between two persons' clusters:
    unsigned8    connected_associate1;
    unsigned1    connected_associate1_paths;
    unsigned8    connected_associate2;
    unsigned1    connected_associate2_paths;
    unsigned8    connected_associate3;
    unsigned1    connected_associate3_paths;

    qstring10    prim_range1;
    qstring28    prim_name1;
    qstring8     sec_range1;
    qstring5     zip1;
    unsigned1    shared_did_count1;
    real4        best_combined_degree1;

    qstring10    prim_range2;
    qstring28    prim_name2;
    qstring8     sec_range2;
    qstring5     zip2;
    unsigned1    shared_did_count2;
    real4        best_combined_degree2;

    qstring10    prim_range3;
    qstring28    prim_name3;
    qstring8     sec_range3;
    qstring5     zip3;
    unsigned1    shared_did_count3;
    real4        best_combined_degree3;

  end;
	
export mortgage_collusion_input := record
		unsigned1 	transaction_seq;  // number from 1-100
	  unsigned1  	input_seq; // number from 1-10, this will be used for normalizing the input record into up to 10 records
		unsigned2 	seq;  // transaction_seq * input_seq, to generate unique seq in DID append function
		
		string30  AcctNo;  // echo back for batch linking
		string120 StreetAddress;  
		string25  City;
		string2   St;
		string5   Zip;

		string30  Buyer1_First_Name;
		string30  Buyer1_Middle_Name;
		string30  Buyer1_Last_Name;
		string9   Buyer1_SSN;
		string8   Buyer1_DateOfBirth;
		string120 Buyer1_StreetAddress;
		string25  Buyer1_City;
		string2   Buyer1_St;
		string5   Buyer1_Zip;
		
		string30  Buyer2_First_Name;
		string30  Buyer2_Middle_Name;
		string30  Buyer2_Last_Name;
		string9   Buyer2_SSN;
		string8   Buyer2_DateOfBirth;
		string120 Buyer2_StreetAddress;
		string25  Buyer2_City;
		string2   Buyer2_St;
		string5   Buyer2_Zip;
		
		string30  Buyer3_First_Name;
		string30  Buyer3_Middle_Name;
		string30  Buyer3_Last_Name;
		string9   Buyer3_SSN;
		string8   Buyer3_DateOfBirth;
		string120 Buyer3_StreetAddress;
		string25  Buyer3_City;
		string2   Buyer3_St;
		string5   Buyer3_Zip;
	
		string30  Seller1_First_Name;
		string30  Seller1_Middle_Name;
		string30  Seller1_Last_Name;
		string9   Seller1_SSN;
		string8   Seller1_DateOfBirth;
		string120 Seller1_StreetAddress;
		string25  Seller1_City;
		string2   Seller1_St;
		string5   Seller1_Zip;
		
		string30  Seller2_First_Name;
		string30  Seller2_Middle_Name;
		string30  Seller2_Last_Name;
		string9   Seller2_SSN;
		string8   Seller2_DateOfBirth;
		string120 Seller2_StreetAddress;
		string25  Seller2_City;
		string2   Seller2_St;
		string5   Seller2_Zip;
		
		string30  Seller3_First_Name;
		string30  Seller3_Middle_Name;
		string30  Seller3_Last_Name;
		string9   Seller3_SSN;
		string8   Seller3_DateOfBirth;
		string120 Seller3_StreetAddress;
		string25  Seller3_City;
		string2   Seller3_St;
		string5   Seller3_Zip;
	
		string30  Professional1_First_Name;
		string30  Professional1_Middle_Name;
		string30  Professional1_Last_Name;
		string9   Professional1_SSN;
		string8   Professional1_DateOfBirth;
		string120 Professional1_StreetAddress;
		string25  Professional1_City;
		string2   Professional1_St;
		string5   Professional1_Zip;
		string30    Professional1_License_Number;
		string10    Professional1_License_Type;
		
		string30  Professional2_First_Name;
		string30  Professional2_Middle_Name;
		string30  Professional2_Last_Name;
		string9   Professional2_SSN;
		string8   Professional2_DateOfBirth;
		string120 Professional2_StreetAddress;
		string25  Professional2_City;
		string2   Professional2_St;
		string5   Professional2_Zip;
		string30    Professional2_License_Number;       
		string10    Professional2_License_Type;         
		
		string30  Professional3_First_Name;
		string30  Professional3_Middle_Name;
		string30  Professional3_Last_Name;
		string9   Professional3_SSN;
		string8   Professional3_DateOfBirth;
		string120 Professional3_StreetAddress;
		string25  Professional3_City;
		string2   Professional3_St;
		string5   Professional3_Zip;
		string30    Professional3_License_Number;
		string10    Professional3_License_Type;
		integer   HistoryDateYYYYMM;

	end; 
	
export Layout_Cluster_Stats := RECORD
		unsigned8 cluster_id;
		unsigned3 cluster_sales_count;
		unsigned3 cluster_flip_count;
		unsigned3 cluster_flip_0_degree;
		unsigned3 cluster_flip_business_count;
		unsigned3 cluster_flop_count;
		unsigned3 cluster_flop_person_count;
		unsigned3 cluster_flop_person_busines_count;
		unsigned3 cluster_in_network_count;
		unsigned3 cluster_in_network_count_0_degree;
		unsigned3 cluster_in_network_flip_business_count;
		unsigned3 cluster_in_network_flop;
		unsigned3 cluster_in_network_flip_count;
		unsigned3 cluster_in_network_flip_count_0_degree;
		unsigned3 cluster_high_profit_count;
		unsigned3 cluster_high_profit_count_0_degree;
		unsigned3 cluster_in_network_high_profit;
		unsigned3 cluster_in_network_high_profit_0_degree;
		unsigned3 cluster_in_network_high_profit_flip_count;
		unsigned3 cluster_default_count;
		unsigned3 cluster_foreclosure_count;
		unsigned3 cluster_foreclosure_default_count_0_degree;
		unsigned3 cluster_ends_in_default_foreclosure;
		unsigned3 cluster_fha_count;
		unsigned3 cluster_va_count;
		unsigned3 cluster_suspicious_govt_loan_count;
		unsigned3 distinct_property_count;
		unsigned3 high_incidence_flip_count;
		unsigned3 high_incidence_in_network_count;
		unsigned3 high_incidence_in_network_flip_count;
		unsigned3 high_incidence_high_profit_count;
		unsigned3 high_incidence_in_network_high_profit_count;
	END;
	

  shared Layout_Prop_Cluster_Stats_v1 := record
		SNA.Key_Prop_Cluster_Stats.cluster_sales_count;
		SNA.Key_Prop_Cluster_Stats.cluster_flip_count;
		SNA.Key_Prop_Cluster_Stats.cluster_flip_count10;
		SNA.Key_Prop_Cluster_Stats.cluster_flip_count30;
		SNA.Key_Prop_Cluster_Stats.cluster_flip_count60;
		SNA.Key_Prop_Cluster_Stats.cluster_flip_count120;
		SNA.Key_Prop_Cluster_Stats.cluster_flip_count180;
		SNA.Key_Prop_Cluster_Stats.cluster_flip_0_degree;
		SNA.Key_Prop_Cluster_Stats.cluster_flip_1_degree;
		SNA.Key_Prop_Cluster_Stats.cluster_flip_2_degree;
		SNA.Key_Prop_Cluster_Stats.cluster_flip_business_count;
		SNA.Key_Prop_Cluster_Stats.cluster_flop_count;
		SNA.Key_Prop_Cluster_Stats.cluster_flop_person_count;
		SNA.Key_Prop_Cluster_Stats.cluster_flop_person_busines_count;
		SNA.Key_Prop_Cluster_Stats.cluster_in_network_count;
		SNA.Key_Prop_Cluster_Stats.cluster_in_network_count_0_degree;
		SNA.Key_Prop_Cluster_Stats.cluster_in_network_count_1_degree;
		SNA.Key_Prop_Cluster_Stats.cluster_in_network_count_2_degree;
		SNA.Key_Prop_Cluster_Stats.cluster_in_network_flip_business_count;
		SNA.Key_Prop_Cluster_Stats.cluster_in_network_flop;
		SNA.Key_Prop_Cluster_Stats.cluster_in_network_flip_count;
		SNA.Key_Prop_Cluster_Stats.cluster_in_network_flip_count_0_degree;
		SNA.Key_Prop_Cluster_Stats.cluster_in_network_flip_count_1_degree;
		SNA.Key_Prop_Cluster_Stats.cluster_in_network_flip_count_2_degree;
		SNA.Key_Prop_Cluster_Stats.cluster_high_profit_count;
		SNA.Key_Prop_Cluster_Stats.cluster_high_profit_count_0_degree;
		SNA.Key_Prop_Cluster_Stats.cluster_high_profit_count_1_degree;
		SNA.Key_Prop_Cluster_Stats.cluster_high_profit_count_2_degree;
		SNA.Key_Prop_Cluster_Stats.cluster_in_network_high_profit;
		SNA.Key_Prop_Cluster_Stats.cluster_in_network_high_profit_0_degree;
		SNA.Key_Prop_Cluster_Stats.cluster_in_network_high_profit_1_degree;
		SNA.Key_Prop_Cluster_Stats.cluster_in_network_high_profit_2_degree;
		SNA.Key_Prop_Cluster_Stats.cluster_in_network_high_profit_flip_count;
		SNA.Key_Prop_Cluster_Stats.cluster_default_count;
		SNA.Key_Prop_Cluster_Stats.cluster_foreclosure_count;
		SNA.Key_Prop_Cluster_Stats.cluster_foreclosure_default_count_0_degree;
		SNA.Key_Prop_Cluster_Stats.prop_network_cohesivity;
		SNA.Key_Prop_Cluster_Stats.prop_1st_degrees;
		SNA.Key_Prop_Cluster_Stats.prop_2nd_degrees;
		SNA.Key_Prop_Cluster_Stats.sales_count_stdd;
		SNA.Key_Prop_Cluster_Stats.flip_count_actors;
		SNA.Key_Prop_Cluster_Stats.flip_count_stdd;
		SNA.Key_Prop_Cluster_Stats.cluster_ends_in_default_foreclosure;
		SNA.Key_Prop_Cluster_Stats.cluster_fha_count;
		SNA.Key_Prop_Cluster_Stats.cluster_va_count;
		SNA.Key_Prop_Cluster_Stats.prop_people_count;
		SNA.Key_Prop_Cluster_Stats.distinct_property_count;
		SNA.Key_Prop_Cluster_Stats.high_incidence_flip_count;
		SNA.Key_Prop_Cluster_Stats.high_incidence_in_network_count;
		SNA.Key_Prop_Cluster_Stats.high_incidence_in_network_flip_count;
		SNA.Key_Prop_Cluster_Stats.high_incidence_high_profit_count;
		SNA.Key_Prop_Cluster_Stats.high_incidence_in_network_high_profit_count;
		SNA.Key_Prop_Cluster_Stats.high_incidence_in_network_high_profit_flip_count;
		// SNA.Key_Prop_Cluster_Stats.totalcnt;
		// SNA.Key_Prop_Cluster_Stats.firstdegrees;
		// SNA.Key_Prop_Cluster_Stats.seconddegrees;
		// SNA.Key_Prop_Cluster_Stats.cohesivity;
		SNA.Key_Prop_Cluster_Stats.p_city_name;
  end;
	export Layout_Attributes_v1 := record
    Layout_PersonToPerson3;
    Layout_Prop_Cluster_Stats_v1 Prop1;
    Layout_Prop_Cluster_Stats_v1 Prop2;
	end;


  export Layout_Batch_Attributes_v1 := RECORD
    string30 acctno;
    string20 person1;
    string5 totalcnt1;
    string5 firstdegrees1;
    string5 seconddegrees1;
    string6 cohesivity1;
    string20 person2;
    string5 totalcnt2;
    string5 firstdegrees2;
    string5 seconddegrees2;
    string6 cohesivity2;
    string20 connected_associate1;
    string3 connected_associate1_paths;
    string20 connected_associate2;
    string3 connected_associate2_paths;
    string20 connected_associate3;
    string3 connected_associate3_paths;
    string8 prim_range1;
    string21 prim_name1;
    string6 sec_range1;
    string4 zip1;
    string3 shared_did_count1;
    string6 best_combined_degree1;
    string8 prim_range2;
    string21 prim_name2;
    string6 sec_range2;
    string4 zip2;
    string3 shared_did_count2;
    string6 best_combined_degree2;
    string8 prim_range3;
    string21 prim_name3;
    string6 sec_range3;
    string4 zip3;
    string3 shared_did_count3;
    string6 best_combined_degree3;
    string8 prop1__cluster_sales_count;
    string8 prop1__cluster_flip_count;
    string8 prop1__cluster_flip_count10;
    string8 prop1__cluster_flip_count30;
    string8 prop1__cluster_flip_count60;
    string8 prop1__cluster_flip_count120;
    string8 prop1__cluster_flip_count180;
    string8 prop1__cluster_flip_0_degree;
    string8 prop1__cluster_flip_1_degree;
    string8 prop1__cluster_flip_2_degree;
    string8 prop1__cluster_flip_business_count;
    string8 prop1__cluster_flop_count;
    string8 prop1__cluster_flop_person_count;
    string8 prop1__cluster_flop_person_busines_count;
    string8 prop1__cluster_in_network_count;
    string8 prop1__cluster_in_network_count_0_degree;
    string8 prop1__cluster_in_network_count_1_degree;
    string8 prop1__cluster_in_network_count_2_degree;
    string8 prop1__cluster_in_network_flip_business_count;
    string8 prop1__cluster_in_network_flop;
    string8 prop1__cluster_in_network_flip_count;
    string8 prop1__cluster_in_network_flip_count_0_degree;
    string8 prop1__cluster_in_network_flip_count_1_degree;
    string8 prop1__cluster_in_network_flip_count_2_degree;
    string8 prop1__cluster_high_profit_count;
    string8 prop1__cluster_high_profit_count_0_degree;
    string8 prop1__cluster_high_profit_count_1_degree;
    string8 prop1__cluster_high_profit_count_2_degree;
    string8 prop1__cluster_in_network_high_profit;
    string8 prop1__cluster_in_network_high_profit_0_degree;
    string8 prop1__cluster_in_network_high_profit_1_degree;
    string8 prop1__cluster_in_network_high_profit_2_degree;
    string8 prop1__cluster_in_network_high_profit_flip_count;
    string8 prop1__cluster_default_count;
    string8 prop1__cluster_foreclosure_count;
    string8 prop1__cluster_foreclosure_default_count_0_degree;
    string6 prop1__prop_network_cohesivity;
    string8 prop1__prop_1st_degrees;
    string8 prop1__prop_2nd_degrees;
    string6 prop1__sales_count_stdd;
    string8 prop1__flip_count_actors;
    string6 prop1__flip_count_stdd;
    string8 prop1__cluster_ends_in_default_foreclosure;
    string8 prop1__cluster_fha_count;
    string8 prop1__cluster_va_count;
    string8 prop1__prop_people_count;
    string8 prop1__distinct_property_count;
    string8 prop1__high_incidence_flip_count;
    string8 prop1__high_incidence_in_network_count;
    string8 prop1__high_incidence_in_network_flip_count;
    string8 prop1__high_incidence_high_profit_count;
    string8 prop1__high_incidence_in_network_high_profit_count;
    string8 prop1__high_incidence_in_network_high_profit_flip_count;
    string25 prop1__p_city_name;
    string8 prop2__cluster_sales_count;
    string8 prop2__cluster_flip_count;
    string8 prop2__cluster_flip_count10;
    string8 prop2__cluster_flip_count30;
    string8 prop2__cluster_flip_count60;
    string8 prop2__cluster_flip_count120;
    string8 prop2__cluster_flip_count180;
    string8 prop2__cluster_flip_0_degree;
    string8 prop2__cluster_flip_1_degree;
    string8 prop2__cluster_flip_2_degree;
    string8 prop2__cluster_flip_business_count;
    string8 prop2__cluster_flop_count;
    string8 prop2__cluster_flop_person_count;
    string8 prop2__cluster_flop_person_busines_count;
    string8 prop2__cluster_in_network_count;
    string8 prop2__cluster_in_network_count_0_degree;
    string8 prop2__cluster_in_network_count_1_degree;
    string8 prop2__cluster_in_network_count_2_degree;
    string8 prop2__cluster_in_network_flip_business_count;
    string8 prop2__cluster_in_network_flop;
    string8 prop2__cluster_in_network_flip_count;
    string8 prop2__cluster_in_network_flip_count_0_degree;
    string8 prop2__cluster_in_network_flip_count_1_degree;
    string8 prop2__cluster_in_network_flip_count_2_degree;
    string8 prop2__cluster_high_profit_count;
    string8 prop2__cluster_high_profit_count_0_degree;
    string8 prop2__cluster_high_profit_count_1_degree;
    string8 prop2__cluster_high_profit_count_2_degree;
    string8 prop2__cluster_in_network_high_profit;
    string8 prop2__cluster_in_network_high_profit_0_degree;
    string8 prop2__cluster_in_network_high_profit_1_degree;
    string8 prop2__cluster_in_network_high_profit_2_degree;
    string8 prop2__cluster_in_network_high_profit_flip_count;
    string8 prop2__cluster_default_count;
    string8 prop2__cluster_foreclosure_count;
    string8 prop2__cluster_foreclosure_default_count_0_degree;
    string6 prop2__prop_network_cohesivity;
    string8 prop2__prop_1st_degrees;
    string8 prop2__prop_2nd_degrees;
    string6 prop2__sales_count_stdd;
    string8 prop2__flip_count_actors;
    string6 prop2__flip_count_stdd;
    string8 prop2__cluster_ends_in_default_foreclosure;
    string8 prop2__cluster_fha_count;
    string8 prop2__cluster_va_count;
    string8 prop2__prop_people_count;
    string8 prop2__distinct_property_count;
    string8 prop2__high_incidence_flip_count;
    string8 prop2__high_incidence_in_network_count;
    string8 prop2__high_incidence_in_network_flip_count;
    string8 prop2__high_incidence_high_profit_count;
    string8 prop2__high_incidence_in_network_high_profit_count;
    string8 prop2__high_incidence_in_network_high_profit_flip_count;
    string25 prop2__p_city_name;
  END;

export Layout_MortgageCollusion_Attributes_Person_v1 := record
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

END;

export Layout_MortgageCollusion_Attributes_Prof_Person_v1 := record
		string2 LicenseStatus;
	string3	TransactionsCount;
	Layout_MortgageCollusion_Attributes_Person_v1 - PropertyCount;
end;


 export mortgage_collusion_output_flat := Record
    string30  AcctNo;
		string2 PropDefaultCurrent; 				
    string2 PropDefaultEver; 						
    string2 PropDefaultEverSuspActivity; 
    string2 PropForeclosureCurrent; 		
    string2 PropForeclosureEver;					
    string2 PropForeclosureEverSuspActivity;
		string3 PropertyStatusRiskIndex;
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
    string2 PropNetwork;						
    string2 PropHighProf ;					 
    string4 PropFlipProfIndex;					
    string2 PropNetwHighProf;						
    string4 PropNetwProfIndex; 						
    string2 PropNetwFlip ; 								
    string4 PropNetwFlipProfIndex;
		string3 PropDeedRiskIndex;
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
    string3 PropertyHistoryRiskIndex;
		
		string3 BuyerPropertyCt_1;
    string3 BuyerFlipCt_1;
    string3 BuyerHighProfCt_1;
    string3 BuyerDefaultCt_1;
    string3 BuyerForeclosureCt_1;
    string3 BuyerDefaultOrForeclosureCt_1;
    string3 BuyerNetwCt_1;
    string3 BuyerNetwFlipCt_1;
    string3 BuyerNetwHighProfCt_1;
    string2 BuyerHighRiskFlipNetw_1;    
    string2 BuyerHighRiskForeclosureNetw_1;
		string3 BuyerRiskIndex_1;
    string3 BuyerClusterTransferCt_1;
    string3 BuyerClusterFlipCt_1;
    string3 BuyerClusterFlopCt_1;
    string3 BuyerClusterBusFlipCt_1;
    string3 BuyerClusterHighProfCt_1;
    string3 BuyerClusterDefaultCt_1;
    string3 BuyerClusterForeclosureCt_1;
    string3 BuyerClsterDefOrForeclosureCt_1;
    string3 BuyerClusterNetwTransferCt_1;
    string3 BuyerClusterNetwFlipCt_1;
    string3 BuyerClusterNetwFlopCt_1;
    string3 BuyerClsterNetwBusFlipCt_1;
    string3 BuyerClsterNetwHighProfCt_1;
    string3 BuyerClsterNetwHighProfFlipCt_1;
		string3 BuyerClusterRiskIndex_1;
		
		string3 SellerPropertyCt_1;
    string3 SellerFlipCt_1;
    string3 SellerHighProfCt_1;
    string3 SellerDefaultCt_1;
    string3 SellerForeclosureCt_1;
    string3 SellerDefaultOrForeclosureCt_1;
    string3 SellerNetwCt_1;
    string3 SellerNetwFlipCt_1;
    string3 SellerNetwHighProfCt_1;
    string2 SellerHighRiskFlipNetw_1;
    string2 SellerHighRiskForeclosureNetw_1;
		string3 SellerRiskIndex_1;
    string3 SellerClusterTransferCt_1;
    string3 SellerClusterFlipCt_1;
    string3 SellerClusterFlopCt_1;
    string3 SellerClusterBusFlipCt_1;
    string3 SellerClusterHighProfCt_1;
    string3 SellerClusterDefaultCt_1;
    string3 SellerClusterForeclosureCt_1;
    string3 SellerClsterDefOrForeclosureCt_1;
    string3 SellerClusterNetwTransferCt_1;
    string3 SellerClusterNetwFlipCt_1;
    string3 SellerClusterNetwFlopCt_1;
    string3 SellerClsterNetwBusFlipCt_1;
    string3 SellerClsterNetwHighProfCt_1;
    string3 SellerClsterNetwHighProfFlipCt_1;
		string3 SellerClusterRiskIndex_1;
		
		
		
		string3 BuyerPropertyCt_2;
    string3 BuyerFlipCt_2;
    string3 BuyerHighProfCt_2;
    string3 BuyerDefaultCt_2;
    string3 BuyerForeclosureCt_2;
    string3 BuyerDefaultOrForeclosureCt_2;
    string3 BuyerNetwCt_2;
    string3 BuyerNetwFlipCt_2;
    string3 BuyerNetwHighProfCt_2;
    string2 BuyerHighRiskFlipNetw_2;
    string2 BuyerHighRiskForeclosureNetw_2;
		string3 BuyerRiskIndex_2;
    string3 BuyerClusterTransferCt_2;
    string3 BuyerClusterFlipCt_2;
    string3 BuyerClusterFlopCt_2;
    string3 BuyerClusterBusFlipCt_2;
    string3 BuyerClusterHighProfCt_2;
    string3 BuyerClusterDefaultCt_2;
    string3 BuyerClusterForeclosureCt_2;
    string3 BuyerClsterDefOrForeclosureCt_2;
    string3 BuyerClusterNetwTransferCt_2;
    string3 BuyerClusterNetwFlipCt_2;
    string3 BuyerClusterNetwFlopCt_2;
    string3 BuyerClsterNetwBusFlipCt_2;
    string3 BuyerClsterNetwHighProfCt_2;
    string3 BuyerClsterNetwHighProfFlipCt_2;
		string3 BuyerClusterRiskIndex_2;
		
		string3 SellerPropertyCt_2;
    string3 SellerFlipCt_2;
    string3 SellerHighProfCt_2;
    string3 SellerDefaultCt_2;
    string3 SellerForeclosureCt_2;
    string3 SellerDefaultOrForeclosureCt_2;
    string3 SellerNetwCt_2;
    string3 SellerNetwFlipCt_2;
    string3 SellerNetwHighProfCt_2;
    string2 SellerHighRiskFlipNetw_2;
    string2 SellerHighRiskForeclosureNetw_2;
		string3 SellerRiskIndex_2;
    string3 SellerClusterTransferCt_2;
    string3 SellerClusterFlipCt_2;
    string3 SellerClusterFlopCt_2;
    string3 SellerClusterBusFlipCt_2;
    string3 SellerClusterHighProfCt_2;
    string3 SellerClusterDefaultCt_2;
    string3 SellerClusterForeclosureCt_2;
    string3 SellerClsterDefOrForeclosureCt_2;
    string3 SellerClusterNetwTransferCt_2;
    string3 SellerClusterNetwFlipCt_2;
    string3 SellerClusterNetwFlopCt_2;
    string3 SellerClsterNetwBusFlipCt_2;
    string3 SellerClsterNetwHighProfCt_2;
    string3 SellerClsterNetwHighProfFlipCt_2;
		string3 SellerClusterRiskIndex_2;
		
		
		string3 BuyerPropertyCt_3;
    string3 BuyerFlipCt_3;
    string3 BuyerHighProfCt_3;
    string3 BuyerDefaultCt_3;
    string3 BuyerForeclosureCt_3;
    string3 BuyerDefaultOrForeclosureCt_3;
    string3 BuyerNetwCt_3;
    string3 BuyerNetwFlipCt_3;
    string3 BuyerNetwHighProfCt_3;
    string2 BuyerHighRiskFlipNetw_3;
    string2 BuyerHighRiskForeclosureNetw_3;
		string3 BuyerRiskIndex_3;
    string3 BuyerClusterTransferCt_3;
    string3 BuyerClusterFlipCt_3;
    string3 BuyerClusterFlopCt_3;
    string3 BuyerClusterBusFlipCt_3;
    string3 BuyerClusterHighProfCt_3;
    string3 BuyerClusterDefaultCt_3;
    string3 BuyerClusterForeclosureCt_3;
    string3 BuyerClsterDefOrForeclosureCt_3;
    string3 BuyerClusterNetwTransferCt_3;
    string3 BuyerClusterNetwFlipCt_3;
    string3 BuyerClusterNetwFlopCt_3;
    string3 BuyerClsterNetwBusFlipCt_3;
    string3 BuyerClsterNetwHighProfCt_3;
    string3 BuyerClsterNetwHighProfFlipCt_3;
		string3 BuyerClusterRiskIndex_3;
		
		string3 SellerPropertyCt_3;
    string3 SellerFlipCt_3;
    string3 SellerHighProfCt_3;
    string3 SellerDefaultCt_3;
    string3 SellerForeclosureCt_3;
    string3 SellerDefaultOrForeclosureCt_3;
    string3 SellerNetwCt_3;
    string3 SellerNetwFlipCt_3;
    string3 SellerNetwHighProfCt_3;
    string2 SellerHighRiskFlipNetw_3;
    string2 SellerHighRiskForeclosureNetw_3;
		string3 SellerRiskIndex_3;
    string3 SellerClusterTransferCt_3;
    string3 SellerClusterFlipCt_3;
    string3 SellerClusterFlopCt_3;
    string3 SellerClusterBusFlipCt_3;
    string3 SellerClusterHighProfCt_3;
    string3 SellerClusterDefaultCt_3;
    string3 SellerClusterForeclosureCt_3;
    string3 SellerClsterDefOrForeclosureCt_3;
    string3 SellerClusterNetwTransferCt_3;
    string3 SellerClusterNetwFlipCt_3;
    string3 SellerClusterNetwFlopCt_3;
    string3 SellerClsterNetwBusFlipCt_3;
    string3 SellerClsterNetwHighProfCt_3;
    string3 SellerClsterNetwHighProfFlipCt_3;
		string3 SellerClusterRiskIndex_3;
		
		string3 ProfLicenseStatus_1;
    string8 ProfTransactionCt_1;
		string5 ProfFlipCt_1;
    string5 ProfHighProfCt_1;
    string5 ProfDefaultCt_1;
    string5 ProfForeclosureCt_1;
    string5 ProfDefaultOrForeclosureCt_1;
    string5 ProfNetwCt_1;
    string5 ProfNetwFlipCt_1;
    string5 ProfNetwHighProfCt_1;
    string2 ProfHighRiskFlipNetw_1;
    string2 ProfHighRiskForeclosureNetw_1;
		string3 ProfRiskIndex_1;
    string5 ProfClusterTransferCt_1;
    string5 ProfClusterFlipCt_1;
    string5 ProfClusterFlopCt_1;
    string5 ProfClusterBusFlipCt_1;
    string5 ProfClusterHighProfCt_1;
    string5 ProfClusterDefaultCt_1;
    string5 ProfClusterForeclosureCt_1;
    string5 ProfClsterDefOrForeclosureCt_1;
    string5 ProfClusterNetwTransferCt_1;
    string5 ProfClusterNetwFlipCt_1;
    string5 ProfClusterNetwFlopCt_1;
    string5 ProfClsterNetwBusFlipCt_1;
    string5 ProfClsterNetwHighProfCt_1;
    string5 ProfClsterNetwHighProfFlipCt_1;
		string3 ProfClusterRiskIndex_1;
		
		string3 ProfLicenseStatus_2;
    string8 ProfTransactionCt_2;
    string5 ProfFlipCt_2;
    string5 ProfHighProfCt_2;
    string5 ProfDefaultCt_2;
    string5 ProfForeclosureCt_2;
    string5 ProfDefaultOrForeclosureCt_2;
    string5 ProfNetwCt_2;
    string5 ProfNetwFlipCt_2;
    string5 ProfNetwHighProfCt_2;
    string2 ProfHighRiskFlipNetw_2;
    string2 ProfHighRiskForeclosureNetw_2;
		string3 ProfRiskIndex_2;
    string5 ProfClusterTransferCt_2;
    string5 ProfClusterFlipCt_2;
    string5 ProfClusterFlopCt_2;
    string5 ProfClusterBusFlipCt_2;
    string5 ProfClusterHighProfCt_2;
    string5 ProfClusterDefaultCt_2;
    string5 ProfClusterForeclosureCt_2;
    string5 ProfClsterDefOrForeclosureCt_2;
    string5 ProfClusterNetwTransferCt_2;
    string5 ProfClusterNetwFlipCt_2;
    string5 ProfClusterNetwFlopCt_2;
    string5 ProfClsterNetwBusFlipCt_2;
    string5 ProfClsterNetwHighProfCt_2;
    string5 ProfClsterNetwHighProfFlipCt_2;
		string3 ProfClusterRiskIndex_2;

		string3 ProfLicenseStatus_3;
    string8 ProfTransactionCt_3;
    string5 ProfFlipCt_3;
    string5 ProfHighProfCt_3;
    string5 ProfDefaultCt_3;
    string5 ProfForeclosureCt_3;
    string5 ProfDefaultOrForeclosureCt_3;
    string5 ProfNetwCt_3;
    string5 ProfNetwFlipCt_3;
    string5 ProfNetwHighProfCt_3;
    string2 ProfHighRiskFlipNetw_3;
    string2 ProfHighRiskForeclosureNetw_3;
		string3 ProfRiskIndex_3;
    string5 ProfClusterTransferCt_3;
    string5 ProfClusterFlipCt_3;
    string5 ProfClusterFlopCt_3;
    string5 ProfClusterBusFlipCt_3;
    string5 ProfClusterHighProfCt_3;
    string5 ProfClusterDefaultCt_3;
    string5 ProfClusterForeclosureCt_3;
    string5 ProfClsterDefOrForeclosureCt_3;
    string5 ProfClusterNetwTransferCt_3;
    string5 ProfClusterNetwFlipCt_3;
    string5 ProfClusterNetwFlopCt_3;
    string5 ProfClsterNetwBusFlipCt_3;
    string5 ProfClsterNetwHighProfCt_3;
    string5 ProfClsterNetwHighProfFlipCt_3;
		string3 ProfClusterRiskIndex_3;

 end;
 
 export mortgage_collusion_output := Record
		string30 acctno;
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
    string2 PropNetwork;						
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
		string3 PropertyStatusRiskIndex;
    string3 PropDeedRiskIndex;
    string3 PropertyHistoryRiskIndex;
		Layout_MortgageCollusion_Attributes_Person_v1 - seq - did Buyer1_cluster;
		Layout_MortgageCollusion_Attributes_Person_v1 - seq - did Seller1_cluster;
		Layout_MortgageCollusion_Attributes_Person_v1 - seq - did Buyer2_cluster;
		Layout_MortgageCollusion_Attributes_Person_v1 - seq - did Seller2_cluster;
		Layout_MortgageCollusion_Attributes_Person_v1 - seq - did Buyer3_cluster;
		Layout_MortgageCollusion_Attributes_Person_v1 - seq - did Seller3_cluster;
		Layout_MortgageCollusion_Attributes_Prof_Person_v1 - seq - did Prof1_cluster;
		Layout_MortgageCollusion_Attributes_Prof_Person_v1 - seq - did Prof2_cluster;
		Layout_MortgageCollusion_Attributes_Prof_Person_v1 - seq - did Prof3_cluster;
	END;
 


END;