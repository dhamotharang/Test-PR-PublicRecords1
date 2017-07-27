import doxie,Workers_Compensation,bipv2;

KeyBase := Workers_Compensation.Files().KeyBuild.built(bdid>0);	

slimLayout	:=	record
		layouts.keybuild	 - BIPV2.IDlayouts.l_xlink_ids - source_rec_id;
end;

NewKeyBuild	:=	project(KeyBase, TRANSFORM(slimLayout,SELF := LEFT;));

export Key_BDID := index(NewKeyBuild,
												 {bdid},
												 {NewKeyBuild},
							           '~thor_data400::key::Workers_Compensation::'+
												  doxie.Version_SuperKey + '::BDID');						