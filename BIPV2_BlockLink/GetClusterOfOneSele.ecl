import BizlinkFull, BIPV2;
EXPORT GetClusterOfOneSele(unsigned6 seleid_in) := function
		all_ids:=BizlinkFull.Process_Biz_Layouts.KeyseleidUp(seleid=seleid_in);
		the_ultid:=(unsigned6)all_ids[1].ultid;
		the_orgid:=(unsigned6)all_ids[1].orgid;
   	base:=BIPV2.Key_BH_Linking_Ids.key(ultid=the_ultid and orgid=the_orgid and seleid=seleid_in ) + 	 
			BIPV2.Key_BH_Linking_Ids.Key_hidden(ultid=the_ultid and orgid=the_orgid and seleid=seleid_in);
   return base;
end;