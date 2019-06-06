/*--SOAP--
<message name="Collection Shell Service" wuTimeout="300000">
	<part name="AccountNumber" type="xsd:string"/>
	<part name="FirstName" type="xsd:string"/>
	<part name="MiddleName" type="xsd:string"/>
	<part name="LastName" type="xsd:string"/>
	<part name="NameSuffix" type="xsd:string"/>
	<part name="StreetAddress" type="xsd:string"/>
	<part name="City" type="xsd:string"/>
	<part name="State" type="xsd:string"/>
	<part name="Zip" type="xsd:string"/>
	<part name="SSN" type="xsd:string"/>
	<part name="DateOfBirth" type="xsd:string"/>
	<part name="HomePhone" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="BSVersion" type="xsd:integer"/>
	<part name="model" type="xsd:string"/>
 </message>
*/

/*--INFO-- Puts Waterfall Phones and Bocashell together for collections modeling */
/*--HELP-- Valid models: 'csn1007_0' */

import AutoStandardI, risk_indicators, models;

export Collection_Shell_Service := MACRO

  // Can't have duplicate definitions of Stored with different default values, 
  // so add the default to #stored to eliminate the assignment of a default value.
  #stored('DataPermissionMask',risk_indicators.iid_constants.default_DataPermission);

	string30 account_value := '' 		: stored('AccountNumber');
	string30 fname_val := ''     		: stored('FirstName');
	string30 mname_val := ''     		: stored('MiddleName');
	string30 lname_val := ''     		: stored('LastName');
	string5 suffix_val := ''     		: stored('NameSuffix');
	string120 addr1_val := ''    		: stored('StreetAddress');
	string25 city_val := ''      		: stored('City');
	string2 state_val := ''      		: stored('State');
	string6 zip_value := '' 				: stored('Zip');
	string9 ssn_value := ''      		: stored('ssn');
	string8 dob_value := ''      		: stored('DateOfBirth');
	string10 phone_value := ''   		: stored('HomePhone');
	unsigned1 DPPA_Purpose := 0 		: stored('DPPAPurpose');
	unsigned1 GLB_Purpose := 8 		: stored('GLBPurpose');
	unsigned3 in_history_date := 999999 	: stored('HistoryDateYYYYMM');
	unsigned1 in_bsversion := 255			: stored('BSVersion');	
	boolean   in_doScore := false			: stored('IncludeScore');
	boolean   in_ADL_Based_Shell := false				: stored('ADL_Based_Shell');
	boolean   in_RemoveFares := false				: stored('RemoveFares');
	string10  in_DataRestriction := AutoStandardI.GlobalModule().DataRestrictionMask; 
  string 	  in_DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
	string    in_model := '' : stored('model');
	model := STD.Str.ToLowerCase(trim(in_model));
		
	rec := record
	  unsigned4 seq;
	end;
	r := dataset([{(unsigned)account_value}],rec);

	risk_indicators.Layout_Input into(rec l) := transform
		self.seq := l.seq;
		SELF.in_streetAddress := addr1_val;
		SELF.in_city := city_val;
		SELF.in_state := state_val;
		SELF.in_zipCode := zip_value[1..5];
		
		self.ssn := ssn_value;
		self.dob := dob_value;
		
		self.phone10 := phone_value;
		self.fname := STD.Str.ToUpperCase(fname_val);
		self.mname := STD.Str.ToUpperCase(mname_val);
		self.lname := STD.Str.ToUpperCase(lname_val);
		self.suffix := STD.Str.ToUpperCase(suffix_val);
		
		clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(addr1_val, city_val, state_val, zip_value[1..5]);
		self.prim_range := clean_a2[1..10];
		self.predir := clean_a2[11..12];
		self.prim_name := clean_a2[13..40];
		self.addr_suffix := clean_a2[41..44];
		self.postdir := clean_a2[45..46];
		self.unit_desig := clean_a2[47..56];
		self.sec_range := clean_a2[57..65];
		self.p_city_name := clean_a2[90..114];
		self.st := clean_a2[115..116];
		self.z5 := clean_a2[117..121];
		self.zip4 := clean_a2[122..125];
		self.lat := clean_a2[146..155];
		self.long := clean_a2[156..166];
		self.addr_type := clean_a2[139];
		self.addr_status := clean_a2[179..182];
		self.county := clean_a2[143..145];
		self.geo_blk := clean_a2[171..177];
		self.historydate := in_history_date;
		self := [];
	end;
	progressive_prep := PROJECT(r,into(LEFT));

	params := MODULE(risk_indicators.scoring_parameters)
		export unsigned1 dppa := DPPA_Purpose;
		export unsigned1 glb  := GLB_Purpose;
		export boolean isUtility := false;
		export unsigned1 bsVersion := in_bsversion;
		export boolean ln_branded := false;
		
		export boolean isFCRA := false;
		export boolean include_gong := true;
		export boolean suppressNearDups := true;
		export boolean require2ele := false;
		export boolean from_biid := false;
		export boolean from_IT1O := false;
		// turn watchlist searching off
			export boolean ofac_only         := false;
			export boolean excludeWatchlists := true;
			export unsigned1 ofac_version      := 1;
			export boolean include_ofac      := false;
			export boolean include_additional_watchlists := false;
		export real global_watchlist_threshold := 0.84;
		export integer2 dob_radius := -1;
		export boolean includeRelativeInfo := true;
		export boolean includeDLInfo       := true;
		export boolean includeVehInfo      := true;
		export boolean includeDerogInfo    := true;
		export boolean nugenreasons        := true;
		// no gateways, don't want to incur transactional cost to targus on collection products
		// export gateways := dataset([],risk_indicators.Layout_Gateways_In);
		export boolean DoScore := in_doScore;
		export string50 DataRestriction := in_datarestriction;
		export boolean RemoveFares := in_RemoveFares;
		export boolean IncludeGong := true;
		export boolean ADL_Based_Shell := in_adl_based_shell;
		export unsigned1 AppendBest := 1;
		export string50 DataPermission := in_dataPermission;
	END;

	coll_shell := Risk_Indicators.Collection_Shell_Function( progressive_prep, params );
	
	model_result := case( model,
		'csn1007_0' => models.CSN1007_0_0( coll_shell ),
		''          => dataset( [], Models.Layout_ModelOut ),
	fail( Models.Layout_ModelOut, 'Invalid model name requested' ) );
	
	with_model := join( coll_shell, model_result, left.seq=right.seq,
		transform( recordof(left), self.cs.contactability_score := right.score, self := left ), keep(1)
	);

	final := if( model='', coll_shell, with_model );
	output(final, named('Results'));

ENDMACRO;


// Risk_Indicators.Collection_Shell_Service();
