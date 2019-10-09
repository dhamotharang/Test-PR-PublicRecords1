/*--SOAP--
  <message name = "ClickDataBestsService">
    <part name = 'batch_in'	type = 'tns:XmlDataSet' cols='70' rows='25'/>
        <part name="DataRestrictionMask" type="xsd:string"/>
        <part name="IncludeDemographics" type="xsd:boolean"/>
        <part name="EnhancedSearch" type="xsd:boolean"/>
        <part name="ZipRadius" type="xsd:unsignedint"/>
        <part name="ApplicationType"     	type="xsd:string"/>
  </message>
*/
/*--INFO-- This is Clickdata Best Scores service.
<pre>
&lt;dataset&gt;
&lt;row&gt;
&lt;acctno&gt;&lt;/acctno&gt;
&lt;name_last&gt;&lt;/name_last&gt;
&lt;name_first&gt;&lt;/name_first&gt;
&lt;name_middle&gt;&lt;/name_middle&gt;
&lt;name_suffix&gt;&lt;/name_suffix&gt;
&lt;prim_range&gt;&lt;/prim_range&gt;
&lt;predir&gt;&lt;/predir&gt;
&lt;prim_name&gt;&lt;/prim_name&gt;
&lt;suffix&gt;&lt;/suffix&gt;
&lt;postdir&gt;&lt;/postdir&gt;
&lt;unit_desig&gt;&lt;/unit_desig&gt;
&lt;sec_range&gt;&lt;/sec_range&gt;
&lt;p_city_name&gt;&lt;/p_city_name&gt;
&lt;st&gt;&lt;/st&gt;
&lt;zip&gt;&lt;/zip&gt;
&lt;z5&gt;&lt;/z5&gt;
&lt;zip4&gt;&lt;/zip4&gt;
&lt;dob&gt;&lt;/dob&gt;
&lt;phone&gt;&lt;/phone&gt;
&lt;/row&gt;
&lt;/dataset&gt;
</pre>
*/

import AutoStandardI, Doxie;
export Clickdata_Bests_Service := macro

  df := dataset([], clickdata.Layout_ClickData_In) : stored('batch_in', few);

  include_demographics := false : stored('IncludeDemographics');
  enhanced_search := false	: stored('EnhancedSearch');
  Zip_Radius := 25 : stored('ZipRadius');
  mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());

  outf:= clickdata.ClickData_Best_Function(df, mod_access, true, include_demographics,
    enhanced_search, Zip_radius);

  output(choosen(outf,all), named('Results'));

endmacro;