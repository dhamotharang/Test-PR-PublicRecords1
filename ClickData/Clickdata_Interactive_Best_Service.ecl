/*--SOAP--
	<message name = "ClickdataInteractiveBestService" wuTimeout="300000">
		<part name="FirstName" type="xsd:string"/>
		<part name="MiddleName" type="xsd:string"/>
		<part name="LastName" type="xsd:string"/>
		<part name="Addr" type="xsd:string"/>
		<part name="City" type="xsd:string"/>
		<part name="State" type="xsd:string"/>
		<part name="Zip" type="xsd:string"/>
		<part name="DOB" type="xsd:unsignedInt"/>
		<part name="Phone" type="xsd:string"/>
    <part name="DataRestrictionMask" type="xsd:string"/>
		<part name="DataPackageEnhancement" type="xsd:string"/>
		<part name="DirectMarketingSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
		<part name="ApplicationType"     	type="xsd:string"/>
	</message>
*/
/*--INFO--
This is the interactive version of ClickData.Clickdata_Bests_Service.
*/

/*--HELP--
Use DataPackageEnhancement to return demographics. Values: A, B, C or D.
*/
import iesp, AutoStandardI;
export Clickdata_Interactive_Best_Service := macro

		rec_in := iesp.directmarketingsearch.t_DirectMarketingSearchRequest;
    ds_in := DATASET ([], rec_in) : STORED ('DirectMarketingSearchRequest', FEW);
    first_row := ds_in[1] : independent;

		// --------------------------------------------------------------------
		// parse incoming request
		//
    iesp.ECL2ESP.SetInputBaseRequest (first_row);
    search_by := global (first_row.SearchBy);
    iesp.ECL2ESP.SetInputName (search_by.Name);
    iesp.ECL2ESP.SetInputAddress (search_by.Address);
    iesp.ECL2ESP.SetInputDate (search_by.DOB,'DOB');
    #stored('Phone', search_by.Phone);
		iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);
    search_opt := global (first_row.options);
		#stored('DataPackageEnhancement', search_opt.DataPackageEnhancement);
		string1 DataPackageEnhancement := '' : stored('DataPackageEnhancement');
    tempmod := AutoStandardI.GlobalModule();
    mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(tempmod);
		r := record string1 a, end;
		// --------------------------------------------------------------------
		// projecting request into layout expected by common function
		//
		Clickdata.Layout_ClickData_In xform (r le) := transform
			self.full_name 		:= tempmod.unparsedfullname;
			self.name_first 	:= tempmod.firstname;
			self.name_last	 	:= tempmod.lastname;
			self.name_middle	:= tempmod.middlename;
			self.name_suffix	:= tempmod.namesuffix;
			self.addr1 				:= tempmod.addr;
			self.prim_range 	:= tempmod.prim_range;
			self.predir	 			:= tempmod.predir;
			self.prim_name  	:= tempmod.prim_name;
			self.suffix     	:= tempmod.suffix;
			self.postdir    	:= tempmod.postdir;
			self.sec_range  	:= tempmod.sec_range;
			self.city 				:= tempmod.city;
			self.st 					:= tempmod.state;
			self.zip 					:= tempmod.zip;
			self.phone	 			:= tempmod.phone;
			self.dob		 			:=(string) tempmod.dob;
			self 							:= [];
		end;
		f_in_raw := project(dataset([{''}],r),xform(LEFT));

		// --------------------------------------------------------------------
		// call common function to get results
		//
		out_recs_raw := ungroup(clickdata.ClickData_Best_Function(f_in_raw, mod_access, true, true));
		out_recs := ClickData.fn_filter_demographics(out_recs_raw, STD.Str.ToUpperCase(DataPackageEnhancement));

		// --------------------------------------------------------------------
		// format response to layout expected by esp
		//
		out_results := iesp.transform_dmxml(out_recs);
		iesp.ECL2ESP.Marshall.MAC_Marshall_Results(out_results, results, iesp.dmxmlsearch.t_DMXMLSearchResponse);

		// --------------------------------------------------------------------
		// calculate royalties
		//
		Royalty.MAC_RoyaltyDMXML(out_recs, royalties);

		output(results, named('Results'));
		output(royalties, named('RoyaltySet'));

endmacro;
/*-- Example Search
<DirectMarketingSearchRequest>
  <Row>
   <User>
    <ReferenceCode/>
    <BillingCode/>
    <QueryId/>
    <CompanyId/>
   </User>
   <SearchBy>
    <Name>
     <Full/>
     <First>KARLA</First>
     <Middle>N</Middle>
     <Last>MORAST</Last>
     <Suffix/>
     <Prefix/>
    </Name>
    <Address>
     <StreetNumber/>
     <StreetPreDirection/>
     <StreetName/>
     <StreetSuffix/>
     <StreetPostDirection/>
     <UnitDesignation/>
     <UnitNumber/>
     <StreetAddress1>65 FOX HILL DR</StreetAddress1>
     <StreetAddress2/>
     <City>BRIDGEWATER</City>
     <State>MA</State>
     <Zip5>02324</Zip5>
    </Address>
    <DOB/>
    <Phone>7818851533</Phone>
   </SearchBy>
   <Options>
    <DataPackageEnhancement>B</DataPackageEnhancement>
   </Options>
  </Row>
 </DirectMarketingSearchRequest>
*/
