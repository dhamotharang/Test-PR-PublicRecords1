import  tools;

export Filenames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lversiondate	:= pversion														;
	shared lfileRoot		:= _Constants(pUseOtherEnvironment).FileTemplate	+ 'source_ingest::data'	;

	export Source_Ingest		:= tools.mod_FilenamesBuild(lfileRoot                                           ,lversiondate);
	export Common_Base      := tools.mod_FilenamesBuild('~thor_data400::bipv2::internal_linking::@version@' ,lversiondate);
		     
	export dAll_filenames := 
			Source_Ingest.dAll_filenames
		; 

end;