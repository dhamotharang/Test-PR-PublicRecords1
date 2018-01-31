import Address_Attributes, gong_neustar, ut;

//*** JIRA ticket DF-20295
//*** Jesse Shaw, Principal Statistical Modeler, from the Analytics team, has built logic to create a 
//*** file to replace the existing ACA file. Product will work with data and engineering teams to use 
//*** Jesse’s new file to replace the data in the ACA non-FCRA keys. We will also regression test all 
//*** the products that hit these ACA non-FCRA keys. Because the change is a data level only change, 
//*** the downstream products that use the ACA non-FCRA keys will not need to implement any logic changes.
export File_ACA_Clean_New (

	 dataset(layout_aca_internal					) pfile_aca					= Address_Attributes.file_aca
	,dataset(gong_neustar.Layout_Gong_Did	) pfile_gong_full		= gong_neustar.File_Gong_full
	,string																	pPersistname			= '~thor_data400::persist::aca::file_aca_clean_new'
	
) :=
function
	
	ds_aca_internal_in := pfile_aca(rc>'90');

	ACA.Layout_ACA_Clean tMap2ACA(ds_aca_internal_in l) := transform
	
			self.Inst_type := l.inst_class;
			self.Institution := l.cnp_name;
			self.Addr1 := ut.CleanSpacesAndUpper(
										ut.CleanSpacesAndUpper(l.prim_range) + ' ' +
										ut.CleanSpacesAndUpper(l.predir) + ' ' +
										ut.CleanSpacesAndUpper(l.prim_name) + ' ' +
										ut.CleanSpacesAndUpper(l.addr_suffix) + ' ' +										
										ut.CleanSpacesAndUpper(l.postdir) + ' ' +
										ut.CleanSpacesAndUpper(l.unit_desig) + ' ' +
										ut.CleanSpacesAndUpper(l.sec_range)
										);										
			self.City := ut.CleanSpacesAndUpper(l.p_city_name);
			self.state := ut.CleanSpacesAndUpper(l.st);
			self.Zip := l.Zip;
			self.p_city_name := ut.CleanSpacesAndUpper(l.p_city_name);
			self.v_city_name := ut.CleanSpacesAndUpper(l.v_city_name);
			self.z5 := l.zip;
			self.Inst_type_exp := ut.CleanSpacesAndUpper(l.inst_class);
			self.phone := trim(l.cnp_phone,left,right);
			//self.Mail_Addr;
			//self.Mail_City;
			//self.Mail_State;
			//self.Mail_Zip;
			//self.Notes;	
			//self.name	:= ;
			//self.title := '';
			//self.fname := '';
			//self.mname := '';
			//self.lname := '';
			//self.name_suffix := '';
			//self.Addr2 := '';
			//self.addr_type;
			self 	:= l;
			self 	:= [];
	end;
	
	ds_aca_mapped := project(ds_aca_internal_in, tmap2ACA(left));
	
	//////////////////////////////////////////////////////////////////////////////////////////////
	//*** Joining to gong full file to append the latest phone numbers for the matched addresses
	//////////////////////////////////////////////////////////////////////////////////////////////
	
	ACA.Layout_ACA_Clean get_phones(ds_aca_mapped L, gong_neustar.Layout_Gong_Did R) := transform
		self.phone	:= R.phone10;
		self.zip		:= L.z5;  //08-25-2009 Mapping the cleaned z5 to zip, since zip field is used in the keys.
		self 				:= L;
	end;

	ds_aca_w_gong_phone := join(distribute(ds_aca_mapped,hash(prim_range, prim_name, sec_range, z5)),
															distribute(pfile_gong_full(prim_name != ''),hash(prim_range, prim_name, sec_range, z5)),
															left.prim_range = right.prim_range and
															left.predir = right.predir and
															left.prim_name = right.prim_name and
															left.postdir = right.postdir and
															left.addr_suffix = right.suffix and
															left.sec_range = right.sec_range and
															left.z5 = right.z5,
															get_phones(LEFT,RIGHT), local,
															left outer);

	aca_out_final := dedup(sort(ds_aca_w_gong_phone, record), record) : persist(pPersistname);
	
	return aca_out_final;
	
end;
