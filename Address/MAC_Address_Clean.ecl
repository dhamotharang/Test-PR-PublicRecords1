export MAC_Address_Clean(infile,addr1_expr,addr2_expr,clean_misses,out_file) := macro

IMPORT ut;

#uniquename(new_layout)
%new_layout% := record
  infile;
  string182 clean;
  end;

#uniquename(add_cache)
#uniquename(join_cache)

%new_Layout% %add_cache%(address.Layout_Address_Cache ri,infile le) := transform
  self.clean := ri.clean;
  self := le;
  end;

%join_cache% := join(distribute(address.file_address_cache, hash(trim(addr1), trim(addr2))),
                     distribute(infile,hash(trim((qstring)addr1_expr),trim((qstring)addr2_expr))),
                     left.addr1=(qstring)right.addr1_expr and
                     left.addr2=(qstring)right.addr2_expr,
                     %add_cache%(left,right),right outer, local);

#uniquename(hits)
#uniquename(misses)

%hits% := %join_cache%(clean<>'');
%misses% := %join_cache%(clean='');

//Dedup misses before cleaning then join back on temp_id.
#uniquename(id_layout)
%id_layout% := record
	integer4 temp_ID;
	%new_Layout%;
end;

#uniquename(make_id_layout)
%id_layout% %make_id_layout%(%new_Layout% l) := transform
	self.temp_ID := 0;
	self := l;
end;

#uniquename(infile_pre_id)
#uniquename(pre_infile_id)
%infile_pre_id% := project(%misses%, %make_id_layout%(left));
ut.MAC_Sequence_Records(%infile_pre_id%,temp_ID,%pre_infile_id%)

#uniquename(infile_dist)
%infile_dist% := distribute(%pre_infile_id%,hash(addr1_expr,addr2_expr));

#uniquename(infile_srtd)
%infile_srtd% := sort(%infile_dist%,addr1_expr,addr2_expr,local);

#uniquename(infile_grpd)
%infile_grpd% := group(%infile_srtd%,addr1_expr,addr2_expr,local);

#uniquename(rid_em)
%id_layout% %rid_em%(%id_layout% l, %id_layout% r) := transform
	self.temp_id := if (l.temp_id = 0, r.temp_id, l.temp_id);
	self := r;
end;

#uniquename(infile_iter)
#uniquename(infile_dup)
%infile_iter% := iterate(%infile_grpd%, %rid_em%(left, right));
%infile_dup% := group(dedup(%infile_iter%,temp_id));

#uniquename(clean_new)
%id_layout% %clean_new%(%infile_dup% le) := transform
//  self.clean := AddrCleanLib.CleanAddress182(le.addr1_expr,le.addr2_expr, '172.16.70.102:10000');
  self.clean := AddrCleanLib.CleanAddress182(le.addr1_expr,le.addr2_expr);
  self := le;
  end;

#uniquename(do_misses)
%do_misses% := project(%infile_dup%,%clean_new%(left));

#uniquename(j_back)
%new_layout% %j_back%(%id_layout% L, %id_layout% R) := transform
 self.clean := r.clean;
 self := l;
end;

#uniquename(dis_whole)
#uniquename(dis_part)
%dis_whole% := distribute(group(%infile_iter%),hash(temp_id));
%dis_part% := distribute(%do_misses%,hash(temp_id));

#uniquename(cleaned_miss)
%cleaned_miss% := join(%dis_whole%,%dis_part%,left.temp_id=right.temp_id,%j_back%(left,right),local);

out_file := %hits% + IF(clean_misses,%cleaned_miss%,%misses%);

/*#uniquename(to_cache)
address.Layout_Address_Cache %to_cache%(%do_misses% le) := transform
  self.clean := le.clean;
  self.addr1 := le.addr1_expr;
  self.addr2 := le.addr2_expr;
  end;

#if(clean_misses)
//output( project(%do_misses%,%to_cache%(left)),,'TEMP::New_Addresses', overwrite );
#end
*/
endmacro;
