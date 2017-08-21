import demo_data;
EXPORT Proc_Build_BIPV2FullKeys(
  string pversion
  

) :=
function

  thecode := demo_data.buildindexcode('BipV2FullKeys',pversion,'N','B');
  // PRTE.CopyMissingKeys //copy keys that you don't build
  // thecodestring := rollup(thecode,true,transform(recordof(left) ,self.eclstring := left.eclstring + '\n' + right.eclstring));
  // submitwuid := wk_ut.mac_ChainWuids();
  return thecode;
end;