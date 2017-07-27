
IMPORT BatchShare, Experian_Phones, Royalty;

EXPORT layouts := MODULE

	EXPORT batch_in := RECORD
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDid;
		BatchShare.Layouts.SharePII; // i.e. ssn (no dashes), dob
		BatchShare.Layouts.ShareName;
		BatchShare.Layouts.ShareAddress;
		STRING10 phone1  := '';
		STRING10 phone2  := '';
		STRING10 phone3  := '';
		STRING10 phone4  := '';
		STRING10 phone5  := '';
		STRING10 phone6  := '';
		STRING10 phone7  := '';
		STRING10 phone8  := '';
		STRING10 phone9  := '';
		STRING10 phone10 := '';
		STRING10 phone11 := '';
		STRING10 phone12 := '';
		STRING10 phone13 := '';
		STRING10 phone14 := '';
		STRING10 phone15 := '';
		STRING10 phone16 := '';
		STRING10 phone17 := '';
		STRING10 phone18 := '';
		STRING10 phone19 := '';
		STRING10 phone20 := '';
		STRING10 phone21 := '';
		STRING10 phone22 := '';
		STRING10 phone23 := '';
		STRING10 phone24 := '';
		STRING10 phone25 := '';
	END;

	EXPORT batch_in_plus := RECORD(batch_in)
		STRING20	orig_acctno 	:= ''; // [internal]
		Batchshare.Layouts.ShareErrors;	
	END;
	
	EXPORT acctno_plus_Experian_Phones := RECORD
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDid;
		Batchshare.Layouts.ShareErrors;
		Experian_Phones.Layouts.base AND NOT did;
	END;
				
	EXPORT batch_out := RECORD // essentially progressive_phone.layout_progressive_batch_out_with_fb
		BatchShare.Layouts.ShareAcct; 
		STRING20  subj_first                   := ''; 
		STRING20  subj_middle                  := ''; 
		STRING20  subj_last                    := ''; 
		STRING5   subj_suffix                  := ''; 
		STRING10  subj_phone10                 := ''; 
		STRING3   subj_phone10_score           := ''; 
		STRING120 subj_name_dual               := ''; 
		STRING20  subj_phone_relationship      := ''; 
		STRING2   subj_phone_type              := ''; 
		STRING6   subj_date_first              := ''; 
		STRING6   subj_date_last               := ''; 
		STRING3   phpl_phones_plus_type        := ''; 
		STRING30  phpl_phone_carrier           := ''; 
		STRING25  phpl_carrier_city            := ''; 
		STRING2   phpl_carrier_state           := ''; 
		STRING2   subj_phone_type_new          := ''; 
		STRING1   subj_phone_duplicate_flag    := ''; 
		STRING1   switch_type                  := ''; 
		STRING8   phone_feedback_date          := ''; 
		STRING1   phone_feedback_result        := ''; 
		STRING20  phone_feedback_first         := ''; 
		STRING20  phone_feedback_middle        := ''; 
		STRING20  phone_feedback_last          := ''; 
		STRING8   phone_feedback_last_rpc_date := ''; 
		Batchshare.Layouts.ShareErrors;
		Royalty.Layouts.Royalty.royalty_type;
		Royalty.Layouts.RoyaltySrc.royalty_src;
	END;
	
	EXPORT batch_out_plus := RECORD(batch_out)
		STRING20	orig_acctno := ''; // [internal]
		BatchShare.Layouts.ShareDid;
	END;
END;