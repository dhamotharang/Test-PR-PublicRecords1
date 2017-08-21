//#workunit('name', 'BusReg Company & Contacts Output Creation ' + BusReg.BusReg_Build_Date);

cmpny := busreg.File_BusReg_Company;
cntct := busreg.File_BusReg_Contact;
do1 := output('Busreg Contact Did population : ' + count(busreg.File_BusReg_Contact(did > 0)));

Company_Layout := BusReg.Layout_BusReg_Company_Out;

contact_layout := BusReg.Layout_BusReg_Contact_Out;

company_layout p1(busreg.Layout_BusReg_Company L) := transform
 self.bdid := if(l.bdid=0,'',intformat(l.bdid, 12, 1));
 self.br_id := intformat(l.br_id, 12, 1);
 self := l;
end;

contact_layout p2(busreg.Layout_BusReg_Contact L) := transform
 self.bdid := if(l.bdid=0,'',intformat(l.bdid, 12, 1));
 self.did := if(l.did=0,'',intformat(l.did, 12, 1));
 self.br_id := intformat(l.br_id, 12, 1);
 self := l;
end;

do2 := output(project(cmpny,p1(left)),,'OUT::BusReg_Company_' + BusReg.BusReg_Build_Date,overwrite);
do3 := output(project(cntct,p2(left)),,'OUT::BusReg_Contacts_' + BusReg.BusReg_Build_Date,overwrite);

export BWR_4Accurint := sequential(do1,do2,do3);