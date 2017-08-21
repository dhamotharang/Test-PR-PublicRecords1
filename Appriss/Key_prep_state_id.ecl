import doxie,ut;

layout_slim:=RECORD
string25  state_id;	
string15  booking_sid;
END;

// layout_slim tSlim(file_bookings_base L):= TRANSFORM
// self.state_id   :=trim(L.state_id,left,right);
// self.booking_sid:=trim(L.booking_sid,left,right);
// END;
// df := PROJECT(file_bookings_base(state_id <> '' ),tSlim(LEFT));


layout_slim tSlim(appriss.file_bookings_base L):= TRANSFORM
				 
  st_2 := If(stringlib.stringfind(l.state_id,'#',1) >0 and 
  					 regexfind('^([a-zA-Z][/]*[a-zA-Z -]+[. (]*[#])(.*)$',l.state_id) , regexreplace('^([a-zA-Z][/]*[a-zA-Z -]+[. (]*[#])(.*)$',l.state_id,'$2'),l.state_id);						 
 
  st_3 := if(stringlib.stringfind(st_2,'/',1) >0 and 
             regexfind('^([a-zA-Z][ ]*[a-zA-Z]*[ ]*/)(.*)$',st_2) ,regexreplace('^([a-zA-Z][ ]*[a-zA-Z]*[ ]*/)(.*)$',st_2,'$2'),st_2);
						 
  st_4 := if(stringlib.stringfind(st_3,'/',1) >0 and 
             regexfind('^(.*)(/[a-zA-Z.\' ]*)$',st_3),regexreplace('^(.*)(/[a-zA-Z.\' ]*)$',st_3,'$1'),st_3);
						 
					 
	// st_7 := if(stringlib.stringfind(st_5,'/',1) >0 and 
                 // regexfind('^(.*)([ ]+([0-9]*[0-9])*[/]*([0-9]*[0-9])*[/]([0-9]*[0-9])*)$',trim(st_5)) ,regexreplace('^(.*)([ ]+([0-9]*[0-9])*[/]*([0-9]*[0-9])*[/]([0-9]*[0-9])*)$',trim(st_5),'$1'),trim(st_5));						 
						 
	 st_fixed := MAP(regexfind('^(.*) (JUV ID|DPS[ ]#|[A-Z][A-Z]ID|ID|TDC[ ]*#)$',trim(st_4)) and 
	                 stringlib.stringfind(st_4,'VOID',1) =0 => regexreplace('^(.*) (JUV ID|DPS[ ]#|[A-Z][A-Z]ID|ID|TDC[ ]*#)$',trim(st_4),'$1'),
	                // regexfind('^(["]*ID["-.]*)(.*)$',trim(st_7)) => regexreplace('^(["]*ID["-.]*)(.*)$',trim(st_7),'$2'),
									 trim(st_4));
  
	st_fixed1 := trim(st_fixed,left,right);
	
	trim_st   := MAP(stringlib.stringfind(st_fixed1,'##',1) >0 => stringlib.stringfilterout(st_fixed1,'#'),
	                 stringlib.stringfind(st_fixed1,'**',1) >0 => stringlib.stringfilterout(st_fixed1,'*'),
									 stringlib.stringfind(st_fixed1,'..',1) >0 => stringlib.stringfilterout(st_fixed1,'.'),
									 stringlib.stringfind(st_fixed1,'++',1) >0 => stringlib.stringfilterout(st_fixed1,'+'),
	                 st_fixed1);
	
self.state_id := MAP(trim_st[1..1] in ['#','/',',','-','+',')','(',']','[','*','.','\'','-'] => trim(trim_st[2..],left,right),
                     trim_st[length(trim_st)..length(trim_st)] in ['#','/',',','-','+',')','(',']','[','*','.','\'','-'] => trim(trim_st[1..length(trim_st)-1],left,right),
                     trim(trim_st));
  
//self.fixed_st   :=trim(L.state_id,left,right);
self.booking_sid:=trim(L.booking_sid,left,right);
END;


state_ids := PROJECT(appriss.file_bookings_base(state_id <> '' and
                                  ~regexfind('D[/]*L[/ ]*#|FBI[ ]*#|SS[N]*[I]*[ ]*#|BAG[ ]#|1/P|N[/]*A[0-9][0-9]*[/-][0-9][0-9]*[/-][0-9]*|[ ]DL[ ]*$',trim(state_id)) and 
																  ~regexfind('^[0-9][0-9]*/[0-9][0-9]*/[0-9]{2}([0-9][0-9])*$|YRS|NOFILE|NONE|FBI/|DL/|DOB[ -]|C/I[/(]*[0-9][0-9]*[/-][0-9][0-9]*[/-][0-9]*',trim(state_id)) //and 
                               ),tSlim(LEFT));
//output(count(state_ids));
tosplit := state_ids(regexfind('^[a-zA-Z0-9]{4}[a-zA-Z0-9]*[ ]*/[ ]*[a-zA-Z0-9]{4}[a-zA-Z0-9]*$',trim(state_id)) and 
              stringlib.stringfind(state_id,'/',2) = 0 and 
							stringlib.stringfind(state_id,'/',1) > 0);
//output(choosen(tosplit,15000));
//output(count(tosplit));
keepsame:= state_ids(not(regexfind('^[a-zA-Z0-9]{4}[a-zA-Z0-9]*[ ]*/[ ]*[a-zA-Z0-9]{4}[a-zA-Z0-9]*$',trim(state_id)) and 
                         stringlib.stringfind(state_id,'/',2) = 0 and stringlib.stringfind(state_id,'/',1) > 0));
//output(count(keepsame));
layout_slim NormIt(tosplit L, INTEGER C) := TRANSFORM
le := trim(l.state_id[1..stringlib.stringfind(l.state_id,'/',1)-1],left,right);
le1 := IF(le[1..1] in ['#','/',',','-','+',')','(',']','[','*','.','\'','-'], le[2..],le );
le2 := if(le1[length(le1)..length(le1)] in ['#','/',',','-','+',')','(',']','[','*','.','\'','-'] , le1[1..length(le1)-1],le1);

ri  := trim(l.state_id[stringlib.stringfind(l.state_id,'/',1)+1..],left,right);
ri1 := IF(ri[1..1] in ['#','/',',','-','+',')','(',']','[','*','.','\'','-'], ri[2..],ri );
ri2 := if(ri1[length(le1)..length(ri1)] in ['#','/',',','-','+',')','(',']','[','*','.','\'','-'] , ri1[1..length(ri1)-1],ri1);

self.state_id := CHOOSE(C, le2, ri2 );
SELF := L;
END;
final_ds := NORMALIZE(tosplit,2,NormIt(LEFT,COUNTER));
df := final_ds(state_id <> '' and regexfind('[0-9]',trim(state_id)))+keepsame;

export Key_prep_state_id := 
 index(df,{state_id},{booking_sid},
         '~thor_200::key::appriss::'+ doxie.Version_SuperKey+'::state_id' );
