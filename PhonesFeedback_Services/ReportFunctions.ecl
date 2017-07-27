import ut,iesp,PhonesFeedback,lib_stringlib;
export ReportFunctions (dataset(Layouts.Layout_PhonesFeedback_base) Phone_recs_tmp):= function
// export ReportFunctions (recordof(Phone_recs_tmp) Phone_recs_tmp):= function

		
		export string30 contact_type_description(string type_code) := map(
		type_code = '1'=>'Right Party Contact',
		type_code = '2'=>'Relative Or Associate Contact',
		type_code = '3'=>'Wrong Party Claim',
		type_code = '4'=>'Phone Disconnected',
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
		
		export valid_date(string DatetoCheck):= if(length(DatetoCheck)>8 AND
		                                            ((Integer)(DatetoCheck[1..4]) >= 1900) And
                                                ((Integer)(DatetoCheck[5..6]) Between 1 And 12) And            
                                                ((Integer)(DatetoCheck[7..8]) Between 1 And 31),DatetoCheck,'');
		
	
		
		r1:=record
		recordof (Phone_recs_tmp);
		integer fmt_date;
		end;
		r1 xform_dt(Phone_recs_tmp le):=transform
			self.fmt_date:=(unsigned) PhonesFeedback_Services.CleanDate(le.date_time_added);
			self:=le;
		end;
		Phone_recs_dt:=project(Phone_recs_tmp,xform_dt(LEFT));
		
		PhonesFeedback_Services.Layouts.rec_fmt_layout add_std_date(Phone_recs_tmp l):=transform
		
		tmp:=l.date_time_added;
		c2:=lib_stringlib.stringlib.stringfind(tmp,':',1);
		s1:=tmp[1..(c2-3)];
		htmp:=intformat((integer) tmp[(c2-2)..(c2-1)],2,1);
		mtmp:=intformat((integer) tmp[(c2+1)..(c2+2)],2,1);
		amtmTmp:=tmp[(length(tmp)-1)..length(tmp)];
		htmp24:=intformat(if(amtmTmp='AM',(integer) htmp,((integer) htmp)+12),2,1);
		s2:=PhonesFeedback_Services.CleanDate(s1);

		self.fmt_date:=(integer) valid_date((s2+(string) htmp24+(string) mtmp));
		self:=l;
		end;
		
		Phone_recs:=project(Phone_recs_tmp,add_std_date(LEFT));
		
			phone_recs_dedup:=dedup(sort(Phone_recs,-fmt_date,customerid,loginid,did,phone_contact_type),customerid,loginid,did,phone_contact_type);
			rpt_Layout:=record
				PhonesFeedback_Services.Layouts.feedback_report;
				string loginid;
			end;

			Phone_recs_srt:=sort(Phone_recs,-fmt_date);

			// rpt_Layout x_rpt1 (Phone_recs l,integer c):=transform
			rpt_Layout x_rpt1 (Phone_recs l):=transform

				self.Last_Feedback_Result_Provided:=l.fmt_date;
				self.Last_Feedback_Result:=contact_type_description(l.phone_contact_type);
				self.loginid:=l.loginid;
				self:=[];
			end;

			// result_rpt1_tmp:=dedup(sort(project(Phone_recs_srt,x_rpt1(LEFT,counter)),-Last_Feedback_Result_Provided,Last_Feedback_Result,loginid),Last_Feedback_Result,Last_Feedback_Result,loginid);
			result_rpt1_tmp_all:=dedup(sort(project(Phone_recs_srt,x_rpt1(LEFT)),-Last_Feedback_Result_Provided,Last_Feedback_Result,loginid),Last_Feedback_Result,Last_Feedback_Result,loginid);

			result_rpt1_tmp := result_rpt1_tmp_all(Last_Feedback_Result<>'');
			result_rpt1:=result_rpt1_tmp[1];
			
			result_rpt2:=table(result_rpt1_tmp,{Last_Feedback_Result,fbcnt:=count(Group)},Last_Feedback_Result);
							     
			PhonesFeedback_Services.Layouts.feedback_report xform(result_rpt1_tmp l,result_rpt2 r) :=transform
				self.Last_Feedback_Result_Provided:=(unsigned) l.Last_Feedback_Result_Provided[1..8];
				self.feedback_count:=r.fbcnt;
				self.Last_Feedback_Result:=l.Last_Feedback_Result;
			end;
			result_rpt_all:=join(result_rpt1_tmp,result_rpt2,
											 left.Last_Feedback_Result=right.Last_Feedback_Result,
											 xform(left,right));
			
			// result_rpt:=result_rpt_all[1];
			// result_rpt:=choosen(result_rpt_all,1);
			return result_rpt_all;
		
end;		