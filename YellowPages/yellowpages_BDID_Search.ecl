/*--SOAP--
<message name="YellowPagesSearch" wuTimeout="300000">
	<part name="BDID" type="xsd:unsignedInt"/>
</message>
*/
/*--INFO-- This service searches the Yellowpages datafile.*/


export YellowPages_BDID_Search() := macro

typeof(yellowpages.key_YellowPages_BDID) getrecs(yellowpages.key_YellowPages_BDID L) := transform
	self := l;
end;

unsigned6	bd := 0 : stored('BDID');

outf := project(yellowpages.key_YellowPages_BDID(bdid = bd),getrecs(LEFT));

output(outf,named('Results'));

endmacro;