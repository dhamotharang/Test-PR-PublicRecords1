EXPORT CreditAcceptanceCorp_RV_V2_BATCH_Macro(fcraroxie_IP, neutralroxie_IP, Thread, Timeout, Retry, Input_file_name, Output_file_name, records_ToRun):= FUNCTIONMACRO

IMPORT Models, iESP, Risk_Indicators, RiskWise, RiskProcessing, UT;

		unsigned8 no_of_records := records_ToRun;
		integer eyeball := 50;
		integer retry := retry;
		integer timeout := timeout;
		integer threads := Thread;
		String neutralroxieIP := neutralroxie_IP ; 
		String fcraroxieIP := fcraroxie_IP ;
		Infile_name :=  Input_file_name;
  	String outfile_name :=  Output_file_name ;

		//*********custom settings**********

		DRM:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V2_BATCH_CreditAcceptance_settings.DRM;
		IsPreScreen:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V2_BATCH_CreditAcceptance_settings.IsPreScreen;
		IncludeVersion2:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V2_BATCH_CreditAcceptance_settings.IncludeVersion2;
		DPPA:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V2_BATCH_CreditAcceptance_settings.DPPA;
		GLB:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V2_BATCH_CreditAcceptance_settings.GLB;
		HISTORYDATE := 999999;

	  //*****************************************************

	  //************** INPUT FILE GENERATION ****************	
		
		layout_input := RECORD
			Scoring_Project_Macros.Regression.global_layout;
			Scoring_Project_Macros.Regression.pii_layout;
			Scoring_Project_Macros.Regression.runtime_layout;
		END;

		ds_raw_input := IF(no_of_records <= 0, DATASET (infile_name, layout_input, thor),
																CHOOSEN(DATASET( infile_name, layout_input,thor), no_of_records));


    //*********** CreditAcceptanceCorp RV V2 BATCH SETUP AND SOAPCALL ******************
	
		Layout_Attributes_In := RECORD
			STRING name;
		END;

		layout_soap_input := record
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
			integer HistoryDateYYYYMM := HistoryDate;
			boolean Attributes := False;
			dataset(Layout_Attributes_In) RequestedAttributeGroups;
			dataset(Risk_Indicators.Layout_Gateways_In) gateways;
			string DataRestrictionMask;
		end;

		layout_soap_input append_settings(ds_raw_input le, INTEGER c) := TRANSFORM
			self.accountnumber := (string)le.accountnumber;	
			self.dppapurpose := dppa;
			self.glbpurpose := glb;
			self.attributes := true;
			self.RequestedAttributeGroups := dataset([{'version2'}], layout_attributes_in); 
			self.HistoryDateYYYYMM :=  HistoryDate;	
			self.gateways := dataset([{'neutralroxie', neutralroxieIP}], risk_indicators.Layout_Gateways_In); 
			self.DataRestrictionMask := DRM; 
			SELF := le;
			self := [];
		end;

    //ds_soap_in
		soap_in := DISTRIBUTE(PROJECT(ds_raw_input, append_settings(LEFT, counter)), Random());

	  //Soap output layout
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
		
		layout_Soap_output := RECORD, maxlength(100000)
			STRING30 AccountNumber;
			unsigned6 did := 0;
			DATASET(Models.Layout_Model) models;
			Layout_RVAttributesOut AttributeGroups;
			STRING errorcode;
		END;
					
		layout_Soap_output myFail(soap_in le) := TRANSFORM
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			SELF := le;
			SELF := [];
		END;

    //*********** PERFORMING SOAPCALL TO ROXIE ************ 		
		Soap_output := soapcall(soap_in, fcraroxieIP ,
												'Models.RiskView_Testing_Service', 
												{soap_in},
												DATASET(layout_Soap_output),
												RETRY(retry), TIMEOUT(timeout), LITERAL,
												XPATH('Models.RiskView_Testing_ServiceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
												PARALLEL(threads), onFail(myFail(LEFT)));
												
		
		// ***************************************************************************************************
		// *********************** Transform into layout for use in daily reports ****************************
		// ***************************************************************************************************
				
		get_group(recordof(layout_rvattributesout) groups, string name_i) := FUNCTION
			groupi := groups.attributegroup(name=name_i);
			RETURN groupi;
		END;

		get_attribute(dataset(Layout_AttributeGroup) groupi, integer i) := FUNCTION
			attr := groupi.attributes[i];
			attribute_values_converted := dataset([{attr.attribute[1].name, map(attr.attribute[1].value='true' => '1',
																	attr.attribute[1].value='false' => '0',
																	attr.attribute[1].value) }], Models.Layout_Parameters);
																 
			attr_converted := DATASET([{attribute_values_converted}], Layout_Attribute);
			
			RETURN attr_converted;
	  END; 
			 	 
		//GLOBAL OUTPUT LAYOUT
		Global_output_lay:= RECORD	 
		Scoring_Project_Macros.Global_Output_Layouts.FCRA_RiskView_XML_CreditAcceptancecorp_Attributes_V2_Global_Layout;			 
		END;
		
		//Appeding additional internal extras to Soap output file
	  //Mapping Version2 attributes to v2 attributes
		Global_output_lay v2_trans(Soap_output L, soap_in R) := transform
			self.accountnumber :=(string) R.accountnumber;
			self.DID := (integer)l.did; 
			self.historydate := (string)r.HistoryDateYYYYMM;
			self.FNamePop := r.firstname<>'';
			self.LNamePop := r.lastname<>'';
			self.AddrPop := r.streetaddress<>'';
			self.SSNLength := (string)(length(trim(r.ssn,left,right))) ;
			self.DOBPop := r.dateofbirth<>'';
			self.EmailPop := r.email<>'';
			self.HPhnPop := r.homephone<>'';
											
			just_groups := project(l, transform(layout_RVAttributesOut, self := l.attributegroups));
				
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
			v2216 := get_attribute(v2, 216);
			v2217 := get_attribute(v2, 217);
			v2218 := get_attribute(v2, 218);
			v2219 := get_attribute(v2, 219);
			v2220 := get_attribute(v2, 220);
			v2221 := get_attribute(v2, 221);
			v2222 := get_attribute(v2, 222);
			v2223 := get_attribute(v2, 223);
			v2224 := get_attribute(v2, 224);
			v2225 := get_attribute(v2, 225);
			v2226 := get_attribute(v2, 226);
			v2227 := get_attribute(v2, 227);
			v2228 := get_attribute(v2, 228);
			v2229 := get_attribute(v2, 229);
			v2230 := get_attribute(v2, 230);
			v2231 := get_attribute(v2, 231);
			v2232 := get_attribute(v2, 232);
			v2233 := get_attribute(v2, 233);
			v2234 := get_attribute(v2, 234);
			v2235 := get_attribute(v2, 235);
			v2236 := get_attribute(v2, 236);
			v2237 := get_attribute(v2, 237);
			v2238 := get_attribute(v2, 238);
			v2239 := get_attribute(v2, 239);
			v2240 := get_attribute(v2, 240);
			v2241 := get_attribute(v2, 241);
			v2242 := get_attribute(v2, 242);
			v2243 := get_attribute(v2, 243);
			v2244 := get_attribute(v2, 244);
			v2245 := get_attribute(v2, 245);
			v2246 := get_attribute(v2, 246);
			v2247 := get_attribute(v2, 247);
			v2248 := get_attribute(v2, 248);
			v2249 := get_attribute(v2, 249);
			v2250 := get_attribute(v2, 250);
			v2251 := get_attribute(v2, 251);
			v2252 := get_attribute(v2, 252);
			v2253 := get_attribute(v2, 253);
			v2254 := get_attribute(v2, 254);
			v2255 := get_attribute(v2, 255);
			v2256 := get_attribute(v2, 256);
			v2257 := get_attribute(v2, 257);
			v2258 := get_attribute(v2, 258);
			v2259 := get_attribute(v2, 259);
			v2260 := get_attribute(v2, 260);
			v2261 := get_attribute(v2, 261);
			v2262 := get_attribute(v2, 262);
			v2263 := get_attribute(v2, 263);
			v2264 := get_attribute(v2, 264);
			v2265 := get_attribute(v2, 265);
			v2266 := get_attribute(v2, 266);
			v2267 := get_attribute(v2, 267);
			v2268 := get_attribute(v2, 268);
			v2269 := get_attribute(v2, 269);
			v2270 := get_attribute(v2, 270);
			v2271 := get_attribute(v2, 271);
			v2272 := get_attribute(v2, 272);
			v2273 := get_attribute(v2, 273);
			v2274 := get_attribute(v2, 274);
			v2275 := get_attribute(v2, 275);
			v2276 := get_attribute(v2, 276);
			v2277 := get_attribute(v2, 277);
			v2278 := get_attribute(v2, 278);
			v2279 := get_attribute(v2, 279);
			v2280 := get_attribute(v2, 280);
			v2281 := get_attribute(v2, 281);
			v2282 := get_attribute(v2, 282);
			v2283 := get_attribute(v2, 283);
			v2284 := get_attribute(v2, 284);
			v2285 := get_attribute(v2, 285);
			v2286 := get_attribute(v2, 286);
			v2287 := get_attribute(v2, 287);
			v2288 := get_attribute(v2, 288);
			v2289 := get_attribute(v2, 289);
			v2290 := get_attribute(v2, 290);
			v2291 := get_attribute(v2, 291);
			v2292 := get_attribute(v2, 292);
			v2293 := get_attribute(v2, 293);
			v2294 := get_attribute(v2, 294);
			v2295 := get_attribute(v2, 295);
			v2296 := get_attribute(v2, 296);
			v2297 := get_attribute(v2, 297);
			v2298 := get_attribute(v2, 298);
			v2299 := get_attribute(v2, 299);
			v2300 := get_attribute(v2, 300);
			v2301 := get_attribute(v2, 301);
			v2302 := get_attribute(v2, 302);
			v2303 := get_attribute(v2, 303);
			v2304 := get_attribute(v2, 304);
			v2305 := get_attribute(v2, 305);
			v2306 := get_attribute(v2, 306);
			v2307 := get_attribute(v2, 307);
			v2308 := get_attribute(v2, 308);
			v2309 := get_attribute(v2, 309);
			v2310 := get_attribute(v2, 310);
			v2311 := get_attribute(v2, 311);
			v2312 := get_attribute(v2, 312);
			v2313 := get_attribute(v2, 313);
			v2314 := get_attribute(v2, 314);
			v2315 := get_attribute(v2, 315);
			v2316 := get_attribute(v2, 316);
			v2317 := get_attribute(v2, 317);
			v2318 := get_attribute(v2, 318);
			v2319 := get_attribute(v2, 319);
			v2320 := get_attribute(v2, 320);
			v2321 := get_attribute(v2, 321);
			v2322 := get_attribute(v2, 322);
				
		self.SSNFirstSeen:=v21.attribute[1].value;
		self.DateLastSeen:=v22.attribute[1].value;
		self.isRecentUpdate:=v23.attribute[1].value;
		self.NumSources:=v24.attribute[1].value;
		self.isPhoneFullNameMatch:=v25.attribute[1].value;
		self.isPhoneLastNameMatch:=v26.attribute[1].value;
		self.isSSNInvalid:=v27.attribute[1].value;
		self.isPhoneInvalid:=v28.attribute[1].value;
		self.isAddrInvalid:=v29.attribute[1].value;
		self.isDLInvalid:=v210.attribute[1].value;
		self.isNoVer:=v211.attribute[1].value;
		self.isDeceased:=v212.attribute[1].value;
		self.DeceasedDate:=v213.attribute[1].value;
		self.isSSNValid:=v214.attribute[1].value;
		self.isRecentIssue:=v215.attribute[1].value;
		self.LowIssueDate:=v216.attribute[1].value;
		self.HighIssueDate:=v217.attribute[1].value;
		self.IssueState:=v218.attribute[1].value;
		self.isNonUS:=v219.attribute[1].value;
		self.isIssued3:=v220.attribute[1].value;
		self.isIssuedAge5:=v221.attribute[1].value;
		self.IADateFirstReported:=v222.attribute[1].value;
		self.IADateLastReported:=v223.attribute[1].value;
		self.IALenOfRes:=v224.attribute[1].value;
		self.IADwellType:=v225.attribute[1].value;
		self.IALandUseCode:=v226.attribute[1].value;
		self. IAAssessedValue:=v227.attribute[1].value;
		self.IAisOwnedBySubject:=v228.attribute[1].value;
		self.IAisFamilyOwned:=v229.attribute[1].value;
		self.IAisOccupantOwned:=v230.attribute[1].value;
		self.IALastSaleDate:=v231.attribute[1].value;
		self. IALastSaleAmount:=v232.attribute[1].value;
		self.IAisNotPrimaryRes:=v233.attribute[1].value;
		self.IAPhoneListed:=v234.attribute[1].value;
		self. IAPhoneNumber:=v235.attribute[1].value;
		self.CADateFirstReported:=v236.attribute[1].value;
		self.CADateLastReported:=v237.attribute[1].value;
		self.CALenOfRes:=v238.attribute[1].value;
		self.CADwellType:=v239.attribute[1].value;
		self.CALandUseCode:=v240.attribute[1].value;
		self. CAAssessedValue:=v241.attribute[1].value;
		self.CAisOwnedBySubject:=v242.attribute[1].value;
		self.CAisFamilyOwned:=v243.attribute[1].value;
		self.CAisOccupantOwned:=v244.attribute[1].value;
		self.CALastSaleDate:=v245.attribute[1].value;
		self. CALastSaleAmount:=v246.attribute[1].value;
		self.CAisNotPrimaryRes:=v247.attribute[1].value;
		self.CAPhoneListed:=v248.attribute[1].value;
		self. CAPhoneNumber:=v249.attribute[1].value;
		self.PADateFirstReported:=v250.attribute[1].value;
		self.PADateLastReported:=v251.attribute[1].value;
		self.PALenOfRes:=v252.attribute[1].value;
		self.PADwellType:=v253.attribute[1].value;
		self.PALandUseCode:=v254.attribute[1].value;
		self. PAAssessedValue:=v255.attribute[1].value;
		self.PAisOwnedBySubject:=v256.attribute[1].value;
		self.PAisFamilyOwned:=v257.attribute[1].value;
		self.PAisOccupantOwned:=v258.attribute[1].value;
		self.PALastSaleDate:=v259.attribute[1].value;
		self. PALastSaleAmount:=v260.attribute[1].value;
		self.PAisNotPrimaryRes:=v261.attribute[1].value;
		self.PAPhoneListed:=v262.attribute[1].value;
		self. PAPhoneNumber:=v263.attribute[1].value;
		self.isInputCurrMatch:=v264.attribute[1].value;
		self.DistInputCurr:=v265.attribute[1].value;
		self.isDiffState:=v266.attribute[1].value;
		self. AssessedDiff:=v267.attribute[1].value;
		self.EcoTrajectory:=v268.attribute[1].value;
		self.isInputPrevMatch:=v269.attribute[1].value;
		self.DistCurrPrev:=v270.attribute[1].value;
		self.isDiffState2:=v271.attribute[1].value;
		self. AssessedDiff2:=v272.attribute[1].value;
		self.EcoTrajectory2:=v273.attribute[1].value;
		self.mobility_indicator:=v274.attribute[1].value;
		self.statusAddr:=v275.attribute[1].value;
		self.statusAddr2:=v276.attribute[1].value;
		self.statusAddr3:=v277.attribute[1].value;
		self.PADateFirstReported2:=v278.attribute[1].value;
		self.NPADateFirstReported:=v279.attribute[1].value;
		self.addrChanges30:=v280.attribute[1].value;
		self.addrChanges90:=v281.attribute[1].value;
		self.addrChanges180:=v282.attribute[1].value;
		self.addrChanges12:=v283.attribute[1].value;
		self.addrChanges24:=v284.attribute[1].value;
		self.addrChanges36:=v285.attribute[1].value;
		self.addrChanges60:=v286.attribute[1].value;
		self.property_owned_total:=v287.attribute[1].value;
		self. property_owned_assessed_total:=v288.attribute[1].value;
		self.property_historically_owned:=v289.attribute[1].value;
		self.date_first_purchase:=v290.attribute[1].value;
		self.date_most_recent_purchase:=v291.attribute[1].value;
		self.date_most_recent_sale:=v292.attribute[1].value;
		self.numPurchase30:=v293.attribute[1].value;
		self.numPurchase90:=v294.attribute[1].value;
		self.numPurchase180:=v295.attribute[1].value;
		self.numPurchase12:=v296.attribute[1].value;
		self.numPurchase24:=v297.attribute[1].value;
		self.numPurchase36:=v298.attribute[1].value;
		self.numPurchase60:=v299.attribute[1].value;
		self.numSold30:=v2100.attribute[1].value;
		self.numSold90:=v2101.attribute[1].value;
		self.numSold180:=v2102.attribute[1].value;
		self.numSold12:=v2103.attribute[1].value;
		self.numSold24:=v2104.attribute[1].value;
		self.numSold36:=v2105.attribute[1].value;
		self.numSold60:=v2106.attribute[1].value;
		self.numWatercraft:=v2107.attribute[1].value;
		self.numWatercraft30:=v2108.attribute[1].value;
		self.numWatercraft90:=v2109.attribute[1].value;
		self.numWatercraft180:=v2110.attribute[1].value;
		self.numWatercraft12:=v2111.attribute[1].value;
		self.numWatercraft24:=v2112.attribute[1].value;
		self.numWatercraft36:=v2113.attribute[1].value;
		self.numWatercraft60:=v2114.attribute[1].value;
		self.numAircraft:=v2115.attribute[1].value;
		self.numAircraft30:=v2116.attribute[1].value;
		self.numAircraft90:=v2117.attribute[1].value;
		self.numAircraft180:=v2118.attribute[1].value;
		self.numAircraft12:=v2119.attribute[1].value;
		self.numAircraft24:=v2120.attribute[1].value;
		self.numAircraft36:=v2121.attribute[1].value;
		self.numAircraft60:=v2122.attribute[1].value;
		self.wealth_indicator:=v2123.attribute[1].value;
		self.total_number_derogs:=v2124.attribute[1].value;
		self.date_last_derog:=v2125.attribute[1].value;
		self.felonies:=v2126.attribute[1].value;
		self.date_last_conviction:=v2127.attribute[1].value;
		self.felonies30:=v2128.attribute[1].value;
		self.felonies90:=v2129.attribute[1].value;
		self.felonies180:=v2130.attribute[1].value;
		self.felonies12:=v2131.attribute[1].value;
		self.felonies24:=v2132.attribute[1].value;
		self.felonies36:=v2133.attribute[1].value;
		self.felonies60:=v2134.attribute[1].value;
		self.num_liens:=v2135.attribute[1].value;
		self.num_unreleased_liens:=v2136.attribute[1].value;
		self.date_last_unreleased:=v2137.attribute[1].value;
		self.num_unreleased_liens30:=v2138.attribute[1].value;
		self.num_unreleased_liens90:=v2139.attribute[1].value;
		self.num_unreleased_liens180:=v2140.attribute[1].value;
		self.num_unreleased_liens12:=v2141.attribute[1].value;
		self.num_unreleased_liens24:=v2142.attribute[1].value;
		self.num_unreleased_liens36:=v2143.attribute[1].value;
		self.num_unreleased_liens60:=v2144.attribute[1].value;
		self.num_released_liens:=v2145.attribute[1].value;
		self.date_last_released:=v2146.attribute[1].value;
		self.num_released_liens30:=v2147.attribute[1].value;
		self.num_released_liens90:=v2148.attribute[1].value;
		self.num_released_liens180:=v2149.attribute[1].value;
		self.num_released_liens12:=v2150.attribute[1].value;
		self.num_released_liens24:=v2151.attribute[1].value;
		self.num_released_liens36:=v2152.attribute[1].value;
		self.num_released_liens60:=v2153.attribute[1].value;
		self.bankruptcy_count:=v2154.attribute[1].value;
		self.date_last_bankruptcy:=v2155.attribute[1].value;
		self.filing_type:=v2156.attribute[1].value;
		self. disposition:=v2157.attribute[1].value;
		self.bankruptcy_count30:=v2158.attribute[1].value;
		self.bankruptcy_count90:=v2159.attribute[1].value;
		self.bankruptcy_count180:=v2160.attribute[1].value;
		self.bankruptcy_count12:=v2161.attribute[1].value;
		self.bankruptcy_count24:=v2162.attribute[1].value;
		self.bankruptcy_count36:=v2163.attribute[1].value;
		self.bankruptcy_count60:=v2164.attribute[1].value;
		self.eviction_count:=v2165.attribute[1].value;
		self.date_last_eviction:=v2166.attribute[1].value;
		self.eviction_count30:=v2167.attribute[1].value;
		self.eviction_count90:=v2168.attribute[1].value;
		self.eviction_count180:=v2169.attribute[1].value;
		self.eviction_count12:=v2170.attribute[1].value;
		self.eviction_count24:=v2171.attribute[1].value;
		self.eviction_count36:=v2172.attribute[1].value;
		self.eviction_count60:=v2173.attribute[1].value;
		self.num_nonderogs:=v2174.attribute[1].value;
		self.num_nonderogs30:=v2175.attribute[1].value;
		self.num_nonderogs90:=v2176.attribute[1].value;
		self.num_nonderogs180:=v2177.attribute[1].value;
		self.num_nonderogs12:=v2178.attribute[1].value;
		self.num_nonderogs24:=v2179.attribute[1].value;
		self.num_nonderogs36:=v2180.attribute[1].value;
		self.num_nonderogs60:=v2181.attribute[1].value;
		self.num_proflic:=v2182.attribute[1].value;
		self.date_last_proflic:=v2183.attribute[1].value;
		self. proflic_type:=v2184.attribute[1].value;
		self.expire_date_last_proflic:=v2185.attribute[1].value;
		self.num_proflic30:=v2186.attribute[1].value;
		self.num_proflic90:=v2187.attribute[1].value;
		self.num_proflic180:=v2188.attribute[1].value;
		self.num_proflic12:=v2189.attribute[1].value;
		self.num_proflic24:=v2190.attribute[1].value;
		self.num_proflic36:=v2191.attribute[1].value;
		self.num_proflic60:=v2192.attribute[1].value;
		self.num_proflic_exp30:=v2193.attribute[1].value;
		self.num_proflic_exp90:=v2194.attribute[1].value;
		self.num_proflic_exp180:=v2195.attribute[1].value;
		self.num_proflic_exp12:=v2196.attribute[1].value;
		self.num_proflic_exp24:=v2197.attribute[1].value;
		self.num_proflic_exp36:=v2198.attribute[1].value;
		self.num_proflic_exp60:=v2199.attribute[1].value;
		self.isAddrHighRisk:=v2200.attribute[1].value;
		self.isPhoneHighRisk:=v2201.attribute[1].value;
		self.isAddrPrison:=v2202.attribute[1].value;
		self.isZipPOBox:=v2203.attribute[1].value;
		self.isZipCorpMil:=v2204.attribute[1].value;
		self.phoneStatus:=v2205.attribute[1].value;
		self.isPhonePager:=v2206.attribute[1].value;
		self.isPhoneMobile:=v2207.attribute[1].value;
		self.isPhoneZipMismatch:=v2208.attribute[1].value;
		self.phoneAddrDist:=v2209.attribute[1].value;
		self.correctedFlag:=v2210.attribute[1].value;
		self.disputeFlag:=v2211.attribute[1].value;
		self.securityFreeze:=v2212.attribute[1].value;
		self.securityAlert:=v2213.attribute[1].value;
		self.negativeAlert:=v2214.attribute[1].value;
		self.idTheftFlag:=v2215.attribute[1].value;
		self := L;
		self := [];
		end;
					
		res := JOIN(Soap_output,soap_in,(integer)LEFT.accountnumber=(integer)RIGHT.accountnumber,v2_trans(LEFT,RIGHT));
			 
	 //final file out to thor	 
	 final_output := output(res ,, outfile_name, thor, compressed, overwrite);

   RETURN final_output;

ENDMACRO;