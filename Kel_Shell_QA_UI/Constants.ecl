EXPORT Constants := MODULE

// DALI
EXPORT Public_Records_Dali:='10.194.90.202';
EXPORT Vault_Dali:='10.173.14.201';

// ECL Watch
EXPORT Public_Records_EW:='http://10.173.14.204:8010/WsWorkunits';
EXPORT Vault_EW:='http://10.194.90.204:8010/WsWorkunits';

//**************** Input Configurations ******************
GLB := 1;
DPPA := 3;
// Bit counter:         12345678901234567890123456789012345678901234567890
// DataPermissionMask  := '00000000000000000000000000000000000000000000000000'; 
DRM  := (STRING)PublicRecords_KEL.CFG_Compile.Permit_Targus; 
DPM := '00100000000000000000000000000000000000000000000000'; 

PRODUCT:='';
Sources_for_the_selected_product='';

//************ get query info ***************************

query:='';

END;