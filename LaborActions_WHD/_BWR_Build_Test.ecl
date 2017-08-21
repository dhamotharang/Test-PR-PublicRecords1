//pversion    := '20110207';
pversion    := '20111025';
     
directory := '/hds_180/SIM/LaborActions_WHD/' + pversion;

#workunit('name', 'LaborActions_WHD Build ' + pversion);
LaborActions_WHD.Build_All(pversion).all;

