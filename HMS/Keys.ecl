IMPORT doxie, tools;

EXPORT Keys(

	 string		pversion							= ''
	,boolean pUseProd = false

) :=
MODULE

	SHARED Individual_Base				:= Files(pversion,pUseProd).Individual_Base.Built;
	EXPORT Individual_Provider_PIID					:= Individual_Base((string)HMS_PIID <> '');

	tools.mac_FilesIndex('Individual_Base	,{HMS_PIID}	  ,{Individual_Provider_PIID	}'	,keynames(pversion,pUseProd).Provider_PIID_key, Provider_PIID);
	
END;
