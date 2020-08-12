/*--SOAP--
<message name= "LiensRetrievalServiceFCRA">
  <part name="PublicRecordRetrievalRequest" type="tns:XmlDataSet" cols="80" rows="30" />
  <part name="gateways" type="tns:XmlDataSet" cols="70" rows="4"/>
</message>
  // <part name="TransactionID" 				type="xsd:string"/>
/*--INFO-- This service searches the FCRA LiensV2 files and OKC.*/

EXPORT LiensRetrievalServiceFCRA := MACRO

   IMPORT Address, AutoStandardI, doxie, iesp, FCRA, FFD, risk_indicators, WSInput, $;

   WSInput.MAC_Liensv2_LiensRetrievalServiceFCRA();

   //Get XML Input
   req_in := iesp.riskview_publicrecordretrieval.t_PublicRecordRetrievalRequest;
   in_req := DATASET([], req_in) : STORED('PublicRecordRetrievalRequest', FEW);

   first_row := in_req[1] : INDEPENDENT;

   iesp.ECL2ESP.SetInputBaseRequest(first_row);

   params := LiensV2_Services.IParam.GetLiensRetrievalParams(first_row);

   srch_recs  := LiensV2_Services.LiensRetrieval_Records(params, in_req);

   response :=   PROJECT(srch_recs, TRANSFORM(iesp.riskview_publicrecordretrieval.t_PublicRecordRetrievalResponseEx,
                                    SELF.response := LEFT));

  MAP( params.Invalid_FilingtypeID => FAIL(LiensV2_Services.Constants.LIENS_RETRIEVAL.Invalid_FilingtypeID_failure),
      ~params.InputOk =>FAIL(301, doxie.ErrorCodes(301)),
      params.InputOk => OUTPUT(response,named('Results'))   
      ) ;

 ENDMACRO;