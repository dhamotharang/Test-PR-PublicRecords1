/*--SOAP--
<message name="PersonSearch">
  <part name="SSN" type="xsd:string"/>
	<part name="UnParsedFullName" type="xsd:string"/>
  <part name="FirstName" type="xsd:string"/>
  <part name="AllowNickNames" type="xsd:boolean"/>
	<part name="AllowPhoneticMatch" type="xsd:boolean"/>
  <part name="LastName" type="xsd:string"/>
  <part name="Zip" type="xsd:string"/>
  <part name="ZipRadius" type="xsd:unsignedInt"/>
</message>
*/

export PersonSearch := FUNCTION




	output(Training_Module.PersonSearchModule(Training_Module.PersonSearchParam).Records, NAMED('Results'));
	
	RETURN 0;
END;