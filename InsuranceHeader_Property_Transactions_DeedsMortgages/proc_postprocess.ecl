EXPORT proc_postprocess (string pversion, string iter, dataset(layout_property_transaction) raw_inDS = files(pversion,iter).salt_output_qa) := FUNCTION

inDS := distribute(raw_inDS,hash(dproptxid));

//Clusters with more than 100 records
trec := record
  inDS.dproptxid;
	cnt := count(group);
end;
LargeClusters := table(sort(inDS,dproptxid,local),trec,dproptxid,local)(cnt>100);

//Merge with prior filter files
LargeFares  := join(inDS,LargeClusters,left.dproptxid=right.dproptxid,transform(layout_fidrec,self:=left),local);

//Reset the IDs for Large Clusters
ResetIDs  := join(distribute(inDS,hash(ln_fares_id)),distribute(LargeFares,hash(ln_fares_id)),
                  left.ln_fares_id=right.ln_fares_id,
									transform(recordof(left),
									          self.dproptxid := IF(left.ln_fares_id=right.ln_fares_id,left.rid,left.dproptxid),
														self := left), left outer, local);

FullFile := distribute(ResetIDs,hash(dproptxid));

/* Append best Flags Source A = Fares (Corelogic) Source B = Black Knight
   Supress  := S 
   Display  := D
   Collapse := C
*/ 
slimrec := RECORD
  FullFile.rid;
  FullFile.dproptxid;	
	FullFile.ln_fares_id;
	FullFile.recording_date;
	FullFile.document_number;
	FullFile.recorder_book_number;
	FullFile.recorder_page_number;
	FullFile.contract_date;
	FullFile.sales_price;
	FullFile.first_td_loan_amount;
	FullFile.lender_name;
	FullFile.document_type_code;
	string1 source_code_1;
	unsigned2 pop_cnt;
	string1 best_dproptx_ind := '';
	unsigned4 lender_name_length;
	unsigned6 rid1;
	unsigned6 rid2;
end;

slimDS := project(FullFile,
                  transform(slimrec,
									          self.pop_cnt := IF(left.contract_date>'0',1,0)        +
														                IF(left.sales_price>'0',1,0)          +
																						IF(left.first_td_loan_amount>'0',1,0) +
																						IF(left.lender_name<>'',1,0)          +
																						IF(left.document_type_code<>'',1,0)   +
																						IF(left.recording_date>'0',1,0),
                            self.lender_name_length := length(left.lender_name),
														self.source_code_1      := IF(left.ln_fares_id[1]='R','A','B'),
														self.best_dproptx_ind   := 'S',
														self.rid1 := [], self.rid2:=[],
														self:=left));

slimAs    := slimDS(source_code_1='A');
dedupAs   := dedup(sort(slimAs,dproptxid,-pop_cnt,lender_name_length,local),dproptxid,local);
remainAs  := join(slimAs,dedupAs,left.dproptxid=right.dproptxid AND left.rid = right.rid, left only, local);                        

slimBs    := slimDS(source_code_1='B');
dedupBS   := dedup(sort(slimBs,dproptxid,-pop_cnt,lender_name_length,local),dproptxid,local);
remainBs  := join(slimBs,dedupBs,left.dproptxid=right.dproptxid AND left.rid = right.rid, left only, local);
 
bestABs   := dedup(sort(dedupAs + dedupBS,dproptxid,-pop_cnt,-source_code_1,lender_name_length,local),dproptxid,local);
taggedABs := project(bestABs,transform(recordof(left),self.best_dproptx_ind := 'D', self := left));
worseABs  := join(dedupAs + dedupBS,bestABs,
                  left.dproptxid = right.dproptxid,
								  transform(recordof(left),
								            self.best_dproptx_ind := 'C',
														self.rid1 := left.rid,
														self.rid2 := right.rid,
								            self := left),local)(rid1<>rid2);

result := join(FullFile,remainAs + remainBs + taggedABs + worseABs,
               left.dproptxid = right.dproptxid AND
							 left.rid       = right.rid,
							 transform(layout_property_transaction_out,
							           self.best_dproptx_ind := right.best_dproptx_ind,
												 self := left),left outer, local);

CreateLargecluster := output(if(NOTHOR(fileservices.superfileexists(files(pversion).large_filename_qa)),
                      DEDUP(files(pversion).large_qa + LargeFares,ln_fares_id,ALL),
					            LargeFares),,files(pversion).large_filename,overwrite,compressed);
          
final := output(result,,files(pversion).post_filename,overwrite,compressed); 

updateSF := sequential(
                       FileServices.PromoteSuperFileList([files(pversion).large_filename_qa,files(pversion).large_filename_father], files(pversion).large_filename),
                       FileServices.PromoteSuperFileList([files(pversion).post_filename_qa,files(pversion).post_filename_father], files(pversion).post_filename));
            
RETURN sequential(CreateLargecluster,final,updateSF);
END;