import risk_indicators, seed_files, iesp;

export SmallBusiness_Testseed_Function(
	dataset(Layouts.RequestEx) indata,
	STRING model_name,
	STRING table_name
) := FUNCTION

	Layouts.ResponseEx GetSeeds( indata le, seed_files.Key_LNSmallBusiness ri ) := TRANSFORM
		self.seq := le.seq;
		self.AcctNo := ri.AcctNo;
		
		self.Result.InputEcho.business.name := ri.bus_name;
		self.Result.InputEcho.business.alternatename := ri.bus_altname;
		
		self.Result.InputEcho.Business.Address.streetname          := ri.bus_streetname;
		self.Result.InputEcho.Business.Address.streetnumber        := ri.bus_streetnumber;
		self.Result.InputEcho.Business.Address.streetpredirection  := ri.bus_streetpredirection;
		self.Result.InputEcho.Business.Address.streetpostdirection := ri.bus_streetpostdirection;
		self.Result.InputEcho.Business.Address.streetsuffix        := ri.bus_streetsuffix;
		self.Result.InputEcho.Business.Address.unitdesignation     := ri.bus_unitdesignation;
		self.Result.InputEcho.Business.Address.unitnumber          := ri.bus_unitnumber;
		self.Result.InputEcho.Business.Address.streetaddress1      := ri.bus_streetaddress1;
		self.Result.InputEcho.Business.Address.streetaddress2      := ri.bus_streetaddress2;
		self.Result.InputEcho.Business.Address.state               := ri.bus_state;
		self.Result.InputEcho.Business.Address.city                := ri.bus_city;
		self.Result.InputEcho.Business.Address.zip5                := ri.bus_zip5;
		self.Result.InputEcho.Business.Address.zip4                := ri.bus_zip4;
		self.Result.InputEcho.Business.Address.county              := ri.bus_county;
		self.Result.InputEcho.Business.Address.postalcode          := ri.bus_postalcode;
		self.Result.InputEcho.Business.Address.statecityzip        := ri.bus_statecityzip;

		self.Result.InputEcho.Business.fein    := ri.bus_fein;
		self.Result.InputEcho.Business.phone10 := ri.bus_phone10;



		self.Result.InputEcho.OwnerAgent.Name.full      := ri.rep_fullname;
		self.Result.InputEcho.OwnerAgent.Name.first     := ri.rep_first;
		self.Result.InputEcho.OwnerAgent.Name.middle    := ri.rep_middle;
		self.Result.InputEcho.OwnerAgent.Name.last      := ri.rep_last;
		self.Result.InputEcho.OwnerAgent.Name.suffix    := ri.rep_suffix;
		self.Result.InputEcho.OwnerAgent.Name.prefix    := ri.rep_prefix;

		self.Result.InputEcho.OwnerAgent.Address.streetname          := ri.rep_streetname;
		self.Result.InputEcho.OwnerAgent.Address.streetnumber        := ri.rep_streetnumber;
		self.Result.InputEcho.OwnerAgent.Address.streetpredirection  := ri.rep_streetpredirection;
		self.Result.InputEcho.OwnerAgent.Address.streetpostdirection := ri.rep_streetpostdirection;
		self.Result.InputEcho.OwnerAgent.Address.streetsuffix        := ri.rep_streetsuffix;
		self.Result.InputEcho.OwnerAgent.Address.unitdesignation     := ri.rep_unitdesignation;
		self.Result.InputEcho.OwnerAgent.Address.unitnumber          := ri.rep_unitnumber;
		self.Result.InputEcho.OwnerAgent.Address.streetaddress1      := ri.rep_streetaddress1;
		self.Result.InputEcho.OwnerAgent.Address.streetaddress2      := ri.rep_streetaddress2;
		self.Result.InputEcho.OwnerAgent.Address.state               := ri.rep_state;
		self.Result.InputEcho.OwnerAgent.Address.city                := ri.rep_city;
		self.Result.InputEcho.OwnerAgent.Address.zip5                := ri.rep_zip5;
		self.Result.InputEcho.OwnerAgent.Address.zip4                := ri.rep_zip4;
		self.Result.InputEcho.OwnerAgent.Address.county              := ri.rep_county;
		self.Result.InputEcho.OwnerAgent.Address.postalcode          := ri.rep_postalcode;
		self.Result.InputEcho.OwnerAgent.Address.statecityzip        := ri.rep_statecityzip;


		self.Result.InputEcho.OwnerAgent.SSN                 := ri.rep_ssn;
		self.Result.InputEcho.OwnerAgent.DOB.year            := (integer)ri.rep_dob_year;
		self.Result.InputEcho.OwnerAgent.DOB.month           := (integer)ri.rep_dob_month;
		self.Result.InputEcho.OwnerAgent.DOB.day             := (integer)ri.rep_dob_day;
		self.Result.InputEcho.OwnerAgent.phone10             := ri.rep_phone10;
		self.Result.InputEcho.OwnerAgent.driverlicensenumber := ri.rep_driverlicensenumber;
		self.Result.InputEcho.OwnerAgent.driverlicensestate  := ri.rep_driverlicensestate;
		
		bizrc1 := dataset( [ {ri.bus_rc11, ri.bus_desc11 },{ri.bus_rc21, ri.bus_desc21 },{ri.bus_rc31, ri.bus_desc31 },{ri.bus_rc41, ri.bus_desc41} ], iesp.share.t_RiskIndicator );
		reprc1 := dataset( [ {ri.rep_rc11, ri.rep_desc11 },{ri.rep_rc21, ri.rep_desc21 },{ri.rep_rc31, ri.rep_desc31 },{ri.rep_rc41, ri.rep_desc41} ], iesp.share.t_RiskIndicator );
		bizrc1_filtered := bizrc1( trim(riskcode) not in ['','00'] );
		reprc1_filtered := reprc1( trim(riskcode) not in ['','00'] );
		sb_scores1 := dataset( [ { ri.type1, ri.score1, ri.index1, bizrc1_filtered, reprc1_filtered } ], iesp.ws_analytics.t_SmallBusinessScoreHRI );
		sb_models1 := dataset( [ { ri.name1, ri.modeldescription1, sb_scores1 } ], iesp.ws_analytics.t_SmallBusinessModelHRI );
		
		bizrc2 := dataset( [ {ri.bus_rc12, ri.bus_desc12 },{ri.bus_rc22, ri.bus_desc22 },{ri.bus_rc32, ri.bus_desc32 },{ri.bus_rc42, ri.bus_desc42} ], iesp.share.t_RiskIndicator );
		reprc2 := dataset( [ {ri.rep_rc12, ri.rep_desc12 },{ri.rep_rc22, ri.rep_desc22 },{ri.rep_rc32, ri.rep_desc32 },{ri.rep_rc42, ri.rep_desc42} ], iesp.share.t_RiskIndicator );
		bizrc2_filtered := bizrc2( trim(riskcode) not in ['','00'] );
		reprc2_filtered := reprc2( trim(riskcode) not in ['','00'] );
		sb_scores2 := dataset( [ { ri.type2, ri.score2, ri.index2, bizrc2_filtered, reprc2_filtered } ], iesp.ws_analytics.t_SmallBusinessScoreHRI );
		sb_models2 := dataset( [ { ri.name2, ri.modeldescription2, sb_scores2 } ], iesp.ws_analytics.t_SmallBusinessModelHRI );
		
		// include model2 only if it appears to be populated
		sb_models := if( ri.name2='', sb_models1, sb_models1+sb_models2 );
		self.Result.Models := sb_models;
		
		self := [];
	END;

	seeds := join( indata, seed_files.Key_LNSmallBusiness,
		KEYED( Seed_Files.Hash_InstantID(
				StringLib.StringToUpperCase(trim(left.searchby.owneragent.name.first)),
				StringLib.StringToUpperCase(trim(left.searchby.owneragent.name.last)),
				// SSN is not included in the RVFSB key, so don't pass in the rep ssn
				'', // left.searchby.owneragent.ssn,
				StringLib.StringToUpperCase(trim(left.searchby.business.fein)),
				StringLib.StringToUpperCase(trim(left.searchby.business.address.zip5)),
				StringLib.StringToUpperCase(trim(left.searchby.business.phone10)),
				StringLib.StringToUpperCase(trim(left.searchby.business.name))
			) = right.hashvalue )
		AND StringLib.StringToUpperCase(trim(model_name)) = StringLib.StringToUpperCase(trim(right.modelname))
		AND StringLib.StringToUpperCase(trim(table_name)) = StringLib.StringToUpperCase(trim(right.table_name)),
		GetSeeds(LEFT,RIGHT), left outer, keep(1)
	);
	
	return seeds;
END;