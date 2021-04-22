#workunit('name','NonFCRA-Chargeback Defender Attributes');
#option ('hthorMemoryLimit', 1000)
#option ('linkCountedRows', false);

import ut, risk_indicators, models;
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

f := dataset('~jpyon::in::northern_1985_cb_consumer_in_in', In_Layout, csv(QUOTE('"')));
// f := choosen(dataset('~jpyon::in::northern_1985_cb_consumer_in_in', In_Layout, csv(QUOTE('"'))),5);

output(f);

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
	
	SELF.RequestedAttributeGroups := dataset([{'identityv1'},{'relationshipv1'}], layout_attributes_in); // identityv1 is basic, relationshipv1 adds on premium
		
	self.DataRestrictionMask := '000000000000';  // to allow use of everything

    self := le;
	self := [];
end;

soap_in := project( f, to_soap(LEFT) );
output(soap_in, named('soap_in'));

ip := 'http://roxiethorvip.hpcc.risk.regn.net:9856'; // roxiebatch

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
	
	// attributes
	string3 BillToAgeOldestRecord;
	string3 ShipToAgeOldestRecord;
	string3 BillToAgeNewestRecord; 
	string3 ShipToAgeNewestRecord;
	string1 BillToRecentUpdate;
	string1 ShipToRecentUpdate;
	string3 BillToSrcsConfirmIDAddrCount;
	string3 ShipToSrcsConfirmIDAddrCount;
	string1 BillToInvalidAddr; 
	string1 ShipToInvalidAddr;
	string1 BillToInvalidPhone;
	string1 ShipToInvalidPhone;
	string1 BillToVerificationFailure;
	string1 ShipToVerificationFailure;
	string1 BillToVerifiedName;
	string1 ShipToVerifiedName;
	string1 BillToVerifiedPhone;
	string1 ShipToVerifiedPhone;
	string1 BillToVerifiedPhoneFullName;
	string1 ShipToVerifiedPhoneFullName;
	string1 BillToVerifiedPhoneLastName; 
	string1 ShipToVerifiedPhoneLastName;
	string1 BillToVerifiedAddress;
	string1 ShipToVerifiedAddress;
	string3 BillToInferredMinimumAge;
	string3 ShipToInferredMinimumAge;
	string3 BillToAddrIdentitiesCount;
	string3 ShipToAddrIdentitiesCount;
	string3 BillToAddrPhoneCount;
	string3 ShipToAddrPhoneCount;
	string3 BillToAddrIdentitiesRecentCount;
	string3 ShipToAddrIdentitiesRecentCount;
	string3 BillToAddrPhoneRecentCount;
	string3 ShipToAddrPhoneRecentCount;
	string3 BillToPhoneIdentitiesCount;
	string3 ShipToPhoneIdentitiesCount;
	string1 BillToPhoneListDiffNameAddr;
	string1 ShipToPhoneListDiffNameAddr;
	string3 BillToPhoneIdentitiesRecentCount;
	string3 ShipToPhoneIdentitiesRecentCount;
	string1 BillToAddrStability;
	string1 ShipToAddrStability;
	string1 BillToStatusMostRecent;
	string1 ShipToStatusMostRecent;
	string3 BillToAddrChangeCount03;
	string3 ShipToAddrChangeCount03;
	string3 BillToPropOwnedCount;
	string3 ShipToPropOwnedCount;
	string10 BillToPropOwnedTaxTotal;	
	string10 ShipToPropOwnedTaxTotal;	
	string3 BillToWatercraftCount;
	string3 ShipToWatercraftCount;
	string3 BillToAircraftCount;
	string3 ShipToAircraftCount;
	string1 BillToWealthIndex;
	string1 ShipToWealthIndex;
	string3 BillToDerogCount;
	string3 ShipToDerogCount;
	string3 BillToDerogAge;
	string3 ShipToDerogAge;
	string3 BillToFelonyCount;
	string3 ShipToFelonyCount;
	string3 BillToFelonyAge;
	string3 ShipToFelonyAge;
	string3 BillToEvictionAge;
	string3 ShipToEvictionAge;
	string3 BillToEvictionCount;
	string3 ShipToEvictionCount;
	string3 BillToProfLicAge;
	string3 ShipToProfLicAge;
	string3 BillToProfLicCount;
	string3 ShipToProfLicCount;
	string1 BillToPhoneStatus;
	string1 ShipToPhoneStatus;
	string1 BillToPhonePager;
	string1 ShipToPhonePager;
	string1 BillToPhoneMobile;
	string1 ShipToPhoneMobile;
	string3 BillToPhoneEDAAgeOldestRecord;
	string3 ShipToPhoneEDAAgeOldestRecord;
	string3 BillToPhoneEDAAgeNewestRecord;
	string3 ShipToPhoneEDAAgeNewestRecord;
	string3 BillToPhoneOtherAgeOldestRecord;
	string3 ShipToPhoneOtherAgeOldestRecord;
	string3 BillToPhoneOtherAgeNewestRecord;
	string3 ShipToPhoneOtherAgeNewestRecord;
	string1 BillToInvalidPhoneZip;
	string1 ShipToInvalidPhoneZip;
	string4 BillToPhoneAddrDist;
	string4 ShipToPhoneAddrDist;
	string1 BillToAddrHighRisk;
	string1 ShipToAddrHighRisk;
	string1 BillToInputPhoneHighRisk;
	string1 ShipToInputPhoneHighRisk;
	string1 BillToInputAddrPrison;
	string1 ShipToInputAddrPrison;
	string1 BillToInputZipPOBox;
	string1 ShipToInputZipPOBox;
	string1 BillToInputZipCorpMil;
	string1 ShipToInputZipCorpMil;

	string1 BillToShipToSameIdentity;
	string1 BillToShipToSameName;
	string1 BillToShipToSameAddr;
	string1 BillToFNameFoundEmail;
	string1 BillToLNameFoundEmail;
	string1 ShipToFNameFoundEmail;
	string1 ShipToLNameFoundEmail;
	string4 BillToPhoneBillToAddrDist;
	string4 ShipToPhoneShipToAddrDist;
	string4 BillToPhoneShipToAddrDist;
	string4 BillToShipToPhoneDist;
	string4 BillToShipToAddrDist;
	string4 BillToAddrShipToPhoneDist;
	string1 BillToShipToRelative;
	string1 BillToShipToCommonRelative;
	
	string200 errorcode;
