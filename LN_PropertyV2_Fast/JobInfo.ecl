IMPORT std,_control;
EXPORT JobInfo := MODULE
	SHARED layout := {string recipients};
	SHARED fileName := '~jobinfo::'+STD.System.Job.WUID()+'::recipients';
	EXPORT setEmailsToNotify(string list) := FUNCTION
		ds := dataset([{list}],layout);
		RETURN output(ds,,fileName,overwrite);
	END;
	EXPORT getEmailsToNotify() := FUNCTION
	  
		list := set(if(nothor(fileservices.FileExists(filename))
									 ,dataset(filename,layout,flat)
								   ,dataset([{''}],layout)
									)
								,recipients
							  );
		RETURN list[1];
	END;
	EXPORT updateViaEmail(string message,string eType = 'Update') := FUNCTION
			env := _control.ThisEnvironment.name;
			ipa := if(env='Dataland','10.241.12.207',_control.IPAddress.prod_thor_esp);
			msg := env+': http://'+ipa+':8010/?Wuid='+STD.System.Job.WUID()+'&Widget=WUDetailsWidget#/stub/Summary';
			sbj := eType+' '+STD.System.Job.Name()+' '+STD.System.Job.WUID();
			bdy := msg + if(message='','',' DETAILS:'+ message);
			RETURN if (getEmailsToNotify()<>''
								,FileServices.SendEmail(getEmailsToNotify(), sbj,bdy,,,env+'@lexisnexis.com')
								,sequential(STD.System.Log.addWorkunitError('NO EMAIL ADDRESSES SPECIFIED. DID YOU RUN JobInfo.setEmailsToNotify?'),
														STD.System.Log.addWorkunitError(eType+':'+message)
													 )
								);
	END;
	EXPORT deleteFile := if(nothor(fileservices.FileExists(filename)),nothor(fileservices.DeleteLogicalFile(fileName)));
	EXPORT RunActionAndUpdateViaEmail(action,emails) := FUNCTIONMACRO
				 go := sequential( LN_PropertyV2_Fast.JobInfo.setEmailsToNotify(emails),
													  LN_PropertyV2_Fast.JobInfo.updateViaEmail('','Started'),
														action):
											success(sequential(LN_PropertyV2_Fast.JobInfo.updateViaEmail('','Completed'),
															LN_PropertyV2_Fast.JobInfo.deleteFile)),
										  failure(sequential(LN_PropertyV2_Fast.JobInfo.updateViaEmail(failmessage,'FAILED!'),
															LN_PropertyV2_Fast.JobInfo.deleteFile));
				return go;
	ENDMACRO;
END;

//LN_PropertyV2_Fast.JobInfo.RunActionAndUpdateViaEmail(d,'gabriel.marcan@lexisnexis.com');
//within d use: LN_PropertyV2_Fast.JobInfo.updateViaEmail('Here we are again')