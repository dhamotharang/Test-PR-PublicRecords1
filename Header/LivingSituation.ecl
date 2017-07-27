import watchdog,ut;
hh := file_hhid_current(ver=1);
b := watchdog.File_Best;

pcr := record
  b.did;
  unsigned1 age := ut.GetAgeI(b.dob);
  string1   gender := datalib.gender(trim(b.fname));
  end;

personal_characteristics := table(b,pcr);


house_char := record
  pcr;
  string20 lname;
  unsigned6 hhid;
  end;
  
  
house_char take_two(pcr le,hh ri) := transform
  self := le;
  self.lname := ri.lname;
  self.hhid := ri.hhid_relat;
  end;

appends := join(personal_characteristics,hh,left.did=right.did,take_two(left,right),hash);  


living_status := record
  unsigned6 did;
  unsigned6 hhid;
  string1   gender;
  unsigned2 house_size;
  unsigned2 sg_within_7;
  unsigned2 dg_within_7;
  unsigned2 ug_within_7;
  unsigned2 sg_y_8_15;
  unsigned2 dg_y_8_15;
  unsigned2 ug_y_8_15;
  unsigned2 sg_y_16_30;
  unsigned2 dg_y_16_30;
  unsigned2 ug_y_16_30;
  unsigned2 sg_o_8_15;
  unsigned2 dg_o_8_15;
  unsigned2 ug_o_8_15;
  unsigned2 sg_o_16_30;
  unsigned2 dg_o_16_30;
  unsigned2 ug_o_16_30;
  unsigned2 sg_o_30;
  unsigned2 dg_o_30;
  unsigned2 ug_o_30;
  unsigned2 sg_y_30;
  unsigned2 dg_y_30;
  unsigned2 ug_y_30;
  unsigned2 sg;
  unsigned2 dg;
  unsigned2 ug;
  end;

dgen(string1 l, string1 r) := l<>r and ~l IN ['U','N',' '] and ~r IN ['U','N',' '];
ugen(string1 l, string1 r) := l IN ['U','N'] or r IN ['U','N'];
sgen(string1 l, string1 r) := l=r and ~ugen(l,r);

ran(unsigned v,unsigned l,unsigned r) := v >= l and v <= r;
  
living_status set_age(house_char le, house_char ri) := transform
  self.did := le.did;
  self.hhid := le.hhid;
  self.gender := le.gender;
  self.house_size := 1;
  self.sg := if (le.did<>ri.did and sgen(le.gender,ri.gender) and (le.age=0 or ri.age=0),1,0);
  self.dg := if (dgen(le.gender,ri.gender) and (le.age=0 or ri.age=0),1,0);
  self.ug := if (le.did<>ri.did and ugen(le.gender,ri.gender) and (le.age=0 or ri.age=0),1,0);
  self.sg_within_7 := if(le.did<>ri.did and sgen(le.gender,ri.gender) and le.age<>0 and ri.age<>0 and abs(le.age-ri.age)<=7,1,0);
  self.dg_within_7 := if(dgen(le.gender,ri.gender) and le.age<>0 and ri.age<>0 and abs(le.age-ri.age)<=7,1,0);
  self.ug_within_7 := if(le.did<>ri.did and ugen(le.gender,ri.gender) and le.age<>0 and ri.age<>0 and abs(le.age-ri.age)<=7,1,0);
  self.sg_y_8_15  := if(sgen(le.gender,ri.gender) and le.age<>0 and ri.age<>0 and ran(le.age-ri.age,8,15),1,0);
  self.dg_y_8_15 := if(dgen(le.gender,ri.gender) and le.age<>0 and ri.age<>0 and ran(le.age-ri.age,8,15),1,0);
  self.ug_y_8_15 := if(ugen(le.gender,ri.gender) and le.age<>0 and ri.age<>0 and ran(le.age-ri.age,8,15),1,0);
  self.sg_y_16_30 := if(sgen(le.gender,ri.gender) and le.age<>0 and ri.age<>0 and ran(le.age-ri.age,16,30),1,0);
  self.dg_y_16_30:= if(dgen(le.gender,ri.gender) and le.age<>0 and ri.age<>0 and ran(le.age-ri.age,16,30),1,0);
  self.ug_y_16_30:= if(ugen(le.gender,ri.gender) and le.age<>0 and ri.age<>0 and ran(le.age-ri.age,16,30),1,0);
  self.sg_y_30 := if(sgen(le.gender,ri.gender) and le.age<>0 and ri.age<>0 and ran(le.age-ri.age,31,99),1,0);
  self.dg_y_30:= if(dgen(le.gender,ri.gender) and le.age<>0 and ri.age<>0 and ran(le.age-ri.age,31,99),1,0);
  self.ug_y_30:= if(ugen(le.gender,ri.gender) and le.age<>0 and ri.age<>0 and ran(le.age-ri.age,31,99),1,0);

  self.sg_o_8_15  := if(sgen(le.gender,ri.gender) and le.age<>0 and ri.age<>0 and ran(ri.age-le.age,8,15),1,0);
  self.dg_o_8_15 := if(dgen(le.gender,ri.gender) and le.age<>0 and ri.age<>0 and ran(ri.age-le.age,8,15),1,0);
  self.ug_o_8_15 := if(ugen(le.gender,ri.gender) and le.age<>0 and ri.age<>0 and ran(ri.age-le.age,8,15),1,0);
  self.sg_o_16_30 := if(sgen(le.gender,ri.gender) and le.age<>0 and ri.age<>0 and ran(ri.age-le.age,16,30),1,0);
  self.dg_o_16_30:= if(dgen(le.gender,ri.gender) and le.age<>0 and ri.age<>0 and ran(ri.age-le.age,16,30),1,0);
  self.ug_o_16_30:= if(ugen(le.gender,ri.gender) and le.age<>0 and ri.age<>0 and ran(ri.age-le.age,16,30),1,0);
  self.sg_o_30 := if(sgen(le.gender,ri.gender) and le.age<>0 and ri.age<>0 and ran(ri.age-le.age,31,99),1,0);
  self.dg_o_30:= if(dgen(le.gender,ri.gender) and le.age<>0 and ri.age<>0 and ran(ri.age-le.age,31,99),1,0);
  self.ug_o_30:= if(ugen(le.gender,ri.gender) and le.age<>0 and ri.age<>0 and ran(ri.age-le.age,31,99),1,0);

  end;  

