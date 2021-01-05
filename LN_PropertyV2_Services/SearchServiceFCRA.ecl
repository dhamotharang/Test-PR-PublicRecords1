// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- Search for Property Records via simple keys and autokeys. It also searches the Forclosures File. (ESP-compliant output)<br/>
  Optionally searches the Notice of Defaults File:
<table border="1">
<tr><th>ExcludeForeclosures</th><th>IncludeNoticeOfDefaults</th><th>Record Types</th></tr>
<tr><td>false</td><td>false</td><td>Foreclosures Only</td></tr>
<tr><td>false</td><td>true</td><td>Foreclosures and Notice of Defaults</td></tr>
<tr><td>true</td><td>true</td><td>Notice of Defaults Only</td></tr>
<tr><td>true</td><td>false</td><td>zip, zilch, zero, zippo, zot, ...</td></tr>
</table>
*/
import FCRA;

export SearchServiceFCRA() := macro
  //Property Search
  boolean isFCRA := true;
  // compute results
  #CONSTANT('NoDeepDive', true);
  #CONSTANT('usePropMarshall', true);
  #CONSTANT('DisplayMatchedParty', true);
  #constant('DidOnly', true); // for picklist
  #CONSTANT('TwoPartySearch', FALSE);

  //------------------------------------------------------------------------------------
  // gateways := dataset([], Gateway.layouts.config) : stored ('gateways', few);
  gateways := Gateway.Configuration.Get();
  picklist_res := FCRA.PickListSoapcall.non_esdl(gateways);
  //------------------------------------------------------------------------------------

  rdid := (unsigned6)picklist_res[1].Records[1].UniqueId;

  //non-subject suppression
  nss := ut.getNonSubjectSuppression (Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription);

  //  Fill FCRA.iRules
  iRulesParams := module (FCRA.iRules)
    export integer8 FFDOptionsMask := FFD.FFDMask.Get();
    export integer FCRAPurpose := FCRA.FCRAPurpose.Get();
  end;

  raw_combined := LN_PropertyV2_Services.SearchService_records(rdid,nss,isFCRA,iRulesParams);
  raw := raw_combined.Records;
  statements := raw_combined.Statements;
  consumer_alerts := raw_combined.ConsumerAlerts;
  input_consumer := FFD.MAC.PrepareConsumerRecord(rdid, false);

  // standard record counts & limits
  doxie.MAC_Header_Field_Declare(isFCRA);

  Alerts.mac_ProcessAlerts(raw,LN_PropertyV2_Services.alert,raw_final);

  // create External Key field
  Text_Search.MAC_Append_ExternalKey(raw_final, raw_final2, l.ln_fares_id);

  // doxie.MAC_Marshall_Results(raw_final2,cooked)
  LN_PropertyV2_Services.Marshall.MAC_Marshall_Results(raw_final2, cooked);

  // display Property results
  output(cooked, named('Results'));
  output(statements, named('ConsumerStatements'));
  output(consumer_alerts, named('ConsumerAlerts'));
  output(input_consumer, named('Consumer'));

endmacro;
