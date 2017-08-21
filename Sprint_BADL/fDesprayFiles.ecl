import versioncontrol, _control, business_header;

export fDesprayFiles(
	 string		pversion	
	,string		pServer			= _control.IPAddress.edata10
	,string		pMount			= '/prod_data_build_13/eval_data/sprint_badl/'
	,boolean	pOverwrite	= false

) := 
function


	myfilestodespray := dataset([
		
		 {	 Filenames(pversion).Base.Exist.new,pServer,pMount + 'LN_DELTA_BUS_EXIST_'	+ pversion + '.OUT'}
		,{	 Filenames(pversion).Base.Fraud.new,pServer,pMount + 'LN_DELTA_BUS_FRAUD_'	+ pversion + '.OUT'}
		,{	 Filenames(pversion).Base.WO.new	 ,pServer,pMount + 'LN_DELTA_BUS_WO_'			+ pversion + '.OUT'}
                                                             
	], versioncontrol.Layout_DKCs.Input);

	return versioncontrol.fDesprayFiles(myfilestodespray,,,'DespraySprintBADLInfo',pOverwrite);

end;