import business_header;

df := business_header.File_Business_Contacts_Base(did != 0);

export Key_Bus_Cont_DID_2_BDID := index(df,{did},{bdid},'~thor_Data400::key::bh_contacts_did_2_bdid_qa');
