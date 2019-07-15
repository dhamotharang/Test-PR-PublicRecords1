IMPORT InsuranceHeader_Salt_T46,STD,IDL_Header ; 

EXPORT RemoveRecord  := MODULE 

  Suppress_DS        := InsuranceHeader_Salt_T46.ManualSuppression.data_file;//((STRING)dt_added >= '20170620'); 
  Inds               := InsuranceHeader_Incremental.Files.dsBase;//IDL_Header.Files.DS_IDL_POLICY_HEADER_FATHER;

// Find to be suppressed records by PII to match the full suppression logic 
	
	suppressed_File := JOIN(Inds,
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
														 TRANSFORM({inds}, SELF:=LEFT),LOOKUP):INDEPENDENT;		
														 
// get only latest suppression records not suppressed in previous incremental 

	ridLatestOnly  := JOIN(suppressed_File,
                      Files.IncSuppression_Current_DS,
											LEFT.rid = RIGHT.rid,
											LEFT ONLY,
											HASH);
											
	EXPORT ridLatest  :=   PROJECT(ridLatestOnly , Transform ( Layout_Base , 
                                SELF.DT_EFFECTIVE_LAST := Std.Date.Today() ; 
																SELF.src_orig := LEFT.src ; 
																SELF.src := MAP(LEFT.src[1..3] = 'IVS' => 'IVS', 
																                 LEFT.src[1..3] = 'ICA' => 'ICA',
																								 LEFT.src[1..3] = 'ICP' => 'ICP' , LEFT.src),													 
																SELF := LEFT)); 	
		
	EXPORT SuppressedFull := 	ridLatest & Files.IncSuppression_Current_DS ;  	
	
END; 