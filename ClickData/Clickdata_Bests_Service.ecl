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

import AutoStandardI;
export Clickdata_Bests_Service := macro

	df := dataset([], clickdata.Layout_ClickData_In) : stored('batch_in', few);

	include_demographics	:= false : stored('IncludeDemographics');
	enhanced_search					:= false	: stored('EnhancedSearch');
	Zip_Radius           	:= 25 : stored('ZipRadius');
	appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));
	
	outf 									:= clickdata.ClickData_Best_Function(df, true, 
																															include_demographics, 
																															enhanced_search,
																															Zip_radius,
																															appType);
		
	output(choosen(outf,all), named('Results'));	

endmacro;
// Clickdata_Bests_Service()
/*-- Example Search
<ClickDataBestsService>
 <batch_in>
	<row>
		<acctno>1</acctno>
		<source></source>
		<name_first>KARLA</name_first>
		<name_middle>N</name_middle>
		<name_last>MORAST</name_last>
		<name_suffix></name_suffix>
		<prim_range>65</prim_range>
		<predir></predir>
		<prim_name>FOX HILL</prim_name>
		<suffix>DR</suffix>
		<postdir></postdir>
		<unit_desig></unit_desig>
		<sec_range></sec_range>
		<p_city_name></p_city_name>
		<city>BRIDGEWATER</city>
		<state>MA</state>
		<st>MA</st>
		<zip>02324</zip>
		<z5>02324</z5>
		<zip4></zip4>
		<phoneno></phoneno>
		<DOB></DOB>
	</row>
	<row>
     <acctno/>
     <record_id/>
     <full_name/>
     <unparsedfullname/>
     <name_first>JASON</name_first>
     <name_middle/>
     <name_last>SWAN</name_last>
     <name_suffix/>
     <source/>
     <addr1/>
     <unparsedaddr1/>
     <prim_range/>
     <predir/>
     <prim_name/>
     <suffix/>
     <postdir/>
     <unit_desig/>
     <sec_range/>
     <p_city_name>NEW ROCHELLE</p_city_name>
     <st>NY</st>
     <z5>10801</z5>
     <city/>
     <state/>
     <zip/>
     <zip4/>
     <phone/>
     <dob>1974</dob>
   </row>
   </batch_in>
</ClickDataBestsService>
*/