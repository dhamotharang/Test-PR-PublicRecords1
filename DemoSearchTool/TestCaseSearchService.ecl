/*--SOAP--
<message name="TestCaseSearchService" wuTimeout="300000">
	<part name="DemoSearchToolSearchRequest" type="tns:XmlDataSet" cols="110" rows="75"/>
</message>
*/
/*--INFO-- Demo Internal Search Tool Service - This service returns fake people and businesses. */

IMPORT AutoStandardI, iesp, ut;

EXPORT TestCaseSearchService := 
  MACRO 
	  
    /* ************************************************************************
     *                      Force the order on the WsECL page                 *
     ************************************************************************ */
    #WEBSERVICE(FIELDS(
      'DemoSearchToolSearchRequest'
      ));
    
    /* ************************************************************************
     *                          Grab service inputs                           *
     ************************************************************************ */
    requestIn := DATASET([], iesp.demosearchtool.t_DemoSearchToolSearchRequest) : STORED('DemoSearchToolSearchRequest', FEW);
    shared firstRow := requestIn[1] : INDEPENDENT; // Since this is realtime and not batch, should only have one row on input.
    shared searchBy := GLOBAL(firstRow.SearchBy);
    shared options  := GLOBAL(firstRow.Options);

    ErrorCode := DemoSearchTool.IParams.fn_checkForInputFailures(searchBy, options);
    IF(ErrorCode != 0,  
       FAIL(ErrorCode, ut.MapMessageCodes(ErrorCode)));
       
    DemoSearchTool_inMod := DemoSearchTool.IParams.fn_CreateSearchToolInputModule(SearchBy, options);
    
    ds_Recs := DemoSearchTool.TestCaseSearchService_Records( DemoSearchTool_inmod );
    
    iesp.demosearchtool.t_DemoSearchToolSearchResponse xfm_finalLayout() :=   
      TRANSFORM
        SELF._Header     := iesp.ECL2ESP.GetHeaderRow(),
        SELF.RecordCount := COUNT(ds_Recs),
        SELF.InputEcho   := searchBy,
        SELF.OptionsEcho := options,
        SELF.Records     := ds_Recs
      END;                   
    ds_Results := DATASET([xfm_finalLayout()]);

    OUTPUT(ds_Results, NAMED('Results'));  
  ENDMACRO;