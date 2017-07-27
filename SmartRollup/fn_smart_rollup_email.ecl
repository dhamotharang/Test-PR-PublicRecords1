IMPORT iesp, codes;
export fn_smart_rollup_email(DATASET(iesp.emailsearch.t_EmailSearchRecord) inRecs) := function

	emailOnlyRec := record
     iesp.emailsearch.t_EmailSearchRecord - Emails;
	   dataset(iesp.emailsearch.t_EmailSearchEmail) emails;
	   boolean isRoyalty;
  end;
	
	emailOnlyRec makeEmails(inRecs l, iesp.emailsearch.t_EmailSearchEmail r) := transform
	  self.isRoyalty := l.source in set(codes.Key_Codes_V3(file_name = 'EMAIL_SOURCES', field_name = 'ROYALTY'), code);
		self.emails := r;
		self := l;
	end;

	normalRecs := normalize(inRecs, left.Emails, makeEmails(left,right));
  
	sNormalRecs := sort(normalRecs, emails[1].emailaddress , isRoyalty);
	rNormalRecs := dedup(sNormalRecs, emails[1].emailaddress);
	
	rNormalRecs loadit(rNormalRecs l,rNormalRecs r) := transform
		self.emails := l.emails + r.emails;
		self := l;
	end;
	
	srNormalRecs := sort(rnormalRecs, source);
	dRecs := rollup(srnormalRecs,loadit(left, right), source);
	
	outRecs := project(dRecs, transform(iesp.emailsearch.t_EmailSearchRecord,
																						 self.emails := choosen(left.emails, iesp.Constants.Email.MAX_EMAILS_PER_PERSON),
																						 self := left));
	RETURN outRecs;
end;