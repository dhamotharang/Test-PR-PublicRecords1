import tools;
export Files(string pversion = '',boolean pUseOtherEnvironment = false) :=
module

	export Abstract := module
		tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Abstract.Linked,Layout_Abstract.Linked,Linked);
	end;

  export Aircraft := module
	  export Main := module
			tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Aircraft.Main.Linked,Layout_Aircraft.Main.Linked,Linked);
		end;
		tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Aircraft.Party,Layout_Aircraft.Party,Party);
	end;
	
	export Bankruptcy := module
		export Main := module
			tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Bankruptcy.Main.Linked,Layout_Bankruptcy.Main.Linked,Linked);
		end;
		tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Bankruptcy.Party,Layout_Bankruptcy.Party,Party);
	end;
	
	export Contacts := module
		tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Contacts.Linked,Layout_Contacts.Linked,Linked);
	end;	
	
	export Finance := module
		tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Finance.Linked,Layout_Finance.Linked,Linked);
	end;
	
	export Foreclosure := module
	  export main := module
			tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Foreclosure.Main.Linked,Layout_Foreclosure.Main.Linked,Linked);
		end;
		export Party := module
			tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Foreclosure.Party.Linked,Layout_Foreclosure.Party.Linked,Linked);
		end;
  end;
	
	export Incorporation := module
		tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Incorporation.Linked,Layout_Incorporation.Linked,Linked);
	end;
	
	export Industry := module
		tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Industry.Linked,Layout_Industry.Linked,Linked);
	end;
	
	export License := module
		tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).License.Linked,Layout_License.Linked,Linked);
	end;
	
	export Liens := module
		export Main := module
			tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Liens.Main.Linked,Layout_Liens.Main.Linked,Linked);
		end;
		tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Liens.Party,Layout_Liens.Party,Party);
	end;
	
	export Linking := module
		tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Linking.Linked,Layout_Linking.Linked,Linked);
	end;
	
	export LLID := module
		tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).LLID.Linked,Layout_LLID.Linked,Linked);
	end;
	
	export Mark := module
		tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Mark.Linked,Layout_Mark.Linked,Linked);
	end;
	
	export Match := module
		tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Match.Linked,Layout_Linking.Match,Linked);
	end;
	
  export MotorVehicle := module
	  export Main := module
			tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).MotorVehicle.Main.Linked,Layout_MotorVehicle.Main.Linked,Linked);
		end;
		tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).MotorVehicle.Registration,Layout_MotorVehicle.Registration,Registration);
		tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).MotorVehicle.Title,Layout_MotorVehicle.Title,Title);
		tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).MotorVehicle.Party,Layout_MotorVehicle.Party,Party);
	end;
	
	export NAPs := module
		tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).NAPs.Linked,Layout_NAPs.Linked,Linked);
	end;
	
	export Property := module
		export Main := module
			tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Property.Main.Linked,Layout_Property.Main.Linked,Linked);
		end;
		export Party := module
			tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Property.Party.Linked,Layout_Property.Party.Linked,Linked);
		end;
		export Assessment := module
			tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Property.Assessment.Linked,Layout_Property.Assessment.Linked,Linked);
		end;
		export Deed := module
			tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Property.Deed.Linked,Layout_Property.Deed.Linked,Linked);
		end;
		export Foreclosure := module
			tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Property.Foreclosure.Linked,Layout_Property.Foreclosure.Linked,Linked);
		end;
	end;
	
	export Relationship := module
		tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Relationship.Linked,Layout_Relationship.Linked,Linked);
	end;
	
	export TradeLines := module
		tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).TradeLines.Linked,Layout_TradeLines.Linked,Linked);
	end;
	
	export UCC := module
		export Main := module
			tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).UCC.Main.Linked,Layout_UCC.Main.Linked,Linked);
		end;
		tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).UCC.Party,Layout_UCC.Party,Party);
		tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).UCC.Collateral,Layout_UCC.Collateral,Collateral);
	end;
	
	export URLs := module
		tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).URLs.Linked,Layout_URLs.Linked,Linked);
	end;
	
	export Watercraft := module
	  export Main := module
			tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Watercraft.Main.Linked,Layout_Watercraft.Main.Linked,Linked);
		end;
		tools.mac_FilesBase(Filenames(pversion,pUseOtherEnvironment).Watercraft.Party,Layout_Watercraft.Party,Party);
	end;
end;
