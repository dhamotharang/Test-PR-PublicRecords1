import idl_header;
export UpdateGender(dataset(idl_header.Layout_Header_link) innames) := FUNCTION

	shared layout_name_count := idl_header.layout_name_count;
  shared suffixNameSet := ['SR', 'JR', 'JR JR', 'II', 'III', 'IV', '1', '2', '3', '4'];
	
	nametable := IDL_Header.Name_Count_DS;

	idl_header.Layout_Header_link rulexform1(idl_header.Layout_Header_link l, layout_name_count r) :=	transform
			validParam 			:= length(trim(r.name)) > 1 and trim(l.derived_gender) = ''; 
			validFirstName 	:= r.fname_cnt > r.lname_cnt;
			validMale 			:= r.female_cnt = 0 or (r.male_cnt*100   / r.fname_cnt) >= 80;
			validFemale			:= r.male_cnt = 0   or (r.female_cnt*100 / r.fname_cnt) >= 80;
		
			result := map(validParam and validFirstName and validMale => 'M', 
										validParam and validFirstName and validFemale => 'F', 
										'');
			// Populate gender
      self.derived_gender := if(l.derived_gender = '', result, l.derived_gender);				
			self := l;
	end;

	idl_header.Layout_Header_link rulexform2(idl_header.Layout_Header_link l, layout_name_count r) :=	transform
			validParam 			:= length(trim(r.name)) > 1 and trim(l.derived_gender) = ''; 
			validMale 			:= r.female_cnt = 0 or (r.male_cnt*100   / r.fname_cnt) >= 80;
			validFemale			:= r.male_cnt = 0   or (r.female_cnt*100 / r.fname_cnt) >= 80;
			// Populate gender
			result := map(validParam and validMale => 'M', 
										validParam and validFemale => 'F', 
										'');
      self.derived_gender := if(l.derived_gender = '', result, l.derived_gender);													
			self := l;
	end;

	idl_header.Layout_Header_link rulexform3(idl_header.Layout_Header_link l) :=	transform
			// Populate gender
			result := if(l.sname in suffixNameSet, 'M', '');
      self.derived_gender := if(l.derived_gender = '', result, l.derived_gender);													
			self := l;
	end;

	j1 :=	join(innames,		nametable,
						 trim(left.fname) <> '' and left.fname = right.name,
						 rulexform1(left, right), left outer, lookup); 

	j2 :=	join(j1, nametable,
							trim(left.mname) <> '' and left.mname = right.name,
							rulexform1(left, right),
							left outer, lookup); 
	
	j3 :=	join(j2, nametable,
							trim(left.lname) <> '' and left.lname = right.name,
							rulexform1(left, right),
							left outer, lookup); 

	j4 :=	join(j3, nametable,
							trim(left.fname) <> '' and left.fname = right.name,
							rulexform2(left, right),
							left outer, lookup); 

	j5 :=	join(j4, nametable,
							trim(left.mname) <> '' and left.mname = right.name,
							rulexform2(left, right),
							left outer, lookup); 

	j6 :=	project(j5, rulexform3(left));
							
	// output(j1, named('j1'));
	// output(j2, named('j2'));
	// output(j3, named('j3'));
	// output(j4, named('j4'));
	// output(j5, named('j5'));
							
	return j6;
END;