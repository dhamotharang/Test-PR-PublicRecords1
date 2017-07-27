/*--SOAP--
<message name="SerialOffenderFinder">
	<!-- Search Criteria -->
  <part name="Date1" type="xsd:unsignedInt"/>
  <part name="Address1" type="xsd:string" required="1"/>
  <part name="City1" type="xsd:string" required="1"/>
  <part name="State1" type="xsd:string" required="1"/>
  <part name="Zip1" type="xsd:string" required="1"/>
  <part name="Zip1LowYYYYMM" type="xsd:unsignedInt"/>
  <part name="Zip1HighYYYYMM" type="xsd:unsignedInt"/>
  <part name="Date2" type="xsd:unsignedInt"/>
  <part name="Address2" type="xsd:string"/>
  <part name="City2" type="xsd:string" required="1"/>
  <part name="State2" type="xsd:string" required="1"/>
  <part name="Zip2" type="xsd:string"/>
  <part name="Zip2LowYYYYMM" type="xsd:unsignedInt"/>
  <part name="Zip2HighYYYYMM" type="xsd:unsignedInt"/>
  <part name="Date3" type="xsd:unsignedInt"/>
  <part name="Address3" type="xsd:string"/>
  <part name="City3" type="xsd:string" required="1"/>
  <part name="State3" type="xsd:string" required="1"/>
  <part name="Zip3" type="xsd:string"/>
  <part name="Zip3LowYYYYMM" type="xsd:unsignedInt"/>
  <part name="Zip3HighYYYYMM" type="xsd:unsignedInt"/>
  <part name="AgeLow" type="xsd:byte"/>
  <part name="AgeHigh" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
  <part name="Radius" type="xsd:unsignedInt"/>
  <part name="Gender" type="xsd:string"/>
</message>
*/

