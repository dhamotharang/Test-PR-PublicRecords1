/*--SOAP--
<message name="SearchService">
	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"          type="xsd:byte"/>
	<part name="DPPAPurpose"           type="xsd:byte"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	
	<part name="MaxWaitSeconds"      type="xsd:integer"/>
		
	<part name="UnParsedFullName" type="xsd:string"/>
	<part name="FirstName"        type="xsd:string"/>
	<part name="MiddleName"       type="xsd:string"/>
	<part name="LastName"         type="xsd:string"/>
	<part name="NameSuffix"				type="xsd:string"/>
	
	<part name="prim_range" type="xsd:string"/>
	<part name="prim_name" type="xsd:string"/>
  <part name="predir" type="xsd:string"/>
  <part name="postdir" type="xsd:string"/>
	<part name="suffix"  type="xsd:string"/>
  <part name="sec_range" type="xsd:string"/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
	
	
	<part name="did"                 type="xsd:string"/>
	
	<part name="ReturnCount"         type="xsd:string"/>
	<part name="StartingRecord"      type="xsd:string"/>

	
	<part name="allownicknames"   type="xsd:boolean"/>
  <part name="PhoneticMatch"    type="xsd:boolean"/>
	
	<part name="NoDeepDive" type="xsd:boolean"/>
	<part name="PenaltThreshold" type="xsd:unsignedInt"/>
  <part name="StrictMatch" type="xsd:boolean"/>
	
	<part name="PilotSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Returns FAA Pilot Search records.*/

// so in general approach is 
// 1.  define input attrs from interfaces or via direct call to :STORED
// 2.  using input attrs get ids
// 3. filter ids
// 4. pentalize based on record etc in order to filter more
// 4.5 filter out pentalties that are larger than CERTAIN VALUE.
// 5. dedup.
// 6. format results
// 7. return results.

export SearchService := macro
import FaaV2_PilotServices, iesp, AutoStandardI;

 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
    
		rec_in := iesp.faapilot.t_PilotSearchRequest;
		// "FEW" keyword set to make data read more efficient
    ds_in := DATASET ([], rec_in) : STORED ('PilotSearchRequest', FEW);
		// "independent" keyword used here to make statement atomic and a signal to 
		// code generator to not combine it with other lines of code.
		first_row := ds_in[1] : independent;
    //set options
		search_by := global (first_row.SearchBy);
		
		iesp.ECL2ESP.SetInputBaseRequest (first_row);
		iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);
		
		#constant ('PenaltThreshold', 10);
		iesp.ECL2ESP.SetInputName (search_by.Name);	
    iesp.ECL2ESP.SetInputAddress (search_by.Address);
		string12 UniqueId   := search_by.UniqueId;
		#STORED('did',UniqueId);
		iesp.ECL2ESP.SetInputSearchOptions (first_row.options);
			
  input_params := AutoStandardI.GlobalModule();
	tempmod := module(project(input_params,FaaV2_PilotServices.SearchService_Records.params,opt))
		export string32 ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(input_params,AutoStandardI.InterfaceTranslator.application_type_val.params));
		
	end;
	
	tmp := FaaV2_PilotServices.SearchService_Records.val(tempmod);

		iesp.ECL2ESP.Marshall.MAC_Marshall_Results(tmp, results, iesp.faapilot.t_PilotSearchResponse);

		output(results, named('Results'));			
	
endmacro;

//SearchService ();

/*
<PilotSearchRequest>
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

<SearchBy>
  <Name>
    <Full></Full>
    <First></First>
    <Middle></Middle>
    <Last></Last>
    <Suffix></Suffix>
    <Prefix></Prefix>
  </Name>
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
<Options>
  <ReturnCount>10</ReturnCount>
  <StartingRecord>1</StartingRecord>
  <UseNicknames>1</UseNicknames>
  <IncludeAlsoFound>0</IncludeAlsoFound>
  <UsePhonetics>0</UsePhonetics>
  <StrictMatch>0</StrictMatch>
</Options>
</row>
</PilotSearchRequest>
*/