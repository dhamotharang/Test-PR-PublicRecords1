
import ut,iesp,PhonesFeedback;

export Functions := module
	shared string35 contact_type_description(string type_code) := map(
		type_code = '1'=>'Right Party Contact',
		type_code = '2'=>'Relative Or Associate Contact',
		type_code = '3'=>'Wrong Party Claim',
		type_code = '4'=>'Phone Disconnected',
		type_code = '5'=>'No Contact Or Knowledge of Debtor',
		type_code = '7'=>'Alternate Phone entered',
		type_code = '8'=>'Other info entered',
		'');
	
	
 	export string30 feedback_src_description(string feedback_src_code) := map(
		feedback_src_code = '1'=>'Person Search',
		feedback_src_code = '2'=>'Advanced Person/Deep Skip Search',
		feedback_src_code = '3'=>'Phones Plus',
		feedback_src_code = '4'=>'Phones Basic Lookup',
		feedback_src_code = '5'=>'Phones Reverse Lookup',
		'');
		
	shared valid_date(string DatetoCheck):= if(length(DatetoCheck)=8 AND
		                                            ((Integer)(DatetoCheck[1..4]) >= 1900) And
                                                ((Integer)(DatetoCheck[5..6]) Between 1 And 12) And            
                                                ((Integer)(DatetoCheck[7..8]) Between 1 And 31),DatetoCheck,'');
		
	// the only purpose is to get a date as YYYYMMDD (this actually better to be be done at a build time)
	shared PhonesFeedback_Services.Layouts.rec_fmt_layout add_std_date (Layouts.Layout_PhonesFeedback_base l):=transform
			// sort of a hack: evaluate only yyyymmdd, ignoring everything else
			c2:=stringlib.stringfind (l.date_time_added,':',1);
			s1:=trim (l.date_time_added[1..(c2-3)]);
			s2:=PhonesFeedback_Services.CleanDate(s1);

			self.fmt_date:=(integer) valid_date(s2);
			self:=l;
	end;

	
	export fnSearchVal(dataset(Layouts.Layout_PhonesFeedback_base) Phone_recs_tmp) := function

		Phone_recs := project (Phone_recs_tmp, add_std_date (Left));

		// takes the latest of all feedbacks, calculates when its phone number was confirmed the last time
		// "confirmed" means either 'Right Party Contact' or 'Relative Or Associate Contact'
		feedback_Report (dataset(PhonesFeedback_Services.Layouts.rec_fmt_layout) Phone_recs):=function
			Phone_recs_srt:= choosen (sort (Phone_recs, -fmt_date), 1); // the latest feedback

			iesp.phonesfeedback.t_LastFeedback final_xform (PhonesFeedback_Services.Layouts.rec_fmt_layout l):=transform
				self.ResultProvided := iesp.ECL2ESP.toDate (l.fmt_date);
				self.Result := contact_type_description (l.phone_contact_type);
        // latest date when this phone was confirmed:
        cdate := max (Phone_recs ((phone_contact_type='1') or (phone_contact_type='2')), fmt_date);
				self.ConfirmedContact := iesp.ECL2ESP.toDate (cdate);
			end;

			return project (Phone_recs_srt(fmt_date > 0), final_xform(LEFT));
		end;	

			
		addl_Phone (dataset(PhonesFeedback_Services.Layouts.rec_fmt_layout) Phone_recs):=function
			Phone_recs_addl_ph:=dedup(sort(Phone_recs(phone_contact_type='7'),-fmt_date,-alt_phone),alt_phone);
			Phone_recs_addl_info:=dedup(sort(Phone_recs(phone_contact_type='8'),-fmt_date,-other_info),other_info);
			PhonesFeedback.Mac_Parse_Phone(Phone_recs_addl_info,other_info,did,Phone_recs_addl_ph_2);
			Phone_recs_addl_ph_1:=table(Phone_recs_addl_ph(alt_phone<>''),{PhoneNumber:=alt_phone});
			addl_ph_tmp:=dedup(sort(Phone_recs_addl_ph_1+Phone_recs_addl_ph_2,PhoneNumber),PhoneNumber);
			
			iesp.share.t_StringArrayItem xform(addl_ph_tmp le):=transform
				self.value:=le.PhoneNumber;
			end;
			addl_ph:=project(addl_ph_tmp,xform(LEFT));
			
			return addl_ph;
		end;
		
		addl_info (dataset(PhonesFeedback_Services.Layouts.rec_fmt_layout) Phone_recs):=function
			Phone_recs_addl_info:=dedup(sort(Phone_recs(phone_contact_type='8'),-fmt_date,-other_info),other_info);
			addl_info:= table(Phone_recs_addl_info(other_info<>''),{other_info});
			
			iesp.share.t_StringArrayItem xform(addl_info le):=transform
				self.Value:=le.other_info;
			end;
			other_info:=project(addl_info,xform(LEFT));
			return other_info;
		end;

		feedback_summary (dataset(PhonesFeedback_Services.Layouts.rec_fmt_layout) Phone_recs):=function
				ds_tmp:=dedup(sort(Phone_recs,loginid,-fmt_date),loginid);
				feedback_tmp:=table(ds_tmp,{phone_contact_type,FeedbackCount:=COUNT(GROUP)},phone_contact_type);
				iesp.phonesfeedback.t_FeedbackReport xform(feedback_tmp le):=transform
					self.description:=contact_type_description(le.phone_contact_type);
					self.FeedbackCount:=le.FeedbackCount;
				end;
				feedback_summary:=project(feedback_tmp,xform(LEFT));
				return feedback_summary;
		
		end;

		iesp.phonesfeedback.t_PhonesFeedbackReportResponse xform (PhonesFeedback_Services.Layouts.rec_fmt_layout l):=transform
			self.LastFeedback:= feedback_Report(Phone_recs)[1];
			self.AdditionalPhones:=choosen(project(addl_Phone(Phone_recs),iesp.share.t_StringArrayItem), iesp.Constants.PHFEEDBACK.MaxAdditionalPhones);
			self.OtherInfo:=choosen(project(addl_info(Phone_recs),iesp.share.t_StringArrayItem), iesp.Constants.PHFEEDBACK.MaxOtherInfo);
			self.FeedbackReports:=choosen(feedback_summary(Phone_recs), iesp.Constants.PHFEEDBACK.MaxFeedbacks);
			self._Header:=iesp.ECL2ESP.GetHeaderRow();
		end;
		
		final_Rpt:=project(Phone_recs,xform(LEFT));
		return final_Rpt;     
	end;



  // to be used for embedded PhonesFeedback section (person search, reports, etc.)
  // returns no more than one record (per phone+DID)
  export GetReport (dataset(Layouts.Layout_PhonesFeedback_base) Phone_recs_tmp):= function

		Phone_recs := project (Phone_recs_tmp, add_std_date (Left));

		// keep only latest feedbacks from each user (customerid + loginid)
		// TODO: time may be important: two feedbacks with different contact_type at the same date
		phone_dedup:=dedup(sort(Phone_recs, did, phone_number, customerid, loginid, -fmt_date, phone_contact_type),
														did, phone_number, customerid, loginid);

		// take the latest of all (per phone+DID)
    phone_unique := dedup (sort (phone_dedup, did, phone_number, -fmt_date), did, phone_number);
    
		// per spec: take latest feedback and count how many "same" feedbacks among latest per user
		PhonesFeedback_Services.Layouts.feedback_report x_rpt1 (PhonesFeedback_Services.Layouts.rec_fmt_layout l):=transform
			self.Last_Feedback_Result_Provided:=l.fmt_date;
			self.Last_Feedback_Result:=contact_type_description(l.phone_contact_type);
			self.feedback_count := count (phone_dedup (did = l.did, phone_number = l.phone_number, 
                                    phone_contact_type = l.phone_contact_type));
		end;

		result := project (phone_unique, x_rpt1 (LEFT));
		return result;
	end;
end;
