import tools;

export Prep_File(
	 dataset(layouts.Input.raw				)	pSprayedFile			= Files().Input.raw.using
	,string															pPersistname			= persistnames().PrepFile
	,boolean														pShouldPersist		= true
	
) :=
function

	tools.mac_RedefineFormat(pSprayedFile,Layouts.input.Sprayed,loutput,,,[30,30]);

	doutput 					:= loutput(duns_number != '');
	doutput_persisted := doutput : persist(pPersistname);
	
	return if(pShouldPersist	,doutput_persisted
														,doutput
				);
	
end;
