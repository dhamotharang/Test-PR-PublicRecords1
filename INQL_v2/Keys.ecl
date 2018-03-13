import doxie, tools;

export Keys(string pversion = '', boolean fcra = false, boolean pDaily = true) := module

	shared bINQL	:= INQL_v2.Files(,fcra,pDaily).bINQL_In_Bldg
												+ 
										if(pDaily, INQL_v2.Files(,fcra).bINQL_Common, INQL_v2.Files(,fcra,false).INQL_Base.built);
		
	tools.mac_FilesIndex('bINQL,	{t}	,	{bINQL}', INQL_v2.Keynames(pVersion, fcra, pDaily).INQL_Key, INQL_payload);
		
end;
