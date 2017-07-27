vc0 := fsm.AnnotatedPeople();

co_bits := trim(stringlib.stringfilter(vc0._type,'wWESC#'));
vc := vc0(length(trim(co_bits))>0);
comps := vc(length(trim(_type))=1 or length(co_bits)>=2 or co_bits IN ['WES#']);

gp := join(Person_Names,comps,left.pname=right.pname,transform(left),left only,hash);
gp1 := join(gp,PeopleReallyCompanies,left.pname=right.pname,transform(left),left only,hash);

export Person_Names_Only := gp1;