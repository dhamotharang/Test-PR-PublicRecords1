IMPORT UPS_Services, iesp;

/*--SOAP--
<message name="SearchService">
  <part name="inBDID" type="xsd:string"/>
  <separator/>
  <part name="inCompanyName" type="xsd:string"/> 
  <separator/>
	<part name="inStreetAddr" type="xsd:string"/>
	<part name="inCity" type="xsd:string"/>
	<part name="inState" type="xsd:string"/>
	<part name="inZip" type="xsd:string"/>
  <separator/>
  <part name="inPhone" type="xsd:string"/> 
</message>
*/

export BusinessSearch := MACRO

	// bdid will be picked up by globalmodule automatically if set	
	STRING cname := '' : STORED('inCompanyName');
	STRING street := '' : STORED('inStreetAddr');
	STRING city := '' : STORED('inCity');
	STRING state := '' : STORED('inState');
	STRING zip := '' : STORED('inZip');
	STRING phone := '' : STORED('inPhone');

	searchby :=dataset([{
			'', /* unparsed full name, NOT SUPPORTED */
			'', /* firstname */
			'', /* middlename */
			'', /* lastname*/
			'', /* NOT USED */
			'', /* NOT USED */
			'', /* companyname */
			cname, /* LastNameOrCompany */
			'', /* prim_name, NOT SUPPORTED */
			'', /* prim_range, NOT SUPPORTED */
			'', /* NOT USED */
			'', /* NOT USED */'', 
			'', /* NOT USED */
			'', /* sec_range, NOT SUPPORTED */
			street, /* streetaddress1 (=> addr) */
			'', /* streetaddress2 (=> addr) */
			state, /* state */
			city, /* city */
			zip, /* zip */
			'', /* NOT USED */
			'', /* NOT USED*/
			'', /* NOT USED */
			'', /* statecityzip, NOT SUPPORTED */
			phone, // Phone10
			UPS_Services.Constants.TAG_ENTITY_BIZ, // EntityType, UNK, BIZ, or IND
			0,     // ZipRadius
			'' }], // UniqueID
			{ iesp.share.t_NameAndCompany Name,
				STRING120 LastNameOrCompany,
				iesp.share.t_Address Address,
				STRING10 Phone10,
				STRING10 EntityType,
				INTEGER  Radius,
				STRING12 UniqueID });

	iesp.rightaddress.t_RightAddressSearchRequest SearchRequestTransform(searchby L) := TRANSFORM	
		SELF.Options := UPS_Testing.DefaultOptions;
		SELF.User := UPS_Testing.DefaultUser;
		SELF.RemoteLocations := [];
		SELF.ServiceLocations := [];

		SELF.SearchBy := L;
	END;

	request := project(searchby, SearchRequestTransform(LEFT));

  recs := UPS_Services.RightAddress(request).BusinessSearch.records;
	sorted_recs := SORT(recs, rollup_key, dt_first_seen, dt_last_seen);

	output(request, named('Request'));
  output(sorted_recs, named(doxie.strResultsName));
ENDMACRO;

