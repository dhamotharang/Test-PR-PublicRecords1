import ut, Business_Header, Business_Header_SS, did_add, AID, Address, idl_header;

export Clean_FDIC (string filedate,
									 dataset(Layouts_FDIC.Base_AID) pPrevbase = govdata.File_FDIC_Base_AID
									 ):= function
									
	File_in 					:= govdata.Mapping_FDIC(filedate);
	File_base					:= pPrevBase;

	File_Combined			:=	File_in + File_base;

	HasAddress				:=	trim(File_Combined.prep_addr_line1, left,right) != '' and 
												trim(File_Combined.prep_addr_last_line, left,right) != '';
										
	dWith_address			:= File_Combined(HasAddress);
	dWithout_address	:= File_Combined(not(HasAddress));

	unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

	AID.MacAppendFromRaw_2Line(dWith_address, prep_addr_line1, prep_addr_last_line, Append_RawAID, dwithAID, lFlags);
		
	dBase := project(dwithAID,transform(
																				govdata.Layouts_FDIC.Base_AID,
																				self.Append_ACEAID		:= left.aidwork_acecache.aid;
																				self.Append_RawAID		:= left.aidwork_rawaid;
																				self.zip							:= left.aidwork_acecache.zip5;
																				self									:= left.aidwork_acecache;
																				self									:= left;
																			)
									) + dWithout_address ;
									
	 ds_sort_base						:= sort(dBase, RECORD, EXCEPT process_date,source_rec_id);
	 
	 govdata.Layouts_FDIC.Base_AID   rollupXform(govdata.Layouts_FDIC.Base_AID  l, govdata.Layouts_FDIC.Base_AID  r) := transform
			self.process_date  	:= (STRING)ut.LatestDate((INTEGER)l.process_date,(INTEGER)r.process_date);
			self.source_rec_id	:= if(l.source_rec_id <> 0,l.source_rec_id,r.source_rec_id);
			self 								:= l;
	 end;

	 New_Rollup_Base 				:= rollup(ds_sort_base, rollupXform(LEFT,RIGHT), RECORD,EXCEPT process_date,source_rec_id): persist('~thor_data400::persist::govdata::FDIC::Clean');
	 return New_Rollup_Base;

end;