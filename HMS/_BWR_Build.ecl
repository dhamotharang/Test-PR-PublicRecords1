IMPORT HMS;

//pversion := '20150319';
// pversion := '20150424';
pversion := '20150609';

     
#workunit('name', 'HMS Build ' + pversion);
HMS.Build_All(pversion);