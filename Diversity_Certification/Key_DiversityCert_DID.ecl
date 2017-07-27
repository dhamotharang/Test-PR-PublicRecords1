Import BIPv2;

base := Diversity_Certification.Files().KeyBuildSF(did>0);
//filter has been in place for base file records in order to avoid system error (index limit exceeds) during key build time 	   			   
valid_base := project( base (sizeof(base)<=4096),transform(Diversity_Certification.Layouts.KeyBuild-BIPV2.IDlayouts.l_xlink_ids,SELF := LEFT;));

export Key_DiversityCert_DID := index(valid_base,
																			{did},
																			{valid_base},
																			Diversity_Certification.Keynames().did.qa);
   
