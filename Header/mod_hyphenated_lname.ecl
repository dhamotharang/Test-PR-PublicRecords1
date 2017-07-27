export mod_hyphenated_lname(string20 plname) :=module
	shared lname			:=	trim(plname);
	shared hyphen			:=	map( stringlib.stringfind(lname,'-',1)>0 => '-'
									,stringlib.stringfind(lname,'/',1)>0 => '/'
									,' ');
	shared hyphen_indx		:=	stringlib.stringfind(lname,hyphen,1);
	has_one_hyphen			:=	stringlib.stringfind(lname,hyphen,2)=0 and hyphen_indx > 0;
	good_lname1st_length	:=	length(lname[1..hyphen_indx-1]) > 3;
	good_lname2nd_length	:=	length(lname[hyphen_indx+1.. ]) > 2;

	export	is_hyphenated	:=	has_one_hyphen
							and	good_lname1st_length
							and	good_lname2nd_length;

	export	lname1st	:=	trim(lname[1..hyphen_indx-1],left,right);

	export	lname2nd	:=	trim(lname[hyphen_indx+1.. ],left,right);
end;
