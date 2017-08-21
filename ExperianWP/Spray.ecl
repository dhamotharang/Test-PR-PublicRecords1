import VersionControl;
export Spray := DATASET([
 	{'edata12-bld.br.seisint.com'										
 	,'/thor_back5/cellphones/experianwp/' + version                      
 	,'LEXIS_*.ebcdic'                           
 	,'429'                                                             
 	,'~thor_dell400::in::experianwp::@version@'    
 	,[{'~thor_dell400::in::experianwp'}]    
 	,'thor400_92'
	,ExperianWp.version
                          
 	}

], VersionControl.Layout_Sprays.Info);