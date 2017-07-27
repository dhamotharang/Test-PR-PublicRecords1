import tools, _control;

export Spray(

	 string		pversion				= ''
	,string		pServerIP				= _control.IPAddress.edata10
	,string		pDirectory			= '/prod_data_build_13/eval_data/debt_settlement'
	,string		pFilename1			= 'attroney_file_did_stats.csv'
	,string		pFilename2			= 'DebtSettlementCreditCounsel.csv'
	,string		pGroupName			= _Constants().groupname																		
	,boolean	pIsTesting			= false
	,boolean	pOverwrite			= false
	,string		pNameOutput			= _Constants().Name + ' Spray Info'
	,boolean	pExistRSIHSprayed	= _Flags.ExistCurrentRSIHSprayed
	,boolean	pExistCCSprayed		= _Flags.ExistCurrentCCSprayed

) :=
function

	FilesToSpray := DATASET([

		{pServerIP
	 	,pDirectory
	 	,pFilename1
	 	,0
	 	,Filenames().inputRSIH.Template
	 	,[ {Filenames().inputRSIH.sprayed	}	]
		,pGroupName
		,''
		,'[0-9]{8}'
		,'VARIABLE'
		,''
		,_Constants().max_record_size
	 	},
	
		{pServerIP
	 	,pDirectory
	 	,pFilename2
	 	,0
	 	,Filenames().inputCC.Template
	 	,[ {Filenames().inputCC.sprayed	}	]
		,pGroupName
		,''
		,'[0-9]{8}'
		,'VARIABLE'
		,''
		,_Constants().max_record_size
	 	}
	], tools.Layout_Sprays.Info);
		
	return if(					pDirectory != ''
							and (not pExistRSIHSprayed or pExistCCSprayed)
						,tools.fun_Spray(FilesToSpray,,,pOverwrite,,false,pIsTesting,,_Constants().Name + ' ' + pversion,pNameOutput));

end;
