import Address, ut, AID;
//DF-27577 Moved DID after AID and Name processes
//DF-27577 Removed Address.MAC_Address_Clean because it was not getting called/used
in_file := VotersV2.Updated_Voters;

//DF-27577 Added prep address fields
// Transform to Normalize the Mailing Addresses.
// Skip's the normalized mailing records that only contain the mailing city, st and zip populate 
// and are equivalent to resident addr city, st and zip values. or all mailing address parts are
// blank.
VotersV2.Layouts_Voters.Layout_Voters_base_new trfInFile(in_File l, unsigned c) := transform
  ,skip(c = 2 and
	     trim(l.res_city,left,right)  = trim(l.mail_city,left,right) and
		   trim(l.res_state,left,right) = trim(l.mail_state,left,right) and
		   trim(l.res_zip,left,right)   = trim(l.mail_zip,left,right) and
		   trim(l.res_city,left,right) + trim(l.res_zip,left,right) <> '')  	
	self.addr_type := choose(c, '','M');  		 
  self.prep_addr_line1:= choose(c, ut.CleanSpacesAndUpper(l.res_Addr1 + ' ' + l.res_Addr2), ut.CleanSpacesAndUpper(l.mail_Addr1 + ' ' + l.mail_Addr2));
	temp_res_addr_line_last := if((trim(l.res_city,left,right) != '' and trim(l.res_state,left,right) != '') or (trim(l.res_zip,left,right) != '')
																	,Address.Addr2FromComponents(ut.CleanSpacesAndUpper(l.res_city), ut.CleanSpacesAndUpper(l.res_state), l.res_zip[1..5])			
																  ,'');	
	temp_mail_addr_line_last := if((trim(l.mail_city,left,right) != '' and trim(l.mail_state,left,right) != '') or (trim(l.mail_zip,left,right) != '')
																	,Address.Addr2FromComponents(ut.CleanSpacesAndUpper(l.mail_city), ut.CleanSpacesAndUpper(l.mail_state), l.mail_zip[1..5])			
																	,'');
	self.prep_addr_line_last := choose(c, temp_res_addr_line_last, temp_mail_addr_line_last); 								                   
	self.title := l.prefix_title;
	self.fname := l.first_name;
	self.mname := l.middle_name;
	self.lname := l.last_name;
	self.name_suffix := l.name_suffix_in;
	self := l;	
	self := [];
END;

// Normalize the Mailing Addresses 
Infile_Addr_Norm  := NORMALIZE(in_file,
								   if((trim(left.mail_city,left,right) + trim(left.mail_state,left,right) = '' and
								       (integer)left.mail_zip = 0)  or 											 
								      (trim(left.res_addr1,left,right) = trim(left.mail_addr1,left,right) and
									     trim(left.res_addr2,left,right) = trim(left.mail_addr2,left,right) and
								       trim(left.res_city,left,right)  = trim(left.mail_city,left,right) and									   
								       trim(left.res_state,left,right) = trim(left.mail_state,left,right) and
								       trim(left.res_zip,left,right)   = trim(left.mail_zip,left,right)),1,2)								      
								   ,trfInFile(left,counter));
									 
// Transform the Maiden Prior name value
VotersV2.Layouts_Voters.Layout_Voters_base_new trfMaidenPrior(Infile_Addr_Norm l, unsigned c) := transform												 
	self.lname      := choose(c, trim(l.last_name,left,right), trim(l.clean_maiden_pri,left,right));
	self.name_type  := choose(c, '','2');
	self := l;	
end;

Invalid_Maiden_Names := ['','JR','SR','MRS','NONE','N/A',
                         'NOT AVAILABLE','UNAVAILABLE',
                         'UNK','UNKN','UNKNOWN'];

// Normalize the Maiden Prior name value
Infile_Name_Norm  := NORMALIZE(Infile_Addr_Norm
									,if(trim(left.clean_maiden_pri,left,right) in Invalid_Maiden_Names or
									    trim(left.last_name,left,right) = trim(left.clean_maiden_pri,left,right),1,2)
									,trfMaidenPrior(left,counter));									
									
//DF-26929 Adding the MA Census base to re-DID
//Bringing previous base files into the build process
baseFile := VotersV2.File_Voters_Base + VotersV2.File_MA_Census_Base 
//uncomment for testing purposes
// : persist('~thor_data400::persist::voters::BaseFile',SINGLE) 
;

//Concatenated previous base files with current update
bothFiles := Infile_Name_Norm + baseFile;

// Added for DF-27802 - Emerges Opt Out - This will filter out Voters records that are found in the Emerges Opt Out file.  
//Barb moved to this attribute, Cleaned_Addr_Cache_Base since Clean_Voters_DID, since DID process has been moved to after this attribute
optOut :=  VotersV2.File_OptOut_Cleaned;	

joinLayout := record
	 VotersV2.Layouts_Voters.Layout_Voters_base_new;	
	 string optout_flag;
