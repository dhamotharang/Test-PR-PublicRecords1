IMPORT BIPV2_Files;
IMPORT BizLinkFull;
  dBase:=PULL(BIPV2_Files.files_CommonBase.KEY_HISTORY);
  lParentChild:={UNSIGNED parent;STRING versiondate;UNSIGNED1 level;UNSIGNED child;STRING level_name;};
  
  macDistillIDs(d,p,c,l,n):=FUNCTIONMACRO
    dSlim:=PROJECT(d,TRANSFORM(lParentChild,SELF.level:=l;SELF.level_name:=n;SELF.parent:=LEFT.p;SELF.child:=LEFT.c;SELF:=LEFT;));
    dDeduped:=DEDUP(SORT(DISTRIBUTE(dSlim,HASH32(parent)),parent,child,versiondate,LOCAL),parent,child,LOCAL);
    RETURN dDeduped;
  ENDMACRO;
  
  dUlts:=macDistillIDs(dBase,ultid,orgid,1,'ULT');
  dOrgs:=macDistillIDs(dBase,orgid,proxid,2,'ORG');
  dProxs:=macDistillIDs(dBase,proxid,dotid,3,'PROX');
  dDots:=macDistillIDs(dBase,dotid,rcid,4,'DOT');
  dParentChild:=SORT(DISTRIBUTE(dUlts+dOrgs+dProxs+dDots,HASH32(parent)),RECORD);
  
EXPORT Key_Hierarchy:=INDEX(dParentChild,{parent},{dParentChild},BizLinkFull.filename_keys.hierarchy);  

