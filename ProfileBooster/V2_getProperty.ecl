IMPORT ProfileBooster, Risk_Indicators, _Control, LN_PropertyV2_Services, Doxie, Riskwise, avm_v2, ut;
onThor := _Control.Environment.OnThor;
EXPORT V2_getProperty(DATASET(ProfileBooster.V2_Layouts.Layout_PB2_Shell) PB2_In,
                      DATASET(ProfileBooster.V2_Layouts.Layout_PB2_Slim) slimShell,
                      string50 DataRestrictionMask,
											string50 DataPermissionMask
												 ) := FUNCTION
  //--------- Property -------------//

	includeRelativeInfo := false;
	filter_out_fares		:= true;	//Fares data is restricted from use in any Marketing product
	nines		 		        := 9999999;

//for prospect pass input address, current address and previous address into property common function as we need info for all
  Risk_Indicators.Layout_PropertyRecord get_addresses(PB2_In le, integer c) := TRANSFORM
    self.fname 				:= le.fname;
    self.lname 				:= le.lname;
    self.prim_range 	:= choose(c,le.prim_range,
													    		le.curr_prim_range,
													    		le.prev_prim_range);
    self.prim_name 		:= choose(c,le.prim_name,
																	le.curr_prim_name,
																	le.prev_prim_name);
    self.st 					:= choose(c,le.st,
																	le.curr_st,
																	le.prev_st);
		self.city_name 		:= choose(c,le.p_city_name,
																	le.curr_city_name,
																	le.prev_city_name);
	  self.zip5 				:= choose(c,le.z5,
																	le.curr_z5,
																	le.prev_z5);
  	self.predir 			:= choose(c,le.predir,
																	le.curr_predir,
																	le.prev_predir);
	  self.postdir 			:= choose(c,le.postdir,
																	le.curr_postdir,
																	le.prev_postdir);
	  self.addr_suffix 	:= choose(c,le.addr_suffix,
																	le.curr_addr_suffix,
																	le.prev_addr_suffix);
	  self.sec_range 		:= choose(c,le.sec_range,
																	le.curr_sec_range,
																	le.prev_sec_range);
	  self.county 			:= choose(c,le.county,
																	le.curr_county,
																	le.prev_county);
	  self.geo_blk 			:= choose(c,le.geo_blk,
																	le.curr_geo_blk,
																	le.prev_geo_blk);
    self.did 					:= le.did2;
    self.seq 					:= le.seq;
		self.historydate 	:= le.historydate;
    self 							:= [];
  end;
	
  p_address := group(normalize(PB2_In, 3, get_addresses (LEFT,COUNTER))(prim_name != '', zip5 != ''), seq);
	
	ids_only := group(project(slimShell,  
												transform(Risk_Indicators.Layout_Boca_Shell_ids,
																	self.seq 					:= left.seq;
																	self.did 					:= left.did2;
																	self.historydate 	:= left.historydate;
																	self.isrelat     	:= false;
																	// don't populate the name fields unless the rec_type is the applicant
																	self.fname       	:= if(left.rec_type=1, left.fname, '');
																	self.lname       	:= if(left.rec_type=1, left.lname, '');
																	self.relation    	:= '',																	
																	self              := left;
																	self 							:= [])), seq);

	in_mod_property := MODULE(LN_PropertyV2_Services.interfaces.Iinput_report)		
			SHARED LN_PropertyV2_Services.interfaces.layout_entity buildEntity1() :=
				TRANSFORM
					// SELF.firstname        := with_DID[1].fname;
					// SELF.middlename       := with_DID[1].mname;
					// SELF.lastname         := with_DID[1].lname;	
					SELF.firstname        := '';
					SELF.middlename       := '';
					SELF.lastname         := '';
					SELF.unparsedfullname := '';
					SELF.allownicknames   := FALSE;
					SELF.phoneticmatch    := FALSE;
					SELF.companyname      := '';
					SELF.addr             := ''; 
					SELF.sec_range        := ''; 
					SELF.city             := ''; 
					SELF.state            := ''; 
					SELF.zip              := ''; 
					SELF.zipradius        := 0;
					SELF.county           := '';
					SELF.phone            := ''; 
					SELF.fein             := '';
					SELF.bdid             := '';
					SELF.did              := ''; 
					SELF.ssn              := ''; 
				END;

			// Option fields: set each to its default value unless present here in getAllBocaShellData.
			EXPORT faresID                 := '';
			// Data restrictions
			EXPORT data_restriction_mask   := DataRestrictionMask;
			EXPORT srcRestrict             := []; 
			EXPORT currentVend             := FALSE;
			EXPORT currentOnly             := FALSE;
			EXPORT robustnessScoreSorting  := FALSE;
			EXPORT ssn_mask_value          := 'NONE';
			EXPORT application_type_value  := '';
			EXPORT set_AddressFilters      := ALL;
			EXPORT paSearch                := FALSE;
			// Tuning
			EXPORT DisplayMatchedParty_val := FALSE;
			EXPORT pThresh                 := 10;
			EXPORT lookupVal               := '';
			EXPORT partyType               := '';
			EXPORT incDetails              := FALSE;
			EXPORT TwoPartySearch          := FALSE;
			EXPORT xadl2_weight_threshold_value	:= 0;
			// For penalization
			// EXPORT entity1 := ROW(buildEntity1());
			EXPORT entity1 := ROW([],LN_PropertyV2_Services.interfaces.layout_entity); //just send in blanks
			EXPORT entity2 := ROW([],LN_PropertyV2_Services.interfaces.layout_entity);
	END;
	
	

	from_PB     := true; 
	ViewDebugs  := false;
	isFCRA 			:= false;
	prop_common := Risk_Indicators.Boca_Shell_Property_Common(p_address, ids_only(did<>0), includeRelativeInfo, filter_out_fares, IsFCRA, in_mod_property, ViewDebugs, from_PB);
	
