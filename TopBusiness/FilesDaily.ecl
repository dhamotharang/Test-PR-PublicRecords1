import tools;
export FilesDaily(string pversion = '',boolean pUseOtherEnvironment = false) :=
module

	export Bankruptcy := module
		export Main := module
			tools.mac_FilesBase(FilenamesDaily(pversion,pUseOtherEnvironment).Bankruptcy.Main.Linked,Layout_Bankruptcy.Main.Linked,Linked);
		end;
		tools.mac_FilesBase(FilenamesDaily(pversion,pUseOtherEnvironment).Bankruptcy.Party,Layout_Bankruptcy.Party,Party);
	end;
end;
