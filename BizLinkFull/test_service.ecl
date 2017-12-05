/*--SOAP--
<message name="Biz_Header_Service">
<part name="company_name" type="xsd:string"/>
<part name="prim_range" type="xsd:string"/>
<part name="prim_name" type="xsd:string"/>
<part name="zip" type="xsd:string"/>
<part name="company_phone" type="xsd:string"/>
<part name="zip_radius" type="xsd:float"/>
</message>
*/
IMPORT BIPV2;
EXPORT test_service := MACRO
  STRING Input_company_name := '' : STORED('company_name');
  STRING Input_prim_range := '' : STORED('prim_range');
  STRING Input_prim_name := '' : STORED('prim_name');
  STRING Input_zip := '' : STORED('zip');
  STRING Input_company_phone := '' : STORED('company_phone');
  UNSIGNED Input_zip_radius := 0 : STORED('zip_radius');

  searches := dataset([{Input_company_name,Input_prim_range,Input_prim_name,Input_zip,Input_company_phone,'',Input_zip_radius}],
  {string company_name, string prim_range, string prim_name, string zip5, string10 phone10, string acctno, 
  unsigned3 zip_radius_miles := 0,	string Contact_fname := '', string Contact_mname := '', string Contact_lname := ''});

  inputs := project(searches,transform(BIPV2.IDfunctions.rec_SearchInput,self := left,self := []));

  // Data_ := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(inputs).Data_;
  Data2_ := BIPV2.IDfunctions.fn_IndexedSearchForXLinkIDs(inputs).Data2_;

  output(inputs, named('inputs'));
  output(Data2_, all, named('Data_'));

ENDMACRO;
