import doxie;

KeyBaseFile := NaturalDisaster_Readiness.Files().KeyBuild.built(bid>0);		

slimLayout	:=	record
		layouts.keybuild	 - [bid,bid_score];
end;

NewKeyBuild	:=	project(KeyBaseFile, TRANSFORM(slimLayout,self.BDID := Left.BID; SELF := LEFT;));

export Key_BID := index(NewKeyBuild,
							         {bdid},
											 {NewKeyBuild},
							          '~thor_data400::key::NaturalDisaster_Readiness::'+doxie.Version_SuperKey+'::BID');