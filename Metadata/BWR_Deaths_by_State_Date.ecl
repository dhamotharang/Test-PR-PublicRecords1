//Deaths by State Date jjb W20071129-120528 20080130-110142 20080317-085759 20081022-123027

dDev := dataset('~thor_data400::Base::Death_Master_Plus',header.layout_death_master_plus,flat);

rFile := record
  dDev.filedate;
  dDev.state;
  dDev.state_death_flag;
  count(group);
end;

rBirth := record
  byear := dDev.dob8[5..8];
  min(group,dDev.dob8);
  max(group,dDev.dob8);
  dDev.state;
  dDev.state_death_flag;
  count(group);
end;

rDeath := record
  dyear := dDev.dod8[5..8];
  min(group,dDev.dod8);
  max(group,dDev.dod8);
  dDev.state;
  dDev.state_death_flag;
  count(group);
end;

tFile := table(dDev,rFile,filedate,state,state_death_flag);
tBirth := table(dDev,rBirth,dob8[5..8],state,state_death_flag);
tDeath := table(dDev,rDeath,dod8[5..8],state,state_death_flag);

output(sort(tFile,state,state_death_flag,filedate),all);
output(sort(tBirth,state,state_death_flag,byear),all);
output(sort(tDeath,state,state_death_flag,dyear),all);

//output(choosen(dDev(state='CA',dod8='10242007'),all)); //W20071129-163920 Missing record search
//output(choosen(dDev(fname='ADAM',lname='SCHATZ'),all)); //W20080812-102535 Missing record search