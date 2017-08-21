import _control,wk_ut;

EXPORT mod_dfuInfo(string pWorkunitID = '',string pESp = wk_ut._Constants.LocalEsp) :=
module
	export GetDFUWorkunitInRecord :=
	record, maxlength(100)
		string  wuid             {xpath('wuid'                   )} := pWorkunitID;
	end;
	

	export GetDFUWorkunitOutRecord :=
	record, maxlength(100000)
	
		string exception_code     {xpath('Exceptions/Exception/Code'    )};
		string exception_source   {xpath('Exceptions/Exception/Source'  )};
		string exception_msg      {xpath('Exceptions/Exception/Message' )};
    string DestLogicalName    {xpath('result/DestLogicalName'       )};
	end;

		userid 		:= _control.MyInfo.UserID;
		password	:= _control.MyInfo.Password;
		// esp				:= if(_Constants.IsDataland
                  // ,'10.241.12.204:8010'	//oss is 242,infiniband is '10.241.3.242'
                  // ,'prod:8010'
                // );
    export myurl := 'http://' + pESp + ':8010/FileSpray';
    export myesp := pESp;
    
		export results := SOAPCALL(
			myurl
			,'GetDFUWorkunit'
			,GetDFUWorkunitInRecord
			,dataset(GetDFUWorkunitOutRecord)
			// ,heading('<WUInfoRequest>','</WUInfoRequest>')
			,xpath('GetDFUWorkunitResponse')
      ,literal
		);
		

  export DestLogicalName := results[1].DestLogicalName;
  
  // export fNormResults(
	
		// dataset(wuinfoOutRecord) pWorkunitRawInputs = fWUInfo()
	
	// ) :=
	// function
	
		// eclResultLayout tNormfiles(wuinfoOutRecord l, eclResultLayout r) :=
		// transform
			// self.name   := r.Name;
			// self.value  := r.Value;
		// end;
		// normit := normalize(pWorkunitRawInputs, left.results,tNormfiles(left,right));
		
		// return normit;
	
	// end;

	// export fWUGraphTiming := 
	// function
	
		// userid 		:= _control.MyInfo.UserID;
		// password	:= _control.MyInfo.Password;
		// esp				:= if(_Constants.IsDataland
                  // ,'10.241.3.243:8010'	//oss is 242,infiniband is '10.241.3.242'
                  // ,'prod:8010'
                // );

		// results := SOAPCALL(
			// 'http://' + esp + '/WsWorkunits?ver_=1.30'
			// ,'WUGraphTiming'
			// ,wuinfoInRecord
			// ,dataset(wuinfoOutRecord)
			// ,heading('<WUInfoRequest>','</WUInfoRequest>')
			// ,xpath('WUGraphTimingResponse')
		// );
		// return results;
		
	// end;

/*	
	export fNormInputs(
	
		dataset(wuinfoOutRecord) pWorkunitRawInputs
	
	) :=
	function
	
		Layout_Names tNormfiles(wuinfoOutRecord l, eclResultLayout r) :=
		transform
			self.name := r.sourceFile;
		end;
		normit := normalize(pWorkunitRawInputs, left.results,tNormfiles(left,right));
		
		return normit;
	
	end;
*/
	// export fNormGraphs(
	
		// dataset(wuinfoOutRecord) pWorkunitRawInputs
	
	// ) :=
	// function
	
		// eclGraphResultLayout tNormfiles(wuinfoOutRecord l, eclGraphResultLayout r) :=
		// transform
			// self := r;
		// end;
		// normit := normalize(pWorkunitRawInputs, left.graphs,tNormfiles(left,right));
		
		// return normit;
	
	// end;
  
	// export fNormWorkflows(
	
		// dataset(wuinfoOutRecord) pWorkunitRawInputs
	
	// ) :=
	// function
	
		// eclWorkflowsResultLayout tNormfiles(wuinfoOutRecord l, eclWorkflowsResultLayout r) :=
		// transform
			// self := r;
		// end;
		// normit := normalize(pWorkunitRawInputs, left.Workflows,tNormfiles(left,right));
		
		// return normit;
	
	// end;
	// export fNormTimingData(
	
		// dataset(wuinfoOutRecord) pWorkunitRawInputs
	
	// ) :=
	// function
	
		// eclTimingDataResultLayout tNormfiles(wuinfoOutRecord l, eclTimingDataResultLayout r) :=
		// transform
			// self := r;
		// end;
		// normit := normalize(pWorkunitRawInputs, left.TimingData,tNormfiles(left,right));
		
		// return normit;
	
	// end;

end;

                                                                            