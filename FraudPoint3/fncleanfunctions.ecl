EXPORT fncleanfunctions := module

export clean_date(string indate) := function //dates 08/18/2006
searchpattern := '(.*)/(.*)/(.*)';
cleanit 	:= if(indate <> '' and regexfind('[0-9]+',indate), trim(indate, left, right), '');		
        clean_yr := regexfind(searchpattern, cleanit, 3);
				clean_mn := if(length(regexfind(searchpattern, cleanit, 1)) = 1, '0'+ regexfind(searchpattern, cleanit, 1), regexfind(searchpattern, cleanit, 1)); 
				clean_dy := if(length(regexfind(searchpattern, cleanit, 2)) = 1, '0'+ regexfind(searchpattern, cleanit, 2), regexfind(searchpattern, cleanit, 2));

									
indate_clean := clean_yr + clean_mn + clean_dy;
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
			
			
end;