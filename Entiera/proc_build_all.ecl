import _Control;
export Proc_Build_all(string version) := function

//spray file
/*
DoSpray := entiera.fn_SprayEntieraFiles('edata10',
                 '/ucc_new_build2/marriage_divorces/downloads/nv/20071203.DATA.k',
                 '~thor_200::in::mar_div::@version@::nv::divorce',
								 'DIV',
								 'NV');
*/
//Start Build Process
DoBuild := Proc_build_Entiera(version);

//Create Sample Records for QA.
SampleRecs := Output(choosen(sort(dataset(Entiera.Entiera_Constants(version).Cluster+'base::entiera::basefile',entiera.All_Entiera_Layouts.Entiera_final_layout,flat),-process_date),1000));
					
retval := sequential(//DoSpray
								DoBuild,
								SampleRecs
								) : success(Send_Email(version).Build_Success), failure(Send_Email(version).Build_Failure);
return retval;
end;


