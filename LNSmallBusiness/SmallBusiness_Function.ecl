import Models, Risk_Indicators, Business_Risk, RiskWise, Risk_Reporting, address, ut, iesp, Gateway, STD;


EXPORT SmallBusiness_Function(
    dataset(Layouts.RequestEx) indata,
    dataset(Gateway.Layouts.Config) gateways,
    boolean  Testseeds            = false,
    string20 Test_Data_Table_Name = '',
    string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
    string50 DataPermission=risk_indicators.iid_constants.default_DataPermission,
    unsigned1 LexIdSourceOptout = 1,
    string TransactionID = '',
    string BatchUID = '',
    unsigned6 GlobalCompanyId = 0
) := FUNCTION

	//Experian Sources ER and Q3 cannot be used for services that deal with commercial credit origination
	BOOLEAN RESTRICT_EXPERIAN := TRUE;

	// this expression fails when trying to deploy ('Attempting to lookup field name in a dataset which has no active element'):
	// model_name   := indata[1].servicelocations[1].parameters( Name='model' )[1].value;
	// therefore, we're forced to not do a filter and simply assume the first parameter is the model:
	in_model_name   := indata[1].servicelocations[1].parameters[1].value;

	model_name := case( in_model_name,
		'' => 'rvs811_0', // blank model name gets rewritten to the default model
		STD.Str.toLowerCase(in_model_name)
	);

	DPPA_Purpose := (integer)indata[1].user.dlpurpose;
	GLB_Purpose  := (integer)indata[1].user.glbpurpose;
	
	risk_indicators.Layout_Input build_iid_prep( indata le ) := TRANSFORM
		fulladdr := if( trim(le.searchby.owneragent.address.streetaddress1) != '', le.searchby.owneragent.address.streetaddress1,
			risk_indicators.MOD_AddressClean.street_address('',
				le.searchby.owneragent.address.StreetNumber,
				le.searchby.owneragent.address.StreetPreDirection,
				le.searchby.owneragent.address.StreetName,
				le.searchby.owneragent.address.StreetSuffix,
				le.searchby.owneragent.address.StreetPostDirection,
				le.searchby.owneragent.address.UnitDesignation,
				le.searchby.owneragent.address.UnitNumber
			)
		);
	
		clean_addr := risk_indicators.MOD_AddressClean.clean_addr(
			fulladdr,
			le.searchby.owneragent.address.City,
			le.searchby.owneragent.address.State,
			le.searchby.owneragent.address.Zip5
		);														
	
		// self.seq              := (integer)le.user.queryid;
		// self.seq              := (integer)le.user.relatedtransactionid;
		self.seq              := le.seq;
		self.historydate 			:= le.historydate;
		// self.DID              := ;
		// self.score            := ;
		
		/* Name */
		// not used: name.full
		
		cleanName := address.CleanPerson73( le.searchby.owneragent.name.full );
		title := trim(cleanName[1..5]);
		fname := trim(cleanName[6..25]);
		mname := trim(cleanName[26..45]);
		lname := trim(cleanName[46..65]);
		suffix:= trim(cleanName[66..70]);
		
		string pickName( string cleaned, string input ) := if( input='', cleaned, input );
		
		
		
		self.title            := pickName( title, le.searchby.owneragent.name.prefix );
		self.fname            := pickName( fname, le.searchby.owneragent.name.first );
		self.mname            := pickName( mname, le.searchby.owneragent.name.middle );
		self.lname            := pickName( lname, le.searchby.owneragent.name.last );
		self.suffix           := pickName( suffix, le.searchby.owneragent.name.suffix );
                                        
		self.in_streetAddress := fulladdr;
		self.in_city          := le.searchby.owneragent.address.city;
		self.in_state         := le.searchby.owneragent.address.state;
		self.in_zipCode       := le.searchby.owneragent.address.zip5;
		// self.in_country       := ;
		
		self.prim_range       := clean_addr[1..10];
		self.predir           := clean_addr[11..12];
		self.prim_name        := clean_addr[13..40];
		self.addr_suffix      := clean_addr[41..44];
		self.postdir          := clean_addr[45..46];
		self.unit_desig       := clean_addr[47..56];
		self.sec_range        := clean_addr[57..64];
		self.p_city_name      := clean_addr[90..114];
		self.st               := clean_addr[115..116];
		self.z5               := clean_addr[117..121];
		self.zip4             := clean_addr[122..125];
		self.county           := clean_addr[143..145];
		self.lat              := clean_addr[146..155];
		self.long             := clean_addr[156..166];
		self.addr_type        := clean_addr[139];
		self.geo_blk          := clean_addr[171..177];
		self.addr_status      := clean_addr[179..182];
		// self.orig_city        := STD.Str.touppercase(le.city);
		// self.orig_st          := STD.Str.touppercase(le.state);
		// self.orig_z5          := le.zip[1..5];

		self.ssn              := RiskWise.CleanSSN( le.searchby.owneragent.ssn );
		self.dob              := intformat( (integer)le.searchby.owneragent.dob.year, 4, 1)
		                         + intformat( (integer)le.searchby.owneragent.dob.month, 2, 1)
		                         + intformat( (integer)le.searchby.owneragent.dob.day, 2, 1 );
		// self.age              := if((integer)dob_val != 0, (STRING3)(ut.GetAgeI((integer)dob_val)), '');
		// self.age              := le.searchby.owneragent.age;                
		self.dl_number        := STD.Str.touppercase(le.searchby.owneragent.driverlicensenumber);
		self.dl_state         := STD.Str.touppercase(le.searchby.owneragent.driverlicensestate);
		// self.email_address    := ;        


		// self.ip_address       := le.searchby.ipaddress;
		self.phone10          := RiskWise.cleanphone( le.searchby.owneragent.phone10 );
		self.wphone10         := RiskWise.cleanphone( le.searchby.business.phone10 );
		// self.employer_name    := ;
		// self.lname_prev       := ;

		self := [];
	END;
	iid_prep := project( indata, build_iid_prep(LEFT) );

	bsVersion := 2;
	derogs    := true;
	relatives := true;
	vehicles  := false;
	dl        := false;

	iid := risk_indicators.InstantID_Function(iid_prep, gateways, DPPA_Purpose, GLB_Purpose, in_ln_branded:=false, in_bsVersion:=BSversion, in_DataRestriction := DataRestriction, in_DataPermission := DataPermission,
                                                                        LexIdSourceOptout := LexIdSourceOptout, 
                                                                        TransactionID := TransactionID, 
                                                                        BatchUID := BatchUID, 
                                                                        GlobalCompanyID := GlobalCompanyID);
	clam := ungroup(risk_indicators.Boca_Shell_Function(iid, gateways, DPPA_Purpose, GLB_Purpose, 
								includeRelativeInfo := true, includeDLInfo := dl, includeVehInfo := vehicles, includeDerogInfo := derogs, BSversion:=BSversion, DataRestriction:=DataRestriction, DataPermission := DataPermission,
                                LexIdSourceOptout := LexIdSourceOptout, 
                                TransactionID := TransactionID, 
                                BatchUID := BatchUID, 
                                GlobalCompanyID := GlobalCompanyID));

	business_risk.Layout_Input build_biid_prep(indata le) := transform
		fullBusAddr := risk_indicators.MOD_AddressClean.street_address(
			le.searchby.business.address.streetaddress1,
			le.searchby.business.address.StreetNumber,
			le.searchby.business.address.StreetPreDirection,
			le.searchby.business.address.StreetName,
			le.searchby.business.address.StreetSuffix,
			le.searchby.business.address.StreetPostDirection,
			le.searchby.business.address.UnitDesignation,
			le.searchby.business.address.UnitNumber
		);
		
		
		// in the event the city/state/zip5 components are unpopulated, use the full StateCityZip
		clean_bus_addr := if( le.searchby.business.address.city='' and le.searchby.business.address.state='' and le.searchby.business.address.zip5='',
			Address.CleanAddress182(fullBusAddr, le.searchby.business.address.statecityzip),
			Risk_Indicators.MOD_AddressClean.clean_addr( fullBusAddr, le.searchby.business.address.city, le.searchby.business.address.state, le.searchby.business.address.zip5 )
		);


		fullRepAddr := risk_indicators.MOD_AddressClean.street_address(
			le.searchby.owneragent.address.streetaddress1,
			le.searchby.owneragent.address.StreetNumber,
			le.searchby.owneragent.address.StreetPreDirection,
			le.searchby.owneragent.address.StreetName,
			le.searchby.owneragent.address.StreetSuffix,
			le.searchby.owneragent.address.StreetPostDirection,
			le.searchby.owneragent.address.UnitDesignation,
			le.searchby.owneragent.address.UnitNumber
		);
		
		clean_rep_addr := if( le.searchby.owneragent.address.city='' and le.searchby.owneragent.address.state='' and le.searchby.owneragent.address.zip5='',
			Address.CleanAddress182( fullRepAddr, le.searchby.owneragent.address.statecityzip ),
			Risk_Indicators.MOD_AddressClean.clean_addr(fullRepAddr, le.searchby.owneragent.address.city, le.searchby.owneragent.address.state, le.searchby.owneragent.address.zip5 )
		);
		
		self.seq              := le.seq;
		self.Account          := le.user.AccountNumber;;
		// self.bdid             := (integer)BDID_value;
		self.score            := 0;
		self.company_name     := STD.Str.touppercase(le.searchby.business.name);
		self.alt_company_name := STD.Str.touppercase(le.searchby.business.alternatename);
		self.prim_range       := clean_bus_addr[1..10];
		self.predir           := clean_bus_addr[11..12];
		self.prim_name        := clean_bus_addr[13..40];
		self.addr_suffix      := clean_bus_addr[41..44];
		self.postdir          := clean_bus_addr[45..46];
		self.unit_desig       := clean_bus_addr[47..56];
		self.sec_range        := clean_bus_addr[57..64];
		self.p_city_name      := clean_bus_addr[65..89];
		self.v_city_name      := clean_bus_addr[90..114];
		self.st               := clean_bus_addr[115..116];
		self.z5               := clean_bus_addr[117..121];     
		self.zip4             := clean_bus_addr[122..125];
		self.orig_z5          := le.searchby.business.address.zip5;
		self.lat              := clean_bus_addr[146..155];
		self.long             := clean_bus_addr[156..166];
		self.addr_type        := clean_bus_addr[139];
		self.addr_status      := clean_bus_addr[179..182];
		self.county           := clean_bus_addr[143..145];
		self.geo_blk          := clean_bus_addr[171..177];
		self.fein             := le.searchby.business.fein;
		self.phone10          := RiskWise.cleanphone( le.searchby.business.phone10 );
		// self.ip_addr          := bus_ip;
		
		
		cleanName := address.CleanPerson73( STD.Str.touppercase(le.searchby.owneragent.name.full) );
		title := trim(cleanName[1..5]);
		fname := trim(cleanName[6..25]);
		mname := trim(cleanName[26..45]);
		lname := trim(cleanName[46..65]);
		suffix:= trim(cleanName[66..70]);
		
		string pickName( string cleaned, string input ) := if( input='', cleaned, input );
		
		
		self.rep_fname        := pickName( fname, STD.Str.touppercase(le.searchby.owneragent.name.first));
		self.rep_mname        := pickName( mname, STD.Str.touppercase(le.searchby.owneragent.name.middle));
		self.rep_lname        := pickName( lname, STD.Str.touppercase(le.searchby.owneragent.name.last));
		self.rep_name_suffix  := pickName( suffix, STD.Str.touppercase(le.searchby.owneragent.name.suffix));
		// self.rep_alt_Lname    := STD.Str.touppercase(rep_alt_lname);
		self.rep_prim_range   := clean_rep_addr[1..10];
		self.rep_predir       := clean_rep_addr[11..12];
		self.rep_prim_name    := clean_rep_addr[13..40];
		self.rep_addr_suffix  := clean_rep_addr[41..44];
		self.rep_postdir      := clean_rep_addr[45..46];
		self.rep_unit_desig   := clean_rep_addr[47..56];
		self.rep_sec_range    := clean_rep_addr[57..64];
		self.rep_p_city_name  := clean_rep_addr[65..89];
		self.rep_st           := clean_rep_addr[115..116];
		self.rep_z5           := clean_rep_addr[117..121];
		self.rep_orig_city    := STD.Str.touppercase(le.searchby.owneragent.address.city);
		self.rep_orig_st      := STD.Str.touppercase(le.searchby.owneragent.address.state);
		self.rep_orig_z5      := le.searchby.owneragent.address.zip5;
		self.rep_zip4         := clean_rep_addr[122..125];
		self.rep_lat          := clean_rep_addr[146..155];
		self.rep_long         := clean_rep_addr[156..166];
		self.rep_addr_type    := clean_rep_addr[139];
		self.rep_addr_status  := clean_rep_addr[179..182];
		self.rep_ssn          := RiskWise.CleanSSN( le.searchby.owneragent.ssn );
		self.rep_dob          := intformat( (integer)le.searchby.owneragent.dob.year, 4, 1)
		                         + intformat( (integer)le.searchby.owneragent.dob.month, 2, 1)
		                         + intformat( (integer)le.searchby.owneragent.dob.day, 2, 1 );
		self.rep_phone        := RiskWise.cleanphone( le.searchby.owneragent.phone10 );
		// self.rep_age          := (string)rep_age; // need to calculate this?
		self.rep_dl_num       := le.searchby.owneragent.driverlicensenumber;
		self.rep_dl_state     := STD.Str.touppercase(le.searchby.owneragent.driverlicensestate);
		// self.rep_email        := STD.Str.touppercase(rep_email);
		self.historydate := le.historydate;
	end;
	biid_prep := project(indata, build_biid_prep(LEFT));
	biid := business_risk.InstantID_Function(biid_prep, gateways, false /*hasbdids*/, dppa_purpose, glb_purpose,
                                                                          DataPermission:=DataPermission, 
                                                                          RestrictExperianData:=RESTRICT_EXPERIAN,
                                                                          LexIdSourceOptout := LexIdSourceOptout, 
                                                                          TransactionID := TransactionID, 
                                                                          BatchUID := BatchUID, 
                                                                          GlobalCompanyID := GlobalCompanyID);
                                                                          
	bshell := Business_Risk.Business_Shell_Function(biid, GLB_Purpose,
                                                                                           LexIdSourceOptout := LexIdSourceOptout, 
                                                                                           TransactionID := TransactionID, 
                                                                                           BatchUID := BatchUID, 
                                                                                           GlobalCompanyID := GlobalCompanyID,
                                                                                           DataPermission := DataPermission);

	model := case( model_name,
		'rvs811_0' => Models.RVS811_0_0( clam, bshell ),
		dataset( [], LNSmallBusiness.Layouts.Model_With_Seq )
	);
	
	Layouts.ResponseEx addModel( indata le, model ri ) := TRANSFORM
		self.seq := le.seq;
		self.AcctNo := le.AcctNo;
		self.result.inputecho := le.searchby;

		// 'ri' is a record of type LNSmallBusiness.Layouts.Model_With_Seq (has a sequence included for the purpose of this join).
		// However, self.response.result.models is a dataset of type riskview.t_SmallBusinessModelHRI.
		// To reconcile, convert ri to a dataset:
		ds_ri := dataset([ri], LNSmallBusiness.Layouts.Model_With_Seq);
		// then project into the appropriate layout
		mdl := project( ds_ri,  transform( iesp.ws_analytics.t_SmallBusinessModelHRI , self := left ) );

		self.result.models   := mdl;
		self._header.queryid := (string)le.user.accountnumber;
		self := [];
	END;
	
	withModel := join( indata, model, left.seq = right.seq, addModel(left,right), left outer, keep(1) );
	
  withbdid := join(withModel, bshell, left.seq = right.biid.seq, TRANSFORM({UNSIGNED6 rep_did, unsigned bdid, recordof(LEFT)},
                                                                           SELF.rep_did := 0,
                                                                           SELF.bdid := RIGHT.biid.bdid,
                                                                           SELF := LEFT),
                                                                       LEFT OUTER, KEEP(1));
                                                                       
  withdid := join(withbdid, iid, left.seq = right.seq, TRANSFORM({recordof(LEFT)}, SELF.rep_did := right.did, SELF := LEFT), LEFT OUTER, KEEP(1));

	// get seeds
	seeds := PROJECT(SmallBusiness_Testseed_Function( indata, model_name, Test_Data_Table_Name ), TRANSFORM({UNSIGNED6 rep_did, unsigned bdid, recordof(LEFT)}, SELF := LEFT, SELF := []));
	final := if( testseeds, seeds, withdid );
	
 /* *************************************
  *   Boca Shell Logging Functionality  *
  * NOTE: Because of the #stored below  *
  * this MUST go at the end of this     *
  * function in order to compile.       *
  ***************************************/
	productID := Risk_Reporting.ProductID.LNSmallBusiness__SmallBusiness_Service;
	
	intermediate_Log := Risk_Reporting.To_LOG_Boca_Shell(GROUP(clam, seq), productID, bsVersion);
	#stored('Intermediate_Log', intermediate_log);
 /* ************ End Logging ************/

	return final;
END;