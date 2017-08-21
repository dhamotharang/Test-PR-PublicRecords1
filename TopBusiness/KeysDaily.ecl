import doxie, tools,autokeyb2;

export KeysDaily(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) := module

	export Bankruptcy := module
		export Main := KeyPrepDaily_Bankruptcy_ID(FilesDaily(pversion,pUseOtherEnvironment).Bankruptcy.Main.Linked.Built,pversion,pUseOtherEnvironment);
		export Party := KeyPrepDaily_Bankruptcy_Party(FilesDaily(pversion,pUseOtherEnvironment).Bankruptcy.Party.Built,pversion,pUseOtherEnvironment);
	end;
	export Source := KeyPrepDaily_Source_ID(
		// FilesDaily(pversion,pUseOtherEnvironment).Linking.Linked.Built,
		// FilesDaily(pversion,pUseOtherEnvironment).Industry.Linked.Built,
		// FilesDaily(pversion,pUseOtherEnvironment).Abstract.Linked.Built,
		// FilesDaily(pversion,pUseOtherEnvironment).UCC.Main.Linked.Built,
		// FilesDaily(pversion,pUseOtherEnvironment).Liens.Main.Linked.Built,
		// FilesDaily(pversion,pUseOtherEnvironment).Aircraft.Main.Linked.Built,
		// FilesDaily(pversion,pUseOtherEnvironment).Watercraft.Main.Linked.Built,
		// FilesDaily(pversion,pUseOtherEnvironment).Incorporation.Linked.Built,
		// FilesDaily(pversion,pUseOtherEnvironment).Mark.Linked.Built,
		FilesDaily(pversion,pUseOtherEnvironment).Bankruptcy.Main.Linked.Built,
		// FilesDaily(pversion,pUseOtherEnvironment).Finance.Linked.Built,
		// FilesDaily(pversion,pUseOtherEnvironment).Property.Main.Linked.Built,
		pversion,
		pUseOtherEnvironment);

end;