end;
	
distVoters  :=	distribute(bothFiles,hash(dob)); 
dedupOptOut :=	dedup(sort(distribute(optOut,hash(dob)),dob,last_name,first_name,state,local),dob,last_name,first_name,state,local)(dob <> '' and last_name <> '' and first_name <> '' and state <> '');
	
joinVoters_OptOut := join(distVoters, dedupOptOut,
													 left.dob        = right.dob and
													 left.last_name  = right.last_name and
													 left.first_name = right.first_name and
													 (left.res_state = right.state or left.mail_state = right.state),
														transform(joinLayout,
																			 self.optout_flag := if( left.dob        = right.dob and
																															 left.last_name  = right.last_name and 
																															 left.first_name = right.first_name and 
																															 (left.res_state = right.state or left.mail_state = right.state) and 
																															 left.dob        <> '' and right.dob        <> ''  and 
																															 left.last_name  <> '' and right.last_name  <> ''  and 
																															 left.first_name <> '' and right.first_name <> ''  and 
																															 (left.res_state <> '' or left.mail_state   <> '') and right.state <> ''
																															 ,'O' ,'');	
																			 self 				  := left;
																			 self  				  := [];),
															 left outer, lookup, local);
																	 
Base_filterOptOuts := project(joinVoters_OptOut(optOut_flag <> 'O'),transform(VotersV2.Layouts_Voters.Layout_Voters_base_new,self := left));
// End of Emerges Opt Out filter

// generating a sequence number for "vtid"
ut.MAC_Sequence_Records(Base_filterOptOuts,vtid,vtidBothFiles);

File_Addr_filtered_recs := vtidBothFiles(prep_addr_line_last <> '');
File_Addr_empty_recs    := vtidBothFiles(prep_addr_line_last = '');
									
unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

//Added AID
AID.MacAppendFromRaw_2Line(
                           File_Addr_filtered_recs,
				                   prep_addr_line1,       //addr1
				                   prep_addr_line_last,   //addr2													 
													 raw_aid, dwithAID, lFlags);

clean_cache_addr_file := project(dwithAID
			,transform( VotersV2.Layouts_Voters.Layout_Voters_base_new,			  
								  self.ace_aid	      := left.aidwork_acecache.aid					;
									self.raw_aid        := left.aidwork_rawaid								;
									self.prim_range			:= left.aidwork_acecache.prim_range		;
									self.predir					:= left.aidwork_acecache.predir				;
									self.prim_name			:= left.aidwork_acecache.prim_name		;
									self.addr_suffix		:= left.aidwork_acecache.addr_suffix	;
									self.postdir				:= left.aidwork_acecache.postdir			;
									self.unit_desig			:= left.aidwork_acecache.unit_desig		;
									self.sec_range			:= left.aidwork_acecache.sec_range		;
									self.p_city_name		:= left.aidwork_acecache.p_city_name	;
									self.v_city_name		:= left.aidwork_acecache.v_city_name	;
									self.st							:= left.aidwork_acecache.st						;
									self.zip						:= left.aidwork_acecache.zip5					;
									self.zip4						:= left.aidwork_acecache.zip4					;
									self.cart						:= left.aidwork_acecache.cart					;
									self.cr_sort_sz			:= left.aidwork_acecache.cr_sort_sz		;
									self.lot						:= left.aidwork_acecache.lot					;
									self.lot_order			:= left.aidwork_acecache.lot_order		;
									self.dpbc						:= left.aidwork_acecache.dbpc					;
									self.chk_digit			:= left.aidwork_acecache.chk_digit		;
									self.rec_type				:= left.aidwork_acecache.rec_type			;
									self.ace_fips_st    := left.aidwork_acecache.county[1..2]	;
									self.fips_county		:= left.aidwork_acecache.county[3..]	;
									self.geo_lat				:= left.aidwork_acecache.geo_lat			;
									self.geo_long				:= left.aidwork_acecache.geo_long			;
									self.msa						:= left.aidwork_acecache.msa					;
									self.geo_blk				:= left.aidwork_acecache.geo_blk			;
									self.geo_match			:= left.aidwork_acecache.geo_match		;
									self.err_stat				:= left.aidwork_acecache.err_stat			;
									//initializing these fields for DID appends in next step
									self.did 						:= 0;
									self.did_score 			:= 0;
									self.ssn 						:= '';
									self 								:= left;
			)
		)
		+ project(File_Addr_empty_recs,transform(VotersV2.Layouts_Voters.Layout_Voters_base_new,	
									//initializing these fields for DID	appends in next step
									                           self.did 						:= 0;
									                           self.did_score 			:= 0;
									                           self.ssn 						:= '';
		                                         self := left,
		                                         self := []));

export Cleaned_Addr_Cache_Base :=  clean_cache_addr_file
//uncomment for testing purposes
// : persist(VotersV2.Cluster+'persist::voters::Cleaned_Addr_Cache_Base',SINGLE)
;
