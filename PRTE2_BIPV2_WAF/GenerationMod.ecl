// Machine-readable versions of the spec file and subsets thereof
EXPORT GenerationMod := MODULE
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.0';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'PRTE2_BIPV2_WAF';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := 'Biz';
  EXPORT spc_IDNAME := 'proxid'; // cluster id (input)
  EXPORT spc_IDFIELD := 'proxid'; // cluster id (output)
  EXPORT spc_RIDFIELD := 'rcid'; // record id
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-ma\n'
    + '// OPTIONS:-ma \n'
    + 'MODULE:PRTE2_BIPV2_WAF\n'
    + 'FILENAME:BizHead\n'
    + 'IDNAME:proxid\n'
    + 'IDFIELD:EXISTS:proxid\n'
    + 'IDPARENTS:seleid,orgid,ultid\n'
    + 'RIDFIELD:rcid\n'
    + 'RECORDS:4000000000\n'
    + 'POPULATION:100000000\n'
    + 'NINES:3\n'
    + 'PROCESS:Biz\n'
    + '// HACK:MAXBLOCKSIZE:10000\n'
    + '// HACK:KEYSUFFIX\n'
    + 'FIELDTYPE:wordbag:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789):SPACES( <>{}[]-^=!+&,./):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:alpha:CAPS:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ):ONFAIL(CLEAN)\n'
    + 'FIELDTYPE:number:ALLOW(0123456789):ONFAIL(CLEAN)\n'
    + 'FUZZY:Right4:RST:CUSTOM(fn_Right4):TYPE(STRING4)\n'
    + 'FUZZY:PreferredName:RST:CUSTOM(fn_PreferredName):TYPE(STRING20)\n'
    + 'FUZZY:NormSuffix:RST:CUSTOM(fn_normSuffix):TYPE(STRING5)\n'
    + 'FIELD:parent_proxid:CARRY:0,0\n'
    + 'FIELD:ultimate_proxid:CARRY:0,0\n'
    + 'FIELD:has_lgid:CARRY:0,0\n'
    + 'FIELD:empid:0,0\n'
    + 'FIELD:powid:0,0\n'
    + '//FIELD:orgid:27,0 // Comment out when using IDPARENTS\n'
    + '//FIELD:ultid:27,0 // Comment out when using IDPARENTS\n'
    + 'FIELD:source:2,0\n'
    + 'FIELD:source_record_id:26,0\n'
    + '// FIELD:company_name:TYPE(STRING120):BAGOFWORDS:LIKE(wordbag):25,0\n'
    + 'FIELD:cnp_number:0,0\n'
    + 'FIELD:cnp_btype:0,0\n'
    + 'FIELD:cnp_lowv:0,0\n'
    + 'FIELD:cnp_name:TYPE(STRING120):BAGOFWORDS:LIKE(wordbag):24,0\n'
    + 'FIELD:company_phone:26,0\n'
    + 'FIELD:company_fein:LIKE(number):EDIT1:PROP:26,0\n'
    + 'FIELD:company_sic_code1:10,0\n'
    + 'FIELD:prim_range:EDIT1:13,0\n'
    + 'FIELD:prim_name:EDIT1:LIKE(wordbag):15,0\n'
    + 'FIELD:sec_range:EDIT1:LIKE(wordbag):12,0\n'
    + 'FIELD:p_city_name:EDIT1:LIKE(wordbag):CONTEXT(st):12,0\n'
    + 'FIELD:st:LIKE(alpha):5,0\n'
    + 'FIELD:zip:LIKE(number):MULTIPLE:14,0\n'
    + 'FIELD:company_url:TYPE(STRING120):BAGOFWORDS:LIKE(wordbag):26,0\n'
    + 'FIELD:isContact:1,0\n'
    + 'FIELD:title:1,0\n'
    + 'FIELD:fname:EDIT1:INITIAL:PreferredName:LIKE(wordbag):8,0\n'
    + 'FIELD:mname:INITIAL:EDIT2:LIKE(wordbag):9,0\n'
    + 'FIELD:lname:INITIAL:HYPHEN2:EDIT2:LIKE(wordbag):10,0\n'
    + 'FIELD:name_suffix:NormSuffix:LIKE(wordbag):8,0\n'
    + 'FIELD:contact_email:0,0\n'
    + 'CONCEPT:CONTACTNAME:fname:mname:lname:17,0\n'
    + 'CONCEPT:STREETADDRESS:prim_range:prim_name:sec_range:16,0\n'
    + '\n'
    + '//LINKPATH:L_CNPNAME:cnp_name:?:zip:prim_name:p_city_name:st:+:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:prim_range:sec_range \n'
    + '//LINKPATH:L_CNPNAME_ST:cnp_name:st:?:zip:prim_name:p_city_name:+:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:prim_range:sec_range                                                                              \n'
    + '//LINKPATH:L_ADDRESS1:prim_name:p_city_name:st:?:prim_range:cnp_name:+:zip:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:sec_range\n'
    + '//LINKPATH:L_ADDRESS2:prim_name:zip:?:st:prim_range:cnp_name:+:p_city_name:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:sec_range\n'
    + '//LINKPATH:L_PHONE:company_phone:+:company_sic_code1:cnp_name:cnp_number:cnp_btype:cnp_lowv:zip:prim_name:p_city_name:st:prim_range:sec_range\n'
    + '//LINKPATH:L_FEIN:company_fein:+:company_sic_code1:cnp_name:cnp_number:cnp_btype:cnp_lowv:zip:prim_name:p_city_name:st:prim_range:sec_range\n'
    + '//LINKPATH:L_CONTACT:fname:lname:?:mname:cnp_name:st:+:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:zip:prim_name:p_city_name:prim_range:sec_range\n'
    + '//LINKPATH:L_URL:company_url:?:st:+:company_sic_code1:cnp_name:cnp_number:cnp_btype:cnp_lowv:zip:prim_name:p_city_name:prim_range:sec_range\n'
    + '//LINKPATH:L_EMAIL:contact_email:?:company_sic_code1:cnp_name:cnp_number:cnp_btype:cnp_lowv:zip:prim_name:p_city_name:st:prim_range:sec_range\n'
    + '//LINKPATH:L_SOURCE:source_record_id:source:?:cnp_name:prim_name:p_city_name:st:zip:+:company_sic_code1:cnp_number:cnp_btype:cnp_lowv:prim_range:sec_range\n'
    + '\n'
    + 'SOURCEFIELD:SOURCE:PERMITS(fn_sources,10)\n'
    + 'EXTERNALFILE:Corps:NAMED(File_Corp2_Base):IDDONE:MAPPING(cnp_name=corp_legal_name,prim_range=corp_addr1_prim_range,prim_name=corp_addr1_prim_name,sec_range=corp_addr1_sec_range,p_city_name=corp_addr1_p_city_name,st=corp_addr1_state,zip=corp_addr1_zip5,company_phone=corp_phone10,company_fein=corp_fed_tax_id,fname=cont_fname,lname=cont_lname,mname=cont_mname,source_record_id=source_rec_id):PERMIT(source):\n'
    + 'EXTERNALFILE:UCC:NAMED(File_Uccv2_Base):IDDONE:MAPPING(cnp_name=company_name,prim_range=prim_range,prim_name=prim_name,sec_range=sec_range,p_city_name=p_city_name,st=st,zip=zip5,company_phone=telephone_number,company_fein=fein,fname=fname,lname=lname,mname=mname):PERMIT(source):\n'
    + 'EXTERNALFILE:Vehicle:NAMED(File_VehicleV2_Base):IDDONE:MAPPING(cnp_name=append_clean_cname,prim_range=append_clean_address.prim_range,prim_name=append_clean_address.prim_name,sec_range=append_clean_address.sec_range,p_city_name=append_clean_address.v_city_name,st=append_clean_address.st,zip=append_clean_address.zip5,company_fein=orig_fein,fname=fname,mname=mname,lname=lname,source_record_id=source_rec_id):PERMIT(source):\n'
    + 'EXTERNALFILE:PropertyV2:NAMED(File_Ln_PropertyV2_Base):IDDONE:MAPPING(cnp_name=cname,prim_range=prim_range,prim_name=prim_name,sec_range=sec_range,p_city_name=p_city_name,st=st,zip=zip,company_phone=phone_number):PERMIT(source):\n'
    + 'EXTERNALFILE:BizContacts:NAMED(File_BizHead_Contacts):IDDONE:MAPPING(cnp_name=company_name,prim_range=prim_range,prim_name=prim_name,sec_range=sec_range,p_city_name=p_city_name,st=st,zip=zip,company_phone=company_phone,company_fein=company_fein):PERMIT(source):\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
