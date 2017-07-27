import LiensV2_Services, FFD, BatchShare;

EXPORT batch_make_consumer_statements(dataset(LiensV2_Services.Batch_Layouts.fcra_batch_out_pre) batch_out_pre , 
																			dataset(FFD.Layouts.PersonContextBatch) PersonContext
																			) := function

	
	temp_rec := record
	  // FFD.Layouts.ConsumerStatementBatch.acctno;
	  // FFD.Layouts.ConsumerStatementBatch.SequenceNumber;
		dataset(FFD.Layouts.ConsumerStatementBatch ) Recs;
	end;
	
  temp_rec xform(LiensV2_Services.Batch_Layouts.fcra_batch_out_pre l) := transform
  

      //  Inner transform  
      FFD.Layouts.ConsumerStatementBatch xform_inner(
                          boolean doDispute,
                          FFD.Layouts.StatementIdRec le,
                          string section_id
                          ) :=  transform
        self.acctno 			:=  l.acctno;
        self.SequenceNumber := l.sequence_number;
        self.UniqueId 		:= 0;
        self.DateAdded 		:= 	'';
        self.SectionID 		:= 	section_id;
        self.StatementID	:=	le.statementId;
        self.RecordType := if(doDispute,FFD.Constants.RecordType.DR,FFD.Constants.RecordType.RS);
        self.DataGroup 		:= if(section_id IN ['filing_1','filing_2','filing_3','filing_4','case'],
                                    FFD.Constants.DataGroups.LIEN_MAIN,
                                    FFD.Constants.DataGroups.LIEN_PARTY );
        self.Content   		:=	'';	
      end;	

   		 case_sids :=  project(l.case_statementids,xform_inner(false,left,l.case_section_id)); 
   		 d11_sids  :=  project(l.debtor_1_party_1_statementids,xform_inner(false,left, l.debtor_1_party_1_section_id )); 
   		 d12_sids  :=  project(l.debtor_1_party_2_statementids,xform_inner(false,left, l.debtor_1_party_2_section_id )); 
   		 d21_sids  :=  project(l.debtor_2_party_1_statementids,xform_inner(false,left, l.debtor_2_party_1_section_id )); 
   		 d22_sids  :=  project(l.debtor_2_party_2_statementids,xform_inner(false,left, l.debtor_2_party_2_section_id )); 
   		 d31_sids  :=  project(l.debtor_3_party_1_statementids,xform_inner(false,left, l.debtor_3_party_1_section_id )); 
   		 d32_sids  :=  project(l.debtor_3_party_2_statementids,xform_inner(false,left, l.debtor_3_party_2_section_id )); 
   		 d41_sids  :=  project(l.debtor_4_party_1_statementids,xform_inner(false,left, l.debtor_4_party_1_section_id )); 
   		 d42_sids  :=  project(l.debtor_4_party_2_statementids,xform_inner(false,left, l.debtor_4_party_2_section_id )); 
   		 d51_sids  :=  project(l.debtor_5_party_1_statementids,xform_inner(false,left, l.debtor_5_party_1_section_id )); 
   		 d52_sids  :=  project(l.debtor_5_party_2_statementids,xform_inner(false,left, l.debtor_5_party_2_section_id )); 
   		 d61_sids  :=  project(l.debtor_6_party_1_statementids,xform_inner(false,left, l.debtor_6_party_1_section_id )); 
   		 d62_sids  :=  project(l.debtor_6_party_2_statementids,xform_inner(false,left, l.debtor_6_party_2_section_id )); 
   		 d71_sids  :=  project(l.debtor_7_party_1_statementids,xform_inner(false,left, l.debtor_7_party_1_section_id )); 
   		 d72_sids  :=  project(l.debtor_7_party_2_statementids,xform_inner(false,left, l.debtor_7_party_2_section_id )); 
   		 c_sids   :=	 project(l.creditor_statementids,xform_inner(false,left, l.creditor_section_id )); 
   		 a_sids   :=   project(l.attorney_statementids,xform_inner(false,left, l.attorney_section_id )); 
   		 f1_sids :=  	 project(l.filing_1_statementids,xform_inner(false,left, l.filing_1_section_id )); 
   		 f2_sids :=  	 project(l.filing_2_statementids,xform_inner(false,left, l.filing_2_section_id )); 
   		 f3_sids :=  	 project(l.filing_3_statementids,xform_inner(false,left, l.filing_3_section_id )); 
   		 f4_sids :=  	 project(l.filing_4_statementids,xform_inner(false,left, l.filing_4_section_id )); 
			 
			 case_dispute :=  if(l.case_is_disputed ,row(xform_inner(true,FFD.Constants.BlankStatementid,l.case_section_id))); 
   		 d11_dispute  :=  if(l.debtor_1_party_1_is_disputed,row(xform_inner(true,FFD.Constants.BlankStatementid, l.debtor_1_party_1_section_id ))); 
   		 d12_dispute  :=  if(l.debtor_1_party_2_is_disputed,row(xform_inner(true,FFD.Constants.BlankStatementid, l.debtor_1_party_2_section_id ))); 
   		 d21_dispute  :=  if(l.debtor_2_party_1_is_disputed,row(xform_inner(true,FFD.Constants.BlankStatementid, l.debtor_2_party_1_section_id ))); 
   		 d22_dispute  :=  if(l.debtor_2_party_2_is_disputed,row(xform_inner(true,FFD.Constants.BlankStatementid, l.debtor_2_party_2_section_id ))); 
   		 d31_dispute  :=  if(l.debtor_3_party_1_is_disputed,row(xform_inner(true,FFD.Constants.BlankStatementid, l.debtor_3_party_1_section_id ))); 
   		 d32_dispute  :=  if(l.debtor_3_party_2_is_disputed,row(xform_inner(true,FFD.Constants.BlankStatementid, l.debtor_3_party_2_section_id ))); 
   		 d41_dispute  :=  if(l.debtor_4_party_1_is_disputed,row(xform_inner(true,FFD.Constants.BlankStatementid, l.debtor_4_party_1_section_id ))); 
   		 d42_dispute  :=  if(l.debtor_4_party_2_is_disputed,row(xform_inner(true,FFD.Constants.BlankStatementid, l.debtor_4_party_2_section_id ))); 
   		 d51_dispute  :=  if(l.debtor_5_party_1_is_disputed,row(xform_inner(true,FFD.Constants.BlankStatementid, l.debtor_5_party_1_section_id ))); 
   		 d52_dispute  :=  if(l.debtor_5_party_2_is_disputed,row(xform_inner(true,FFD.Constants.BlankStatementid, l.debtor_5_party_2_section_id ))); 
   		 d61_dispute  :=  if(l.debtor_6_party_1_is_disputed,row(xform_inner(true,FFD.Constants.BlankStatementid, l.debtor_6_party_1_section_id ))); 
   		 d62_dispute  :=  if(l.debtor_6_party_2_is_disputed,row(xform_inner(true,FFD.Constants.BlankStatementid, l.debtor_6_party_2_section_id ))); 
   		 d71_dispute  :=  if(l.debtor_7_party_1_is_disputed,row(xform_inner(true,FFD.Constants.BlankStatementid, l.debtor_7_party_1_section_id ))); 
   		 d72_dispute  :=  if(l.debtor_7_party_2_is_disputed,row(xform_inner(true,FFD.Constants.BlankStatementid, l.debtor_7_party_2_section_id ))); 
   		 c_dispute   :=	  if(l.creditor_is_disputed,row(xform_inner(true,FFD.Constants.BlankStatementid, l.creditor_section_id ))); 
   		 a_dispute   :=   if(l.attorney_is_disputed,row(xform_inner(true,FFD.Constants.BlankStatementid, l.attorney_section_id ))); 
   		 f1_dispute :=  	if(l.filing_1_is_disputed,row(xform_inner(true,FFD.Constants.BlankStatementid, l.filing_1_section_id ))); 
   		 f2_dispute :=  	if(l.filing_2_is_disputed,row(xform_inner(true,FFD.Constants.BlankStatementid, l.filing_2_section_id ))); 
   		 f3_dispute :=  	if(l.filing_3_is_disputed,row(xform_inner(true,FFD.Constants.BlankStatementid, l.filing_3_section_id ))); 
   		 f4_dispute :=  	if(l.filing_4_is_disputed,row(xform_inner(true,FFD.Constants.BlankStatementid, l.filing_4_section_id ))); 
   	 
   		// self.acctno := l.acctno;
			// self.SequenceNumber := l.Sequence_Number;
   		self.Recs 	:= case_sids + c_sids + a_sids + f1_sids + f2_sids + f3_sids + f4_sids +
										 d11_sids +  d21_sids +  d31_sids  +  d41_sids  +  d51_sids + d61_sids + d71_sids + 
										 d12_sids +  d22_sids +  d32_sids  +  d42_sids  +  d52_sids + d62_sids + d72_sids +
										 case_dispute + c_dispute + a_dispute + f1_dispute + f2_dispute + f3_dispute + f4_dispute +
										 d11_dispute +  d21_dispute +  d31_dispute  +  d41_dispute  +  d51_dispute + d61_dispute + d71_dispute + 
										 d12_dispute +  d22_dispute +  d32_dispute  +  d42_dispute  +  d52_dispute + d62_dispute + d72_dispute;

 	end;
	
	out_1 := project(batch_out_pre,xform(left)); 
	
	out := normalize(out_1, LEFT.Recs, transform (FFD.Layouts.ConsumerStatementBatch, 
              												           self := right));
												
	StatementsAndDisputes := FFD.prepareConsumerStatementsBatch(out,PersonContext);
	
/* 	output(batch_out_pre,named('batch_out_pre'));
   	output(statements,named('out'));
*/

  return StatementsAndDisputes;
end;
