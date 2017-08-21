IMPORT UPS_Services, doxie;

/*--SOAP--
<message name="SearchService">
  <part name="did" type="xsd:string"/>
  <separator/>
  <part name="inLastName" type="xsd:string"/> 
  <part name="inFirstName" type="xsd:string"/> 
  <part name="inMiddleName" type="xsd:string"/> 
  <separator/>
	<part name="inStreetAddr" type="xsd:string"/>
	<part name="inCity" type="xsd:string"/>
	<part name="inState" type="xsd:string"/>
	<part name="inZip" type="xsd:string"/>
  <separator/>
  <part name="inPhone" type="xsd:string"/> 
</message>
*/

export PersonSearch() := MACRO
	// did will be picked up by globalmodule automatically if set
	
	STRING fname := '' : STORED('inFirstName');
	STRING mname := '' : STORED('inMiddleName');
	STRING lname := '' : STORED('inLastName');
	STRING street := '' : STORED('inStreetAddr');
	STRING city := '' : STORED('inCity');
	STRING state := '' : STORED('inState');
	STRING zip := '' : STORED('inZip');
	STRING phone := '' : STORED('inPhone');
															
searchby :=dataset([{
			'', /* unparsed full name, NOT SUPPORTED */
			fname, /* firstname */
			mname, /* middlename */
			'', /* lastname*/
			'', /* NOT USED */
			'', /* NOT USED */
			'', /* companyname */
			lname, /* LastNameOrCompany */
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
			UPS_Services.Constants.TAG_ENTITY_IND, // EntityType, UNK, BIZ, or IND
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

  recs := UPS_Services.RightAddress(request).PersonSearch.records;
	sorted_recs := SORT(recs, rollup_key, dt_first_seen, dt_last_seen);

	output(request, named('request'));
  output(sorted_recs, named(doxie.strResultsName));
ENDMACRO;