ProfileBooster.V2_Layouts.Layout_PB2_Shell append_property(ProfileBooster.V2_Layouts.Layout_PB2_Shell le, prop_common rt) := transform
		//see if the input address or current address came back as an owned address
		isInputAddr												:= le.z5=rt.zip5 and le.prim_range=rt.prim_range and le.prim_name=rt.prim_name;                              
		isCurrAddr												:= le.curr_z5=rt.zip5 and le.curr_prim_range=rt.prim_range and le.curr_prim_name=rt.prim_name;
		isPrevAddr												:= le.prev_z5=rt.zip5 and le.prev_prim_range=rt.prim_range and le.prev_prim_name=rt.prim_name;
		self.sale_date_by_did							:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect, rt.sale_date_by_did, 0);
    /*
    AstPropCurrCntFlag                := rt.property_status_applicant = 'O';		
    self.AstCurrFlag    							:= if(le.AstCurrFlag =1 OR AstPropCurrCntFlag, 1, 0);
    self.AstPropCurrFlag							:= if(AstPropCurrCntFlag, 1, 0);
    self.AstPropCurrCntEv							:= if(AstPropCurrCntFlag, 1, 0);
		self.AstPropCurrValTot			      := if(rt.property_status_applicant = 'O', rt.assessed_amount, 0);
    */
		self.PropCurrOwner								:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and rt.property_status_applicant = 'O', 1, 0);
		self.AstPropCurrFlag							:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and rt.property_status_applicant = 'O', 1, 0);
		
    self.PropCurrOwnedCnt							:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and rt.property_status_applicant = 'O', 1, 0);
		self.AstPropCurrCntEv							:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and rt.property_status_applicant = 'O', 1, 0);
		
    self.PropCurrOwnedAssessedTtl			:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and rt.property_status_applicant = 'O', rt.assessed_amount, 0);
		self.AstPropCurrValTot      			:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and rt.property_status_applicant = 'O', rt.assessed_amount, 0);
		
    validsaledate := Doxie.DOBTools(rt.sale_date_by_did).IsValidDOB;
		monthsSinceSold 									:= if(~validsaledate, nines, min(ProfileBooster.Common.MonthsApart_YYYYMMDD((string)rt.sale_date_by_did,risk_indicators.iid_constants.myGetDate(le.historydate),true),960));
		self.PropTimeLastSale							:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and validsaledate, monthsSinceSold, nines);
		self.AstPropSaleNewMsnc						:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and validsaledate, monthsSinceSold, nines);
		
    self.PropEverOwnedCnt							:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and rt.property_status_applicant in ['O','S'], 1, 0);
    self.AstPropCntEv   							:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and rt.property_status_applicant in ['O','S'], 1, 0);
		
    self.PropEverSoldCnt							:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and rt.property_status_applicant = 'S', 1, 0);
    self.AstPropSoldCntEv							:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and rt.property_status_applicant = 'S', 1, 0);
		
    self.PropSoldCnt12Mo							:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and validsaledate and monthsSinceSold <= 12, 1, 0);
    self.AstPropSoldCnt1Y							:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and validsaledate and monthsSinceSold <= 12, 1, 0);
		
    salePrice													:= if(rt.sale_price1<>0, rt.sale_price1, rt.sale_price2);
		self.PropSoldRatio := if(rt.purchase_amount = 0 or salePrice = 0, 
														 '0', 
														 trim((string)(decimal4_2)min(salePrice / rt.purchase_amount, 99.0)));
    self.AstPropSoldNewRatio := if(rt.purchase_amount = 0 or salePrice = 0, 
														 '0', 
														 trim((string)(decimal4_2)min(salePrice / rt.purchase_amount, 99.0)));
    validpurchasedate := Doxie.DOBTools(rt.purchase_date_by_did).IsValidDOB;
		monthsSincePurchased							:= if(~validpurchasedate, -99997, min(ProfileBooster.Common.MonthsApart_YYYYMMDD((string)rt.purchase_date_by_did,risk_indicators.iid_constants.myGetDate(le.historydate),true),960));
		self.PropPurchaseCnt12Mo					:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and monthsSincePurchased >= 0 and monthsSincePurchased <= 12, 1, 0);
		self.AstPropPurchCnt1Y  					:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and monthsSincePurchased >= 0 and monthsSincePurchased <= 12, 1, 0);
		
    self.LifeAstPurchOldMsnc	:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect, max(le.LifeAstPurchOldMsnc, monthsSincePurchased), le.LifeAstPurchOldMsnc);
		self.LifeAstPurchNewMsnc	:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect, 
																						map(monthsSincePurchased = -99997					=> le.LifeAstPurchNewMsnc,
																								le.LifeAstPurchNewMsnc < 0	          => monthsSincePurchased,
																																												 min(le.LifeAstPurchNewMsnc,monthsSincePurchased)),
																						le.LifeAstPurchNewMsnc);	
		self.CurrAddrOwnershipIndx				:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect,
																						map(isCurrAddr and rt.property_status_applicant = 'O' and rt.naprop = 4				=> 4,
																								isCurrAddr and rt.naprop = 3																							=> 3,
																								isCurrAddr and rt.occupant_owned																					=> 2,
																								isCurrAddr and rt.property_status_applicant <> 'O'												=> 1,
																																																													   0),
																						0);
		// self.ResCurrMortgageType					:= map(~le.rec_type=ProfileBooster.Constants.recType.Prospect or ~isCurrAddr	=>	'-1', 
																						 // rt.type_financing = 'ADJ'																							=>	'1',
																						 // rt.type_financing = 'CNV'																							=>	'2',
																						 // rt.type_financing <> ''																								=>	'0',
																																																													// '-1');
		// self.ResCurrMortgageAmount				:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and isCurrAddr, rt.mortgage_amount, 0);
		self.InpAddrOwnershipIndx				:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect,
																						map(isInputAddr and rt.property_status_applicant = 'O' and rt.naprop = 4			=> 4,
																								isInputAddr and rt.naprop = 3																							=> 3,
																								isInputAddr and rt.occupant_owned																					=> 2,
																								isInputAddr and rt.property_status_applicant <> 'O'												=> 1,
																																																														 0),
																						0);
		// self.ResInputMortgageType					:= map(~le.rec_type=ProfileBooster.Constants.recType.Prospect or ~isInputAddr	=>	'-1', 
																						 // rt.type_financing = 'ADJ'																							=>	'1',
																						 // rt.type_financing = 'CNV'																							=>	'2',
																						 // rt.type_financing <> ''																								=>	'0',
																																																													// '-1');
		// self.ResInputMortgageAmount				:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and isInputAddr, rt.mortgage_amount, 0);																	
		self.HHPropCurrOwnerMmbrCnt			 	:= if(le.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household] and rt.property_status_applicant = 'O', 1, 0);  
		self.HHPropCurrOwnedCnt					 	:= if(le.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household] and rt.property_status_applicant = 'O', 1, 0); 
		self.RaAPropCurrOwnerMmbrCnt			:= if(le.rec_type = ProfileBooster.Constants.recType.Relative and rt.property_status_applicant = 'O', 1, 0);
		self.owned_prim_range							:= if(rt.property_status_applicant = 'O', rt.prim_range, '');
		self.owned_predir									:= if(rt.property_status_applicant = 'O', rt.predir, '');
		self.owned_prim_name							:= if(rt.property_status_applicant = 'O', rt.prim_name, '');
		self.owned_addr_suffix						:= if(rt.property_status_applicant = 'O', rt.addr_suffix, '');
		self.owned_postdir								:= if(rt.property_status_applicant = 'O', rt.postdir, '');
		self.owned_unit_desig							:= if(rt.property_status_applicant = 'O', rt.unit_desig, '');
		self.owned_sec_range							:= if(rt.property_status_applicant = 'O', rt.sec_range, '');
		self.owned_z5											:= if(rt.property_status_applicant = 'O', rt.zip5, '');
		self.owned_city_name							:= if(rt.property_status_applicant = 'O', rt.city_name, '');
		self.owned_st											:= if(rt.property_status_applicant = 'O', rt.st, '');
		
		self.sold_prim_range							:= if(rt.property_status_applicant = 'S', rt.prim_range, '');
		self.sold_predir									:= if(rt.property_status_applicant = 'S', rt.predir, '');
		self.sold_prim_name								:= if(rt.property_status_applicant = 'S', rt.prim_name, '');
		self.sold_addr_suffix							:= if(rt.property_status_applicant = 'S', rt.addr_suffix, '');
		self.sold_postdir									:= if(rt.property_status_applicant = 'S', rt.postdir, '');
		self.sold_unit_desig							:= if(rt.property_status_applicant = 'S', rt.unit_desig, '');
		self.sold_sec_range								:= if(rt.property_status_applicant = 'S', rt.sec_range, '');
		self.sold_z5											:= if(rt.property_status_applicant = 'S', rt.zip5, '');
		self.sold_city_name								:= if(rt.property_status_applicant = 'S', rt.city_name, '');
		self.sold_st											:= if(rt.property_status_applicant = 'S', rt.st, '');
		
		self.curr_AssessedAmount					:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and isCurrAddr, rt.assessed_amount, 0);
		self.prev_AssessedAmount					:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and isPrevAddr, rt.assessed_amount, 0);
		self := le;
	end;
	
	withProperty_roxie := join(PB2_In, prop_common,
												left.seq = right.seq and
												left.did2 = right.did,
												append_property(left, right), left outer, parallel);

	
