EXPORT fn_email_attachment_deact_gh(string version) := function

	//Reflag same_day deletion records
	ds_same  	:= dataset('~thor_data400::persist::gong_history_deact_sameday', PhonesInfo.Layout_Deact_GH.Temp, flat);

	PhonesInfo.Layout_Deact_GH.Temp fixF(ds_same l):= transform
		self.is_deact := 'S';	
		self.is_react := 'S';
		self 									:= l;
	end;

	fix_same		:= project(ds_same, fixF(left));

	//Pull remaining records
	ds_rem	  	:= dataset('~thor_data400::base::phones::disconnect_gh_main_'+version, PhonesInfo.Layout_Deact_GH.Temp, flat);

	//Concat reflagged deletion records and others
	ds_concat	:= fix_same + ds_rem;

	//Breakdown by is_deact & is_react
	rec := record
	 ds_concat.is_deact;
	 ds_concat.is_react;
	 count_ := count(group);
	end;

	out := sort(table(ds_concat,
																			rec,
																			ds_concat.is_deact,
																			ds_concat.is_react), -count_);
	
	//Prep Email Notice
	mail_data := record, maxlength(10000000)
		string mail_text;
	end;

	header_ := dataset([{'is_deact,is_react,flag_count\n'}], mail_data); 
			
	mail_data convertToString(rec L) := transform
		self.mail_text := l.is_deact + ',' + l.is_react + ',' + l.count_ + '\n';	                
	end;
		
	stringRecs := header_ + project(out, convertToString(LEFT));

	mail_data convertToText(mail_data L, mail_data R) := transform
		self.mail_text := trim(L.mail_text) + trim(R.mail_text);
	end;

	textDs := rollup(stringRecs, 1=1, convertToText(LEFT, RIGHT));

	//Generate Email Notice
 return textDs[1].mail_text;
	
end;