/*--SOAP--
<message name="CompanyNameClean">
<part name="company_name" type="xsd:string"/>
</message> 
*/
EXPORT CompanyNameClean := MACRO
  IMPORT BIPV2_Company_Names;
  SALT26.StrType Input_company_name := '' : STORED('company_name');
  BOOLEAN input_alphabetical := FALSE : STORED('input_alphabetical');
  dInputPrep:=DATASET([{1,Input_company_name}],{UNSIGNED rid;STRING company_name;});
  BIPV2_Company_Names.functions.mac_go(dInputPrep,dCnpName,rid,company_name,input_alphabetical);
	OUTPUT(dCnpName,	NAMED('Result'));
ENDMACRO;
