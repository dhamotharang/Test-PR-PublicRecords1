/*--SOAP--
<message name="WorkPlace_BatchService">
	<part name="DPPAPurpose"         type="xsd:byte"/>
	<part name="GLBPurpose"          type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="ApplicationType"     type="xsd:string"/>
  <part name="DataPermissionMask"    type="xsd:string"/>

	<!-- USER OPTIONS -->
	<part name="IncludeSpouseAlways"             type="xsd:boolean"/>
	<part name="IncludeSpouseOnlyIfNoDebtor"     type="xsd:boolean"/>
	<part name="IncludeCorpInfo"	               type="xsd:boolean"/>
  <part name="IncludeSelfRepCompanyName"			 type="xsd:boolean"/>

  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>

	<!-- RESULTS DATA EXCLUSION OPTIONS FOR INTERNAL USE-->
	<part name="ExcludedSources"      type="xsd:string"/>	
	<part name="ReturnDetailedRoyalties" type="xsd:boolean"/>	

</message>
*/
import Royalty;

EXPORT WorkPlace_BatchService(useCannedRecs = 'false') := MACRO
#constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
#stored('useOnlyBestDID',true); // used to determine the 1 "best" did for the input criteria

  Pre_result := BatchServices.WorkPlace_Records(useCannedRecs);
	ut.mac_TrimFields(Pre_result, 'Pre_result', result);	

	returnDetailedRoyalties	:= false : stored('ReturnDetailedRoyalties');	
	royalties := Royalty.RoyaltyWorkplace.GetBatchRoyaltySet(result,,returnDetailedRoyalties);
	
	OUTPUT(result, NAMED('Results'));	
	OUTPUT(royalties, NAMED('RoyaltySet'));	
	

	
ENDMACRO;

/* For testing on a roxie box:
1. Set DPPA/GLB/DataRestrictionMask as needed.
   DataRestrictionMask=00000000001 restricts TT from the output.

2. Set Include* options as needed.

3. Use something like this in the "batch_in" box/window:
<dataset>
 <row>
  <acctno>acctno_tt_and_gw</acctno>
  <name_first>brenda</name_first> 
  <name_middle></name_middle> 
  <name_last>glover</name_last> 
  <prim_range>4924</prim_range> 
  <prim_name>heatherfield</prim_name> 
  <addr_suffix>way</addr_suffix>
  <p_city_name>raleigh</p_city_name> 
  <st>nc</st> 
  <z5>27604</z5>
 </row>
</dataset>

4. If needed, set "ExcludedSources", a list of comma de-limited 2 character source codes 
   to be excluded.

*/
