/*--SOAP--
<message name="SearchService">
	<!-- XML INPUT -->
	<part name="AddrRiskSearchRequest" 		type="tns:XmlDataSet" cols="80" rows="30" />
	</message>
*/


import iesp,risk_indicators,easi;

export AddressRisk_Service := macro

//The following macro defines the field sequence on WsECL page of query.
  WSInput.MAC_AddrFraud_AddressRisk_Service();

	// Get XML input 
	ds_in_pre := DATASET ([], iesp.addressrisksearch.t_AddrRiskSearchRequest) : STORED ('AddrRiskSearchRequest', FEW);
	ds_in := ds_in_pre[1];
	
	real4 in_lat          := (real4)ds_in.SearchBy.GeoLocation.Latitude;
	real4 in_lon          := (real4)ds_in.SearchBy.GeoLocation.Longitude;
	string addr           := trim(risk_indicators.MOD_AddressClean.street_address(
	                          ds_in.SearchBy.address.streetaddress1,
	                          ds_in.SearchBy.address.StreetNumber,
	                          ds_in.SearchBy.address.StreetPreDirection,
	                          ds_in.SearchBy.address.StreetName,
	                          ds_in.SearchBy.address.StreetSuffix,
	                          ds_in.SearchBy.address.StreetPostDirection,
	                          ds_in.SearchBy.address.UnitDesignation,
	                          ds_in.SearchBy.address.UnitNumber));
	string city           := ds_in.SearchBy.address.City;
	string state          := ds_in.SearchBy.address.State;
	string zip            := ds_in.SearchBy.address.Zip5;
	integer inResults     := if(ds_in.Options.SurroundingPropertyCount=0, 10, ds_in.Options.SurroundingPropertyCount);
	real4 threshold_miles := if(ds_in.Options.GeoRadiusMiles=0, 10, ds_in.Options.GeoRadiusMiles);
	results := min(inResults, 50);




	// BY-ADDRESS:
		cleaned := Risk_Indicators.MOD_AddressClean.clean_addr(addr, city, state, zip );
		st          := cleaned[115..116];
		county      := cleaned[143..145];
		geo_blk     := cleaned[171..177];
		in_geolink  := st+county+geo_blk;

		// information on the input address' geolink
		geoInfo := AddrFraud.Key_GeoInfo_Geolink( keyed( in_geolink = geolink ) )[1];
		nearby_addr   := CHOOSEN( AddrFraud.Key_GeoLinkDistance_GeoLink( keyed(geolink1=in_geolink)), results-1 );
		risk_by_addr := join( nearby_addr, AddrFraud.Key_AddrFraud_GeoLink,
			keyed(left.geolink2=right.geolink),
			transform( AddrFraud.Layouts.AddrRisk_Key, self := right )
			)
			+ project( AddrFraud.Key_AddrFraud_GeoLink( keyed(geolink=in_geolink) ), AddrFraud.Layouts.AddrRisk_Key )
		;
	// BY-COORDS:
		nearby_latlon := CHOOSEN( AddrFraud.Functions.FindGeoBlocks( in_lat, in_lon, threshold_miles ), results );

		risk_by_coord := join( nearby_latlon, AddrFraud.Key_AddrFraud_GeoLink,
			keyed(left.geolink=right.geolink),
			transform( AddrFraud.Layouts.AddrRisk_Key, self := right )
		);
	//

	
	risk := if( in_lat!=0 and in_lon!=0, risk_by_coord, risk_by_addr );
	scored := AddrFraud.Functions.CalculateScore( risk );
	
	
	latitude  := if( in_lat!=0, in_lat, (real4)geoInfo.lat );
	longitude := if( in_lon!=0, in_lon, (real4)geoInfo.long );
	
	AddrFraud.Layouts.AddrRisk_Scored AddDistance( scored le, AddrFraud.Key_GeoInfo_Geolink ri ) := TRANSFORM
		self.miles := AddrFraud.Functions.GeoDist( latitude, longitude, (real4)ri.lat, (real4)ri.long );
		self := le;
	END;
	withDist := join( scored, AddrFraud.Key_GeoInfo_Geolink,
		keyed(left.geolink=right.geolink),
		AddDistance(LEFT,RIGHT), LEFT OUTER, KEEP(1) );
	
	withDistFiltered := withDist(Miles <= threshold_miles);
	
	output(AddrFraud.Functions.formatIESP_out(withDistFiltered),named('results'));
ENDMACRO;

// AddrFraud.AddressRisk_Service()

// For testing/debugging in a web form xml text area
/*
<AddrRiskSearchRequest>
<row>
<User>
  <ReferenceCode></ReferenceCode>
  <BillingCode></BillingCode>
  <QueryId></QueryId>
  <GLBPurpose></GLBPurpose>
  <DLPurpose></DLPurpose>
  <EndUser>
    <CompanyName></CompanyName>
    <StreetAddress1></StreetAddress1>
    <City></City>
    <State></State>
    <Zip5></Zip5>
  </EndUser>
  <MaxWaitSeconds></MaxWaitSeconds>
</User>
<Options>
	<ReturnCount></ReturnCount>
  <StartingRecord></StartingRecord> 
	<SurroundingPropertyCount></SurroundingPropertyCount>
	<GeoRadiusMiles></GeoRadiusMiles>
</Options>
<SearchBy>
	<GeoLocation>
		<Latitude></Latitude>
		<Longitude></Longitude>
	</GeoLocation>
	<Address>
		<StreetName></StreetName>
		<StreetNumber></StreetNumber>
		<StreetPreDirection></StreetPreDirection>
		<StreetPostDirection></StreetPostDirection>
		<StreetSuffix></StreetSuffix>
		<UnitDesignation></UnitDesignation>
		<UnitNumber></UnitNumber>
		<StreetAddress1></StreetAddress1>
		<StreetAddress2></StreetAddress2>
		<State></State>
		<City></City>
		<Zip5></Zip5>
		<Zip4></Zip4>
		<County></County>
		<PostalCode></PostalCode>
		<StateCityZip></StateCityZip>
	</Address>
</SearchBy>
</row>
</AddrRiskSearchRequest>
*/