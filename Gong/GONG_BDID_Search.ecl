/*--SOAP--
<message name = "GongBDIDSearch">
	<part name = "BDID" type = "xsd:unsignedInt"/>
</message>
*/
/*--INFO-- This Service Searches the GONG History by BDID */

export GONG_BDID_Search() := macro
	
	unsigned4 bd := 0 : stored('BDID');
	
	typeof(gong.Key_History_BDID) get_by_BDID(gong.key_history_bdid L) := transform
		self := L;
	end;
	
	outf := project(gong.Key_History_BDID(bdid = bd),get_by_bdid(LEFT));
	
	output(outf,named('RESULTS'));

endmacro;
