import tools,Data_Services;

export Keynames_Scoring(

	 string		pversion							= '',
   boolean pUseProd = false

) :=
module

	export lFileTemplate	    := Data_Services.Data_location.Prefix()+'thor_data400::key::phonesplus_scoring::@version@::'	;

	shared laddress			:= lFileTemplate + 'address'		;
	shared lPhone			:= lFileTemplate + 'phone'		;

	export address	:= tools.mod_FilenamesBuild(laddress	,pversion);
	export phone	:= tools.mod_FilenamesBuild(lPhone	,pversion);
	export dAll_filenames := 
				 address.dAll_filenames
				+ phone.dAll_filenames
		;

end;