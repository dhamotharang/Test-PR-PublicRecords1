import _Control, _Validate, ut;
#option('multiplePersistInstances',FALSE);

export Proc_Build_all(string pVersion) := function

#workunit('name','Entiera Build');

//Start Build Process
zCheckDate	:=	if((length(trim(pVersion)) not between 8 and 9) or (not _Validate.Date.fIsValid(pVersion[1..8], _Validate.Date.Rules.DayValid | _Validate.Date.Rules.DateInPast)),
									 fail('Error: Entiera.Proc_Build_All version parameter "' + pVersion + '" is invalid.')
									);


DoBuild := Proc_build_Entiera(pVersion);

//Create Sample Records for QA.
SampleRecs := Output(choosen(sort(dataset(Entiera.Entiera_Constants(pVersion).Cluster+'base::entiera::basefile',Entiera.Layouts.Base,flat),-process_date),1000));
					
retval := sequential(//DoSpray
								zCheckDate,
								DoBuild,
								SampleRecs
								) : success(Send_Email(pVersion).Build_Success), failure(Send_Email(pVersion).Build_Failure);
return retval;
end;




