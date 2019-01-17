import progressive_phone, doxie, header, AddrBest;
export fn_addSSN(dataset(progressive_phone.layout_progressive_batch_out_with_did) f_out) := function

set of STRING1 daily_autokey_skipset:=[];

ssn_rec := record
		doxie.Layout_presentation.ssn;
end;

// Note: using factual permissions, instead of hardcoded used in doxie.mod_header_records before.
mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule());

rec_acct_rna := record
		progressive_phone.layout_progressive_batch_out_with_did.acctno;
  	boolean checkRNA;
end;

ssn_header_rec := record
		// progressive_phone.layout_progressive_batch_out_with_did.acctno;
	  rec_acct_rna;
		doxie.Layout_presentation.did;
		dataset(ssn_rec) SSNRec;
end;

ssn_header_rec addRNACheck(f_out L) := transform
	self.acctno := L.acctno;
	self.checkRNA := (l.subj_phone_type_new in AddrBest.Constants.RNASet or l.did <> l.p_did);
	self.did := L.p_did; //assign p_did as the did for fetching header records below
	self.SSNRec := [];
end;

// ug_f_out := ungroup(f_out);
p_dids_extended := dedup(sort(project(f_out, addRNACheck(left))(did <> 0), //we are not interested in p_dids = 0
																											acctno, did, checkRNA), 
																											acctno, did, checkRNA);

/*--- Fetch SSN Info for p_did from doxie.mod_header_records ---*/
p_dids := dedup(sort(project(p_dids_extended, transform(doxie.layout_references_hh, 
																	self.did := left.did, 
																	self.includedByHHID := false)), did), did);

header_recs := doxie.mod_header_records(true, 
																				daily_autokey_skipset := daily_autokey_skipset,
                                        modAccess := mod_access 
																				).results(p_dids);


/*--- Determine and Clean RNA record ---*/
header_rnaCheck := record
	rec_acct_rna;
	header_recs;
end;

header_rnaCheck addCheckRNA(header_recs L, p_dids_extended R):= transform
	self.acctno := R.acctno;
	self.checkRNA := R.checkRNA;
	self := L; //rest is header_recs;
end;

header_recs_RNA := join(header_recs, p_dids_extended, 
												left.did = right.did, 
												addCheckRNA(left, right), 
												limit(1000, skip));	//there might be same p_did in different accounts
header_recs_checkRNA := header_recs_RNA(checkRNA = true);
 // output(header_recs_CheckRNA, named('header_recs_CheckRNA'));

// doxie.MAC_Header_Field_Declare();
header.MAC_GLB_DPPA_Clean_RNA(header_recs_checkRNA, CheckRNA_rec_applied, mod_access);
 // output(CheckRNA_rec_applied, named('CheckRNA_rec_applied'));
cleaned_header_recs := dedup(sort(header_recs_RNA(checkRna = false) + CheckRNA_rec_applied, acctno, did, ssn), acctno, did, ssn);
// output(cleaned_header_recs, named('cleaned_header_recs'));

grouped_header_recs := group(cleaned_header_recs, acctno, did);
dedup_header_recs := dedup(dedup(sort(grouped_header_recs, ssn), 
																									ssn), // dedup by SSN within the group
																									acctno,did, keep(9));		//keep only 9 ssns based on previous version	
				
/*--- Format SSN Info ---*/
ssn_header_rec RollHeader(dedup_header_recs L, dataset(recordof(dedup_header_recs)) R) := transform
	self.SSNRec := project(R,transform(ssn_rec,self:=left));
	self.did := L.did;
	self.acctno := L.acctno;
	self.checkRna := L.checkRNA;
end;

header_recs_w_ssn := rollup(dedup_header_recs, group, RollHeader(left,rows(left)));
return header_recs_w_ssn;
end;
