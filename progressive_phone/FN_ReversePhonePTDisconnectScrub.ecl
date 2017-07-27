IMPORT PhonesFeedback, ut;

EXPORT FN_ReversePhonePTDisconnectScrub(DATASET(layout_reverse_phone_pt_disconnect_scrub_in) phoneList) := FUNCTION
	fbk := PhonesFeedback.Key_PhonesFeedback_phone;

	in_x := RECORD
		STRING30	acctno;
		STRING10	phone_number;
	END;

	in_x cleanup(layout_reverse_phone_pt_disconnect_scrub_in input) := TRANSFORM
		STRING cleaned := REGEXREPLACE('\\D', input.phone_number, '');

		SELF.phone_number := IF(LENGTH(cleaned) = 10, cleaned, '');
		SELF := input;
	END;

	layout_reverse_phone_pt_disconnect_scrub_out toOut(in_x l, fbk r) := TRANSFORM
		SELF.name_first := r.fname;
		SELF.name_middle := r.mname;
		SELF.name_last := r.lname;
		SELF.phone_feedback_date := ut.cnvDateStr(r.date_time_added);
		SELF.phone_feedback_result := (UNSIGNED1) TRIM(r.phone_contact_type);
		SELF := r;
		SELF := l;
	END;

	phoneList_c := PROJECT(phoneList, cleanup(LEFT))(phone_number <> '');
	o := JOIN(phoneList_c, fbk,
						KEYED(LEFT.phone_number = RIGHT.phone_number) AND
						(UNSIGNED1) TRIM(RIGHT.phone_contact_type) in  [1,2,3,4],
						toOut(LEFT, RIGHT), LIMIT(10000, SKIP));
	o_sd := DEDUP(SORT(o, acctno, phone_number, -phone_feedback_date,phone_feedback_result), acctno, phone_number, phone_feedback_date);
	RETURN o_sd;
END;
/* contact_type
  1 = Right Party Contact
  2 = Relative or Associate Right Party Contact
  3 = Potential Wrong Party Claim
  4 = Potential Temporary Disconnect
*/