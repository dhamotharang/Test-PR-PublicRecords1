import tools;
EXPORT _Filters :=
module
  export Explode(
    dataset(BIPV2_ProxID_mj6_PlatForm.layout_DOT_Base) pDataset
  
  ) :=
  function
  
    return tools.fExplodeDids2Rid(pDataset,proxid,dotid,_Proxids2Explode);
  
  end;
end;
