import VersionControl;

export Spray := module

export Input1 := DATASET([
 	{'edata14-bld.br.seisint.com'
 	,'/load01/wired_assets/privider_1/'
 	,'*.txt'
 	,'454'
 	,'~thor_dell400::in::OptinCellphones_Build::@version@'
 	,[{'~thor_data400::in::OptinCellphones_build'}]
 	,'thor400_92'
	,version

 	}

], VersionControl.Layout_Sprays.Info);

export Input1_csv := DATASET([
 	{'edata14-bld.br.seisint.com'
 	,'/load01/wired_assets/privider_1/'
 	,'*.csv'
 	,'454'
 	,'~thor_dell400::in::OptinCellphones_Build::@version@'
 	,[{'~thor_data400::in::OptinCellphones_build'}]
 	,'thor400_92'
	,version

 	}

], VersionControl.Layout_Sprays.Info);

export Input2 := DATASET([
 	{'edata14-bld.br.seisint.com'
 	,'/load01/wired_assets/provider_2/' 
 	,'*.txt'
 	,0
 	,'~thor_dell400::in::OptinCellphones_Build2::@version@'
 	,[{'~thor_data400::in::OptinCellphones_build2'}]
 	,'thor400_92'
	,''
	,'[0-9]{8}'
	,'VARIABLE'
 	}

], VersionControl.Layout_Sprays.Info);

end;