// function to capture error messages in a WU
// and send the messages as attachment in CSV
import STD,ut;
export GetWUErrorMessages(string wid
												,string esp // pass in esp ip or dns, ignore http://
												,string port = '8010'
												,string senderemail
												,string toemaillist
												) := function
		rundatetime := (string8)STD.Date.Today()+Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S') : independent;
		
		InRecord := record
			string Name{xpath('Wuid')} := wid;
		end;

	
		messages := record, maxlength(30000)
			string Severity {XPATH('Severity')} := '';
			string message {XPATH('Message')} := '';
		end;

	
		resultnames := record
			string100 name {XPATH('FileName')} := '';
		end;

	
		OutRecord := record,maxlength(300000)
			string20 Wuid{xpath('Wuid')};
			dataset(messages) errormessages{xpath('Exceptions/ECLException')};
			//dataset(resultnames) resultfiles{xpath('Results/ECLResult')};
		end;
	
		results := SOAPCALL('http://'+esp+':'+port+'/WsWorkunits', 'WUInfo', 
											InRecord, dataset(OutRecord),
											xpath('WUInfoResponse/Workunit')
											,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues())
										 );

		filenames := record, maxlength(30000)
			string20 wuid := wid;
			string20 errortime;
			integer emailsent;
			string messages := '';
			string severity := ''
		end;
	
		filenames norm_sources(results l, messages r) := transform
			self.messages := regexreplace('"',r.message,'');
			self.errortime := rundatetime;
			self.severity := r.severity;
			self.emailsent := 0;
			self := l;
		end;
	
		filesused := normalize(results,left.errormessages,norm_sources(left,right));
	
		fulllist := dedup(sort(filesused(stringlib.stringtouppercase(severity) = 'ERROR' or regexfind('FAILED',stringlib.stringtouppercase(messages))),messages),record);

		//errords := dataset('~'+errorqa, filenames, CSV(SEPARATOR('\t'),QUOTE('\"'),TERMINATOR('\r\n')),OPT);
		
		finalerrorlist := dedup(sort(fulllist /*+ errords*/,wuid,messages,-emailsent,-errortime),wuid,messages);

		// Email prep work
		
		linestring := RECORD
			STRING300000 line; 
		END;

		headerRec := DATASET([{'errormessage, errortime'}], linestring);

		linestring converttoline (finalerrorlist L) := TRANSFORM
				SELF.line         := '"' + L.messages + '",' +  regexreplace('-',L.errortime,'');
		END;
		
		singlelinerecord := PROJECT (finalerrorlist(emailsent = 0), converttoline(LEFT));

		
		myrec := RECORD
			UNSIGNED  code0; 
			STRING300000 line; 
		END;

		myrec ref(singlelinerecord l) := TRANSFORM 
			SELF.code0 := 0; 
			SELF       := l; 
		END;

		inputs := PROJECT(headerRec+singlelinerecord, ref(LEFT));

		MyRec rollupForm (myrec L, myrec R) := TRANSFORM
			SELF.line := TRIM(L.line, left, right) + '\n' + TRIM(R.line, LEFT, RIGHT); 
			SELF      := L;
		END;

		XtabOut := ROLLUP(inputs, rollupForm(LEFT,RIGHT), CODE0);
	
	
		mailerrors :=	FileServices.SendEmailAttachText( toemaillist
																						,wid + ' errors - ' + rundatetime
																						,'Please see attached file for errors'
																						, TRIM(XtabOut[1].line, LEFT, RIGHT)
																						,'text/xml'
																						,wid+'Errors.csv'
																						,
																						,
																						,senderemail);
		
		filenames resetemailflag(finalerrorlist l) := transform
			self.emailsent := 1;
			self := l;
		end;
		
		createerrorfile := project(finalerrorlist,resetemailflag(left));
		
		return if (count(singlelinerecord) > 0,
									// sequential(
										mailerrors/*,
										output(createerrorfile,,'~'+errorfile, CSV(SEPARATOR('\t'),QUOTE('\"'),TERMINATOR('\r\n')),overwrite),
										CreateSupers,
										fileservices.clearsuperfile('~'+errordelete,true),
										fileservices.addsuperfile('~'+errordelete,'~'+errorqa,,true),
										fileservices.clearsuperfile('~'+errorqa),
										fileservices.addsuperfile('~'+errorqa,'~'+errorfile),*/
									//)
								);
	end;