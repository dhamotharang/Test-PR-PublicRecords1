Import BIPV2, Data_Services, doxie;

KeyBaseFile := NaturalDisaster_Readiness.Files().KeyBuild.built(bdid>0);			   

slimLayout	:=	record
		layouts.keybuild	 -BIPV2.IDlayouts.l_xlink_ids;
end;

NewKeyBuild	:=	project(KeyBaseFile, TRANSFORM(slimLayout,SELF := LEFT;));

export Key_BDID := index(NewKeyBuild,
							          {bdid},
												{NewKeyBuild},
							          Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::NaturalDisaster_Readiness::'+doxie.Version_SuperKey+'::BDID');