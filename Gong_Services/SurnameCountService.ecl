/*--SOAP--
<message name="SurnameCountService">
  <part name="LastName" type="xsd:string" />
 </message>
*/
/*--INFO-- Surname Count service
*/
export SurnameCountService := macro

	gmod := AutoStandardI.GlobalModule();

	lname_value := AutoStandardI.InterfaceTranslator.lname_value.val(project(gmod,AutoStandardI.InterfaceTranslator.lname_value.params));

	recs := choosen(dx_Gong.key_surname_count()(name_last=lname_value), 100);

	final := sort(recs, -cnt, st);

	output(final, NAMED('Records'));

endmacro;
