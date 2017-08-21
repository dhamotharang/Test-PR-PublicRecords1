export File_Keybuild_Bid := 
	PROJECT( YellowPages.Files().Base.Built
					,TRANSFORM(YellowPages.Layout_YellowPages_Base_Slim, self.bdid := left.bid, SELF := LEFT;)
	) 
	: persist (persistnames().FileKeybuildBid);