withPB2_In_distr := distribute(PB2_In, did2);
prop_common_distr := distribute(prop_common, did);
	
	withProperty_thor := join(withPB2_In_distr, prop_common_distr,
												left.did2 = right.did,
												append_property(left, right), left outer, local)
												;
	// : PERSIST('~PROFILEBOOSTER::withProperty_thor');// remove persists because low on disk space and it's rebuilding persist file each time anyway
	
	#IF(onThor)
		withProperty := withProperty_thor;
	#ELSE
		withProperty := withProperty_roxie;
	#END
	
	withProperty_distributed := distribute(withProperty, seq);
	sortedProperty :=  sort(withProperty, seq, did2, -sale_date_by_did, -owned_prim_range, -owned_prim_name, local); //within DID, sort most recent sold property to top

	ProfileBooster.V2_Layouts.Layout_PB2_Shell rollProperty(sortedProperty le, sortedProperty ri) := TRANSFORM
		same_prop := le.owned_prim_range=ri.owned_prim_range and le.owned_prim_name=ri.owned_prim_name;
		same_sold_prop := le.sold_prim_range = ri.sold_prim_range AND le.sold_prim_name = ri.sold_prim_name;
		
		self.PropCurrOwner								:= max(le.PropCurrOwner, ri.PropCurrOwner);
		self.AstPropCurrFlag							:= max(le.AstPropCurrFlag, ri.AstPropCurrFlag);
		self.PropCurrOwnedCnt							:= le.PropCurrOwnedCnt + if(same_prop, 0, ri.PropCurrOwnedCnt);
		self.AstPropCurrCntEv							:= le.AstPropCurrCntEv + if(same_prop, 0, ri.AstPropCurrCntEv);
		self.PropCurrOwnedAssessedTtl			:= le.PropCurrOwnedAssessedTtl + if(same_prop, 0, ri.PropCurrOwnedAssessedTtl);
		self.AstPropCurrValTot      			:= le.AstPropCurrValTot + if(same_prop, 0, ri.AstPropCurrValTot);
		self.PropTimeLastSale							:= min(le.PropTimeLastSale, ri.PropTimeLastSale);
		self.AstPropSaleNewMsnc						:= min(le.PropTimeLastSale, ri.PropTimeLastSale);
		self.PropEverOwnedCnt							:= le.PropEverOwnedCnt + if(same_prop, 0, ri.PropEverOwnedCnt);
		self.AstPropCntEv   							:= le.AstPropCntEv + if(same_prop, 0, ri.AstPropCntEv);
		self.PropEverSoldCnt							:= le.PropEverSoldCnt + if(same_sold_prop, 0, ri.PropEverSoldCnt);
		self.AstPropSoldCntEv							:= le.AstPropSoldCntEv + if(same_sold_prop, 0, ri.AstPropSoldCntEv);
		self.PropSoldCnt12Mo							:= le.PropSoldCnt12Mo + if(same_sold_prop, 0, ri.PropSoldCnt12Mo);
		self.AstPropSoldCnt1Y							:= le.AstPropSoldCnt1Y + if(same_sold_prop, 0, ri.AstPropSoldCnt1Y);
		self.PropSoldRatio								:= le.propSoldRatio; //most recent was sorted first so always just keep the left
		self.AstPropSoldNewRatio					:= le.AstPropSoldNewRatio; //most recent was sorted first so always just keep the left
		self.PropPurchaseCnt12Mo					:= le.PropPurchaseCnt12Mo + if(same_prop, 0, ri.PropPurchaseCnt12Mo);
		self.AstPropPurchCnt1Y  					:= le.AstPropPurchCnt1Y + if(same_prop, 0, ri.AstPropPurchCnt1Y);
		self.LifeAstPurchOldMsnc	        := max(le.LifeAstPurchOldMsnc, ri.LifeAstPurchOldMsnc);
		self.LifeAstPurchNewMsnc	        := map(ri.LifeAstPurchNewMsnc <= 0	=> le.LifeAstPurchNewMsnc,
																						 le.LifeAstPurchNewMsnc <= 0	=> ri.LifeAstPurchNewMsnc,
																																						 min(le.LifeAstPurchNewMsnc, ri.LifeAstPurchNewMsnc));
		self.CurrAddrOwnershipIndx			 	:= max(le.CurrAddrOwnershipIndx, ri.CurrAddrOwnershipIndx);  
		// self.ResCurrMortgageType					:= if(ri.ResCurrMortgageType <> '', ri.ResCurrMortgageType, le.ResCurrMortgageType);
		// self.ResCurrMortgageAmount				:= max(le.ResCurrMortgageAmount, ri.ResCurrMortgageAmount);
		self.InpAddrOwnershipIndx			 	  := max(le.InpAddrOwnershipIndx, ri.InpAddrOwnershipIndx);  
		// self.ResInputMortgageType					:= if(ri.ResInputMortgageType <> '', ri.ResInputMortgageType, le.ResInputMortgageType);
		// self.ResInputMortgageAmount				:= max(le.ResInputMortgageAmount, ri.ResInputMortgageAmount);
		self.curr_AssessedAmount					:= max(le.curr_AssessedAmount, ri.curr_AssessedAmount);
		self.prev_AssessedAmount					:= max(le.prev_AssessedAmount, ri.prev_AssessedAmount);
		self.HHPropCurrOwnerMmbrCnt			 	:= max(le.HHPropCurrOwnerMmbrCnt, ri.HHPropCurrOwnerMmbrCnt);  
		self.HHPropCurrOwnedCnt					 	:= le.HHPropCurrOwnedCnt + if(same_prop, 0, ri.HHPropCurrOwnedCnt); 
		self.RaAPropCurrOwnerMmbrCnt			:= max(le.RaAPropCurrOwnerMmbrCnt, ri.RaAPropCurrOwnerMmbrCnt);
		self								 							:= le;
	END;

	rolledProperty :=  rollup(sortedProperty, left.seq = right.seq and left.did2 = right.did2,
											rollProperty(left, right));
                      
  //--------- AVM -------------//

	preAVM := group(project(PB2_In(rec_type=ProfileBooster.Constants.recType.Prospect),  // withInfutor contains only Prospect records...we don't need HH or relatives info
												transform(Risk_Indicators.layout_bocashell_neutral,
																	self.seq 					:= left.seq;
																	self.did 					:= left.did;
																	self.historydate 	:= left.historydate;
																	self.isrelat     	:= false;
																	self.fname       	:= left.fname;
																	self.lname       	:= left.lname;
																	self.address_verification.input_address_information.prim_name   := left.prim_name;
																	self.address_verification.input_address_information.prim_range  := left.prim_range;
																	self.address_verification.input_address_information.zip5			  := left.z5;
																	self.address_verification.input_address_information.st				  := left.st;
																	self.address_verification.input_address_information.predir		  := left.predir;
																	self.address_verification.input_address_information.postdir	    := left.postdir;
																	self.address_verification.input_address_information.addr_suffix := left.addr_suffix;
																	self.address_verification.input_address_information.sec_range	  := left.sec_range;
																	self.address_verification.input_address_information.county	  	:= left.county;
																	self.address_verification.input_address_information.geo_blk	  	:= left.geo_blk;
																	self.address_verification.address_history_1.prim_name   				:= left.curr_prim_name;
																	self.address_verification.address_history_1.prim_range  				:= left.curr_prim_range;
																	self.address_verification.address_history_1.zip5			  				:= left.curr_z5;
																	self.address_verification.address_history_1.st				  				:= left.curr_st;
																	self.address_verification.address_history_1.predir		  				:= left.curr_predir;
																	self.address_verification.address_history_1.postdir	    				:= left.curr_postdir;
																	self.address_verification.address_history_1.addr_suffix 				:= left.curr_addr_suffix;
																	self.address_verification.address_history_1.sec_range	  				:= left.curr_sec_range;
																	self.address_verification.address_history_1.county	  					:= left.curr_county;
																	self.address_verification.address_history_1.geo_blk	  					:= left.curr_geo_blk;
																	self.address_verification.address_history_2.prim_name   				:= left.prev_prim_name;
																	self.address_verification.address_history_2.prim_range  				:= left.prev_prim_range;
																	self.address_verification.address_history_2.zip5			  				:= left.prev_z5;
																	self.address_verification.address_history_2.st				  				:= left.prev_st;
																	self.address_verification.address_history_2.predir		  				:= left.prev_predir;
																	self.address_verification.address_history_2.postdir	    				:= left.prev_postdir;
																	self.address_verification.address_history_2.addr_suffix 				:= left.prev_addr_suffix;
																	self.address_verification.address_history_2.sec_range	  				:= left.prev_sec_range;
																	self.address_verification.address_history_2.county	  					:= left.prev_county;
																	self.address_verification.address_history_2.geo_blk	  					:= left.prev_geo_blk;
																	
																	self 							:= [])), seq);				

	AVMrecs := Risk_Indicators.Boca_Shell_AVM(preAVM);

	withAVM := join(rolledProperty, AVMrecs,
												left.seq = right.seq and
												left.rec_type=ProfileBooster.Constants.recType.Prospect, //we sent only Prospect recs to AVM search so only need to update Prospects here
												transform(ProfileBooster.V2_Layouts.Layout_PB2_Shell,
																	self.CurrAddrAVMVal 					:= right.address_history_1.avm_automated_valuation;
																	self.CurrAddrAVMValA1Y 			:= right.address_history_1.avm_automated_valuation2;
																	self.CurrAddrAVMRatio1Y := if(right.address_history_1.avm_automated_valuation = 0 or right.address_history_1.avm_automated_valuation2 = 0, 
																																		 '0', 
																																		 trim((string)(decimal4_2)min(right.address_history_1.avm_automated_valuation / right.address_history_1.avm_automated_valuation2, 99.0)));
																	self.CurrAddrAVMValA5Y 			:= right.address_history_1.avm_automated_valuation6;
																	self.CurrAddrAVMRatio5Y := if(right.address_history_1.avm_automated_valuation = 0 or right.address_history_1.avm_automated_valuation6 = 0, 
																																		 '0', 
																																		 trim((string)(decimal4_2)min(right.address_history_1.avm_automated_valuation / right.address_history_1.avm_automated_valuation6, 99.0)));
																	self.CurrAddrMedAVMCtyRatio := if(right.address_history_1.avm_automated_valuation = 0 or right.address_history_1.avm_median_fips_level = 0, 
																																  '0', 
																																	trim((string)(decimal4_2)min(right.address_history_1.avm_automated_valuation / right.address_history_1.avm_median_fips_level, 99.0)));
																	self.CurrAddrMedAVMCenTractRatio := if(right.address_history_1.avm_automated_valuation = 0 or right.address_history_1.avm_median_geo11_level = 0, 
																																	'0', 
																																	trim((string)(decimal4_2)min(right.address_history_1.avm_automated_valuation / right.address_history_1.avm_median_geo11_level, 99.0)));
																	self.CurrAddrMedAVMCenBlockRatio := if(right.address_history_1.avm_automated_valuation = 0 or right.address_history_1.avm_median_geo12_level = 0, 
																																	'0', 
																																	trim((string)(decimal4_2)min(right.address_history_1.avm_automated_valuation / right.address_history_1.avm_median_geo12_level, 99.0)));
																	self.InpAddrAVMVal 				:= right.Input_Address_Information.avm_automated_valuation;
																	self.InpAddrAVMValA1Y 		:= right.Input_Address_Information.avm_automated_valuation2;
																	self.InpAddrAVMRatio1Y := if(right.Input_Address_Information.avm_automated_valuation = 0 or right.Input_Address_Information.avm_automated_valuation2 = 0, 
																																			'0', 
																																			trim((string)(decimal4_2)min(right.Input_Address_Information.avm_automated_valuation / right.Input_Address_Information.avm_automated_valuation2, 99.0)));
																	self.InpAddrAVMValA5Y 		:= right.Input_Address_Information.avm_automated_valuation6;
																	self.InpAddrAVMRatio5Y := if(right.Input_Address_Information.avm_automated_valuation = 0 or right.Input_Address_Information.avm_automated_valuation6 = 0, 
																																			'0', 
																																			trim((string)(decimal4_2)min(right.Input_Address_Information.avm_automated_valuation / right.Input_Address_Information.avm_automated_valuation6, 99.0)));
																	self.InpAddrMedAVMCtyRatio := if(right.Input_Address_Information.avm_automated_valuation = 0 or right.Input_Address_Information.avm_median_fips_level = 0, 
																																	'0', 
																																	trim((string)(decimal4_2)min(right.Input_Address_Information.avm_automated_valuation / right.Input_Address_Information.avm_median_fips_level, 99.0)));
																	self.InpAddrMedAVMCenTractRatio := if(right.Input_Address_Information.avm_automated_valuation = 0 or right.Input_Address_Information.avm_median_geo11_level = 0, 
																																	 '0', 
																																	 trim((string)(decimal4_2)min(right.Input_Address_Information.avm_automated_valuation / right.Input_Address_Information.avm_median_geo11_level, 99.0)));
																	self.InpAddrMedAVMCenBlockRatio := if(right.Input_Address_Information.avm_automated_valuation = 0 or right.Input_Address_Information.avm_median_geo12_level = 0, 
																																	 '0', 
																																	 trim((string)(decimal4_2)min(right.Input_Address_Information.avm_automated_valuation / right.Input_Address_Information.avm_median_geo12_level, 99.0)));
																	self := left), left outer, parallel);
	
	//We need the AVM value of any properties owned by the Prospect, HH members or Relatives...isolate those people/properties here
	propOwners	:= dedup(sort(withProperty(owned_prim_name<>'' and owned_z5<>''),   
														seq, did2, owned_prim_name, owned_prim_range, owned_z5), 
														seq, did2, owned_prim_name, owned_prim_range, owned_z5); 
														
	preAVMOwned := group(project(propOwners,  
												transform(Risk_Indicators.layout_bocashell_neutral,
																	self.seq 					:= left.seq;
																	self.did 					:= left.did2;
																	self.historydate 	:= left.historydate;
																	self.isrelat     	:= false;
																	self.address_verification.input_address_information.prim_name   := left.owned_prim_name;
																	self.address_verification.input_address_information.prim_range  := left.owned_prim_range;
																	self.address_verification.input_address_information.zip5			  := left.owned_z5;
																	self.address_verification.input_address_information.city_name	  := left.owned_city_name;
																	self.address_verification.input_address_information.st				  := left.owned_st;
																	self.address_verification.input_address_information.predir		  := left.owned_predir;
																	self.address_verification.input_address_information.postdir	    := left.owned_postdir;
																	self.address_verification.input_address_information.addr_suffix := left.owned_addr_suffix;
																	self.address_verification.input_address_information.sec_range	  := left.owned_sec_range;
																	self 							:= [])), seq);				

	Layout_AVM := RECORD
		unsigned4 seq;
		unsigned6 DID;
		unsigned3 historydate;
		string10 	prim_range;
		string2  	predir;
		string28  prim_name;
		string2   postdir;
		string8   sec_range;
		string2   st;
		string5   zip;			
		Riskwise.Layouts.Layout_AVM;
	END;

	Layout_AVM add_AVM(preAVMOwned le, avm_v2.Key_AVM_Address ri) := transform
		full_history_date := Risk_Indicators.iid_constants.full_history_date(le.historydate);
		AVM_V2.MOD_get_AVM_from_History.MAC_get_AVM(ri, full_history_date, avm_record);	// updated to get full history
		
		SELF.Input_Address_Information.avm_land_use_code := avm_record.land_use;
		SELF.Input_Address_Information.avm_recording_date := avm_record.recording_date;
		SELF.Input_Address_Information.avm_assessed_value_year := avm_record.assessed_value_year;
		SELF.Input_Address_Information.avm_sales_price := avm_record.sales_price;  
		SELF.Input_Address_Information.avm_assessed_total_value := avm_record.assessed_total_value;
		SELF.Input_Address_Information.avm_market_total_value := avm_record.market_total_value;
		SELF.Input_Address_Information.avm_tax_assessment_valuation := avm_record.tax_assessment_valuation;
		SELF.Input_Address_Information.avm_price_index_valuation := avm_record.price_index_valuation;
		SELF.Input_Address_Information.avm_hedonic_valuation := avm_record.hedonic_valuation;
		SELF.Input_Address_Information.avm_automated_valuation := avm_record.automated_valuation;
		SELF.Input_Address_Information.avm_confidence_score := avm_record.confidence_score;
		
		// new fields
		SELF.Input_Address_Information.avm_automated_valuation2 := avm_record.automated_valuation2;
		SELF.Input_Address_Information.avm_automated_valuation3 := avm_record.automated_valuation3;
		SELF.Input_Address_Information.avm_automated_valuation4 := avm_record.automated_valuation4;
		SELF.Input_Address_Information.avm_automated_valuation5 := avm_record.automated_valuation5;
		SELF.Input_Address_Information.avm_automated_valuation6 := avm_record.automated_valuation6;
		
		SELF.seq := le.seq;
		SELF.DID := le.DID;
		self.historydate := le.historydate;
		SELF.prim_range := ri.prim_range;
		SELF.predir := ri.predir;
		SELF.prim_name := ri.prim_name;
		SELF.postdir := ri.postdir;
		SELF.sec_range := ri.sec_range;
		SELF.st := ri.st;
		SELF.zip := ri.zip;	
	END;
	
	avm1Owned_roxie := join(preAVMOwned, avm_v2.Key_AVM_Address,  
								left.address_verification.input_address_information.prim_name!='' and left.address_verification.input_address_information.zip5!='' and
								keyed(left.address_verification.input_address_information.prim_name = right.prim_name) and
								keyed(left.address_verification.input_address_information.st = right.st) and
								keyed(left.address_verification.input_address_information.zip5 = right.zip) and
								keyed(left.address_verification.input_address_information.prim_range = right.prim_range) and
								keyed(left.address_verification.input_address_information.sec_range = right.sec_range) and	// NNEQ here?
								left.address_verification.input_address_information.predir=right.predir and 
								left.address_verification.input_address_information.postdir=right.postdir,
							add_AVM(left, right),  
									atmost(RiskWise.max_atmost), keep(100));

	avm1Owned_thor := join(
		distribute(preAVMOwned, hash64(address_verification.input_address_information.prim_name,
																address_verification.input_address_information.st,
																address_verification.input_address_information.zip5,
																address_verification.input_address_information.prim_range)), 
		distribute(pull(avm_v2.Key_AVM_Address), hash64(prim_name, st, zip, prim_range)),   
								left.address_verification.input_address_information.prim_name!='' and left.address_verification.input_address_information.zip5!='' and
								left.address_verification.input_address_information.prim_name = right.prim_name and
								left.address_verification.input_address_information.st = right.st and
								left.address_verification.input_address_information.zip5 = right.zip and
								left.address_verification.input_address_information.prim_range = right.prim_range and
								left.address_verification.input_address_information.sec_range = right.sec_range and	// NNEQ here?
								left.address_verification.input_address_information.predir=right.predir and 
								left.address_verification.input_address_information.postdir=right.postdir,
							add_AVM(left, right),  
									atmost(RiskWise.max_atmost), keep(100), 
			local);

	#IF(onThor)
		avm1Owned := group(avm1Owned_thor, seq);
	#ELSE
		avm1Owned := avm1Owned_roxie;
	#END
	
	// when choosing which AVM to output if the addr returns more than 1 result, 
	// always pick the record with the most recent recording date and secondarily the most recent assessed value year
	avms1Owned := dedup(sort(avm1Owned, seq, did, prim_range, prim_name, zip, -Input_Address_Information.avm_recording_date, -Input_Address_Information.avm_assessed_value_year),
																			seq, did, prim_range, prim_name, zip);
	
	withAVMOwned_pre := join(withAVM, avms1Owned,
												left.seq = right.seq and
												left.DID2 = right.DID,
												transform({ProfileBooster.V2_Layouts.Layout_PB2_Shell, STRING DateDifference},
                                                                    self.DateDifference := IF(left.dt_last_seen = 0, '-1', (string)ut.MonthsApart((string6)left.dt_last_seen,risk_indicators.iid_constants.myGetDate(left.historydate)[1..6]));
																	self.AstPropCurrAVMTot 			:= if(left.rec_type = ProfileBooster.Constants.recType.Prospect, right.Input_Address_Information.avm_automated_valuation, 0);
																	self.HHPropCurrAVMHighest 		:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], right.Input_Address_Information.avm_automated_valuation, 0);
																	self.RaAPropOwnerAVMHighest 	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, right.Input_Address_Information.avm_automated_valuation, 0);
																	self.RaAPropOwnerAVMMed 	     := if(left.rec_type = ProfileBooster.Constants.recType.Relative, right.Input_Address_Information.avm_automated_valuation, 0);
                                                                    self.HHMmbrPropAVMTot1Y           := if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household] AND ((INTEGER)self.DateDifference >= 0 AND (INTEGER)self.DateDifference <= 12), right.Input_Address_Information.avm_automated_valuation, 0);
                                                                    self.HHMmbrPropAVMTot5Y           := if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household] AND ((INTEGER)self.DateDifference >= 0 AND (INTEGER)self.DateDifference <= 60), right.Input_Address_Information.avm_automated_valuation, 0);
																	self := left), left outer, parallel);

    withAVMOwned := PROJECT(withAVMOwned_pre, TRANSFORM(ProfileBooster.V2_Layouts.Layout_PB2_Shell, SELF := LEFT;));
    
	sortedAVMOwned :=  sort(withAVMOwned, seq, did2); 

	groupAVMOwned := group(sortedAVMOwned(RaAPropOwnerAVMMed<>0), seq);	

	ProfileBooster.V2_Layouts.Layout_PB2_Shell rollAVMOwned(sortedAVMOwned le, sortedAVMOwned ri) := TRANSFORM
		self.AstPropCurrAVMTot					:= le.AstPropCurrAVMTot + ri.AstPropCurrAVMTot;
		self.HHMmbrPropAVMTot					:= le.HHPropCurrAVMHighest + ri.HHPropCurrAVMHighest;
		self.HHMmbrPropAVMTot1Y					:= le.HHMmbrPropAVMTot1Y + ri.HHMmbrPropAVMTot1Y;
		self.HHMmbrPropAVMTot5Y					:= le.HHMmbrPropAVMTot5Y + ri.HHMmbrPropAVMTot5Y;
		self.HHPropCurrAVMHighest					:= max(le.HHPropCurrAVMHighest, ri.HHPropCurrAVMHighest);
		self.RaAPropOwnerAVMHighest				:= max(le.RaAPropOwnerAVMHighest, ri.RaAPropOwnerAVMHighest);
		self								 							:= le;
	END;

	rolledAVMOwned :=  rollup(sortedAVMOwned, left.seq = right.seq and left.did2 = right.did2,
											rollAVMOwned(left, right));

