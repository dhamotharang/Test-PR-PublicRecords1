/*--SOAP--
<message name="BestAddress_Batch_Service">
  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>  
  <part name="DateLastSeen"		type="xsd:string"/>	
  <part name="MaxRecordsToReturn" type="xsd:unsignedInt"/>	
  <part name="PhoneticMatch" type="xsd:boolean"/>
  <part name="AllowNickNames" type="xsd:boolean"/>
  <part name="DPPAPurpose" type="xsd:unsignedInt"/>
  <part name="GLBPurpose" type="xsd:unsignedInt"/>
  <part name="DoNOTRollupDateFirstSeen" type="xsd:boolean"  default="false"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="UseNameUniqueDID" type="xsd:boolean"/>
	<part name="ReturnDedupFlag" type="xsd:boolean"/>	
  <part name="PartialAddressDedup" type="xsd:boolean"/>
  <part name="InputAddressDedup" type="xsd:boolean"/>	
  <part name="StartWithNextMostCurrent" type="xsd:boolean"/>
  <part name="EndWithNextMostCurrent" type="xsd:boolean"/>
  <part name="FirstNameLastNameMatch" type="xsd:boolean"/>	
  <part name="FirstNameMatch" type="xsd:boolean"/>	
  <part name="LastNameMatch" type="xsd:boolean"/>	
  <part name="FullNameMatch" type="xsd:boolean"/>	
  <part name="FirstInitialLastNameMatch" type="xsd:boolean"/>	
	<part name="Match_Name" type="xsd:boolean"/>
	<part name="Min_Name_Score" type="xsd:unsignedInt"/>
  <part name="Max_Name_Score" type="xsd:unsignedInt"/>
	<part name="Match_Street_Address" type="xsd:boolean"/>
	<part name="Match_City" type="xsd:boolean"/>
	<part name="Match_State" type="xsd:boolean"/>
	<part name="Match_Zip" type="xsd:boolean"/>
	<part name="Match_DOB" type="xsd:boolean"/>
	<part name="Match_SSN" type="xsd:boolean"/>
	<part name="Match_LinkID" type="xsd:boolean"/>
	<part name="Include_Military_Address" type="xsd:boolean"/>
	<part name="ReturnOverLimitIndicator" type="xsd:boolean"/> 
	<part name="ReturnAddrPhone" type="xsd:boolean"/> 
	<part name="ReturnLatLong" type="xsd:boolean"/> 
	<part name="ReturnCountyName" type="xsd:boolean"/> 
	<part name="ReturnConfidenceFlag" type="xsd:boolean"/> 
	<part name="ReturnUnServAddrIndicator" type="xsd:boolean"/> 
	<part name="UnServAddrDedup" type="xsd:boolean"/> 
	<part name="ReturnMultiADLIndicator" type="xsd:boolean"/> 
	<part name="ReturnConfirmedMatchCode" type="xsd:boolean"/> 
	<part name="ReturnFlipFlopIndicator" type="xsd:boolean"/> 
	<part name="CalculateV1Scores" type="xsd:boolean"/> 
	<part name="HistoricMatchCodes" type="xsd:boolean"/> 	
	<part name="IncludeBlankDateLastSeen" type="xsd:boolean"/>
	<part name="IncludeHistoricRecords" type="xsd:boolean"/> 
	<part name="ReturnSSNLooseMatchIndicator" type="xsd:boolean"/> 
</message>
*/
/*--INFO-- This service returns best address 
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
&lt;z5&gt;&lt;/z5&gt;
&lt;zip4&gt;&lt;/zip4&gt;
&lt;ssn&gt;&lt;/ssn&gt;
&lt;dob&gt;&lt;/dob&gt;
&lt;homephone&gt;&lt;/homephone&gt;
&lt;workphone&gt;&lt;/workphone&gt;
&lt;/row&gt;
&lt;/dataset&gt;
</pre>
*/


export BestAddress_Batch_Service := macro
 #CONSTANT ('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
	#constant('OnlyReturnSuccessfullyCleanedAddresses',true);

	ds_raw := dataset([],AddrBest.Layout_BestAddr.Batch_in) : stored('batch_in',few);

	BatchShare.MAC_SequenceInput(ds_raw, ds_xml_in_seq);		
	BatchShare.MAC_CapitalizeInput(ds_xml_in_seq, ds_input);		
	
	input_mod := AddrBest.Iparams.DefaultParams; 
	pre_out_recs := AddrBest.Records(ds_input, input_mod).best_records;
	
	BatchShare.MAC_RestoreAcctno(ds_input, pre_out_recs, out_recs,,false);		

	output(out_recs, named('Results'));
endmacro;
