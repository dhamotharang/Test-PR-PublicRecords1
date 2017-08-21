import ExperianCred,lib_keylib,lib_fileservices,ut,Header,ut;

export	Experian_as_header(dataset(ExperianCred.Layouts.Layout_Out) pExperian = dataset([],ExperianCred.Layouts.Layout_Out), boolean pForHeaderBuild=false, boolean pFastHeader = false)
 :=
  function
	dExperianasSource	:=	header.Files_SeqdSrc(pFastHeader).EN;

	Header.Layout_New_Records Translate_Experian_to_Header(dExperianasSource l) := transform
		self.did := if(pFastHeader, l.did, 0);
		self.rid := 0;
		self.pflag1 := '';
		self.pflag2 := '';
		self.pflag3 := '';  
		
		self.dt_first_seen := (unsigned3) ((string)l.date_first_seen)[1..6];
	    self.dt_last_seen :=  (unsigned3) ((string)l.date_last_seen)[1..6] ;
		self.dt_vendor_first_reported := (unsigned3) ((string)l.date_vendor_first_reported)[1..6];
		self.dt_vendor_last_reported :=  (unsigned3) ((string)l.date_vendor_last_reported)[1..6];
		self.dt_nonglb_last_seen :=  0;
		
		self.rec_type := map(l.nametype ='C1' and l.AddressSeq = 1 and l.current_rec_flag=1 => '1', // Only one current record exists with this condition
		                     l.nametype ='C1' and l.AddressSeq = 1 and l.current_rec_flag =0 => '2', // this is old current record- but in update file we recieved record which is more recent than this. 
		                     l.nametype ='C1' and l.AddressSeq in [2,3,4,5,6,7,8] => '2',
		                     l.nametype ='C2' and l.AddressSeq in [1,2,3,4,5,6,7,8] => '2',
							 l.nametype[1] = 'O' and  l.AddressSeq = 1 => '2', 
							 l.nametype[1] = 'O' and  l.AddressSeq in [2,3,4,5,6,7,8] => '3' , 
							 '') ;
		
		self.vendor_id := trim(l.Encrypted_Experian_PIN,left,right);
		
		self.phone := if(length(trim(l.telephone,left,right)) not in [7,10] or 
		                 trim(l.telephone,left,right) in ut.Set_BadPhones  ,'',l.telephone);
		
		self.ssn := if(stringlib.stringfilterout(l.Social_Security_Number, '0') ='' or l.Social_Security_Number in ut.Set_BadSSN ,'',l.Social_Security_Number);
		
		self.dob :=map (l.Date_of_Birth[1..4] ='9999'=>0,
	     	 l.Date_of_Birth[5..8] ='9999' => (integer)(l.Date_of_Birth[1..4]+'0000'),			 
		     l.Date_of_Birth[5..6] ='99' => (integer)(l.Date_of_Birth[1..4]+'00'+l.Date_of_Birth[7..]),
			 l.Date_of_Birth[7..8] ='99' => (integer)(l.Date_of_Birth[1..6]+'00'),
			 stringlib.stringfilterout(l.Date_of_Birth, '0') ='' or stringlib.stringfilterout(l.Date_of_Birth, '9') ='' => 0,
			 (integer)l.Date_of_Birth); 
			
		/*9 filler for unknown components, i.e., 9999MMDD, 999999DD, 9999MM99, CCYY99DD, CCYYMM99, CCYY9999 */
		
		self.title := l.title;
		self.fname := l.fname;
		self.lname := l.lname;
		self.mname := if(trim(l.mname,left,right)='NULL', '', l.mname);
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

dExperianasSource0 := project(dExperianasSource,Translate_Experian_to_Header(left));

dExperianasSource_dist := distribute(dExperianasSource0,hash(vendor_id,
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
dExperianasSource_sort := sort(dExperianasSource_dist,vendor_id,fname,mname,lname,name_suffix,ssn,dob,prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,city_name,st,zip,zip4,county,phone,rec_type,local);

Header.Layout_New_Records t_rollup(dExperianasSource_sort le, dExperianasSource_sort ri) := transform
 self.dt_first_seen            := ut.Min2(le.dt_first_seen,ri.dt_first_seen);
 self.dt_last_seen             := max(le.dt_last_seen,ri.dt_last_seen);
 self.dt_vendor_first_reported := ut.Min2(le.dt_vendor_first_reported,ri.dt_vendor_first_reported);
 self.dt_vendor_last_reported  := max(le.dt_vendor_last_reported,ri.dt_vendor_last_reported);
 self                          := le;
end;

Experian_to_header := rollup(dExperianasSource_sort,
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

	Experian_non_blank := Experian_to_header(fname<>'',lname<>'',prim_name <> '');
					
    return Experian_non_blank;
	
  end
 ;