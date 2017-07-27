 import mdr,FCRA_ExperianCred;
EXPORT File_FCRA_header_raw_syncd := 
                               header.File_header_raw_syncd(src<>'EN',src in mdr.sourceTools.set_scoring_FCRA,pflag3<>'I',pflag3<>'V')
								              + FCRA_ExperianCred.as_header(,true)(did>0);