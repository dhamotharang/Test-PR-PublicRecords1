#workunit('name','NonFCRA-Chargeback Defender Attributes-wk48');
#option ('hthorMemoryLimit', 1000)
#option ('linkCountedRows', false);

import ut, risk_indicators, riskwise, models;

RUN_TEST := false;   // set to 'true' to run a sample of records-false equals all records
INCLUDE_CHARGEBACK := false;  

// *** IP Address logic is currently "NOT" included ***
in_layout := record	
	string account;
	string first;
	string last;
	string addr;
	string city;
	string state;
	string zip;
	string hphone;
	string socs;
	string email;
	string first2;
	string last2;
	string addr2;
	string city2;
	string state2;
	string zip2;
	string hphone2;
	string ipaddr;
	string HistorydateYYYYMM;
end;

unsigned1 parallel_threads := 30;  //max number of parallel threads = 30

f_all := dataset('~tfuerstenberg::in::dell_3345_cbd_wk48_in', In_Layout, csv(QUOTE('"')));

#if(RUN_TEST)
	f := choosen(f_all,20);
#else
	f := f_all;
#end

output(choosen(f,20), named('raw_input'));

output(count(f_all), named('count_f_all'));
Layout_Attributes_In := RECORD
	string name;
END;

layout_soap_in := record
	string account;
	string first;
	string last;
	string addr;
	string city;
	string state;
	string zip;
	string hphone;
	string socs;
	string email;
	string first2;
	string last2;
	string addr2;
	string city2;
	string state2;
	string zip2;
	string hphone2;
	string ipaddr;
	string HistoryDateYYYYMM;
	INTEGER GLBPurpose;
	INTEGER DPPAPurpose;
	dataset(Layout_Attributes_In) RequestedAttributeGroups;
	dataset(Risk_Indicators.Layout_Gateways_In) gateways;
	string DataRestrictionMask;
end;


layout_soap_in to_soap( f le ) := TRANSFORM
	self.HistoryDateYYYYMM := le.historydateyyyymm; 
	self.dppapurpose := 3;
	self.glbpurpose := 1;
	SELF.RequestedAttributeGroups := dataset([{'identityv4'},{'relationshipv4'},{'velocityv4'}], layout_attributes_in);
	self.DataRestrictionMask := '000000000000';  // to allow use of everything

  self := le;
	self := [];
end;

soap_in := project( f, to_soap(LEFT) );
output(soap_in, named('soap_in'));

ip := 'http://roxiethorvip.hpcc.risk.regn.net:9856'; // roxiebatch
// ip := riskwise.shortcuts.dev64;
svc:= 'Models.ChargebackDefender_Service';

layout_with_errcode := record
	string200 errorcode;
	Models.Layout_Chargeback_Out;
END;

layout_with_errcode myFail( soap_in le ) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	self := [];
END;

Layout_Chargeback := RECORD
	STRING30 account := '';
	#if(INCLUDE_CHARGEBACK)
		STRING2  socsverlevel := '';
		STRING2  phoneverlevel := '';
		STRING20 correctlast := '';
		STRING10 correcthphone := '';
		STRING9  correctsocs := '';
		STRING50 correctaddr := '';
		STRING3  altareacode := '';
		STRING8  areacodesplitdate := '';
		STRING15 verfirst := '';
		STRING20 verlast := '';
		STRING50 veraddr := '';
		STRING30 vercity := '';
		STRING2  verstate := '';
		STRING5  verzip5 := '';
		STRING4  verzip4 := '';
		STRING10 nameaddrphone := '';
		STRING1  hphonetypeflag := '';
		STRING1  dwelltypeflag := '';
		STRING6  sic := '';
		
		STRING2  phoneverlevel2 := '';
		STRING20 correctlast2 := '';
		STRING10 correcthphone2 := '';
		STRING50 correctaddr2 := '';
		STRING3  altareacode2 := '';
		STRING8  areacodesplitdate2 := '';
		STRING15 verfirst2 := '';
		STRING20 verlast2 := '';
		STRING50 veraddr2 := '';
		STRING30 vercity2 := '';
		STRING2  verstate2 := '';
		STRING5  verzip52 := '';
		STRING4  verzip42 := '';
		STRING10 nameaddrphone2 := '';
		STRING1  hphonetypeflag2 := '';
		STRING1  dwelltypeflag2 := '';
		STRING6  sic2 := '';
	#end
	// attributes
	Models.Layout_CBDAttributes.IdentityV4;
	Models.Layout_CBDAttributes.RelationshipV4;
	Models.Layout_CBDAttributes.VelocityV4;

	string200 errorcode;
 end;

