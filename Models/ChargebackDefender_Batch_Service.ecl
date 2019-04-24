/*--SOAP--
<message name="ChargebackDefender Batch Service">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="20"/>
	<part name="IdentityVersion" type="xsd:integer"/>
	<part name="RelationshipVersion" type="xsd:integer"/>
	<part name="VelocityVersion" type="xsd:integer"/>
	<part name="ipid_only" type="xsd:boolean"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="IndustryClass" type="xsd:string"/>
	<part name="ModelName" type="xsd:string"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="10"/>
	<part name="ReturnDetailedRoyalties" type="xsd:boolean"/>	
</message>
*/
/*--INFO-- Contains Attributes Version 1 and room for 3 scores*/
/*--HELP-- 
<pre>&lt;batch_in&gt;
   &lt;row&gt;
      &lt;seq&gt;&lt;/seq&gt;
      &lt;acctno&gt;&lt;/acctno&gt;
      &lt;name_first&gt;&lt;/name_first&gt;
      &lt;name_middle&gt;&lt;/name_middle&gt;
      &lt;name_last&gt;&lt;/name_last&gt;
      &lt;name_suffix&gt;&lt;/name_suffix&gt;
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
      &lt;home_phone&gt;&lt;/home_phone&gt;
      &lt;ssn&gt;&lt;/ssn&gt;
      &lt;email&gt;&lt;/email&gt;
      &lt;dl_number&gt;&lt;/dl_number&gt;
      &lt;dl_state&gt;&lt;/dl_state&gt;

      &lt;name_first_2&gt;&lt;/name_first_2&gt;
      &lt;name_middle_2&gt;&lt;/name_middle_2&gt;
      &lt;name_last_2&gt;&lt;/name_last_2&gt;
      &lt;name_suffix_2&gt;&lt;/name_suffix_2&gt;
      &lt;street_addr2&gt;&lt;/street_addr2&gt;
      &lt;prim_range_2&gt;&lt;/prim_range_2&gt;
      &lt;predir_2&gt;&lt;/predir_2&gt;
      &lt;prim_name_2&gt;&lt;/prim_name_2&gt;
      &lt;suffix_2&gt;&lt;/suffix_2&gt;
      &lt;postdir_2&gt;&lt;/postdir_2&gt;
      &lt;unit_desig_2&gt;&lt;/unit_desig_2&gt;
      &lt;sec_range_2&gt;&lt;/sec_range_2&gt;
      &lt;city_2&gt;&lt;/city_2&gt;
      &lt;state_2&gt;&lt;/state_2&gt;
      &lt;z5_2&gt;&lt;/z5_2&gt;
      &lt;home_phone_2&gt;&lt;/home_phone_2&gt;

      &lt;ip_addr&gt;&lt;/ip_addr&gt;
      &lt;pymtmethod&gt;&lt;/pymtmethod&gt;
      &lt;prodcode&gt;&lt;/prodcode&gt;
      &lt;avscode&gt;&lt;/avscode&gt;
      &lt;orderamt&gt;&lt;/orderamt&gt;
      &lt;numitems&gt;&lt;/numitems&gt;
      &lt;cidcode&gt;&lt;/cidcode&gt;
      &lt;score1&gt;&lt;/score1&gt;
      &lt;score2&gt;&lt;/score2&gt;
      &lt;userdefined1&gt;&lt;/userdefined1&gt;
      &lt;userdefined2&gt;&lt;/userdefined2&gt;
      &lt;userdefined3&gt;&lt;/userdefined3&gt;
      &lt;userdefined4&gt;&lt;/userdefined4&gt;
      &lt;userdefined5&gt;&lt;/userdefined5&gt;
      &lt;HistoryDateYYYYMM&gt;&lt;/HistoryDateYYYYMM&gt;
   &lt;/row&gt;
&lt;/batch_in&gt;</pre>
*/


import address, risk_indicators, models, riskwise, ut, gateway, AutoStandardI;


export ChargebackDefender_Batch_Service := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

batchin := dataset([],Models.Layout_CBD_BatchIn) 	: stored('batch_in',few);
gateways_input := Gateway.Configuration.Get();

string15 ModelName_in := '' : stored('ModelName');
model_name := StringLib.StringToLowerCase( modelname_in );

unsigned1 dppa := 0 									: stored('DPPAPurpose');
unsigned1 glb := AutoStandardI.Constants.GLBPurpose_default : stored('GLBPurpose');
string5   industry_class_val := '' 		: stored('IndustryClass');
boolean   isUtility := Doxie.Compliance.isUtilityRestricted(STD.Str.ToUpperCase(industry_class_val));

