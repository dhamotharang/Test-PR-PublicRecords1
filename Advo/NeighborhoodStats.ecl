import address, risk_indicators;

//Data Declarations
// ADVO_BASE_PRE := advo.key_addr1;  // for building in dataland only
ADVO_BASE_PRE := project(Files().Base.built(active_flag = 'Y'), transform(Layouts.Layout_Common_Out_k, self := left));

//Layouts
layout_geolink := record
	string12 geolink;
end;
layout_ADVO := record
	unsigned2 Neighborhood_Vacant_Properties;
	unsigned2	Neighborhood_Business_Count;
	unsigned2 Neighborhood_SFD_Count;
	unsigned2 Neighborhood_MFD_Count;
	unsigned2	Neighborhood_CollegeAddr_Count;
	unsigned2	Neighborhood_SeasonalAddr_Count;
	unsigned4	Neighborhood_Property_Count;
End;
layout_ADVO_geolink := record
	layout_geolink;
	layout_ADVO;
End;

//Append ADVO Neighborhood Data
layout_ADVO_Geolink addNeighborhoodAdvo(ADVO_BASE_PRE l) := TRANSFORM
			// street_add := l.prim_range + ' ' + l.predir + ' ' + l.prim_name + ' ' + l.addr_suffix + ' ' +  l.postdir + ' ' + l.sec_range;
			street_add := address.Addr1FromComponents(l.prim_range,l.predir,l.prim_name,l.addr_suffix,l.postdir,'',l.sec_range);
			clean_address := Risk_Indicators.MOD_AddressClean.clean_addr(street_add, l.city_name, l.st, l.zip);
			//build geolink for AddrRisk
			self.geolink := clean_address[115..116]+clean_address[143..145]+clean_address[171..177];
			
			self.Neighborhood_Vacant_Properties := if(l.address_vacancy_indicator ='Y', 1,0);
			self.Neighborhood_Business_Count := if(l.Address_Type ='0', 1,0);
			self.Neighborhood_SFD_Count := if(l.Address_Type ='1', 1,0);
			self.Neighborhood_MFD_Count := if(l.Address_Type ='2', 1,0);
			self.Neighborhood_CollegeAddr_Count := if(l.College_Indicator ='Y', 1,0);
			self.Neighborhood_SeasonalAddr_Count := if(l.Seasonal_Delivery_Indicator ='Y', 1,0);
			self.Neighborhood_Property_Count := 1;
end;

Neighborhood_ADVO_init := project(ADVO_BASE_PRE, addNeighborhoodAdvo(left));
Neighborhood_ADVO_dist := distribute(Neighborhood_ADVO_init, hash32(geolink));
layout_ADVO_geolink rollADVO( layout_ADVO_geolink l, layout_ADVO_geolink r ) := TRANSFORM
			self.Neighborhood_Vacant_Properties := l.Neighborhood_Vacant_Properties + r.Neighborhood_Vacant_Properties;
			self.Neighborhood_Business_Count := l.Neighborhood_Business_Count + r.Neighborhood_Business_Count;
			self.Neighborhood_SFD_Count := l.Neighborhood_SFD_Count + r.Neighborhood_SFD_Count;
			self.Neighborhood_MFD_Count := l.Neighborhood_MFD_Count + r.Neighborhood_MFD_Count;
			self.Neighborhood_CollegeAddr_Count := l.Neighborhood_CollegeAddr_Count + r.Neighborhood_CollegeAddr_Count;
			self.Neighborhood_SeasonalAddr_Count := l.Neighborhood_SeasonalAddr_Count + r.Neighborhood_SeasonalAddr_Count;
			self.Neighborhood_Property_Count := l.Neighborhood_Property_Count + r.Neighborhood_Property_Count;
			self := l;
		END;
		
Neighborhood_ADVO := rollup(sort(Neighborhood_ADVO_dist, geolink, local), rollADVO(left,right), geolink, local) : persist('temp::advo_neighborhood_stats');	

export NeighborhoodStats := Neighborhood_ADVO;