l := join(appends,appends,left.hhid=right.hhid,set_age(left,right),hash);


f_result := record
  string1 status := '';
  l.did;
  l.hhid;
  l.gender;
  unsigned2 house_size := sum(group,l.house_size);
  unsigned2 sg_within_7 := sum(group,l.sg_within_7);
  unsigned2 dg_within_7 := sum(group,l.dg_within_7);
  unsigned2 ug_within_7 := sum(group,l.ug_within_7);
  unsigned2 sg_y_8_15 := sum(group,l.sg_y_8_15);
  unsigned2 dg_y_8_15 := sum(group,l.dg_y_8_15);
  unsigned2 ug_y_8_15 := sum(group,l.ug_y_8_15);
  unsigned2 sg_y_16_30 := sum(group,l.sg_y_16_30);
  unsigned2 dg_y_16_30 := sum(group,l.dg_y_16_30);
  unsigned2 ug_y_16_30 := sum(group,l.ug_y_16_30);
  unsigned2 sg_o_8_15 := sum(group,l.sg_o_8_15);
  unsigned2 dg_o_8_15 := sum(group,l.dg_o_8_15);
  unsigned2 ug_o_8_15 := sum(group,l.ug_o_8_15);
  unsigned2 sg_o_16_30 := sum(group,l.sg_o_16_30);
  unsigned2 dg_o_16_30 := sum(group,l.dg_o_16_30);
  unsigned2 ug_o_16_30 := sum(group,l.ug_o_16_30);
  unsigned2 sg_o_30 := sum(group,l.sg_o_30);
  unsigned2 dg_o_30 := sum(group,l.dg_o_30);
  unsigned2 ug_o_30 := sum(group,l.ug_o_30);
  unsigned2 sg_y_30 := sum(group,l.sg_y_30);
  unsigned2 dg_y_30 := sum(group,l.dg_y_30);
  unsigned2 ug_y_30 := sum(group,l.ug_y_30);
  unsigned2 kids := sum(group,l.sg_y_16_30+l.sg_y_30+l.ug_y_16_30+l.ug_y_30+l.dg_y_16_30+l.dg_y_30);
  unsigned2 parents := sum(group,l.sg_o_16_30+l.sg_o_30+l.ug_o_16_30+l.ug_o_30+l.dg_o_16_30+l.dg_o_30);
  unsigned2 sg := sum(group,l.sg);
  unsigned2 dg := sum(group,l.dg);
  unsigned2 ug := sum(group,l.ug);
  end;

res := table(l,f_result,did,hhid,gender,local);

f_result guess_status(f_result le) := transform
  self.status := MAP( le.house_size = 1 => 'S',
                      ( le.house_size = 2 or le.house_size - ( le.kids + le.parents ) = 2 )
					                    and ( le.dg_within_7 = 1 or
					                          le.ug_within_7 = 1 or
											  le.gender<>'F' and le.dg_y_8_15 = 1 or
											  le.gender<>'F' and le.ug_y_8_15 = 1 or
											  le.gender<>'M' and le.dg_o_8_15 = 1 or
											  le.gender<>'M' and le.ug_o_8_15 = 1 ) => 'M',
		              le.house_size = 2 and le.dg = 1 => 'm',
		              le.house_size = 2 and le.sg_within_7 = 1 => 'Q',
					  le.house_size - le.kids = 1 => 'K',
					  le.house_size = 3 and le.parents = 2 => 'P',
					  le.house_size > 20 => 'W',
					  'U' );
					  
  self := le;
  end;

//export LivingSituation := l;
export LivingSituation := project(res,guess_status(left)) : persist('LivingSituation');