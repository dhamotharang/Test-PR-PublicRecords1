/*--SOAP--
<message name="dolStateService">
  <part name="ApplicationType" type="xsd:string"/>
  <part name="dolStateRequest" type="tns:XmlDataSet" cols="40" rows="10" />
</message>
*/

IMPORT iesp, Accident_services, WSInput;

EXPORT dolStateService := MACRO

 //The following macro defines the field sequence on WsECL page of query.
  WSInput.MAC_Accident_Services_dolStateService();
            
  DOL := Accident_Services.Constants.DOL;
  rptRec := Accident_Services.Layouts.AccidentStateRestrictionReportRecord;

  xml_in := DATASET([],{iesp.share.t_user.ApplicationType}) : STORED('dolStateRequest',FEW);
  STRING32 ApplicationType := xml_in[1].ApplicationType : STORED('ApplicationType');
  StResRptRec := Accident_Services.StateRestrictionsFunctions.getRestrictions(ApplicationType);

  iesp.AccidentStateRestrictionReport.t_AccidentStateRestrictionReportBy stateRequiresDOL(rptRec L) := TRANSFORM
    BOOLEAN dolReq := EXISTS(L.RequiredInputs) AND Accident_Services.StateRestrictionsFunctions.hasRequiredInput(L.RequiredInputs,DOL);
    SELF.AccidentState := IF(dolReq,L.AccidentState,SKIP);
  END;

  Results := PROJECT(StResRptRec,stateRequiresDOL(LEFT));
  OUTPUT(Results,NAMED('Results'));

ENDMACRO;
// Accident_Services.dolStateService();
/*
<dolStateRequest>
 <row>
  <ApplicationType></ApplicationType>
 </row>
</dolStateRequest>
*/
