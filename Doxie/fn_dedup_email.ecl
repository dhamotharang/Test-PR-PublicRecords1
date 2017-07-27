IMPORT EmailService, codes, Suppress;
EXPORT fn_dedup_email(Dataset(doxie.layout_references) dids,
  string6 ssn_mask = '', string32 appType = Suppress.Constants.ApplicationTypes.DEFAULT) := FUNCTION
 
  inRecs := doxie.email_records(dids,ssn_mask,appType);
	
  in_Layout_w_seq := record
	  integer seq;
	  EmailService.Assorted_Layouts.layout_report_rollup;
	end;
	
	inrecs_w_seq := project(inRecs,transform(in_Layout_w_seq, self.seq:= counter, self := left));
	
	email_Only_Rec := record
	   integer seq;
     EmailService.Assorted_Layouts.layout_emails;
	   boolean isRoyalty;
  end;
	
	set_royalty := set(codes.Key_Codes_V3(file_name = 'EMAIL_SOURCES', field_name = 'ROYALTY'), code);
	
	email_Only_Rec makeEmails(inrecs_w_seq l,EmailService.Assorted_Layouts.layout_emails r) := transform
	  self.seq := l.seq;
	  self.isRoyalty := l.src in set_royalty ;
		self := r;
	end;

	normal_Recs := normalize(inrecs_w_seq, left.emails, makeEmails(left,right));     
 
  snormal_Recs := sort(normal_Recs, orig_email , isRoyalty); // to return non-royalty on top
	rnormal_Recs := dedup(snormal_Recs, orig_email); // returns unique email ID's
	
	EmailService.Assorted_Layouts.layout_report_rollup add_emails(in_Layout_w_seq L, dataset(email_Only_Rec) R) := transform
			self.emails := project(R, transform(EmailService.Assorted_Layouts.layout_emails, self := left));
			self := L;
	end;

	denormed_Recs := denormalize(inrecs_w_seq, rnormal_Recs, left.seq = right.seq, group, add_emails(left,rows(right)));
	denorm_Recs_final := denormed_recs(exists(emails));
	
	outRecs := if(count(inRecs.Emails) > 1, denorm_Recs_final, inRecs);

	RETURN outRecs;
end;