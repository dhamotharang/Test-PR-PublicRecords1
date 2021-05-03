import std, FLAccidents_Ecrash;

layouts.keybuild_SSv2 copyNames(layouts.keybuild_SSv2  le) := TRANSFORM
		SELF.fname := le.orig_fname;
		SELF.lname := le.orig_lname;
		self.mname := le.orig_mname;
		self := Le;
	END;
	 
m_base_file:= PROJECT(File_KeybuildV2.out(trim(lname, left, right) <> trim(orig_lname, left, right) 
																					and(STD.STr.CountWords(lname,' ') > 1 or STD.STr.CountWords(orig_lname,' ') > 1 ) 
																					and orig_lname <> '' ),copyNames(LEFT));
	
cmbnd_base_file := m_base_file + File_KeybuildV2.out;
	
// A record with all the fields needed to build the autokeys
ak_rec := record
	string8  dt_first_seen;
	string8  dt_last_seen;
	string40  accident_nbr;
	string40 orig_accnbr;
	unsigned6 did;
	string20 fname;
	string20 mname;
	string20 lname;
	string28 prim_name ;
	string10 prim_range ;
	string8  sec_range ;
	string25 v_city_name ;
	string2  st ;
	string5  zip5;
	unsigned6 b_did;
	string25 b_name;
	string28 b_prim_name ;
	string10 b_prim_range ;
	string8  b_sec_range ;
	string25 b_v_city_name ;
	string2  b_st ;
	string5  b_zip5 ;
	unsigned1 zero := 0;
	string1   blank := '';
end;

ak_rec slim_rec(File_KeybuildV2.out l) := transform
  boolean is_company := if(l.cname<>'',true,false); 

	self.dt_first_seen:= l.dt_first_seen;
	self.dt_last_seen := l.dt_last_seen;
	self.accident_nbr := l.accident_nbr;
	self.orig_accnbr := l.orig_accnbr; 
	// people fields
	self.did          := (unsigned6)l.did;
	self.fname        := if(~is_company,l.fname,'');
	self.mname        := if(~is_company,l.mname,'');
	self.lname        := if(~is_company,l.lname,'');
	self.prim_name    := if(~is_company,l.prim_name,'');
	self.prim_range   := if(~is_company,l.prim_range,'');
	self.sec_range    := if(~is_company,l.sec_range,'');
	self.v_city_name  := if(~is_company,l.v_city_name,'');
	self.st           := if(~is_company,l.st,'');
	self.zip5         := if(~is_company,l.zip,'');
	// business fields
	self.b_did         := (unsigned6)l.b_did;
	self.b_name        := if(is_company,l.cname,'');
	self.b_prim_name   := if(is_company,l.prim_name,'');
	self.b_prim_range  := if(is_company,l.prim_range,'');
	self.b_sec_range   := if(is_company,l.sec_range,'');
	self.b_v_city_name := if(is_company,l.v_city_name,'');
	self.b_st          := if(is_company,l.st,'');
	self.b_zip5        := if(is_company,l.zip,'');
end;

export file_Autokey := dedup(project(cmbnd_base_file, slim_rec(left)), all);
