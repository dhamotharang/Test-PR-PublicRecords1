import tools;

export Keynames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lversiondate	:= pversion														;
	
  shared ftemplate(string pFiletype, string pCategory, string pSubset)	:=
		tools.mod_FilenamesBuild(_Constants(pUseOtherEnvironment).thor_cluster_files + pFiletype + '::' + _Dataset().name + '::' + pCategory + '::@version@::' + pSubset,lversiondate);

	export Abstract := ftemplate('key','abstract','main');
  export AddressesPhones := ftemplate('key','addressesphones','main');
	export Aircraft := module
	  export Main  := ftemplate('key','aircraft','main');
	  export Party := ftemplate('key','aircraft','party');
		export dAll_filenames :=
			Main.dAll_filenames +
			Party.dAll_filenames;
	end;
	export Bankruptcy := module
		export Main := ftemplate('key','bankruptcy','main');
		export Party := ftemplate('key','bankruptcy','party');
		export dAll_filenames :=
			Main.dAll_filenames +
			Party.dAll_filenames;
	end;
	export Contacts := ftemplate('key','contacts','main');	
	export ContactsDID := ftemplate('key','contactsdid','main');	
	export Finance := ftemplate('key','finance','main');
	export Incorporation := ftemplate('key','incorporation','main');
	export Industry := ftemplate('key','industry','main');
	export License := ftemplate('key','license','main');
	export Liens := module
		export Main := ftemplate('key','liens','main');
		export Party := ftemplate('key','liens','party');
		export dAll_filenames :=
			Main.dAll_filenames +
			Party.dAll_filenames;
	end;
	export LinkDiagnostic := ftemplate('key','linkdiagnostic','main');
	export LLID12 := ftemplate('key','llid12','main');
	export LLID9 := ftemplate('key','llid9','main');
	export MatchDiagnostic := ftemplate('key','matchdiagnostic','main');
	export MotorVehicle := module
	  export Main  := ftemplate('key','motorvehicle','main');
	  export Registration := ftemplate('key','motorvehicle','registration');
	  export Title := ftemplate('key','motorvehicle','title');
	  export Party := ftemplate('key','motorvehicle','party');
		export dAll_filenames :=
			Main.dAll_filenames +
			Registration.dAll_filenames +
			Title.dAll_filenames +
			Party.dAll_filenames;
	end;
	export NamesFEINs := ftemplate('key','namesfeins','main');
	export Property := module
		export Main := ftemplate('key','property','main');
		export Party := ftemplate('key','property','party');
		export Assessment := ftemplate('key','property','assessment');
		export Deed := ftemplate('key','property','deed');
		export Foreclosure := ftemplate('key','property','foreclosure');
		export dAll_filenames :=
			Main.dAll_filenames +
			Party.dAll_filenames +
			Assessment.dAll_filenames +
			Deed.dAll_filenames +
			Foreclosure.dAll_filenames;
	end;
	export Relationship := ftemplate('key','relationship','main');
	export Source := ftemplate('key','source','main');
	export TradeLines := ftemplate('key','tradelines','main');
	export UCC := module
		export Main := ftemplate('key','ucc','main');
		export Party := ftemplate('key','ucc','party');
		export Collateral := ftemplate('key','ucc','collateral');
		export dAll_filenames :=
			Main.dAll_filenames +
			Party.dAll_filenames +
			Collateral.dAll_filenames;
	end;
	export URLs := ftemplate('key','urls','main');
	export Watercraft := module
	  export Main  := ftemplate('key','watercraft','main');
	  export Party := ftemplate('key','watercraft','party');
		export dAll_filenames :=
			Main.dAll_filenames +
			Party.dAll_filenames;
	end;

	export dAll_filenames := 
		  Abstract.dAll_filenames
		+ AddressesPhones.dAll_filenames
		+ Aircraft.dAll_filenames
		+ Bankruptcy.dAll_filenames
		+ Contacts.dAll_filenames
		+ Finance.dAll_filenames
		+ Incorporation.dAll_filenames
		+ Industry.dAll_filenames
		+ License.dAll_filenames
		+ Liens.dAll_filenames
		+ LinkDiagnostic.dAll_filenames
		+ LLID12.dAll_filenames
		+ LLID9.dAll_filenames
		+ MatchDiagnostic.dAll_filenames
		+ MotorVehicle.dAll_filenames
		+ NamesFEINs.dAll_filenames
		+ Property.dAll_filenames
		+ Relationship.dAll_filenames
		+ Source.dAll_filenames
		+ TradeLines.dAll_filenames
		+ UCC.dAll_filenames
		+ URLs.dAll_filenames
		+ Watercraft.dAll_filenames
		;

end;