boolean   ofac_Only := true 					: stored('OfacOnly');
boolean   ofacSearching := true 			: stored('OFACSearching');
boolean   excludewatchlists := false  : stored('ExcludeWatchLists');
unsigned1 OFACVersion       := 1      : stored('OFACVersion');
boolean   IncludeOfac       := false  : stored('IncludeOfac');
real      gwThreshold       := 0.84   : stored('GlobalWatchlistThreshold');
boolean   addtl_watchlists  := false  : stored('IncludeAdditionalWatchLists');
boolean   usedobFilter      := false  : stored('UseDOBFilter');

string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string  DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
boolean   ipid_only    := false  : stored('ipid_only');
unsigned1 IdentityVersion             := 0 : stored('IdentityVersion');
unsigned1 RelationshipVersion         := 0 : stored('RelationshipVersion');
unsigned1 VelocityVersion             := 0 : stored('VelocityVersion');
input_Scores := dataset([], Risk_Indicators.Layout_BocaShell_BtSt.input_Scores);
BSOptions := 0;


// Per Bug 58340 - Pricepoint does not support hitting the Targus gateway, filtering it out.
Gateway.Layouts.Config gwSwitch(gateways_input le) := transform
	self.servicename := le.servicename;
	self.url := if(StringLib.StringToLowerCase(le.servicename) = 'targus', '', le.url);		
	self := le;
end;
gateways := project(gateways_input, gwSwitch(left));


doIdentity     := IdentityVersion > 0 and not ipid_only;
doRelationship := RelationshipVersion > 0 and not ipid_only;
doVelocity     := VelocityVersion > 0 and not ipid_only;

attrVersion := max( IdentityVersion, RelationshipVersion, VelocityVersion );


bsVersion := map(
	attrVersion=4 => 4,
	2
);

Models.Layout_Chargeback_In addseq(batchin le, integer C) := transform
	self.seq := C;							// using this for attribute output
	self.historydate := if(le.HistoryDateYYYYMM=0, risk_indicators.iid_constants.default_history_date, le.HistoryDateYYYYMM);
	self.account := le.acctno;//'';
	self.first := le.name_first;
	self.middle := le.name_middle;
	self.last := le.name_last;
	self.suffix := le.name_suffix;
	self.addr := Risk_Indicators.MOD_AddressClean.street_address(le.street_addr,le.prim_range,le.predir,le.prim_name,le.suffix,le.postdir,le.unit_desig,le.sec_range);
	self.city := le.p_city_name;
	self.state := le.st;
	self.zip := le.z5;
	self.hphone := le.home_phone;
	self.socs := le.ssn;
	self.email := le.email;
	self.drlc := le.dl_number;
	self.drlcstate := le.dl_state;
	self.first2 := le.name_first_2;
	self.middle2 := le.name_middle_2;
	self.last2 := le.name_last_2;
	self.suffix2 := le.name_suffix_2;
	self.addr2 := Risk_Indicators.MOD_AddressClean.street_address(le.street_addr2,le.prim_range_2,le.predir_2,le.prim_name_2,le.suffix_2,le.postdir_2,le.unit_desig_2,le.sec_range_2);
	self.city2 := le.city_2;
	self.state2 := le.state_2;
	self.zip2 := le.z5_2;
	self.hphone2 := le.home_phone_2;
	self.ipaddr := le.ip_addr;
	// self.channel := le.channel;
	// self.orderamt := le.orderamt;
	// self.numitems := le.numitems;
	// self.orderdate := le.orderdate;
	// self.shipmode := le.shipmode;
	// self.pymtmethod := le.pymtmethod;
	// self.avscode := le.avscode;	
	// self := le;
	self := []; 
end;
batchinseq := project(batchin, addseq(LEFT,COUNTER));



// set variables for passing to bocashell function
boolean   require2ele := attrVersion=0; // false for any version of attributes
boolean   isLn := false;	// not needed anymore
boolean   doRelatives := true;
boolean   doDL := true;		// can this be turned off
boolean   doVehicle := true;	// can this be turned off
boolean   doDerogs := true;
boolean   suppressNearDups := true;
boolean   fromBIID := false;
boolean   isFCRA := false;
boolean   fromIT1O := false;
boolean   doScore := false;
boolean   nugen := true;


iid_results := Models.ChargebackDefender_Function(batchinseq, gateways, glb, dppa, ipid_only, dataRestriction, ofac_only,
																									suppressneardups, require2Ele, bsVersion, dataPermission );


