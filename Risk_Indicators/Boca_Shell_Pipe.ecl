import risk_indicators;

export Boca_Shell_Pipe(dataset(risk_indicators.Layout_Batch_In) indataset,
												unsigned dppa_purpose='0', unsigned glb_purpose, STRING industry_class='',
												boolean ln_branded, STRING6 history_date='999999') := function
	
insize := sizeof(risk_indicators.Layout_Batch_In);
outsize := sizeof(risk_indicators.Layout_Boca_Shell);

options := '<DPPAPurpose>'+(STRING)dppa_purpose+'</DPPAPurpose>' +
		 '<GLBPurpose>'+(STRING)glb_purpose+'</GLBPurpose>' +
		 '<IndustryClass>'+industry_class+'</IndustryClass>'+
		 '<LnBranded>'+(STRING)ln_branded+'</LnBranded>'+
		 '<HistoryDateYYYYMM>'+history_date+'</HistoryDateYYYYMM>';
					
roxie_ip := '10.173.202.4:9876';

// find out what all of the little commands in here mean	
outfile := PIPE(indataset, 'roxiepipe -iw '+ insize +' -t 1 -ow '
								+ outsize	+' -b 10 -mr 2 -q "'
								+ '<Risk_Indicators.Boca_Shell_Batch  format=\'raw\'>'
								+ options +'<batch_in id=\'id\' format=\'raw\'></batch_in>'
								+ '</Risk_Indicators.Boca_Shell_Batch>" -h ' 
								+ roxie_ip + ' -r Results', risk_indicators.Layout_Boca_Shell);											
	
return outfile;

end;