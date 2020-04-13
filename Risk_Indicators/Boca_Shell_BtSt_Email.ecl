/*
Used in the BTST shell
Common Email Link - btst_emails_in_common - Number of unique emails in intersection of BT emails and ST emails
Common e-mail Num Free - btst_free_emails_in_common - Number of unique Free emails in intersection of BT emails and ST emails
Common e-mail Num ISP - btst_isp_emails_in_common - Number of unique ISP emails in intersection of BT emails and ST emails
Common e-mail Num EDU - btst_edu_emails_in_common - Number of unique EDU emails in intersection of BT emails and ST emails
Common e-mail Num Corp - btst_corp_emails_in_common - Number of unique Corp emails in intersection of BT emails and ST emails
*/

import email_data, riskwise, risk_indicators, doxie, Suppress;

export Boca_Shell_BtSt_Email(grouped dataset(Risk_Indicators.layout_ciid_btst_Output) input, doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

	email_tmp := record
		unsigned4 bt_seq;	
		unsigned4 st_seq;
		string12 domain_type;
		string200 email;
		integer btst_emails_in_common := 0;
		integer btst_free_emails_in_common := 0;
		integer btst_isp_emails_in_common := 0;
		integer btst_edu_emails_in_common := 0;
		integer btst_corp_emails_in_common := 0;
	end;

    email_tmp_CCPA := RECORD
      unsigned6 did;  //CCPA Changes
      unsigned4 global_sid; //CCPA Changes
			boolean skip_opt_out := false;
      email_tmp;
    END;
    
    getBtStEmailDetails(btStField, btStSeqField, EmailDetailsCount) := FUNCTIONMACRO
	email_tmp_CCPA	email_details(Risk_Indicators.layout_ciid_btst_Output le, email_data.key_did rt, integer c) := transform
        self.did := rt.did;
        self.global_sid := rt.global_sid;
		self.bt_seq := if(c = 1, le.bill_to_output.seq, 0);
		self.st_seq := if(c = 2, le.ship_to_output.seq, 0);	
		self.domain_type := TRIM(rt.append_domain_type);
		self.email := rt.clean_email;
		self := []
	end;

	emails_orig_unsuppressed := join(input, email_data.key_did,
				left.#EXPAND(btStField).did <> 0 and 
				keyed(left.#EXPAND(btStField).did=right.did) and
				right.email_src IN Risk_Indicators.iid_constants.SetEmailSources and
				right.did < Risk_Indicators.iid_constants.EmailFakeIds and // don't include Fake DIDs
				(unsigned)right.date_first_seen[1..6] < left.#EXPAND(btStField).historydate,
			email_details(left, right, EmailDetailsCount), 
				atmost(riskwise.max_atmost), keep(1000), left outer);
                                                  
    emails_orig_flagged := Suppress.CheckSuppression(emails_orig_unsuppressed, mod_access);

	emails_orig := PROJECT(emails_orig_flagged, TRANSFORM(email_tmp, 
		self.domain_type := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.domain_type);
		self.email := IF(left.is_suppressed, Suppress.OptOutMessage('STRING'), left.email);
			SELF := LEFT;
	)); 
                                       
	emails := sort(dedup(emails_orig, #EXPAND(btStSeqField), email), #EXPAND(btStSeqField), email);
  
    RETURN emails;
    
    ENDMACRO;
    
    bt_emails := getBtStEmailDetails('bill_to_output', 'bt_seq', 1);
    st_emails := getBtStEmailDetails('ship_to_output', 'st_seq', 2);

	email_tmp email_combo(email_tmp l, email_tmp r) := transform	
		self.bt_seq := l.bt_seq;
		self.btst_emails_in_common := if(l.email <>'' and r.email <>'' and l.email = r.email, 1, 0);
		self.btst_free_emails_in_common := if(l.domain_type = 'FREE' and r.domain_type = 'FREE' and l.email = r.email, 1, 0);
		self.btst_isp_emails_in_common := if(l.domain_type = 'ISP' and r.domain_type = 'ISP' and l.email = r.email, 1, 0);
		self.btst_edu_emails_in_common := if(l.domain_type = 'EDU' and r.domain_type = 'EDU' and l.email = r.email, 1, 0);
		self.btst_corp_emails_in_common := if(l.domain_type = 'CORP' and r.domain_type = 'CORP' and l.email = r.email, 1, 0);
		self.st_seq := r.st_seq;
		self.domain_type := '';
		self.email := '';
		self := [];
	end;
  
	btst_email_combo_tmp :=	join(bt_emails, st_emails, 
		left.bt_seq = right.st_seq -1,
		email_combo(left, right),
		atmost(riskwise.max_atmost), 
		keep(1000),
		left outer);

	btst_email_combo := join(input, btst_email_combo_tmp,
		left.bill_to_output.seq = right.bt_seq,
		transform(right),
		left outer);

	btst_common_emails_grpd := group(sort(btst_email_combo, bt_seq, -btst_emails_in_common, 
		-btst_free_emails_in_common ), bt_seq);

	email_tmp rollCommonEmails(email_tmp l, email_tmp r) := transform
		self.btst_emails_in_common := l.btst_emails_in_common + r.btst_emails_in_common;
		self.btst_free_emails_in_common := l.btst_free_emails_in_common + r.btst_free_emails_in_common;
		self.btst_isp_emails_in_common := l.btst_isp_emails_in_common + r.btst_isp_emails_in_common;
		self.btst_edu_emails_in_common := l.btst_edu_emails_in_common + r.btst_edu_emails_in_common;
		self.btst_corp_emails_in_common := l.btst_corp_emails_in_common + r.btst_corp_emails_in_common;
		self := l;
	end;
	btst_common_emails_rolled := rollup(btst_common_emails_grpd, left.bt_seq = right.bt_seq, rollCommonEmails(left, right));

		// //outputs for debugging
		// output(bt_emails, named('bt_emails'));
		// output(st_emails, named('st_emails'));
		// output(btst_email_combo, named('btst_email_combo'));
		// output(btst_common_emails_grpd, named('btst_common_emails_grpd'));
		// output(btst_common_emails_rolled, named('btst_common_emails_rolled'));
	
	return btst_common_emails_rolled;
end;