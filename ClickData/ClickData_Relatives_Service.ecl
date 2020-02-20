/*--SOAP--
  <message name = "CLICKDATA_RELATIVES_SERVICE">
    <part name = 'batch_in' type = 'tns:XmlDataSet' cols = '70' rows = '25' />
    <part name = 'AppendBests' type = 'xsd:boolean'/>
        <part name="DataRestrictionMask" type="xsd:string"/>
        <part name="ApplicationType"     	type="xsd:string"/>
  </message>
*/
/*--INFO-- This is the Clickdata Relatives Service. */

import AutoStandardI, Doxie;
export ClickData_Relatives_Service := macro

  df := dataset([],clickdata.Layout_Clickdata_In_RR) : stored('batch_in',few);
  ab := false : stored('AppendBests');

  // DPPA and GLB were hardcoded to 0 prior to opt_out changes.
  mod_access := MODULE(Doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule()))
    EXPORT glb := 0;
    EXPORT dppa := 0;
  END;

  outf := clickdata.ClickData_Relatives_Function(df, mod_access, ab);

  output(choosen(outf,all),named('Results'));

endmacro;
// ClickData_Relatives_Service()