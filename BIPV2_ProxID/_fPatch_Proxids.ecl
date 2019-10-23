//this is for when a new dotid build is run on top of existing proxids.
//this way I can patch the proxids before running the proxid build
//this will patch the following cases
//1. if the dotid that the proxid got its value from does not exist anymore, it will reset the proxid to it's dotid.
//2. in the case where the proxid doesn't contain the dotid where it got its value from.
import bipv2,bipv2_files,BIPV2_ProxID,ut,salt26,tools,BIPV2_Tools;
EXPORT _fPatch_Proxids(
  dataset(layout_DOT_Base) pDataset   
) :=
function

  ddefaultproxids := BIPV2_Tools.initParentID(pDataset,dotid,proxid);

  return ddefaultproxids;
    
end;
