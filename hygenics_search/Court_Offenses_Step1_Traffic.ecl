import crimsrch;

dCourtOffensesNoTraffic		:= Court_Offenses_as_CrimSrch_Offenses(Vendor in sCourt_Vendors_With_No_Traffic);
dCourtOffensesOnlyTraffic 	:= Court_Offenses_as_CrimSrch_Offenses(Vendor in sCourt_Vendors_With_Only_Traffic);
dCourtOffensesMixedTraffic	:= Court_Offenses_as_CrimSrch_Offenses((Vendor not in sCourt_Vendors_With_No_Traffic) and (Vendor not in sCourt_Vendors_With_Only_Traffic));

	CrimSrch.Layout_Moxie_Offenses_temp tJoinForTrafficFlag(CrimSrch.Layout_Moxie_Offenses_temp pOffense, Layout_Traffic_Lookup pLookup) := transform
		self.fcra_traffic_flag 	:= if(pOffense.FCRA_Traffic_Flag = 'Y',
									  pOffense.FCRA_Traffic_Flag,
									  if(pLookup.Vendor<>'',
										 'Y',
										 'N'));
		self					:=	pOffense;
	end;
	
dCourtOffensesMixedTrafficByOffense 	:= dCourtOffensesMixedTraffic(Vendor not in sCourt_Vendors_With_Traffic_Based_Upon_Off_Lev and Vendor not in sCourt_Vendors_With_Traffic_Based_Upon_Offender_Key);
dCourtOffensesMixedTrafficByOffense1	:= join(dCourtOffensesMixedTrafficByOffense,File_Traffic_lookup(Court_Statute<>''),
												left.Vendor = right.Vendor
											and left.Court_Statute = right.Court_Statute,
												tJoinForTrafficFlag(left,right),
												left outer, lookup);
dCourtOffensesMixedTrafficByOffense2	:= join(dCourtOffensesMixedTrafficByOffense1,File_Traffic_lookup(Court_Statute_Desc<>''),
												left.Vendor = right.Vendor
											and left.Court_Statute_Desc = right.Court_Statute_Desc,
												tJoinForTrafficFlag(left,right),
												left outer, lookup);
dCourtOffensesMixedTrafficByOffense3	:= join(dCourtOffensesMixedTrafficByOffense2,File_Traffic_lookup(Court_Off_Desc_1<>''),
												left.Vendor = right.Vendor
											and left.Court_Off_Desc[1..70] = right.Court_Off_Desc_1,
												tJoinForTrafficFlag(left,right),
												left outer, lookup);

	CrimSrch.Layout_Moxie_Offenses_temp tSetTrafficFlagByOffenseLevel(CrimSrch.Layout_Moxie_Offenses_temp pOffense) := transform
		self.fcra_traffic_flag 	:= fTraffic_Flag_From_Vendor_and_Offense_Level(pOffense.Vendor,pOffense.Court_Off_Level);
		self					:= pOffense;
	end;
	
dCourtOffensesMixedTrafficByLevel	:= dCourtOffensesMixedTraffic(Vendor in sCourt_Vendors_With_Traffic_Based_Upon_Off_Lev);
dCourtOffensesMixedTrafficByLevel1	:= project(dCourtOffensesMixedTrafficByLevel,tSetTrafficFlagByOffenseLevel(left));

	CrimSrch.Layout_Moxie_Offenses_temp tSetTrafficFlagByOffenderKey(CrimSrch.Layout_Moxie_Offenses_temp pOffense) := transform
		self.fcra_traffic_flag 	:= fTraffic_Flag_From_Vendor_and_Offender_Key(pOffense.Vendor,pOffense.Offender_Key);
		self					:= pOffense;
	end;
	
dCourtOffensesMixedTrafficByOffenderKey		:= dCourtOffensesMixedTraffic(Vendor in sCourt_Vendors_With_Traffic_Based_Upon_Offender_Key);
dCourtOffensesMixedTrafficByOffenderKey1	:= project(dCourtOffensesMixedTrafficByOffenderKey,tSetTrafficFlagByOffenderKey(left));

#if(CrimSrch.Switch_ShouldUsePersists = CrimSrch.Switch_YesValue)
	export Court_Offenses_Step1_Traffic
	 := dCourtOffensesNoTraffic
	 +	dCourtOffensesOnlyTraffic
	 +	dCourtOffensesMixedTrafficByOffense3
	 +	dCourtOffensesMixedTrafficByLevel1
	 +  dCourtOffensesMixedTrafficByOffenderKey1
	 :	persist('Persist::CrimSrch_Court_Offenses_Fixed_Traffic');
#else
	export Court_Offenses_Step1_Traffic
	 := dCourtOffensesNoTraffic
	 +	dCourtOffensesOnlyTraffic
	 +	dCourtOffensesMixedTrafficByOffense3
	 +	dCourtOffensesMixedTrafficByLevel1
	 +  dCourtOffensesMixedTrafficByOffenderKey1;
#end