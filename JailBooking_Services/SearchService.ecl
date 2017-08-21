/*--SOAP--
<message name="SearchService">
	
	<!-- COMPLIANCE SETTINGS -->
	<part name="GLBPurpose"          type="xsd:byte" 	default="1"/>
	<part name="DPPAPurpose"         type="xsd:byte" 	default="1"/>
	<part name="ApplicationType"   	 type="xsd:string"/>
		
  <!-- Internal testing search field -->
	<part name="did" 							   type="xsd:string"/>
		
  <part name="JailBookingSearchRequest" type="tns:XmlDataSet" cols="80" rows="30" />

</message>
*/

/*--HELP--
<pre>
&lt;JailBookingRequest&gt;
	&lt;row&gt;
		&lt;User&gt;
			&lt;GLBPurpose&gt;&lt;/GLBPurpose&gt;
			&lt;DLPurpose&gt;&lt;/DLPurpose&gt;
			&lt;DLMask&gt;&lt;/DLMask&gt;
			&lt;SSNMask&gt;&lt;/SSNMask&gt;
			&lt;EndUser/&gt;
		&lt;/User&gt;
		&lt;SearchBy&gt;
			&lt;Name&gt;
			&lt;UnParsedFullName&gt;&lt;/UnParsedFullName&gt;
				&lt;Last&gt;&lt;/Last&gt;
				&lt;First&gt;&lt;/First&gt;
				&lt;Middle&gt;&lt;/Middle&gt;
			&lt;/Name&gt;    
			&lt;Address&gt;
				&lt;StreetAddress1&gt;&lt;/StreetAddress1&gt;
				&lt;City&gt;&lt;/City&gt;
				&lt;State&gt;&lt;/State&gt;
				&lt;Zip5&gt;&lt;/Zip5&gt;
				&lt;StateCityZip&gt;&lt;/StateCityZip&gt;
			&lt;/Address&gt;			
			&lt;DOB&gt;
				&lt;Year&gt;&lt;/Year&gt;
				&lt;Month&gt;&lt;/Month&gt;
				&lt;Day&gt;&lt;/Day&gt;
			&lt;/DOB&gt;
			&lt;SSN&gt;&lt;/SSN&gt; 
			&lt;Phone10&gt;&lt;/Phone10&gt;
			&lt;FBINumber&gt;&lt;/FBINumber&gt; 
			&lt;UniqueId&gt;&lt;/UniqueId&gt; 
			&lt;DLNumber&gt;&lt;/DLNumber&gt;
			&lt;StateID&gt;&lt;/StateID&gt;
			&lt;Gender&gt;&lt;/Gender&gt; 
			&lt;Race&gt;&lt;/Race&gt;
			&lt;AgeRange&gt;
				&lt;Low&gt;&lt;/Low&gt;
				&lt;High&gt;&lt;/High&gt;
			&lt;/AgeRange&gt;
			&lt;HeightRange&gt;
				&lt;Low&gt;&lt;/Low&gt;
				&lt;High&gt;&lt;/High&gt;
			&lt;/HeightRange&gt; 
			&lt;WeightRange&gt;
				&lt;Low&gt;&lt;/Low&gt;
				&lt;High&gt;&lt;/High&gt;
			&lt;/WeightRange&gt; 
			&lt;HairColor&gt;&lt;/HairColor&gt;
			&lt;EyeColor&gt;&lt;/EyeColor&gt;
			&lt;GangNameMoniker&gt;&lt;/GangNameMoniker&gt;
			&lt;ScarsMarksTattoos&gt;&lt;/ScarsMarksTattoos&gt;	
			&lt;Scars&gt;&lt;/Scars&gt;	
			&lt;Marks&gt;&lt;/Marks&gt;	
			&lt;Tattoos&gt;&lt;/Tattoos&gt;	
			 &lt;Agency&gt;&lt;/Agency&gt;
			&lt;Jurisdiction&gt;&lt;/Jurisdiction&gt; 			
		&lt;/SearchBy&gt;
		&lt;Options&gt;
			&lt;ReturnCount&gt;&lt;/ReturnCount&gt;
			&lt;StartingRecord&gt;&lt;/StartingRecord&gt;
			&lt;IncludeAlsoFound&gt;&lt;/IncludeAlsoFound&gt;
			&lt;UseNicknames&gt;&lt;/UseNicknames&gt;
			&lt;UsePhonetics&gt;&lt;/UsePhonetics&gt;
			&lt;PenaltyThreshold&gt;&lt;/PenaltyThreshold&gt;
		&lt;/Options&gt;
	&lt;/row&gt;
&lt;/JailBookingRequest&gt;
</pre>
*/
import iesp;

#warning('Service no longer used as of 09/26/2012.')
export SearchService := MACRO
	ds_in := DATASET ([], iesp.jailbooking.t_JailBookingSearchRequest) : STORED('JailBookingSearchRequest', FEW);
	first_row := ds_in[1] : INDEPENDENT;
	iesp.ECL2ESP.SetInputBaseRequest(first_row);
	JailBooking_Services.IParam.SetInputSearchBy(first_row.searchBy);	
	JailBooking_Services.IParam.SetInputSearchOptions(first_row.options);
	tmpMod := JailBooking_Services.IParam.getSearchModule(first_row);
	records := JailBooking_Services.SearchRecords(tmpMod);	
	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(records, iespOutput, iesp.jailbooking.t_JailBookingSearchResponse);
	output(iespOutput, named('Results'));
ENDMACRO;
