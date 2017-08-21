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

import address_attributes, addrfraud, iesp, risk_indicators;

export AddressRisk_Service := macro

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
	integer report_type		:= if(ds_in.Options.ReturnType =0, 4, ds_in.Options.ReturnType );
	integer inResults     := if(ds_in.Options.SurroundingPropertyCount=0, 10, ds_in.Options.SurroundingPropertyCount);
	real4 threshold_miles := if(ds_in.Options.GeoRadiusMiles=0, 10, ds_in.Options.GeoRadiusMiles);
	results 							:= min(inResults, 30);


	// BY-ADDRESS:
		cleaned := Risk_Indicators.MOD_AddressClean.clean_addr(addr, city, state, zip );
		st          := cleaned[115..116];
		county      := cleaned[143..145];
		geo_blk     := cleaned[171..177];
		in_geolink  := st+county+geo_blk;


		// information on the input address' geolink
		geoInfo := AddrFraud.Key_GeoInfo_Geolink( keyed( in_geolink = geolink ) )[1];
		nearby_addr  := CHOOSEN( AddrFraud.Key_GeoLinkDistance_GeoLink( keyed(geolink1=in_geolink)), results-1 );
		
		risk_by_addr := join( nearby_addr, AddrFraud.Key_AddrFraud_GeoLink,
										keyed(left.geolink2=right.geolink),
										transform( AddrFraud.Layouts.AddrRisk_Key, self := right ))
										+
										project( AddrFraud.Key_AddrFraud_GeoLink( keyed(geolink=in_geolink) ), AddrFraud.Layouts.AddrRisk_Key );
		
		
	// BY-COORDS:
		nearby_latlon := CHOOSEN( AddrFraud.Functions.FindGeoBlocks( in_lat, in_lon, threshold_miles ), results );

		risk_by_coord := join( nearby_latlon, AddrFraud.Key_AddrFraud_GeoLink,
										 keyed(left.geolink=right.geolink),
										 transform( AddrFraud.Layouts.AddrRisk_Key, self := right ));

//Choose which geolink set and set lat/long
	geolinks := if( in_lat!=0 and in_lon!=0, risk_by_coord, risk_by_addr );
	
	latitude  := if( in_lat!=0, in_lat, (real4)geoInfo.lat );
	longitude := if( in_lon!=0, in_lon, (real4)geoInfo.long );
	
//////////////////
//RISK CALCULATION
	scored := AddrFraud.Functions.CalculateScore( geolinks );
	
	AddrFraud.Layouts.AddrRisk_Scored AddDistance( scored l, AddrFraud.Key_GeoInfo_Geolink r ) := TRANSFORM
		self.miles := AddrFraud.Functions.GeoDist( latitude, longitude, (real4)r.lat, (real4)r.long );
		self := l;
	END;
	
	withDist := choosen(join( scored, AddrFraud.Key_GeoInfo_Geolink,
						 keyed(left.geolink=right.geolink),
						 AddDistance(LEFT,RIGHT), LEFT OUTER, KEEP(1)), results);
	
	withRiskScore := withDist(Miles <= threshold_miles);

/////////////////////////
//SEX OFFENDER COLLECTION
	Address_Attributes.Layouts.AR_SexOffender getSexOffenders(geolinks l, Address_Attributes.key_sexoffender_geolink r):= transform
		self.did := (string)r.did;
		self := r;
	end;
	
	withSexOffenderFull := join(geolinks, Address_Attributes.key_sexoffender_geolink,
										 left.geolink = right.geolink,
										 getSexOffenders(left, right),keep(30));

	withSexOffender := choosen(dedup(sort(withSexOffenderfull, did) ,did) ,results);
	
//////////////////////////
//PUBLIC SAFETY COLLECTION
	Address_Attributes.Layouts.AR_PublicSafety getFD(geolinks l, Address_Attributes.key_firedepartment_geolink r):= transform
		self.bdid := '';
		self.name := r.Fire_Dept_Name;
		self.addr_suffix := r.suffix;
		self.phone10 := r.HQ_Phone;
		self := r;
	end;
	
	withPublicSafetyFull := choosen(join(geolinks, Address_Attributes.key_firedepartment_geolink,
										 left.geolink = right.geolink,
										 getFD(left, right),keep(30)),30);

	withPublicSafety := choosen(dedup(sort(withPublicSafetyFull, name) ,name) ,results);
	
///////////////
//FINAL RESULTS
	final_results	:= MAP(
									report_type = 4 => AddrFraud.Functions.formatAR_IESP_out_4(withRiskScore),    //Risk Score with details
									report_type = 3 => AddrFraud.Functions.formatAR_IESP_out_3(withPublicSafety), //Public Safety 
									report_type = 2 => AddrFraud.Functions.formatAR_IESP_out_2(withSexOffender),  //Sex Offenders
									report_type = 1 => AddrFraud.Functions.formatAR_IESP_out_1(withRiskScore)     //Risk Score
									);					


	output(final_results,named('results'));

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