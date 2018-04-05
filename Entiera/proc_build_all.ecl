import _Control, _Validate, ut, Orbit3;
export Proc_Build_all(string pVersion) := function

#workunit('name','Yogurt:Entiera Build' + pVersion);

//spray file
/*
DoSpray := entiera.fn_SprayEntieraFiles('edata10',
                 '/ucc_new_build2/marriage_divorces/downloads/nv/20071203.DATA.k',
                 '~thor_200::in::mar_div::@version@::nv::divorce',
								 'DIV',
								 'NV');
*/
//Start Build Process
zCheckDate	:=	if((length(trim(pVersion)) not between 8 and 9) or (not _Validate.Date.fIsValid(pVersion[1..8], _Validate.Date.Rules.DayValid | _Validate.Date.Rules.DateInPast)),
									 fail('Error: Entiera.Proc_Build_All version parameter "' + pVersion + '" is invalid.')
									);


DoBuild := Proc_build_Entiera(pVersion);

//Create Sample Records for QA.
SampleRecs := Output(choosen(sort(dataset(Entiera.Entiera_Constants(pVersion).Cluster+'base::entiera::basefile',Entiera.Layouts.Base,flat),-process_date),1000));
					
create_orbit_build:= Orbit3.Proc_Orbit3_CreateBuild_npf ('Email Addresses',pVersion);					
					
retval := sequential(//DoSpray
								zCheckDate,
								DoBuild,
								SampleRecs,
								create_orbit_build
								) : success(Send_Email(pVersion).Build_Success), failure(Send_Email(pVersion).Build_Failure);
return retval;
end;


