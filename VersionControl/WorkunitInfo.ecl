import _control;
#option('maxLength', 131072); // have to increase for the remote directory child datasets
//////////////////////////////////////////////////////////////////////////////////////////////
// -- rawinputs := versioncontrol.WorkunitInfo('W20071008-134224').fRawInputs;
//
// -- norminputs := versioncontrol.WorkunitInfo().fNormInputs(rawinputs);
//
// -- output(norminputs, all);
// -- this will pull all of the source inputs from a workunit, and normalize them out to one file per record
//////////////////////////////////////////////////////////////////////////////////////////////
export WorkunitInfo(string pWorkunitID = '') :=
module

	export wuinfoInRecord :=
	record, maxlength(100)
		string eclWorkunit{xpath('Wuid')} := pWorkunitID;
	end;
	
	export eclResultLayout :=
	record, maxlength(500)
	
	// string FileName{xpath('FileName')};
		string sourceFile{xpath('Name')};
	
	end;
	
	export wuinfoOutRecord :=
	record, maxlength(100000)
	
		string exception_code{xpath('Exceptions/Exception/Code')};
		string exception_source{xpath('Exceptions/Exception/Source')};
		string exception_msg{xpath('Exceptions/Exception/Message')};
		string wuid{xpath('Workunit/Wuid')};
		
		// dataset(eclResultLayout) results{xpath('Workunit/Results/ECLResult')};
		dataset(eclResultLayout) results{xpath('Workunit/SourceFiles/ECLSourceFile')};
	
	end;

	export fRawInputs := 
	function
	
		userid 		:= _control.MyInfo.UserID;
		password	:= _control.MyInfo.Password;
		esp				:= if(_Flags.IsDataland
										,'dataland'
										,'prod'
		);
		
		results := SOAPCALL(
			'http://' + userid + ':' + password + '@' + esp + '_esp.br.seisint.com:8010/WsWorkunits?ver_=1.12'
			,'WUInfo'
			,wuinfoInRecord
			,dataset(wuinfoOutRecord)
			// ,heading('<WUInfoRequest>','</WUInfoRequest>')
			,xpath('WUInfoResponse')
		);

		return results;
		
	end;
	
	export fNormInputs(
	
		dataset(wuinfoOutRecord) pWorkunitRawInputs
	
	) :=
	function
	
		layout_names tNormfiles(wuinfoOutRecord l, eclResultLayout r) :=
		transform

			self.name := r.sourceFile;

		end;

		normit := normalize(pWorkunitRawInputs, left.results,tNormfiles(left,right));
		
		return normit;
	
	end;

end;