EXPORT Email_Report(logical_file_name, file_name, report_tag, file_tag, Tag) := FUNCTIONMACRO

		string out_file_layout := '';

		outfile := dataset(file_name, typeof(out_file_layout));
		
		no_of_records := count(outfile);		
		
		myrec := RECORD, maxlength(9999999) 
		unsigned code0; 
		unsigned code1;
		string line; 
		END;

		myrec ref1(outfile l, integer c) := TRANSFORM 
		self.code0 := c; 
		self.code1 := c + 1 ;
		self.line := if( c = 1,logical_file_name  + '\n' + l.line 	, l.line);
		END;

		outputs := project(outfile, ref1(left, counter));
		
		// outputs;

		MyRec Xform(myrec L,myrec R) := TRANSFORM
		SELF.line := trim(L.line, left, right) + '\n' + trim(R.line, left, right); 
		self := l;
		END;

		XtabOut := iterate(outputs,Xform(left,right));		
		
		// XtabOut[no_of_RECORDs];
	
		//send_file := fileservices.SendEmailAttachText('karthik.reddy@lexisnexis.com',
		 send_file := fileservices.SENDEmailAttachText(Kel_Shell_QA.email_distribution.Success_list,
							 ' '+ report_tag  +  'Test Results Direct From Thor ',
																			 	 trim(Tag,left,right) + ' '+ '\n Please view attachment. \n'  + 'Your WUID is ' + workunit + ' .' ,
																			 XtabOut[no_of_records].line ,
																			 'text/plain; charset=ISO-8859-3', 
																				' ' +	file_tag + ' '+ trim(Tag,left,right) + ' '  + '.csv',
																			 ,
																			 ,
																			 'karthik.reddy@lexisnexis.com');	
																																	 
																			 
	RETURN send_file;
	
ENDMACRO;	
