// randomly pick a specified number of rows from a dataset

export MAC_Pick_Random(inf, outf, num) := macro
	#uniquename(l_wide)
	#uniquename(h)
	%l_wide% := record( recordof(inf) )
		integer8 %h%;
	end;
	
	#uniquename(rand)
	%rand% := random();
	
	#uniquename(ds_wide)
	%ds_wide% := project(inf, transform(%l_wide%, self.%h%:=hash64(left,%rand%), self:=left));
	
	#uniquename(ds_rand)
	%ds_rand% := project(topn(%ds_wide%, num, %h%), recordof(inf));
	
	#uniquename(ds_sort)
	%ds_sort% := project(sort(%ds_wide%, %h%), recordof(inf));
	
	outf := if(count(inf)<=num, %ds_sort%, %ds_rand%);
endmacro;