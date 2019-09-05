/*--SOAP--
<message name="inquiry_services.log_service">
	<part name="address" type="xsd:string"/>
	<part name="address_2" type="xsd:string"/>
	<part name="address_3" type="xsd:string"/>
	<part name="address_4" type="xsd:string"/>
	<part name="address_5" type="xsd:string"/>
	<part name="address_6" type="xsd:string"/>
	<part name="address_7" type="xsd:string"/>
	<part name="address_8" type="xsd:string"/>
	<part name="applicationtype" type="xsd:string"/>
	<part name="city" type="xsd:string"/>
	<part name="city_2" type="xsd:string"/>
	<part name="city_3" type="xsd:string"/>
	<part name="company_address" type="xsd:string"/>
	<part name="company_city" type="xsd:string"/>
	<part name="company_fein" type="xsd:string"/>
	<part name="company_id" type="xsd:string"/>
	<part name="company_name" type="xsd:string"/>
	<part name="company_phone" type="xsd:string"/>
	<part name="company_state" type="xsd:string"/>
	<part name="company_zip" type="xsd:string"/>
	<part name="datapermissionmask" type="xsd:string"/>
	<part name="dob" type="xsd:string"/>
	<part name="dob_2" type="xsd:string"/>
	<part name="dob_3" type="xsd:string"/>
	<part name="dob_4" type="xsd:string"/>
	<part name="dob_5" type="xsd:string"/>
	<part name="dob_6" type="xsd:string"/>
	<part name="dob_7" type="xsd:string"/>
	<part name="dob_8" type="xsd:string"/>
	<part name="email" type="xsd:string"/>
	<part name="email_2" type="xsd:string"/>
	<part name="email_3" type="xsd:string"/>
	<part name="email_4" type="xsd:string"/>
	<part name="email_5" type="xsd:string"/>
	<part name="email_6" type="xsd:string"/>
	<part name="email_7" type="xsd:string"/>
	<part name="email_8" type="xsd:string"/>
	<part name="firstname" type="xsd:string"/>
	<part name="firstname_2" type="xsd:string"/>
	<part name="firstname_3" type="xsd:string"/>
	<part name="firstname_4" type="xsd:string"/>
	<part name="firstname_5" type="xsd:string"/>
	<part name="firstname_6" type="xsd:string"/>
	<part name="firstname_7" type="xsd:string"/>
	<part name="firstname_8" type="xsd:string"/>
	<part name="function_name" type="xsd:string"/>
	<part name="industryclass" type="xsd:string"/>
	<part name="lastname" type="xsd:string"/>
	<part name="lastname_2" type="xsd:string"/>
	<part name="lastname_3" type="xsd:string"/>
	<part name="lastname_4" type="xsd:string"/>
	<part name="lastname_5" type="xsd:string"/>
	<part name="lastname_6" type="xsd:string"/>
	<part name="lastname_7" type="xsd:string"/>
	<part name="lastname_8" type="xsd:string"/>
	<part name="phone" type="xsd:string"/>
	<part name="phone_2" type="xsd:string"/>
	<part name="phone_3" type="xsd:string"/>
	<part name="phone_4" type="xsd:string"/>
	<part name="phone_5" type="xsd:string"/>
	<part name="phone_6" type="xsd:string"/>
	<part name="phone_7" type="xsd:string"/>
	<part name="phone_8" type="xsd:string"/>
	<part name="ssn" type="xsd:string"/>
	<part name="ssn_2" type="xsd:string"/>
	<part name="ssn_3" type="xsd:string"/>
	<part name="ssn_4" type="xsd:string"/>
	<part name="ssn_5" type="xsd:string"/>
	<part name="ssn_6" type="xsd:string"/>
	<part name="ssn_7" type="xsd:string"/>
	<part name="ssn_8" type="xsd:string"/>
	<part name="state" type="xsd:string"/>
	<part name="state_2" type="xsd:string"/>
	<part name="state_3" type="xsd:string"/>
	<part name="state_4" type="xsd:string"/>
	<part name="state_5" type="xsd:string"/>
	<part name="state_6" type="xsd:string"/>
	<part name="state_7" type="xsd:string"/>
	<part name="state_8" type="xsd:string"/>
	<part name="transaction_type" type="xsd:string"/>
	<part name="zip" type="xsd:string"/>
	<part name="zip_2" type="xsd:string"/>
	<part name="zip_3" type="xsd:string"/>
	<part name="zip_4" type="xsd:string"/>
	<part name="zip_5" type="xsd:string"/>
	<part name="zip_6" type="xsd:string"/>
	<part name="zip_7" type="xsd:string"/>
	<part name="zip_8" type="xsd:string"/>
</message>
*/

EXPORT Log_Service() := MACRO
import inquiry_services;
   //page 306 stored: http://cdn.hpccsystems.com/releases/CE-Candidate-4.0.2/docs/ECLLanguageReference-4.0.2-2.pdf
  inputParams := stored(Inquiry_Services.Log_IParam.params);
  mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
  final_out := Inquiry_Services.Log_Records(inputParams, mod_access);	
  output(final_out, named ('Results'));
ENDMACRO;
//Log_Service()
