pversion := '';  // Enter version date in yyyymmdd.
#workunit('name','Build BIPV2 Business Contacts Base - '+ pversion);

BIPV2_WAF.Proc_Build_BIP_Business_Contact(pversion).all;