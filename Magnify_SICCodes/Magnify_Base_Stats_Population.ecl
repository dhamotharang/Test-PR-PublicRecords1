export Magnify_Base_Stats_Population(string filedate,string ExportOutDate) := function;


	SIC_OUT_DS			:= Magnify_SICCodes.File_magnifySICCodes_base;
   								
	SIC_IN_DS 			:= Magnify_SICCodes.File_raw_in;	
	
	SUBSCRIBER			:= 'MAGNIFY';
	SUBSCRIBER_ID       := '200604';
	INPUT_FILE 			:= 'SICCodes.txt';
	BATCH_ID            := thorlib.WUID();
	RECEIVE_FILE_DATE	:= filedate	;
	EXPORT_DATE			:= ExportOutDate;
   
  TOTAL_NUMBER_OF_RECORDS_ON_INPUT_FILE		:= count(SIC_IN_DS);
  
  	H_rec :=record
		string  sic_code;
	end;
	
 H_rec transH(SIC_IN_DS l, SIC_OUT_DS r):=transform
   	 self.sic_code:=r.sic;
 end;
   	 //If the sic_code was found in the data its a hit
   	 TOTAL_NUMBER_OF_HITS:=join(SIC_IN_DS ,SIC_OUT_DS,
   	                     trim(left.sic_code,left,right)=trim(right.sic,left,right),
   						  transH(left,right)
   						 );

	
 H_rec transM(SIC_IN_DS l, SIC_OUT_DS r):=transform
   	 self.sic_code:=l.sic_code;
 end;
  //If no records were found for specific input sic_code
   TOTAL_NUMBER_OF_MISSES:=join(SIC_IN_DS ,SIC_OUT_DS,
   	                     trim(left.sic_code)=trim(right.sic),
   						  transM(left,right),
   						 left ONLY);
						 
						 
  R_rec :=record
		string  reject_sic_code;
  end;
	
  R_rec transR(SIC_IN_DS l):=transform
   	 self.reject_sic_code:=if(length(trim(l.sic_code,left,right))>4,l.sic_code,'');
 end;
   	 //If there was something wrong with the record itself, I.e. if somehow the input was 123456 as sic code and we were expecting only 4 digit sic_code as 1234.
   	TOTAL_NUMBER_OF_REJECTS:=project(SIC_IN_DS , transR(left));
 
  TOTAL_NUMBER_OF_RECORDS_ON_OUTPUT_FILE	:= COUNT(SIC_OUT_DS);
  
      rec_stats:=record
		string FOR_INPUT_SIC_CODE		:= SIC_OUT_DS.Sic_code;	
		integer RECORDS_FOUND 			:= count(group);
      End;
	  
  RECORDS_FOUND		:= table(SIC_OUT_DS,rec_stats,Sic_code);
  
stats_layout := record
  string name;
  string results;
end;
  
stats_layout reformat(rec_stats l) := transform
	self.name	:= 'RECORD COUNT FOR SIC CODE: ' + l.FOR_INPUT_SIC_CODE ;
	self.results	:= (string)l.RECORDS_FOUND;
end;
  
projected_recs_found := project(RECORDS_FOUND, reformat(left));

stats_results := dataset([{'SUBSCRIBER',SUBSCRIBER}
									,{'SUBSCRIBER_ID',SUBSCRIBER_ID}
									,{'INPUT_FILE',INPUT_FILE}
									,{'BATCH_ID',BATCH_ID}
									,{'RECEIVE_FILE_DATE',RECEIVE_FILE_DATE}
									,{'EXPORT_DATE',EXPORT_DATE}
									,{'TOTAL_NUMBER_OF_RECORDS_ON_INPUT_FILE',TOTAL_NUMBER_OF_RECORDS_ON_INPUT_FILE}
									,{'TOTAL_NUMBER_OF_HITS',(string)(count(dedup(TOTAL_NUMBER_OF_HITS,sic_code)))}
									,{'TOTAL_NUMBER_OF_MISSES',(string)(count(TOTAL_NUMBER_OF_MISSES))}
									,{'TOTAL_NUMBER_OF_REJECTS',(string)(count(TOTAL_NUMBER_OF_REJECTS(reject_sic_code<>'')))}
									,{'TOTAL_NUMBER_OF_RECORDS_ON_OUTPUT_FILE',TOTAL_NUMBER_OF_RECORDS_ON_OUTPUT_FILE}]
									, stats_layout);
  
final_results := stats_results + projected_recs_found;

statsoutputfile := output(final_results,,'~thor_data400::out::'+filedate+'::magnify_Extract_stats', csv, overwrite);
  
results			  :=sequential(output(SUBSCRIBER,named('SUBSCRIBER'))
								,output(SUBSCRIBER_ID,named('SUBSCRIBER_ID'))
								,output(INPUT_FILE,named('INPUT_FILE'))
								,output(BATCH_ID,named('BATCH_ID'))
								,output(RECEIVE_FILE_DATE,named('RECEIVE_FILE_DATE'))
								,output(EXPORT_DATE,named('EXPORT_DATE'))
								,output(TOTAL_NUMBER_OF_RECORDS_ON_INPUT_FILE,named('TOTAL_NUMBER_OF_RECORDS_ON_INPUT_FILE'))
								,output(count(dedup(TOTAL_NUMBER_OF_HITS,sic_code)),named('TOTAL_NUMBER_OF_HITS'))
								,OUTPUT(count(TOTAL_NUMBER_OF_MISSES),named('TOTAL_NUMBER_OF_MISSES'))
								,output(count(TOTAL_NUMBER_OF_REJECTS(reject_sic_code<>'')),named('TOTAL_NUMBER_OF_REJECTS'))
								,output(TOTAL_NUMBER_OF_RECORDS_ON_OUTPUT_FILE,named('TOTAL_NUMBER_OF_RECORDS_ON_OUTPUT_FILE'))
								,output(RECORDS_FOUND,named('RECORDS_FOUND_FOR_INPUT_SIC_CODE'))
								,statsoutputfile
							  );
   
  return results;
  end;