Models.Layout_Chargeback_Out fill_output(iid_results le, batchinseq ri) := TRANSFORM
		self.AccountNumber := ri.account;
		
		self.chargeback.seq := ri.seq;
		self.chargeback.account := ri.account;
		
		// first input (bill to)
		self.chargeback.verfirst:= le.bill_to_output.combo_first;
		self.chargeback.verlast := le.bill_to_output.combo_last;
		self.chargeback.veraddr := Risk_Indicators.MOD_AddressClean.street_address('',
			le.bill_to_output.combo_prim_range,le.bill_to_output.combo_predir,
			le.bill_to_output.combo_prim_name,le.bill_to_output.combo_suffix,
			le.bill_to_output.combo_postdir,le.bill_to_output.combo_unit_desig,
			le.bill_to_output.combo_sec_range
		);
		self.chargeback.vercity := le.bill_to_output.combo_city;
		self.chargeback.verstate:= le.bill_to_output.combo_state;
		self.chargeback.verzip5 := le.bill_to_output.combo_zip[1..5];
		self.chargeback.verzip4 := le.bill_to_output.combo_zip[6..9];
		self.chargeback.nameaddrphone := le.bill_to_output.name_addr_phone;
		
		self.chargeback.socsverlevel := (string)le.bill_to_output.socsverlevel;
		self.chargeback.phoneverlevel := (string)le.bill_to_output.phoneverlevel;
		
		self.chargeback.correctlast := le.bill_to_output.correctlast;
		self.chargeback.correcthphone := le.bill_to_output.correcthphone;
		self.chargeback.correctaddr := le.bill_to_output.correctaddr;
		self.chargeback.correctsocs := le.bill_to_output.correctssn;
			
		self.chargeback.altareacode := le.bill_to_output.altareacode;
		self.chargeback.areacodesplitdate := le.bill_to_output.areacodesplitdate;
		
		self.chargeback.hphonetypeflag := le.bill_to_output.hphonetypeflag;
		self.chargeback.dwelltypeflag  := if(le.bill_to_output.addr_type='S' and le.bill_to_output.addrvalflag='N', '', le.bill_to_output.addr_type); 

		// second input (ship to)
		self.chargeback.verfirst2 := le.ship_to_output.combo_first;
		self.chargeback.verlast2 := le.ship_to_output.combo_last;
		self.chargeback.veraddr2 := Risk_Indicators.MOD_AddressClean.street_address('',
			le.ship_to_output.combo_prim_range,le.ship_to_output.combo_predir,
			le.ship_to_output.combo_prim_name,le.ship_to_output.combo_suffix,
			le.ship_to_output.combo_postdir,le.ship_to_output.combo_unit_desig,
			le.ship_to_output.combo_sec_range
		);
		self.chargeback.vercity2 := le.ship_to_output.combo_city;
		self.chargeback.verstate2:= le.ship_to_output.combo_state;
		self.chargeback.verzip52 := le.ship_to_output.combo_zip[1..5];
		self.chargeback.verzip42 := le.ship_to_output.combo_zip[6..9];
		self.chargeback.nameaddrphone2 := le.ship_to_output.name_addr_phone;
		

		self.chargeback.phoneverlevel2 := (string)le.ship_to_output.phoneverlevel;
		
		self.chargeback.correctlast2 := le.ship_to_output.correctlast;
		self.chargeback.correcthphone2 := le.ship_to_output.correcthphone;
		self.chargeback.correctaddr2 := le.ship_to_output.correctaddr;
			
		self.chargeback.altareacode2 := le.ship_to_output.altareacode;
		self.chargeback.areacodesplitdate2 := le.ship_to_output.areacodesplitdate;
		
		self.chargeback.hphonetypeflag2 := le.ship_to_output.hphonetypeflag;
		self.chargeback.dwelltypeflag2 := if(le.ship_to_output.addr_type='S' and le.ship_to_output.addrvalflag='N', '', le.ship_to_output.addr_type);
		
		// ip := trim(ri.ipaddr);
		
		self.chargeback := ri;
		self := [];
	END;
mapped_results := JOIN(iid_results, batchinseq, left.bill_to_output.seq = (right.seq * 2), fill_output(left,right), left outer);


Models.Layout_Chargeback_Out blankCB( mapped_results le ) := TRANSFORM
		self.chargeback.seq := le.chargeback.seq;
		self.chargeback := [];
		self := le;
END;

mapped_results_mod := if( ipid_only, project(mapped_results,blankCB(left)), mapped_results );


