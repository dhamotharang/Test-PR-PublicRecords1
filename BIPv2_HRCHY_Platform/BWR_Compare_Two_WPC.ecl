import lksd;

rc := dataset([], BIPv2_HRCHY_Platform.Layouts.Inrec);
wpc := BIPv2_HRCHY_Platform.Functions.WithParentsChildren(rc) ;
lt :=  BIPv2_HRCHY_Platform.Functions.LgidTable(wpc);
wi :=  BIPv2_HRCHY_Platform.Functions.WithIds(wpc,lt);

old := dataset('~thor_data400::BIPv2_HRCHY_Platform::mod_Build.wpcL__p4186236489', recordof(wpc), thor);
new := dataset('~thor_data400::BIPv2_HRCHY_Platform::mod_Build.wpcLsimple __p2338146823', recordof(wpc), thor);


BIPv2_HRCHY_Platform.mac_WPC_stats(old);
BIPv2_HRCHY_Platform.mac_WPC_stats(new);