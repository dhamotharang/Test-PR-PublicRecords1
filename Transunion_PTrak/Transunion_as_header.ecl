import Transunion_PTrak,lib_keylib,lib_fileservices,ut,Header;

export	Transunion_as_header(dataset(Transunion_PTrak.Layout_Transunion_Out.LayoutTransunionBaseOut) ptucs = dataset([],Transunion_PTrak.Layout_Transunion_Out.LayoutTransunionBaseOut), boolean pForHeaderBuild=false)
 :=
  function
	dtucsasSource	:=	Transunion_PTrak.Transunion_as_source(ptucs,pForHeaderBuild);

	Header.Layout_New_Records Translate_tucs_to_Header(dtucsasSource l) := transform
		self.did := 0;
		self.rid := 0;
		self.pflag1 := '';
		self.pflag2 := '';
		self.pflag3 := '';  
		self.dt_first_seen := IF(l.FileType = 'F', (integer)l.UPDATEDATE_unformatted[1..6] ,(integer)l.COMPILATIONDATE_unformatted[1..6]); 
		self.dt_last_seen := IF(l.FileType = 'F', (integer)l.UPDATEDATE_unformatted[1..6] ,(integer)l.COMPILATIONDATE_unformatted[1..6]); 
		self.dt_vendor_first_reported := self.dt_first_seen;
		self.dt_vendor_last_reported :=  (integer)l.FileDate[1..6];
		self.dt_nonglb_last_seen :=  self.dt_last_seen;
		self.rec_type := if(l.AddressSeq =1, '1','2'); 
		self.vendor_id := 'TS'+trim(l.VendorDocumentIdentifier,left,right)+((string)(hash(l.fname,l.lname,l.prim_name)))[1..4];
		self.phone := l.TELEPHONE_unformatted;
		self.ssn := l.SSN_unformatted;
		self.dob := if((integer)l.BIRTHDATE_unformatted[1..4] < 1800 ,0  // 36 records with invalid year as of 2009/01
		   , if(l.BIRTHDATEIND = 'N' or (l.BIRTHDATEIND = '' AND l.BIRTHDATE_unformatted [7..] NOT IN ['01','15']),( integer)l.BIRTHDATE_unformatted,0));
 /*Y = Birth date calculated from social security number
N = Exact date of birth
E =  Calculated from individuals age
Blank = Unknown*/
		self.title := l.title;
		self.fname := l.fname;
		self.lname := l.lname;
		self.mname := l.mname;
		self.name_suffix := l.name_suffix;
		self.prim_range := l.prim_range;
		self.predir := l.predir;
		self.prim_name := l.prim_name;
		self.suffix := l.addr_suffix;
		self.postdir := l.postdir;
		self.unit_desig := l.unit_desig;
		self.sec_range := l.sec_range;
		self.city_name := l.v_city_name;
		self.st := l.st;
		self.zip := l.zip;
		self.zip4 := l.zip4;
		self.county := l.county;
		string3 msa_temp := l.msa;
		self.cbsa := if(msa_temp!='',msa_temp + '0','');
		self.geo_blk := l.geo_blk;
		self.tnt := '';
		self.valid_ssn := '';
		self.jflag1 := '';
		self.jflag2 := '';
		self.jflag3 := '';
	self := l;
	end;

dtucsasSource0 := project(dtucsasSource,Translate_tucs_to_Header(left));
dtucsasSource_dist := distribute(dtucsasSource0,hash(vendor_id,
                              fname,
							  mname,
							  lname,
							  name_suffix,
							  ssn,
							  dob,
							  prim_range,
							  predir,
							  prim_name,
							  suffix,
							  postdir,
							  unit_desig,
							  sec_range,
							  city_name,
							  st,
							  zip,
							  zip4,
							  county,
							  phone,
							  rec_type
							  ));
dtucsasSource_sort := sort(dtucsasSource_dist,vendor_id,fname,mname,lname,name_suffix,ssn,dob,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,county,phone,rec_type,local);

Header.Layout_New_Records t_rollup(dtucsasSource_sort le, dtucsasSource_sort ri) := transform
 self.dt_first_seen            := ut.Min2(le.dt_first_seen,ri.dt_first_seen);
 self.dt_last_seen             := ut.Max2(le.dt_last_seen,ri.dt_last_seen);
 self.dt_vendor_first_reported := self.dt_first_seen; 
 self.dt_nonglb_last_seen      := self.dt_last_seen;
 self                          := le;
end;

Tucs_to_header := rollup(dtucsasSource_sort,
                           left.vendor_id   = right.vendor_id   and
						   left.fname       = right.fname       and 
                           left.mname       = right.mname       and 
						   left.lname       = right.lname       and 
						   left.name_suffix = right.name_suffix and
						   left.ssn         = right.ssn         and 
						   left.dob         = right.dob         and 
                           left.prim_range  = right.prim_range  and 
						   left.predir      = right.predir      and
						   left.prim_name   = right.prim_name   and
						   left.suffix      = right.suffix      and
						   left.postdir     = right.postdir     and
						   left.unit_desig  = right.unit_desig  and
						   left.sec_range   = right.sec_range   and 
						   left.city_name   = right.city_name   and
						   left.st          = right.st          and
						   left.zip         = right.zip         and
						   left.zip4        = right.zip4        and
						   left.county      = right.county      and
						   left.phone       = right.phone       and
						   left.rec_type    = right.rec_type,
			       t_rollup(left,right),
				   local
				  );

	Tucs_non_blank := Tucs_to_header(fname<>'',lname<>'');
					
    return Tucs_non_blank;
	
  end
 ;