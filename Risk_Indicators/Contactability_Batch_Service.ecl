/*--SOAP--
<message name="Contactability Batch Service" wuTimeout="300000">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="model" type="xsd:string"/>
 </message>
*/

/*--INFO-- Uses collections shell to produce a contactability score */

/*--HELP--
<pre>Batch input:
&lt;dataset&gt;
	&lt;row&gt;
		&lt;seq&gt;&lt;/seq&gt;
		&lt;acctno&gt;&lt;/acctno&gt;
		&lt;ssn&gt;&lt;/ssn&gt;
		&lt;unparsedfullname&gt;&lt;/unparsedfullname&gt;
		&lt;name_first&gt;&lt;/name_first&gt;
		&lt;name_middle&gt;&lt;/name_middle&gt;
		&lt;name_last&gt;&lt;/name_last&gt;
		&lt;name_suffix&gt;&lt;/name_suffix&gt;
		&lt;dob&gt;&lt;/dob&gt;
		&lt;street_addr&gt;&lt;/street_addr&gt;
		&lt;prim_range&gt;&lt;/prim_range&gt;
		&lt;predir&gt;&lt;/predir&gt;
		&lt;prim_name&gt;&lt;/prim_name&gt;
		&lt;suffix&gt;&lt;/suffix&gt;
		&lt;postdir&gt;&lt;/postdir&gt;
		&lt;unit_desig&gt;&lt;/unit_desig&gt;
		&lt;sec_range&gt;&lt;/sec_range&gt;
		&lt;p_city_name&gt;&lt;/p_city_name&gt;
		&lt;st&gt;&lt;/st&gt;
		&lt;z5&gt;&lt;/z5&gt;
		&lt;age&gt;&lt;/age&gt;
		&lt;dl_number&gt;&lt;/dl_number&gt;
		&lt;dl_state&gt;&lt;/dl_state&gt;
		&lt;home_phone&gt;&lt;/home_phone&gt;
		&lt;work_phone&gt;&lt;/work_phone&gt;
		&lt;ip_addr&gt;&lt;/ip_addr&gt;
	&lt;/row&gt;
&lt;/dataset&gt;

Valid models: csn1007_0_0
</pre>
*/
import AutoStandardI, risk_indicators, models, address;
 