clam := Risk_Indicators.BocaShell_BtSt_Function(
		iid_results,
		gateways,
		dppa,
		glb,
		isUtility,
		isLN, 
		doRelatives,
		doDL,
		doVehicle,
		doDerogs,
		bsversion,
		doScore, 
		nugen, 
		DataRestriction,
		BSOptions,
		DataPermission,
		input_Scores,
		false,
		ipid_only
	);

attr := if(attrVersion > 0,
	Models.getCBDAttributes(clam, ''/*account_value*/, batchinseq, attrVersion),
	project(group(clam), transform(Models.Layout_CBDAttributes, self.seq:=left.bill_to_out.seq, self := []) )
);


Layout_working := RECORD
	unsigned seq;
	Models.Layout_CBD_BatchOut;
	UNSIGNED2 Royalty_NAG := 0;
END;

Layout_working intoAttributes(attr le) := TRANSFORM
	self.seq := le.seq;

	// Version 4
	self.index4 := if( doIdentity and attrVersion=4, risk_indicators.BillingIndex.CBD_IdentityAttr_v4, '');	
	ident := if( doIdentity and attrVersion=4, le.IdentityV4, row( [], Models.Layout_CBDAttributes.IdentityV4 ) );
	self.IdentityV4_BillToAgeOldestRecord                 := ident.BillToAgeOldestRecord;
	self.IdentityV4_ShipToAgeOldestRecord                 := ident.ShipToAgeOldestRecord;
	self.IdentityV4_BillToAgeNewestRecord                 := ident.BillToAgeNewestRecord;
	self.IdentityV4_ShipToAgeNewestRecord                 := ident.ShipToAgeNewestRecord;
	self.IdentityV4_BillToRecentUpdate                    := ident.BillToRecentUpdate;
	self.IdentityV4_ShipToRecentUpdate                    := ident.ShipToRecentUpdate;
	self.IdentityV4_BillToSrcsConfirmIDAddrCount          := ident.BillToSrcsConfirmIDAddrCount;
	self.IdentityV4_ShipToSrcsConfirmIDAddrCount          := ident.ShipToSrcsConfirmIDAddrCount;
	self.IdentityV4_BillToVerificationFailure             := ident.BillToVerificationFailure;
	self.IdentityV4_ShipToVerificationFailure             := ident.ShipToVerificationFailure;
	self.IdentityV4_BillToVerifiedName                    := ident.BillToVerifiedName;
	self.IdentityV4_ShipToVerifiedName                    := ident.ShipToVerifiedName;
	self.IdentityV4_BillToVerifiedPhone                   := ident.BillToVerifiedPhone;
	self.IdentityV4_ShipToVerifiedPhone                   := ident.ShipToVerifiedPhone;
	self.IdentityV4_BillToVerifiedAddress                 := ident.BillToVerifiedAddress;
	self.IdentityV4_ShipToVerifiedAddress                 := ident.ShipToVerifiedAddress;
	self.IdentityV4_BillToAssetVerifiedIdentity           := ident.BillToAssetVerifiedIdentity;
	self.IdentityV4_ShipToAssetVerifiedIdentity           := ident.ShipToAssetVerifiedIdentity;
	self.IdentityV4_BillToPropRealVerifiedIdentity        := ident.BillToPropRealVerifiedIdentity;
	self.IdentityV4_ShipToPropRealVerifiedIdentity        := ident.ShipToPropRealVerifiedIdentity;
	self.IdentityV4_BillToPropRealSourceCount             := ident.BillToPropRealSourceCount;
	self.IdentityV4_ShipToPropRealSourceCount             := ident.ShipToPropRealSourceCount;
	self.IdentityV4_BillToPropPersVerifiedIdentity        := ident.BillToPropPersVerifiedIdentity;
	self.IdentityV4_ShipToPropPersVerifiedIdentity        := ident.ShipToPropPersVerifiedIdentity;
	self.IdentityV4_BillToPropPersSourceCount             := ident.BillToPropPersSourceCount;
	self.IdentityV4_ShipToPropPersSourceCount             := ident.ShipToPropPersSourceCount;
	self.IdentityV4_BillToInferredMinimumAge              := ident.BillToInferredMinimumAge;
	self.IdentityV4_ShipToInferredMinimumAge              := ident.ShipToInferredMinimumAge;
	self.IdentityV4_BillToAddrIdentityCount               := ident.BillToAddrIdentityCount;
	self.IdentityV4_ShipToAddrIdentityCount               := ident.ShipToAddrIdentityCount;
	self.IdentityV4_BillToAddrPhoneCount                  := ident.BillToAddrPhoneCount;
	self.IdentityV4_ShipToAddrPhoneCount                  := ident.ShipToAddrPhoneCount;
	self.IdentityV4_BillToAddrIdentityRecentCount         := ident.BillToAddrIdentityRecentCount;
	self.IdentityV4_ShipToAddrIdentityRecentCount         := ident.ShipToAddrIdentityRecentCount;
	self.IdentityV4_BillToAddrPhoneRecentCount            := ident.BillToAddrPhoneRecentCount;
	self.IdentityV4_ShipToAddrPhoneRecentCount            := ident.ShipToAddrPhoneRecentCount;
	self.IdentityV4_BillToPhoneIdentityCount              := ident.BillToPhoneIdentityCount;
	self.IdentityV4_ShipToPhoneIdentityCount              := ident.ShipToPhoneIdentityCount;
	self.IdentityV4_BillToPhoneIdentityRecentCount        := ident.BillToPhoneIdentityRecentCount;
	self.IdentityV4_ShipToPhoneIdentityRecentCount        := ident.ShipToPhoneIdentityRecentCount;
	self.IdentityV4_BillToAddrStability                   := ident.BillToAddrStability;
	self.IdentityV4_ShipToAddrStability                   := ident.ShipToAddrStability;
	self.IdentityV4_BillToStatusMostRecent                := ident.BillToStatusMostRecent;
	self.IdentityV4_ShipToStatusMostRecent                := ident.ShipToStatusMostRecent;
	self.IdentityV4_BillToAddrChangeCount03               := ident.BillToAddrChangeCount03;
	self.IdentityV4_ShipToAddrChangeCount03               := ident.ShipToAddrChangeCount03;
	self.IdentityV4_BillToFraudDerogSeverityIndex         := ident.BillToFraudDerogSeverityIndex;
	self.IdentityV4_ShipToFraudDerogSeverityIndex         := ident.ShipToFraudDerogSeverityIndex;
	self.IdentityV4_BillToDerogCount                      := ident.BillToDerogCount;
	self.IdentityV4_ShipToDerogCount                      := ident.ShipToDerogCount;
	self.IdentityV4_BillToDerogRecentCount                := ident.BillToDerogRecentCount;
	self.IdentityV4_ShipToDerogRecentCount                := ident.ShipToDerogRecentCount;
	self.IdentityV4_BillToDerogAge                        := ident.BillToDerogAge;
	self.IdentityV4_ShipToDerogAge                        := ident.ShipToDerogAge;
	self.IdentityV4_BillToFelonyCount                     := ident.BillToFelonyCount;
	self.IdentityV4_ShipToFelonyCount                     := ident.ShipToFelonyCount;
	self.IdentityV4_BillToFelonyAge                       := ident.BillToFelonyAge;
	self.IdentityV4_ShipToFelonyAge                       := ident.ShipToFelonyAge;
	self.IdentityV4_BillToEvictionCount                   := ident.BillToEvictionCount;
	self.IdentityV4_ShipToEvictionCount                   := ident.ShipToEvictionCount;
	self.IdentityV4_BillToEvictionAge                     := ident.BillToEvictionAge;
	self.IdentityV4_ShipToEvictionAge                     := ident.ShipToEvictionAge;
	self.IdentityV4_BillToProfLicCount                    := ident.BillToProfLicCount;
	self.IdentityV4_ShipToProfLicCount                    := ident.ShipToProfLicCount;
	self.IdentityV4_BillToPhoneMobile                     := ident.BillToPhoneMobile;
	self.IdentityV4_ShipToPhoneMobile                     := ident.ShipToPhoneMobile;
	self.IdentityV4_BillToProfLicAge                      := ident.BillToProfLicAge;
	self.IdentityV4_ShipToProfLicAge                      := ident.ShipToProfLicAge;
	self.IdentityV4_BillToPhoneEDAAgeOldestRecord         := ident.BillToPhoneEDAAgeOldestRecord;
	self.IdentityV4_ShipToPhoneEDAAgeOldestRecord         := ident.ShipToPhoneEDAAgeOldestRecord;
	self.IdentityV4_BillToPhoneEDAAgeNewestRecord         := ident.BillToPhoneEDAAgeNewestRecord;
	self.IdentityV4_ShipToPhoneEDAAgeNewestRecord         := ident.ShipToPhoneEDAAgeNewestRecord;
	self.IdentityV4_BillToPhoneOthAgeOldestRecord         := ident.BillToPhoneOthAgeOldestRecord;
	self.IdentityV4_ShipToPhoneOthAgeOldestRecord         := ident.ShipToPhoneOthAgeOldestRecord;
	self.IdentityV4_BillToPhoneOthAgeNewestRecord         := ident.BillToPhoneOthAgeNewestRecord;
	self.IdentityV4_ShipToPhoneOthAgeNewestRecord         := ident.ShipToPhoneOthAgeNewestRecord;
	self.IdentityV4_BillToAddrHighRisk                    := ident.BillToAddrHighRisk;
	self.IdentityV4_ShipToAddrHighRisk                    := ident.ShipToAddrHighRisk;
	self.IdentityV4_BillToInputPhoneHighRisk              := ident.BillToInputPhoneHighRisk;
	self.IdentityV4_ShipToInputPhoneHighRisk              := ident.ShipToInputPhoneHighRisk;
	self.IdentityV4_BillToInputPhoneProblems              := ident.BillToInputPhoneProblems;
	self.IdentityV4_ShipToInputPhoneProblems              := ident.ShipToInputPhoneProblems;
	self.IdentityV4_BillToInputAddrProblems               := ident.BillToInputAddrProblems;
	self.IdentityV4_ShipToInputAddrProblems               := ident.ShipToInputAddrProblems;

	self.index5 := if( doRelationship and attrVersion=4, risk_indicators.BillingIndex.CBD_RelationshipAttr_v4, '');
	rel := if( doRelationship and attrVersion=4, le.RelationshipV4, row( [], Models.Layout_CBDAttributes.RelationshipV4 ) );
	self.RelationshipV4_BillToShipToSameIdentity          := rel.BillToShipToSameIdentity;
	self.RelationshipV4_BillToShipToSameName              := rel.BillToShipToSameName;
	self.RelationshipV4_BillToShipToSameAddr              := rel.BillToShipToSameAddr;
	self.RelationshipV4_BillToFNameFoundEmail             := rel.BillToFNameFoundEmail;
	self.RelationshipV4_ShipToFNameFoundEmail             := rel.ShipToFNameFoundEmail;
	self.RelationshipV4_BillToLNameFoundEmail             := rel.BillToLNameFoundEmail;
	self.RelationshipV4_ShipToLNameFoundEmail             := rel.ShipToLNameFoundEmail;
	self.RelationshipV4_BillToPhoneBillToAddrDist         := rel.BillToPhoneBillToAddrDist;
	self.RelationshipV4_ShipToPhoneShipToAddrDist         := rel.ShipToPhoneShipToAddrDist;
	self.RelationshipV4_BillToPhoneShipToAddrDist         := rel.BillToPhoneShipToAddrDist;
	self.RelationshipV4_BillToShipToPhoneDist             := rel.BillToShipToPhoneDist;
	self.RelationshipV4_BillToShipToAddrDist              := rel.BillToShipToAddrDist;
	self.RelationshipV4_BillToAddrShipToPhoneDist         := rel.BillToAddrShipToPhoneDist;
	self.RelationshipV4_BillToShipToRelative              := rel.BillToShipToRelative;
	self.RelationshipV4_BillToShipToCommonRelative        := rel.BillToShipToCommonRelative;

	self.index6 := if( doVelocity and attrVersion=4, risk_indicators.BillingIndex.CBD_VelocityAttr_v4, '');	
	vel := if( doVelocity and attrVersion=4, le.VelocityV4, row( [], Models.Layout_CBDAttributes.VelocityV4 ) );
	self.VelocityV4_BillToSearchCBDAgeOldestRecord        := vel.BillToSearchCBDAgeOldestRecord;
	self.VelocityV4_ShipToSearchCBDAgeOldestRecord        := vel.ShipToSearchCBDAgeOldestRecord;
	self.VelocityV4_BillToSearchCBDAgeNewestRecord        := vel.BillToSearchCBDAgeNewestRecord;
	self.VelocityV4_ShipToSearchCBDAgeNewestRecord        := vel.ShipToSearchCBDAgeNewestRecord;
	self.VelocityV4_BillToSearchCBDCount                  := vel.BillToSearchCBDCount;
	self.VelocityV4_ShipToSearchCBDCount                  := vel.ShipToSearchCBDCount;
	self.VelocityV4_BillToSearchCBDCount01                := vel.BillToSearchCBDCount01;
	self.VelocityV4_ShipToSearchCBDCount01                := vel.ShipToSearchCBDCount01;
	self.VelocityV4_BillToSearchCBDIdentityAddr           := vel.BillToSearchCBDIdentityAddr;
	self.VelocityV4_ShipToSearchCBDIdentityAddr           := vel.ShipToSearchCBDIdentityAddr;
	self.VelocityV4_BillToSearchCBDAddrIdentity           := vel.BillToSearchCBDAddrIdentity;
	self.VelocityV4_ShipToSearchCBDAddrIdentity           := vel.ShipToSearchCBDAddrIdentity;
	self.VelocityV4_BillToSearchCBDIdentityPhone          := vel.BillToSearchCBDIdentityPhone;
	self.VelocityV4_ShipToSearchCBDIdentityPhone          := vel.ShipToSearchCBDIdentityPhone;
	self.VelocityV4_BillToSearchOthAgeOldestRecord        := vel.BillToSearchOthAgeOldestRecord;
	self.VelocityV4_ShipToSearchOthAgeOldestRecord        := vel.ShipToSearchOthAgeOldestRecord;
	self.VelocityV4_BillToSearchOthAgeNewestRecord        := vel.BillToSearchOthAgeNewestRecord;
	self.VelocityV4_ShipToSearchOthAgeNewestRecord        := vel.ShipToSearchOthAgeNewestRecord;
	self.VelocityV4_BillToSearchOthCount                  := vel.BillToSearchOthCount;
	self.VelocityV4_ShipToSearchOthCount                  := vel.ShipToSearchOthCount;
	self.VelocityV4_BillToSearchOthCount01                := vel.BillToSearchOthCount01;
	self.VelocityV4_ShipToSearchOthCount01                := vel.ShipToSearchOthCount01;
	self.VelocityV4_BillToSearchLocateCount               := vel.BillToSearchLocateCount;
	self.VelocityV4_ShipToSearchLocateCount               := vel.ShipToSearchLocateCount;
	self.VelocityV4_BillToSearchLocateCount01             := vel.BillToSearchLocateCount01;
	self.VelocityV4_ShipToSearchLocateCount01             := vel.ShipToSearchLocateCount01;
	self.VelocityV4_BillToSearchRetailCount               := vel.BillToSearchRetailCount;
	self.VelocityV4_ShipToSearchRetailCount               := vel.ShipToSearchRetailCount;
	self.VelocityV4_BillToSearchRetailCount01             := vel.BillToSearchRetailCount01;
	self.VelocityV4_ShipToSearchRetailCount01             := vel.ShipToSearchRetailCount01;
	self.VelocityV4_BillToSearchOthAddrIdentity           := vel.BillToSearchOthAddrIdentity;
	self.VelocityV4_ShipToSearchOthAddrIdentity           := vel.ShipToSearchOthAddrIdentity;

	self := [];
