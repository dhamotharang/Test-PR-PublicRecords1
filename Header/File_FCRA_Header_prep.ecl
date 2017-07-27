import mdr,FCRA_ExperianCred;
export File_FCRA_Header_prep :=header.file_headers(src<>'EN',src in mdr.sourceTools.set_scoring_FCRA)
															+ FCRA_ExperianCred.as_header(,true)(did>0);
