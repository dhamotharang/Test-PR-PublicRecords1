import ut,roxiekeybuild;

export Proc_Build_Key_pullSSN_LE(string filedate) := function

f1:='~thor_data400::key::pullSSN_LE_qa';
f2:='~thor_data400::key::pullSSN_LE_building';
f3:='~thor_data400::key::pullSSN_LE_built';
f4:='~thor_data400::key::pullSSN_LE_delete';
f5:='~thor_data400::key::pullSSN_LE_father';
f6:='~thor_data400::key::pullSSN_LE_grandfather';

super1:=if(filedate<>'',if(fileservices.superfileexists(f1),FileServices.ClearSuperfile(f1),fileservices.createsuperfile(f1)));
super2:=if(filedate<>'',if(fileservices.superfileexists(f2),FileServices.ClearSuperfile(f2),fileservices.createsuperfile(f2)));
super3:=if(filedate<>'',if(fileservices.superfileexists(f3),FileServices.ClearSuperfile(f3),fileservices.createsuperfile(f3)));
super4:=if(filedate<>'',if(fileservices.superfileexists(f4),FileServices.ClearSuperfile(f4),fileservices.createsuperfile(f4)));
super5:=if(filedate<>'',if(fileservices.superfileexists(f5),FileServices.ClearSuperfile(f5),fileservices.createsuperfile(f5)));
super6:=if(filedate<>'',if(fileservices.superfileexists(f6),FileServices.ClearSuperfile(f6),fileservices.createsuperfile(f6)));

  roxiekeybuild.MAC_SK_BuildProcess_v2_Local(key_pullSSN_LE, '~thor_data400::key::pullSSN_LE', '~thor_data400::key::pullSSN_LE::'+filedate+'::ssn', a, true);
  roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::pullSSN_LE', '~thor_data400::key::pullSSN_LE::'+filedate+'::ssn', b, true);
  ut.MAC_SK_Move_v2('~thor_data400::key::pullSSN_LE', 'Q', c);

return sequential(parallel(super1,super2,super3,super4,super5,super6),a,b,c);
end;
