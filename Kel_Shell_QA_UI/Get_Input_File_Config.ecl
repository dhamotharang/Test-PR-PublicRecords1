EXPORT Get_Input_File_Config := MODULE

//**************** Input Configurations ******************
EXPORT GLB := 1;
EXPORT DPPA := 3;
// Bit counter:         12345678901234567890123456789012345678901234567890
// DataPermissionMask  := '00000000000000000000000000000000000000000000000000'; 
EXPORT DRM  := (STRING)PublicRecords_KEL.CFG_Compile.Permit_Targus; 
EXPORT DPM := '00100000000000000000000000000000000000000000000000'; 

EXPORT PRODUCT:='';
EXPORT Sources_for_the_selected_product='';

EXPORT historyDate := (STRING)STD.Date.Today(); // Run with today's date

END;