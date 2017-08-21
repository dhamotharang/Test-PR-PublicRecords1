#option('skipFileFormatCrcCheck', 1);
#option('maxLength', 131072);

d := Accuity.Reformat.Parent.GWL +Accuity.Reformat.Parent.MSB	+Accuity.Reformat.Parent.OFAC;
Addr := Accuity.Reformat.normalizd.gwl.Addresses				+Accuity.Reformat.normalizd.msb.Addresses						+Accuity.Reformat.normalizd.ofac.Addresses;
Dob := Accuity.Reformat.normalizd.gwl.Dob							+Accuity.Reformat.normalizd.msb.Dob									+Accuity.Reformat.normalizd.ofac.Dob;
ID := Accuity.Reformat.normalizd.gwl.Identifications	+Accuity.Reformat.normalizd.msb.Identifications			+Accuity.Reformat.normalizd.ofac.Identifications;
Phones:= Accuity.Reformat.normalizd.gwl.Phones						+Accuity.Reformat.normalizd.msb.Phones							+Accuity.Reformat.normalizd.ofac.Phones;
Pob := Accuity.Reformat.normalizd.gwl.Pob							+Accuity.Reformat.normalizd.msb.Pob									+Accuity.Reformat.normalizd.ofac.Pob;
Addl:= Accuity.Reformat.normalizd.gwl.supplemental			+Accuity.Reformat.normalizd.msb.Supplemental				+Accuity.Reformat.normalizd.ofac.Supplemental;


//Get Address
new_layout := record
string id;
string entity_added_by;
string type;
string information;
end;

new_layout trecs(d L, addr R) := transform
self.ID := L.id;
self.type := if(L.id = R.id,'Street Address and/or Locality','');
self.entity_added_by := L.accuitydatasource + ': ' + Accuity.Conversions.SourceCodeToName(L.accuitydatasource);
self.information     := R.street_1 + R.street_2 + R.city;
end;

jrecs1 := join(d, addr,
								left.id = right.id,
								trecs(left,right), left outer, hash);
//Get Dob								
new_layout trecs1(jrecs1 L, dob R) := transform
self.ID := L.id;
self.entity_added_by := L.entity_added_by;
self.type := if(L.id = R.id,R.type,L.type);
self.information     := if(L.id = R.id,R.information,L.information);
end;

jrecs2 := join(jrecs1, dob(information !=''),
								left.id = right.id,
								trecs1(left,right), left outer, hash);

//Get Other IDs								
new_layout trecs2(jrecs2 L, ID R) := transform
self.ID := L.id;
self.entity_added_by := L.entity_added_by;
self.type := if(L.id = R.id,R.type,L.type);
self.information     := if(L.id = R.id,R.number,L.information);
end;

jrecs3 := join(jrecs2, ID(number !=''),
								left.id = right.id,
								trecs2(left,right), left outer, hash);
								
//Get Phones								
new_layout trecs3(jrecs3 L, phones R) := transform
self.ID := L.id;
self.entity_added_by := L.entity_added_by;
self.type := if(L.id = R.id,R.type,L.type);
self.information     := if(L.id = R.id,R.number,L.information);
end;

jrecs4 := join(jrecs3, phones(number !=''),
								left.id = right.id,
								trecs3(left,right), left outer, hash);
								

//Get POB								
new_layout trecs4(jrecs4 L, pob R) := transform
self.ID := L.id;
self.entity_added_by := L.entity_added_by;
self.type := if(L.id = R.id,R.type,L.type);
self.information     := if(L.id = R.id,R.information,L.information);
end;

jrecs5 := join(jrecs4, pob(information !=''),
								left.id = right.id,
								trecs4(left,right), left outer, hash);

output(jrecs1);
output(jrecs2);
output(jrecs3);
output(jrecs4);
output(jrecs5(type = 'ssn'));

layout_stat := record
jrecs5.entity_added_by;
jrecs5.type;
record_count := count(group);
end;

output(sort(table(jrecs5(type!=''),layout_stat,entity_added_by,type),entity_added_by,type),all);

layout_stat2 := record
jrecs1.entity_added_by;
record_count := count(group);
end;

output(sort(table(jrecs1,layout_stat2,entity_added_by),entity_added_by),all);
output(d);
