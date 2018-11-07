/*--SOAP--
<message name="SexOffender_Report" wuTimeout="240000">
  <part name="DID" type="xsd:string" required="1"/>
  <part name="SeisintPrimaryKey" type="xsd:string"/>
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/> 
	<part name="ApplicationType"     type="xsd:string"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
  <part name="SeisintAdlService" type="xsd:string"/>
  <part name="isANeighbor" type="xsd:boolean"/>
  <part name="NeighborService" type="tns:EspStringArray"/>
</message>
*/
/*--INFO-- This service pulls from the Sex Offenders and Offenses file.*/

import WSInput, doxie;

export sexoffender_report := macro
#CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
#stored('IncludeNonRegisteredAltAddresses',true);

WSInput.MAC_SexOffender_Report()

fetched := doxie.SexOffender_Search_Records ();

/*----------------------[ Output ]-----------------------*/		
output(fetched, NAMED('Results')); 

endmacro;