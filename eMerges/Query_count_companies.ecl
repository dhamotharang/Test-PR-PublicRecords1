hvcfile := emerges.file_hvccw_base;

Layout_hvc_entity := record
emerges.Layout_eMerge_In;
unsigned2 entity_type;
end;


Layout_hvc_entity AddEntity(emerges.Layout_eMerge_In L) := transform
self := L;
self.entity_type := if(Datalib.CompanyClean(l.lname_in + l.fname_in + l.mname_in)[41..120] = '' and 
					(unsigned4)(AddrCleanLib.CleanPerson73(l.lname_in + l.fname_in + l.mname_in)[71..73]) >= 85  and
					(unsigned4)(Datalib.NameClean(l.lname_in + l.fname_in + l.mname_in)[142]) < 3, 0, // person
				if(Datalib.CompanyClean(l.lname_in + l.fname_in + l.mname_in)[41..120] <> '' and
					(unsigned4)(AddrCleanLib.CleanPerson73(l.lname_in + l.fname_in + l.mname_in)[71..73]) >= 85  and
					(unsigned4)(Datalib.NameClean(l.lname_in + l.fname_in + l.mname_in)[142]) < 3, 1, // person and business
				if(Datalib.CompanyClean(l.lname_in + l.fname_in + l.mname_in)[41..120] <> '' or
					(unsigned4)(AddrCleanLib.CleanPerson73(l.lname_in + l.fname_in + l.mname_in)[71..73]) < 85  and
					(unsigned4)(Datalib.NameClean(l.lname_in + l.fname_in + l.mname_in)[142]) >= 3, 2, 3))); // business
end;

hvc_Entity := project(hvcfile(trim(lname_in + fname_in + mname_in) != ''), AddEntity(left));

// keep only the business records
hvc_bus := hvc_Entity(entity_type = 1 or entity_type = 2);
hvc_other := hvc_Entity(entity_type != 1 and entity_type != 2);

output(count(hvcfile), NAMED('RecordCount'));
output(count(hvc_bus), NAMED('RecordCountBUS'));
output(count(hvc_other), NAMED('RecordCountOTH'));


