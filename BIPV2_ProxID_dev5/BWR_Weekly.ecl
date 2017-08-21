import BIPV2,BIPV2_Build,BIPV2_ProxID_dev5,tools;

lbegin    := true;
iteration := '1';
pversion  := BIPV2.KeySuffix;
lih       := if(lbegin = true   ,BIPV2_ProxID_dev5.In_DOT_Base    ,BIPV2_ProxID_dev5.files().base.built );


#workunit('name','BIPV2 Proxid ' + pversion + ' iter ' + iteration);

BIPV2_Build.proc_proxid(iteration,lih,pversion).runIter;