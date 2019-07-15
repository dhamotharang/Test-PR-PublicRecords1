IMPORT IDL_Header,InsuranceHeader_Salt_T46 ; 

Base            := IDL_Header.Files.DS_SALT_ITER_OUTPUT;//IDL_Header.Files.DS_IDL_POLICY_HEADER_FATHER ;
Suppress_DS     := InsuranceHeader_Salt_T46.ManualSuppression.data_file;

dsIngest := JOIN(Base,
														 Suppress_DS,
														 LEFT.ssn         = RIGHT.ssn and
														 LEFT.dob         = RIGHT.dob and
														 LEFT.dl_nbr      = RIGHT.dl_nbr and
														 LEFT.dl_state    = RIGHT.dl_state and
														 LEFT.fname       = RIGHT.fname and
														 LEFT.mname       = RIGHT.mname and
														 LEFT.lname       = RIGHT.lname and
														 LEFT.sname       = RIGHT.sname and
														 LEFT.gender      = RIGHT.gender and
														 LEFT.prim_range  = RIGHT.prim_range and
														 LEFT.predir      = RIGHT.predir and
														 LEFT.prim_name   = RIGHT.prim_name and
														 LEFT.addr_suffix = RIGHT.addr_suffix and
														 LEFT.postdir     = RIGHT.postdir and
														 LEFT.sec_range   = RIGHT.sec_range and
														 LEFT.city        = RIGHT.city and
														 LEFT.st          = RIGHT.st and
														 LEFT.zip         = RIGHT.zip,
														 TRANSFORM(idl_header.Layout_Header_Link, SELF:=LEFT) ,LEFT ONLY , LOOKUP);
													
EXPORT File_Base := dsIngest;