//--------- Economic Trajectory -------------//

//first project the AVM results for our prospect into BocaShell layout (the layout that the Economic Trajectory model accepts) 
	BSAVM := project(AVMrecs,  
												transform(Risk_Indicators.Layout_Boca_Shell,
																	self.historyDate 											:= left.historyDate;				
																	self.seq				 											:= left.seq;				
																	self.AVM.address_history_1						:= left.address_history_1;				
																	self.AVM.address_history_2						:= left.address_history_2;				
																	self 	:= left;
																	self	:= []));				

//now join to our BP shell to append additional fields needed by the model
	BSappended := join(BSAVM, rolledAVMOwned(rec_type=ProfileBooster.Constants.recType.Prospect), //only need prospect (rec_type 1)
												left.seq = right.seq,
												transform(Risk_Indicators.Layout_Boca_Shell,
																	self.address_verification.addr_type2												:= right.curr_addr_type;
																	self.address_verification.address_history_1.assessed_amount	:= right.curr_assessedAmount;
																	self.address_verification.addr_type3												:= right.prev_addr_type;
																	self.address_verification.address_history_2.assessed_amount	:= right.prev_assessedAmount;
																	self.other_address_info.addrs_last_5years										:= if(right.LifeMoveNewMsnc > 60, 0, 1);
																	self.reported_dob																						:= (integer)right.dob;
																	self.addrpop2																								:= right.curr_prim_name <> '' and right.curr_z5 <> '';
																	self.addrpop3																								:= right.prev_prim_name <> '' and right.prev_z5 <> '';
																	self := left), left outer, parallel);

	econTraj := risk_indicators.getEconomicTrajectory(Group(BSappended, seq));		

	withEconTraj := join(rolledAVMOwned, econTraj,
												left.seq = right.seq and
												left.rec_type = ProfileBooster.Constants.recType.Prospect,  //update only the prospect record (not HH or relative)
												transform(ProfileBooster.V2_Layouts.Layout_PB2_Shell,
																	self.LifeAddrEconTrajType 	:= right.economic_trajectory;
																	self.LifeAddrEconTrajIndx 	:= right.economic_trajectory_index;
																	self := left), left outer, parallel);  
                                  
  // At this point we have one record for the prospect, one for each household member and one for each relative - roll them up 
  // here to sum all of the household and relatives attributes for the prospect record  
  ProfileBooster.V2_Layouts.Layout_PB2_Shell rollFinal(ProfileBooster.V2_Layouts.Layout_PB2_Shell le, ProfileBooster.V2_Layouts.Layout_PB2_Shell ri) := transform
		self.HHTeenagerMmbrCnt							:= le.HHTeenagerMmbrCnt + ri.HHTeenagerMmbrCnt;
		self.HHYoungAdultMmbrCnt						:= le.HHYoungAdultMmbrCnt + ri.HHYoungAdultMmbrCnt;
		self.HHMiddleAgeMmbrCnt							:= le.HHMiddleAgeMmbrCnt + ri.HHMiddleAgeMmbrCnt;
		self.HHSeniorMmbrCnt							:= le.HHSeniorMmbrCnt + ri.HHSeniorMmbrCnt;
		self.HHElderlyMmbrCnt							:= le.HHElderlyMmbrCnt + ri.HHElderlyMmbrCnt;
		self.HHMmbrAgeMed								:= le.HHMmbrAgeMed + ri.HHMmbrAgeMed;
		self.HHMmbrAgeAvg								:= le.HHMmbrAgeAvg + ri.HHMmbrAgeAvg;
		self.HHComplexTotalCnt							:= le.HHComplexTotalCnt + ri.HHComplexTotalCnt;
		self.HHUnitsInComplexCnt						:= le.HHUnitsInComplexCnt + ri.HHUnitsInComplexCnt;
		self.HHMmbrCnt									:= le.HHMmbrCnt + ri.HHMmbrCnt;
		self.HHEstimatedIncomeRange					    := le.HHEstimatedIncomeRange;  //need to add code when model is complete
		// self.HHEstimatedIncomeAvg				   	:= le.HHEstimatedIncomeAvg;  //need to add code when model is complete
		self.HHMmbrWEduCollCnt				            := le.HHMmbrWEduCollCnt + ri.HHMmbrWEduCollCnt;
		self.HHMmbrWEduCollEvidEvCnt		            := le.HHMmbrWEduCollEvidEvCnt + ri.HHMmbrWEduCollEvidEvCnt;
		self.HHMmbrWEduColl4YrCnt		                := le.HHMmbrWEduColl4YrCnt + ri.HHMmbrWEduColl4YrCnt;
		self.HHMmbrWEduCollGradCnt		                := le.HHMmbrWEduCollGradCnt + ri.HHMmbrWEduCollGradCnt;
		self.HHMmbrWCollPvtCnt				            := le.HHMmbrWCollPvtCnt + ri.HHMmbrWCollPvtCnt;
		//College tier is 1-6 where 1 indicates highest tier. Keep highest tier (lowest value) but excluding 0.  
		self.HHMmbrCollTierHighest				        := map(le.HHMmbrCollTierHighest = 0	=> ri.HHMmbrCollTierHighest,
																							 ri.HHMmbrCollTierHighest = 0	=> le.HHMmbrCollTierHighest,
																																									 min(le.HHMmbrCollTierHighest, ri.HHMmbrCollTierHighest)); 
		self.HHMmbrCollTierAvg					        := le.HHMmbrCollTierAvg + ri.HHMmbrCollTierAvg;
		self.HHPropCurrOwnerMmbrCnt					    := le.HHPropCurrOwnerMmbrCnt + ri.HHPropCurrOwnerMmbrCnt;
		self.HHPropCurrOwnedCnt							:= le.HHPropCurrOwnedCnt + ri.HHPropCurrOwnedCnt;
		self.HHPropCurrAVMHighest						:= max(le.HHPropCurrAVMHighest, ri.HHPropCurrAVMHighest);
		self.HHPPCurrOwnedCnt							:= le.HHPPCurrOwnedCnt + ri.HHPPCurrOwnedCnt;
		self.HHPPCurrOwnedAutoCnt						:= le.HHPPCurrOwnedAutoCnt + ri.HHPPCurrOwnedAutoCnt;
		self.HHPPCurrOwnedMtrcycleCnt			 	    := le.HHPPCurrOwnedMtrcycleCnt + ri.HHPPCurrOwnedMtrcycleCnt;
		self.HHPPCurrOwnedAircrftCnt				    := le.HHPPCurrOwnedAircrftCnt + ri.HHPPCurrOwnedAircrftCnt;
		self.HHPPCurrOwnedWtrcrftCnt				    := le.HHPPCurrOwnedWtrcrftCnt + ri.HHPPCurrOwnedWtrcrftCnt;
		
    self.HHMmbrWDrgCnt7Y								:= le.HHMmbrWDrgCnt7Y + ri.HHMmbrWDrgCnt7Y;
		self.HHMmbrWDrgCnt1Y						    := le.HHMmbrWDrgCnt1Y + ri.HHMmbrWDrgCnt1Y;
		self.HHDrgNewMsnc7Y					            := le.HHDrgNewMsnc7Y + ri.HHDrgNewMsnc7Y;
		self.HHMmbrWCrimFelCnt7Y			            := le.HHMmbrWCrimFelCnt7Y + ri.HHMmbrWCrimFelCnt7Y;
		self.HHMmbrWCrimFelCnt1Y					    := le.HHMmbrWCrimFelCnt1Y + ri.HHMmbrWCrimFelCnt1Y;
		self.HHMmbrWCrimFelNewMsnc7Y			        := le.HHMmbrWCrimFelNewMsnc7Y + ri.HHMmbrWCrimFelNewMsnc7Y;
		self.HHMmbrWCrimNFelCnt7Y				        := le.HHMmbrWCrimNFelCnt7Y + ri.HHMmbrWCrimNFelCnt7Y;
		self.HHMmbrWCrimNFelCnt1Y		                := le.HHMmbrWCrimNFelCnt1Y + ri.HHMmbrWCrimNFelCnt1Y;
		self.HHMmbrWCrimNFelNewMsnc7Y			    	:= le.HHMmbrWCrimNFelNewMsnc7Y + ri.HHMmbrWCrimNFelNewMsnc7Y;
		self.HHMmbrWEvictCnt7Y		                    := le.HHMmbrWEvictCnt7Y + ri.HHMmbrWEvictCnt7Y;
		self.HHMmbrWEvictCnt1Y					        := le.HHMmbrWEvictCnt1Y + ri.HHMmbrWEvictCnt1Y;
		self.HHMmbrWEvictNewMsnc7Y					    := le.HHMmbrWEvictNewMsnc7Y + ri.HHMmbrWEvictNewMsnc7Y;
		self.HHMmbrWLnJCnt7Y				            := le.HHMmbrWLnJCnt7Y + ri.HHMmbrWLnJCnt7Y;
		self.HHMmbrWLnJCnt1Y				            := le.HHMmbrWLnJCnt1Y + ri.HHMmbrWLnJCnt1Y;
		self.HHMmbrLnJAmtTot7Y						    := le.HHMmbrLnJAmtTot7Y + ri.HHMmbrLnJAmtTot7Y;
		self.HHMmbrWLnJNewMsnc7Y			            := le.HHMmbrWLnJNewMsnc7Y + ri.HHMmbrWLnJNewMsnc7Y;
		self.HHMmbrWBkCnt10Y			                := le.HHMmbrWBkCnt10Y + ri.HHMmbrWBkCnt10Y;
		self.HHMmbrWBkCnt1Y			                    := le.HHMmbrWBkCnt1Y + ri.HHMmbrWBkCnt1Y;
		self.HHMmbrWBkCnt2Y		            	        := le.HHMmbrWBkCnt2Y + ri.HHMmbrWBkCnt2Y;
		self.HHMmbrWBkNewMsnc10Y			            := le.HHMmbrWBkNewMsnc10Y + ri.HHMmbrWBkNewMsnc10Y;
		self.HHMmbrWFrClCnt7Y			                := le.HHMmbrWFrClCnt7Y + ri.HHMmbrWFrClCnt7Y;
		self.HHMmbrWFrClNewMSnc7Y			            := le.HHMmbrWFrClNewMSnc7Y + ri.HHMmbrWFrClNewMSnc7Y;
    
		self.HHInterestSportPersonMmbrCnt		        := le.HHInterestSportPersonMmbrCnt + ri.HHInterestSportPersonMmbrCnt;	
		self.RaATeenageMmbrCnt							:= le.RaATeenageMmbrCnt + ri.RaATeenageMmbrCnt;
		self.RaAYoungAdultMmbrCnt						:= le.RaAYoungAdultMmbrCnt + ri.RaAYoungAdultMmbrCnt;
		self.RaAMiddleAgeMmbrCnt						:= le.RaAMiddleAgeMmbrCnt + ri.RaAMiddleAgeMmbrCnt;
		self.RaASeniorMmbrCnt							:= le.RaASeniorMmbrCnt + ri.RaASeniorMmbrCnt;
		self.RaAElderlyMmbrCnt							:= le.RaAElderlyMmbrCnt + ri.RaAElderlyMmbrCnt;
		self.RaAHHCnt									:= if(le.RaAHHCnt <> 0, le.RaAHHCnt, ri.RaAHHCnt); //this count is summed already so just keep whichever is populated
		self.RaAMmbrCnt									:= le.RaAMmbrCnt + ri.RaAMmbrCnt;
		self.RaAMedIncomeRange							:= if(le.RaAMedIncomeRange <> 0, le.RaAMedIncomeRange, ri.RaAMedIncomeRange);	//Med income will be same for all relatives records at this point so just take whichever is populated
		self.RaACollegeAttendedMmbrCnt			        := le.RaACollegeAttendedMmbrCnt + ri.RaACollegeAttendedMmbrCnt;
		self.RaACollege2yrAttendedMmbrCnt		        := le.RaACollege2yrAttendedMmbrCnt + ri.RaACollege2yrAttendedMmbrCnt;
		self.RaACollege4yrAttendedMmbrCnt		        := le.RaACollege4yrAttendedMmbrCnt + ri.RaACollege4yrAttendedMmbrCnt;
		self.RaACollegeGradAttendedMmbrCnt	            := le.RaACollegeGradAttendedMmbrCnt + ri.RaACollegeGradAttendedMmbrCnt;
		self.RaACollegePrivateMmbrCnt				    := le.RaACollegePrivateMmbrCnt + ri.RaACollegePrivateMmbrCnt;
		self.RaACollegeTopTierMmbrCnt				    := le.RaACollegeTopTierMmbrCnt + ri.RaACollegeTopTierMmbrCnt;
		self.RaACollegeMidTierMmbrCnt				    := le.RaACollegeMidTierMmbrCnt + ri.RaACollegeMidTierMmbrCnt;
		self.RaACollegeLowTierMmbrCnt			  	    := le.RaACollegeLowTierMmbrCnt + ri.RaACollegeLowTierMmbrCnt;
		self.RaAPropCurrOwnerMmbrCnt				    := le.RaAPropCurrOwnerMmbrCnt + ri.RaAPropCurrOwnerMmbrCnt;
		self.RaAPropOwnerAVMHighest					    := max(le.RaAPropOwnerAVMHighest, ri.RaAPropOwnerAVMHighest);
		// self.RaAPropOwnerAVMMed							:= ave(groupAVMOwned, RaAPropOwnerAVMHighest);
		self.RaAPPCurrOwnerMmbrCnt				  	    := le.RaAPPCurrOwnerMmbrCnt + ri.RaAPPCurrOwnerMmbrCnt;
		self.RaAPPCurrOwnerAutoMmbrCnt 			        := le.RaAPPCurrOwnerAutoMmbrCnt + ri.RaAPPCurrOwnerAutoMmbrCnt;
		self.RaAPPCurrOwnerMtrcycleMmbrCnt 	            := le.RaAPPCurrOwnerMtrcycleMmbrCnt + ri.RaAPPCurrOwnerMtrcycleMmbrCnt;
		self.RaAPPCurrOwnerAircrftMmbrCnt 	            := le.RaAPPCurrOwnerAircrftMmbrCnt + ri.RaAPPCurrOwnerAircrftMmbrCnt;
		self.RaAPPCurrOwnerWtrcrftMmbrCnt		        := le.RaAPPCurrOwnerWtrcrftMmbrCnt + ri.RaAPPCurrOwnerWtrcrftMmbrCnt;
		self.RaACrtRecMmbrCnt							:= le.RaACrtRecMmbrCnt + ri.RaACrtRecMmbrCnt;
		self.RaACrtRecMmbrCnt12Mo						:= le.RaACrtRecMmbrCnt12Mo + ri.RaACrtRecMmbrCnt12Mo;
		self.RaACrtRecFelonyMmbrCnt					    := le.RaACrtRecFelonyMmbrCnt + ri.RaACrtRecFelonyMmbrCnt;
		self.RaACrtRecFelonyMmbrCnt12Mo			        := le.RaACrtRecFelonyMmbrCnt12Mo + ri.RaACrtRecFelonyMmbrCnt12Mo;
		self.RaACrtRecMsdmeanMmbrCnt				    := le.RaACrtRecMsdmeanMmbrCnt + ri.RaACrtRecMsdmeanMmbrCnt;
		self.RaACrtRecMsdmeanMmbrCnt12Mo		        := le.RaACrtRecMsdmeanMmbrCnt12Mo + ri.RaACrtRecMsdmeanMmbrCnt12Mo;
		self.RaACrtRecEvictionMmbrCnt				    := le.RaACrtRecEvictionMmbrCnt + ri.RaACrtRecEvictionMmbrCnt;
		self.RaACrtRecEvictionMmbrCnt12Mo		        := le.RaACrtRecEvictionMmbrCnt12Mo + ri.RaACrtRecEvictionMmbrCnt12Mo;
		self.RaACrtRecLienJudgMmbrCnt				    := le.RaACrtRecLienJudgMmbrCnt + ri.RaACrtRecLienJudgMmbrCnt;
		self.RaACrtRecLienJudgMmbrCnt12Mo		        := le.RaACrtRecLienJudgMmbrCnt12Mo + ri.RaACrtRecLienJudgMmbrCnt12Mo;
		self.RaACrtRecLienJudgAmtMax				    := max(le.RaACrtRecLienJudgAmtMax, ri.RaACrtRecLienJudgAmtMax);
		self.RaACrtRecBkrptMmbrCnt36Mo			        := le.RaACrtRecBkrptMmbrCnt36Mo + ri.RaACrtRecBkrptMmbrCnt36Mo;
		self.RaAOccProfLicMmbrCnt						:= le.RaAOccProfLicMmbrCnt + ri.RaAOccProfLicMmbrCnt;
		self.RaAOccBusinessAssocMmbrCnt			        := le.RaAOccBusinessAssocMmbrCnt + ri.RaAOccBusinessAssocMmbrCnt;
		self.RaAInterestSportPersonMmbrCnt	            := le.RaAInterestSportPersonMmbrCnt + ri.RaAInterestSportPersonMmbrCnt;		
		self := le;  //for all prospect attributes, keep all values from the left (first) record  
	end;
	
	finalSort 	:= sort(withEconTraj, seq, rec_type, did2);  //sort prospect record to the top (rec_type = 1)
  finalRollup := rollup(finalSort, rollFinal(left,right), seq);
  //DEBUGGING
