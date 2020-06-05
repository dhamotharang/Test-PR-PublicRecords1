import Address, ut, AID;
//DF-27577 Moved DID after AID
in_file := VotersV2.Updated_Voters;

//DF-27577 Added prep address fields
// Transform to Normalize the Mailing Addresses.
// Skip's the normalized mailing records that only contain the mailing city, st and zip populate 
// and are equivalent to resident addr city, st and zip values. or all mailing address parts are
// blank.
VotersV2.Layouts_Voters.Layout_Voters_base_new trfInFile(in_File l, unsigned c) := transform
  ,skip(c = 2 and
	     trim(l.res_city,left,right) = trim(l.mail_city,left,right) and
		   trim(l.res_state,left,right)          = trim(l.mail_state,left,right) and
		   trim(l.res_zip,left,right)         = trim(l.mail_zip,left,right) and
		   trim(l.res_city,left,right) + trim(l.res_zip,left,right) <> '')  	
	self.addr_type := choose(c, '','M');  		 
  self.prep_addr_line1:= if(self.addr_type != 'M',ut.CleanSpacesAndUpper(l.res_Addr1), ut.CleanSpacesAndUpper(l.mail_Addr1));
	self.prep_addr_line_last := if(self.addr_type != 'M',ut.CleanSpacesAndUpper(ut.CleanSpacesAndUpper(L.res_city) + 
																																	IF(L.res_City <> '' and L.res_State <> '', ', ', '') + 
																																	L.res_State + ' ' + IF(LENGTH(L.res_Zip) >= 5, L.res_zip[1..5], '')
																																	),
																																	ut.CleanSpacesAndUpper(ut.CleanSpacesAndUpper(L.mail_city) + 
																																	IF(L.mail_City <> '' and L.mail_State <> '', ', ', '') + 
																																	L.mail_State + ' ' + IF(LENGTH(L.mail_Zip) >= 5, L.mail_zip[1..5], '')
																																	));		
	
	self.title := l.prefix_title;
	self.fname := l.first_name;
	self.mname := l.middle_name;
	self.lname := l.last_name;
	self.name_suffix := l.name_suffix_in;
	self.did := 0;
	self.did_score := 0;
	self.ssn := '';
	self.name_type := '';
	self := l;	
END;

// Normalize the Mailing Addresses 
Infile_Addr_Norm  := NORMALIZE(in_file,
								   if((trim(left.mail_p_city_name,left,right) + trim(left.mail_st,left,right) = '' and
								       (integer)left.mail_ace_zip = 0)  or 
								      (trim(left.prim_range,left,right)  = trim(left.mail_prim_range,left,right) and
									   trim(left.predir,left,right)      = trim(left.mail_predir,left,right) and
								       trim(left.prim_name,left,right)   = trim(left.mail_prim_name,left,right) and									   
								       trim(left.addr_suffix,left,right) = trim(left.mail_addr_suffix,left,right) and
								       trim(left.postdir,left,right)     = trim(left.mail_postdir,left,right) and
								       trim(left.unit_desig,left,right)  = trim(left.mail_unit_desig,left,right) and
								       trim(left.sec_range,left,right)   = trim(left.mail_sec_range,left,right) and
								       trim(left.v_city_name,left,right) = trim(left.mail_v_city_name,left,right) and
								       trim(left.st,left,right)          = trim(left.mail_st,left,right) and
								       trim(left.zip,left,right)         = trim(left.mail_ace_zip,left,right) and
								       trim(left.zip4,left,right)        = trim(left.mail_zip4,left,right)),1,2)								      
								   ,trfInFile(left,counter));
									 
// Transform the Maiden Prior name value
VotersV2.Layouts_Voters.Layout_Voters_base_new trfMaidenPrior(Infile_Addr_Norm l, unsigned c) := transform												 
	self.lname      := choose(c, trim(l.lname,left,right), trim(l.clean_maiden_pri,left,right));
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
baseFile := VotersV2.File_Voters_Base + VotersV2.File_MA_Census_Base : persist('~thor_data400::persist::voters::BaseFile',SINGLE) ;

bothFiles := Infile_Name_Norm + baseFile;

// generating a sequence number for "vtid"
ut.MAC_Sequence_Records(bothFiles,vtid,vtidBothFiles);

Clean_File_filt := vtidBothFiles(prep_addr_line_last <> '');

Clean_file_emty := vtidBothFiles(prep_addr_line_last = '');
									
unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

//Added AID
AID.MacAppendFromRaw_2Line(
                           Clean_File_filt,
				                   prep_addr_line1,       //addr1
				                   prep_addr_line_last,   //addr2													 
													 raw_aid, dwithAID, lFlags);

clean_cache_addr_file := project(dwithAID
			,transform(VotersV2.Layouts_Voters.Layout_Voters_base_new,
			  string2 temp_st := if(trim(left.source_state,right,left) <> '',left.source_state,
	                      if(trim(left.st,left,right) <> '',left.st,left.mail_st));
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
	      self.rid            := if (left.rid = 0, hash64(temp_st, left.vendor_id, left.lname, left.name_suffix, left.fname, left.mname, 
			 				  left.name_type, left.dob, left.addr_type, left.prim_range, left.prim_name, left.predir,
							  left.addr_suffix, left.postdir, left.unit_desig, left.sec_range, left.p_city_name,
							  left.st, left.zip, left.file_acquired_date), left.rid);
	      self.did := 0;
	      self.did_score := 0;
	      self.ssn := '';
				self := left;
			)
		)
		+ project(Clean_file_emty,transform(VotersV2.Layouts_Voters.Layout_Voters_base_new,
		self := left
		,self := []));

clean_cache_file_dist := distribute(clean_cache_addr_file, vtid);

full_norm_file := sort(clean_cache_file_dist, vtid, -process_date, -date_first_seen, addr_type, local);

export Cleaned_Addr_Cache_Base :=  full_norm_file
//uncomment for testing purposes
// : persist(VotersV2.Cluster+'persist::voters::Cleaned_Addr_Cache_Base',SINGLE)
;