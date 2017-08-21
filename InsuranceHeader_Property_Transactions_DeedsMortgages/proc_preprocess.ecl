IMPORT  ut,LN_PropertyV2;

EXPORT proc_preprocess(
string pVersion
,dataset(LN_PropertyV2.Layout_DID_Out			)       pSearch  		                            = LN_PropertyV2.File_Search_DID
,dataset(LN_PropertyV2.Layouts.layout_deed_mortgage_common_model_base_scrubs	) pDeed		  = LN_PropertyV2.Files.Base.DeedMortgage	

) := 
FUNCTION	

prior_linking_file := files(pversion).salt_output_qa;												 
large_cluster_file := files(pversion).large_qa;
												
//allow BP for mortgage records , OP for Deeds 
search_slim := project(pSearch(source_code IN ['OP','BP']),
                                   transform(layout_slimrec,
                                             self.did      := IF(left.did=0,left.bdid,left.did),
										                         self.nameasis := IF(left.did=0,left.nameasis,left.lname),
                                             self.city     := left.p_city_name,
											                       self:=left,self:=[]));

merged := join(search_slim,pDeed,
					 left.ln_fares_id = right.ln_fares_id,
					 transform(recordof(left),
                     badlist                      := ['NOT PROVIDED'];
                     clean_apn (string apn)       := IF(apn in badlist,'',apn);				           
										 self.fares_unformatted_apn   := clean_apn(right.fares_unformatted_apn),
					           self.contract_date        := right.contract_date,
                     self.recording_date       := right.recording_date,
                     self.document_number      := right.document_number,
                     self.document_type_code   := right.document_type_code,
                     self.recorder_book_number := right.recorder_book_number,
                     self.recorder_page_number := right.recorder_page_number,
                     self.sales_price          := right.sales_price,
                     self.first_td_loan_amount := right.first_td_loan_amount,
                     self.lender_name          := right.lender_name,
										 self.fips_code            := right.fips_code,
										 self.state                := right.state,
										 self.county_name          := right.county_name,
										 self := left), hash);									 


merged_dd := dedup(sort(distribute(merged,hash(ln_fares_id)),ln_fares_id,local),ln_fares_id,local);

//Split fields by alpha / numeric to enhance matching in SALT
numbers_only (string str)        := TRIM(REGEXREPLACE('[^0-9]', REGEXREPLACE('-',str,' '),' '),left,right);
compress_spaces_num (string str) := TRIM(REGEXREPLACE('[ ]+',numbers_only(str) ,' '),left,right);
compress_spaces_all (string str) := TRIM(REGEXREPLACE('[ ]+',str ,' '),left,right);
no_numbers   (string str)        := compress_spaces_all(REGEXREPLACE('[0-9]', str, ''));

result := project(merged_dd,
                      transform(layout_property_transaction,
                                self.did              := left.did;																
																self.rid              := (unsigned6) (MAP(left.ln_fares_id[1..2] = 'DD' => '11',
																                                          left.ln_fares_id[1..2] = 'DM' => '12',
																														              left.ln_fares_id[1..2] = 'OD' => '21',
																														              left.ln_fares_id[1..2] = 'OM' => '22',
                                                                          left.ln_fares_id[1..2] = 'RD' => '31',
																														             '32') + (string10) left.ln_fares_id[3..]);
																self.dproptxid         := self.rid;
																self.SEC_RANGE_alpha  := no_numbers(left.sec_range);
												        self.SEC_RANGE_num    := numbers_only(left.sec_range);
												        self.PRIM_RANGE_alpha := no_numbers(left.prim_range);
																primRangeNumNoSpace   := compress_spaces_num(left.prim_range);
												        self.PRIM_RANGE_num   := IF((integer) primRangeNumNoSpace>0,primRangeNumNoSpace,'');
												        self.PRIM_NAME_alpha  := no_numbers(left.prim_name);
                                primNameNumNoSpace    := compress_spaces_num(left.prim_name);											        
																self.PRIM_NAME_num    := IF((integer) primNameNumNoSpace>0,primNameNumNoSpace,'');
                                self.name             := left.nameasis;
																self.document_number  := compress_spaces_num(left.document_number);
                                self.apnt_or_pin_number   := left.fares_unformatted_apn;  
                                self.SourceType           := IF(left.ln_fares_id[2] = 'D' ,'DEED','MORT');
																self := left));

field_filters := result((document_number<>'' OR (recorder_book_number<>'' AND recorder_page_number<>'')) AND
                         prim_range_num<>'' AND prim_name_alpha<>'' AND zip<>'' AND		
									       recording_date<>'');
												 
fid_filters  := join(field_filters,large_cluster_file,
                     left.ln_fares_id = right.ln_fares_id,
										 left only, hash);

AddPriorLinks := join(fid_filters,prior_linking_file,
                   left.rid = right.rid,
									 transform(recordof(left),
									           self.dproptxid := IF(left.rid=right.rid,right.dproptxid,left.dproptxid),
														 self := left), left outer, hash);

CreatePrefull := output(result,,files(pversion).pre_full_filename,overwrite,compressed);
copyfile      := output(AddPriorLinks,,files(pversion).salt_input_filename,compressed,overwrite);

createSF := sequential(if( not NOTHOR(fileservices.superfileexists(files(pversion).salt_input_filename_qa)),
														   NOTHOR(sequential(fileservices.createsuperfile(files(pversion).salt_input_filename_qa),
														          fileservices.createsuperfile(files(pversion).salt_input_filename_father)))),
											 if( not NOTHOR(fileservices.superfileexists(files(pversion).pre_full_filename_qa)),
													     NOTHOR(sequential(fileservices.createsuperfile(files(pversion).pre_full_filename_qa),
														          fileservices.createsuperfile(files(pversion).pre_full_filename_father)))),
                       if( not NOTHOR(fileservices.superfileexists(files(pversion).large_filename_qa)),
														   NOTHOR(sequential(fileservices.createsuperfile(files(pversion).large_filename_qa),
														          fileservices.createsuperfile(files(pversion).large_filename_father)))),
											 if( not NOTHOR(fileservices.superfileexists(files(pversion).post_filename_qa)),
														   NOTHOR(sequential(fileservices.createsuperfile(files(pversion).post_filename_qa),
														           fileservices.createsuperfile(files(pversion).post_filename_father))))              
                                      );
updateSF := sequential(
                        FileServices.PromoteSuperFileList([files(pversion).salt_input_filename_qa,files(pversion).salt_input_filename_father], files(pversion).salt_input_filename),
												FileServices.PromoteSuperFileList([files(pversion).pre_full_filename_qa,files(pversion).pre_full_filename_father], files(pversion).pre_full_filename));

return sequential(createSF,CreatePrefull,Copyfile,UpdateSF);
end;