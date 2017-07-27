#option('skipFileFormatCrcCheck', 1);
#option('maxLength', 131072);

import ut;

export File_WorldCheck_Native_Character := dataset(worldcheck_bridger.Cluster_Name+'in::worldcheck_bridger::premium_plus_native_character', Layout_WorldCheck_Native_Character, csv(heading(1), utf8, separator('\t'),terminator(['\r\n','\r','\n']),quote(''),maxlength(6000)));