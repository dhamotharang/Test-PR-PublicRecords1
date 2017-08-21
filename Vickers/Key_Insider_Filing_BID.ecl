import doxie;

df := project(vickers.File_Insider_Filing_Base_bid(bid != 0),transform(layout_insider_filing_base,self.bdid:=left.bid,self:=left));

export Key_Insider_Filing_BID := index(df,{bdid},{df},'~thor_data400::key::vickers_insider_filing_bid_' + doxie.Version_SuperKey);
