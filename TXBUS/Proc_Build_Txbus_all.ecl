import _control, TXBUS, orbit_report,tools;

#OPTION('multiplePersistInstances',FALSE);

export Proc_Build_Txbus_all(STRING filedate,STRING thorName,STRING hostname,STRING srcDir = '/data/data_build_1/txbus/build/') := function

//Clean input file.
Mac_Txbus_Spray(hostname
								,srcDir+filedate+'/'
								,filedate
								,filedate
								,'TX_'+filedate+'_STACT.txt'
								,thorName
								,DoClean);


//Start Build Process
pIsTesting := TXBUS._Flags.IsTesting;
DoBuild    := Proc_build_Txbus(filedate,pIsTesting);

//Do Orbit Report
orbit_report.txbus_stats(doReport);
					
retval := sequential(DoClean
										 ,DoBuild
										 ,doReport
										 ,SampleRecs
										 ,Promote
										 ) : success(Send_Email(filedate).Build_Success), failure(Send_Email(filedate).Build_Failure);
return retval;
end;