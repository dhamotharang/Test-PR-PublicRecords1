import tools;
export Files(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	tools.mac_FilesInput(Filenames(pversion,pUseProd).Input	,Layout_YellowPages							,Input	);
	tools.mac_FilesBase	(Filenames(pversion,pUseProd).Base	,Layout_YellowPages_Base_V2_bip	,Base		);

end;