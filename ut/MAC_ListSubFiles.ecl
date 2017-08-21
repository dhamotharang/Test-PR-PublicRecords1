export MAC_ListSubFiles(superfile_name) := macro
import promotesupers;

promotesupers.mac_listsubfiles(superfile_name);
endmacro : deprecated('use promotesupers.mac_listsubfiles instead');