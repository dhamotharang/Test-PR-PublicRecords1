EXPORT fn_email_lerg1_category_change := function

	///////////////////////////////////////////
	//Catch Changes in Lerg1 "Category" Field//
	///////////////////////////////////////////

	//Input Lerg1 Files
	ds 				:= PhonesInfo.File_Lerg.Lerg1;
	ds2				:= PhonesInfo.File_Lerg.Lerg1Hist_Father;

	//Pull Previous Lerg1 File
	ds2 lerg1Tr(ds2 l):= transform
		trimFile 				:= trim(l.filename, left, right);	
		self.filename		:= trimFile[length(trimFile)-7..];
		self 						:= l;
	end;

	addDt 		:= project(ds2, lerg1Tr(left))(filename=max(filename));

	//Compare Current with Previous Lerg1 File
	srt_curr 	:= sort(distribute(ds, hash(ocn)), ocn, category, local);
	srt_prev 	:= sort(distribute(addDt, hash(ocn)), ocn, category, local);

	compLayout := record
		string prev_ocn;
		string prev_ocn_name;
		string prev_ocn_state;
		string prev_category;
		string curr_ocn;
		string curr_ocn_name;
		string curr_ocn_state;
		string curr_category;
	end;
	
	compLayout compF(srt_curr l, srt_prev r):= transform
		self.prev_ocn					:= r.ocn;
		self.prev_ocn_name		:= r.ocn_name;
		self.prev_ocn_state		:= r.ocn_state;
		self.prev_category		:= r.category;
		self.curr_ocn					:= l.ocn;
		self.curr_ocn_name		:= l.ocn_name;
		self.curr_ocn_state		:= l.ocn_state;
		self.curr_category		:= l.category;
	end;

	compFile 	:= join(srt_curr, srt_prev,
										left.ocn = right.ocn and
										left.category <> right.category,
										compF(left, right), local);

	//Prep Email Notice
	mail_data := record, maxlength(10000000)
		string mail_text;
	end;

	header_ 	:= dataset([{'prev_ocn,prev_ocn_name,prev_ocn_state,prev_category,curr_ocn,curr_ocn_name,curr_ocn_state,curr_category\n'}], mail_data); 
			
	mail_data convertToString(compFile l) := transform
		self.mail_text := '"'+ l.prev_ocn + '",' + '"'+ l.prev_ocn_name + '",' + '"'+ l.prev_ocn_state + '",' + '"'+ l.prev_category + '",' + '"'+ l.curr_ocn + '",' + '"'+ l.curr_ocn_name + '",' + '"'+ l.curr_ocn_state + '",' + '"'+ l.curr_category + '"' +'\n';	                
	end;
		
	stringRecs:= header_ + project(compFile, convertToString(left));

	mail_data convertToText(mail_data l, mail_data r) := transform
		self.mail_text := trim(l.mail_text) + trim(r.mail_text);
	end;

	textDs 		:= rollup(stringRecs, 1=1, convertToText(left, right));

	//Generate Email Notice, If "Category" Field Changes
	outfile 	:= if(count(compFile)>0 and count(PhonesInfo.File_Lerg.Lerg1)>0,
									textDs[1].mail_text,
									'no lerg1 category changes');
	
	return outfile;

end;