/*--SOAP--
<message name="Nbr_SearchRequest">
 <part name="SSN" type="xsd:string"/>
 <part name="DID" type="xsd:string"/>
</message>
*/


export Nbr_Service := macro
	
	output(doxie.historic_nbr_summary(false))

endmacro;

