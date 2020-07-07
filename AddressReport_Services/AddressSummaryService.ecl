/*--SOAP--
<message name="AddressSummaryService" wuTimeout="300000">
  <part name="GLBPurpose" type="xsd:unsignedInt"/>
  <part name="DPPAPurpose" type="xsd:unsignedInt"/>
  <part name="did" type="xsd:string"/>
  <part name="UnParsedFullName" type="xsd:string"/>
  <part name="Addr" type="xsd:string"/>
  <part name="City" type="xsd:string"/>
  <part name="State" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="SSN" type="xsd:string"/>
  <part name="DOB" type="xsd:unsignedInt"/>
  <part name="Phone" type="xsd:string"/>

  <separator/>
  <part name="AddressSummaryRequest" type = "tns:XmlDataSet" cols="80" rows="30" default="insert XML here" />
</message>
*/
/*--INFO-- This service returns the Address Summary for CITI*/


IMPORT iesp, address, doxie, AutoStandardI;

EXPORT AddressSummaryService := MACRO

//The following macro defines the field sequence on WsECL page of query.
  WSInput.MAC_AddrReport_AddressSummaryService();
  
  rec_in := iesp.addresssummary.t_AddressSummaryRequest;
  ds_in := DATASET([], rec_in) : STORED('AddressSummaryRequest', FEW);
  first_row := ds_in[1]:INDEPENDENT;
   
  //set "User" criteria:
  iesp.ECL2ESP.SetInputBaseRequest(first_row);
  
  //set "SearchBy" criteria:
  search_by := global(first_row.SearchBy, FEW);
  iesp.ECL2ESP.SetInputName(search_by.Name);
  iesp.ECL2ESP.SetInputDate(search_by.DOB, 'DOB');
  #stored('SSN', search_by.SSN);
  #stored('phone', search_by.Phone);
  
  //set "SearchBy" special CITI input address criteria:
  #stored('prim_name', search_by.Address.StreetName);
  #stored('prim_range', search_by.Address.StreetNumber);
  #stored('predir', search_by.Address.StreetPreDirection);
  #stored('postdir', search_by.Address.StreetPostDirection);
  #stored('suffix', search_by.Address.StreetSuffix);
  #stored('sec_range', search_by.Address.UnitNumber);
  in_streetaddr := address.Addr1FromComponents(search_by.Address.StreetNumber,
                                               search_by.Address.StreetPreDirection,
                                               search_by.Address.StreetName,
                                               search_by.Address.StreetSuffix,
                                               search_by.Address.StreetPostDirection,
                                               '',
                                               search_by.Address.UnitNumber);
  string60 in_streetAddress1 := IF(search_by.Address.StreetAddress1='',in_streetAddr,search_by.Address.StreetAddress1);
  string60 in_streetAddress2 := search_by.Address.StreetAddress2;
  string addr := trim(in_streetAddress1) + ' ' + trim (in_streetAddress2);
  #stored('Addr',addr);
  #stored('State', search_by.Address.State);
  #stored('City', search_by.Address.City);
  #stored('zip',search_by.Address.Zip5);
  #stored('County',search_by.Address.County);
  #stored('StateCityZip',search_by.Address.StateCityZip);
    
  //set "Options" criteria: Hard coded for CITI as these options do not come in from the ESP
  #stored('MaxRecordsToReturn', iesp.Constants.BAP_MAX_COUNT_SEARCH_ADDRESS_RESPONSE_RECORDS);
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
  AddressSummaryRecs := AddressReport_Services.AddressSummaryService_Records(first_row, mod_access);
  iesp.ECL2ESP.Marshall.MAC_Marshall_Results(AddressSummaryRecs, results, iesp.addresssummary.t_AddressSummaryResponse, Result, true);
  output(results, named('Results'));
ENDMACRO;

// AddressReport_Services.AddressSummaryService();

/*
<AddressSummaryRequest>
<row>
<User>
  <ReferenceCode></ReferenceCode>
  <BillingCode></BillingCode>
  <QueryId></QueryId>
  <GLBPurpose>1</GLBPurpose>
  <DLPurpose>1</DLPurpose>
  <MaxWaitSeconds></MaxWaitSeconds>
</User>
<SearchBy>
  <Name>
    <First></First>
    <Middle></Middle>
    <Last></Last>
    <Suffix></Suffix>
    <Prefix></Prefix>
  </Name>
  <Address>
    <StreetNumber></StreetNumber>
    <StreetPreDirection></StreetPreDirection>
    <StreetName></StreetName>
    <StreetSuffix></StreetSuffix>
    <StreetPostDirection></StreetPostDirection>
    <UnitDesignation></UnitDesignation>
    <UnitNumber></UnitNumber>
    <City></City>
    <State></State>
    <Zip5></Zip5>
  </Address>
  <DOB>
    <Year></Year>
    <Month></Month>
    <Day></Day>
  </DOB>
  <SSN></SSN>
  <Phone></Phone>
</SearchBy>
</row>
</AddressSummaryRequest>
*/
