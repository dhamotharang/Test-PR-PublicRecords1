IMPORT iesp,EmailV2_Services,Royalty,Gateway,STD;
EXPORT getEmailInfo(dataset (MemberPoint.Layouts.BestExtended) dsBestE,
									MemberPoint.IParam.BatchParams InputParams) := function

	IsPremiumEmail:=inputparams.useDMEmailSourcesOnly=false;
	Email_v2_ServiceBatchParams := MODULE(project(InputParams, emailV2_Services.IParams.BatchParams, opt))
		EXPORT STRING    SearchType:= MemberPoint.Constants.emailv2search.searchtype;
		EXPORT STRING    SearchTier:= if(IsPremiumEmail,Memberpoint.Constants.defaults.Emailv2servicePremium,Memberpoint.Constants.defaults.Emailv2serviceBasic);
		EXPORT STRING    RestrictedUseCase:=if(IsPremiumEmail,Memberpoint.Constants.defaults.Standard,Memberpoint.Constants.defaults.NoRoyaltySources);
		EXPORT BOOLEAN   CheckEmailDeliverable:=IsPremiumEmail;
		EXPORT UNSIGNED8 MaxResultsPerAcct:= 15;
		EXPORT BOOLEAN   IncludeAdditionalInfo := FALSE;
		EXPORT BOOLEAN   KeepUndeliverableEmail := TRUE;
		EXPORT STRING    BVAPIkey := EmailV2_Services.Constants.GatewayValues.BVAPIkey;
		EXPORT DATASET   (Gateway.Layouts.Config) gateways := Gateway.Configuration.Get();
	END;

	Emailv2serviceBatchIn := project(dsBestE,transform(EmailV2_Services.Layouts.batch_in_rec,
		self.acctno := (string) left.seq,
		self.did    := left.did,
		self        := [];));

	Email_v2_EAAResult := EmailV2_Services.EmailAddressAppendSearch(Emailv2serviceBatchIn,email_v2_servicebatchparams,false);

	Emailv2EAA := project(Email_v2_EAAResult.Records,
						transform(memberpoint.Layouts.EmailRecforv2,
							self.acctno        := left.acctno;
							self.ln_date_first := (integer)left.ln_date_first;
							self.ln_date_last  := (integer)left.ln_date_last;
							self.did           := left.did;
							self.orig_email    := left.cleaned.clean_email;
							self               := left;
							self               := [];));

	Emailv2EAAjoined := join(Emailv2EAA,dsBestE,
						left.did=right.did,
						transform(memberpoint.Layouts.EmailRecInvalidforV2,
						self.input_email_invalid := if(STD.Str.ToUpperCase(trim(right.input_email,left,right))=STD.Str.ToUpperCase(trim(left.orig_email,left,right))
													,left.email_status,'');
						self.input_email_invalid_reason := if(STD.Str.ToUpperCase(trim(right.input_email,left,right))=STD.Str.ToUpperCase(trim(left.orig_email,left,right))
													,left.email_status_reason,'');
						self.acctno := left.acctno;
						self := left;
						self := [];));

	srtd_recs := GROUP(SORT(Email_v2_EAAResult.records, acctno, -date_last_seen, date_first_seen, -original.login_date, -process_date, RECORD), acctno);
	//IN HOUSE ROYALTIES
	inh_royalties := Royalty.RoyaltyEmail.GetBatchRoyaltySet(srtd_recs, email_src, InputParams.MaxResultsPerAcct, InputParams.ReturnDetailedRoyalties);
	dsEmail := dataset([{UNGROUP(TOPN(GROUP(Emailv2EAA(STD.Str.ToUpperCase(trim(email_status,left,right))!='INVALID'), acctno), 10, acctno)),
					Emailv2EAAjoined(input_email_invalid!=''),
					inh_royalties+Email_v2_EaaResult.Royalties}],
					MemberPoint.Layouts.EmailRec);

	return dsEmail;
end;



