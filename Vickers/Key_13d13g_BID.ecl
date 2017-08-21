 import doxie;

df := project(file_13d13g_base_bid(bid != 0),transform(layout_13d13g_base,self.bdid:=left.bid,self:=left));
export Key_13d13g_BID := index(df,{bdid},{df},'~thor_data400::key::vickers_13d13g_bid_' + doxie.Version_SuperKey);