EXPORT FDNParentFiles := module
	
	import FraudDefenseNetwork, ut, ashirey;
	
	export fdnLayout := FraudDefenseNetwork.Layouts.Base.Main;

		//Search keys
		//Search keys are built out of the base file directly
	export fdnDS := dataset(ut.foreign_prod_boca + 'thor_data400::base::fdn::qa::main', fdnLayout, thor);
	
	ashirey.Flatten(fdnDS, flatFDNDS);
	export FlattenedFDNDS := flatFDNDS;

end;