EXPORT fn_email_incomplete_carrier_reference_records(string version) := function

	///////////////////////////////////////////////////////////
	//Capture Incomplete Carrier Reference Records for Review//
	///////////////////////////////////////////////////////////
	
	//Pull Incomplete Reference Table 		
	dsInc 		:= dataset('~thor_data400::base::phones::source_reference_main_review_'+version, PhonesInfo.Layout_Lerg.LergPrep, flat);
		
	//Reformat Incomplete Reference Table
	addRecLayout := record
		string ocn;
		string carrier_name;
		string serv;
		string line;
		string category;
		string spid;
		string operator_full_name;
		string country;
		string override_file;
		string is_new;
		string rec_type;
	end;

	//Add Record Type Flags
	addRecLayout assignTr(dsInc l):= transform
		self.rec_type := if(l.ocn<>'' and l.carrier_name<>'' and l.spid<>'' and l.operator_full_name<>'',
												'1', 			//New Record (Never Seen Before)
											if(l.ocn<>'' and l.carrier_name<>'' and l.spid='' and l.operator_full_name='' and l.country='US',
												'2', 			//Lerg Carrier_Name Not Listed in Comp_Code File
											if(l.ocn<>'' and l.carrier_name<>'' and l.spid='' and l.operator_full_name='' and l.country<>'US',
												'3', 			//Foreign Record
											if(l.ocn<>'' and l.carrier_name='',
												'4',			//Comp_Code Operator Name Not Listed in Lerg File
												'0'))));	//Undefined	
		self 					:= l;
	end;

	addFlags := project(dsInc, assignTr(left));
		
	//Prep Email Notice
	mail_data := record, maxlength(10000000)
		string mail_text;
	end;

	header_ 	:= dataset([{'ocn,carrier_name,serv,line,category,spid,operator_full_name,country,override_file,is_new,rec_type\n'}], mail_data); 
			
	mail_data convertToString(addFlags l) := transform
		self.mail_text := '"'+ l.ocn + '",' + '"'+ l.carrier_name + '",' + '"'+ l.serv + '",' + '"'+ l.line + '",' + '"'+ l.category + '",' + '"'+ l.spid + '",' + '"'+ l.operator_full_name + '",' + '"'+ l.country + '",' + '"'+ l.override_file + '",' + '"'+ l.is_new + '",' + '"'+ l.rec_type + '"' +'\n';	                
	end;
		
	stringRecs:= header_ + project(addFlags, convertToString(left));

	mail_data convertToText(mail_data l, mail_data r) := transform
		self.mail_text := trim(l.mail_text) + trim(r.mail_text);
	end;

	textDs 		:= rollup(stringRecs, 1=1, convertToText(left, right));

	//Generate Email Notice, If There Are Incomplete Carrier Reference Records
	outfile 	:= if(count(addFlags)>0,
									textDs[1].mail_text,
									'no incomplete carrier reference records available');
	
	return outfile;

end;