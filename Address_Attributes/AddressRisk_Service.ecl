/*--SOAP--
<message name="SearchService">
	<!-- XML INPUT -->
	<part name="AddrRiskSearchRequest" 		type="tns:XmlDataSet" cols="80" rows="30" />
	</message>
*/

/*--HELP--
AddressNeighborhood Request XML:
<pre>
&lt;Dataset&gt;
&lt;Row&gt;
	 &lt;options&gt;
			&lt;ReturnCount&gt;&lt;/ReturnCount&gt;
			&lt;ReturnType&gt;&lt;/ReturnType&gt;
			&lt;SurroundingPropertyCount&gt;&lt;/SurroundingPropertyCount&gt;
			&lt;GeoRadiusMiles&gt;&lt;/GeoRadiusMiles&gt;
	 &lt;/options&gt;
   &lt;searchby&gt;
			&lt;Geolink&gt;&lt;/Geolink&gt;
			&lt;GeoLocation&gt;
				&lt;Latitude&gt;&lt;/Latitude&gt; 
				&lt;Longitude&gt;&lt;/Longitude&gt;
			&lt;/GeoLocation&gt;
      &lt;address&gt;
	      &lt;streetaddress1&gt;&lt;/streetaddress1&gt;
	      &lt;streetaddress2&gt;&lt;/streetaddress2&gt;
	      &lt;city&gt;&lt;/city&gt;
	      &lt;state&gt;&lt;/state&gt;
	      &lt;zip5&gt;&lt;/zip5&gt;
	      &lt;zip4&gt;&lt;/zip4&gt;
      &lt;/address&gt;
   &lt;/searchby&gt;
&lt;/Row&gt;
&lt;/Dataset&gt;
</pre>
*/

import address_attributes, addrfraud, easi, iesp, risk_indicators;

export AddressRisk_Service := macro
//Report Type 0 = Full Data Return
//Report Type 1 = Address Risk Score Only
//Report Type 2 = Sex Offenders
//Report Type 3 = Public Safety
//Report Type 4 = Address Risk With Details
	
//Data Sources
		File_Census				:= Easi.Key_Easi_Census;
		File_Address_Risk	:= AddrFraud.Key_AddrFraud_GeoLink;
		
// Get XML input 
	ds_in_pre := DATASET ([], iesp.addressrisksearch.t_AddrRiskSearchRequest) : STORED ('AddrRiskSearchRequest', FEW);
	ds_in := ds_in_pre[1];
	
	string	in_geolink		:= ds_in.SearchBy.geolink;
	real4 	in_lat        := (real4)ds_in.SearchBy.GeoLocation.Latitude;
	real4 	in_lon        := (real4)ds_in.SearchBy.GeoLocation.Longitude;
	string 	in_addr       := ds_in.SearchBy.address.streetaddress1;
	string	in_sec_range	:= ds_in.SearchBy.address.streetaddress2;                       
	string in_city        := ds_in.SearchBy.address.City;
	string in_state       := ds_in.SearchBy.address.State;
	string in_zip         := ds_in.SearchBy.address.Zip5;

	integer report_type		:= if(ds_in.Options.ReturnType not in [0,1,2,3,4], 1, ds_in.Options.ReturnType);
	integer in_Results    := if(ds_in.Options.ReturnCount = 0 or ds_in.Options.ReturnCount > 30, 30, ds_in.Options.ReturnCount);
	real4 threshold_miles := if(ds_in.Options.GeoRadiusMiles = 0 or ds_in.Options.GeoRadiusMiles > 10, 10, ds_in.Options.GeoRadiusMiles);
	

		//Get Geolink by address
			cleaned 		:= Risk_Indicators.MOD_AddressClean.clean_addr(in_addr, in_city, in_state, in_zip, in_sec_range);
			st          := cleaned[115..116];
			county      := cleaned[143..145];
			geo_blk     := cleaned[171..177];
			geolink_a 	:= st+county+geo_blk;

		//Get Geolinks by Lat and Long
			geolink_l 	:= AddrFraud.Functions.FindGeoBlocks(in_lat, in_lon, threshold_miles);

		//Get Geolink from input
			geolink_i 	:= in_geolink;

//Pick Geolink
	geolink_target := map(trim(geolink_i) <> '' => trim(geolink_i),
								 trim(geolink_l[1].geolink) <> '' => trim(geolink_l[1].geolink),
								 trim(geolink_a));

//Get Geolink Info
	geoInfo 		:= AddrFraud.Key_GeoInfo_Geolink(keyed(geolink = geolink_target))[1];
	latitude  	:= if(in_lat!=0, in_lat, (real4)geoInfo.lat);
	longitude 	:= if(in_lon!=0, in_lon, (real4)geoInfo.long);
		
