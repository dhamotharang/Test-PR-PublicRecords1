import tools, corp, corp2_mapping;
export Files(

	 const string pversion							= ''
	,string				pstate								= ''	
	,boolean			pUseOtherEnvironment	= tools._Constants.IsDataland

) :=
module

  shared linput 		:= Filenames(pversion,pstate,pUseOtherEnvironment).Input;
	shared lbase_xtnd := Filenames(pversion,,pUseOtherEnvironment).Base_xtnd;	
  shared ltxbus 		:= corp2_mapping.Filenames(pversion,,pUseOtherEnvironment).txbus_raw;

	export Input :=
	module
	
		export Main		:= tools.macf_FilesInput(linput.Main		,Corp2_Mapping.LayoutsCommon.main				);
		export Events	:= tools.macf_FilesInput(linput.Events	,Corp2_Mapping.LayoutsCommon.Events			);
		export Stock	:= tools.macf_FilesInput(linput.Stock		,Corp2_Mapping.LayoutsCommon.Stock			);
		export AR			:= tools.macf_FilesInput(linput.AR			,Corp2_Mapping.LayoutsCommon.ar					);	
		export txbus	:= tools.macf_FilesInput(ltxbus.ftact	  ,Layout_Tx_Ftact		                    );

	end;
	
	export Base :=
	module

		export Corp		:= tools.macf_FilesBase(lbase_xtnd.Corp		,Corp2.Layout_Corporate_Direct_Corp_Base_expanded 	,pLayout_new := Corp2.Layout_Corporate_Direct_Corp_Base	);
		export Cont		:= tools.macf_FilesBase(lbase_xtnd.Cont		,Corp2.Layout_Corporate_Direct_Cont_Base_expanded 	,pLayout_new := Corp2.Layout_Corporate_Direct_Cont_Base	);
		export Events	:= tools.macf_FilesBase(lbase_xtnd.Events	,Corp2.Layout_Corporate_Direct_Event_Base_expanded 	,pLayout_new := Corp2.Layout_Corporate_Direct_Event_Base	);
		export Stock	:= tools.macf_FilesBase(lbase_xtnd.Stock	,Corp2.Layout_Corporate_Direct_Stock_Base_expanded	,pLayout_new := Corp2.Layout_Corporate_Direct_Stock_Base	);
		export AR			:= tools.macf_FilesBase(lbase_xtnd.AR			,Corp2.Layout_Corporate_Direct_AR_Base_expanded			,pLayout_new := Corp2.Layout_Corporate_Direct_AR_Base		);
	                                                      
	end;                                                 

	export AID :=
	module

		export Corp		:= tools.macf_FilesBase(lbase_xtnd.Corp	 ,Corp2.Layout_Corporate_Direct_Corp_Base_expanded	,pLayout_new := Corp2.Layout_Corporate_Direct_Corp_AID	);
		export Cont		:= tools.macf_FilesBase(lbase_xtnd.Cont	 ,Corp2.Layout_Corporate_Direct_Cont_Base_expanded	,pLayout_new := Corp2.Layout_Corporate_Direct_Cont_AID	);
	                                                      
	end;  
	
	export Base_xtnd :=
	module

		export Corp		:= tools.macf_FilesBase(lbase_xtnd.Corp		,Corp2.Layout_Corporate_Direct_Corp_Base_expanded	);
		export Cont		:= tools.macf_FilesBase(lbase_xtnd.Cont		,Corp2.Layout_Corporate_Direct_Cont_Base_expanded	);
		export Events	:= tools.macf_FilesBase(lbase_xtnd.Events	,Corp2.Layout_Corporate_Direct_Event_Base_expanded);
		export Stock	:= tools.macf_FilesBase(lbase_xtnd.Stock	,Corp2.Layout_Corporate_Direct_Stock_Base_expanded);
		export AR			:= tools.macf_FilesBase(lbase_xtnd.AR			,Corp2.Layout_Corporate_Direct_AR_Base_expanded		);
	                                                      
	end; 
	
	export stateFile:= dataset('~thor_data400::in::corp2::statesprocessed::super',Corp2_Mapping.LayoutsCommon.ProcessedStates,flat);

end;