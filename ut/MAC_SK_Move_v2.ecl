/*2013-10-23T19:23:10Z (ananth_p venkatachalam)

*/
export MAC_SK_Move_v2(kname, move_type, seq_name, numgenerations = '3', diffing = 'false') := macro
import promotesupers;

promotesupers.Mac_SK_Move_v2(kname, move_type, seq_name, numgenerations, diffing);

endmacro : deprecated('use promotesupers.Mac_SK_Move_v2 instead');