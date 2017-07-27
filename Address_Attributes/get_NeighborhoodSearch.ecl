import address_attributes, addrfraud, advo, avm_v2, easi, FBI_UCR, iesp, LN_PropertyV2, property, Risk_Indicators, ut;

export get_NeighborhoodSearch(DATASET(Address_Attributes.Layouts.address_in) indata) := FUNCTION

//Constants
		boolean goodTransaction := if(indata[1].street_address <> '' and  indata[1].city <> '' and  indata[1].state <> '' and  indata[1].zip <> '', true, false);		
		// goodTransIndata := indata(street_address <> '' and  city <> '' and  state <> '' and  zip <> '');			
		nearby_geolinks := 10;
		NeighborhoodScoreRange_low := 0;
		NeighborhoodScoreRange_high := 1000;
		FBIScoreRange_low := 0;
		FBIScoreRange_high := 1000;
		EASIScoreRange_low := 0;
		EASIScoreRange_high := 200;
		
//Data Sources
		File_Census				:= Easi.Key_Easi_Census;
		File_Address_Risk	:= AddrFraud.Key_AddrFraud_GeoLink;
		File_FBIUCR				:= FBI_UCR.key_CIUS_city_addr;
		
//Clean Addresses
		Address_Attributes.Layouts.in_clean AddressClean(indata l, integer c) := TRANSFORM
				self.seq := c;
				self.street_address_in := l.street_address;
				self.apt_in := l.apt;
				self.city_in := l.city;
				self.state_in := l.state;
				self.zip_in := l.zip;
				self.zip4_in := l.zip4;
				clean_address := Risk_Indicators.MOD_AddressClean.clean_addr(l.street_address, l.city, l.state, l.zip);
				self.prim_range := clean_address [1..10];
				self.predir := clean_address [11..12];
				self.prim_name := clean_address [13..40];
				self.suffix := clean_address [41..44];
				self.postdir := clean_address [45..46];
				self.unit_desig := clean_address [47..56];
				// self.sec_range := clean_address [57..65];
				self.sec_range := l.apt;
				self.p_city_name := clean_address [90..114];
				self.st := clean_address [115..116];
				self.zip := clean_address [117..121];
				self.zip4 := clean_address[122..125];
				self.county := clean_address[143..145];
				self.geo_lat := clean_address[146..155];
				self.geo_long := clean_address[156..166];
				self.msa := clean_address[167..170];
				self.geo_blk := clean_address[171..177];
				self.geo_match := clean_address[178];
				//build geolink
				self.geolink := clean_address[115..116]+clean_address[143..145]+clean_address[171..177];
		end;

		cleaned := project(indata, AddressClean(Left, COUNTER));

//Get Census data
		Address_Attributes.Layouts.rNeigbhorhood_Report addEASI(cleaned l, File_Census r) := transform
			self.seq := l.seq;
			self := r;
			self := l;
			self := [];
		end;
		base_EASI := join(cleaned, File_Census,
			left.geolink != '' and 
			keyed(left.geolink = right.geolink),
			addEASI(left, right),Left Outer, keep(1), atmost(100));

//Get FBI National Score
		fbi_slim := record
				integer8	seq;
				fbi_ucr.layouts.layout_CIUS_city;
		end;
 
		fbi_slim getFBIScore(base_EASI l, File_FBIUCR r) := transform
			self.seq := l.seq;
			self := r;
		end;

		all_FBI := join(base_EASI, File_FBIUCR,
			left.st != '' and left.city_in != '' and
			keyed(left.st = right.state) and
			keyed(left.city_in = right.city),
			getFBIScore(left, right),Left Outer, keep(10), atmost(100));

//Add FBI National Score
		best_fbi := dedup(sort(all_FBI, seq, -datadate), seq);
		Address_Attributes.Layouts.rNeigbhorhood_Report addFBIScore(base_EASI l, best_fbi r) := transform
			self.seq := l.seq;
			self.FBINationalScore := r.fbi_score;
			self := l;
		end;

		base_FBI := join(base_EASI, best_fbi,
			left.seq = right.seq,
			addFBIScore(left, right),Left Outer, keep(10), atmost(100));

