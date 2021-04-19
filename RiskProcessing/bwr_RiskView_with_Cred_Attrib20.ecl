#workunit('name','FCRA-Credit Attributes 2.0');
#option ('hthorMemoryLimit', 1000)


// NOTE:  THIS WILL ONLY OUTPUT VERSION2 ATTRIBUTES

import models, Risk_Indicators;

prii_layout := RECORD
     string ACCOUNT;
     string FirstName;
     string MiddleName;
     string LastName;
     string StreetAddress;
     string CITY;
     string STATE;
     string ZIP;
     string HomePhone;
     string SSN;
     string DateOfBirth;
     string WorkPhone;
     string INCOME;
     string DLNumber;
     string DLState;
     string BALANCE;
     string CHARGEOFFD;
     string FORMERName;
     string EMAIL;
     string EmployerName;
     integer HistoryDateYYYYMM;
end;

// f := dataset('~tfuerstenberg::in::lobel_1259_in',prii_layout, csv(quote('"')));
f := choosen(dataset('~tfuerstenberg::in::lobel_1259_in',prii_layout, csv(quote('"'))),5);

output(f, named('original_input'));


Layout_Attributes_In := RECORD
	string name;
END;

layout_soap := record
	STRING AccountNumber;
	STRING FirstName;
	STRING MiddleName;
	STRING LastName;
	STRING NameSuffix;
	STRING StreetAddress;
	STRING City;
	STRING State;
	STRING Zip;
	STRING Country;
	STRING SSN;
	STRING DateOfBirth;
	STRING Age;
	STRING DLNumber;
	STRING DLState;
	STRING Email;
	STRING IPAddress;
	STRING HomePhone;
	STRING WorkPhone;
	STRING EmployerName;
	STRING FormerName;
	INTEGER GLBPurpose;
	INTEGER DPPAPurpose;
	integer HistoryDateYYYYMM := 999999;
	boolean Attributes := False;
	dataset(Models.Layout_Score_Chooser) scores;
	dataset(Layout_Attributes_In) RequestedAttributeGroups;
	dataset(Risk_Indicators.Layout_Gateways_In) gateways;
	string DataRestrictionMask;
end;

// params := dataset([], models.Layout_Parameters);
params := dataset([{'Custom', 'rvr711_0'}], models.Layout_Parameters);	// use this for non-version1 models, also possibly change the scores that you call below

// current possible models available as of 7/25/2008
	// version 2 riskview
		// rvb711_0 - bankcard
		// rva711_0 - auto
		// rvt711_0 - telecom
		// rvr711_0 - retail
	// Custom retail models 
		// rvr803_1	- retail		 
	// Custom auto models 
		// aid605_1	- auto
		// aid607_0 - auto
		// rva707_0 - subprime auto


l := RECORD
	STRING old_account_number;
	layout_soap;
END;


fcraroxieIP := 'http://fcrathorvip.hpcc.risk.regn.net:9876'; 

l t_f(f le, INTEGER c) := TRANSFORM
	SELF.old_account_number := le.account;
	SELF.Accountnumber := (STRING)c;	
	SELF.DPPAPurpose := 0;
	SELF.GLBPurpose := 5;
	SELF.Attributes := True;
	SELF.RequestedAttributeGroups := dataset([{'version2'}], layout_attributes_in); // to get version1 attributes, you need to modify this

// the following 2 lines will allow you add a Day field of '01' to a ChoicePoint 6 byte DOB.
	// patched_dob := le.dateofbirth[1..6] + '01';
	// self.DateOfBirth := if(trim(le.dateofbirth)='', '', patched_dob);

//	self.HistoryDateYYYYMM := le.historydateyyyymm; //999999;

// use it for FCRA RiskView
//	self.scores := dataset([{'Models.RVAuto_Service', fcraroxieIP, params}], models.Layout_Score_Chooser); 
//  self.scores := dataset([{'Models.RVBankCard_Service', fcraroxieIP,params}], models.Layout_Score_Chooser); 
//	self.scores := dataset([{'Models.RVRetail_Service', fcraroxieIP,params}], models.Layout_Score_Chooser); 
//	self.scores := dataset([{'Models.RVTelecom_Service', fcraroxieIP,params}], models.Layout_Score_Chooser); 
	self.gateways := dataset([{'neutralroxie', 'http://roxiebatch.br.seisint.com:9856'}], risk_indicators.Layout_Gateways_In);

	self.DataRestrictionMask := '100001000100'; // to restrict fares, experian and transunion 


	SELF := le;
	self := [];
end;

p_f := project(f, t_f(left, counter));
output(p_f, named('RV_Input'));
output(count(p_f));


dist_dataset := PROJECT(p_f,TRANSFORM(layout_soap,SELF := LEFT));

Layout_Attribute := RECORD, maxlength(100000)
	DATASET(Models.Layout_Parameters) Attribute;
