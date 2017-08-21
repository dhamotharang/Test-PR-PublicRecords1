import business_header, Prte2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
df := Prte2_Business_Header.File_Prep_Business_Contacts_Plus(did != 0);
#ELSE
df := business_header.File_Prep_Business_Contacts_Plus(did != 0);
#END;

export Key_Bus_Cont_DID_2_BDID := index(df,{did},{bdid},'~thor_Data400::key::bh_contacts_did_2_bdid_qa');
