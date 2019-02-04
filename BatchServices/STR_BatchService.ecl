/*--SOAP--
<message name="STR_BatchService">
	<part name="batch_in" 						type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="DPPAPurpose" 					type="xsd:byte"/>
	<part name="GLBPurpose"  					type="xsd:byte"/>
	<part name="DataRestrictionMask" 	type="xsd:string" default="00000000000"/>
	<part name="DataPermissionMask" 	type="xsd:string" default="00000000000"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="ShortTermThreshold" 	type="xsd:unsignedInt"/>	
	<part name="Max_Results_Per_Acct" type="xsd:unsignedInt"/>
	<part name="ExcludeDropIndCheck"  type="xsd:boolean"/>  
	<part name="PenaltThreshold" 		 	type="xsd:unsignedInt"/>	
  <part name="SSNMask"					   	type="xsd:string"/>
  <part name="SkipDeceasedSubjects" type="xsd:boolean"/>
  <part name="IncludeMinors"        type="xsd:boolean"/>
	<part name="GetSSNBest"           type="xsd:boolean"/>
</message>
*/

/*--INFO--
<pre>
Short Term Rental Indicator:
A batch service to identify possible short term rental properties.

This service will search property records to find owners, sales and tax information 
   for a given address or APN.
It will also find residency information associated with the property address by
   searching header records, drivers licenses, motor vehicles and voter registration.
It will then set indicators (hit flags) based on residency date ranges for residents 
   or property owners.
It will return those indicators along with the best information available for both
   property owners and residents.

Hit Flags:

  LT - Long Term Resident
  ST - Short Term Resident
  OO - Owner Occupied
  O  - Current Owner
  PO - Previous Owner
  NO - No Hit

----------------------------------------------------------------------------
</pre>
*/
/*--HELP-- 
<pre>
&lt;batch_in&gt;
&lt;row&gt;
&lt;acctno&gt;&lt;/acctno&gt;
&lt;addr&gt;&lt;/addr&gt;
&lt;prim_range&gt;&lt;/prim_range&gt;
&lt;predir&gt;&lt;/predir&gt;
&lt;prim_name&gt;&lt;/prim_name&gt;
&lt;addr_suffix&gt;&lt;/addr_suffix&gt;
&lt;postdir&gt;&lt;/postdir&gt;
&lt;sec_range&gt;&lt;/sec_range&gt;
&lt;p_city_name&gt;&lt;/p_city_name&gt;
&lt;st&gt;&lt;/st&gt;
&lt;z5&gt;&lt;/z5&gt;
&lt;owner1_first&gt;&lt;/owner1_first&gt;
&lt;owner1_middle&gt;&lt;/owner1_middle&gt;
&lt;owner1_last&gt;&lt;/owner1_last&gt;
&lt;owner2_first&gt;&lt;/owner2_first&gt;
&lt;owner2_middle&gt;&lt;/owner2_middle&gt;
&lt;owner2_last&gt;&lt;/owner2_last&gt;
&lt;year&gt;&lt;/year&gt;
&lt;years_to_search&gt;&lt;/years_to_search&gt;
&lt;/row&gt;
&lt;/batch_in&gt;
</pre>
*/

IMPORT BatchServices;

EXPORT STR_BatchService := MACRO
 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
in_mod := module (BatchServices.Interfaces.str_config)
	export string32 	ApplicationType 		:= '' : stored('ApplicationType');
	export unsigned2 	PenaltThreshold 		:= 10 : stored('PenaltThreshold');
	export unsigned2 	ShortTermThreshold 	:= BatchServices.STR_Constants.Defaults.SHORT_TERM_THRESHOLD : stored('ShortTermThreshold');
	export boolean 		ExcludeDropIndCheck := false : stored('ExcludeDropIndCheck');
	boolean 					SkipDeceased 				:= false : STORED('SkipDeceasedSubjects');
	export boolean 		ReturnDeceased 			:= ~SkipDeceased; // will return deceased subjects by default to keep backward compatibility.
	export boolean    IncludeMinors       := false : STORED('IncludeMinors');
	export boolean    GetSSNBest          := true  : STORED('GetSSNBest');
	export unsigned8  MaxResultsPerAcct		:= BatchServices.STR_Constants.Defaults.MaxResults_Per_Acct : STORED('Max_Results_Per_Acct');
end;

batch_in := DATASET([], BatchServices.STR_Layouts.batch_in) : STORED('batch_in', FEW);

recs := BatchServices.STR_Records(batch_in, in_mod);

output(recs, NAMED('Results'));

ENDMACRO;
//BatchServices.STR_BatchService();