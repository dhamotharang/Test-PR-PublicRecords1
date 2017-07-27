import Doxie, Doxie_Raw;

//#stored('rid', ['2307252565']);
//output(Doxie_Raw.viewSourceRid(0, 1, 1));

#stored('DPPAPurpose', 1);
#stored('GLBPurpose', 1);

//#stored('SectionString', 'COMPADDRESS');

//#stored('didString', 19); //death
//#stored('didString', 1172116824); //atf, veh, finder, voter, phone
//#stored ('didString', '1402'); //bankruptcy, lien
//#stored ('didString', '17'); //pl
//#stored ('didString', '32944'); //dl, veh, pl, dea, voter. (32944 and 56180: dl, pl, dea. 299, 16341: dea).
//#stored ('didString', '5867'); //air craft, lien
//#stored ('didString', '372'); //watercrapt, phone.
//#stored ('didString', '125'); //ucc, dl, veh
//#stored ('didString', '1278933705'); //corpAffil.  173503207, 321078075
//#stored ('didString', '53417'); //MerchVessel, dl, veh.
//#stored ('didString', '61'); //voter, veh.
//#stored ('didString', '10605'); //ccw, dl, pl, veh, corp affil, voter, hunt, phone //dl??
//#stored ('didString', '325'); //hunter,lien, dl, veh, corp affil, ccw //1485, 315, 5
//#stored ('didString', '6718'); //pilot, pilot cert, veh, corp affil.
//#stored ('didString', '43098'); //whois, corp affil, compAddress.
//#stored ('didString', '19'); //gong, veh, corp affil, voter, compAddress
#stored ('didString', '63'); //Big!!! gong, veh, corp affil, voter, compAddress

//Doxie.Comprehensive_Report_Service()
Doxie.HeaderSource_Service();

//#stored('rid', ['1442053107']);  //['2307252565']
//output(header.HeaderShowSources);

//output(Doxie_Raw.AirCraft_Raw(
//    dataset([5867], Doxie.layout_references), 0, 1, 1));
//output(Doxie_Raw.viewSourceDid(0, 1, 1));
