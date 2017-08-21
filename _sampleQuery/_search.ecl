/*--SOAP--
<message name="CriminalRecords::SearchService">
  <part name="OffenderKey" 			type="xsd:string" />
  <part name="DOCNumber" 				type="xsd:string" />
  <part name="DID" 							type="xsd:string" />
</message>
*/
/*--INFO-- This service pulls from the Criminal Offenders file.*/
import iesp, AutoStandardI;

export _search () := macro
  output ('result', named ('Result'));
endmacro;

_search ();
