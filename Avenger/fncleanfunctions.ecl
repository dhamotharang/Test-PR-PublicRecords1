import ut, avenger,lib_stringlib,_validate;

export fncleanfunctions := module

export tDateAdded(string indate) := function //dates like '26-APR-14 02.42.46.852 PM'
										upcaseit 	:= trim(stringlib.stringtouppercase(indate), left, right);
										noTrans := ~regexfind('[B-LN-OQ-Z]', upcaseit); // do not find more than AM PM
										month 	:= trim(map(upcaseit[4..6] = 'JAN' => '01',
														upcaseit[4..6] = 'FEB' => '02',
														upcaseit[4..6] = 'MAR' => '03',
														upcaseit[4..6] = 'APR' => '04',
														upcaseit[4..6] = 'MAY' => '05',
														upcaseit[4..6] = 'JUN' => '06',
														upcaseit[4..6] = 'JUL' => '07',
														upcaseit[4..6] = 'AUG' => '08',
														upcaseit[4..6] = 'SEP' => '09',
														upcaseit[4..6] = 'OCT' => '10',
														upcaseit[4..6] = 'NOV' => '11',
														upcaseit[4..6] = 'DEC' => '12', ''));
										Dy		:= trim(upcaseit[1..2]);
										Yr		:= trim('20' + upcaseit[8..9]);
								return stringlib.stringcleanspaces(if(noTrans, stringlib.stringfilterout(upcaseit, '-'), stringlib.stringcleanspaces(yr+month+dy)+' '+upcaseit[11..]));

								end;	
								
	export tDateAdded_quiz(string indate) := function //dates like '26-APR-14 02.42.46.852 PM'
										upcaseit 	:= trim(stringlib.stringtouppercase(indate), left, right);								
										indate_clean := if(indate <> '', upcaseit[1..4] + upcaseit[6..7] + upcaseit[9..10], indate);
								return indate_clean;//+' '+upcaseit[10..]);
								end;								
								
//01-JAN-13 12.03.17.013 AM
//Apr 13 2014 12:00:04:866AM

export tTimeAdded(string dt) := function //dates like 20110101 10:15:123456AM

		time_only 				:= stringlib.stringtouppercase(trim(dt, all)[10..]);
		
		a	:= (string)intformat((integer)time_only[..2], 2, 1);

		remove_nonalphnum1 := regexreplace('[^AMP0-9]', a, '');
		remove_nonalphnum2 := regexreplace('[^AMP0-9]', time_only[3..], '');

		remove_nonalphnum := remove_nonalphnum1 + remove_nonalphnum2;

		ampm 							:= regexreplace('[^AMP]', remove_nonalphnum, '')[..2];
		has_ampm					:= ampm in ['AM','PM'];

		numbs							:= regexreplace('[^0-9]', remove_nonalphnum, '');
		
		hr								:= (integer)numbs[..2];
		
		hr_ampm						:= intformat(map(~has_ampm => hr,
														 has_ampm and ampm = 'AM' and hr < 12 => hr,
														 has_ampm and ampm = 'AM' and hr = 12 => 0,
														 has_ampm and ampm = 'PM' and hr < 12 => hr + 12, 
														 has_ampm and ampm = 'PM' and hr = 12 => 12, 
														 99), 2, 1);
														 
		dt_hr := if(trim(dt, all)[10..] <> '', trim(dt, all)[..8] + ' ' + trim(((string)hr_ampm + numbs[3..8] + '00000000'), all)[..8], dt);

return dt_hr;
end;
/*
export clean_dob(string orig_dob) := function
				clean_yr := map((unsigned8)orig_dob[1..4] between ((unsigned8)ut.getdate[1..4]) - 123 and (unsigned8)ut.getdate[1..4] => orig_dob[1..4], '0000');
				clean_mn := map(orig_dob[5..6] between '01' and '12' => orig_dob[5..6], '00');
				clean_dy := map(clean_mn <> '00' and clean_yr <> '0000' and (unsigned8)orig_dob[7..8] between 1 and ut.Month_Days((unsigned8)(clean_yr+clean_mn)) => orig_dob[7..8],
									clean_mn in ['01','03','05','07','08','10','12'] and orig_dob[7..8] between '01' and '31' => orig_dob[7..8],
									clean_mn in ['04','06','09','11'] and orig_dob[7..8] between '01' and '30' => orig_dob[7..8],
									clean_mn = '02' and orig_dob[7..8] between '01' and '29' => orig_dob[7..8],
									'00');
									
				return stringlib.stringfindreplace(clean_yr + clean_mn + clean_dy, '00000000', '');
		end;	*/

