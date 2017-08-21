import idl_header;
export UpdateGender(dataset(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header) innames) := FUNCTION

	shared layout_name_count := idl_header.layout_name_count;
  shared suffixNameSet := ['SR', 'JR', 'JR JR', 'II', 'III', 'IV', '1', '2', '3', '4'];
	
	nametable := HealthCareProvider.Files.Name_Count_DS;

	HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header rulexform1(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header l, layout_name_count r,string2 tag) :=	transform
			validParam 			:= length(trim(r.name)) > 1 and trim(l.derived_gender) = ''; 
			validFirstName 	:= r.fname_cnt > r.lname_cnt;
			probablyFirstName:=r.fname_cnt>r.lname_cnt*4;
			validMale 			:= r.female_cnt = 0 or (r.male_cnt*100   / r.fname_cnt) >= 80;
			validFemale			:= r.male_cnt = 0   or (r.female_cnt*100 / r.fname_cnt) >= 80;
		
			result := map(validParam and validFirstName and validMale => 'M', 
										validParam and validFirstName and validFemale => 'F', 
										tag='j1' AND probablyFirstName => 'X',
										'');
			// Populate gender
      self.derived_gender := if(l.derived_gender = '', result, l.derived_gender);
			self := l;
	end;

	HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header rulexform2(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header l, layout_name_count r,string2 tag) :=	transform
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

	HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header rulexform3(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header l) :=	transform
			// Populate gender
			result := if(l.sname in suffixNameSet, 'M', '');
      self.derived_gender := if(l.derived_gender in ['','X'], result, l.derived_gender);													
			self := l;
	end;

	j1 :=	join(innames,		nametable,
						 trim(left.fname) <> '' and left.fname = right.name,
						 rulexform1(left, right, 'j1'), left outer, lookup); 

	j2 :=	join(j1, nametable,
							trim(left.mname) <> '' and left.mname = right.name,
							rulexform1(left, right, 'j2'),
							left outer, lookup); 
	
	j3 :=	join(j2, nametable,
							trim(left.lname) <> '' and left.lname = right.name,
							rulexform1(left, right, 'j3'),
							left outer, lookup); 

	j4 :=	join(j3, nametable,
							trim(left.fname) <> '' and left.fname = right.name,
							rulexform2(left, right, 'j4'),
							left outer, lookup); 

	j5 :=	join(j4, nametable,
							trim(left.mname) <> '' and left.mname = right.name,
							rulexform2(left, right, 'j5'),
							left outer, lookup); 

	j6 :=	project(j5, rulexform3(left));
							
	// output(j1, named('j1'));
	// output(j2, named('j2'));
	// output(j3, named('j3'));
	// output(j4, named('j4'));
	// output(j5, named('j5'));
							
	return j6;
END;