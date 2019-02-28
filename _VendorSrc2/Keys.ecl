import doxie, tools;

export Keys(string		pversion = '',boolean pUseProd = false) := module

	shared Base					:= Files(pversion,pUseProd).Base.Built;

	shared FilterDids		:= Base(source_code		<> '');
	
	tools.mac_FilesIndex('FilterDids		,{source_code	}	  ,{FilterDids	}'	,keynames(pversion,pUseProd).source_code		,source_code	 );
	
end;
