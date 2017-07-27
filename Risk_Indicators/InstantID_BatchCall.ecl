/*
export InstantID_BatchCall(dataset(Layout_Batch_In) indataset, unsigned1 DPPA_Purpose, unsigned1 GLB_Purpose, 
						STRING5 industry_class_value, boolean ln_branded_value,  boolean ofac_only, unsigned3 history_date, string roxie_ip) := function
	
	insize := sizeof(risk_indicators.Layout_Batch_In);
	//outsize := 1; //sizeof(Layout_InstandID_NuGen);
	outsize := sizeof(risk_indicators.Layout_InstantID_NuGen_Denorm);
				
	options := '<DPPAPurpose>'+DPPA_purpose+'</DPPAPurpose>' +
			 '<GLBPurpose>'+GLB_Purpose+'</GLBPurpose>' +
			 '<IndustryClass>'+industry_class_value+'</IndustryClass>' +
			 '<LnBranded>'+ln_branded_value+'</LnBranded>' +
			 '<OfacOnly>'+ofac_only+'</OfacOnly>' +
			 '<HistoryDateYYYYMM>'+history_date+'</HistoryDateYYYYMM>';
	
	// find out what all of the little commands in here mean	
	outfile := PIPE(indataset, 'roxiepipe -iw '+ insize +' -t 2 -ow '
									+ outsize	+' -b 1 -mr 2 -q "'
									+ '<Risk_Indicators.InstantID_Batch  format=\'raw\'>'
									+ options +'<batch_in id=\'id\' format=\'raw\'></batch_in>'
									+ '</Risk_Indicators.InstantID_Batch>" -h ' 
									+ roxie_ip + ' -r Results', risk_indicators.Layout_InstantID_NuGen_Denorm);								
	
	return outfile;

end;
*/


export InstantID_BatchCall(inf, outf, DPPA_Purpose, GLB_Purpose, 
					industry_class_value, ln_branded_value,  ofac_only, history_date, roxie_ip) := macro

#uniquename(insize)
#uniquename(outsize)
%insize% := sizeof(risk_indicators.Layout_Batch_In);
%outsize% := sizeof(risk_indicators.Layout_InstantID_NuGen_Denorm);

#uniquename(options)
%options% := '<DPPAPurpose>'+DPPA_purpose+'</DPPAPurpose>' +
			 '<GLBPurpose>'+GLB_Purpose+'</GLBPurpose>' +
			 '<IndustryClass>'+industry_class_value+'</IndustryClass>' +
			 '<LnBranded>'+(string)ln_branded_value+'</LnBranded>' +
			 '<OfacOnly>'+(string)ofac_only+'</OfacOnly>' +
			 '<HistoryDateYYYYMM>'+history_date+'</HistoryDateYYYYMM>';



outf := PIPE(inf, 'roxiepipe -iw '+ %insize% +' -t 2 -ow '
									+ %outsize%	+' -b 1 -mr 2 -q "'
									+ '<Risk_Indicators.InstantID_Batch  format=\'raw\'>'
									+ %options% +'<batch_in id=\'id\' format=\'raw\'></batch_in>'
									+ '</Risk_Indicators.InstantID_Batch>" -h ' 
									+ roxie_ip + ' -r Results', risk_indicators.Layout_InstantID_NuGen_Denorm);
									

endmacro;