//   lexidset := [1653020855,2659294463,599717915,1287522558,1952185820,719039845,2661278680,246971484,2643889651,952420953,1376746128];

  // OUTPUT(CHOOSEN(PB2_In,100),named('V2GP_PB2_In'));
  // OUTPUT(CHOOSEN(p_address,100),named('V2GP_p_address'));
  // OUTPUT(CHOOSEN(slimShell(did IN lexidset),100),named('V2GP_slimShell'));
  // OUTPUT(CHOOSEN(prop_common(did IN lexidset),100),named('V2GP_prop_common'));
  // OUTPUT(CHOOSEN(withAVM(did IN lexidset),100),named('V2GP_withAVM'));
  // OUTPUT(CHOOSEN(withProperty(did IN lexidset),100),named('V2GP_withProperty_sampleDIDS'));
  // OUTPUT(CHOOSEN(rolledProperty(did IN lexidset),100),named('V2GP_rolledProperty_sampleDIDS'));
  // OUTPUT(CHOOSEN(econTraj(did IN lexidset),100),named('V2GP_econTraj_sampleDIDS'));
  // OUTPUT(CHOOSEN(withEconTraj(did IN lexidset),100),named('V2GP_withEconTraj_sampleDIDS'));
  // OUTPUT(CHOOSEN(finalSort(did IN lexidset),100),named('V2GP_finalSort'));
  // OUTPUT(CHOOSEN(finalRollup(did IN lexidset),100),named('V2GP_finalRollup'));
  // OUTPUT(COUNT(PB2_In(curraddrlat<>'')),named('V2GP_In_CurrAddrLatCnt'));
  // OUTPUT(COUNT(finalRollup(curraddrlat<>'')),named('V2GP_Out_CurrAddrLatCnt'));
  // OUTPUT(CHOOSEN(withEconTraj,100),named('V2GP_Out_withEconTraj'));
  // OUTPUT(CHOOSEN(econTraj,100),named('V2GP_Out_econTraj'));
  // OUTPUT(COUNT(withEconTraj),named('V2GP_Out_withEconTrajCnt'));
  // OUTPUT(COUNT(finalRollup),named('V2GP_Out_finalRollupCnt'));

  // OUTPUT(prop_common,,'~jfrancis::profilebooster20::V2_getProperty_prop_common_' + thorlib.wuid(),CSV(HEADING(single), QUOTE('"')));
  // OUTPUT(BSappended,,'~jfrancis::profilebooster20::V2_getProperty_BSappended' ,CSV(HEADING(single), QUOTE('"')));
  // OUTPUT(econTraj,,'~jfrancis::profilebooster20::V2_getProperty_econTraj' ,CSV(HEADING(single), QUOTE('"')));
  // OUTPUT(withEconTraj,,'~jfrancis::profilebooster20::V2_getProperty_withEconTraj' ,CSV(HEADING(single), QUOTE('"')));
  
  // OUTPUT(CHOOSEN(AVMrecs, 100), NAMED('AVMrecs'));
  // OUTPUT(CHOOSEN(withAVM, 100), NAMED('withAVM'));
  // OUTPUT(CHOOSEN(withAVMOwned_pre, 100), NAMED('withAVMOwned_pre'));
  // OUTPUT(CHOOSEN(withAVMOwned, 100), NAMED('withAVMOwned'));
  // OUTPUT(CHOOSEN(rolledAVMOwned, 100), NAMED('rolledAVMOwned'));
  // OUTPUT(CHOOSEN(finalRollup, 100), NAMED('finalRollupProperty'));
  RETURN finalRollup;
END;