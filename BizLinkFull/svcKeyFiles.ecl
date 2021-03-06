IMPORT BizLinkFull;
EXPORT svcKeyFiles := MACRO
BOOLEAN bGo:=TRUE:STORED('Go');

OUTPUT(CHOOSEN(BizLinkFull.Key_BizHead_l_address1.Key,5));
OUTPUT(CHOOSEN(BizLinkFull.Key_BizHead_l_address2.Key,5));
OUTPUT(CHOOSEN(BizLinkFull.Key_BizHead_l_address3.Key,5));
OUTPUT(CHOOSEN(BizLinkFull.Key_BizHead_l_cnpname.Key,5));
OUTPUT(CHOOSEN(BizLinkFull.Key_BizHead_l_cnpname_fuzzy.Key,5));
OUTPUT(CHOOSEN(BizLinkFull.Key_BizHead_l_cnpname_st.Key,5));
OUTPUT(CHOOSEN(BizLinkFull.Key_BizHead_l_cnpname_zip.Key,5));
OUTPUT(CHOOSEN(BizLinkFull.Key_BizHead_l_contact.Key,5));
OUTPUT(CHOOSEN(BizLinkFull.Key_BizHead_l_contact_did.Key,5));
OUTPUT(CHOOSEN(BizLinkFull.Key_BizHead_l_contact_ssn.Key,5));
OUTPUT(CHOOSEN(BizLinkFull.Key_BizHead_l_email.Key,5));
OUTPUT(CHOOSEN(BizLinkFull.Key_BizHead_l_fein.Key,5));
OUTPUT(CHOOSEN(BizLinkFull.Key_BizHead_l_phone.Key,5));
OUTPUT(CHOOSEN(BizLinkFull.Key_BizHead_l_sic.Key,5));
OUTPUT(CHOOSEN(BizLinkFull.Key_BizHead_l_source.Key,5));
OUTPUT(CHOOSEN(BizLinkFull.Key_BizHead_l_url.Key,5));

OUTPUT(CHOOSEN(BizLinkFull.Process_Biz_Layouts.Key,5));
OUTPUT(CHOOSEN(BizLinkFull.Process_Biz_Layouts.KeyIDHistory,5));
OUTPUT(CHOOSEN(BizLinkFull.Process_Biz_Layouts.KeyOrgidUp,5));
OUTPUT(CHOOSEN(BizLinkFull.Process_Biz_Layouts.KeyProxidUp,5));
OUTPUT(CHOOSEN(BizLinkFull.Process_Biz_Layouts.KeySeleidUp,5));

OUTPUT(CHOOSEN(BizLinkFull.specificities(BizLinkFull.File_Bizhead).cnp_name_values_key,5));
OUTPUT(CHOOSEN(BizLinkFull.specificities(BizLinkFull.File_Bizhead).company_url_values_key,5));

// OUTPUT(CHOOSEN(BizLinkFull.Wheel.Key_city_clean,5));
// OUTPUT(CHOOSEN(BizLinkFull.Wheel.KeyQuick_city_clean,5));

ENDMACRO;

