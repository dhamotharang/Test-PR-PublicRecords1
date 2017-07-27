IMPORT Org_Mast;

//pversion := '20150319';
// pversion := '20150424';
pversion := '20160202';

     
#workunit('name', 'Organization Master Build ' + pversion);
Org_Mast.Build_All(pversion);