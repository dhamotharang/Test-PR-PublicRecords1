import lib_keylib,lib_fileservices,ut,Header,mdr;

export	as_header(dataset(Layouts.base) pFile = dataset([],Layouts.base), boolean pForHeaderBuild=false, boolean pFastHeader= false)
 :=
  function
dENasSource	:=	as_source(pFile,pForHeaderBuild,pFastHeader);


	Header.Layout_Header tr(dENasSource l) := transform
// Prepped_rec_type[1]:
// 0=current name
// 1=former name1
// 2=former name2
// 3=former name3
// 4=spouse name
// Prepped_rec_type[2..3]:
// 00=current address
// 01=previous address1
// ...
// 24=previous address24
		self.rid											:= 900000000000 + l.uid;
		SELF.title                    :=if(l.title not in ['MR','MS'],'',l.title);

		dt_first_seen                 := if(l.dt_first_seen <>0,l.dt_first_seen, l.dt_last_seen);
		dt_last_seen                  := if(l.dt_last_seen  <>0,l.dt_last_seen,  l.dt_first_seen);

		dt_first_seen1                := if(dt_last_seen > dt_first_seen, dt_first_seen, dt_last_seen);
		dt_last_seen1                 := if(dt_last_seen < dt_first_seen, dt_first_seen, dt_last_seen);

		self.dt_first_seen            := (unsigned)((string)dt_first_seen1)[1..6];
		self.dt_last_seen             := (unsigned)((string)dt_last_seen1)[1..6]; 
		self.dt_vendor_first_reported := (unsigned)((string)l.dt_vendor_first_reported)[1..6];
		self.dt_vendor_last_reported  := (unsigned)((string)l.dt_vendor_last_reported)[1..6];
		self.dt_nonglb_last_seen      := 0;
		self.rec_type                 := if(l.IsCurrent,'1','2'); 
		self.vendor_id                := l.EXPERIAN_ENCRYPTED_PIN;
		self.ssn                      := if(l.ssn in ut.Set_BadSSN ,'',l.ssn);
		SELF.dob                      := l.dob;
		self.phone                    := l.phone;
		self.city_name                := if(l.v_city_name in Header.set_derogatory_address,'',l.v_city_name);
		self.suffix                   := l.addr_suffix;
		self.county                   := l.fips_county;
		self.cbsa                     := l.msa;
		self := l;
	end;

EN_to_header := project(dENasSource,tr(left));

	junk1:='0123456789~!@#$%^&*()_+-={}[]|\\:";\'<>?,./ 	';//includes tab and space
	junk2:='0123456789~!@#$%^&*()_+={}[]|\\:";\'<>?,./	';//includes tab but not space or hyphen

	EN_non_blank := EN_to_header
				(
				length(stringlib.stringfilter(trim(fname),junk1))=0
				,length(stringlib.stringfilter(trim(mname),junk1))=0
				,length(stringlib.stringfilter(trim(lname),junk2))=0
				,length(stringlib.stringfilter(trim(lname),' -'))<2
				,fname<>''
				,lname<>''
				,prim_name<>''
				// ,(unsigned)zip4>0
				,did>0
				) : persist('~thor_data400::persist::headerbuild_FCRA_ExperianCred_as_header');

	return EN_non_blank;
end;