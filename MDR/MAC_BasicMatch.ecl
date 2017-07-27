export MAC_BasicMatch(infile,outfile) := macro

match_to := Header.File_headers;

//-- slimmer record format for header file (match_to)
slim_for_addr := record
	  integer8      did;
	  integer8      rid;
	  string10      phone;
	  string9       ssn;
	  integer4      dob;
	  string20      fname;
	  string20      mname;
	  string20      lname;
	  string5       name_suffix;
	  string10      prim_range;
	  string28      prim_name;
	  string8       sec_range;
	  string5       zip;
	  string2       st;
      string2       src;
	  end;

//-- transform used by join to add rid and did
typeof(infile) add_rid(slim_for_addr l, infile r) := transform
	  self.rid := l.rid;
	  self.did := l.did;
      self.pflag1 := IF(ut.Translate_Suffix(l.name_suffix)<>ut.Translate_Suffix(r.name_suffix),'?','');
	  self := r;
	  end;

//-- transform used to push header into slimmer record format
slim_for_addr slim(match_to l) := transform
	  self := l;
	  end;

//****** where header file has valid name, project into slimmer record format
hname := project(match_to(prim_name<>'',zip<>'',fname<>'',lname<>''),slim(left));
h1 := distribute(hname,hash(trim(prim_name),trim(zip),trim(lname)));
ifile := distribute(infile,hash(trim(prim_name),trim(zip),trim(lname)));

//****** join to find matches between infile and header file
//       where match found, add rid and did to result from header file 
//       'right outer' join keeps infile records 


j_mac := join(h1,ifile,
			   left.fname=right.fname and
			   left.lname=right.lname and
			   left.prim_range=right.prim_range and
			   left.prim_name=right.prim_name and
			   left.zip=right.zip and
               mdr.isSourceGroupMatch(left.src,right.src) and
               left.name_suffix=right.name_suffix and
               left.dob=right.dob and
			   left.mname=right.mname and
			   left.ssn=right.ssn and 
			   left.sec_range=right.sec_range and
			   left.phone=right.phone,
			   add_rid(left,right),right outer,local);

outfile := j_mac;		//set outfile to recordset that joined in first(strict) join

	  endmacro;