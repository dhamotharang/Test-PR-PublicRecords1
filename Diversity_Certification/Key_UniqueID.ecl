Import BIPV2;

base := Diversity_Certification.Files().KeyBuildSF;	

//filter has been in place for base file records in order to avoid system error (index limit exceeds) during key build time 	   															 		   
valid_base := project( base (sizeof(base)<=4096),transform(Diversity_Certification.Layouts.KeyBuild-BIPV2.IDlayouts.l_xlink_ids,SELF := LEFT;));

export Key_UniqueID := index(valid_base,
														 {unique_id},
														 {valid_base},
														 Diversity_Certification.Keynames().UniqueID.qa);
   
