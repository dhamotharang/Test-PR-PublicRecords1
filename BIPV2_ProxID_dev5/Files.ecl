import tools,BIPV2_Files,Business_DOT; 

export Files(

	string pversion = ''

) :=
module

	export dotfile  := BIPV2_Files.files_dotid.DS_DOTID_BASE;
		
	export base     := tools.macf_FilesBase	(filenames(pversion).base	,layouts.dot_base);
	
end;