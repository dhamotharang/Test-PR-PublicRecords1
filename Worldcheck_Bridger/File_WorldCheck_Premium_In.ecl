#option('skipFileFormatCrcCheck', 1);
#option('maxLength', 131072);

import ut;

export File_WorldCheck_Premium_In := dataset(worldcheck_bridger.Cluster_Name+'in::worldcheck_bridger::premium_plus', Layout_WorldCheck_Premium, csv(heading(1), separator('\t'),terminator(['\r\n','\r','\n']),quote(''), maxlength(100000)));