end;

soap_out1 := soapcall( soap_in, ip, svc, {soap_in}, dataset(layout_with_errcode), 
	retry(2), timeout(500), literal,
	 XPATH('Models.ChargebackDefender_ServiceResponse/Results/Result/Dataset[@name=\'Results\']/Row'), 
	 Parallel(parallel_threads),ONFAIL(myFail(LEFT))); 

output(soap_out1);

get_attribute(dataset(Models.Layouts.Layout_AttributeGroup) groupi, integer i) := function
	attr := groupi.attributes[i];
	return attr;
end;


layout_chargeback flatten(soap_out1 le) := transform

	self.account := le.accountnumber;
	
	// IdentityV1 output
	just_identityv1_attributes := project(le.attributegroups, transform(Models.Layouts.Layout_AttributeGroup, self.attributes := le.attributegroups(name='IdentityV1').attributes, self := []));
	
	iv11 := get_Attribute(just_identityv1_attributes, 1);
	iv12 := get_Attribute(just_identityv1_attributes, 2);
	iv13 := get_Attribute(just_identityv1_attributes, 3);
	iv14 := get_Attribute(just_identityv1_attributes, 4);
	iv15 := get_Attribute(just_identityv1_attributes, 5);
	iv16 := get_Attribute(just_identityv1_attributes, 6);
	iv17 := get_Attribute(just_identityv1_attributes, 7);
	iv18 := get_Attribute(just_identityv1_attributes, 8);
	iv19 := get_Attribute(just_identityv1_attributes, 9);
	iv110 := get_Attribute(just_identityv1_attributes, 10);
	iv111 := get_Attribute(just_identityv1_attributes, 11);
	iv112 := get_Attribute(just_identityv1_attributes, 12);
	iv113 := get_Attribute(just_identityv1_attributes, 13);
	iv114 := get_Attribute(just_identityv1_attributes, 14);
	iv115 := get_Attribute(just_identityv1_attributes, 15);
	iv116 := get_Attribute(just_identityv1_attributes, 16);
	iv117 := get_Attribute(just_identityv1_attributes, 17);
	iv118 := get_Attribute(just_identityv1_attributes, 18);
	iv119 := get_Attribute(just_identityv1_attributes, 19);
	iv120 := get_Attribute(just_identityv1_attributes, 20);
	iv121 := get_Attribute(just_identityv1_attributes, 21);
	iv122 := get_Attribute(just_identityv1_attributes, 22);
	iv123 := get_Attribute(just_identityv1_attributes, 23);
	iv124 := get_Attribute(just_identityv1_attributes, 24);
	iv125 := get_Attribute(just_identityv1_attributes, 25);
	iv126 := get_Attribute(just_identityv1_attributes, 26);
	iv127 := get_Attribute(just_identityv1_attributes, 27);
	iv128 := get_Attribute(just_identityv1_attributes, 28);
	iv129 := get_Attribute(just_identityv1_attributes, 29);
	iv130 := get_Attribute(just_identityv1_attributes, 30);
	iv131 := get_Attribute(just_identityv1_attributes, 31);
	iv132 := get_Attribute(just_identityv1_attributes, 32);
	iv133 := get_Attribute(just_identityv1_attributes, 33);
	iv134 := get_Attribute(just_identityv1_attributes, 34);
	iv135 := get_Attribute(just_identityv1_attributes, 35);
	iv136 := get_Attribute(just_identityv1_attributes, 36);
	iv137 := get_Attribute(just_identityv1_attributes, 37);
	iv138 := get_Attribute(just_identityv1_attributes, 38);
	iv139 := get_Attribute(just_identityv1_attributes, 39);
	iv140 := get_Attribute(just_identityv1_attributes, 40);
	iv141 := get_Attribute(just_identityv1_attributes, 41);
	iv142 := get_Attribute(just_identityv1_attributes, 42);
	iv143 := get_Attribute(just_identityv1_attributes, 43);
	iv144 := get_Attribute(just_identityv1_attributes, 44);
	iv145 := get_Attribute(just_identityv1_attributes, 45);
	iv146 := get_Attribute(just_identityv1_attributes, 46);
	iv147 := get_Attribute(just_identityv1_attributes, 47);
	iv148 := get_Attribute(just_identityv1_attributes, 48);
	iv149 := get_Attribute(just_identityv1_attributes, 49);
	iv150 := get_Attribute(just_identityv1_attributes, 50);
	iv151 := get_Attribute(just_identityv1_attributes, 51);
	iv152 := get_Attribute(just_identityv1_attributes, 52);
	iv153 := get_Attribute(just_identityv1_attributes, 53);
	iv154 := get_Attribute(just_identityv1_attributes, 54);
	iv155 := get_Attribute(just_identityv1_attributes, 55);
	iv156 := get_Attribute(just_identityv1_attributes, 56);
	iv157 := get_Attribute(just_identityv1_attributes, 57);
	iv158 := get_Attribute(just_identityv1_attributes, 58);
	iv159 := get_Attribute(just_identityv1_attributes, 59);
	iv160 := get_Attribute(just_identityv1_attributes, 60);
	iv161 := get_Attribute(just_identityv1_attributes, 61);
	iv162 := get_Attribute(just_identityv1_attributes, 62);
	iv163 := get_Attribute(just_identityv1_attributes, 63);
	iv164 := get_Attribute(just_identityv1_attributes, 64);
	iv165 := get_Attribute(just_identityv1_attributes, 65);
	iv166 := get_Attribute(just_identityv1_attributes, 66);
	iv167 := get_Attribute(just_identityv1_attributes, 67);
	iv168 := get_Attribute(just_identityv1_attributes, 68);
	iv169 := get_Attribute(just_identityv1_attributes, 69);
	iv170 := get_Attribute(just_identityv1_attributes, 70);
	iv171 := get_Attribute(just_identityv1_attributes, 71);
	iv172 := get_Attribute(just_identityv1_attributes, 72);
	iv173 := get_Attribute(just_identityv1_attributes, 73);
	iv174 := get_Attribute(just_identityv1_attributes, 74);
	iv175 := get_Attribute(just_identityv1_attributes, 75);
	iv176 := get_Attribute(just_identityv1_attributes, 76);
	iv177 := get_Attribute(just_identityv1_attributes, 77);
	iv178 := get_Attribute(just_identityv1_attributes, 78);
	iv179 := get_Attribute(just_identityv1_attributes, 79);
	iv180 := get_Attribute(just_identityv1_attributes, 80);
	iv181 := get_Attribute(just_identityv1_attributes, 81);
	iv182 := get_Attribute(just_identityv1_attributes, 82);
	iv183 := get_Attribute(just_identityv1_attributes, 83);
	iv184 := get_Attribute(just_identityv1_attributes, 84);
	iv185 := get_Attribute(just_identityv1_attributes, 85);
	iv186 := get_Attribute(just_identityv1_attributes, 86);
	iv187 := get_Attribute(just_identityv1_attributes, 87);
	iv188 := get_Attribute(just_identityv1_attributes, 88);
	iv189 := get_Attribute(just_identityv1_attributes, 89);
	iv190 := get_Attribute(just_identityv1_attributes, 90);
	iv191 := get_Attribute(just_identityv1_attributes, 91);
	iv192 := get_Attribute(just_identityv1_attributes, 92);
	iv193 := get_Attribute(just_identityv1_attributes, 93);
	iv194 := get_Attribute(just_identityv1_attributes, 94);
	iv195 := get_Attribute(just_identityv1_attributes, 95);
	iv196 := get_Attribute(just_identityv1_attributes, 96);
	iv197 := get_Attribute(just_identityv1_attributes, 97);
	iv198 := get_Attribute(just_identityv1_attributes, 98);
	iv199 := get_Attribute(just_identityv1_attributes, 99);
	iv1100 := get_Attribute(just_identityv1_attributes, 100);
	
	
	self.BillToAgeOldestRecord := iv11.attribute[1].value;
	self.ShipToAgeOldestRecord := iv12.attribute[1].value;
	self.BillToAgeNewestRecord := iv13.attribute[1].value; 
	self.ShipToAgeNewestRecord := iv14.attribute[1].value;
	self.BillToRecentUpdate := iv15.attribute[1].value;
	self.ShipToRecentUpdate := iv16.attribute[1].value;
	self.BillToSrcsConfirmIDAddrCount := iv17.attribute[1].value;
	self.ShipToSrcsConfirmIDAddrCount := iv18.attribute[1].value;
	self.BillToInvalidAddr := iv19.attribute[1].value; 
	self.ShipToInvalidAddr := iv110.attribute[1].value;
	self.BillToInvalidPhone := iv111.attribute[1].value;
	self.ShipToInvalidPhone := iv112.attribute[1].value;
	self.BillToVerificationFailure := iv113.attribute[1].value;
	self.ShipToVerificationFailure := iv114.attribute[1].value;
	self.BillToVerifiedName := iv115.attribute[1].value;
	self.ShipToVerifiedName := iv116.attribute[1].value;
	self.BillToVerifiedPhone := iv117.attribute[1].value;
	self.ShipToVerifiedPhone := iv118.attribute[1].value;
	self.BillToVerifiedPhoneFullName := iv119.attribute[1].value;
	self.ShipToVerifiedPhoneFullName := iv120.attribute[1].value;
	self.BillToVerifiedPhoneLastName := iv121.attribute[1].value; 
	self.ShipToVerifiedPhoneLastName := iv122.attribute[1].value;
	self.BillToVerifiedAddress := iv123.attribute[1].value;
	self.ShipToVerifiedAddress := iv124.attribute[1].value;
	self.BillToInferredMinimumAge := iv125.attribute[1].value;
	self.ShipToInferredMinimumAge := iv126.attribute[1].value;
	self.BillToAddrIdentitiesCount := iv127.attribute[1].value;
	self.ShipToAddrIdentitiesCount := iv128.attribute[1].value;
	self.BillToAddrPhoneCount := iv129.attribute[1].value;
	self.ShipToAddrPhoneCount := iv130.attribute[1].value;
	self.BillToAddrIdentitiesRecentCount := iv131.attribute[1].value;
	self.ShipToAddrIdentitiesRecentCount := iv132.attribute[1].value;
	self.BillToAddrPhoneRecentCount := iv133.attribute[1].value;
	self.ShipToAddrPhoneRecentCount := iv134.attribute[1].value;
	self.BillToPhoneIdentitiesCount := iv135.attribute[1].value;
	self.ShipToPhoneIdentitiesCount := iv136.attribute[1].value;
	self.BillToPhoneListDiffNameAddr := iv137.attribute[1].value;
	self.ShipToPhoneListDiffNameAddr := iv138.attribute[1].value;
	self.BillToPhoneIdentitiesRecentCount := iv139.attribute[1].value;
	self.ShipToPhoneIdentitiesRecentCount := iv140.attribute[1].value;
	self.BillToAddrStability := iv141.attribute[1].value;
	self.ShipToAddrStability := iv142.attribute[1].value;
	self.BillToStatusMostRecent := iv143.attribute[1].value;
	self.ShipToStatusMostRecent := iv144.attribute[1].value;
	self.BillToAddrChangeCount03 := iv145.attribute[1].value;
	self.ShipToAddrChangeCount03 := iv146.attribute[1].value;
	self.BillToPropOwnedCount := iv147.attribute[1].value;
	self.ShipToPropOwnedCount := iv148.attribute[1].value;
	self.BillToPropOwnedTaxTotal := iv149.attribute[1].value;
	self.ShipToPropOwnedTaxTotal := iv150.attribute[1].value;	
	self.BillToWatercraftCount := iv151.attribute[1].value;
	self.ShipToWatercraftCount := iv152.attribute[1].value;
	self.BillToAircraftCount := iv153.attribute[1].value;
	self.ShipToAircraftCount := iv154.attribute[1].value;
	self.BillToWealthIndex := iv155.attribute[1].value;
	self.ShipToWealthIndex := iv156.attribute[1].value;
	self.BillToDerogCount := iv157.attribute[1].value;
	self.ShipToDerogCount := iv158.attribute[1].value;
	self.BillToDerogAge := iv159.attribute[1].value;
	self.ShipToDerogAge := iv160.attribute[1].value;
	self.BillToFelonyCount := iv161.attribute[1].value;
	self.ShipToFelonyCount := iv162.attribute[1].value;
	self.BillToFelonyAge := iv163.attribute[1].value;
	self.ShipToFelonyAge := iv164.attribute[1].value;
	self.BillToEvictionAge := iv165.attribute[1].value;
	self.ShipToEvictionAge := iv166.attribute[1].value;
	self.BillToEvictionCount := iv167.attribute[1].value;
	self.ShipToEvictionCount := iv168.attribute[1].value;
	self.BillToProfLicAge := iv169.attribute[1].value;
	self.ShipToProfLicAge := iv170.attribute[1].value;
	self.BillToProfLicCount := iv171.attribute[1].value;
	self.ShipToProfLicCount := iv172.attribute[1].value;
	self.BillToPhoneStatus := iv173.attribute[1].value;
	self.ShipToPhoneStatus := iv174.attribute[1].value;
	self.BillToPhonePager := iv175.attribute[1].value;
	self.ShipToPhonePager := iv176.attribute[1].value;
	self.BillToPhoneMobile := iv177.attribute[1].value;
	self.ShipToPhoneMobile := iv178.attribute[1].value;
	self.BillToPhoneEDAAgeOldestRecord := iv179.attribute[1].value;
	self.ShipToPhoneEDAAgeOldestRecord := iv180.attribute[1].value;
	self.BillToPhoneEDAAgeNewestRecord := iv181.attribute[1].value;
	self.ShipToPhoneEDAAgeNewestRecord := iv182.attribute[1].value;
	self.BillToPhoneOtherAgeOldestRecord := iv183.attribute[1].value;
	self.ShipToPhoneOtherAgeOldestRecord := iv184.attribute[1].value;
	self.BillToPhoneOtherAgeNewestRecord := iv185.attribute[1].value;
	self.ShipToPhoneOtherAgeNewestRecord := iv186.attribute[1].value;
	self.BillToInvalidPhoneZip := iv187.attribute[1].value;
	self.ShipToInvalidPhoneZip := iv188.attribute[1].value;
	self.BillToPhoneAddrDist := iv189.attribute[1].value;
	self.ShipToPhoneAddrDist := iv190.attribute[1].value;
	self.BillToAddrHighRisk := iv191.attribute[1].value;
	self.ShipToAddrHighRisk := iv192.attribute[1].value;
	self.BillToInputPhoneHighRisk := iv193.attribute[1].value;
	self.ShipToInputPhoneHighRisk := iv194.attribute[1].value;
	self.BillToInputAddrPrison := iv195.attribute[1].value;
	self.ShipToInputAddrPrison := iv196.attribute[1].value;
	self.BillToInputZipPOBox := iv197.attribute[1].value;
	self.ShipToInputZipPOBox := iv198.attribute[1].value;
	self.BillToInputZipCorpMil := iv199.attribute[1].value;
	self.ShipToInputZipCorpMil := iv1100.attribute[1].value;
	
	// RelationshipV1 Attributes
	just_relationshipv1_attributes := project(le.attributegroups, transform(Models.Layouts.Layout_AttributeGroup, self.attributes := le.attributegroups(name='RelationshipV1').attributes, self := []));
	
	rv11 := get_Attribute(just_relationshipv1_attributes, 1);
	rv12 := get_Attribute(just_relationshipv1_attributes, 2);
	rv13 := get_Attribute(just_relationshipv1_attributes, 3);
	rv14 := get_Attribute(just_relationshipv1_attributes, 4);
	rv15 := get_Attribute(just_relationshipv1_attributes, 5);
	rv16 := get_Attribute(just_relationshipv1_attributes, 6);
	rv17 := get_Attribute(just_relationshipv1_attributes, 7);
	rv18 := get_Attribute(just_relationshipv1_attributes, 8);
	rv19 := get_Attribute(just_relationshipv1_attributes, 9);
	rv110 := get_Attribute(just_relationshipv1_attributes, 10);
	rv111 := get_Attribute(just_relationshipv1_attributes, 11);
	rv112 := get_Attribute(just_relationshipv1_attributes, 12);
	rv113 := get_Attribute(just_relationshipv1_attributes, 13);
	rv114 := get_Attribute(just_relationshipv1_attributes, 14);
	rv115 := get_Attribute(just_relationshipv1_attributes, 15);

	self.BillToShipToSameIdentity := rv11.attribute[1].value;
	self.BillToShipToSameName := rv12.attribute[1].value;
	self.BillToShipToSameAddr := rv13.attribute[1].value;
	self.BillToFNameFoundEmail := rv14.attribute[1].value;
	self.BillToLNameFoundEmail := rv15.attribute[1].value;
	self.ShipToFNameFoundEmail := rv16.attribute[1].value;
	self.ShipToLNameFoundEmail := rv17.attribute[1].value;
	self.BillToPhoneBillToAddrDist := rv18.attribute[1].value;
	self.ShipToPhoneShipToAddrDist := rv19.attribute[1].value;
	self.BillToPhoneShipToAddrDist := rv110.attribute[1].value;
	self.BillToShipToPhoneDist := rv111.attribute[1].value;
	self.BillToShipToAddrDist := rv112.attribute[1].value;
	self.BillToAddrShipToPhoneDist := rv113.attribute[1].value;
	self.BillToShipToRelative := rv114.attribute[1].value;
	self.BillToShipToCommonRelative := rv115.attribute[1].value;

	
	self.errorcode := le.errorcode;
	self := le.chargeback;
	
end;

soap_out  := project(soap_out1,flatten(left));

output(soap_out,named('output'));
output(soap_out(errorcode = ''),,'~dvstemp::out::northern_1985_cb_out',CSV(heading(single), quote('"')), overwrite);
output(soap_out(errorcode != ''),,'~dvstemp::out::northern_1985_cb_out_err',CSV(heading(single), quote('"')), overwrite);

output(choosen(soap_out(errorcode<>''), 5), named('errors'));
