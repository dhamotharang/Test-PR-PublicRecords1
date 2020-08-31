﻿EXPORT Proc_GoExternal(BOOLEAN incremental = FALSE) := PARALLEL(
/*GOEXTERNAL01*/
Process_xIDL_Layouts(incremental).BuildAll,
Key_InsuranceHeader_NAME(incremental).BuildAll,
Key_InsuranceHeader_ADDRESS(incremental).BuildAll,
Key_InsuranceHeader_SSN(incremental).BuildAll,
Key_InsuranceHeader_SSN4(incremental).BuildAll,
Key_InsuranceHeader_DOB(incremental).BuildAll,
Key_InsuranceHeader_DOBF(incremental).BuildAll,
Key_InsuranceHeader_ZIP_PR(incremental).BuildAll,
Key_InsuranceHeader_SRC_RID(incremental).BuildAll,
Key_InsuranceHeader_DLN(incremental).BuildAll,
Key_InsuranceHeader_PH(incremental).BuildAll,
Key_InsuranceHeader_LFZ(incremental).BuildAll,
Key_InsuranceHeader_RELATIVE(incremental).BuildAll,
Key_InsuranceHeader_VIN(incremental).BuildAll
);
