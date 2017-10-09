/*--SOAP--
<message name="Biz_Header_Service">
<part name="company_name" type="xsd:string"/>
</message>
*/
EXPORT ServiceTest := MACRO
  IMPORT lib_stringlib;
  STRING Input_company_name_prefix := '' : STORED('company_name_prefix');
  UNSIGNED iLimit:=10000:STORED('fetch_limit');
  
  param_company_name_prefix:=stringlib.StringToUpperCase(Input_company_name_prefix);
  
  Key:=BizLinkFull.Key_BizHead_L_CNPNAME_FUZZY.Key;
  KeyRec:=RECORDOF(Key);

  RawFetch(STRING5 param_company_name_prefix) :=  
  // STEPPED(
  LIMIT(Key(
      (company_name_prefix = param_company_name_prefix AND param_company_name_prefix <> (TYPEOF(company_name_prefix))'' )
    ),iLimit,ONFAIL(TRANSFORM(KeyRec,SELF := ROW([],KeyRec))),KEYED)
    // ,ultid,orgid,seleid,proxid)
    ;
  RawData := RawFetch(param_company_name_prefix);
  RawDataCount:=COUNT(RawData);
  
  OUTPUT(RawData,NAMED('RawData'));
ENDMACRO;

