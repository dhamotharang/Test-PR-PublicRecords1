/*--SOAP--
<message name="BBBKeys">
</message>
*/


export BBBKeys := macro
	output(choosen(BBB2.Key_BBB_BDID,10));
	output(choosen(BBB2.Key_BBB_Non_Member_BDID,10));
endmacro;