EXPORT SerialOffenderFinder := MACRO
  IMPORT address, WeCares;
  string InDemoMode := '' : STORED('demomode');
  integer DemoMode := MAP(InDemoMode='1'=>1,0);
  
  string Address1 := '' : stored('Address1');
  string City1    := '' : stored('City1');
  string2 State1  := '' : stored('State1');
  string5 Zip1    := '' : stored('Zip1');
  string8 Date1   := '' : stored('Date1');
  string Address2 := '' : stored('Address2');
  string City2    := '' : stored('City2');
  string2 State2  := '' : stored('State2');
  string5 Zip2    := '' : stored('Zip2');
  string8 Date2   := '' : stored('Date2');
  string Address3 := '' : stored('Address3');
  string City3    := '' : stored('City3');
  string2 State3  := '' : stored('State3');
  string5 Zip3    := '' : stored('Zip3');
  string8 Date3   := '' : stored('Date3');
  dAddresses := dataset([{1, Address1, City1, State1, Zip1, Date1}, {2, Address2, City2, State2, Zip2, Date2}, {3, Address3, City3, State3, Zip3, Date3}], {integer addressSeq, string address, string city, string state, string zip, string date})(zip <> '');
  rWithLatLong := RECORD
    RECORDOF(dAddresses);
    STRING CleanedLatitude;
    STRING CleanedLongitude;
  END;
  rWithLatLong transLatLong(dAddresses L) := TRANSFORM
      addr1					        := L.Address;
			addr2 					      := Address.Addr2FromComponents(L.City, L.State, L.Zip);
			clean_addr 		        := address.GetCleanAddress(addr1,addr2,address.Components.country.US);
			addr_ca							  := clean_addr.results;
			self.CleanedLatitude  := addr_ca.latitude;
			self.CleanedLongitude := addr_ca.longitude;
      SELF := L;
   END;
  dAddressesWithLatLong := PROJECT(dAddresses, transLatLong(LEFT));
  GeoDistanceThreshold := 10 : STORED('GeoDistanceThreshold');
  TimeDistanceThreshold := 36 : STORED('TimeDistanceThreshold');
  
  Months(string YearMonth) := FUNCTION
    return (integer)YearMonth[1..4] * 12 + (integer)YearMonth[5..6];
  END;
  TimeDiff(string YearMonth1, string YearMonth2) := FUNCTION
    return Months(YearMonth2) - Months(YearMonth1);
  END;
      
  dSoapcallOut := WeCares.SoapcallTroyService();
  dWithLatLong := JOIN(dSoapcallOut, AID_Build.Key_AID_Base, 
    LEFT.rawaid=RIGHT.rawaid, 
    TRANSFORM({RECORDOF(LEFT), RIGHT.geo_lat, RIGHT.geo_long, STRING address}, 
      SELF.address := MAP(DemoMode = 0 =>TRIM(RIGHT.prim_range),'') + ' ' + TRIM(RIGHT.prim_name) + TRIM(' ' + TRIM(MAP(DemoMode=0=>RIGHT.unit_desig,''))) + TRIM(' ' + TRIM(MAP(DemoMode=0=>RIGHT.sec_range,''))) + ', ' + TRIM(RIGHT.v_city_name) + ', ' + TRIM(RIGHT.zip5) + ', ' + TRIM(RIGHT.st),
      SELF := LEFT, 
      SELF := RIGHT), 
    KEYED, HASH);
  output(dWithLatLong, named('TroySearch'));

  AddressDistancesPrep := DEDUP(SORT(JOIN(dWithLatLong, dAddressesWithLatLong, true, 
    TRANSFORM({recordof(LEFT),  integer location_seq, string CrimeLocation, string8 location_date, integer Location_TimeDiff, decimal7_2 Location_GeoDistance},
      SELF.location_seq := RIGHT.addressSeq,															
      SELF.location_date := RIGHT.date,
      SELF.Location_TimeDiff := TimeDiff((string)LEFT.first_seen, RIGHT.date),
      SELF.Location_GeoDistance := ut.ll_dist((REAL)RIGHT.CleanedLatitude, (REAL)RIGHT.CleanedLongitude, (REAL)LEFT.geo_lat, (REAL)LEFT.geo_long),
      SELF.CrimeLocation := (STRING)RIGHT.CleanedLatitude + ',' + (STRING)RIGHT.CleanedLongitude,
      SELF := LEFT, 
      ), all, HASH), 
    did, geo_lat, geo_long, location_seq), 
    did, geo_lat, geo_long, location_seq);
                              
  PersonAddressDistancesDetail := TABLE(AddressDistancesPrep(Location_TimeDiff <= TimeDistanceThreshold and Location_TimeDiff > -6 and Location_GeoDistance <= GeoDistanceThreshold ), 
                               {did, name, location_seq, string8 location_date := location_date, 
															  tie_count := count(group),
																min_dist := min(group, Location_GeoDistance),
                                crim_records, score, dob
															 },
															  did, location_seq, location_date, few, merge);
 						
  PersonAddressDistancesAnalysis := TABLE(PersonAddressDistancesDetail, {did, name, dob, close_count := count(group, min_dist <= GeoDistanceThreshold), crim_records, score, integer final_score := score*count(group, min_dist <= GeoDistanceThreshold)}, did);

  output(sort(PersonAddressDistancesAnalysis, -final_score), all, named('BestFit'));
  
  rDetail :=
  record
    AddressDistancesPrep.did;
    AddressDistancesPrep.name;
    AddressDistancesPrep.rawaid;
    AddressDistancesPrep.address;
    AddressDistancesPrep.first_seen;
    AddressDistancesPrep.last_seen;
    AddressDistancesPrep.dob;
    AddressDistancesPrep.geo_lat;
    AddressDistancesPrep.geo_long;
		string LocationGeoLatLong_1;
		integer LocationDate_1;
		integer LocationTimeDiff_1;
		integer LocationGeodistance_1;
		string LocationGeoLatLong_2;
		integer LocationDate_2;
		integer LocationTimeDiff_2;
		integer LocationGeodistance_2;
		string LocationGeoLatLong_3;
		integer LocationDate_3;
		integer LocationTimeDiff_3;
		integer LocationGeodistance_3;
  end;
  NormParentPrep := PROJECT(DEDUP(SORT(AddressDistancesPrep, rawaid), rawaid), TRANSFORM(rDetail, self := LEFT, self := []));
  rDetail DenormDetail(NormParentPrep L, AddressDistancesPrep R) := TRANSFORM
      self.LocationGeoLatLong_1 := IF (R.location_seq=1, R.CrimeLocation, L.LocationGeoLatLong_1);
      self.LocationDate_1 := IF (R.location_seq=1, (integer)R.location_date, L.LocationDate_1);
      self.LocationTimeDiff_1 := IF (R.location_seq=1, R.Location_TimeDiff, L.LocationTimeDiff_1);
      self.LocationGeodistance_1 := IF (R.location_seq=1, R.location_geodistance, L.LocationGeodistance_1);

      self.LocationGeoLatLong_2 := IF (R.location_seq=2, R.CrimeLocation, L.LocationGeoLatLong_2);
      self.LocationDate_2 := IF (R.location_seq=2, (integer)R.location_date, L.LocationDate_2);
      self.LocationTimeDiff_2 := IF (R.location_seq=2, R.Location_TimeDiff, L.LocationTimeDiff_2);
      self.LocationGeodistance_2 := IF (R.location_seq=2, R.location_geodistance, L.LocationGeodistance_2);

      self.LocationGeoLatLong_3 := IF (R.location_seq=3, R.CrimeLocation, L.LocationGeoLatLong_3);
      self.LocationDate_3 := IF (R.location_seq=3, (integer)R.location_date, L.LocationDate_3);
      self.LocationTimeDiff_3 := IF (R.location_seq=3, R.Location_TimeDiff, L.LocationTimeDiff_3);
      self.LocationGeodistance_3 := IF (R.location_seq=3, R.location_geodistance, L.LocationGeodistance_3);

      SELF := L;
  END;
              
  dsDetail := JOIN(DENORMALIZE(NormParentPrep, AddressDistancesPrep,
                              LEFT.did = RIGHT.did and LEFT.rawaid = RIGHT.rawaid,
                              DenormDetail(LEFT,RIGHT)), PersonAddressDistancesAnalysis(close_count > 1), LEFT.did=RIGHT.did, HASH);
                              
  output(choosen(sort(dsDetail, did, first_seen), all), named('Detail'));

ENDMACRO;