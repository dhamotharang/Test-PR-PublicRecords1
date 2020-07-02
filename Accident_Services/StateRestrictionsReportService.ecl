/*--SOAP--
<message name="StateRestrictionsReportService">
  <part name="ApplicationType" type="xsd:string"/>
  <part name="AccidentState" type="xsd:string"/>
  <part name="AccidentStateRestrictionReportRequest" type="tns:XmlDataSet" cols="40" rows="10" />
</message>
*/


IMPORT iesp, Accident_services, WSInput;

EXPORT StateRestrictionsReportService := MACRO
 //The following macro defines the field sequence on WsECL page of query.
 WSInput.MAC_Accident_Services_StateRestrictionsReportService();

  xml_in := DATASET([],iesp.AccidentStateRestrictionReport.t_AccidentStateRestrictionReportRequest) : STORED('AccidentStateRestrictionReportRequest',FEW);
  STRING32 ApplicationType := xml_in[1].User.ApplicationType : STORED('ApplicationType');
  STRING2 AccidentState := xml_in[1].ReportBy.AccidentState : STORED('AccidentState');

  StResRptRec := Accident_Services.StateRestrictionsFunctions.getRestrictions(ApplicationType,AccidentState);

  iesp.AccidentStateRestrictionReport.t_AccidentRequiredItems decodeItems(Accident_Services.Layouts.AccidentInputRequired L) := TRANSFORM
    stringArray := DATASET([
      {IF(L.Bitmap&Accident_Services.Constants.DOL>0,Accident_Services.Constants.sDOL,'')},
      {IF(L.Bitmap&Accident_Services.Constants.NAME>0,Accident_Services.Constants.sNAME,'')},
      {IF(L.Bitmap&Accident_Services.Constants.ADDR>0,Accident_Services.Constants.sADDR,'')},
      {IF(L.Bitmap&Accident_Services.Constants.VIN>0,Accident_Services.Constants.sVIN,'')},
      {IF(L.Bitmap&Accident_Services.Constants.DLNBR>0,Accident_Services.Constants.sDLNBR,'')},
      {IF(L.Bitmap&Accident_Services.Constants.TAG>0,Accident_Services.Constants.sTAG,'')},
      {IF(L.Bitmap&Accident_Services.Constants.SSN>0,Accident_Services.Constants.sSSN,'')},
      {IF(L.Bitmap&Accident_Services.Constants.DOB>0,Accident_Services.Constants.sDOB,'')}
      ],iesp.share.t_StringArrayItem);
    SELF.ItemsRequired := CHOOSEN(stringArray(value!=''),iesp.Constants.ACCIDENT_STATE_RESTRICTIONS_MAX_REQUIRED_ITEMS);
  END;

  iesp.AccidentStateRestrictionReport.t_AccidentStateRestrictionReportRecord rptRec(Accident_Services.Layouts.AccidentStateRestrictionReportRecord L) := TRANSFORM
    RestrictedOutputs := DATASET([{L.RestrictedOutputBitmap}],Accident_Services.Layouts.AccidentInputRequired);
    SELF.RestrictedOutputs := CHOOSEN(PROJECT(RestrictedOutputs,decodeItems(LEFT)),iesp.Constants.ACCIDENT_STATE_RESTRICTIONS_MAX_RESTRICTED_ITEMS);
    SELF.RequiredInputs := CHOOSEN(PROJECT(L.RequiredInputs,decodeItems(LEFT)),iesp.Constants.ACCIDENT_STATE_RESTRICTIONS_MAX_REQUIRED_ITEMS);
    SELF := L;
  END;

  iesp.AccidentStateRestrictionReport.t_AccidentStateRestrictionReportResponse initResponse() := TRANSFORM
    SELF.Records := CHOOSEN(PROJECT(StResRptRec,rptRec(LEFT)),iesp.Constants.ACCIDENT_STATE_RESTRICTIONS_MAX_RECORDS);
    SELF:=[];
  END;

  OUTPUT(DATASET([initResponse()]),NAMED('Results'));

ENDMACRO;
// StateRestrictionsReportService();
/*
<AccidentStateRestrictionReportRequest>
 <row>
  <user>
   <ApplicationType></ApplicationType>
  </user>
  <reportBy>
   <accidentState></accidentState>
  </reportBy>
 </row>
</AccidentStateRestrictionReportRequest>
*/
