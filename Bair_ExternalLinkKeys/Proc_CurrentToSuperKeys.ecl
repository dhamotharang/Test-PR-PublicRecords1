EXPORT Proc_CurrentToSuperKeys := PARALLEL( // parallel should be ok - all using different superkey
     Process_PS_Layouts.AssignCurrentKeyToSuperFile // Assign main datafile
    ,Process_PS_Layouts.AssignCurrentKeyIDHistoryToSuperFile // Assign ID History Key
    ,Key_Classify_PS_NAME.AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_Classify_PS_ADDRESS.AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_Classify_PS_ADDRESS1.AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_Classify_PS_DOB.AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_Classify_PS_ZIP_PR.AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_Classify_PS_DLN.AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_Classify_PS_PH.AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_Classify_PS_LFZ.AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_Classify_PS_VIN.AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_Classify_PS_LEXID.AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_Classify_PS_SSN.AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_Classify_PS_LATLONG.AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_Classify_PS_PLATE.AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_Classify_PS_COMPANY.AssignCurrentKeyToSuperFile // Assign linkpath
);