export Contactability_Batch_Service := MACRO
  // Can't have duplicate definitions of Stored with different default values, 
  // so add the default to #stored to eliminate the assignment of a default value.
  #stored('DataPermissionMask',Risk_Indicators.iid_constants.default_DataPermission);

	unsigned1 DPPA_Purpose   := 0        : stored('DPPAPurpose');
	unsigned1 GLB_Purpose    := 8        : stored('GLBPurpose');
	industry_class_value     := '';
	unsigned3 in_history_date   := 999999   : stored('HistoryDateYYYYMM');
	boolean in_doScore          := false    : stored('IncludeScore');
	boolean in_ADL_Based_Shell  := false    : stored('ADL_Based_Shell');
	boolean in_RemoveFares      := false    : stored('RemoveFares');
	string50 in_DataRestriction := AutoStandardI.GlobalModule().DataRestrictionMask;
	string   in_DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
	string in_model             := '' : stored('model');

	batch_in                 := dataset([],Risk_Indicators.Layout_Batch_In) : STORED('batch_in',few);

	in_bsversion := 3;

	layout_acct := record
		string30 acctno;
		risk_indicators.Layout_Input;
	end;
	layout_acct into(batch_in l, integer i) := transform
		cleanedName 					:= StringLib.StringToUpperCase(Address.CleanPerson73(l.unparsedfullname));
		BOOLEAN validCleaned := cleanedName <> '';
		
		self.acctno           := l.acctno;
		self.seq              := i;
		SELF.in_streetAddress := l.street_addr;
		SELF.in_city          := l.p_city_name;
		SELF.in_state         := l.st;
		SELF.in_zipCode       := l.z5[1..5];
		self.ssn              := l.ssn;
		self.dob              := l.dob;
		self.phone10          := l.home_phone;
		self.title  					:= StringLib.StringToUppercase(if(validCleaned, cleanedName[1..5], ''));
		self.fname            := StringLib.StringToUppercase(if(l.Name_First='' AND validCleaned, cleanedName[6..25], l.Name_First));
		self.mname            := StringLib.StringToUppercase(if(l.Name_Middle='' AND validCleaned, cleanedName[26..45], l.Name_Middle));
		self.lname            := StringLib.StringToUppercase(if(l.Name_Last='' AND validCleaned, cleanedName[46..65], l.Name_Last));
		self.suffix           := StringLib.StringToUppercase(if(l.Suffix='' AND validCleaned, cleanedName[66..70], l.Suffix));
		clean_a2              := Risk_Indicators.MOD_AddressClean.clean_addr(l.street_addr, l.p_city_name, l.st, l.z5[1..5]);
		self.prim_range       := clean_a2[1..10];
		self.predir           := clean_a2[11..12];
		self.prim_name        := clean_a2[13..40];
		self.addr_suffix      := clean_a2[41..44];
		self.postdir          := clean_a2[45..46];
		self.unit_desig       := clean_a2[47..56];
		self.sec_range        := clean_a2[57..65];
		self.p_city_name      := clean_a2[90..114];
		self.st               := clean_a2[115..116];
		self.z5               := clean_a2[117..121];
		self.zip4             := clean_a2[122..125];
		self.lat              := clean_a2[146..155];
		self.long             := clean_a2[156..166];
		self.addr_type        := clean_a2[139];
		self.addr_status      := clean_a2[179..182];
		self.county           := clean_a2[143..145];
		self.geo_blk          := clean_a2[171..177];
		self.historydate := if(l.HistoryDateYYYYMM=0, in_history_date, l.historydateYYYYMM); 
		self                  := [];
	end;
	progressive_prep_acct := PROJECT(batch_in,into(LEFT, counter));
	progressive_prep := PROJECT( progressive_prep_acct, risk_indicators.layout_input);


	params := MODULE(risk_indicators.scoring_parameters)
		export dppa := DPPA_Purpose;
		export glb  := GLB_Purpose;
		export isUtility := false;
		export bsVersion := in_bsversion;
		export ln_branded := false;
		
		export isFCRA := false;
		export include_gong := true;
		export suppressNearDups := true;
		export require2ele := false;
		export from_biid := false;
		export from_IT1O := false;
		// turn watchlist searching off
			export ofac_only         := false;
			export excludeWatchlists := true;
			export ofac_version      := 1;
			export include_ofac      := false;
			export include_additional_watchlists := false;
		export global_watchlist_threshold := 0.84;
		export dob_radius := -1;
		export includeRelativeInfo := true;
		export includeDLInfo       := true;
		export includeVehInfo      := true;
		export includeDerogInfo    :=true;
		export nugenreasons        := true;
		// no gateways, don't want to incur transactional cost to targus on collection products
		// export gateways := dataset([],risk_indicators.Layout_Gateways_In);
		export DoScore := in_doScore;
		export DataRestriction := in_datarestriction;
		export RemoveFares := in_RemoveFares;
		export IncludeGong := true;
		export ADL_Based_Shell := in_ADL_Based_Shell;
		export string50 DataPermission := in_dataPermission;
	END;

	cclam := Risk_Indicators.Collection_Shell_Function( progressive_prep, params );
	
	model_out := case( StringLib.StringToLowerCase(trim(in_model)),
		'csn1007_0_0' => models.CSN1007_0_0( cclam ),
		dataset( [], models.layout_modelout )
	);
	
	layout_final := record
		string30 acctno;
		string3 score;
	end;
	final := join( progressive_prep_acct, model_out, left.seq=right.seq,
		transform( layout_final,
			self.score  := right.score,
			self.acctno := left.acctno
		), left outer, keep(1)
	);
	
	output(final, named('Results'));
ENDMACRO;

// Risk_Indicators.Contactability_Batch_Service();