// Get Geolink Risk Data
		rGeolink := record
			string12 geolink;
		end;
		geolink_out := dataset([{geolink_target}], rGeolink);

//Get Surrounding Geolinks
	Address_Attributes.Layouts.AddrRisk_Key getGeolinkRiskData(geolink_out l, File_Address_Risk r) := transform
		self.geolink := l.geolink;
		self := r;
	end;
	
	geolink_risk := join(geolink_out, File_Address_Risk,
										 keyed(left.geolink=right.geolink),
										 getGeolinkRiskData(left,right), left outer, keep(1));

		
//Get Geolink based data
		Address_Attributes.Layouts.AddressRisk_out getGeolinkData(geolink_risk l) := TRANSFORM
			self.geolink 				:= l.geolink;
			self.latitude				:= l.latitude;
			self.longitude			:= l.longitude;
			self.miles := AddrFraud.Functions.GeoDist(latitude, longitude, (real)geoinfo.lat, (real)geoinfo.long);
			self.dAddressRisks 	:= choosen(Address_Attributes.get_Data.Neighborhood_Risk(Address_Attributes.functions.getGeolinks(l.geolink, 30)), 30);
			self.dSexOffenders 	:= choosen(Address_Attributes.get_Data.Sex_Offenders(Address_Attributes.functions.getGeolinks(l.geolink, in_Results)), 100);
			self.dPublicSafety 	:= choosen(Address_Attributes.get_Data.Public_Safety(Address_Attributes.functions.getGeolinks(l.geolink, in_Results)), 100);
			self := l;
			self := [];
		end;
		
		geolink_data := project(geolink_risk, getGeolinkData(left));

//Get Address Risk data
		Address_Attributes.Layouts.AddressRisk_out addEASI(geolink_data l, File_Census r) := transform
			Poverty_Index_Raw     := ((real)r.LOWINC/100);
			Disruption_Index_Raw  := ((real)r.FAMOTF18_P/100);
			Poverty_Index := 100*(if(Poverty_Index_Raw<=0, 0, Poverty_Index_Raw));
			Disruption_Index := 100*(if(Disruption_Index_Raw<=0, 0, Disruption_Index_Raw));
			
			personsPerHouse := 2;
			Crime_Index_Raw := if(l.crimes*100000/l.occupants > 1000, 999, l.crimes*100000/l.occupants);
			Foreclosure_Index_Raw := l.foreclosures*100000/(l.occupants/personsPerHouse);
			Mobility_Index_Raw    := (l.turnover_1yr_in + l.turnover_1yr_out)/l.occupants_1yr;
			Crime_Index 	:= .5*(if(Crime_Index_Raw<=0, 0, Crime_Index_Raw));
			Foreclosure_Index := .0233*(if(Foreclosure_Index_Raw<=0, 0, Foreclosure_Index_Raw));
			Mobility_Index := 100 * abs(Mobility_Index_Raw);
			risk_SOS := if(Crime_Index + Poverty_Index + Foreclosure_Index + Disruption_Index + Mobility_Index >= 1000, 999, Crime_Index + Poverty_Index + Foreclosure_Index + Disruption_Index + Mobility_Index);
			Risk_Index := risk_SOS; 

			self.Crime_Index := Crime_Index;
			self.Poverty_Index := abs(Poverty_Index);
			self.Foreclosure_Index := Foreclosure_Index;
			self.Disruption_Index := abs(Disruption_Index);
			self.Mobility_Index := Mobility_Index;
			self.Risk_Index := Risk_Index;
			
			self := r;
			self := l;

		end;
		base_EASI := join(geolink_data, File_Census,
			left.geolink != '' and 
			keyed(left.geolink = right.geolink),
			addEASI(left, right),Left Outer, keep(1));
	
	withRiskScore := base_EASI(Miles <= threshold_miles);

