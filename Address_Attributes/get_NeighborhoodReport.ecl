import address_attributes, addrfraud, advo, avm_v2, easi, FBI_UCR, iesp, LN_PropertyV2, property, Risk_Indicators, ut;

export get_NeighborhoodReport(DATASET(Address_Attributes.Layouts.address_in) indata) := FUNCTION

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

//Get Geolink based data
		Address_Attributes.Layouts.rNeigbhorhood_Report getGeolinkData(cleaned l) := TRANSFORM
			self.seq := l.seq;
			self.SexOffenders  := choosen(Address_Attributes.get_Data.Sex_Offenders(Address_Attributes.functions.getGeolinks(l.geolink, nearby_geolinks)),iesp.Constants.NeighborSafety.MaxSexOffender);
			self.PublicSafety  := choosen(Address_Attributes.get_Data.Public_Safety(Address_Attributes.functions.getGeolinks(l.geolink, nearby_geolinks)),iesp.Constants.NeighborSafety.MaxPublicSafety);
			self.Correctional  := choosen(Address_Attributes.get_Data.Correctional(Address_Attributes.functions.getGeolinks(l.geolink, nearby_geolinks)),iesp.Constants.NeighborSafety.MaxCorrecFacility);
			self.Neighborhood	 := Address_Attributes.get_Data.Neighborhood_Stats(Address_Attributes.functions.getGeolinks(l.geolink, 0));
			self := l;
			self := [];
		end;
		
		geolink_data := project(cleaned, getGeolinkData(left));

