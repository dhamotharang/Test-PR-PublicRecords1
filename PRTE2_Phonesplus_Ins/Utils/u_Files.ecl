// PRTE2_Phonesplus_Ins.u_Files
IMPORT PRTE2_Phonesplus_Ins, PRTE2_Common;

Layouts := PRTE2_Phonesplus_Ins.Layouts;
Files   := PRTE2_Phonesplus_Ins.Files;

EXPORT u_Files := MODULE

EXPORT INITIAL_PPLUS_CSV_FILE := Files.BASE_PREFIX_NAME + '::util::' + 'initial_PPlus_CSV';
EXPORT INITIAL_PPLUS_CSV_DS		:= DATASET(INITIAL_PPLUS_CSV_FILE, Layouts.Alpha_CSV_Layout, THOR);

EXPORT INITIAL_PPLUS_CSV_update1_FILE := Files.BASE_PREFIX_NAME + '::util::' + 'initial_PPlus_CSV_update1';
EXPORT INITIAL_PPLUS_CSV_update1_DS		:= DATASET(INITIAL_PPLUS_CSV_update1_FILE, Layouts.Alpha_CSV_Layout, THOR);


//EXPORT PPlus_MHDR_File := Files.BASE_PREFIX_NAME + '::util::' + 'PPlus_MHDR';
//EXPORT PPlus_MHDR_DS	:= DATASET(PPlus_MHDR_File, Layouts.Alpha_CSV_Layout, THOR);

END;