EXPORT Proc_GoExternal := PARALLEL(
Keys(File_BizHead).BuildAll,
Process_Biz_Layouts.BuildAll,
Key_BizHead_L_CNPNAME_ZIP.BuildAll,
Key_BizHead_L_CNPNAME_ST.BuildAll,
Key_BizHead_L_CNPNAME.BuildAll,
Key_BizHead_L_CNPNAME_FUZZY.BuildAll,
Key_BizHead_L_ADDRESS1.BuildAll,
Key_BizHead_L_ADDRESS2.BuildAll,
Key_BizHead_L_ADDRESS3.BuildAll,
Key_BizHead_L_PHONE.BuildAll,
Key_BizHead_L_FEIN.BuildAll,
Key_BizHead_L_URL.BuildAll,
Key_BizHead_L_CONTACT_ZIP.BuildAll,
Key_BizHead_L_CONTACT_ST.BuildAll,
Key_BizHead_L_CONTACT.BuildAll,
Key_BizHead_L_CONTACT_SSN.BuildAll,
Key_BizHead_L_EMAIL.BuildAll,
Key_BizHead_L_SIC.BuildAll,
Key_BizHead_L_SOURCE.BuildAll,
Key_BizHead_L_CONTACT_DID.BuildAll,
Specificities(File_BizHead).BuildBOWFields,
Wheel.BuildAll
);
