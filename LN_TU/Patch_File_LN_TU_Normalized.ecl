rec1 := record
 string5   old_title;
 string20  old_fname;
 string20  old_mname;
 string20  old_lname;
 string5   old_name_suffix;
 string3   name_score;
 string182 clean;
 LN_TU.Layout_In_Header_UID_SRC;
end;

ds := dataset('~thor_dell400_2::persist::File_LN_TU_Normalized_All',rec1,flat);

rec2 := record
 string5  title       :='';
 string20 fname       :='';
 string20 mname       :='';
 string20 lname       :='';
 string5  name_suffix :='';
 rec1;
end;

suffixes := ['II','III','IV','V','JR','SR','MD','RD'];

rec2 t1(rec1 l) := transform
 
 string v_lname            := if(trim(l.old_lname)        ='RD','III',trim(l.old_lname));
 string v_name_suffix      := if(trim(l.old_name_suffix)  ='RD','III',trim(l.old_name_suffix));
 string v_orig_name_suffix := if(trim(l.orig_name_suffix) ='RD','III',trim(l.orig_name_suffix));

 self.title        := l.old_title;
 self.fname        := l.old_fname;
 self.mname        := l.old_mname;
 self.lname        := if(v_lname in suffixes,'',v_lname);
 self.name_suffix  := if(v_lname=v_orig_name_suffix,v_lname,v_name_suffix);
 self              := l;
 
end;

p1 := project(ds,t1(left));

rec2 t2(rec2 l) := transform

 boolean shift_pattern := (stringlib.stringfind(trim(l.mname),' ',1)!=0 and trim(l.lname)='');
 
 string v_true_mname   := if(shift_pattern,l.mname[1..stringlib.stringfind(trim(l.mname),' ',1)-1],l.mname);
 string v_true_mname_2 := if(v_true_mname in ['NMI','NMN'],'',if(regexfind('^NMI |^NMN ',v_true_mname),v_true_mname[5..20],v_true_mname));
 string v_true_lname   := if(shift_pattern,l.mname[stringlib.stringfind(trim(l.mname),' ',1)+1..20],l.lname);
 string v_true_lname_2 := if(regexfind('^NMI |^NMN ',v_true_lname),v_true_lname[5..20],v_true_lname);

 self.mname := v_true_mname_2;
 self.lname := v_true_lname_2;
 self           := l;
 
end;

p_name_cleanup := project(p1,t2(left));

p_name_cleanup_mname_check := p_name_cleanup(mname <> old_mname);
p_name_cleanup_lname_check := p_name_cleanup(lname <> old_lname);

output(enth (p_name_cleanup_mname_check,1,100,1),named('mname_delta_sample'));
output(enth (p_name_cleanup_lname_check,1,100,1),named('lname_delta_sample'));
output(count(p_name_cleanup_mname_check),        named('mnames_affected'   ));
output(count(p_name_cleanup_lname_check),        named('lnames_affected'   ));

/*
rec1 t_overwrite_bad(rec2 l) := transform
 self.mname := l.new_mname;
 self.lname := l.new_lname;
 self       := l;
end;

p_overwrite_bad := project(p_name_cleanup,t_overwrite_bad(left)) : persist('persist::File_LN_TU_Normalized_All_patched');
*/
//All NMI's are resolved however there are 8 records that meet this condition - it's because the orig name is garbage.
potential_unresolved_suffix := p_name_cleanup(trim(lname) in suffixes);
output(potential_unresolved_suffix);
count(potential_unresolved_suffix);

output(p_name_cleanup,,'base::File_LN_TU_Normalized_All_patched',__compressed__,overwrite);

export Patch_File_LN_TU_Normalized := p_name_cleanup;