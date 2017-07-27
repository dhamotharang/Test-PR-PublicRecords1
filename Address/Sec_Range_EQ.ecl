IMPORT STD;

hsr(string sr) := STD.Str.Filter(sr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
num_only(string sr) := STD.Str.Filter(sr,'0123456789');
let_only(string sr) := STD.Str.Filter(sr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ');

desig(string20 sr) := MAP( STD.Str.Find(trim(sr),' ',1)<>0 => sr[STD.Str.Find(trim(sr),' ',1)+1..],
						 STD.Str.Find(trim(sr),'-',1)<>0 => sr[STD.Str.Find(trim(sr),'-',1)+1..],
                         sr[1] >= 'A' and sr[1]<='Z' and (unsigned4)(sr[2..length(sr)])<>0=> sr[2..],
                         sr[length(trim(sr))] >= 'A' and sr[length(trim(sr))]<='Z' and (unsigned4)(sr[1..length(trim(sr))-1])<>0=> sr[1..length(trim(sr))-1],
                         sr );

export Sec_Range_EQ(string le, string ri) := 
  MAP( le=ri => 0,
       le = '' or ri = '' or hsr(le)=hsr(ri) => 1,
       desig(le)=desig(ri) => 2, 
       num_only(le)=num_only(ri) and (unsigned4)num_only(le)<>0 => 3,
       let_only(le)=let_only(ri) and (unsigned4)num_only(le)=0 and let_only(le)<>'' => 4,
       10 );