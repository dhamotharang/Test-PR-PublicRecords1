EXPORT fCountsVerify := function

//lib_fileservices.fileservices.Comparefiles('~thor_data400::base::watchdog_best_w20130528-132002-1','~thor_data400::base::watchdog_best_w20130526-133002-1');

string bname := '~thor_data400::base::watchdog_best';

r := {string wtype};

ds := dataset([{'glb'},{'nonglb'},{'nonen'},{'nonglb_nonutility'},{'noneq'},{'nonen_noneq'},{'nonutility'} ],r);

rec := record
string wtype;
unsigned integer bcnt ;
unsigned integer fatherbcnt;
integer countdiff;
end;

rec t(ds l) := transform
sfcontnew := if ( l.wtype <> 'glb',fileservices.Superfilecontents(bname + '_'+l.wtype),fileservices.Superfilecontents(bname));
sfcontprev := if ( l.wtype <> 'glb',fileservices.Superfilecontents(bname + '_'+l.wtype+'_father'),fileservices.Superfilecontents(bname+'_father'));

dsnew := fileservices.logicalfilelist( namepattern := sfcontnew[1].name);
dsprev := fileservices.logicalfilelist( namepattern := sfcontprev[1].name);
self.wtype := l.wtype;
self.bcnt := dsnew[1].rowcount;
self.fatherbcnt := dsprev[1].rowcount;
self.countdiff := self.bcnt - self.fatherbcnt;
end;

return output(nothor(project(global(ds,few),t(LEFT))));

end;









