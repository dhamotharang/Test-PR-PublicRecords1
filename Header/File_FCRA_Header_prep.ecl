 import mdr,FCRA_ExperianCred,PRTE2_Header,Header_Incremental,SALT37;

#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
export File_FCRA_Header_prep :=header.file_headers(src<>'EN',src in mdr.sourceTools.set_scoring_FCRA,pflag3<>'I',pflag3<>'V',did>0);
#ELSE 

hr0 := header.File_header_raw_latest.File(src<>'EN',src in mdr.sourceTools.set_scoring_FCRA,pflag3<>'I',pflag3<>'V');

pre_fcra := hr0 + FCRA_ExperianCred.as_header(,true)(did>0);

EXPORT File_FCRA_Header_prep := Header_Incremental.File_headers_inc_FCRA(pre_fcra);
  
#END;