//Get Census data
		Address_Attributes.Layouts.rNeigbhorhood_Report addEASI(geolink_data l, File_Census r) := transform
			self.seq := l.seq;
			self := r;
			self := l;
		end;
		base_EASI := join(geolink_data, File_Census,
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
	//sex offenders
	iesp.neighborhood_safety.t_SexOffender toSO_ESDL(Address_Attributes.Layouts.rSexOffenders l):=transform
		self.uniqueId			:= l.offender_id;
		self.Name.First		:= l.fname;
		self.Name.Middle	:= l.mname;
		self.Name.Last		:= l.lname;
		self.DOB.Year		:=(integer)l.DOB[1..4];
		self.DOB.Month	:=(integer)l.DOB[5..6];
		self.DOB.Day		:=(integer)l.DOB[7..8];
		self.Age				:=(integer)ut.GetAgeI((unsigned8)l.dob);
		self.Race				:=l.race;
		self.Ethnicity	:=l.ethnicity;
		self.Sex				:=l.sex;
		self.HairColor	:=l.hair_color;
		self.EyeColor		:=l.eye_color;
		self.Heigth			:=l.height;
		self.Weight			:=l.weight;
		self.SkinTone		:=l.skin_tone;
		self.GeoAddress.Address.StreetNumber					:=l.prim_range;
		self.GeoAddress.Address.StreetPreDirection		:=l.predir;
		self.GeoAddress.Address.StreetName						:=l.prim_name;
		self.GeoAddress.Address.StreetSuffix					:=l.addr_suffix;
		self.GeoAddress.Address.StreetPostDirection		:=l.postdir;
		self.GeoAddress.Address.UnitDesignation				:=l.unit_desig;
		self.GeoAddress.Address.UnitNumber						:=l.sec_range;
		self.GeoAddress.Address.City									:=l.p_city_name;
		self.GeoAddress.Address.State									:=l.st;
		self.GeoAddress.Address.Zip5									:=l.zip5;
		self.GeoAddress.Address.Zip4									:=l.zip4;
		self.GeoAddress.Location.Latitude		:=l.geo_lat;
		self.GeoAddress.Location.Longitude	:=l.geo_long;
		self :=[];
	end;
	
	
	//public safety
	iesp.neighborhood_safety.t_PublicSafetyFacility toPS_ESDL(Address_Attributes.Layouts.rPublicSafety l):=transform
		self.Name									:= l.Name;
		self.Institution					:= l.Institution;
		self.Distance							:= l.Distance;
		self.BID									:= l.BDID;
		self.Officers							:= l.Officers;
		self.PopulationPerOfficer	:= l.Pop_per_Cop;
		self.Website							:= l.Website;
		self.Phone								:= l.Phone10;
		self.GeoAddress.Address.StreetNumber					:=l.prim_range;
		self.GeoAddress.Address.StreetPreDirection		:=l.predir;
		self.GeoAddress.Address.StreetName						:=l.prim_name;
		self.GeoAddress.Address.StreetSuffix					:=l.addr_suffix;
		self.GeoAddress.Address.StreetPostDirection		:=l.postdir;
		self.GeoAddress.Address.UnitDesignation				:=l.unit_desig;
		self.GeoAddress.Address.UnitNumber						:=l.sec_range;
		self.GeoAddress.Address.City									:=l.p_city_name;
		self.GeoAddress.Address.State									:=l.st;
		self.GeoAddress.Address.Zip5									:=l.zip;
		self.GeoAddress.Address.Zip4									:=l.zip4;
		self.GeoAddress.Location.Latitude		:=l.geo_lat;
		self.GeoAddress.Location.Longitude	:=l.geo_long;
		self :=[];
	end;
	
	//correctional facilities
	iesp.neighborhood_safety.t_Facility toCF_ESDL(Address_Attributes.Layouts.rCorrectional l):=transform
		self.Name					:= l.institution;
		self.Institution	:= l.institution;
		self.Distance			:= l.distance;
		self.GeoAddress.Address.StreetNumber					:=l.prim_range;
		self.GeoAddress.Address.StreetPreDirection		:=l.predir;
		self.GeoAddress.Address.StreetName						:=l.prim_name;
		self.GeoAddress.Address.StreetSuffix					:=l.addr_suffix;
		self.GeoAddress.Address.StreetPostDirection		:=l.postdir;
		self.GeoAddress.Address.UnitDesignation				:=l.unit_desig;
		self.GeoAddress.Address.UnitNumber						:=l.sec_range;
		self.GeoAddress.Address.City									:=l.p_city_name;
		self.GeoAddress.Address.State									:=l.st;
		self.GeoAddress.Address.Zip5									:=l.zip;
		self.GeoAddress.Address.Zip4									:=l.zip4;
		self.GeoAddress.Location.Latitude		:=l.geo_lat;
		self.GeoAddress.Location.Longitude	:=l.geo_long;
		self :=[];
	end;
	

	//main payload
	iesp.neighborhood_safety.t_NeighborhoodSafetyReportResponse toESDL(final_data l) := TRANSFORM
		// Header
		self._Header.Status												:= if(goodTransaction,1,0);
		self._Header.Message											:= if(goodTransaction,'', 'Results may be incomplete.  Input requirements not met.');
		// self._Header.QueryID										:= '';
		// self._Header.TransactionID							:= trans_id;
		
		//Score Ranges
		self.Report.SafetyScores.NeighborhoodScoreRange.low := NeighborhoodScoreRange_low;
		self.Report.SafetyScores.NeighborhoodScoreRange.high := NeighborhoodScoreRange_high;
		self.Report.SafetyScores.FBIScoreRange.low := FBIScoreRange_low;
		self.Report.SafetyScores.FBIScoreRange.high := FBIScoreRange_high;
		self.Report.SafetyScores.EASIScoreRange.low := EASIScoreRange_low;
		self.Report.SafetyScores.EASIScoreRange.high := EASIScoreRange_high;

		// Scores
		self.Report.SafetyScores.NeighborhoodSafetyScore := if(l.Risk_Index = 0, -1, l.Risk_Index) ;
		self.Report.SafetyScores.FBINationalScore := if(l.FBINationalScore > FBIScoreRange_high, FBIScoreRange_high, l.FBINationalScore);
		self.Report.SafetyScores.EASIQualityOfLife := if((integer)l.EASIQLIFE > EASIScoreRange_high, (string)EASIScoreRange_high, l.EASIQLIFE);
				
		//Census
		self.Report.Demographics.Population := l.POP00;
		self.Report.Demographics.Families := l.FAMILIES;
		self.Report.Demographics.HouseHold := l.HH00;
		self.Report.Demographics.HouseHoldSize := l.HHSIZE;
		// self.Report.Demographics.MedianAge := l.MED_AGE;
		self.Report.Demographics.MedianRent := l.MED_RENT;
		self.Report.Demographics.MedianHouseValue := l.MED_HVAL;
		self.Report.Demographics.MedianYearBuilt := l.MED_YEARBLT;
		self.Report.Demographics.MedianHouseHoldIncome := l.MED_HHINC;
		self.Report.Demographics.UrbanPercent := l.URBAN_P;
		self.Report.Demographics.RuralPercent := l.RURAL_P;
		self.Report.Demographics.MarriedFamiliesPercent := l.FAMMAR_P;
		self.Report.Demographics.Families18YearsPercent := l.FAMMAR18_P;
		self.Report.Demographics.Families18YearsNotLivingAtHomePercent := l.FAMOTF18_P;
		self.Report.Demographics.Child := l.CHILD;
		self.Report.Demographics.Young := l.YOUNG;
		self.Report.Demographics.Retired := l.RETIRED;
		self.Report.Demographics.DivorcedFamiliesPercent := l.FEMDIV_P;
		self.Report.Demographics.VacantPercent := l.VACANT_P;
		self.Report.Demographics.OccupiedUnitPercent := l.OCCUNIT_P;
		self.Report.Demographics.OwnerOccupied := l.OWNOCP;
		self.Report.Demographics.RentOccupied := l.RENTOCP;
		self.Report.Demographics.SingleFamilyDetachedUnitPercent := l.SFDU_P;
		self.Report.Demographics.BigApartmentPercent := l.BIGAPT_P;
		self.Report.Demographics.TrailerPercent := l.TRAILER_P;
		self.Report.Demographics.HigherRent := l.HIGHRENT;
		self.Report.Demographics.LowerRent := l.LOWRENT;
		self.Report.Demographics.LowerHouseValue := l.LOW_HVAL;
		self.Report.Demographics.HigherHouseValue := l.HIGH_HVAL;
		self.Report.Demographics.NewHouses := l.NEWHOUSE;
		self.Report.Demographics.OldHouses := l.OLDHOUSE;
		self.Report.Demographics.LowIncome := l.LOWINC;
		self.Report.Demographics.HighIncome := l.HIGHINC;
		self.Report.Demographics.PopulationOver25 := l.POPOVER25;//easi pop 18-25 aggregate it
		self.Report.Demographics.PopulationOver18 := l.POPOVER18;//easi pop 18-25 aggregate it
		self.Report.Demographics.LowEducation := l.LOW_ED;
		self.Report.Demographics.HighEducation := l.HIGH_ED;
		self.Report.Demographics.InCollege := l.INCOLLEGE;
		self.Report.Demographics.Unemployed := l.UNEMP;
		self.Report.Demographics.CivilEmployed := l.CIV_EMP;
		self.Report.Demographics.MilitaryEmployed := l.MIL_EMP;
		self.Report.Demographics.WhiteCollar := l.WHITE_COL;
		self.Report.Demographics.BlueCollar := l.BLUE_COL;
		self.Report.Demographics.Murders := l.MURDERS;
		self.Report.Demographics.Rape := l.RAPE;
		self.Report.Demographics.Robbery := l.ROBBERY;
		self.Report.Demographics.Assault := l.ASSAULT;
		self.Report.Demographics.Burglary := l.BURGLARY;
		self.Report.Demographics.Larceny := l.LARCENY;
		self.Report.Demographics.CarTheft := l.CARTHEFT;
		self.Report.Demographics.TotalCrime := l.TOTCRIME;
		self.Report.Demographics.EasiqScore := l.EASIQLIFE;
		
		//Neighborhood Risk
		self.Report.AddressRisk.occupants						:= l.ar_occupants;
		self.Report.AddressRisk.Turnover1YearIn			:= l.ar_turnover_1yr_in;
		self.Report.AddressRisk.Turnover1YearOut		:= l.ar_turnover_1yr_out;
		self.Report.AddressRisk.Crimes							:= l.ar_crimes;
		self.Report.AddressRisk.Crimes1Year					:= l.ar_crimes_1yr;
		self.Report.AddressRisk.Crimes2Year					:= l.ar_crimes_2yr;
		self.Report.AddressRisk.Foreclosures				:= l.ar_foreclosures;
		self.Report.AddressRisk.Foreclosures1Year		:= l.ar_foreclosures_1yr;
		self.Report.AddressRisk.Foreclosures2Years	:= l.ar_foreclosures_2yr;
		self.Report.AddressRisk.SexOffenders				:= l.ar_sexoffenders;
		self.Report.AddressRisk.SexOffenders1Year		:= l.ar_sexoffenders_1yr;
		self.Report.AddressRisk.SexOffenders2Years	:= l.ar_sexoffenders_2yr;
		self.Report.AddressRisk.CrimeIndex					:= (string)l.Crime_Index;
		self.Report.AddressRisk.PovertyIndex				:= (string)l.Poverty_Index;
		self.Report.AddressRisk.ForeclosureIndex		:= (string)l.Foreclosure_Index;
		self.Report.AddressRisk.DisruptionIndex			:= (string)l.Disruption_Index;
		self.Report.AddressRisk.MobilityIndex				:= (string)l.Mobility_Index;
		self.Report.AddressRisk.RiskIndex						:= l.Risk_Index;

		//Neighborhood Statistics
		self.Report.NeighborhoodStats.VacantProperties 			:= l.Neighborhood[1].neighborhood_vacant_properties;
		self.Report.NeighborhoodStats.Business				 			:= l.Neighborhood[1].neighborhood_business_count;
		self.Report.NeighborhoodStats.SingleFamilyDwelling	:= l.Neighborhood[1].neighborhood_sfd_count;
		self.Report.NeighborhoodStats.MultiFamilyDwelling		:= l.Neighborhood[1].neighborhood_mfd_count;
		self.Report.NeighborhoodStats.CollegeAddress				:= l.Neighborhood[1].neighborhood_collegeaddr_count;
		self.Report.NeighborhoodStats.SeasonalAddress				:= l.Neighborhood[1].neighborhood_seasonaladdr_count;
		self.Report.NeighborhoodStats.POBOX									:= l.Neighborhood[1].neighborhood_pobox_count;
		self.Report.NeighborhoodStats.NoticeOfDefault				:= l.Neighborhood[1].nod;
		self.Report.NeighborhoodStats.NoticeOfDefault1Year	:= l.Neighborhood[1].nod_1yr;
		self.Report.NeighborhoodStats.NoticeOfDefault2Year	:= l.Neighborhood[1].nod_2yr;
		self.Report.NeighborhoodStats.NoticeOfDefault3Year	:= l.Neighborhood[1].nod_3yr;
		self.Report.NeighborhoodStats.NoticeOfDefault4Year	:= l.Neighborhood[1].nod_4yr;
		self.Report.NeighborhoodStats.NoticeOfDefault5Year	:= l.Neighborhood[1].nod_5yr;
		self.Report.NeighborhoodStats.Foreclosures					:= l.Neighborhood[1].foreclosures;
		self.Report.NeighborhoodStats.Foreclosures1Year			:= l.Neighborhood[1].foreclosures_1yr;
		self.Report.NeighborhoodStats.Foreclosures2Year			:= l.Neighborhood[1].foreclosures_2yr;
		self.Report.NeighborhoodStats.Foreclosures3Year			:= l.Neighborhood[1].foreclosures_3yr;
		self.Report.NeighborhoodStats.Foreclosures4Year			:= l.Neighborhood[1].foreclosures_4yr;
		self.Report.NeighborhoodStats.Foreclosures5Year			:= l.Neighborhood[1].foreclosures_5yr;
		self.Report.NeighborhoodStats.DeedTransfers					:= l.Neighborhood[1].deed_transfers;
		self.Report.NeighborhoodStats.DeedTransfers1Year		:= l.Neighborhood[1].deed_transfers_1yr;
		self.Report.NeighborhoodStats.DeedTransfers2Year		:= l.Neighborhood[1].deed_transfers_2yr;
		self.Report.NeighborhoodStats.DeedTransfers3Year		:= l.Neighborhood[1].deed_transfers_3yr;
		self.Report.NeighborhoodStats.DeedTransfers4Year		:= l.Neighborhood[1].deed_transfers_4yr;
		self.Report.NeighborhoodStats.DeedTransfers5Year		:= l.Neighborhood[1].deed_transfers_5yr;
		self.Report.NeighborhoodStats.ReleaseLisPendens			:= l.Neighborhood[1].release_lis_pendens;
		self.Report.NeighborhoodStats.ReleaseLisPendens1Year	:= l.Neighborhood[1].release_lis_pendens_1yr;
		self.Report.NeighborhoodStats.ReleaseLisPendens2Year	:= l.Neighborhood[1].release_lis_pendens_2yr;
		self.Report.NeighborhoodStats.ReleaseLisPendens3Year	:= l.Neighborhood[1].release_lis_pendens_3yr;
		self.Report.NeighborhoodStats.ReleaseLisPendens4Year	:= l.Neighborhood[1].release_lis_pendens_4yr;
		self.Report.NeighborhoodStats.ReleaseLisPendens5Year	:= l.Neighborhood[1].release_lis_pendens_5yr;
		self.Report.NeighborhoodStats.LiensRecentUnreleased		:= l.Neighborhood[1].liens_recent_unreleased_count;
		self.Report.NeighborhoodStats.LiensHistoricalUnreleased	:= l.Neighborhood[1].liens_historical_unreleased_count;
		self.Report.NeighborhoodStats.LiensRecentReleased				:= l.Neighborhood[1].liens_recent_released_count;
		self.Report.NeighborhoodStats.LiensHistoricalReleased		:= l.Neighborhood[1].liens_historical_released_count;
		self.Report.NeighborhoodStats.EvictionRecentUnreleased	:= l.Neighborhood[1].eviction_recent_unreleased_count;
		self.Report.NeighborhoodStats.EvictionHistoricalUnreleased	:= l.Neighborhood[1].eviction_historical_unreleased_count;
		self.Report.NeighborhoodStats.EvictionRecentReleased				:= l.Neighborhood[1].eviction_recent_released_count;
		self.Report.NeighborhoodStats.EvictionHistoricalReleased		:= l.Neighborhood[1].eviction_historical_released_count;
		self.Report.NeighborhoodStats.OccupantOwned				:= l.Neighborhood[1].occupant_owned_count;
		self.Report.NeighborhoodStats.BuildingAgeRecords	:= l.Neighborhood[1].cnt_building_age;
		self.Report.NeighborhoodStats.AverageBuildingAge	:= l.Neighborhood[1].ave_building_age;
		self.Report.NeighborhoodStats.PurchaseAmountRecords	:= l.Neighborhood[1].cnt_purchase_amount;
		self.Report.NeighborhoodStats.AveragePurchaseAmount	:= l.Neighborhood[1].ave_purchase_amount;
		self.Report.NeighborhoodStats.MortgageAmountRecords	:= l.Neighborhood[1].cnt_mortgage_amount;
		self.Report.NeighborhoodStats.AverageMortgageAmount	:= l.Neighborhood[1].ave_mortgage_amount;
		self.Report.NeighborhoodStats.AssessedAmountRecords	:= l.Neighborhood[1].cnt_assessed_amount;
		self.Report.NeighborhoodStats.AverageAssessedAmount	:= l.Neighborhood[1].ave_assessed_amount;
		self.Report.NeighborhoodStats.BuildingAreaRecords	:= l.Neighborhood[1].cnt_building_area;
		self.Report.NeighborhoodStats.AverageBuildingArea	:= l.Neighborhood[1].ave_building_area;
		self.Report.NeighborhoodStats.PricePerSquareFootRecords	:= l.Neighborhood[1].cnt_price_per_sf;
		self.Report.NeighborhoodStats.AveragePricePerSquareFoot	:= l.Neighborhood[1].ave_price_per_sf;
		self.Report.NeighborhoodStats.NumberOfBuildingsRecords	:= l.Neighborhood[1].cnt_no_of_buildings_count;
		self.Report.NeighborhoodStats.AverageNumberOfBuildings	:= l.Neighborhood[1].ave_no_of_buildings_count;
		self.Report.NeighborhoodStats.NumberOfStoriesRecords	:= l.Neighborhood[1].cnt_no_of_stories_count;
		self.Report.NeighborhoodStats.AverageNumberOfStories	:= l.Neighborhood[1].ave_no_of_stories_count;
		self.Report.NeighborhoodStats.NumberOfRoomsRecords	:= l.Neighborhood[1].cnt_no_of_rooms_count;
		self.Report.NeighborhoodStats.AverageNumberOfRooms	:= l.Neighborhood[1].ave_no_of_rooms_count;
		self.Report.NeighborhoodStats.NumberOfBedroomsRecords	:= l.Neighborhood[1].cnt_no_of_bedrooms_count;
		self.Report.NeighborhoodStats.AverageNumberOfBedrooms	:= l.Neighborhood[1].ave_no_of_bedrooms_count;
		self.Report.NeighborhoodStats.NumberOfBathsRecords	:= l.Neighborhood[1].cnt_no_of_baths_count;
		self.Report.NeighborhoodStats.AverageNumberOfBaths	:= l.Neighborhood[1].ave_no_of_baths_count;
		self.Report.NeighborhoodStats.NumberOfPartiaBathsRecords	:= l.Neighborhood[1].cnt_no_of_partial_baths_count;
		self.Report.NeighborhoodStats.AverageNumberOfPartialBaths	:= l.Neighborhood[1].ave_no_of_partial_baths_count;
		self.Report.NeighborhoodStats.TotalProperty	:= l.Neighborhood[1].total_property_count;
		self.Report.NeighborhoodStats.BankruptcyCount	:= l.Neighborhood[1].bk_cnt;
		self.Report.NeighborhoodStats.Bankruptcy1yr	:= l.Neighborhood[1].bk_1yr;
		self.Report.NeighborhoodStats.Bankruptcy2yr	:= l.Neighborhood[1].bk_2yr;
		self.Report.NeighborhoodStats.Bankruptcy3yr	:= l.Neighborhood[1].bk_3yr;
		self.Report.NeighborhoodStats.Bankruptcy4yr	:= l.Neighborhood[1].bk_4yr;
		self.Report.NeighborhoodStats.Bankruptcy5yr	:= l.Neighborhood[1].bk_5yr;
		self.Report.NeighborhoodStats.BankruptcyCh7	:= l.Neighborhood[1].bk_ch7_cnt;
		self.Report.NeighborhoodStats.BankruptcyCh11	:= l.Neighborhood[1].bk_ch11_cnt;
		self.Report.NeighborhoodStats.BankruptcyCh12	:= l.Neighborhood[1].bk_ch12_cnt;
		self.Report.NeighborhoodStats.BankruptcyCh13	:= l.Neighborhood[1].bk_ch13_cnt;
		self.Report.NeighborhoodStats.BankruptcyDischarged	:= l.Neighborhood[1].bk_discharged_cnt;
		self.Report.NeighborhoodStats.BankruptcyDismissed	:= l.Neighborhood[1].bk_dismissed_cnt;
		self.Report.NeighborhoodStats.BankruptcySelfRepresenting	:= l.Neighborhood[1].bk_pro_se_cnt;
		self.Report.NeighborhoodStats.BankruptcyBusinessFlag	:= l.Neighborhood[1].bk_business_flag_cnt;
		self.Report.NeighborhoodStats.BankruptcyCorpFlag	:= l.Neighborhood[1].bk_corp_flag_cnt;
		
		//Datasets
		self.Report.SexOffenders := project(l.SexOffenders, toSO_ESDL(left));
		self.Report.PublicSafetyFacilities := project(l.PublicSafety, toPS_ESDL(left));
		self.Report.CorrectionalFacilities := project(l.Correctional, toCF_ESDL(left));

		self := l;
		self := [];
	end;	
	final_report_iesp := project(final_data, toESDL(left));

///////////////
//FINAL RESULTS

Return final_report_iesp;

END;
