import bipv2;
EXPORT proc_Xlink_Sample(

   string  pversion        = bipv2.KeySuffix
  ,boolean pUseBDIDPersist = true
  ,boolean pUseBIPPersist  = false

) :=
function

  import bipv2_files;
  import BIPV2_Testing;

  UseBDIDPersist 	:= pUseBDIDPersist;
  UseBIPPersist 	:= pUseBIPPersist ;


  ds20k := BIPV2_Testing.files.xlink;
    
  hfile := BIPV2_Files.files_proxid().DS_PROXID_BASE;

  z := BIPV2_Testing.mod_XLink.addIDs(ds20k, hfile, UseBDIDPersist, UseBIPPersist, pversion);

  // mac(k,kname) := macro
  // output(count(k), named('count_'+kname));
  // output(sizeof(k), named('sizeof_'+kname));
  // output(count(k)*sizeof(k), named('totalsizeof_'+kname));
  // endmacro;

  returnresult := 
		sequential(
			// output(z)
			 BIPV2_Testing.ShortCycle.out			
//			, BIPV2_Testing.mod_XLink_throughput.out
		)  : 
     SUCCESS(send_emails(pversion).buildsuccess) 
    ,FAILURE(send_emails(pversion).buildfailure)
    ;
  
  return returnresult;

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

end;