END;
attributes := project(ungroup(attr), intoAttributes(left));


// wAcctNo is the normal processing results
wAcctNo := join(attributes, batchinseq, left.seq=right.seq, 
							transform(layout_working, 
													self.seq := right.seq, 
													self.acctno := right.account, 
													self := left), 
									right outer);
									
									
									
// IP DATA
		riskwise.Layout_IPAI prep_ips(iid_results le) := transform
			self.seq := le.bill_to_output.seq;
			self.ipaddr := le.Bill_to_output.ip_address;
		end;
		ips_prep := ungroup(project(iid_results, prep_ips(left)));
		
	Gateway.Layouts.Config gwIPIDCheck(gateways_input le) := transform
		self.servicename := IF(StringLib.StringToLowerCase(le.servicename) = 'netacuity' and ~ipid_only, '', le.servicename);
		self.url := if(StringLib.StringToLowerCase(le.servicename) = 'netacuity' and ~ipid_only, '', le.url);		 
		self := le;
	end;

	gateways_in_tempNetAcuity := project(gateways_input, gwIPIDCheck(left));
		
		ips := risk_indicators.getNetAcuity(ips_prep, gateways_in_tempNetAcuity, dppa, glb);
		
		Layout_Chargeback_Out_Ext := record
			Models.Layout_Chargeback_Out;
			UNSIGNED2	Royalty_NAG	:= 0; // internal, for royalty tracking
		end;
		
		Layout_Chargeback_Out_Ext addIP(mapped_results le, ips ri) := TRANSFORM
			self.ipdata.ipcontinent := ri.continent;
			self.ipdata.ipcountry := StringLib.StringToUpperCase(ri.countrycode);
			self.ipdata.iproutingtype := if(Stringlib.StringFilterOut(ri.ipaddr[1],'0123456789') = '', ri.iproutingmethod, '');
			self.ipdata.ipstate := if(StringLib.StringToUpperCase(ri.countrycode[1..2]) = 'US', StringLib.StringToUpperCase(ri.state), '');
			self.ipdata.ipzip := if(StringLib.StringToUpperCase(ri.countrycode[1..2]) = 'US', ri.zip, '');
			self.ipdata.ipareacode := if(ri.areacode <> '0', ri.areacode, '');	
			self.ipdata.topleveldomain := StringLib.StringToUpperCase(ri.topleveldomain);
			self.ipdata.secondleveldomain := StringLib.StringToUpperCase(ri.secondleveldomain);
			SELF.Royalty_NAG := Royalty.RoyaltyNetAcuity.GetCount(ri.ipaddr, ri.iptype);
			self := le;
		END;     
		withIP := JOIN(mapped_results_mod, ips, (left.chargeback.seq*2) = right.seq, addIP(left,right), left outer);	
		
		Layout_Chargeback_Out_Ext addIP_BTSTFunc(mapped_results le, clam ri) := TRANSFORM
			self.ipdata.ipcontinent := ri.ip2o.continent;
			self.ipdata.ipcountry := StringLib.StringToUpperCase(ri.ip2o.countrycode);
			self.ipdata.iproutingtype := if(Stringlib.StringFilterOut(ri.ip2o.ipaddr[1],'0123456789') = '', ri.ip2o.iproutingmethod, '');
			self.ipdata.ipstate := if(StringLib.StringToUpperCase(ri.ip2o.countrycode[1..2]) = 'US', StringLib.StringToUpperCase(ri.ip2o.state), '');
			self.ipdata.ipzip := if(StringLib.StringToUpperCase(ri.ip2o.countrycode[1..2]) = 'US', ri.ip2o.zip, '');
			self.ipdata.ipareacode := if(ri.ip2o.areacode <> '0', ri.ip2o.areacode, '');	
			self.ipdata.topleveldomain := StringLib.StringToUpperCase(ri.ip2o.topleveldomain);
			self.ipdata.secondleveldomain := StringLib.StringToUpperCase(ri.ip2o.secondleveldomain);
			SELF.Royalty_NAG := Royalty.RoyaltyNetAcuity.GetCount(ri.ip2o.ipaddr, ri.ip2o.iptype);
			self := le;
		END;     
		
		withIP_BTST := JOIN(mapped_results, clam, (left.chargeback.seq*2) = right.bill_to_out.seq, addIP_BTSTFunc(left,right), left outer);	
		
		
