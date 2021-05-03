import header, mdr;
// export	as_headers(dataset(Layouts.layout_offender) pDOC = prte2_doc.Files.file_offenders_keybuilding) :=  function
export	as_headers(dataset(Layouts.layout_offender) pDOC = dataset([],Layouts.layout_offender)) :=  function
	infile := pDOC;

	header.Layout_New_Records into(infile L, integer c) := transform
		 self.did := (integer)l.did;
		 self.rid := 0;
		 self.rec_type := '2';
		 self.vendor_id := l.offender_key[1..18];
		 self.src := map(	l.data_type='1'or l.data_type='' => MDR.SourceTools.src_Accurint_DOC, 
											l.data_type='2' =>  MDR.SourceTools.src_Accurint_Crim_Court,
											 MDR.SourceTools.src_Accurint_Arrest_Log);
		 self.dt_first_seen := (integer)(l.file_date[1..6]);
		 self.dt_last_seen := (integer)(l.file_date[1..6]);
		 self.dt_vendor_first_reported := (integer)(l.file_date[1..6]);
		 self.dt_vendor_last_reported := (integer)(l.file_date[1..6]);
		 self.dt_nonglb_last_seen := 0;
		 self.phone := '';
		 self.suffix := l.addr_suffix;
		 self.city_name := l.v_city_name;
		 self.zip := l.zip5;
		 self.county := l.county_name;
		 self.dob := (integer)choose(c,l.dob,l.dob_alias);
		 self.ssn := '';
		 self.cbsa := if(l.msa='','',l.msa+'0');
		 self.title := '';
		 self := l; 
	end;

	norm := normalize(infile,if((integer)left.dob_alias>0,2,1),into(left,counter));

	as_header := norm(did > 0 and prim_name!='' and lname!='' and fname!='');
	return as_header;

end;
