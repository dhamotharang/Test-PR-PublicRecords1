export MAC_ListSubFiles_seq(superfile_name, seq) := macro

import Promotesupers;

promotesupers.Mac_ListSubFiles_seq(superfile_name, seq);
endmacro : deprecated('use promotesupers.Mac_ListSubFiles_seq instead');