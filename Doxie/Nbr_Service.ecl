/*--SOAP--
<message name="Nbr_SearchRequest">
 <part name="SSN" type="xsd:string"/>
 <part name="DID" type="xsd:string"/>
</message>
*/


export Nbr_Service := macro
	#constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.LEGACY);
	output(doxie.historic_nbr_summary(false))

endmacro;