//Get Address Risk Data
		Address_Attributes.Layouts.rNeigbhorhood_Report addAddressRisk(base_FBI l, File_Address_Risk r) := TRANSFORM
			self.seq := l.seq;
			Poverty_Index_Raw     := ((real)l.LOWINC/100);
			Disruption_Index_Raw  := ((real)l.FAMOTF18_P/100);
			Poverty_Index := 100*(if(Poverty_Index_Raw<=0, 0, Poverty_Index_Raw));
			Disruption_Index := 100*(if(Disruption_Index_Raw<=0, 0, Disruption_Index_Raw));
			personsPerHouse := 2;
			Crime_Index_Raw := if(r.crimes*100000/r.occupants > 1000, 999, r.crimes*100000/r.occupants);
			Foreclosure_Index_Raw := r.foreclosures*100000/(r.occupants/personsPerHouse);
			Mobility_Index_Raw    := (r.turnover_1yr_in + r.turnover_1yr_out)/r.occupants_1yr;
			Crime_Index 	:= .5*(if(Crime_Index_Raw<=0, 0, Crime_Index_Raw));
			Foreclosure_Index := .0233*(if(Foreclosure_Index_Raw<=0, 0, Foreclosure_Index_Raw));
			Mobility_Index := 100 * abs(Mobility_Index_Raw);
			risk_SOS := if(Crime_Index + Poverty_Index + Foreclosure_Index + Disruption_Index + Mobility_Index >= 1000, 999, Crime_Index + Poverty_Index + Foreclosure_Index + Disruption_Index + Mobility_Index);
			Risk_Index := risk_SOS; 
			self.ar_occupants := r.occupants;
			self.ar_turnover_1yr_in := r.turnover_1yr_in;
			self.ar_turnover_1yr_out := r.turnover_1yr_out;
			self.ar_crimes := r.crimes;
			self.ar_crimes_1yr := r.crimes_1yr;
			self.ar_crimes_2yr := r.crimes_2yr;
			self.ar_foreclosures := r.foreclosures;
			self.ar_foreclosures_1yr := r.foreclosures_1yr;
			self.ar_foreclosures_2yr := r.foreclosures_2yr;
			self.ar_sexoffenders := r.sexoffenders;
			self.ar_sexoffenders_1yr := r.sexoffenders_1yr;
			self.ar_sexoffenders_2yr := r.sexoffenders_2yr;
			self.Crime_Index := Crime_Index;
			self.Poverty_Index := abs(Poverty_Index);
			self.Foreclosure_Index := Foreclosure_Index;
			self.Disruption_Index := abs(Disruption_Index);
			self.Mobility_Index := Mobility_Index;
			self.Risk_Index := Risk_Index;
			self := l;
		END;

		final_data := join(base_FBI, File_Address_Risk,
			left.geolink != '' and 
			keyed(left.geolink = right.geolink),
			addAddressRisk(left, right), Left Outer, keep(1), atmost(100));

//Map Results to ESDL
	//main payload
	iesp.neighborhood_safety.t_NeighborhoodSafetySearchResponse toESDL(final_data l) := TRANSFORM
		// Header
		self._Header.Status								:= if(goodTransaction,1,0);
		self._Header.Message							:= if(goodTransaction,'', 'Results may be incomplete.  Input requirements not met.');
		// self._Header.QueryID																				:= '';
		// self._Header.TransactionID																	:= trans_id;
		
		//Score Ranges
		self.SafetyScores.NeighborhoodScoreRange.low := NeighborhoodScoreRange_low;
		self.SafetyScores.NeighborhoodScoreRange.high := NeighborhoodScoreRange_high;
		self.SafetyScores.FBIScoreRange.low := FBIScoreRange_low;
		self.SafetyScores.FBIScoreRange.high := FBIScoreRange_high;
		self.SafetyScores.EASIScoreRange.low := EASIScoreRange_low;
		self.SafetyScores.EASIScoreRange.high := EASIScoreRange_high;

		// Scores
		self.SafetyScores.NeighborhoodSafetyScore := if(l.Risk_Index = 0, -1, l.Risk_Index);
		self.SafetyScores.FBINationalScore := if(l.FBINationalScore > FBIScoreRange_high, FBIScoreRange_high, l.FBINationalScore);
		self.SafetyScores.EASIQualityOfLife := if((integer)l.EASIQLIFE > EASIScoreRange_high, (string)EASIScoreRange_high, l.EASIQLIFE);
				
		self := l;
		self := [];
	end;	
	final_report_iesp := project(final_data, toESDL(left));

///////////////
//FINAL RESULTS

Return final_report_iesp;

END;
