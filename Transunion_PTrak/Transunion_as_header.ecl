import Transunion_PTrak,lib_keylib,lib_fileservices,ut,Header;

//these have been identified as bad dates in the file
bad_dates := [200011,200107,200402,200510];

export	Transunion_as_header(dataset(Transunion_PTrak.Layout_Transunion_Out.LayoutTransunionBaseOut) ptucs = dataset([],Transunion_PTrak.Layout_Transunion_Out.LayoutTransunionBaseOut), boolean pForHeaderBuild=false)
 :=
  function
	dtucsasSource	:=	Transunion_PTrak.Transunion_as_source(ptucs,pForHeaderBuild);

		Header.Layout_New_Records Translate_tucs_to_Header(dtucsasSource l) := transform
	
	    unsigned3 v_dt := IF(l.FileType = 'F', (integer)l.UPDATEDATE_unformatted[1..6] ,(integer)l.COMPILATIONDATE_unformatted[1..6]);
		unsigned3 v_r_dt := IF(l.FileType = 'F', (integer)l.TRANSFERDATE_Unformatted[1..6] ,(integer)l.FileDate[1..6]);

		self.rid := 0;
		self.pflag1 := '';
		self.pflag2 := '';
		self.pflag3 := '';  
		self.dt_first_seen            := if(v_dt in bad_dates,0,v_dt);
		self.dt_last_seen             := if(v_dt in bad_dates,0,v_dt);
		self.dt_vendor_first_reported := v_r_dt;
		self.dt_vendor_last_reported :=  v_r_dt;
		self.dt_nonglb_last_seen :=  self.dt_last_seen;
		self.rec_type := if(l.AddressSeq =1, '1','2'); 
		self.vendor_id := 'TS'+l.VendorDocumentIdentifier+((string)(hash(l.fname,l.lname,l.prim_name)))[1..4];
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
		self.county := l.county[3..5];
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
dtucsasSource1 := Header.fn_TUCS_exclusuins(dtucsasSource0(did>0),header.File_Headers(src<>'TS'));
dtucsasSource_dist := distribute(dtucsasSource1(fname <> '' and lname <>''),hash(
                            //vendor_id,
                              fname,
							//mname,
							  lname,
							  name_suffix,
							//ssn,
							//dob,
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
							  county
						   // phone,
						   // rec_type
							  ));
dtucsasSource_sort := sort(dtucsasSource_dist,fname,lname,name_suffix,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,county,phone,rec_type,local);

Header.Layout_New_Records t_rollup(dtucsasSource_sort le, dtucsasSource_sort ri) := transform
 self.dt_first_seen            := ut.Min2(le.dt_first_seen,ri.dt_first_seen);
 self.dt_last_seen             := ut.Max2(le.dt_last_seen,ri.dt_last_seen);
 self.dt_vendor_first_reported := ut.Min2(le.dt_vendor_first_reported,ri.dt_vendor_first_reported);
 self.dt_vendor_last_reported  := ut.Max2(le.dt_vendor_last_reported,ri.dt_vendor_last_reported);
 self.dt_nonglb_last_seen      := self.dt_last_seen;
 
 self.mname    := if(length(trim(le.mname))>length(trim(ri.mname)),le.mname,ri.mname);
 self.ssn      := if(le.ssn <> '' ,le.ssn,ri.ssn); 
 self.dob      := if(le.dob <>0 ,le.dob, ri.dob); 
 self.phone    := if(le.phone <>'' ,le.phone ,ri.phone); 
 self.rec_type := if(le.rec_type = '1', le.rec_type , ri.rec_type); 
 self          := le;
end;

Tucs_to_header := rollup(dtucsasSource_sort,
                           left.fname       = right.fname       and  
						   left.lname       = right.lname       and 
						   left.name_suffix = right.name_suffix and
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
						   ut.firstname_match(left.mname,right.mname)>0 and
						   ut.NNEQ_SSN(left.ssn, right.ssn)     and
						   ut.NNEQ_Date(left.dob, right.dob)    , 
				   t_rollup(left,right),
				   local
				  );
					
    return Tucs_to_header;
	
  end
 ;