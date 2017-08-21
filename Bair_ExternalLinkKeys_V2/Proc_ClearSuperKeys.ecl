SpecMod := specificities(Bair_ExternalLinkKeys_V2.File_Classify_PS);
EXPORT Proc_ClearSuperKeys := PARALLEL( // parallel should be ok - all using different superkey
     Process_PS_Layouts.ClearKeySuperFile // main datafile
    ,Key_Classify_PS_NAME.ClearKeySuperFile // linkpath
    ,Key_Classify_PS_ADDRESS.ClearKeySuperFile // linkpath
    ,Key_Classify_PS_DOB.ClearKeySuperFile // linkpath
    ,Key_Classify_PS_ZIP_PR.ClearKeySuperFile // linkpath
    ,Key_Classify_PS_DLN.ClearKeySuperFile // linkpath
    ,Key_Classify_PS_PH.ClearKeySuperFile // linkpath
    ,Key_Classify_PS_LFZ.ClearKeySuperFile // linkpath
    ,Key_Classify_PS_VIN.ClearKeySuperFile // linkpath
    ,Key_Classify_PS_LEXID.ClearKeySuperFile // linkpath
    ,Key_Classify_PS_SSN.ClearKeySuperFile // linkpath
    ,Key_Classify_PS_LATLONG.ClearKeySuperFile // linkpath
    ,Key_Classify_PS_PLATE.ClearKeySuperFile // linkpath
    ,Key_Classify_PS_COMPANY.ClearKeySuperFile // linkpath
    ,SpecMod.Clear_LNAMEValuesKeyNameSuperFile // BOW Keys
);
