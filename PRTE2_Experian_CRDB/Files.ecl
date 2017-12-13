import data_services;

EXPORT files := module

EXPORT Experian_IN := DATASET(constants.In_Experian, Layouts.In_Layout, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), maxlength(1950),QUOTE('"')));

Export Prep := project(Experian_IN,
   Transform(Layouts.Base,
   Self:=Left;
   self := []; 
   ));
	 
EXPORT Base := DATASET(constants.Base_Experian, Layouts.Base, FLAT );

Export CRDB :=project(Base,Layouts.Experian_CRDB_Base);

MSA:= dataset(data_services.foreign_prod+'thor_data400::base::experian_crdb::qa::data', layouts.Experian_CRDB_Base, thor);

MSA_All :=project(MSA,layouts.msa_layout);

//Export MSA_dedup:=dedup(sort(MSA_ALL,MSA_code,Msa_Description),all);

	Export MSA_dedup := dedup(sort(distribute(MSA_All,hash(Msa_Code)),Msa_Code,MSA_Description,local),Msa_code,msa_description,local);

END;