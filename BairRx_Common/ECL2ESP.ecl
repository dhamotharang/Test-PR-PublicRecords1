import ut,iesp;
EXPORT ECL2ESP := MODULE 
	
	EXPORT iesp.share.t_TimeStamp toTimeStamp(STRING d) := ROW(TRANSFORM(iesp.share.t_TimeStamp,
										Self.Year   := (INTEGER2) d[1..4], 
										Self.Month  := (INTEGER2) d[6..7], 
										Self.Day    := (INTEGER2) d[9..10],
										Self.Hour24 := (INTEGER2) d[12..13],	
										Self.Minute := (INTEGER2) d[15..16],
										Self.Second := (INTEGER2) d[18..19]));			
	
	EXPORT string8 t_DateToString8(iesp.share.t_Date inDate) := function
		string8 outDate := (string)(inDate.day+(inDate.month*100)+(inDate.year*10000));
		return if(outDate='0','',outDate);
	end;
	
	// FOr converting from format YYYYMMDDHHMISS
	EXPORT iesp.share.t_TimeStamp toTimeStamp2(STRING d) := ROW(TRANSFORM(iesp.share.t_TimeStamp,
										Self.Year   := (INTEGER2) d[1..4], 
										Self.Month  := (INTEGER2) d[5..6], 
										Self.Day    := (INTEGER2) d[7..8],
										Self.Hour24 := (INTEGER2) d[9..10],	
										Self.Minute := (INTEGER2) d[11..12],
										Self.Second := (INTEGER2) d[13..14]));			
	
	
	
	EXPORT iesp.share.t_Date String8Tot_Date (string8 d) := 
  row ({(integer2) d[1..4],(integer2) d[5..6],(integer2) d[7..8]}, iesp.share.t_Date);  
	
	shared string q_id := '' : stored ('_QueryId');
  shared string t_id := '' : stored ('_TransactionId');
  EXPORT GetHeaderRow () := ROW ({0, '', q_id, t_id, []}, iesp.share.t_ResponseHeader);
	
	export Marshall := module
		export integer return_count			:= 20  	 : stored('ReturnCount');			// records per page
		export integer starting_record	:= 1	 	 : stored('StartingRecord');	// which record page starts with
		export integer in_max_results 	:= 0 		 : stored('MaxResults');	
		export integer max_results			:= if(in_max_results > 0, in_max_results, 100);
	
		export Mac_Set (tag_options) := macro
			unsigned ReturnCount := global(tag_options).ReturnCount;
			#stored ('ReturnCount', ReturnCount);
			unsigned StartingRecord := global(tag_options).StartingRecord;
			#stored ('StartingRecord', StartingRecord);
			unsigned MaxResults := global(tag_options).MaxResults;
			#stored ('MaxResults', MaxResults);
		endmacro;	
	
		export integer max_results_to_return := IF(max_results>0 AND max_results<=5000, max_results, 500);	
	
		export integer max_return := ut.Min2(return_count, max_results_to_return);
	
		export MAC_Marshall_Results(infile,outfile,l_out,match_count,recField='Records',noCount=False,countField='RecordCount'
																,extraField1='',extraValue1='',extraField2='',extraValue2='',noPaging=False) := macro
			#uniquename(cnt)														
			#uniquename(xform)
			l_out %xform%() := transform
				self._Header			:= BairRx_Common.ECL2ESP.GetHeaderRow();
				#if(noCount=false)
					%cnt% := count(infile); 
					SELF.matchcount := match_count,
					self.countField	:= %cnt%,
					self.recField		:= IF(noPaging, infile, choosen(infile, BairRx_Common.ECL2ESP.Marshall.max_return, BairRx_Common.ECL2ESP.Marshall.starting_record));
				#else
					self.recField		:= infile,
				#end
				#if(#TEXT(extraField1)<>'')
					self.extraField1	:= extraValue1,
				#end	
				#if(#TEXT(extraField2)<>'')
					self.extraField2	:= extraValue2,
				#end	
				SELF := []
			end;
			outfile := dataset([%xform%()]);
		endmacro;
end;
End;

