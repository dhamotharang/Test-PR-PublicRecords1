EXPORT Proc_CurrentToSuperKeys := PARALLEL( // parallel should be ok - all using different superkey
     Process_xIDL_Layouts().AssignCurrentKeyToSuperFile // Assign main datafile
    ,Process_xIDL_Layouts().AssignCurrentKeyIDHistoryToSuperFile // Assign ID History Key
    ,Process_xIDL_Layouts().AssignCurrentKey0ToSuperFile // datafile for attributefile
    ,Key_InsuranceHeader_NAME().AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_InsuranceHeader_ADDRESS().AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_InsuranceHeader_SSN().AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_InsuranceHeader_SSN4().AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_InsuranceHeader_DOB().AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_InsuranceHeader_DOBF().AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_InsuranceHeader_ZIP_PR().AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_InsuranceHeader_SRC_RID().AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_InsuranceHeader_DLN().AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_InsuranceHeader_PH().AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_InsuranceHeader_LFZ().AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_InsuranceHeader_RELATIVE().AssignCurrentKeyToSuperFile // Assign linkpath
);
