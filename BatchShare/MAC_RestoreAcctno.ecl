
// Use to restore original acctno, after BatchShare.MAC_SequenceInputRecords()
// IMPORTANT: [inputf] is supposed to have all records from the input,
//            whereas [outf] may contain only records for which results were found


// See Standard/Errors for errors description.
// These errors are generally internal and can be cahnged from time to time; 
//   they are not supposed to be exposed to the end customer.
// Batch developer can introduce his/her own errors, as long as they are bit-wise and not used in Standard/Errors


export MAC_RestoreAcctno(inputf, outf, outf_res, preserve_accounts = true, propagate_errors = true) := macro
  // search errors can exists in both [inputf], [outf], whereas address cleaner errors 
  // typicall would be in [inputf] only (after standard processing is called)

	outf_res	:= 
#if(preserve_accounts)
		join(inputf, outf,
				 left.acctno = right.acctno,
				 transform(recordof(outf), self.acctno := left.orig_acctno, 
#if(propagate_errors)				 
                                    self.err_search := right.err_search | left.err_search,
                                    self.err_addr := left.err_addr,
#end																		
                                    self := right),
				 left outer);
#else
// note a different order of datasets in hte join
		join(outf, inputf,
				 left.acctno = right.acctno,
				 transform(recordof(outf), self.acctno := right.orig_acctno, 
#if(propagate_errors)					 
                                    self.err_search := right.err_search | left.err_search,
                                    self.err_addr := right.err_addr,
#end																		
                                    self := left),
				 keep (1), limit (0));
#end
endmacro;