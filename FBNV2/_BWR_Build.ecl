IMPORT FBNV2, _control;

sourceip 					:= _control.IPAddress.bctlpedata12;

// FBNV2.BWR_Build('/data/data_build_4/fbn/sources/experian/','20161107','Experian',sourceip);
FBNV2.BWR_Build('/data/data_build_4/fbn/sources/ca/orange/archive/20180213.Jan_2018.txt','20180213','Orange',sourceip);
// FBNV2.BWR_Build ('/data/data_build_4/fbn/sources/ca/san_diego/20180212/RECL.P.OFFS.LEXI4201.VENDOR','20180212','San_Diego',sourceip);
// FBNV2.BWR_Build ('/data/data_build_4/fbn/sources/ca/santa_clara/archive/20180206_FBN-Listing_20180102-20180131.csv','20180206','Santa_Clara',sourceip);
// FBNV2.BWR_Build ('/data/data_build_4/fbn/sources/ca/ventura/archive/20180208/Ventura_FBN_R_Jan2018.txt','20180208','Ventura',sourceip);
// FBNV2.BWR_Build ('/data/data_build_4/fbn/sources/fl/20171018/ficevt.txt','20171018','Event',sourceip);
// FBNV2.BWR_Build ('/data/data_build_4/fbn/sources/fl/20171018/ficfile.txt','20171018','Filing',sourceip);
// FBNV2.BWR_Build ('/data/data_build_4/fbn/sources/tx/harris/20170302/ASN*.txt','20170302','Harris',sourceip);