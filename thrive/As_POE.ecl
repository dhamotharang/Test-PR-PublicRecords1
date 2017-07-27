import POE,mdr;

export As_POE(

	dataset(layouts.Base) pThriveBase	= Files().base.qa

) :=
function

//Home phone for subject
	POE.Layouts.Base	tMapToPOE(layouts.Base l, string1 phone_type) :=
	transform
		self.source													:= l.src;
		self.vendor_id											:= l.persistent_record_id;
		self.subject_name.title             := l.title;
		self.subject_name.fname             := l.fname;
		self.subject_name.mname             := l.mname;
		self.subject_name.lname             := l.lname;
		self.subject_name.name_suffix       := l.name_suffix;
		self.subject_address.prim_range     := l.prim_range;
		self.subject_address.predir         := l.predir;
		self.subject_address.prim_name      := l.prim_name;
		self.subject_address.addr_suffix    := l.addr_suffix;
		self.subject_address.postdir        := l.postdir;
		self.subject_address.unit_desig     := l.unit_desig;
		self.subject_address.sec_range      := l.sec_range;
		self.subject_address.city_name      := l.p_city_name;
		self.subject_address.st							:= l.st	;
		self.subject_address.zip						:= l.zip;
		self.subject_address.zip4						:= l.zip4;
		self.subject_phone									:= (unsigned) if(phone_type = 'H',l.clean_Phone_Home,l.clean_Phone_Cell);
		self.subject_dob										:= (unsigned)l.clean_dob;
		self.subject_rawaid									:= l.RawAID;
		self.subject_aceaid									:= l.ACEAID;
		self.company_name										:= l.Employer;
		self.company_phone									:= (unsigned)l.clean_Phone_Work;
		self														:= l;
		self														:= [];
	
	end;

//Add additional subject phones in the clean_phone_cell field;
cell_not_as_home_phone := join(distribute(pThriveBase(clean_Phone_Cell <> ''), hash(persistent_record_id)),
															 distribute(pThriveBase(clean_Phone_Home <> ''), hash(persistent_record_id)),
															 left.persistent_record_id = right.persistent_record_id and
															 left.clean_Phone_Cell = right.clean_Phone_Home,
															 left only,
															 local);
															 

dMappedToPOE_home_ph := project(pThriveBase	,tMapToPOE(left, 'H'));
dMappedToPOE_cell_ph := project(cell_not_as_home_phone	,tMapToPOE(left, 'C'));

dMappedToPOE := 	(dMappedToPOE_home_ph + dMappedToPOE_cell_ph);
return dMappedToPOE;
END;
	
	
	