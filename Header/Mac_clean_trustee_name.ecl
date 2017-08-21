export Mac_clean_trustee_name(ifile_,ofile_):=macro 
	#uniquename(r_tmp)
	%r_tmp% := record
	 ifile_;
	 boolean  vv1;
	 boolean  vv2;
	 boolean  vv3;
	 boolean  vv4;
	end;

	#uniquename(x_tmp)
	%r_tmp% %x_tmp%(ifile_ le) := transform
	 integer  v_st_length := length(trim(le.lname));
	 boolean  v1          := regexfind(' TR| RT', le.lname[v_st_length-2..v_st_length]);
	 boolean  v2          := regexfind(' TRUST',  le.lname[v_st_length-5..v_st_length]);
	 boolean  v3          := regexfind(' TRUSTEE',le.lname[v_st_length-7..v_st_length]);
	 boolean  v4          := regexfind(' RETIREE',le.lname[v_st_length-7..v_st_length]);
	 string20 v_lname1 := if(v1,      le.lname[1..v_st_length-3],
												if(v2,      le.lname[1..v_st_length-6],
																			if(v3 or v4,le.lname[1..v_st_length-8],
																			le.lname)));
	 string20 v_lname2 := stringlib.stringfilterout(v_lname1,',');
	 string20 v_lname3 := stringlib.stringfindreplace(v_lname2,'/','-');

	 self.vv1   := v1;
	 self.vv2   := v2;
	 self.vv3   := v3;
	 self.vv4   := v4;
	 self.lname := v_lname3;
	 self       := le;
	end;

	ofile_ := project(ifile_,%x_tmp%(left))(fname<>'' and lname<>'');
endmacro;