END;
Layout_AttributeGroup := RECORD, maxlength(100000)
	string name;
	string index;
	DATASET(Layout_Attribute) Attributes;
END;
layout_RVAttributesOut := RECORD, maxlength(100000)
	string30 accountnumber;
	DATASET(Layout_AttributeGroup) AttributeGroup;
END;
xlayout := RECORD, maxlength(100000)
	STRING30 AccountNumber;
	DATASET(Models.Layout_Model) models;
	Layout_RVAttributesOut AttributeGroups;
	STRING errorcode;
END;

xlayout myFail(dist_dataset le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;

resu := soapcall(dist_dataset, fcraroxieIP,
										'Models.RiskView_Testing_Service', {dist_dataset}, 
										DATASET(xlayout),
                    RETRY(5), TIMEOUT(500), LITERAL,
                    XPATH('Models.RiskView_Testing_ServiceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
										PARALLEL(25), onFail(myFail(LEFT)));

output(resu, named('resu'));

			
rv_attributes_norm := RECORD
	unsigned seq;

	string30 AccountNumber;

	string8 SSNFirstSeen;
	string8 DateLastSeen;
	string1 isRecentUpdate;
	string2 NumSources;
	string1 isPhoneFullNameMatch;
	string1 isPhoneLastNameMatch;
	string1 isSSNInvalid;
	string1 isPhoneInvalid;
	string1 isAddrInvalid;
	string1 isDLInvalid;
	string1 isNoVer;
	
	string1 isDeceased;
	string8 DeceasedDate;
	string1 isSSNValid;
	string1 isRecentIssue;
	string8 LowIssueDate;
	string8 HighIssueDate;
	string2 IssueState;
	string1 isNonUS;
	string1 isIssued3;
	string1 isIssuedAge5;

	string6 IADateFirstReported;
	string6 IADateLastReported;
	string4 IALenOfRes;
	string1 IADwellType;
	string1 IALandUseCode;
	string10 IAAssessedValue;
	string1 IAisOwnedBySubject;
	string1 IAisFamilyOwned;
	string1 IAisOccupantOwned;
	string8 IALastSaleDate;
	string10 IALastSaleAmount;
	string1 IAisNotPrimaryRes;
	string1 IAPhoneListed;
	string10 IAPhoneNumber;

	string6 CADateFirstReported;
	string6 CADateLastReported;
	string4 CALenOfRes;
	string1 CADwellType;
	string1 CALandUseCode;
	string10 CAAssessedValue;
	string1 CAisOwnedBySubject;
	string1 CAisFamilyOwned;
	string1 CAisOccupantOwned;
	string8 CALastSaleDate;
	string10 CALastSaleAmount;
	string1 CAisNotPrimaryRes;
	string1 CAPhoneListed;
	string10 CAPhoneNumber;
	
	string6 PADateFirstReported;
	string6 PADateLastReported;
	string4 PALenOfRes;
	string1 PADwellType;
	string1 PALandUseCode;
	string10 PAAssessedValue;
	string1 PAisOwnedBySubject;
	string1 PAisFamilyOwned;
	string1 PAisOccupantOwned;
	string8 PALastSaleDate;
	string10 PALastSaleAmount;
	string1 PAisNotPrimaryRes;
	string1 PAPhoneListed;
	string10 PAPhoneNumber;
	
	string1 isInputCurrMatch;
	string4 DistInputCurr;
	string1 isDiffState;
	string10 AssessedDiff;
	string2 EcoTrajectory;
	
	string1 isInputPrevMatch;
	string4 DistCurrPrev;
	string1 isDiffState2;
	string10 AssessedDiff2;
	string2 EcoTrajectory2;
	
	string1 mobility_indicator;
	string1 statusAddr;
	string1 statusAddr2;
	string1 statusAddr3;
	string6 PADateFirstReported2;
	string6 NPADateFirstReported;
	string3 addrChanges30;
	string3 addrChanges90;
	string3 addrChanges180;
	string3 addrChanges12;
	string3 addrChanges24;
	string3 addrChanges36;
	string3 addrChanges60;
	
	string3 property_owned_total;
	string13 property_owned_assessed_total;
	string3 property_historically_owned;
	string8 date_first_purchase;
	string8 date_most_recent_purchase;
	string8 date_most_recent_sale;
	
	string3 numPurchase30;
	string3 numPurchase90;
	string3 numPurchase180;
	string3 numPurchase12;
	string3 numPurchase24;
	string3 numPurchase36;
	string3 numPurchase60;
	
	string3 numSold30;
	string3 numSold90;
	string3 numSold180;
	string3 numSold12;
	string3 numSold24;
	string3 numSold36;
	string3 numSold60;
	
	string3 numWatercraft;
	string3 numWatercraft30;
	string3 numWatercraft90;
	string3 numWatercraft180;
	string3 numWatercraft12;
	string3 numWatercraft24;
	string3 numWatercraft36;
	string3 numWatercraft60;
	
	string3 numAircraft;
	string3 numAircraft30;
	string3 numAircraft90;
	string3 numAircraft180;
	string3 numAircraft12;
	string3 numAircraft24;
	string3 numAircraft36;
	string3 numAircraft60;
	
	string1 wealth_indicator;

	string3 total_number_derogs;
	string8 date_last_derog;
	
	string3 felonies;
	string8 date_last_conviction;
	string3 felonies30;
	string3 felonies90;
	string3 felonies180;
	string3 felonies12;
	string3 felonies24;
	string3 felonies36;
	string3 felonies60;
	
	string3 num_liens;
	string3 num_unreleased_liens;
	string8 date_last_unreleased;
	string3 num_unreleased_liens30;
	string3 num_unreleased_liens90;
	string3 num_unreleased_liens180;
	string3 num_unreleased_liens12;
	string3 num_unreleased_liens24;
	string3 num_unreleased_liens36;
	string3 num_unreleased_liens60;
	
	string3 num_released_liens;
	string8 date_last_released;
	string3 num_released_liens30;
	string3 num_released_liens90;
	string3 num_released_liens180;
	string3 num_released_liens12;
	string3 num_released_liens24;
	string3 num_released_liens36;
	string3 num_released_liens60;
	
	string3 bankruptcy_count;
	string8 date_last_bankruptcy;
	STRING1 filing_type;
	STRING35 disposition;
	string3 bankruptcy_count30;
	string3 bankruptcy_count90;
	string3 bankruptcy_count180;
	string3 bankruptcy_count12;
	string3 bankruptcy_count24;
	string3 bankruptcy_count36;
	string3 bankruptcy_count60;
	
	string3 eviction_count;
	string8 date_last_eviction;
	string3 eviction_count30;
	string3 eviction_count90;
	string3 eviction_count180;
	string3 eviction_count12;
	string3 eviction_count24;
	string3 eviction_count36;
	string3 eviction_count60;

	string3 num_nonderogs;
	string3 num_nonderogs30;
	string3 num_nonderogs90;
	string3 num_nonderogs180;
	string3 num_nonderogs12;
	string3 num_nonderogs24;
	string3 num_nonderogs36;
	string3 num_nonderogs60;
	
	string3 num_proflic;
	string8 date_last_proflic;
	string60 proflic_type;
	string8 expire_date_last_proflic;
	
	string3 num_proflic30;
	string3 num_proflic90;
	string3 num_proflic180;
	string3 num_proflic12;
	string3 num_proflic24;
	string3 num_proflic36;
	string3 num_proflic60;
	
	string3 num_proflic_exp30;
	string3 num_proflic_exp90;
	string3 num_proflic_exp180;
	string3 num_proflic_exp12;
	string3 num_proflic_exp24;
	string3 num_proflic_exp36;
	string3 num_proflic_exp60;
	
	string1 isAddrHighRisk;
	string1 isPhoneHighRisk;
	string1 isAddrPrison;
	string1 isZipPOBox;
	string1 isZipCorpMil;
	string1 phoneStatus;
	string1 isPhonePager;
	string1 isPhoneMobile;
	string1 isPhoneZipMismatch;
	string4 phoneAddrDist;
	
	string1 correctedFlag;
	string1 disputeFlag;
	string1 securityFreeze;
	string1 securityAlert;
	string1 negativeAlert;
	string1 idTheftFlag;
	
	string3 RV_score;
	string3 RV_reason;
	string3 RV_reason2;
	string3 RV_reason3;
	string3 RV_reason4;
	
	string6 history_date;
	
	string10 errorcode;
END;


get_group(recordof(layout_rvattributesout) groups, string name_i) := function
	groupi := groups.attributegroup(name=name_i);
	return groupi;
end;


get_attribute(dataset(Layout_AttributeGroup) groupi, integer i) := function
	attr := groupi.attributes[i];
	// return attr;
	
	// temporary conversion of booleans until the riskview product starts returning booleans as 0 and 1 instead of true and false
	// checkBoolean(boolean x) := if(x, 'true', 'false');
			attribute_values_converted := dataset([{attr.attribute[1].name, map(attr.attribute[1].value='true' => '1',
														  attr.attribute[1].value='false' => '0',
														  attr.attribute[1].value) }], Models.Layout_Parameters);
														 
			attr_converted := DATASET([{attribute_values_converted}], Layout_Attribute);
			return attr_converted;
	// end of temporary conversion for booleans
	
end;

rv_attributes_norm normit(resu L, p_f R) := transform
	self.AccountNumber := r.old_account_number;
	
	
	just_groups := project(l, transform(layout_RVAttributesOut, self := l.attributegroups));
	
	// version2 output
	v2 := get_group(just_groups, 'Version2');
	v21 := get_attribute(v2, 1);
	v22 := get_attribute(v2, 2);
	v23 := get_attribute(v2, 3);
	v24 := get_attribute(v2, 4);
	v25 := get_attribute(v2, 5);
	v26 := get_attribute(v2, 6);
	v27 := get_attribute(v2, 7);
	v28 := get_attribute(v2, 8);
	v29 := get_attribute(v2, 9);
	v210 := get_attribute(v2, 10);
	v211 := get_attribute(v2, 11);
	v212 := get_attribute(v2, 12);
	v213 := get_attribute(v2, 13);
	v214 := get_attribute(v2, 14);
	v215 := get_attribute(v2, 15);
	v216 := get_attribute(v2, 16);
	v217 := get_attribute(v2, 17);
	v218 := get_attribute(v2, 18);
	v219 := get_attribute(v2, 19);
	v220 := get_attribute(v2, 20);
	v221 := get_attribute(v2, 21);
	v222 := get_attribute(v2, 22);
	v223 := get_attribute(v2, 23);
	v224 := get_attribute(v2, 24);
	v225 := get_attribute(v2, 25);
	v226 := get_attribute(v2, 26);
	v227 := get_attribute(v2, 27);
	v228 := get_attribute(v2, 28);
	v229 := get_attribute(v2, 29);
	v230 := get_attribute(v2, 30);
	v231 := get_attribute(v2, 31);
	v232 := get_attribute(v2, 32);
	v233 := get_attribute(v2, 33);
	v234 := get_attribute(v2, 34);
	v235 := get_attribute(v2, 35);
	v236 := get_attribute(v2, 36);
	v237 := get_attribute(v2, 37);
	v238 := get_attribute(v2, 38);
	v239 := get_attribute(v2, 39);
	v240 := get_attribute(v2, 40);
	v241 := get_attribute(v2, 41);
	v242 := get_attribute(v2, 42);
	v243 := get_attribute(v2, 43);
	v244 := get_attribute(v2, 44);
	v245 := get_attribute(v2, 45);
	v246 := get_attribute(v2, 46);
	v247 := get_attribute(v2, 47);
	v248 := get_attribute(v2, 48);
	v249 := get_attribute(v2, 49);
	v250 := get_attribute(v2, 50);
	v251 := get_attribute(v2, 51);
	v252 := get_attribute(v2, 52);
	v253 := get_attribute(v2, 53);
	v254 := get_attribute(v2, 54);
	v255 := get_attribute(v2, 55);
	v256 := get_attribute(v2, 56);
	v257 := get_attribute(v2, 57);
	v258 := get_attribute(v2, 58);
	v259 := get_attribute(v2, 59);
	v260 := get_attribute(v2, 60);
	v261 := get_attribute(v2, 61);
	v262 := get_attribute(v2, 62);
	v263 := get_attribute(v2, 63);
	v264 := get_attribute(v2, 64);
	v265 := get_attribute(v2, 65);
	v266 := get_attribute(v2, 66);
	v267 := get_attribute(v2, 67);
	v268 := get_attribute(v2, 68);
	v269 := get_attribute(v2, 69);
	v270 := get_attribute(v2, 70);
	v271 := get_attribute(v2, 71);
	v272 := get_attribute(v2, 72);
	v273 := get_attribute(v2, 73);
	v274 := get_attribute(v2, 74);
	v275 := get_attribute(v2, 75);
	v276 := get_attribute(v2, 76);
	v277 := get_attribute(v2, 77);
	v278 := get_attribute(v2, 78);
	v279 := get_attribute(v2, 79);
	v280 := get_attribute(v2, 80);
	v281 := get_attribute(v2, 81);
	v282 := get_attribute(v2, 82);
	v283 := get_attribute(v2, 83);
	v284 := get_attribute(v2, 84);
	v285 := get_attribute(v2, 85);
	v286 := get_attribute(v2, 86);
	v287 := get_attribute(v2, 87);
	v288 := get_attribute(v2, 88);
	v289 := get_attribute(v2, 89);
	v290 := get_attribute(v2, 90);
	v291 := get_attribute(v2, 91);
	v292 := get_attribute(v2, 92);
	v293 := get_attribute(v2, 93);
	v294 := get_attribute(v2, 94);
	v295 := get_attribute(v2, 95);
	v296 := get_attribute(v2, 96);
	v297 := get_attribute(v2, 97);
	v298 := get_attribute(v2, 98);
	v299 := get_attribute(v2, 99);
	v2100 := get_attribute(v2, 100);
	v2101 := get_attribute(v2, 101);
	v2102 := get_attribute(v2, 102);
	v2103 := get_attribute(v2, 103);
	v2104 := get_attribute(v2, 104);
	v2105 := get_attribute(v2, 105);
	v2106 := get_attribute(v2, 106);
	v2107 := get_attribute(v2, 107);
	v2108 := get_attribute(v2, 108);
	v2109 := get_attribute(v2, 109);
	v2110 := get_attribute(v2, 110);
	v2111 := get_attribute(v2, 111);
	v2112 := get_attribute(v2, 112);
	v2113 := get_attribute(v2, 113);
	v2114 := get_attribute(v2, 114);
	v2115 := get_attribute(v2, 115);
	v2116 := get_attribute(v2, 116);
	v2117 := get_attribute(v2, 117);
	v2118 := get_attribute(v2, 118);
	v2119 := get_attribute(v2, 119);
	v2120 := get_attribute(v2, 120);
	v2121 := get_attribute(v2, 121);
	v2122 := get_attribute(v2, 122);
	v2123 := get_attribute(v2, 123);
	v2124 := get_attribute(v2, 124);
	v2125 := get_attribute(v2, 125);
	v2126 := get_attribute(v2, 126);
	v2127 := get_attribute(v2, 127);
	v2128 := get_attribute(v2, 128);
	v2129 := get_attribute(v2, 129);
	v2130 := get_attribute(v2, 130);
	v2131 := get_attribute(v2, 131);
	v2132 := get_attribute(v2, 132);
	v2133 := get_attribute(v2, 133);
	v2134 := get_attribute(v2, 134);
	v2135 := get_attribute(v2, 135);
	v2136 := get_attribute(v2, 136);
	v2137 := get_attribute(v2, 137);
	v2138 := get_attribute(v2, 138);
	v2139 := get_attribute(v2, 139);
	v2140 := get_attribute(v2, 140);
	v2141 := get_attribute(v2, 141);
	v2142 := get_attribute(v2, 142);
	v2143 := get_attribute(v2, 143);
	v2144 := get_attribute(v2, 144);
	v2145 := get_attribute(v2, 145);
	v2146 := get_attribute(v2, 146);
	v2147 := get_attribute(v2, 147);
	v2148 := get_attribute(v2, 148);
	v2149 := get_attribute(v2, 149);
	v2150 := get_attribute(v2, 150);
	v2151 := get_attribute(v2, 151);
	v2152 := get_attribute(v2, 152);
	v2153 := get_attribute(v2, 153);
	v2154 := get_attribute(v2, 154);
	v2155 := get_attribute(v2, 155);
	v2156 := get_attribute(v2, 156);
	v2157 := get_attribute(v2, 157);
	v2158 := get_attribute(v2, 158);
	v2159 := get_attribute(v2, 159);
	v2160 := get_attribute(v2, 160);
	v2161 := get_attribute(v2, 161);
	v2162 := get_attribute(v2, 162);
	v2163 := get_attribute(v2, 163);
	v2164 := get_attribute(v2, 164);
	v2165 := get_attribute(v2, 165);
	v2166 := get_attribute(v2, 166);
	v2167 := get_attribute(v2, 167);
	v2168 := get_attribute(v2, 168);
	v2169 := get_attribute(v2, 169);
	v2170 := get_attribute(v2, 170);
	v2171 := get_attribute(v2, 171);
	v2172 := get_attribute(v2, 172);
	v2173 := get_attribute(v2, 173);
	v2174 := get_attribute(v2, 174);
	v2175 := get_attribute(v2, 175);
	v2176 := get_attribute(v2, 176);
	v2177 := get_attribute(v2, 177);
	v2178 := get_attribute(v2, 178);
	v2179 := get_attribute(v2, 179);
	v2180 := get_attribute(v2, 180);
	v2181 := get_attribute(v2, 181);
	v2182 := get_attribute(v2, 182);
	v2183 := get_attribute(v2, 183);
	v2184 := get_attribute(v2, 184);
	v2185 := get_attribute(v2, 185);
	v2186 := get_attribute(v2, 186);
	v2187 := get_attribute(v2, 187);
	v2188 := get_attribute(v2, 188);
	v2189 := get_attribute(v2, 189);
	v2190 := get_attribute(v2, 190);
	v2191 := get_attribute(v2, 191);
	v2192 := get_attribute(v2, 192);
	v2193 := get_attribute(v2, 193);
	v2194 := get_attribute(v2, 194);
	v2195 := get_attribute(v2, 195);
	v2196 := get_attribute(v2, 196);
	v2197 := get_attribute(v2, 197);
	v2198 := get_attribute(v2, 198);
	v2199 := get_attribute(v2, 199);
	v2200 := get_attribute(v2, 200);
	v2201 := get_attribute(v2, 201);
	v2202 := get_attribute(v2, 202);
	v2203 := get_attribute(v2, 203);
	v2204 := get_attribute(v2, 204);
	v2205 := get_attribute(v2, 205);
	v2206 := get_attribute(v2, 206);
	v2207 := get_attribute(v2, 207);
	v2208 := get_attribute(v2, 208);
	v2209 := get_attribute(v2, 209);
	v2210 := get_attribute(v2, 210);
	v2211 := get_attribute(v2, 211);
	v2212 := get_attribute(v2, 212);
	v2213 := get_attribute(v2, 213);
	v2214 := get_attribute(v2, 214);
	v2215 := get_attribute(v2, 215);
	
	self.SSNFirstSeen := v21.attribute[1].value;
	self.DateLastSeen := v22.attribute[1].value;
	self.isRecentUpdate := v23.attribute[1].value;
	self.NumSources := v24.attribute[1].value;
	self.isPhoneFullNameMatch := v25.attribute[1].value;
	self.isPhoneLastNameMatch := v26.attribute[1].value;
	self.isSSNInvalid := v27.attribute[1].value;
	self.isPhoneInvalid := v28.attribute[1].value;
	self.isAddrInvalid := v29.attribute[1].value;
	self.isDLInvalid := v210.attribute[1].value;
	self.isNoVer := v211.attribute[1].value;
	
	self.isDeceased := v212.attribute[1].value;
	self.DeceasedDate := v213.attribute[1].value;
	self.isSSNValid := v214.attribute[1].value;
	self.isRecentIssue := v215.attribute[1].value;
	self.LowIssueDate := v216.attribute[1].value;
	self.HighIssueDate := v217.attribute[1].value;
	self.IssueState := v218.attribute[1].value;
	self.isNonUS := v219.attribute[1].value;
	self.isIssued3 := v220.attribute[1].value;
	self.isIssuedAge5 := v221.attribute[1].value;

	self.IADateFirstReported := v222.attribute[1].value;
	self.IADateLastReported := v223.attribute[1].value;
	self.IALenOfRes := v224.attribute[1].value;
	self.IADwellType := v225.attribute[1].value;
	self.IALandUseCode := v226.attribute[1].value;
	self.IAAssessedValue := v227.attribute[1].value;
	self.IAisOwnedBySubject := v228.attribute[1].value;
	self.IAisFamilyOwned := v229.attribute[1].value;
	self.IAisOccupantOwned := v230.attribute[1].value;
	self.IALastSaleDate := v231.attribute[1].value;
	self.IALastSaleAmount := v232.attribute[1].value;
	self.IAisNotPrimaryRes := v233.attribute[1].value;
	self.IAPhoneListed := v234.attribute[1].value;
	self.IAPhoneNumber := v235.attribute[1].value;

	self.CADateFirstReported := v236.attribute[1].value;
	self.CADateLastReported := v237.attribute[1].value;
	self.CALenOfRes := v238.attribute[1].value;
	self.CADwellType := v239.attribute[1].value;
	self.CALandUseCode := v240.attribute[1].value;
	self.CAAssessedValue := v241.attribute[1].value;
	self.CAisOwnedBySubject := v242.attribute[1].value;
	self.CAisFamilyOwned := v243.attribute[1].value;
	self.CAisOccupantOwned := v244.attribute[1].value;
	self.CALastSaleDate := v245.attribute[1].value;
	self.CALastSaleAmount := v246.attribute[1].value;
	self.CAisNotPrimaryRes := v247.attribute[1].value;
	self.CAPhoneListed := v248.attribute[1].value;
	self.CAPhoneNumber := v249.attribute[1].value;
	
	self.PADateFirstReported := v250.attribute[1].value;
	self.PADateLastReported := v251.attribute[1].value;
	self.PALenOfRes := v252.attribute[1].value;
	self.PADwellType := v253.attribute[1].value;
	self.PALandUseCode := v254.attribute[1].value;
	self.PAAssessedValue := v255.attribute[1].value;
	self.PAisOwnedBySubject := v256.attribute[1].value;
	self.PAisFamilyOwned := v257.attribute[1].value;
	self.PAisOccupantOwned := v258.attribute[1].value;
	self.PALastSaleDate := v259.attribute[1].value;
	self.PALastSaleAmount := v260.attribute[1].value;
	self.PAisNotPrimaryRes := v261.attribute[1].value;
	self.PAPhoneListed := v262.attribute[1].value;
	self.PAPhoneNumber := v263.attribute[1].value;
	
	self.isInputCurrMatch := v264.attribute[1].value;
	self.DistInputCurr := v265.attribute[1].value;
	self.isDiffState := v266.attribute[1].value;
	self.AssessedDiff := v267.attribute[1].value;
	self.EcoTrajectory := v268.attribute[1].value;
	
	self.isInputPrevMatch := v269.attribute[1].value;
	self.DistCurrPrev := v270.attribute[1].value;
	self.isDiffState2 := v271.attribute[1].value;
	self.AssessedDiff2 := v272.attribute[1].value;
	self.EcoTrajectory2 := v273.attribute[1].value;
	
	self.mobility_indicator := v274.attribute[1].value;
	self.statusAddr := v275.attribute[1].value;
	self.statusAddr2 := v276.attribute[1].value;
	self.statusAddr3 := v277.attribute[1].value;
	self.PADateFirstReported2 := v278.attribute[1].value;
	self.NPADateFirstReported := v279.attribute[1].value;
	self.addrChanges30 := v280.attribute[1].value;
	self.addrChanges90 := v281.attribute[1].value;
	self.addrChanges180 := v282.attribute[1].value;
	self.addrChanges12 := v283.attribute[1].value;
	self.addrChanges24 := v284.attribute[1].value;
	self.addrChanges36 := v285.attribute[1].value;
	self.addrChanges60 := v286.attribute[1].value;
	
	self.property_owned_total := v287.attribute[1].value;
	self.property_owned_assessed_total := v288.attribute[1].value;
	self.property_historically_owned := v289.attribute[1].value;
	self.date_first_purchase := v290.attribute[1].value;
	self.date_most_recent_purchase := v291.attribute[1].value;
	self.date_most_recent_sale := v292.attribute[1].value;
	
	self.numPurchase30 := v293.attribute[1].value;
	self.numPurchase90 := v294.attribute[1].value;
	self.numPurchase180 := v295.attribute[1].value;
	self.numPurchase12 := v296.attribute[1].value;
	self.numPurchase24 := v297.attribute[1].value;
	self.numPurchase36 := v298.attribute[1].value;
	self.numPurchase60 := v299.attribute[1].value;
	
	self.numSold30 := v2100.attribute[1].value;
	self.numSold90 := v2101.attribute[1].value;
	self.numSold180 := v2102.attribute[1].value;
	self.numSold12 := v2103.attribute[1].value;
	self.numSold24 := v2104.attribute[1].value;
	self.numSold36 := v2105.attribute[1].value;
	self.numSold60 := v2106.attribute[1].value;
	
	self.numWatercraft := v2107.attribute[1].value;
	self.numWatercraft30 := v2108.attribute[1].value;
	self.numWatercraft90 := v2109.attribute[1].value;
	self.numWatercraft180 := v2110.attribute[1].value;
	self.numWatercraft12 := v2111.attribute[1].value;
	self.numWatercraft24 := v2112.attribute[1].value;
	self.numWatercraft36 := v2113.attribute[1].value;
	self.numWatercraft60 := v2114.attribute[1].value;
	
	self.numAircraft := v2115.attribute[1].value;
	self.numAircraft30 := v2116.attribute[1].value;
	self.numAircraft90 := v2117.attribute[1].value;
	self.numAircraft180 := v2118.attribute[1].value;
	self.numAircraft12 := v2119.attribute[1].value;
	self.numAircraft24 := v2120.attribute[1].value;
	self.numAircraft36 := v2121.attribute[1].value;
	self.numAircraft60 := v2122.attribute[1].value;
	
	self.wealth_indicator := v2123.attribute[1].value;

	self.total_number_derogs := v2124.attribute[1].value;
	self.date_last_derog := v2125.attribute[1].value;
	
	self.felonies := v2126.attribute[1].value;
	self.date_last_conviction := v2127.attribute[1].value;
	self.felonies30 := v2128.attribute[1].value;
	self.felonies90 := v2129.attribute[1].value;
	self.felonies180 := v2130.attribute[1].value;
	self.felonies12 := v2131.attribute[1].value;
	self.felonies24 := v2132.attribute[1].value;
	self.felonies36 := v2133.attribute[1].value;
	self.felonies60 := v2134.attribute[1].value;
	
	self.num_liens := v2135.attribute[1].value;
	self.num_unreleased_liens := v2136.attribute[1].value;
	self.date_last_unreleased := v2137.attribute[1].value;
	self.num_unreleased_liens30 := v2138.attribute[1].value;
	self.num_unreleased_liens90 := v2139.attribute[1].value;
	self.num_unreleased_liens180 := v2140.attribute[1].value;
	self.num_unreleased_liens12 := v2141.attribute[1].value;
	self.num_unreleased_liens24 := v2142.attribute[1].value;
	self.num_unreleased_liens36 := v2143.attribute[1].value;
	self.num_unreleased_liens60 := v2144.attribute[1].value;
	
	self.num_released_liens := v2145.attribute[1].value;
	self.date_last_released := v2146.attribute[1].value;
	self.num_released_liens30 := v2147.attribute[1].value;
	self.num_released_liens90 := v2148.attribute[1].value;
	self.num_released_liens180 := v2149.attribute[1].value;
	self.num_released_liens12 := v2150.attribute[1].value;
	self.num_released_liens24 := v2151.attribute[1].value;
	self.num_released_liens36 := v2152.attribute[1].value;
	self.num_released_liens60 := v2153.attribute[1].value;
	
	self.bankruptcy_count := v2154.attribute[1].value;
	self.date_last_bankruptcy := v2155.attribute[1].value;
	self.filing_type := v2156.attribute[1].value;
	self.disposition := v2157.attribute[1].value;
	self.bankruptcy_count30 := v2158.attribute[1].value;
	self.bankruptcy_count90 := v2159.attribute[1].value;
	self.bankruptcy_count180 := v2160.attribute[1].value;
	self.bankruptcy_count12 := v2161.attribute[1].value;
	self.bankruptcy_count24 := v2162.attribute[1].value;
	self.bankruptcy_count36 := v2163.attribute[1].value;
	self.bankruptcy_count60 := v2164.attribute[1].value;
	
	self.eviction_count := v2165.attribute[1].value;
	self.date_last_eviction := v2166.attribute[1].value;
	self.eviction_count30 := v2167.attribute[1].value;
	self.eviction_count90 := v2168.attribute[1].value;
	self.eviction_count180 := v2169.attribute[1].value;
	self.eviction_count12 := v2170.attribute[1].value;
	self.eviction_count24 := v2171.attribute[1].value;
	self.eviction_count36 := v2172.attribute[1].value;
	self.eviction_count60 := v2173.attribute[1].value;

	self.num_nonderogs := v2174.attribute[1].value;
	self.num_nonderogs30 := v2175.attribute[1].value;
	self.num_nonderogs90 := v2176.attribute[1].value;
	self.num_nonderogs180 := v2177.attribute[1].value;
	self.num_nonderogs12 := v2178.attribute[1].value;
	self.num_nonderogs24 := v2179.attribute[1].value;
	self.num_nonderogs36 := v2180.attribute[1].value;
	self.num_nonderogs60 := v2181.attribute[1].value;
	
	self.num_proflic := v2182.attribute[1].value;
	self.date_last_proflic := v2183.attribute[1].value;
	self.proflic_type := v2184.attribute[1].value;
	self.expire_date_last_proflic := v2185.attribute[1].value;
	
	self.num_proflic30 := v2186.attribute[1].value;
	self.num_proflic90 := v2187.attribute[1].value;
	self.num_proflic180 := v2188.attribute[1].value;
	self.num_proflic12 := v2189.attribute[1].value;
	self.num_proflic24 := v2190.attribute[1].value;
	self.num_proflic36 := v2191.attribute[1].value;
	self.num_proflic60 := v2192.attribute[1].value;
	
	self.num_proflic_exp30 := v2193.attribute[1].value;
	self.num_proflic_exp90 := v2194.attribute[1].value;
	self.num_proflic_exp180 := v2195.attribute[1].value;
	self.num_proflic_exp12 := v2196.attribute[1].value;
	self.num_proflic_exp24 := v2197.attribute[1].value;
	self.num_proflic_exp36 := v2198.attribute[1].value;
	self.num_proflic_exp60 := v2199.attribute[1].value;
	
	self.isAddrHighRisk := v2200.attribute[1].value;
	self.isPhoneHighRisk := v2201.attribute[1].value;
	self.isAddrPrison := v2202.attribute[1].value;
	self.isZipPOBox := v2203.attribute[1].value;
	self.isZipCorpMil := v2204.attribute[1].value;
	self.phoneStatus := v2205.attribute[1].value;
	self.isPhonePager := v2206.attribute[1].value;
	self.isPhoneMobile := v2207.attribute[1].value;
	self.isPhoneZipMismatch := v2208.attribute[1].value;
	self.phoneAddrDist := v2209.attribute[1].value;
	
	self.correctedFlag := v2210.attribute[1].value;
	self.disputeFlag := v2211.attribute[1].value;
	self.securityFreeze := v2212.attribute[1].value;
	self.securityAlert := v2213.attribute[1].value;
	self.negativeAlert := v2214.attribute[1].value;
	self.idTheftFlag := v2215.attribute[1].value;
	
	
	/////////////
	self.rv_score := l.models[1].scores[1].i;
	self.rv_reason := l.models[1].scores[1].reason_codes[1].reason_code;
	self.rv_reason2 := l.models[1].scores[1].reason_codes[2].reason_code;
	self.rv_reason3 := l.models[1].scores[1].reason_codes[3].reason_code;
	self.rv_reason4 := l.models[1].scores[1].reason_codes[4].reason_code;
	
	self.history_date := (string)r.HistoryDateYYYYMM;
	
	self.seq := (unsigned)l.accountnumber;
	
	self := l;
	self := [];
end;


j_f := JOIN(resu,p_f,LEFT.attributegroups.accountnumber=RIGHT.accountnumber,normit(left,right));

output(j_f);

// ******* Resort output to original order ********

layout_final := RECORD
	rv_attributes_norm - seq;
end;

s := sort(j_f, seq);

layout_final intoFinal(s le) := transform
	self := le;
end;
final := project(s, intoFinal(left));
output(final);

// *************************************************

output(final,,'~tfuerstenberg::out::test_out',CSV(heading(single), quote('"')), overwrite);
output(final(errorcode<>''),,'~tfuerstenberg::out::test_error',CSV(QUOTE('"')), overwrite);