//Map Results to ESDL

	//address risks
	iesp.addressrisksearch.t_AddressRiskScoreRecord toAR_ESDL(Address_Attributes.Layouts.rAddressRisks l):=transform
		self.GeoLink 											:= l.geolink;
		self.Risk  												:= (string)l.Risk_Index;
		self.Latitude											:= (string)l.latitude;
		self.Longitude										:= (string)l.longitude;
		self :=[];
	end;
	//sex offenders
	iesp.addressrisksearch.t_SexOffenderRecord toSO_ESDL(Address_Attributes.Layouts.rSexOffenders l):=transform
		self.UniqueId											:=l.offender_id;
		self.Name.First										:=l.lname;
		self.Name.Middle									:=l.fname;
		self.Name.Last										:=l.mname;
		self.DOB.Year											:=l.DOB[1..4];
		self.DOB.Month										:=l.DOB[5..6];
		self.DOB.Day											:=l.DOB[7..8];
		self.Address.StreetNumber					:=l.prim_range;
		self.Address.StreetPreDirection		:=l.predir;
		self.Address.StreetName						:=l.prim_name;
		self.Address.StreetSuffix					:=l.addr_suffix;
		self.Address.StreetPostDirection	:=l.postdir;
		self.Address.UnitDesignation			:=l.unit_desig;
		self.Address.UnitNumber						:=l.sec_range;
		self.Address.City									:=l.p_city_name;
		self.Address.State								:=l.st;
		self.Address.Zip5									:=l.zip5;
		self.Address.Zip4									:=l.zip4;
		self.Latitude											:=l.geo_lat;
		self.Longitude										:=l.geo_long;
		self :=[];
	end;
	
	
	//public safety
	iesp.addressrisksearch.t_PublicSafetyRecord toPS_ESDL(Address_Attributes.Layouts.rPublicSafety l):=transform
		self.BDID													:= l.BDID;
		self.CompanyName									:= l.Name;
		self.Phone10											:= l.Phone10;
		self.Address.StreetNumber					:= l.prim_range;
		self.Address.StreetPreDirection		:= l.predir;
		self.Address.StreetName						:= l.prim_name;
		self.Address.StreetSuffix					:= l.addr_suffix;
		self.Address.StreetPostDirection	:= l.postdir;
		self.Address.UnitDesignation			:= l.unit_desig;
		self.Address.UnitNumber						:= l.sec_range;
		self.Address.City									:= l.p_city_name;
		self.Address.State								:= l.st;
		self.Address.Zip5									:= l.zip;
		self.Address.Zip4									:= l.zip4;
		self.Latitude											:= l.geo_lat;
		self.Longitude										:= l.geo_long;
		self :=[];
	end;
	
	//main payload
	iesp.addressrisksearch.t_AddrRiskSearchRecord toESDL(withRiskScore l) := TRANSFORM
			self.GeoLink 								:= l.GeoLink;
			self.GeoLocation.Latitude 	:= (string)l.Latitude;
			self.GeoLocation.Longitude 	:= (string)l.Longitude;
			
			self.Occupants.Current 		:= if(report_type in [0,4],(string)l.occupants,'');
			self.Occupants.Last 			:= if(report_type in [0,4],(string)l.occupants_1yr,'');
			self.Occupants.Two 				:= if(report_type in [0,4],(string)l.occupants_2yr,'');
			self.Occupants.Three 			:= if(report_type in [0,4],(string)l.occupants_3yr,'');
			self.Occupants.Four 			:= if(report_type in [0,4],(string)l.occupants_4yr,'');
			self.Occupants.Five 			:= if(report_type in [0,4],(string)l.occupants_5yr,'');
			
			self.PeopleMovedIn.Current := '';
			self.PeopleMovedIn.Last 	:= if(report_type in [0,4],(string)l.turnover_1yr_in,'');
			self.PeopleMovedIn.Two 		:= if(report_type in [0,4],(string)l.turnover_2yr_in,'');
			self.PeopleMovedIn.Three 	:= if(report_type in [0,4],(string)l.turnover_3yr_in,'');
			self.PeopleMovedIn.Four 	:= if(report_type in [0,4],(string)l.turnover_4yr_in,'');
			self.PeopleMovedIn.Five 	:= if(report_type in [0,4],(string)l.turnover_5yr_in,'');
			
			self.PeopleMovedOut.Current := '';
			self.PeopleMovedOut.Last 	:= if(report_type in [0,4],(string)l.turnover_1yr_out,'');
			self.PeopleMovedOut.Two 	:= if(report_type in [0,4],(string)l.turnover_2yr_out,'');
			self.PeopleMovedOut.Three := if(report_type in [0,4],(string)l.turnover_3yr_out,'');
			self.PeopleMovedOut.Four 	:= if(report_type in [0,4],(string)l.turnover_4yr_out,'');
			self.PeopleMovedOut.Five 	:= if(report_type in [0,4],(string)l.turnover_5yr_out,'');
			
			self.Crimes.Current 			:= if(report_type in [0,4],(string)l.crimes,'');
			self.Crimes.Last 					:= if(report_type in [0,4],(string)l.crimes_1yr,'');
			self.Crimes.Two 					:= if(report_type in [0,4],(string)l.crimes_2yr,'');
			self.Crimes.Three 				:= if(report_type in [0,4],(string)l.crimes_3yr,'');
			self.Crimes.Four 					:= if(report_type in [0,4],(string)l.crimes_4yr,'');
			self.Crimes.Five 					:= if(report_type in [0,4],(string)l.crimes_5yr,'');
			
			self.Foreclosures.Current := if(report_type in [0,4],(string)l.foreclosures,'');
			self.Foreclosures.Last 		:= if(report_type in [0,4],(string)l.foreclosures_1yr,'');
			self.Foreclosures.Two 		:= if(report_type in [0,4],(string)l.foreclosures_2yr,'');
			self.Foreclosures.Three 	:= if(report_type in [0,4],(string)l.foreclosures_3yr,'');
			self.Foreclosures.Four 		:= if(report_type in [0,4],(string)l.foreclosures_4yr,'');
			self.Foreclosures.Five 		:= if(report_type in [0,4],(string)l.foreclosures_5yr,'');
			
			self.SexOffenders.Current := if(report_type in [0,4],(string)l.sexoffenders,'');
			self.SexOffenders.Last 		:= if(report_type in [0,4],(string)l.sexoffenders_1yr,'');
			self.SexOffenders.Two 		:= if(report_type in [0,4],(string)l.sexoffenders_2yr,'');
			self.SexOffenders.Three 	:= if(report_type in [0,4],(string)l.sexoffenders_3yr,'');
			self.SexOffenders.Four 		:= if(report_type in [0,4],(string)l.sexoffenders_4yr,'');
			self.SexOffenders.Five 		:= if(report_type in [0,4],(string)l.sexoffenders_5yr,'');
			
			self.Indices.Crime 				:= if(report_type in [0,4],(string)l.Crime_Index,'');
			self.Indices.Poverty 			:= if(report_type in [0,4],(string)l.Poverty_Index,'');
			self.Indices.Foreclosure 	:= if(report_type in [0,4],(string)l.Foreclosure_Index,'');
			self.Indices.Disruption		:= if(report_type in [0,4],(string)l.Disruption_Index,'');
			self.Indices.Mobility			:= if(report_type in [0,4],(string)l.Mobility_Index,'');
			self.Indices.Risk					:= if(report_type in [0,1,4],(string)l.Risk_Index,'');
			
			self.MilesToTargetProperty := trim(realformat(l.miles, 10, 2));
			
		//Datasets
		self.AddressRiskScoreRecords := if(report_type in [0,1], project(choosen(l.dAddressRisks,iesp.Constants.NeighborSafety.MaxAddressRisk),  toAR_ESDL(left)), project(choosen(l.dAddressRisks,0), toAR_ESDL(left)));
		self.SexOffenderRecords  		 := if(report_type in [0,2], project(choosen(l.dSexOffenders,iesp.Constants.NeighborSafety.MaxSexOffender),  toSO_ESDL(left)), project(choosen(l.dSexOffenders,0), toSO_ESDL(left)));
		self.PublicSafetyRecords 		 := if(report_type in [0,3], project(choosen(l.dPublicSafety,iesp.Constants.NeighborSafety.MaxPublicSafety), toPS_ESDL(left)), project(choosen(l.dPublicSafety,0), toPS_ESDL(left)));
	end;	
	searchRecord := project(withRiskScore, toESDL(left));


//Final iESP Form Conversion
		d := dataset([{0}], {integer i});
		iesp.addressrisksearch.t_AddrRiskSearchResponse finalform(d le):=transform
			self.RecordCount := Count(searchRecord);
			self.Records := sort(searchRecord, MilesToTargetProperty);
			self := [];
		End;

		results := project(d, finalform(left));

	output(results, named('results'));

ENDMACRO;

// Address_Attributes.AddressRisk_Service();

// For testing/debugging in a web form xml text area
/*
<Dataset>
<Row>
	 <options>
			<ReturnCount></ReturnCount>
			<ReturnType>4</ReturnType>
			<SurroundingPropertyCount></SurroundingPropertyCount>
			<GeoRadiusMiles></GeoRadiusMiles>
	 </options>
   <searchby>
			<GeoLocation>
				<Latitude></Latitude> 
				<Longitude></Longitude>
			</GeoLocation>
      <address>
	      <streetaddress1>420 MONARCH CIR</streetaddress1>
	      <streetaddress2></streetaddress2>
	      <city>ROCK SPRINGS</city>
	      <state>WY</state>
	      <zip5>82901</zip5>
	      <zip4></zip4>
      </address>
   </searchby>
</Row>
</Dataset>
*/