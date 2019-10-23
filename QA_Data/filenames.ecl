IMPORT  tools;

EXPORT Filenames(
	 
	 STRING		pversion							= ''
	,BOOLEAN	pUseOtherEnvironment	= FALSE

) := MODULE

	SHARED lversiondate			:= pversion;
	SHARED lInputAddrRoot		:= _Constants(pUseOtherEnvironment).InputTemplate	+ 'addr_data'	;
	SHARED lInputTransRoot	:= _Constants(pUseOtherEnvironment).InputTemplate	+ 'trans_data'	;
	SHARED lfileRoot		    := _Constants(pUseOtherEnvironment).FileTemplate	+ 'data'	;

	EXPORT InputAddr	:= tools.mod_FilenamesInput(lInputAddrRoot ,lversiondate);
	EXPORT InputTrans	:= tools.mod_FilenamesInput(lInputTransRoot,lversiondate);
	EXPORT Base		    := tools.mod_FilenamesBuild(lfileRoot      ,lversiondate);
		     
	EXPORT dAll_filenames := Base.dAll_filenames; 

END;