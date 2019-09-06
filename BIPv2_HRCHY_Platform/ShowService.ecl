

/*--SOAP--
<message name="ShowService">
<part name="proxid" type="xsd:string"/>
</message>
*/

/*--INFO-- Show parent companies.
<p>More info here.</p>

*/



EXPORT ShowService() := 
MACRO

import doxie, BIPv2_HRCHY_Platform;

myproxid := 0 : stored('proxid');
res := BIPv2_HRCHY_Platform.FunctionsShow.ShowParents(myproxid);
output(res, named(doxie.strResultsName));

ENDMACRO;

