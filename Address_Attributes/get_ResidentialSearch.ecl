import address_attributes, addrfraud, advo, avm_v2, easi, FBI_UCR, iesp, LN_PropertyV2, property, Risk_Indicators, ut;

export get_ResidentialSearch(DATASET(Address_Attributes.Layouts.address_in) indata) := FUNCTION

//Constants
		boolean goodTransaction := if(indata[1].street_address <> '' and  indata[1].city <> '' and  indata[1].state <> '' and  indata[1].zip <> '', true, false);		
		// goodTransIndata := indata(street_address <> '' and  city <> '' and  state <> '' and  zip <> '');
		walkabilityscore_low := 0;
		walkabilityscore_high := 100;
		
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
			self := l;
			self := [];
		end;
		
		geolink_data := project(cleaned, getGeolinkData(left));

//Get Walkability Score		
		Walkability := address_attributes.getWalkability_clean_in(cleaned);	
		
//Append Walkability To Geolink data
		Address_Attributes.Layouts.rNeigbhorhood_Report addWalkability(geolink_data l, Walkability r) := transform
			self.seq := l.seq;
			self := r;
			self := l;
		end;
		final_data := join(geolink_data, Walkability,
			left.seq = right.seq,
			addWalkability(left, right), Left Outer, keep(1));

//Map Results to ESDL
	//main payload
	iesp.residential_quality.t_ResidentialQualitySearchResponse toESDL(final_data l) := TRANSFORM
		// Header
		self._Header.Status												:= if(goodTransaction,1,0);
		self._Header.Message											:= if(goodTransaction,'', 'Results may be incomplete.  Input requirements not met.');
		//Walkability Range
		self.WalkabilityScoresRange.low := walkabilityscore_low;
		self.WalkabilityScoresRange.high := walkabilityscore_high;
		
		self.WalkabilityScore := if(l.walkability_score > 100, walkabilityscore_high, if(l.walkability_score = 0, -1, l.walkability_score));
		self := l;
		self := [];
	end;	
	final_report_iesp := project(final_data, toESDL(left));

///////////////
//FINAL RESULTS

Return final_report_iesp;

END;
