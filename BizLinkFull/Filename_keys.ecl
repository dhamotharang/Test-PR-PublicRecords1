IMPORT ut,Data_services,Doxie,_control,bipv2;
EXPORT Filename_Keys := module

  SHARED THISMODULE:='BizLinkFull';
	EXPORT STRING superkey_version:=TRIM(doxie.version_superkey);

  // EXPORT STRING superkey_version:=TRIM(MAP(
     // THISMODULE[LENGTH(THISMODULE)-1..] ='02'=> 'Dev'
    // ,THISMODULE[LENGTH(THISMODULE)-1..] ='03'=> 'Dev03'
    // ,regexfind('roxie',_Control.ThisEnvironment.Name,nocase) or not regexfind('dataland|thor',_Control.ThisEnvironment.Name,nocase)  =>  doxie.version_superkey
    // ,BIPV2.KeySuffix
  // ));

  SHARED STRING basename:=Data_services.Data_location.Prefix('biz_linking') + 'key::'+THISMODULE+'::'+superkey_version+'::proxid::';
  
  
  // Key_BizHead_
  EXPORT Refs                      := basename+'refs';
  EXPORT Words                     := basename+'words';
  // Key_BizHead_*
  EXPORT L_ADDRESS1                := basename+'refs::l_address1';
  EXPORT L_ADDRESS2                := basename+'refs::l_address2';
  EXPORT L_ADDRESS3                := basename+'refs::l_address3';
  EXPORT L_CNPNAME                 := basename+'refs::l_cnpname';
  EXPORT L_CNPNAME_SLIM            := basename+'refs::l_cnpname_slim';
  EXPORT L_CNPNAME_FUZZY           := basename+'refs::l_cnpname_fuzzy';
  EXPORT L_CNPNAME_ST              := basename+'refs::l_cnpname_st';
  EXPORT L_CNPNAME_ZIP             := basename+'refs::l_cnpname_zip';
  EXPORT L_CONTACT_ZIP             := basename+'refs::l_contact_zip';
  EXPORT L_CONTACT_ST              := basename+'refs::l_contact_st';
  EXPORT L_CONTACT_DID             := basename+'refs::l_contact_did';
  EXPORT L_CONTACT_SSN             := basename+'refs::l_contact_ssn';
  EXPORT L_EMAIL                   := basename+'refs::l_email';
  EXPORT L_FEIN                    := basename+'refs::l_fein';
  EXPORT L_PHONE                   := basename+'refs::l_phone';
  EXPORT L_SIC                     := basename+'refs::l_sic';
  EXPORT L_SOURCE                  := basename+'refs::l_source';
  EXPORT L_URL                     := basename+'refs::l_url';
// Key_BizHead_* External Files
	EXPORT EXT_PAYLOADBYPROXID		   := basename+'ext_databyproxid::payload';
  EXPORT EXT_L_ADDRESS1            := basename+'l_address1::ext_data';
  EXPORT EXT_L_ADDRESS2            := basename+'l_address2::ext_data';
  EXPORT EXT_L_ADDRESS3            := basename+'l_address3::ext_data';
  EXPORT EXT_L_CNPNAME             := basename+'l_cnpname::ext_data';
  EXPORT EXT_L_CNPNAME_FUZZY       := basename+'l_cnpname_fuzzy::ext_data';
  EXPORT EXT_L_CNPNAME_ST          := basename+'l_cnpname_st::ext_data';
  EXPORT EXT_L_CNPNAME_ZIP         := basename+'l_cnpname_zip::ext_data';
  EXPORT EXT_L_CONTACT_ZIP         := basename+'l_contact_zip::ext_data';
  EXPORT EXT_L_CONTACT_ST          := basename+'l_contact_st::ext_data';
  EXPORT EXT_L_CONTACT_DID         := basename+'l_contact_did::ext_data';
  EXPORT EXT_L_CONTACT_SSN         := basename+'l_contact_ssn::ext_data';
  EXPORT EXT_L_EMAIL               := basename+'l_email::ext_data';
  EXPORT EXT_L_FEIN                := basename+'l_fein::ext_data';
  EXPORT EXT_L_PHONE               := basename+'l_phone::ext_data';
  EXPORT EXT_L_SIC                 := basename+'l_sic::ext_data';
  EXPORT EXT_L_SOURCE              := basename+'l_source::ext_data';
  EXPORT EXT_L_URL                 := basename+'l_url::ext_data';	
  // Process_Biz_Layouts
  EXPORT meow                      := basename+'meow';
  EXPORT sup_proxid                := basename+'sup::proxid';
  EXPORT sup_seleid                := basename+'sup::seleid';
  EXPORT sup_orgid                 := basename+'sup::orgid';
  EXPORT sup_rcid                  := basename+'sup::rcid';
  // Speceficities
  EXPORT cnp_name                  := basename+'word::cnp_name';
  EXPORT company_url               := basename+'word::company_url';
  // Wheel
  EXPORT Wheel_Quick_city_clean    := basename+'wheel_quick::city_clean';
  EXPORT Wheel_city_clean          := basename+'wheel::city_clean';
  EXPORT Wheel_Quick_company_name  := basename+'wheel_quick::company_name';
  EXPORT Wheel_company_name        := basename+'wheel::company_name';
  //Hierarchy
  EXPORT hierarchy                 := basename+'hierarchy';
END;
/*
//for testing
output(BizLinkFull.Key_BizHead_.Key);
output(BizLinkFull.Key_BizHead_.ValueKey);
output(BizLinkFull.Key_BizHead_L_ADDRESS1.key);
output(BizLinkFull.Key_BizHead_L_ADDRESS2.key);
output(BizLinkFull.Key_BizHead_L_ADDRESS3.key);
output(BizLinkFull.Key_BizHead_L_CNPNAME.key);
output(BizLinkFull.Key_BizHead_L_CNPNAME_FUZZY.key);
output(BizLinkFull.Key_BizHead_L_CNPNAME_ST.key);
output(BizLinkFull.Key_BizHead_L_CONTACT_ZIP.key);
output(BizLinkFull.Key_BizHead_L_CONTACT_ST.key);
output(BizLinkFull.Key_BizHead_L_CONTACT_SSN.key);
output(BizLinkFull.Key_BizHead_L_EMAIL.key);
output(BizLinkFull.Key_BizHead_L_FEIN.key);
output(BizLinkFull.Key_BizHead_L_PHONE.key);
output(BizLinkFull.Key_BizHead_L_SIC.key);
output(BizLinkFull.Key_BizHead_L_SOURCE.key);
output(BizLinkFull.Key_BizHead_L_URL.key);
output(BizLinkFull.Process_Biz_Layouts.key);
output(BizLinkFull.Process_Biz_Layouts.KeyproxidUp);
output(BizLinkFull.Process_Biz_Layouts.KeyseleidUp);
output(BizLinkFull.Process_Biz_Layouts.KeyorgidUp);
output(BizLinkFull.specificities(DATASET([], BizLinkFull.layout_BizHead)).cnp_name_values_key);
output(BizLinkFull.specificities(DATASET([], BizLinkFull.layout_BizHead)).company_url_values_key);
output(BizLinkFull.Wheel.Key_city_clean);
output(BizLinkFull.Wheel.KeyQuick_city_clean);
*/
