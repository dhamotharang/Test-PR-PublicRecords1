
/*--SOAP--
<message name="RightAddress">
  <part name="RightAddressSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />
</message>
*/
/*--INFO-- This service searches the header file (Autonomy-style UPS search).*/

export UPSBusinessSearchService := MACRO

	#stored ('ScoreThreshold', UPS_Services.Constants.SCORE_THRESHOLD);
	#constant('AllowWildcard',true);
	resp := UPS_Testing.UPSBusinessSearch().records;
  output (resp, named(doxie.strResultsName));

ENDMACRO;
