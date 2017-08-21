import tools, _control;

export Despray(

	 string		pversion
	,string		pServer			= _control.IPAddress.edata10
	,string		pMount			= '/prod_data_build_13/eval_data/judge_data/'
	,boolean	pOverwrite	= false

) := 
function


	myfilestodespray := dataset([
		
		 {Filenames(pversion).out.new	,pServer	,pMount + '/judges' + pversion + '.csv'	}

	], tools.Layout_DKCs.Input);

	return tools.fun_Despray(myfilestodespray,,,'DesprayJudgesInfo',pOverwrite);

end;