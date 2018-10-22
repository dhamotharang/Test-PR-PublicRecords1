EXPORT compare_iterations(
   dataset(layout_dot_base) pDataset1
  ,dataset(layout_dot_base) pDataset2
) :=
function
  //join two datasets on rcid and proxid
  //to get rcids in diff proxids
  djoin := join(
     pDataset1
    ,pDataset2
    ,   left.rcid    = right.rcid
    and left.proxid != right.proxid
    ,transform(
       {pdataset1.rcid,unsigned6 proxid1,unsigned6 proxid2}
      ,self.rcid  := left.rcid
      ,self.proxid1 := left.proxid
      ,self.proxid2 := right.proxid
    )
  );
  
  drolledup1 := BIPV2_ProxID.AggregateProxidElements(pDataset1);
  drolledup2 := BIPV2_ProxID.AggregateProxidElements(pDataset2);
  
  dget1 := join(djoin,drolledup1,left.proxid1 = right.proxid  ,transform({recordof(djoin),recordof(drolledup1) d1,recordof(drolledup2) d2},self := left,self.d1 := right,self := []));
  dget2 := join(dget1,drolledup2,left.proxid2 = right.proxid  ,transform({recordof(djoin),recordof(drolledup1) d1,recordof(drolledup2) d2},self.d2 := right,self := left));
  
  return dget2;
end;
