import versioncontrol, _control;

export Despray_Extracts(

	 string		pversion
	,string		pServer			= _control.IPAddress.edata10
	,string		pMount			= '/prod_data_build_10/production_data/business_headers/martindale_hubbell/extracts/'
	,boolean	pOverwrite	= false

) := 
function


	myfilestodespray := dataset([
		
		 {Filenames(pversion).extracts.Organizations.new						,pServer	,pMount + '/Organizations.csv'						}
		,{Filenames(pversion).extracts.Affiliated_Individuals.new		,pServer	,pMount + '/Affiliated_Individuals.csv'		}
		,{Filenames(pversion).extracts.Unaffiliated_Individuals.new	,pServer	,pMount + '/Unaffiliated_Individuals.csv'	}

	], versioncontrol.Layout_DKCs.Input);

	return versioncontrol.fDesprayFiles(myfilestodespray,,,'DesprayMartindaleExtractsInfo',pOverwrite);

end;