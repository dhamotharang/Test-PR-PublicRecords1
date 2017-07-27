/*--SOAP--
<message name="EnvironmentVariableService">
	<part name="EnvironmentVariable" type="xsd:string"/>
 </message>
*/
export EnvironmentVariablesService :=
MACRO

STRING env_name := '' : STORED('EnvironmentVariable');

e := thorlib.getenv(env_name,'Default');

output(e,NAMED('Results'));


ENDMACRO;