import business_header, tools;

export FilenamesDaily(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lversiondate	:= pversion														;
	
  shared ftemplate(string pFiletype, string pCategory, string pSubset, string pStatus = '')	:=
		tools.mod_FilenamesBuild(_Dataset().thor_cluster_files + pFiletype + '::' + _Dataset().name + 'daily::' + pCategory + '::@version@::' + pSubset + if(pStatus = '','','::' + pStatus),lversiondate);

	shared template(string pFiletype,string pCategory,string pSubset) := module
		export Linked   := ftemplate(pFiletype,pCategory,pSubset,'linked'  );
		export dAll_filenames :=
			Linked.dAll_filenames;
	end;
	
	
	export Bankruptcy := module
		export Main := template('base','bankruptcy','main');
		export Party := ftemplate('base','bankruptcy','party');
		export dAll_filenames :=
			Main.dAll_filenames +
			Party.dAll_filenames;
	end;

	export dAll_filenames := 
			Bankruptcy.dAll_filenames
		; 

end;
