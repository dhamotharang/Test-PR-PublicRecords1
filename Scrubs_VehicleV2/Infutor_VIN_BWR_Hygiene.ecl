//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_VehicleV2.Infutor_VIN_BWR_Hygiene - Hygiene & Stats - SALT V3.6.1');
IMPORT Scrubs_VehicleV2,SALT36;
// First create an instantiated hygiene module
  infile := Scrubs_VehicleV2.Infutor_VIN_In_VehicleV2;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := Scrubs_VehicleV2.Infutor_VIN_Hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(SALT36.MAC_Character_Counts.EclRecord(p,'Layout_VehicleV2'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT36.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT36.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,iid,Examples),NAMED('iidBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,pid,Examples),NAMED('pidBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,vin,Examples),NAMED('vinBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,make,Examples),NAMED('makeBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,model,Examples),NAMED('modelBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,year,Examples),NAMED('yearBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,class_code,Examples),NAMED('class_codeBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,fuel_type_code,Examples),NAMED('fuel_type_codeBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,mfg_code,Examples),NAMED('mfg_codeBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,style_code,Examples),NAMED('style_codeBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,mileagecd,Examples),NAMED('mileagecdBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,nbr_vehicles,Examples),NAMED('nbr_vehiclesBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,idate,Examples),NAMED('idateBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,odate,Examples),NAMED('odateBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,fname,Examples),NAMED('fnameBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,mi,Examples),NAMED('miBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,lname,Examples),NAMED('lnameBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,suffix,Examples),NAMED('suffixBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,gender,Examples),NAMED('genderBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,house,Examples),NAMED('houseBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,predir,Examples),NAMED('predirBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,street,Examples),NAMED('streetBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,strtype,Examples),NAMED('strtypeBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,postdir,Examples),NAMED('postdirBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,apttype,Examples),NAMED('apttypeBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,aptnbr,Examples),NAMED('aptnbrBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,city,Examples),NAMED('cityBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,state,Examples),NAMED('stateBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,zip,Examples),NAMED('zipBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,z4,Examples),NAMED('z4Bystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,dpc,Examples),NAMED('dpcBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,crte,Examples),NAMED('crteBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,cnty,Examples),NAMED('cntyBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,z4type,Examples),NAMED('z4typeBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,dpv,Examples),NAMED('dpvBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,vacant,Examples),NAMED('vacantBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,phone,Examples),NAMED('phoneBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,dnc,Examples),NAMED('dncBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,internal1,Examples),NAMED('internal1Bystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,internal2,Examples),NAMED('internal2Bystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,internal3,Examples),NAMED('internal3Bystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,county,Examples),NAMED('countyBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,msa,Examples),NAMED('msaBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,cbsa,Examples),NAMED('cbsaBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,ehi,Examples),NAMED('ehiBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,child,Examples),NAMED('childBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,homeowner,Examples),NAMED('homeownerBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,pctw,Examples),NAMED('pctwBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,pctb,Examples),NAMED('pctbBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,pcta,Examples),NAMED('pctaBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,pcth,Examples),NAMED('pcthBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,pctspe,Examples),NAMED('pctspeBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,pctsps,Examples),NAMED('pctspsBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,pctspa,Examples),NAMED('pctspaBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,mhv,Examples),NAMED('mhvBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,mor,Examples),NAMED('morBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,pctoccw,Examples),NAMED('pctoccwBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,pctoccb,Examples),NAMED('pctoccbBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,pctocco,Examples),NAMED('pctoccoBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,lor,Examples),NAMED('lorBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,sfdu,Examples),NAMED('sfduBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,mfdu,Examples),NAMED('mfduBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,processdate,Examples),NAMED('processdateBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,source_code,Examples),NAMED('source_codeBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,append_ownernametypeind,Examples),NAMED('append_ownernametypeindBystate_origin'));
  //  OUTPUT(SALT36.MAC_CrossTab(infile,state_origin,fullname,Examples),NAMED('fullnameBystate_origin'));