export clean_irm_dob(string indate) := function //dates 2006-08-18
cleanit 	:= if(indate <> '' and regexfind('[0-9]+',indate), trim(indate, left, right)[1..10], '');		      								
indate_clean := _validate.date.fCorrectedDateString(stringlib.StringFilterOut(cleanit, '-'),false);
return indate_clean;
						
end;	    
		
export clean_asser_dob(string indate) := function //dates 08/18/2006
searchpattern := '(.*)/(.*)/(.*)';
cleanit 	:= if(indate <> '' and regexfind('[0-9]+',indate), trim(indate, left, right), '');		
        clean_yr := regexfind(searchpattern, cleanit, 3);
				clean_mn := if(length(regexfind(searchpattern, cleanit, 1)) = 1, '0'+ regexfind(searchpattern, cleanit, 1), regexfind(searchpattern, cleanit, 1)); 
				clean_dy := if(length(regexfind(searchpattern, cleanit, 2)) = 1, '0'+ regexfind(searchpattern, cleanit, 2), regexfind(searchpattern, cleanit, 2));

									
indate_clean := _validate.date.fCorrectedDateString(clean_yr + clean_mn + clean_dy, false);
								return indate_clean;
						
end;	    
			
export clean_tran_dob(string yr, string mn, string dy) := function //dates 08/18/2006
        clean_yr := trim(yr, left, right);
				clean_mn := if(length(trim(mn, left,right)) = 1, '0'+ trim(mn, left,right), trim(mn, left,right)); 
				clean_dy := if(length(trim(dy, left,right)) = 1, '0'+ trim(dy, left,right), trim(dy, left,right)); 

indate_clean := _validate.date.fCorrectedDateString(clean_yr + clean_mn + clean_dy, false);
								return indate_clean;
						
end;	    
			
	
	export clean_phone(string orig_phone) := function
        pre_clean_phone1 := if(trim(orig_phone)[1] = '+',orig_phone[3..],orig_phone);
	      pre_clean_phone2 := stringlib.stringfilter(pre_clean_phone1, '0123456789');
				pclean_phone := if(pre_clean_phone2[1..3] in ['000','XXX','xxx'], '   ', orig_phone[1..3])+ orig_phone[4..10]; /* empty area codes standardized */
				NPAg := pclean_phone[1..3] in ['800','811','822','833','844','855','866','877','888','899'] or orig_phone[1..3] between '200' and '999'; /* toll free area codes */
				NXXg := pclean_phone[4..6] between '001' and '999'; /* valid nxx */
				TBg  := pclean_phone[7..10] between '0000' and '9999'; /* valid tb+ */
				return  pre_clean_phone2;//map(NPAg and NXXg and TBg => pclean_phone, NXXg and TBg => '   ' + pclean_phone[7..10], '');
		
		end;
		
		export clean_ADL(string ADL) := function
		
		valid_ADL := if(~regexfind('[a-zA-Z]', ADL) and length(trim(ADL,left,right)) <= 12 and (unsigned)ADL > 0, ADL, '');
    return valid_ADL;
				
end;
			
		export clean_fields(string orig_field) := function	
		
		blank_fields := if(~regexfind('[a-zA-Z0-9]', orig_field), '', orig_field);
		
		return blank_fields;
		
		end;
		
		shared RISK_INDICES_filter(string orig_field) := trim(StringLib.Stringfilter(orig_field, '0123456789'),left,right);

		export get_Friendly(string orig_field) := function
		
		return RISK_INDICES_filter(orig_field[1..StringLib.Stringfind(orig_field, ',', 1)]);

	end;	
	
	export get_Suspicous(string orig_field) := function
		
		return RISK_INDICES_filter(orig_field[StringLib.Stringfind(orig_field, ',', 1)..StringLib.Stringfind(orig_field, ',', 2)]);

	end;	 
	
	export get_Synthetic(string orig_field) := function
		
		return RISK_INDICES_filter(orig_field[StringLib.Stringfind(orig_field, ',', 2)..StringLib.Stringfind(orig_field, ',', 3)]);

	end;	 
	
	export get_Manipulated(string orig_field) := function
		
		return RISK_INDICES_filter(orig_field[StringLib.Stringfind(orig_field, ',', 3)..StringLib.Stringfind(orig_field, ',', 4)]);

	end;
	
	export get_Stolen(string orig_field) := function
		
		return RISK_INDICES_filter(orig_field[StringLib.Stringfind(orig_field, ',', 4)..StringLib.Stringfind(orig_field, ',', 5)]);

	end;
	
	export get_Vulnerable(string orig_field) := function
		
		return RISK_INDICES_filter(orig_field[StringLib.Stringfind(orig_field, ',', 5)..]);

	end;

end;