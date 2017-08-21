fn_hardcode_dodgy(dataset(recordof(header.layout_DodgyDids)) inDodgy ) := function

header.layout_DodgyDids tDodgy(inDodgy le) := transform
 self.did         := le.did;
 self.rule_number := '-';
end;

itsDodgy := project(inDodgy,tDodgy(left));

return itsdodgy;

end;

//expand as necessary
DodgyList := fn_hardcode_dodgy(dataset([{,''}],header.layout_DodgyDids));

WriteFile := output(DodgyList,,'~thor_data400::out::hard_coded_dodgies'+thorlib.wuid(),overwrite);

AddToSuper := fileservices.addsuperfile('~thor_data400::base::hard_coded_dodgies','~thor_data400::out::hard_coded_dodgies'+thorlib.wuid());

sequential(WriteFile,AddToSuper);

//fileservices.clearsuperfile('~thor_data400::base::hard_coded_dodgies');