soap_out1 := soapcall( soap_in, ip, svc, {soap_in}, dataset(layout_with_errcode), 
	retry(2), timeout(500), literal,
	 XPATH('Models.ChargebackDefender_ServiceResponse/Results/Result/Dataset[@name=\'Results\']/Row'), 
	 Parallel(parallel_threads),ONFAIL(myFail(LEFT))); 

output(choosen(soap_out1,20), named('raw_soap_out'));

layout_chargeback flatten(soap_out1 le) := transform

	self.account := le.accountnumber;
	
	// IdentityV4 output
	identityV4     := le.attributegroups(name='IdentityV4')[1].attributes;
	relationshipV4 := le.attributegroups(name='RelationshipV4')[1].attributes;
	velocityV4     := le.attributegroups(name='VelocityV4')[1].attributes;
	
	self.BillToAgeOldestRecord                 := IdentityV4[1].attribute[1].value;
	self.ShipToAgeOldestRecord                 := IdentityV4[2].attribute[1].value;
	self.BillToAgeNewestRecord                 := IdentityV4[3].attribute[1].value;
	self.ShipToAgeNewestRecord                 := IdentityV4[4].attribute[1].value;
	self.BillToRecentUpdate                    := IdentityV4[5].attribute[1].value;
	self.ShipToRecentUpdate                    := IdentityV4[6].attribute[1].value;
	self.BillToSrcsConfirmIDAddrCount          := IdentityV4[7].attribute[1].value;
	self.ShipToSrcsConfirmIDAddrCount          := IdentityV4[8].attribute[1].value;
	self.BillToVerificationFailure             := IdentityV4[9].attribute[1].value;
	self.ShipToVerificationFailure             := IdentityV4[10].attribute[1].value;
	self.BillToVerifiedName                    := IdentityV4[11].attribute[1].value;
	self.ShipToVerifiedName                    := IdentityV4[12].attribute[1].value;
	self.BillToVerifiedPhone                   := IdentityV4[13].attribute[1].value;
	self.ShipToVerifiedPhone                   := IdentityV4[14].attribute[1].value;
	self.BillToVerifiedAddress                 := IdentityV4[15].attribute[1].value;
	self.ShipToVerifiedAddress                 := IdentityV4[16].attribute[1].value;


	self.BillToAssetVerifiedIdentity           := IdentityV4[17].attribute[1].value;
	self.ShipToAssetVerifiedIdentity           := IdentityV4[18].attribute[1].value;
	self.BillToPropRealVerifiedIdentity        := IdentityV4[19].attribute[1].value;
	self.ShipToPropRealVerifiedIdentity        := IdentityV4[20].attribute[1].value;
	self.BillToPropRealSourceCount             := IdentityV4[21].attribute[1].value;
	self.ShipToPropRealSourceCount             := IdentityV4[22].attribute[1].value;
	self.BillToPropPersVerifiedIdentity        := IdentityV4[23].attribute[1].value;
	self.ShipToPropPersVerifiedIdentity        := IdentityV4[24].attribute[1].value;
	self.BillToPropPersSourceCount             := IdentityV4[25].attribute[1].value;
	self.ShipToPropPersSourceCount             := IdentityV4[26].attribute[1].value;
	self.BillToInferredMinimumAge              := IdentityV4[27].attribute[1].value;
	self.ShipToInferredMinimumAge              := IdentityV4[28].attribute[1].value;
	self.BillToAddrIdentityCount               := IdentityV4[29].attribute[1].value;
	self.ShipToAddrIdentityCount               := IdentityV4[30].attribute[1].value;
	self.BillToAddrPhoneCount                  := IdentityV4[31].attribute[1].value;
	self.ShipToAddrPhoneCount                  := IdentityV4[32].attribute[1].value;
	self.BillToAddrIdentityRecentCount         := IdentityV4[33].attribute[1].value;
	self.ShipToAddrIdentityRecentCount         := IdentityV4[34].attribute[1].value;
	self.BillToAddrPhoneRecentCount            := IdentityV4[35].attribute[1].value;
	self.ShipToAddrPhoneRecentCount            := IdentityV4[36].attribute[1].value;
	self.BillToPhoneIdentityCount              := IdentityV4[37].attribute[1].value;
	self.ShipToPhoneIdentityCount              := IdentityV4[38].attribute[1].value;
	self.BillToPhoneIdentityRecentCount        := IdentityV4[39].attribute[1].value;
	self.ShipToPhoneIdentityRecentCount        := IdentityV4[40].attribute[1].value;
	self.BillToAddrStability                   := IdentityV4[41].attribute[1].value;
	self.ShipToAddrStability                   := IdentityV4[42].attribute[1].value;
	self.BillToStatusMostRecent                := IdentityV4[43].attribute[1].value;
	self.ShipToStatusMostRecent                := IdentityV4[44].attribute[1].value;
	self.BillToAddrChangeCount03               := IdentityV4[45].attribute[1].value;
	self.ShipToAddrChangeCount03               := IdentityV4[46].attribute[1].value;
	self.BillToFraudDerogSeverityIndex         := IdentityV4[47].attribute[1].value;
	self.ShipToFraudDerogSeverityIndex         := IdentityV4[48].attribute[1].value;
	self.BillToDerogCount                      := IdentityV4[49].attribute[1].value;
	self.ShipToDerogCount                      := IdentityV4[50].attribute[1].value;
	self.BillToDerogRecentCount                := IdentityV4[51].attribute[1].value;
	self.ShipToDerogRecentCount                := IdentityV4[52].attribute[1].value;
	self.BillToDerogAge                        := IdentityV4[53].attribute[1].value;
	self.ShipToDerogAge                        := IdentityV4[54].attribute[1].value;
	self.BillToFelonyCount                     := IdentityV4[55].attribute[1].value;
	self.ShipToFelonyCount                     := IdentityV4[56].attribute[1].value;
	self.BillToFelonyAge                       := IdentityV4[57].attribute[1].value;
	self.ShipToFelonyAge                       := IdentityV4[58].attribute[1].value;
	self.BillToEvictionCount                   := IdentityV4[59].attribute[1].value;
	self.ShipToEvictionCount                   := IdentityV4[60].attribute[1].value;
	self.BillToEvictionAge                     := IdentityV4[61].attribute[1].value;
	self.ShipToEvictionAge                     := IdentityV4[62].attribute[1].value;
	self.BillToProfLicCount                    := IdentityV4[63].attribute[1].value;
	self.ShipToProfLicCount                    := IdentityV4[64].attribute[1].value;
	self.BillToPhoneMobile                     := IdentityV4[65].attribute[1].value;
	self.ShipToPhoneMobile                     := IdentityV4[66].attribute[1].value;
	self.BillToProfLicAge                      := IdentityV4[67].attribute[1].value;
	self.ShipToProfLicAge                      := IdentityV4[68].attribute[1].value;
	self.BillToPhoneEDAAgeOldestRecord         := IdentityV4[69].attribute[1].value;
	self.ShipToPhoneEDAAgeOldestRecord         := IdentityV4[70].attribute[1].value;
	self.BillToPhoneEDAAgeNewestRecord         := IdentityV4[71].attribute[1].value;
	self.ShipToPhoneEDAAgeNewestRecord         := IdentityV4[72].attribute[1].value;
	self.BillToPhoneOthAgeOldestRecord         := IdentityV4[73].attribute[1].value;
	self.ShipToPhoneOthAgeOldestRecord         := IdentityV4[74].attribute[1].value;
	self.BillToPhoneOthAgeNewestRecord         := IdentityV4[75].attribute[1].value;
	self.ShipToPhoneOthAgeNewestRecord         := IdentityV4[76].attribute[1].value;
	self.BillToAddrHighRisk                    := IdentityV4[77].attribute[1].value;
	self.ShipToAddrHighRisk                    := IdentityV4[78].attribute[1].value;
	self.BillToInputPhoneHighRisk              := IdentityV4[79].attribute[1].value;
	self.ShipToInputPhoneHighRisk              := IdentityV4[80].attribute[1].value;
	self.BillToInputPhoneProblems              := IdentityV4[81].attribute[1].value;
	self.ShipToInputPhoneProblems              := IdentityV4[82].attribute[1].value;
	self.BillToInputAddrProblems               := IdentityV4[83].attribute[1].value;
	self.ShipToInputAddrProblems               := IdentityV4[84].attribute[1].value;


	self.BillToShipToSameIdentity              := RelationshipV4[1].attribute[1].value;
	self.BillToShipToSameName                  := RelationshipV4[2].attribute[1].value;
	self.BillToShipToSameAddr                  := RelationshipV4[3].attribute[1].value;
	self.BillToFNameFoundEmail                 := RelationshipV4[4].attribute[1].value;
	self.ShipToFNameFoundEmail                 := RelationshipV4[5].attribute[1].value;
	self.BillToLNameFoundEmail                 := RelationshipV4[6].attribute[1].value;
	self.ShipToLNameFoundEmail                 := RelationshipV4[7].attribute[1].value;
	self.BillToPhoneBillToAddrDist             := RelationshipV4[8].attribute[1].value;
	self.ShipToPhoneShipToAddrDist             := RelationshipV4[9].attribute[1].value;
	self.BillToPhoneShipToAddrDist             := RelationshipV4[10].attribute[1].value;
	self.BillToShipToPhoneDist                 := RelationshipV4[11].attribute[1].value;
	self.BillToShipToAddrDist                  := RelationshipV4[12].attribute[1].value;
	self.BillToAddrShipToPhoneDist             := RelationshipV4[13].attribute[1].value;
	self.BillToShipToRelative                  := RelationshipV4[14].attribute[1].value;
	self.BillToShipToCommonRelative            := RelationshipV4[15].attribute[1].value;


	self.BillToSearchCBDAgeOldestRecord        := VelocityV4[1].attribute[1].value;
	self.ShipToSearchCBDAgeOldestRecord        := VelocityV4[2].attribute[1].value;
	self.BillToSearchCBDAgeNewestRecord        := VelocityV4[3].attribute[1].value;
	self.ShipToSearchCBDAgeNewestRecord        := VelocityV4[4].attribute[1].value;
	self.BillToSearchCBDCount                  := VelocityV4[5].attribute[1].value;
	self.ShipToSearchCBDCount                  := VelocityV4[6].attribute[1].value;
	self.BillToSearchCBDCount01                := VelocityV4[7].attribute[1].value;
	self.ShipToSearchCBDCount01                := VelocityV4[8].attribute[1].value;
	self.BillToSearchCBDIdentityAddr           := VelocityV4[9].attribute[1].value;
	self.ShipToSearchCBDIdentityAddr           := VelocityV4[10].attribute[1].value;
	self.BillToSearchCBDAddrIdentity           := VelocityV4[11].attribute[1].value;
	self.ShipToSearchCBDAddrIdentity           := VelocityV4[12].attribute[1].value;
	self.BillToSearchCBDIdentityPhone          := VelocityV4[13].attribute[1].value;
	self.ShipToSearchCBDIdentityPhone          := VelocityV4[14].attribute[1].value;
	self.BillToSearchOthAgeOldestRecord        := VelocityV4[15].attribute[1].value;
	self.ShipToSearchOthAgeOldestRecord        := VelocityV4[16].attribute[1].value;
	self.BillToSearchOthAgeNewestRecord        := VelocityV4[17].attribute[1].value;
	self.ShipToSearchOthAgeNewestRecord        := VelocityV4[18].attribute[1].value;
	self.BillToSearchOthCount                  := VelocityV4[19].attribute[1].value;
	self.ShipToSearchOthCount                  := VelocityV4[20].attribute[1].value;
	self.BillToSearchOthCount01                := VelocityV4[21].attribute[1].value;
	self.ShipToSearchOthCount01                := VelocityV4[22].attribute[1].value;
	self.BillToSearchLocateCount               := VelocityV4[23].attribute[1].value;
	self.ShipToSearchLocateCount               := VelocityV4[24].attribute[1].value;
	self.BillToSearchLocateCount01             := VelocityV4[25].attribute[1].value;
	self.ShipToSearchLocateCount01             := VelocityV4[26].attribute[1].value;
	self.BillToSearchRetailCount               := VelocityV4[27].attribute[1].value;
	self.ShipToSearchRetailCount               := VelocityV4[28].attribute[1].value;
	self.BillToSearchRetailCount01             := VelocityV4[29].attribute[1].value;
	self.ShipToSearchRetailCount01             := VelocityV4[30].attribute[1].value;
	self.BillToSearchOthAddrIdentity           := VelocityV4[31].attribute[1].value;
	self.ShipToSearchOthAddrIdentity           := VelocityV4[32].attribute[1].value;

	self.errorcode := le.errorcode;
	
	#if(INCLUDE_CHARGEBACK)
		self := le.chargeback;
	#end
end;

//filter off error records
soap_out  := project(soap_out1(errorcode = ''),flatten(left));

#if(RUN_TEST)
	output(soap_out,named('output'));
#else
	output(soap_out,,'~tfuerstenberg::out::dell_3345_wk48_CBD40_out',CSV(heading(single), quote('"')), overwrite);
	output(soap_out1(errorcode != ''),,'~tfuerstenberg::out::dell_3345_wk48_CBD40_out_errors',CSV(heading(single), quote('"')), overwrite);
#end
output(choosen(soap_out1(errorcode != ''), 5), named('errors'));
output(choosen(soap_out(account = ''), 5), named('emptyAccts'));
//display error count
output(count(soap_out1(errorcode != '')), named('raw_soap_errors'));

