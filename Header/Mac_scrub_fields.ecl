export Mac_scrub_fields (in_dirty, out_clean) := macro

#uniquename(fn_cleanup)
#uniquename(pIn)
%fn_cleanup%(string %pIn%) := function
	pOut1 := trim(regexreplace('[!$^*<>?]',%pIn%,' '),left,right);
	pOut  := trim(stringlib.stringfindreplace(pOut1,'\'',''),left,right);
	return pOut;
end;

#uniquename(is_junky)
#uniquename(in_name)
%is_junky%(string %in_name%) := function
	is_true := length(trim(stringlib.stringfilterout(%in_name%,' ')))>ut.fn_count_unique_characters_in_a_string(%in_name%)*4
			or
			(length(trim(stringlib.stringfilterout(%in_name%,' ')))>2 and ut.fn_count_unique_characters_in_a_string(%in_name%)=1);
	return is_true;
end;

#uniquename(t1)
{in_dirty} %t1%(in_dirty le) := transform
	//'II' not added because it wouldn't qualify as junky to begin with
	name_exception_set := ['III','IIII'];
	addr_exception_set := ['RR RR'];

	string4 v_dob   := (string)le.dob[1..4];
	boolean bad_dob := (~(v_dob between '1800' and ut.getdate[1..4])) and le.dob>0;

	string v_prim_name := %fn_cleanup%(le.prim_name);

	boolean prim_name_is_bogus := ut.bogusstreets(v_prim_name) or (%is_junky%(v_prim_name) and v_prim_name not in addr_exception_set);

	prim_name	:= if(prim_name_is_bogus,'',v_prim_name);;
	unit_desig	:= if(prim_name_is_bogus,'',le.unit_desig);
	sec_range	:= if(prim_name_is_bogus,'',%fn_cleanup%(le.sec_range));

	pl:=length(trim(prim_name));
	ul:=length(trim(unit_desig));
	sl:=length(trim(sec_range));

	usl:=ul + sl;

	filter:='('
	+'^ *( *PO *BOX *[0-9]{1,}) *$'
	+'|^ *(COUNTY *ROAD *[0-9]{1,}) *$'
	+')';

	boolean OK2dedup := usl > 0	
			and  regexfind(filter,prim_name)
			and  trim(prim_name)[pl-usl..]=trim(unit_desig)+' '+trim(sec_range);

	self.prim_name	:= if(regexfind('SSN [0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]',stringlib.stringfilterout(prim_name,'-'))
	or prim_name in set(header.file_derogatoryAddress,derogatoryAddress),'',prim_name);

	self.unit_desig := if(OK2dedup,'',unit_desig);
	self.sec_range  := if(OK2dedup,'',sec_range);

	self.phone     := if(length(trim(le.phone,left,right)) in [7,10],le.phone,'');

	self.vendor_id := %fn_cleanup%(le.vendor_id);
	self.title     := '';
	fname     := if(%is_junky%(%fn_cleanup%(le.fname))=false and le.fname not in name_exception_set,%fn_cleanup%(le.fname),'');
	mname     := if(%is_junky%(%fn_cleanup%(le.mname))=false and le.mname not in name_exception_set,%fn_cleanup%(le.mname),'');
	lname     := if(%is_junky%(%fn_cleanup%(le.lname))=false and le.lname not in name_exception_set,%fn_cleanup%(le.lname),'');

// more junk removal
 self.fname      := header.fn_blankout_junk(fname);
 self.mname      := header.fn_blankout_junk(mname);
 self.lname      := header.fn_blankout_junk(lname);

	self.prim_range := if(prim_name_is_bogus or trim(le.prim_range)='0','',le.prim_range);
	self.predir     := if(prim_name_is_bogus,'',le.predir);
	self.suffix     := if(prim_name_is_bogus,'',le.suffix);
	self.postdir    := if(prim_name_is_bogus,'',le.postdir);
	self.city_name  := if(le.city_name in set(header.file_derogatoryAddress,derogatoryAddress)
		,'',stringlib.stringcleanspaces(%fn_cleanup%(le.city_name)));
	self.st         := %fn_cleanup%(le.st);
	self.zip        := if((integer)le.zip=0,'',le.zip);

	self.ssn       := if(length(trim(le.ssn,left,right))=9 and le.ssn=stringlib.stringfilter(le.ssn,'0123456789'),le.ssn,
	   if(le.src in ['BA','L2'] and length(trim(le.ssn,left,right))=4 and le.ssn=stringlib.stringfilter(le.ssn,'0123456789'),'00000'+le.ssn,
	   ''));
	self.dob       := if(bad_dob=true,0,le.dob);
	self           := le;
end;

#uniquename(p1)
%p1% := project(in_dirty,%t1%(left))(fname<>'' and lname<>'');

#uniquename(r1)
%r1% := record
	%p1%;
	boolean acceptable_street;
	boolean acceptable_csz;
	boolean keep_record;
end;

#uniquename(t2)
%r1% %t2%(in_dirty le) := transform
	self.acceptable_street := (~(trim(le.prim_range)='' and (trim(le.prim_name)='' or trim(le.prim_name,all)=trim(le.city_name+le.st,all))));
	self.acceptable_csz    := (le.city_name<>'' and le.st<>'') or le.zip<>'';
	self.keep_record       := (~(trim(le.ssn)='' and le.dob=0 and (self.acceptable_street=false or self.acceptable_csz=false)));

	self.ssn         := if(le.ssn in ut.set_badssn,'',le.ssn);
	self.phone       := header.fn_blank_bogus_phones(le.phone);
	self.title       := '';
	self.fname       := if(ut.mod_value_is_repeated(le.fname).is_repeated,    ut.mod_value_is_repeated(le.fname).fixed,    le.fname);
	self.mname       := if(ut.mod_value_is_repeated(le.mname).is_repeated,    ut.mod_value_is_repeated(le.mname).fixed,    le.mname);
	self.lname       := if(ut.mod_value_is_repeated(le.lname).is_repeated,    ut.mod_value_is_repeated(le.lname).fixed,    le.lname);
	self.prim_name   := if(ut.mod_value_is_repeated(le.prim_name).is_repeated,ut.mod_value_is_repeated(le.prim_name).fixed,le.prim_name);
	self.name_suffix := header.fn_cleanup_name_suffix(le.name_suffix);

	self                   := le;
end;

#uniquename(p2)
%p2% := project(%p1%,%t2%(left))(fname<>'',lname<>'',keep_record=true);

//****** Remove some known bad names  city_name='OZ' and st
#uniquename(isjunky)
%isjunky% := UT.BogusNames(%p2%.FNAME, %p2%.MNAME, %p2%.LNAME)
        or UT.BogusCities(%p2%.city_name, %p2%.st);

#uniquename(kill_junk)
%kill_junk% := %p2%(not %isjunky%);

out_clean := %kill_junk%(header.isPersonRec(fname, mname, lname, name_suffix),fname<>'',lname<>'');

endmacro;