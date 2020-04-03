//Find Existing Carrier Reference Records That Are Missing From the Latest Update

EXPORT fn_email_before_after_carrier_record_differences := function

	ds_before 	:= PhonesInfo.File_Source_Reference.Main_Previous; //Last Carrier Reference Update
	ds_after  	:= PhonesInfo.File_Source_Reference.Main;					 //Latest Carrier Reference Update

	srt_before 	:= sort(distribute(ds_before, hash(ocn)), ocn, name, spid, serv, line, local);
	srt_after   := sort(distribute(ds_after, hash(ocn)), ocn, name, spid, serv, line, local);

	diffLayout := record
		string8   ocn;
		string60  carrier_name;
		string60  name;
		string1   serv;
		string1   line;
		string2   prepaid;
		string2   high_risk_indicator;
		string10  spid;
		string60  operator_full_name;
	end;

	diffLayout compF(srt_before l, srt_after r):= transform
		self	:= l;
	end;

	compFiles 	:= join(srt_before, srt_after,
											left.ocn = right.ocn and
											left.name = right.name and
											left.spid = right.spid and
											left.serv = right.serv and
											left.line = right.line,
											compF(left, right), left only, local);

	ddCompFiles := dedup(sort(distribute(compFiles, hash(ocn, name)), record, local), record, local);
	
	//Prep Email Notice
	mail_data := record, maxlength(10000000)
		string mail_text;
	end;

	header_ 	:= dataset([{'ocn,carrier_name,name,serv,line,prepaid,high_risk_indicator,spid,operator_full_name\n'}], mail_data); 
			
	mail_data convertToString(compFiles l) := transform
		self.mail_text := '"'+ l.ocn + '",' + '"'+ l.carrier_name + '",' + '"'+ l.name + '",' + '"'+ l.serv + '",' + '"'+ l.line + '",' + '"'+ l.prepaid + '",' + '"'+ l.high_risk_indicator + '",' + '"'+ l.spid + '",' + '"'+ l.operator_full_name + '"' +'\n';	                
	end;
		
	stringRecs:= header_ + project(compFiles, convertToString(left));

	mail_data convertToText(mail_data l, mail_data r) := transform
		self.mail_text := trim(l.mail_text) + trim(r.mail_text);
	end;

	textDs 		:= rollup(stringRecs, 1=1, convertToText(left, right));	
	
	//Generate Email Notice, If There Are Existing Carrier Reference Records Missing From the Current Update
	outfile 	:= if(count(ddCompFiles)>0,
									textDs[1].mail_text,
									'no carrier reference records ocn/carrier_name/serv/line/spid differences available');
	
	return outfile;	
	
end;