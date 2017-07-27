/*--SOAP--
<message name="Outlet_Search_Service">
	<part name="CompanyName"     		type="xsd:string"/>
  <part name="City"        				type="xsd:string"/>
  <part name="State"      				type="xsd:string"/>
	<part name="Phone"			     		type="xsd:string"/>
	<part name="DeaNumber"					type="xds:string"/>
  <part name="FederalTaxId"       type="xsd:string"/> 
	<part name="NcpdpNumber"				type="xds:string"/>
	<part name="NpiNumber"          type="xsd:string"/>
	<part name="StateLicenseNumber" type="xsd:string"/>
	<part name="Zip"    	     			type="xsd:string"/>

	<!-- COMPLIANCE/USER SETTINGS -->
  <part name="DPPAPurpose"        type="xsd:byte"/>
  <part name="GLBPurpose"         type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>

	<!-- ADDITIONAL USER OPTIONS -->
  <part name="queryOutletRequest" type="tns:XmlDataSet" cols="80" rows="30" />

 </message>
*/


IMPORT iesp, AutoStandardI, doxie;

EXPORT Outlet_Search_Service  := 
   MACRO

		//*** Get XML input
		rec_in := iesp.searchpoint.t_queryOutletRequest;
		ds_in := DATASET ([], rec_in) : STORED ('queryOutletRequest', FEW);
		first_row := ds_in[1] : independent;

		//*** Set some base options
		iesp.ECL2ESP.SetInputBaseRequest (first_row);

		//*** Store main search criteria:
		search_by := GLOBAL (first_row.SearchBy);
		options   := GLOBAL (first_row.Options);

		//iesp.ECL2ESP.SetInputAddress( search_by.Address );
			 
		//*** Service specific input variables
		#stored ('DeaNumber', search_by.deaNumber);
		#stored ('FederalTaxId', search_by.federalTaxId);
		#stored ('NpiNumber', search_by.npiNumber);
		#stored ('NcpdpNumber', search_by.ncpdpNumber);
		#stored ('StateLicenseNumber', search_by.stateLicenseNumber);
		#stored ('in_CompanyName', search_by.companyName);
		#stored ('in_City', search_by.city);
		#stored ('State', search_by.state);
		#stored ('in_Zip', search_by.Zip);
		#stored ('phone', search_by.Phone);
		
    STRING20 in_compName     := '' : STORED('in_CompanyName');
    STRING20 compName_val := stringlib.StringFindReplace( in_compName, '*', '' );
     
    STRING20 in_city  := '' : STORED('in_city');
    STRING20 city_val := stringlib.StringFindReplace( in_city, '*', '' ); 
     
    STRING20 in_zip    := '' : STORED('in_Zip');
    STRING20 zip_val   := stringlib.StringFindReplace( in_zip, '*', '' ); 
     
     
    #stored ('CompanyName',compName_val);
		#stored ('City', city_val);
		#STORED ('Zip',  zip_val);
		
		//*** Get system date for query date
		dateTime := ut.GetTimeDate();
    queryDate := dateTime[1..10] + 'T' + dateTime[11..12] + ':' + dateTime[13..14] + ':' + dateTime[15..16] + '.00' + dateTime[17..] +'Z';


				
		input_params := AutoStandardI.GlobalModule();
		
		tempmod := MODULE(PROJECT(input_params,SearchPoint_Services.Outlet_Search_Records.Iparams,opt));
				//*** Store product specific search option
				EXPORT STRING   deaNum              := ''    : STORED( 'DeaNumber' );
				EXPORT STRING   federalTaxId        := ''    : STORED( 'FederalTaxId' );
				EXPORT STRING   npiNumber           := ''    : STORED( 'NpiNumber');
				EXPORT STRING   ncpdpNumber         := ''    : STORED( 'NcpdpNumber');
				EXPORT STRING   stateLicenseNumber  := ''    : STORED( 'StateLicenseNumber' );
				EXPORT STRING32 applicationType	   	:= AutoStandardI.InterfaceTranslator.application_type_val.val(PROJECT(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
		end;
		
		outlet_results := SearchPoint_Services.Outlet_Search_Records.resultRecs( tempmod );
		
		iesp.searchpoint.t_queryOutletResponse xform() := transform
				self._Header 									:= iesp.ECL2ESP.GetHeaderRow();
				self.RecordCount 							:= count(outlet_results);
				self.return.OutletSummaryList	:= outlet_results;				
				self.return.ErrorCode    			:= '';
				self.return.ErrorMessage 			:= '';
				self.return.QueryDate    			:= queryDate;
		end;
		
		//results := Choosen(DATASET([xform()]), iesp.ECL2ESP.Marshall.max_return, iesp.ECL2ESP.Marshall.starting_record);
		results := Choosen(DATASET([xform()]), iesp.ECL2ESP.Marshall.max_return, iesp.ECL2ESP.Marshall.starting_record);
		
    
		output(results, named('Results'));	
	
ENDMACRO;
/*
<queryOutletRequest>
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
	<Options> </Options>
	<SearchBy>
		<DeaNumber>BR7530478</DeaNumber>
		<FederalTaxId> </FederalTaxId>
		<CompanyName> </CompanyName>
		<City> </City>
		<State> </State>
		<NcpdpNumber> </NcpdpNumber>
		<NpiNumber> </NpiNumber>
		<Phone> </Phone>
		<StateLicenseNumber> </StateLicenseNumber>
		<Zip> </Zip>
	</SearchBy>
</row>
</queryOutletRequest>

*/
