// Check queries on dops to find any other keys. Wheel?

import BIPV2_Best;
import BIPV2_Build;
import BIPV2_Contacts;
import BIPV2_Segmentation;
import BIPV2_Suppression;
import BizLinkFull;

//thor_data400::key::bipv2_best::qa::linkids
output(choosen(BIPV2_Best.Key_LinkIds.Key, 100), named('best'));

// thor_data400::key::bipv2::business_header::qa::contact_title_linkids
output(choosen(BIPV2_Contacts.KeyRead_Contact_Title().key, 100), named('contact_title_linkids'));

// thor_data400::key::bipv2::business_header::qa::segmentation::linkids
output(choosen(BIPV2_Segmentation.KeyRead(,false).Key, 100), named('segmentation'));

// thor_data400::key::bipv2_suppression::qa::seleprox
output(choosen(BIPV2_Suppression.modSuppression.kSeleProx(), 100), named('suppression'));

// BIPV2_Build

output(choosen(bipv2_build.key_contact_linkids.key, 100), named('contact'));
output(choosen(bipv2_build.key_directories_linkids.key, 100), named('directories'));
// output(choosen(bipv2_build.key_high_risk_industries.key, 100), named('high_risk_industry'));


// BizLinkFull Linkpaths

// thor_data400::key::bizlinkfull::qa::proxid::refs::l_address1
output(choosen(BizLinkFull.Key_BizHead_L_ADDRESS1.Key, 100), named('biz_addr1'));
// thor_data400::key::bizlinkfull::qa::proxid::refs::l_address2
output(choosen(BizLinkFull.Key_BizHead_L_ADDRESS2.Key, 100), named('biz_addr2'));
// thor_data400::key::bizlinkfull::qa::proxid::refs::l_address3
output(choosen(BizLinkFull.Key_BizHead_L_ADDRESS3.Key, 100), named('biz_addr3'));
// thor_data400::key::bizlinkfull::qa::proxid::refs::l_cnpname_fuzzy
output(choosen(BizLinkFull.Key_BizHead_L_CNPNAME_FUZZY.Key, 100), named('biz_cnp_fuzzy'));
// thor_data400::key::bizlinkfull::qa::proxid::refs::l_cnpname_st
output(choosen(BizLinkFull.Key_BizHead_L_CNPNAME_ST.Key, 100), named('biz_cnp_st'));
// thor_data400::key::bizlinkfull::qa::proxid::refs::l_cnpname_zip
output(choosen(BizLinkFull.Key_BizHead_L_CNPNAME_ZIP.Key, 100), named('biz_cnp_zip'));
// thor_data400::key::bizlinkfull::qa::proxid::refs::l_cnpname
output(choosen(BizLinkFull.Key_BizHead_L_CNPNAME.Key, 100), named('biz_cnp'));
// thor_data400::key::bizlinkfull::qa::proxid::refs::l_cnpname_slim
output(choosen(BizLinkFull.Key_BizHead_L_CNPNAME.SlimKey, 100), named('biz_cnp_slim'));
// thor_data400::key::bizlinkfull::qa::proxid::refs::l_contact_did
output(choosen(BizLinkFull.Key_BizHead_L_CONTACT_DID.Key, 100), named('biz_contact_did'));
// thor_data400::key::bizlinkfull::qa::proxid::refs::l_contact_ssn
output(choosen(BizLinkFull.Key_BizHead_L_CONTACT_SSN.Key, 100), named('biz_contact_ssn'));
// thor_data400::key::bizlinkfull::qa::proxid::refs::l_contact
output(choosen(BizLinkFull.Key_BizHead_L_CONTACT.Key, 100), named('biz_contact'));
// thor_data400::key::bizlinkfull::qa::proxid::refs::l_email
output(choosen(BizLinkFull.Key_BizHead_L_EMAIL.Key, 100), named('biz_email'));
// thor_data400::key::bizlinkfull::qa::proxid::refs::l_fein
output(choosen(BizLinkFull.Key_BizHead_L_FEIN.Key, 100), named('biz_fein'));
// thor_data400::key::bizlinkfull::qa::proxid::refs::l_phone
output(choosen(BizLinkFull.Key_BizHead_L_PHONE.Key, 100), named('biz_phone'));
// thor_data400::key::bizlinkfull::qa::proxid::refs::l_sic
output(choosen(BizLinkFull.Key_BizHead_L_SIC.Key, 100), named('biz_sic'));
// thor_data400::key::bizlinkfull::qa::proxid::refs::l_source
output(choosen(BizLinkFull.Key_BizHead_L_SOURCE.Key, 100), named('biz_source'));
// thor_data400::key::bizlinkfull::qa::proxid::refs::l_url
output(choosen(BizLinkFull.Key_BizHead_L_URL.Key, 100), named('biz_url'));


// BizLinkFull Process_Biz_Layouts

// thor_data400::key::bizlinkfull::qa::proxid::meow  - Filename_keys.meow
output(choosen(BizLinkFull.Process_Biz_Layouts.key, 100), named('biz_meow'));

// thor_data400::key::bizlinkfull::qa::proxid::sup::rcid - Filename_keys.sup_rcid
output(choosen(BizLinkFull.Process_Biz_Layouts.KeyIDHistory, 100), named('biz_sup_rcid'));
// thor_data400::key::bizlinkfull::qa::proxid::sup::proxid - Filename_keys.sup_proxid
output(choosen(BizLinkFull.Process_Biz_Layouts.KeyproxidUp, 100), named('biz_sup_prox'));
// thor_data400::key::bizlinkfull::qa::proxid::sup::seleid - Filename_keys.sup_seleid
output(choosen(BizLinkFull.Process_Biz_Layouts.KeyseleidUp, 100), named('biz_sup_sele'));
// thor_data400::key::bizlinkfull::qa::proxid::sup::orgid - Filename_keys.sup_orgid
output(choosen(BizLinkFull.Process_Biz_Layouts.KeyorgidUp, 100), named('biz_sup_org'));


// BizLinkFull Specificities

// thor_data400::key::bizlinkfull::qa::proxid::word::cnp_name - Filename_keys.cnp_name
output(choosen(BizLinkFull.specificities(DATASET([], BizLinkFull.layout_BizHead)).cnp_name_values_key, 100), named('biz_spec_cnp'));
// thor_data400::key::bizlinkfull::qa::proxid::word::company_url - Filename_keys.company_url
output(choosen(BizLinkFull.specificities(DATASET([], BizLinkFull.layout_BizHead)).company_url_values_key, 100), named('biz_spec_url'));



