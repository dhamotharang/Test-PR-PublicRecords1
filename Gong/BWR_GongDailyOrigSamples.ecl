//Go to edata11 /gong/gong/lss/samples to obtain full file name Ex: lss.sample_20070315_154046.d00


d := FileServices.SprayFixed('10.150.12.242', '/gong/gong/lss/samples/Enter Full File Name Here',2415, 'thor_200', 
							  '~thor_200::in::gong::master::orig::lss', , , ,true,true,false);
					
sequential(d,Gong.stats_SampleOrigLSS);

//Run on thor_200 cluster then email results as a .csv file to qualityassurance@seisint.com