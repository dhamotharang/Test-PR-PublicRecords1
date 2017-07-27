import tools, corp, corp2_mapping;
export Files(

	 const string pversion							= ''
	,string				pstate								= ''	
	,boolean			pUseOtherEnvironment	= tools._Constants.IsDataland

) :=
module

  shared linput := Filenames(pversion,pstate,pUseOtherEnvironment).Input;
  shared lbase  := Filenames(pversion,,pUseOtherEnvironment).Base;
  shared laid   := Filenames(pversion,,pUseOtherEnvironment).AID;
  shared ltxbus := corp2_mapping.Filenames(pversion,,pUseOtherEnvironment).txbus_raw;

	export Input :=
	module
	
		export Corp		:= tools.macf_FilesInput(linput.Corp		,Corp2.Layout_Corporate_Direct_Corp_In	);
		export Cont		:= tools.macf_FilesInput(linput.Cont		,Corp2.Layout_Corporate_Direct_Cont_In	);
		export Events	:= tools.macf_FilesInput(linput.Events	,Corp2.Layout_Corporate_Direct_Event_In	);
		export Stock	:= tools.macf_FilesInput(linput.Stock		,Corp2.Layout_Corporate_Direct_Stock_In	);
		export AR			:= tools.macf_FilesInput(linput.AR			,Corp2.Layout_Corporate_Direct_AR_In		);	
		export txbus	:= tools.macf_FilesInput(ltxbus.ftact	  ,Layout_Tx_Ftact		                    );

	end;
	
	export Base :=
	module

		export Corp		:= tools.macf_FilesBase(lbase.Corp		,Corp2.Layout_Corporate_Direct_Corp_Base	);
		export Cont		:= tools.macf_FilesBase(lbase.Cont		,Corp2.Layout_Corporate_Direct_Cont_Base	);
		export Events	:= tools.macf_FilesBase(lbase.Events	,Corp2.Layout_Corporate_Direct_Event_Base	);
		export Stock	:= tools.macf_FilesBase(lbase.Stock	  ,Corp2.Layout_Corporate_Direct_Stock_Base	);
		export AR			:= tools.macf_FilesBase(lbase.AR			,Corp2.Layout_Corporate_Direct_AR_Base		);
	                                                      
	end;                                                 

	export AID :=
	module

		export Corp		:= tools.macf_FilesBase(laid.Corp		  ,Corp2.Layout_Corporate_Direct_Corp_AID	);
		export Cont		:= tools.macf_FilesBase(laid.Cont		  ,Corp2.Layout_Corporate_Direct_Cont_AID	);
	                                                      
	end;  
end;