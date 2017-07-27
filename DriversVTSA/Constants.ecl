import _Control;

export Constants := module
	export cluster :=  IF(_Control.ThisEnvironment.name='Dataland', '~thor400_88::', '~thor400_92::');
	//export autokey_keyname	  := '~thor400_88::key::scankdl::autokey::'+filedate+'::';
	export autokey_keyname	  := cluster + 'key::dl_VTSA::autokey::@version@::';
	export autokey_qa_Keyname := cluster + 'key::dl_VTSA::autokey::qa::';  
	
	export autokey_logical(string filedate) :=  cluster + 'key::dl_VTSA::' + filedate + '::autokey::';
	export autokey_typeStr  := '';
	export autokey_skipSet  := ['B','P','Q','F'];
	export IncludeHistory := module
			export history := 'H';
			export current := 'C';
			export allRows	:= 'A';
	end;
	// This set specifies the sources that require opt-in at runtime via "IncludeNonDMV"
	export nonDMVSources := [ ];
end;