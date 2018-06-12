import VersionControl, _control;
export Spray(

	//string pDirectory = '/data/hds_180/advo/spray'
	string pDirectory = '/data/hds_180/advo/spray'

) :=
function

	return
	DATASET([
		{ _control.IPAddress.bctlpedata11										
		,pDirectory                      
		,'VNEF_BASE_AID_*.dat'                           
		,'302'                                                             
		,Filenames().input.template    
		,[{Filenames().input.sprayed	}]
		,_dataset().groupname
																	
		}

	], VersionControl.Layout_Sprays.Info);
	
end;