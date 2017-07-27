import doxie,LaborActions_WHD;

KeyBase := LaborActions_WHD.Files().KeyBuild.built(bid>0);

slimLayout	:=	record
		layouts.keybuild	 - [bid,bid_score];
end;

NewKeyBuild	:=	project(KeyBase, TRANSFORM(slimLayout,self.BDID := Left.BID; SELF := LEFT;));

export Key_bid := index(NewKeyBuild,
												 {bdid},
												 {NewKeyBuild},
							           '~thor_data400::key::LaborActions_WHD::'+
												  doxie.Version_SuperKey + '::BID');