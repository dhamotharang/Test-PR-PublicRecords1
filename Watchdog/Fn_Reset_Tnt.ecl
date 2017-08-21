import header;
export Fn_Reset_Tnt(dataset(recordof(header.layout_header)) file_in) := function
tnt_f := header.TNT_Candidates(file_in);

//Add TNT flag
header.Layout_Header add_flag(file_in le, tnt_f ri) := transform
  self.tnt := if (ri.rid=0,'N',if (le.phone=ri.phone10 and (integer)le.phone!=0,'P','Y'));
    self := le;
  end;

jnd_1 := join(distribute(file_in, hash((unsigned)rid)),distribute(tnt_f,hash((unsigned)rid)),(unsigned)left.rid=(unsigned)right.rid,add_flag(left,right),left outer,local);

return jnd_1;
end;