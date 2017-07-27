import _control;

export _Dataset :=
module

	export Name										:= 'RedBooks'	;
	export thor_cluster_Files			:= if(	_Control.ThisEnvironment.name	= 'Dataland',
	                                            '~thor400_88::'
	                                            //'~thor_data50::',
												,'~thor_data400::');
												
	export thor_cluster_Persists	:= thor_cluster_Files	;
	export Groupname							:= if(	_Control.ThisEnvironment.name	= 'Dataland',
	                                                  // 'thor_data50'
													   'thor400_88' 
													   ,'thor_dell400');

end;