//bug 29753 highlights a very rare case of 2 individuals with the same name and DOB

did_st_set := [
'WA000137071458'
];

export fn_blank_the_did(dataset(recordof(Crim_Common.Layout_Moxie_Crim_Offender2.new)) in_crim) := function

recordof(in_crim) t1(in_crim le) := transform
 self.did := if(le.state_origin+le.did in did_st_set,'',le.did);
 self     := le;
end;

p1 := project(in_crim,t1(left));

return p1;

end;