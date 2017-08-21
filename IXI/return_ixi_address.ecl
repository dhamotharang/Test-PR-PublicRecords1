import avm_v2,ut;

ixi_file_dist := dedup(sort(distribute(ixi.ixi_clean,hash(aid)),aid,local),aid,local);

ixi.layouts.l_address t2(ixi_file_dist le, ixi.get_avm ri) := transform 
 self.aid           := le.aid;
 self.street        := stringlib.stringcleanspaces(le.prim_range+' '+le.predir+' '+le.prim_name+' '+le.addr_suffix+' '+le.postdir+' '+le.unit_desig+' '+le.sec_range);
 self.avm_valuation := ri.automated_valuation;
 self.avm_score     := ri.confidence_score;
 self               := le;
end;

j1 := join(ixi_file_dist,ixi.get_avm,left.aid=right.aid,t2(left,right),left outer,local);

ut.mac_sf_buildprocess(j1,'~thor_data400::base::ixi_address',ixi_addr,2,,true);

export return_ixi_address := ixi_addr;