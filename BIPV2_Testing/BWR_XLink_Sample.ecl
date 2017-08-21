import bipv2_files;
import BIPV2_Testing;

UseBDIDPersist 	:= TRUE;
UseBIPPersist 	:= FALSE;
ver := '113sfull';
t := if(UseBDIDPersist, ' use BDID persisted', ' rebuild BDID');
u := if(UseBIPPersist, t + ', use BIP persisted',  t + ', rebuild BIP');

#workunit('name',ver + ' xlink 20k' + u);
ds20k := BIPV2_Testing.files.xlink;
	
hfile := BIPV2_Files.files_proxid().DS_PROXID_BASE;

z := BIPV2_Testing.mod_XLink.addIDs(ds20k, hfile, UseBDIDPersist, UseBIPPersist, ver);
output(z);

mac(k,kname) := macro
output(count(k), named('count_'+kname));
output(sizeof(k), named('sizeof_'+kname));
output(count(k)*sizeof(k), named('totalsizeof_'+kname));
endmacro;

// mac(BizLinkProx02CM.Key_BizHead_L_CNPNAME.key,'CNPNAME');
// mac(BizLinkProx02CM.Key_BizHead_L_CNPNAME_ST.key,'CNPNAME_ST');
// mac(BizLinkProx02CM.Key_BizHead_L_ADDRESS1.key,'ADDRESS1');
// mac(BizLinkProx02CM.Key_BizHead_L_ADDRESS2.key,'ADDRESS2');
// mac(BizLinkProx02CM.Key_BizHead_L_PHONE.key,'PHONE');
// mac(BizLinkProx02CM.Key_BizHead_L_FEIN.key,'FEIN');
// mac(BizLinkProx02CM.Key_BizHead_L_CONTACT.key,'CONTACT');
// mac(BizLinkProx02CM.Key_BizHead_L_URL.key,'URL');
// mac(BizLinkProx02CM.Key_BizHead_L_EMAIL.key,'EMAIL');
// mac(BizLinkProx02CM.Key_BizHead_L_SOURCE.key,'SOURCE');

// mac(bizlinkfull.Key_BizHead_L_CNPNAME.key,'CNPNAME');
// mac(bizlinkfull.Key_BizHead_L_CNPNAME_ST.key,'CNPNAME_ST');
// mac(bizlinkfull.Key_BizHead_L_ADDRESS1.key,'ADDRESS1');
// mac(bizlinkfull.Key_BizHead_L_ADDRESS2.key,'ADDRESS2');
// mac(bizlinkfull.Key_BizHead_L_PHONE.key,'PHONE');
// mac(bizlinkfull.Key_BizHead_L_FEIN.key,'FEIN');
// mac(bizlinkfull.Key_BizHead_L_CONTACT.key,'CONTACT');
// mac(bizlinkfull.Key_BizHead_L_URL.key,'URL');
// mac(bizlinkfull.Key_BizHead_L_EMAIL.key,'EMAIL');
// mac(bizlinkfull.Key_BizHead_L_SOURCE.key,'SOURCE');