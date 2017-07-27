import doxie,Insurance_Certification;

KeyBase := Insurance_Certification.Files().KeyBuild_Cert.built(bid>0);

slimLayout	:=	record
		layouts_Certification.keybuild	 - [bid,bid_score];
end;

NewKeyBuild	:=	project(KeyBase, TRANSFORM(slimLayout,self.BDID := Left.BID; SELF := LEFT;));

export Key_bid := index(NewKeyBuild,
												 {bdid},
												 {NewKeyBuild},
							           '~thor_data400::key::Insurance_Certification::'+
												  doxie.Version_SuperKey + '::BID');