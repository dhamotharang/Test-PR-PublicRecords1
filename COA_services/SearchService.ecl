/*--SOAP--
<message name="SearchService">

	<!-- User -->
	<part name="ReferenceCode"       type="xsd:string"/>
	<part name="BillingCode"         type="xsd:string"/>
	<part name="QueryId"             type="xsd:string"/>
	
	
	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"          type="xsd:byte"/>
	<part name="DPPAPurpose"           type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	
	<part name="MaxWaitSeconds"      type="xsd:integer"/>
	

  <part name="UnParsedFullName" type="xsd:string"/>
	<part name="FirstName"        type="xsd:string"/>
	<part name="MiddleName"       type="xsd:string"/>
	<part name="LastName"         type="xsd:string"/>
	<part name="NameSuffix"				type="xsd:string"/>
	
	<part name="predir"           type="xsd:string"/>
	<part name="prim_name"        type="xsd:string"/>
  <part name="prim_range"       type="xsd:string"/>
  <part name="suffix"           type="xsd:string"/>
  <part name="postdir"          type="xsd:string"/>
  <part name="sec_range"        type="xsd:string"/>
  <part name="Addr"             type="xsd:string"/>
  <part name="City"             type="xsd:string"/>
  <part name="State"            type="xsd:string"/>
  <part name="Zip"              type="xsd:string"/>
	<part name="did"                 type="xsd:string"/>
	
	<part name="ReturnCount"         type="xsd:string"/>
	<part name="StartingRecord"      type="xsd:string"/>
	
	 <part name="allownicknames"   type="xsd:boolean"/>
  <part name="PhoneticMatch"    type="xsd:boolean"/>
	
	<part name="DeepDive" 			type="xsd:boolean"/>
	
	<part name="ChangeOfAddressRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- Returns COA search Records.*/


import iesp, AutoStandardI;
export SearchService := macro
  #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);  
		rec_in := iesp.ChangeOfAddress.t_ChangeOfAddressRequest;
		
		// "FEW" keyword set to make data read more efficient
    ds_in := DATASET ([], rec_in) : STORED ('ChangeOfAddressRequest', FEW);
		// "independent" keyword used here to make statement atomic and a signal to 
		// code generator to not combine it with other lines of code.
		first_row := ds_in[1] : independent;
    //set options
		search_by := global (first_row.SearchBy);
		
		iesp.ECL2ESP.SetInputBaseRequest (first_row);
		iesp.ECL2ESP.Marshall.Mac_Set (first_row.options);
		iesp.ECL2ESP.SetInputName (search_by.Name);
    iesp.ECL2ESP.SetInputAddress (search_by.Address);
		
	  // wealsofound is opposite of no deep dive
		
		boolean Reversed_weAlsoFound := false : stored('DeepDive');
		boolean weAlsoFound:= if (Reversed_weAlsoFound, false, true);
		#stored('NoDeepDive',weAlsoFound);
		
		gMod := AutoStandardI.GlobalModule();
	  tempmod := module(project(gMod,COA_Services.SearchService_Records.params,opt))						
			EXPORT STRING32 ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(gMod,AutoStandardI.InterfaceTranslator.application_type_val.params));
	  end;
	
	  tmpRes := COA_services.SearchService_Records.val(tempmod);
	
		temp_results := project(tmpRes,  transform(iesp.changeofAddress.t_ChangeOfAddressResponse,
		           self._Header := iesp.ECL2ESP.GetHeaderRow(),
							 self.RecordCount := count(tmpRes),			
							 self  := left));
		results := Choosen(temp_results, iesp.ECL2ESP.Marshall.max_return, iesp.ECL2ESP.Marshall.starting_record);
		output(results, named('Results'));			
	
endmacro;

//SearchService ();

/*
<ChangeOfAddressRequest>
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
	<UseNicknames>0</UseNicknames>
  <IncludeAlsoFound>0</IncludeAlsoFound>
  <UsePhonetics>0</UsePhonetics>
</Options>
</row>
</ChangeOfAddressRequest>
*/