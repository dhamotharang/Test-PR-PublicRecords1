#workunit('name', 'Corporation (SOS) Query of Processed items');
#OPTION('AllowedClusters',thor400_44,thor400_60,hthor');
#option ('activitiesPerCpp', 50);

new_ly := record
string st;
string date;
string filedate;
end;

//Uncomment the dOrig line below depending on what you want to do and fill in the approriate fields.
filterset := ['AZ','MI','ND','KS'];
processed_superfile := dataset('~thor_data400::corpv2::processed', new_ly , flat)(st in filterset);
//Example below shows all dates processed and what version they are in for a particular state.
//dOrig	:= TABLE ( SORT (processed_superfile   (st = 'MO'), { st,date,filedate } ) , { st ,  date ,  filedate } ) ;
//Example below, shows combining a filter on state and tapeload date.
dOrig := TABLE ( SORT (processed_superfile (filedate > '20160601'),	{ st,date,filedate } ) , { st ,  date ,  filedate } ) ;																
////Example below shows writing outeverything sorted by state,date, version processed.
//dOrig := TABLE ( SORT (processed_superfile,{ st,date,filedate } ) , { st ,  date ,  filedate }	);																	
//dOrig := TABLE ( SORT (processed_superfile (filedate > '20140101'),{ st, date, filedate } ) , { st ,  date ,  filedate }	);																	
///
//Example below shows writing out everything in a particular version	
//dOrig := TABLE ( SORT (processed_superfile (filedate='20131202'),{ st,date,filedate } ) , { st ,  date ,  filedate });																		

//Example below shows writing out everything in superfile
//dOrig := TABLE ( SORT (processed_superfile , {filedate,st,date} ) , { filedate,st,date });																		
//dMax := MAX(dOrig,dOrig.st, dOrig.state,dOrig.filedate);
//Output(dOrig (filedate > '20131120'), NAMED('Processed_all'),all);															
//Output(dOrig , NAMED('Processed as of ' + ut.getdate),all);															
output(dOrig , NAMED('ALL'),all);															
