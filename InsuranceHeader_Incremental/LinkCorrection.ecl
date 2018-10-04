 //Existing RID's entity affiliation from one DID to another.
 
IMPORT InsuranceHeader_Salt_T46	, STD , idl_header;

EXPORT LinkCorrection := MODULE 

	Suppress_DS := InsuranceHeader_Salt_T46.ManualSuppression.data_file; 
  inds 				:=  InsuranceHeader_Incremental.Files.dsBase; 
	
	//remove suppressed records from blocklink input
	ih :=  JOIN(Inds,
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
														 TRANSFORM({inds}, SELF:=LEFT),LOOKUP,LEFT ONLY):INDEPENDENT;
	
	//Find out target did's for overlink clusters
	
  split_patch := InsuranceHeader_Salt_T46.LinkBlockers(ih).Patches ;
	
	// Allow only latest  corrections 
	
	BlockLink := DISTRIBUTE(InsuranceHeader_Salt_T46.ManualOverlinks.dataIn_file((STRING)dt_first_seen >= Build_Date.AlphaKeyFull),id);
  ded_rule  := TABLE(BlockLink,{BlockLink.id},id,LOCAL);
  Latest    := JOIN(split_patch,ded_rule,LEFT.rulenum=RIGHT.id,TRANSFORM(LEFT));
	
// FILTER OUT rulenum SPLITTING more than  > 700 rids 

  tab       := TABLE( Latest , {Latest.rulenum , integer cnt := count(group)}, rulenum) ; 
	
	Latest0 := JOIN(Latest ,tab(cnt > 700) , LEFT.rulenum = right.rulenum , TRANSFORM(LEFT), LEFT ONLY); 
	
  corrections := JOIN(ih,Latest0,LEFT.rid=RIGHT.rid,
	                  TRANSFORM({Layout_Base , UNSIGNED did2}, 
	                              SELF.did2 := RIGHT.did;	
															  SELF.src_orig := LEFT.src ; 
																SELF.src := MAP(LEFT.src[1..3] = 'IVS' => 'IVS', 
																                 LEFT.src[1..3] = 'ICA' => 'ICA',
																								 LEFT.src[1..3] = 'ICP' => 'ICP' , LEFT.src),
																SELF.DT_EFFECTIVE_FIRST := Std.Date.Today() ; 
																SELF.DT_EFFECTIVE_LAST  := 0;
															 SELF:= LEFT ),LOOKUP, HASH)(did <> did2);
																 
// should not clear any correction files in 
 did2rid :=  PROJECT(idl_header.files.DS_IDL_DID2RID , TRANSFORM ( Layout_Base , 
      													SELF.DID := LEFT.DID2 ;   
																SELF.src_orig := LEFT.src ; 
																SELF.src := MAP(LEFT.src[1..3] = 'IVS' => 'IVS', 
																                 LEFT.src[1..3] = 'ICA' => 'ICA',
																								 LEFT.src[1..3] = 'ICP' => 'ICP' , LEFT.src),	
																SELF.DT_EFFECTIVE_FIRST := Std.Date.Today() ; 
																SELF.DT_EFFECTIVE_LAST  := 0;
																SELF := LEFT)); 

EXPORT ridLatest := PROJECT(corrections,TRANSFORM(Layout_Base, SELF.did := LEFT.did2 , SELF := LEFT)) + did2rid :INDEPENDENT  ;
 
											
EXPORT Full_  :=  DEDUP(SORT(DISTRIBUTE(ridLatest & Files.IncCorrection_Current_DS , HASH(RID)), RID, DID, -DT_EFFECTIVE_FIRST,LOCAL), RID,DID,LOCAL);

END;  