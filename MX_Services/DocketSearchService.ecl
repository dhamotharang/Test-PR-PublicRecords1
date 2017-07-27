/*--SOAP--
<message name="DocketSearchService">

  <separator />		
	<part name="UniqueId" 					 type="xsd:unsignedint"/>
	<part name="FullName" 					 type="xsd:string"/>
	<part name="FirstName" 					 type="xsd:string"/>
	<part name="MiddleName" 				 type="xsd:string"/>
	<part name="PaternalName" 	 		 type="xsd:string"/>
	<part name="MaternalName" 	 		 type="xsd:string"/>

  <separator />	
	<part name="DocketType" 			 	 type="xsd:string" description="[CRIMINAL|ALL]"/>
	<part name="DocketPubYear"	 		 type="xsd:unsignedInt" default="0"/>
	<part name="Gender" 						 type="xsd:string" description="[M|F]"/>
	<part name="DocketNumber" 			 type="xsd:string"/>
	
  <separator />	
	<part name="PenaltThreshold"     type="xsd:unsignedInt" default="0"/>
	<part name="PhoneticMatch"     	 type="xsd:boolean"/>
	<part name="StrictMatch"     	 	 type="xsd:boolean"/>
	<part name="ReturnCount" 			 	 type="xsd:unsignedInt" default="10"/>
  <part name="StartingRecord" 		 type="xsd:unsignedInt" default="0"/>
	
  <separator />	
	<part name="InternationalDocketSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/
/*--INFO-- <br>Search service for Mexican dockets.<br>*/
/*--HELP
*/
/*--USES-- ut.input_xslt */
import AutoStandardI, iesp;

export DocketSearchService := MACRO

	ds_in := DATASET ([], iesp.internationaldocket.t_InternationalDocketSearchRequest) : STORED('InternationalDocketSearchRequest', FEW);
	first_row := ds_in[1] : INDEPENDENT;	
	iesp.ECL2ESP.SetInputBaseRequest(first_row);		
	MX_Services.IParam.SetInputDocketSearchBy(first_row.searchBy);	
	MX_Services.IParam.SetInputDocketSearchOptions(first_row.options);	
	in_mod 	:= MX_Services.Functions.getDocketSearchModule(first_row);	
	recs 		:= MX_Services.SearchRecords.Docket.records(in_mod);		
	recs_out := choosen(MX_Services.Functions.toFinalDocketOut(recs),  MX_Services.Constants.Limits.MAX_RESULTS);
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(recs_out,results,iesp.internationaldocket.t_InternationalDocketSearchResponse);		
	output(results, named('Results'));
	
ENDMACRO;
// MX_Services.DocketSearchService();
/*
<dataset>
  <Row>
   <SearchBy>
    <Type>CRIMINAL</Type>
    <DocketYear></DocketYear>
    <Gender></Gender>
    <StateProvinceCodes>
     <Item>ZAC</Item>
     <Item>MOR</Item>
    </StateProvinceCodes>
    <Name>
     <Full></Full>
     <First>PEDRO</First>
     <Middle/>
     <PaternalLast>RAMIREZ</PaternalLast>
     <MaternalLast>MARTINEZ</MaternalLast>
     <Suffix/>
     <Prefix/>
    </Name>
    <DocketNumber></DocketNumber>
   </SearchBy>
   <Options>
    <StrictMatch>0</StrictMatch>
    <MaxResults/>
    <UsePhonetics>0</UsePhonetics>
    <PenaltyThreshold/>
    <ReturnCount/>
    <StartingRecord/>
   </Options>
  </Row>
</dataset>
*/
