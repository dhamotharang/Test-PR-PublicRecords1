import misc,Orbit3,STD,dops;

pversion := '20180716';
#workunit('protect',true);
#WORKUNIT('name','Yogurt:VendorSrc load ' + pversion + '');
#workunit('priority','high');
a := misc.fSpray_CourtLocation_File('CourtLocator-201800709.txt');
b1 := Misc.fBuild_All_VendorSrc(pversion);
b2 := output(SAMPLE(Misc.Files_VendorSrc(pversion).Combined_Base,50,1),named('samples'));
c := DOPS.updateversion('VendorSourceKeys',pversion,'Michael.Gould@lexisnexis.com,Jose.Bello@lexisnexisrisk.com',,'N');
d := Orbit3.proc_Orbit3_CreateBuild('Vendor Source Code Master List Lookup',pversion,'N');

Sequential(a,b1,b2,c,d);
