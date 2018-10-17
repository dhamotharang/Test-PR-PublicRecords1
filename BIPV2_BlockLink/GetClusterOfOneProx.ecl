import BizlinkFull, BIPV2;
EXPORT GetClusterOfOneProx(unsigned6 proxid_in) := function
	all_ids:=BizlinkFull.Process_Biz_Layouts.KeyproxidUp(proxid=proxid_in);
	the_ultid:=(unsigned6)all_ids[1].ultid;
	the_orgid:=(unsigned6)all_ids[1].orgid;
	the_seleid:=(unsigned6)all_ids[1].seleid;
	base:=BIPV2.Key_BH_Linking_Ids.key(ultid=the_ultid and orgid=the_orgid and seleid=the_seleid and proxid=proxid_in) + 	 
	      BIPV2.Key_BH_Linking_Ids.Key_hidden(ultid=the_ultid and orgid=the_orgid and seleid=the_seleid and proxid=proxid_in);

return base;
end;