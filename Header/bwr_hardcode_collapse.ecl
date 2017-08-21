fn_hardcode_collapse(dataset(recordof(header.layout_pairmatch)) incollapse ) := function

header.layout_pairmatch tcollapse(incollapse le) := transform
 self.new_rid	:= le.new_rid;
 self.old_rid	:= le.old_rid;
 self.pflag		:= 0;
end;

itscollapse := project(incollapse,tcollapse(left));

return itscollapse;

end;

//expand as necessary
collapseList := fn_hardcode_collapse(dataset([
// {0,0,''}
// ,{0,0,''}
],header.layout_pairmatch));

WriteFile := output(collapseList,,'~thor_data400::out::hard_coded_collapse'+thorlib.wuid(),overwrite);

AddToSuper := fileservices.addsuperfile('~thor_data400::base::hard_coded_collapse','~thor_data400::out::hard_coded_collapse'+thorlib.wuid());

sequential(WriteFile,AddToSuper);

//fileservices.clearsuperfile('~thor_data400::base::hard_coded_collapse');