ds_search := LN_PropertyV2.File_Search_did(ln_fares_id<>'' AND err_stat[1] = 'S' AND which_orig='1' AND ln_fares_id[2] <>'A' AND source_code[1] IN ['B', 'O']);	
rec := record
	Layout_Property_KeyExtract;
	unsigned1 keepit;
end;

rec filterCleans(ds_search l) :=transform
  name :=StringLib.StringCleanSpaces(trim(l.lname+' '+l.fname+' '+l.mname+' '+l.name_suffix,left,right));  
	nameMatched := trim(name, left,right) = trim(l.nameasis,left,right);
	cnameMatched :=  trim(l.cname,left,right) = trim(l.nameasis,left,right);
	
	add1 := StringLib.StringCleanSpaces(trim(l.prim_range+' '+l.predir+' '+l.prim_name+' '+l.suffix+' '+l.postdir,left,right));  
	add2 := StringLib.StringCleanSpaces(trim(l.v_city_name, left, right)+', '+l.st+ ' '+l.zip);  
					
	add1Matched :=add1= trim(l.append_prepaddr1,left,right);
	add2Matched :=add2 = trim(l.append_prepaddr2,left,right);
	
	self.keepit := IF( (nameMatched OR cnameMatched) and add1Matched and add2Matched, 0, 1);
	//when only name same	
	self.lname :=if(nameMatched, '', l.lname);
	self.fname :=if(nameMatched, '', l.fname);
	self.mname :=if(nameMatched, '', l.mname);
	self.name_suffix :=if(nameMatched, '', l.name_suffix);
	//when only cname same
	self.cname :=if(cnameMatched, '', l.cname);
	//when only addr1 same
	self.prim_range := IF(add1Matched, '',l.prim_range);
	self.predir := IF(add1Matched, '',l.predir);
	self.prim_name := IF(add1Matched, '',l.prim_name);
	self.suffix := IF(add1Matched, '',l.suffix);
	self.postdir := IF(add1Matched, '',l.postdir);
	//when onlyaddr2 same
	self.v_city_name := IF(add2Matched, '',l.v_city_name);
	self.st := IF(add2Matched, '',l.st);
	self.zip := IF(add2Matched, '',l.zip);
	self := l;
end;
ds_search_out := project(ds_search, filterCleans(left));
EXPORT File_Property_DMCleanName := project(ds_search_out(keepit>0), Layout_Property_KeyExtract);