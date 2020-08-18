IMPORT ut;

EXPORT Consts :=
MODULE

	EXPORT max_phones			:= 10;
	EXPORT max_hri_ssn		:= 20;
	EXPORT max_hri_addr		:= 50;
	EXPORT max_hri_phone	:= 50;
	EXPORT max_buyers			:= 2;
	EXPORT max_sellers		:= 2;
	EXPORT max_warnings		:= 3;
	EXPORT max_rids				:= 100;
	EXPORT max_rels			  := 100;
	EXPORT max_assocs			:= 200;
	EXPORT max_transact		:= 35;
	EXPORT max_header     := 400;
	// Need to go back 20 years to calculate average sales price
	EXPORT max_zip        := 252; //20*12 + 12 months (since month isn't rollable)

	EXPORT SearchByAutoKeys := FALSE;
	
	EXPORT MaxFaresIDs    := 100;
	EXPORT MaxProperties  := 1000;
	EXPORT MaxAssessments := 100;
	EXPORT MaxClusterAttr := 100;
	
	EXPORT VendorSource :=
	MODULE
		EXPORT setFares          := ['F','S'];
		EXPORT setOkcty          := ['O','D'];
		EXPORT Okcty             := 'OKCTY';
		EXPORT Dayton            := 'DAYTN';
		EXPORT Fares             := 'FAR_F';
		EXPORT FaresSupplemental := 'FAR_S';
	END;
	
	EXPORT RecordType := ENUM(INTEGER1,Suppress = -1,Duplicate = 0,Display = 1);
	
	EXPORT FaresCodes :=
	MODULE
		EXPORT Deed             := 'D';
		EXPORT Mortgage         := 'M';
	END;
	
	EXPORT Debug :=
	MODULE
		EXPORT FaresId                 := FALSE;
		EXPORT AddressHRI              := FALSE;
		EXPORT Assessments             := FALSE;
		EXPORT Deeds                   := FALSE;
		EXPORT CodesV3                 := FALSE;
		EXPORT CurrentResidents        := FALSE;
		EXPORT HistoricalZipSalesPrice := FALSE;
		EXPORT Main                    := FALSE;
	END;
	
	EXPORT AdvoRiskCodes :=
	MODULE
		EXPORT UNSIGNED2 ADVO_VACANT           := 2500; // Address is reported as vacant
		EXPORT UNSIGNED2 ADVO_VACANT_PO        := 2501; // Same as ADVO_VACANT, only for PO Boxes
		EXPORT UNSIGNED2 ADVO_SEASONAL         := 2502; // Address is a seasonal address
		EXPORT UNSIGNED2 ADVO_COLLEGE          := 2503; // Address is College
		EXPORT UNSIGNED2 ADVO_CMRA             := 2504; // Address is a Commercial Mail Receiving Agency (CMRA)
		EXPORT UNSIGNED2 ADVO_IDA              := 2505; // Internal Drop Address (IDA)

		// ADVO address type
		EXPORT UNSIGNED2 ADVO_RESIDENTIAL      := 2506;
		EXPORT UNSIGNED2 ADVO_BUSINESS         := 2507;
		EXPORT UNSIGNED2 ADVO_RESIDENTIAL_PRIM := 2508; //primarily residential with a possible business
		EXPORT UNSIGNED2 ADVO_BUSINESS_PRIM    := 2509; //primarily business with a possible residence
		
		// Advo mixed address usage
		EXPORT UNSIGNED2 ADVO_CALLER           := 2510; //Caller Service Box
		EXPORT UNSIGNED2 ADVO_CONTEST          := 2511; //Contest Box
		EXPORT UNSIGNED2 ADVO_CONTRACT         := 2512; //Contract Box
		EXPORT UNSIGNED2 ADVO_GENERAL          := 2513; //General Delivery
		EXPORT UNSIGNED2 ADVO_NPU              := 2514; //Non-personnel unit
		EXPORT UNSIGNED2 ADVO_POBOX            := 2515; //P.O.Box
		EXPORT UNSIGNED2 ADVO_REMITTANCE       := 2516; //Remittance Box

		EXPORT UNSIGNED2 ADVO_CURB             := 2517;
		EXPORT UNSIGNED2 ADVO_NDCBU            := 2518;
		EXPORT UNSIGNED2 ADVO_CENTRAL          := 2519;
		EXPORT UNSIGNED2 ADVO_OTHER            := 2520;
		EXPORT UNSIGNED2 ADVO_FACILITY         := 2521;
		EXPORT UNSIGNED2 ADVO_DETACHED         := 2522;
		
		// Advo Record type
		EXPORT UNSIGNED2 ADVO_FIRM             := 2523;
		EXPORT UNSIGNED2 ADVO_HIGHRISE         := 2524;
		// RESERVED FOR LATER USE
		// EXPORT UNSIGNED2 ADVO_RURAL_ROUTE      := 2525;
		// EXPORT UNSIGNED2 ADVO_STEET            := 2526;
	END;
	
	// Mortgage Collusion attributes
	EXPORT CollusionAttributes :=
		DATASET([
						// Risk index indicators for buyer (T001 - T020)
						{'RISK_INDEX',TRUE,0,'No deed transfers on record for this buyer','T001'},
						{'RISK_INDEX',TRUE,1,'Buyer deed transfer history has no unusual conditions','T002'},
						{'RISK_INDEX',TRUE,2,'Buyer has sold multiple properties for high profit','T003'},
						{'RISK_INDEX',TRUE,3,'Buyer has flipped multiple properties for a profit','T004'},
						{'RISK_INDEX',TRUE,4,'Buyer has flipped multiple properties in-network','T005'},
						{'RISK_INDEX',TRUE,5,'Buyer has flipped multiple properties in-network for high profit','T006'},
						{'RISK_INDEX',TRUE,6,'Buyer involved in deed transfers ending in default or foreclosure','T007'},
						// {'RISK_INDEX',TRUE,7,'Buyer is a member of a suspicious flipping network','T008'},
						// {'RISK_INDEX',TRUE,8,'Buyer is a member of a suspicious foreclosure network','T009'},
						{'RISK_INDEX',TRUE,9,'Buyer involved in multiple deed transfers ending in default or foreclosure','T010'},
						// Risk index indicators for seller (T021 - T040)
						{'RISK_INDEX',FALSE,0,'No deed transfers on record for this seller','T021'},
						{'RISK_INDEX',FALSE,1,'Seller deed transfer history has no unusual conditions','T022'},
						{'RISK_INDEX',FALSE,2,'Seller has sold multiple properties for high profit','T023'},
						{'RISK_INDEX',FALSE,3,'Seller has flipped multiple properties for a profit','T024'},
						{'RISK_INDEX',FALSE,4,'Seller has flipped multiple properties in-network','T025'},
						{'RISK_INDEX',FALSE,5,'Seller has flipped multiple properties in-network for high profit','T026'},
						{'RISK_INDEX',FALSE,6,'Seller involved in deed transfers ending in default or foreclosure','T027'},
						// {'RISK_INDEX',FALSE,7,'Seller is a member of a suspicious flipping network','T028'},
						// {'RISK_INDEX',FALSE,8,'Seller is a member of a suspicious foreclosure network','T029'},
						{'RISK_INDEX',FALSE,9,'Seller involved in multiple deed transfers ending in default or foreclosure','T030'},
						// Cluster risk index indicators for buyer's cluster (T041 - T060)
						{'CLUSTER_RISK_INDEX',TRUE,0,'No deed transfers on record for this buyer\'s cluster','T041'},
						{'CLUSTER_RISK_INDEX',TRUE,1,'Buyer cluster has no deed transfers with unusual conditions','T042'},
						// {'CLUSTER_RISK_INDEX',TRUE,2,'Buyer cluster had 2+ business flips','T043'},
						// {'CLUSTER_RISK_INDEX',TRUE,3,'Buyer cluster had 2+ property flips','T044'},
						// {'CLUSTER_RISK_INDEX',TRUE,4,'Buyer cluster had 2+ property flops','T045'},
						// {'CLUSTER_RISK_INDEX',TRUE,5,'Buyer cluster has 2+ high-profit, in-network transfers','T046'},
						// {'CLUSTER_RISK_INDEX',TRUE,6,'Buyer cluster has 2+ high-profit, in-network flips','T047'},
						{'CLUSTER_RISK_INDEX',TRUE,7,'Buyer cluster has 5+ in-network flips or flops','T048'},
						// {'CLUSTER_RISK_INDEX',TRUE,8,'Buyer cluster had 2+ deed transfers ending in default or foreclosure','T049'},
						{'CLUSTER_RISK_INDEX',TRUE,9,'Buyer cluster had 5+ deed transfers ending in default or foreclosure','T050'},
						// Cluster risk index indicators for seller's cluster (T061 - T080)
						{'CLUSTER_RISK_INDEX',FALSE,0,'No deed transfers on record for this seller\'s cluster','T061'},
						{'CLUSTER_RISK_INDEX',FALSE,1,'Seller cluster has no deed transfers with unusual conditions','T062'},
						// {'CLUSTER_RISK_INDEX',FALSE,2,'Seller cluster had 2+ business flips','T063'},
						// {'CLUSTER_RISK_INDEX',FALSE,3,'Seller cluster had 2+ property flips','T064'},
						// {'CLUSTER_RISK_INDEX',FALSE,4,'Seller cluster had 2+ property flops','T065'},
						// {'CLUSTER_RISK_INDEX',FALSE,5,'Seller cluster has 2+ high-profit, in-network transfers','T066'},
						// {'CLUSTER_RISK_INDEX',FALSE,6,'Seller cluster has 2+ high-profit, in-network flips','T067'},
						{'CLUSTER_RISK_INDEX',FALSE,7,'Seller cluster has 5+ in-network flips or flops','T068'},
						// {'CLUSTER_RISK_INDEX',FALSE,8,'Seller cluster had 2+ deed transfers ending in default or foreclosure','T069'},
						{'CLUSTER_RISK_INDEX',FALSE,9,'Seller cluster had 5+ deed transfers ending in default or foreclosure','T070'},
						// Property status risk index indicators (T071 - T090)
						{'PROP_STATUS_RISK_INDEX',FALSE,1,'No records found indicating property has been in default or foreclosure','T071'},
						{'PROP_STATUS_RISK_INDEX',FALSE,2,'Property has been in default','T072'},
						{'PROP_STATUS_RISK_INDEX',FALSE,3,'Property has been in foreclosure','T073'},
						{'PROP_STATUS_RISK_INDEX',FALSE,4,'Property has been in default and in foreclosure','T074'},
						{'PROP_STATUS_RISK_INDEX',FALSE,5,'Property has been in default with suspicious characteristics','T075'},
						{'PROP_STATUS_RISK_INDEX',FALSE,6,'Property has been in foreclosure with suspicious characteristics','T076'},
						{'PROP_STATUS_RISK_INDEX',FALSE,7,'Property has been in default and in foreclosure with suspicious characteristics','T077'},
						{'PROP_STATUS_RISK_INDEX',FALSE,8,'Property is currently in default','T078'},
						{'PROP_STATUS_RISK_INDEX',FALSE,9,'Property is currently in foreclosure','T079'},
						// Property history risk index indicators (T091 - T110)
						{'PROP_HIST_RISK_INDEX',FALSE,1,'Property deed transfer history has no unusual conditions','T091'},
						{'PROP_HIST_RISK_INDEX',FALSE,2,'Property has been transferred in-network multiple times','T092'},
						{'PROP_HIST_RISK_INDEX',FALSE,3,'Property has been transferred with suspicious characteristics multiple times','T093'},
						{'PROP_HIST_RISK_INDEX',FALSE,4,'Property has been transferred multiple times in-network for high profit','T094'},
						{'PROP_HIST_RISK_INDEX',FALSE,5,'Property has been flipped in-network multiple times','T095'},
						{'PROP_HIST_RISK_INDEX',FALSE,6,'Property has been flipped for high profit multiple times','T096'},
						{'PROP_HIST_RISK_INDEX',FALSE,7,'Property has been involved in multiple in-network business transfers','T097'},
						{'PROP_HIST_RISK_INDEX',FALSE,8,'Property has been flipped or flopped more than 5 times combined','T098'},
						{'PROP_HIST_RISK_INDEX',FALSE,9,'Property has been flipped in-network multiple times for high profit','T099'},
						// Transaction level risk indicators
						{'FLIP',FALSE,1,'Flip','T111'},
						{'FLOP',FALSE,1,'Flop','T112'},
						{'IN_NETWORK',FALSE,1,'In-Network','T113'},
						{'HIGH_PROFIT',FALSE,1,'High-Profit','T114'},
						{'HIGH_PROFIT_FLIP',FALSE,1,'High-Profit Flip/Flop','T115'},
						{'IN_NETWORK_FLIP',FALSE,1,'In-Network Flip/Flop','T116'},
						{'IN_NETWORK_HIGH_PROFIT',FALSE,1,'In-Network High-Profit','T117'},
						{'IN_NETWORK_HIGH_PROFIT_FLIP',FALSE,1,'In-Network High-Profit Flip/Flop','T118'}],
					{STRING30 Attribute,BOOLEAN isBuyer,INTEGER1 Code,STRING100 Desc,STRING4 RiskCode});

END;