wCBDIP := join(wAcctNo, if(ipid_only, withIP,withIP_BTST) , left.seq=right.chargeback.seq,
									transform(layout_working,
														self.seq := left.seq,
														SELF.Royalty_NAG := right.Royalty_NAG;
														self := right,
														self := left), left outer);


cd2i_in := project(batchinseq, transform(riskwise.layout_cd2i, self := left));



model := map( ipid_only => dataset( [], models.Layout_ModelOut ), // don't call a score for ipid-only transactions
							model_name = 'cdn712_0' => models.CDN712_0_0( clam, true, false), // default model
							model_name = ''         => dataset( [], Models.Layout_ModelOut ),
							fail(Models.Layout_ModelOut, 'Invalid model input')
						);



wmodel := join(wCBDIP, model, left.seq*2=right.seq,
	transform(models.Layout_CBD_BatchOut,
		self.score1 := right.score,
		self.index3 := map(
			model_name='cdn712_0' => Risk_Indicators.BillingIndex.CBD_v1,
			''
		),
		
		self.modelname1 := map(
			model_name='cdn712_0' => 'ChargebackDefender',
			''
		),
		
		self.scorename1 := map(
			model_name='cdn712_0' => 'CBD',
			''
		),
		self.reason1 := right.ri[1].hri,
		self.reason2 := right.ri[2].hri,
		self.reason3 := right.ri[3].hri,
		self.reason4 := right.ri[4].hri,
		self.reason5 := right.ri[5].hri,
		self.reason6 := right.ri[6].hri,
		self.reason7 := right.ri[7].hri,
		self.reason8 := right.ri[8].hri,
		self.reason9 := right.ri[9].hri,
		self.reason10 := right.ri[10].hri,
		self.reason11 := right.ri[11].hri,
		self.reason12 := right.ri[12].hri,
		self := left
	),
	left outer
);

output(wModel, NAMED('Results'));

BOOLEAN  ReturnDetailedRoyalties := false : STORED('ReturnDetailedRoyalties');
dRoyaltiesByAcctno 	:= Royalty.RoyaltyNetAcuity.GetBatchRoyaltiesByAcctno(gateways, ips_prep, wCBDIP, TRUE);
dRoyalties 					:= Royalty.GetBatchRoyalties(dRoyaltiesByAcctno, ReturnDetailedRoyalties);
output(dRoyalties,NAMED('RoyaltySet'));



ENDMACRO;
// models.ChargebackDefender_Batch_Service();