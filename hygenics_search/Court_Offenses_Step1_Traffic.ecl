import hygenics_crim, crimsrch;

dCourtOffensesNoTraffic			:= Court_Offenses_as_CrimSrch_Offenses(Vendor in sCourt_Vendors_With_No_Traffic);
dCourtOffensesOnlyTraffic 	:= Court_Offenses_as_CrimSrch_Offenses(Vendor in sCourt_Vendors_With_Only_Traffic);
dCourtOffensesMixedTraffic	:= Court_Offenses_as_CrimSrch_Offenses((Vendor not in sCourt_Vendors_With_No_Traffic) and (Vendor not in sCourt_Vendors_With_Only_Traffic));

	hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory tJoinForTrafficFlag(hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory pOffense, Layout_Traffic_Lookup pLookup) := transform
		self.fcra_traffic_flag 	:= if(pOffense.FCRA_Traffic_Flag = 'Y',
																pOffense.FCRA_Traffic_Flag,
															if(pLookup.Vendor<>'',
																'Y',
																'N'));
		self										:=	pOffense;
	end;
	

	hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory tSetTrafficFlagByOffenseLevel(hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory pOffense) := transform
		self.fcra_traffic_flag 	:= fTraffic_Flag_From_Vendor_and_Offense_Level(pOffense.Vendor,trim(pOffense.court_off_lev));
		self										:= pOffense;
	end;
	
//First use offense level 
dCourtOffensesMixedTrafficByLevel	    := dCourtOffensesMixedTraffic(Vendor in sCourt_Vendors_With_Traffic_Based_Upon_Off_Lev and court_off_lev <> '' and regexfind('[A-Za-z]',court_off_lev,0)<>'');
dCourtOffensesMixedTrafficByLevel1	  := project(dCourtOffensesMixedTrafficByLevel,tSetTrafficFlagByOffenseLevel(left));
// Then use traffic lookup.
dCourtOffensesMixedTrafficByOffense 	:= dCourtOffensesMixedTraffic(Vendor not in sCourt_Vendors_With_Traffic_Based_Upon_Off_Lev and Vendor not in sCourt_Vendors_With_Traffic_Based_Upon_Offender_Key) +
                                         //records from sources that have offense level but these specific records don't have valid offense level.
																				 dCourtOffensesMixedTraffic(Vendor in sCourt_Vendors_With_Traffic_Based_Upon_Off_Lev and (court_off_lev = '' or regexfind('[A-Za-z]',court_off_lev,0)='')); 
dCourtOffensesMixedTrafficByOffense1	:= join(dCourtOffensesMixedTrafficByOffense,File_Traffic_lookup(Court_Statute<>''),
																					left.Vendor = right.Vendor
																					and left.Court_Statute = right.Court_Statute,
																					tJoinForTrafficFlag(left,right),
																					left outer, lookup);
dCourtOffensesMixedTrafficByOffense2	:= join(dCourtOffensesMixedTrafficByOffense1,File_Traffic_lookup(Court_Statute_Desc<>''),
																					left.Vendor = right.Vendor
																					and left.Court_Off_Desc_1 = right.Court_Statute_Desc, //offenses are mapped only to Court_Off_Desc_1
																					tJoinForTrafficFlag(left,right),
																					left outer, lookup);
dCourtOffensesMixedTrafficByOffense3	:= join(dCourtOffensesMixedTrafficByOffense2,File_Traffic_lookup(Court_Off_Desc_1<>''),
																					left.Vendor = right.Vendor
																					and left.Court_Off_Desc_1[1..70] = right.Court_Off_Desc_1,
																					tJoinForTrafficFlag(left,right),
																					left outer, lookup);

//output(dCourtOffensesMixedTraffic(vendor ='Z1'));
	hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory tSetTrafficFlagByOffenderKey(hygenics_crim.Layout_Base_CourtOffenses_with_OffenseCategory pOffense) := transform
		self.fcra_traffic_flag 	:= MAP(pOffense.fcra_traffic_flag ='Y' => 'Y',
		                               fTraffic_Flag_From_Vendor_and_Offender_Key(pOffense.Vendor,pOffense.Offender_Key)
																	 );
		self										:= pOffense;
	end;
dCourtOffensesMixedTraffic_flagged1 := dCourtOffensesMixedTrafficByOffense3 +	dCourtOffensesMixedTrafficByLevel1 +
                                       //Inlcude records that did not get selected in offenselev and offense desc method - because they are purely based on offender key
                                       dCourtOffensesMixedTraffic(Vendor in hygenics_search.sCourt_Vendors_With_Traffic_Based_Upon_Offender_Key and Vendor NOT in hygenics_search.sCourt_Vendors_With_Traffic_Based_Upon_Off_Lev)+ 
																			 dCourtOffensesMixedTraffic(Vendor in hygenics_search.sCourt_Vendors_With_Traffic_Based_Upon_Offender_Key and 
																			                            Vendor in hygenics_search.sCourt_Vendors_With_Traffic_Based_Upon_Off_Lev and 
																			                            (court_off_lev = '' or regexfind('[A-Za-z]',court_off_lev,0)='')); 
																																	
dCourtOffensesMixedTrafficByOffenderKey		:= dCourtOffensesMixedTraffic_flagged1(Vendor in sCourt_Vendors_With_Traffic_Based_Upon_Offender_Key);
dCourtOffensesMixedTraffic_flagged2     	:= project(dCourtOffensesMixedTrafficByOffenderKey,tSetTrafficFlagByOffenderKey(left)) +
                                             dCourtOffensesMixedTraffic_flagged1(Vendor not in sCourt_Vendors_With_Traffic_Based_Upon_Offender_Key);

									
#if(CrimSrch.Switch_ShouldUsePersists = CrimSrch.Switch_YesValue)
	export Court_Offenses_Step1_Traffic
	 := dCourtOffensesNoTraffic
	 +	dCourtOffensesOnlyTraffic
	 +  dCourtOffensesMixedTraffic_flagged2
	 :	persist('Persist::CrimSrch_Court_Offenses_Fixed_Traffic');
#else
	export Court_Offenses_Step1_Traffic
	 := dCourtOffensesNoTraffic
	 +	dCourtOffensesOnlyTraffic
	 +	dCourtOffensesMixedTraffic_flagged2;
#end