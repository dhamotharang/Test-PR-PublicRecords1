import lib_fileservices,ut,Header;

export	as_header(dataset(Layouts.base) pFile = dataset([],Layouts.base), boolean pForHeaderBuild=false, boolean pFastHeader= false)
 :=
  function
dtuasSource	:=	header.Files_SeqdSrc(pFastHeader).TN((unsigned)name_score>50 or name_score='');


	Header.Layout_New_Records tr(dtuasSource l) := transform
// rec_type:
// A1=current name and current address
// A2=current name and former1 address
// A3=current name and former2 address
// B1=AKA1 name and current address
// B2=AKA1 name and former1 address
// B3=AKA1 name and former2 address
// C1=AKA2 name and current address
// C2=AKA2 name and former1 address
// C3=AKA2 name and former2 address
// D1=AKA3 name and current address
// D2=AKA3 name and former1 address
// D3=AKA3 name and former2 address
		self.did := if(pFastHeader, l.did, 0);
		self.rid := 0;
		self.dt_first_seen            := (unsigned)((string)l.dt_first_seen)[1..6];
		self.dt_last_seen             := (unsigned)((string)l.dt_last_seen)[1..6]; 
		self.dt_vendor_first_reported := (unsigned)((string)l.dt_vendor_first_reported)[1..6];
		self.dt_vendor_last_reported  := (unsigned)((string)l.dt_vendor_last_reported)[1..6];
		self.dt_nonglb_last_seen      := 0;
		self.rec_type                 := if(l.IsCurrent,'1','2'); 
		self.vendor_id                := l.Party_ID;
		self.ssn                      := if(l.clean_ssn in ut.Set_BadSSN ,'',l.clean_ssn);
		SELF.dob                      := l.clean_dob;
		self.phone                    := l.clean_phone;
		self.city_name                := l.v_city_name;
		self.suffix                   := l.addr_suffix;
		self.cbsa                     := l.msa;
		self := l;
	end;

dtuasSource0 := project(dtuasSource,tr(left));

dtuasSource_dist := distribute(dtuasSource0,hash(vendor_id));
dtuasSource_sort := sort(dtuasSource_dist,record
										,except
											dt_first_seen
											,dt_last_seen
											,dt_vendor_first_reported
											,dt_vendor_last_reported
											,uid
										,local);

Header.Layout_New_Records t_rollup(dtuasSource_sort le, dtuasSource_sort ri) := transform
 self.dt_first_seen            := ut.Min2(le.dt_first_seen,ri.dt_first_seen);
 self.dt_last_seen             := Max(le.dt_last_seen,ri.dt_last_seen);
 self.dt_vendor_first_reported := ut.Min2(le.dt_vendor_first_reported,ri.dt_vendor_first_reported);
 self.dt_vendor_last_reported  := Max(le.dt_vendor_last_reported,ri.dt_vendor_last_reported);
 self                          := le;
end;

Tu_to_header := rollup(dtuasSource_sort
							,   left.vendor_id   = right.vendor_id
							and left.rec_type    = right.rec_type
							and left.fname       = right.fname
							and left.mname       = right.mname
							and left.lname       = right.lname
							and left.name_suffix = right.name_suffix
							and left.phone       = right.phone
							and left.ssn         = right.ssn
							and left.dob         = right.dob
							and left.prim_range  = right.prim_range
							and left.predir      = right.predir
							and left.prim_name   = right.prim_name
							and left.suffix      = right.suffix
							and left.postdir     = right.postdir
							and left.unit_desig  = right.unit_desig
							and left.sec_range   = right.sec_range
							and left.city_name   = right.city_name
							and left.st          = right.st
							and left.zip         = right.zip
							and left.zip4        = right.zip4
							and left.county      = right.county
						,t_rollup(left,right)
						,local
						);

	junk1:='0123456789~!@#$%^&*()_+-={}[]|\\:";\'<>?,./ 	';//includes tab and space
	junk2:='0123456789~!@#$%^&*()_+={}[]|\\:";\'<>?,./	';//includes tab but not space or hyphen

	Tu_non_blank := Tu_to_header
				(
				length(stringlib.stringfilter(trim(fname),junk1))=0
				,length(stringlib.stringfilter(trim(mname),junk1))=0
				,length(stringlib.stringfilter(trim(lname),junk2))=0
				,length(stringlib.stringfilter(trim(lname),' -'))<2
				,fname<>''
				,lname<>''
				,prim_name<>''
				,(unsigned)zip4>0
				);

	return Tu_non_blank;
end;