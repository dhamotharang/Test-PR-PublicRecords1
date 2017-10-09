EXPORT Proc_CurrentToSuperKeys := PARALLEL( // parallel should be ok - all using different superkey
     Process_Biz_Layouts.AssignCurrentKeyToSuperFile // Assign main datafile
    ,Key_BizHead_.AssignCurrentKeyToSuperFile // Assign uberkey
    ,Key_BizHead_.AssignCurrentValueKeyToSuperFile // Assign values for uberkey
    ,Key_BizHead_L_CNPNAME.AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_BizHead_L_ADDRESS1.AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_BizHead_L_ADDRESS2.AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_BizHead_L_PHONE.AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_BizHead_L_FEIN.AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_BizHead_L_CONTACT.AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_BizHead_L_URL.AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_BizHead_L_EMAIL.AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_BizHead_L_SOURCE.AssignCurrentKeyToSuperFile // Assign linkpath
);

