import BIPV2,BIPV2_Build,BIPV2_ProxID,tools;
lbegin    := true;
iteration := '1';
pversion  := BIPV2.KeySuffix;
lih       := if(lbegin = true   ,BIPV2_ProxID.In_DOT_Base    ,BIPV2_ProxID.files().base.built );
#workunit('name','BIPV2 Proxid ' + pversion + ' iter ' + iteration);
BIPV2_Build.proc_proxid(iteration,lih,pversion).runIter;
