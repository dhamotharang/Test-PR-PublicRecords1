d := dataset('~thor_data400::in::gp01203_member_numbers',{string13 memno, string64 rest, string1 cr},flat);

r := record
  d.memno;
  string30 name := d.rest[..stringlib.stringfind(d.rest,'  ',1)];
  end;

export File_Members := table(d,r);

/*export File_Members  := dataset('~thor_data400::in::accurint_members', 
 {string20 memno, string1 cr}, flat);*/