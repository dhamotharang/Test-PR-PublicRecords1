import doxie,Workers_Compensation;

KeyBase := Workers_Compensation.Files().KeyBuild.built(bid>0);	

slimLayout	:=	record
		layouts.keybuild	 - [bid,bid_score];
end;

NewKeyBuild	:=	project(KeyBase, TRANSFORM(slimLayout,self.BDID := Left.BID; SELF := LEFT;));

export Key_bid := index(NewKeyBuild,
												 {bdid},
												 {NewKeyBuild},
							           '~thor_data400::key::Workers_Compensation::'+
												  doxie.Version_SuperKey + '::BID');