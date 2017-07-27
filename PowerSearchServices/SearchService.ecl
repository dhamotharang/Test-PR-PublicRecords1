/*--SOAP--
<message name="SearchService">
	<part name="Search" type="xsd:string" rows="7" cols="60" />
	<part name="Terms_Connectors" type="xsd:boolean"/>
	<part name="Rank_Result" type="xsd:boolean"/> 
	<part name="StartingRecord" type="xsd:unsignedInt" default="0"/>
	<part name="ReturnCount" type="xsd:unsignedInt" default="50"/>
	<part name="DPPAPurpose" type="xsd:byte" default="1"/> 
	<part name="GLBPurpose" type="xsd:byte" default="1"/> 
	<part name="SSNMask" type="xsd:string"/>	<!-- [NONE, ALL, LAST4, FIRST5] -->
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="PowerSearchRequest" type="tns:XmlDataSet" cols="80" rows="25" />
</message>
*/
/*--INFO-- Boolean and Natural Language Search.
*/
/*--USES-- Text_Search.search_form_xslt
*/
/*--HELP-- Accepts a boolean or natural language search string.<br>
If TermsConnectors is set, the search is treated as a Boolean Search else Natural Language Search.<br>
If RankResult is set, the results will be ranked else left in natural sort order. 
*/

IMPORT iesp,Text_Search;

EXPORT SearchService := MACRO

	//get iesp XML input 
	rec_in := iesp.powersearch.t_PowerSearchRequest;
	ds_in := DATASET([],rec_in) : STORED('PowerSearchRequest',FEW);
	first_row := ds_in[1] : INDEPENDENT;

	//set compliance from iesp XML input
	User := GLOBAL(first_row.User);
	iesp.ECL2ESP.SetInputUser(User);

	//set search string from iesp XML input
	SearchBy := GLOBAL(first_row.SearchBy);
	#STORED('Search',SearchBy.BooleanSearch.SearchText);

	//set options from iesp XML input
	Options := GLOBAL(first_row.Options);
	iesp.ECL2ESP.Marshall.Mac_Set(Options);
	#STORED('MaxResults',Options.MaxResults);
	#STORED('Terms_Connectors',Options.TermsAndConnectors);
	#STORED('Rank_Result',Options.RankBooleanResult);

	// main
	stdSrchArg := MODULE(PowerSearchServices.IParam.searchParams)
		EXPORT UNSIGNED maxResults := Options.MaxResults;
		EXPORT STRING6 ssnMask := 'NONE' : STORED('SSNMask');
	END;
	iespResults := PowerSearchServices.Records(stdSrchArg);
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(iespResults,Results,
		iesp.powersearch.t_PowerSearchResponse,Records,false,SubjectTotalCount);

	OUTPUT(Results,NAMED('Results'));	

ENDMACRO;
//PowerSearchServices.SearchService();
/*
<PowerSearchRequest>
 <Row>
  <User>
   <GLBPurpose></GLBPurpose>
   <DLPurpose></DLPurpose> 
   <ssnMask></ssnMask>
  </User>
  <Options>
   <MaxResults></MaxResults>
   <ReturnCount></ReturnCount>
   <StartingRecord></StartingRecord>
   <TermsAndConnectors></TermsAndConnectors>
   <RankBooleanResult></RankBooleanResult>
  </Options>
  <SearchBy>
   <BooleanSearch>
    <SearchText></SearchText>
   </BooleanSearch>
  </SearchBy>
 </Row>
</PowerSearchRequest>
*/