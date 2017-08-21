import doxie,ut;

layout_slim:=RECORD
string25  DLNUMBER;
//string25  fixed_dl;	
string15  booking_sid;
END;

layout_slim tSlim(appriss.file_bookings_base L):= TRANSFORM
  dl_1 := If(stringlib.stringfind(l.dlnumber,'#',1) >0 and 
  					 regexfind('^([a-zA-Z.]*[ ]*I[.]*D[.]*[ ]*[a-zA-Z]*[ ]*#)(.*)$',l.dlnumber) and 
						 ~regexfind('(ID[ ]*[a-zA-Z]*#)$',l.dlnumber) , regexreplace('^([a-zA-Z.]*[ ]*I[.]*D[.]*[ ]*[a-zA-Z]*[ ]*#)(.*)$',l.dlnumber,'$2'),l.dlnumber);
						 
  dl_2 := if(stringlib.stringfind(dl_1,'#',1) >0 and 
          	 regexfind('^(.*)(#[/) ]*)$',dl_1) ,regexreplace('^(.*)(I[.]*D[.]*[ ]*[a-zA-Z]*#[/) ]*)$',dl_1,'$1'),dl_1);
 
  dl_3 := if(stringlib.stringfind(dl_2,'/',1) >0 and 
             regexfind('^([a-zA-Z]*[ ]*[a-zA-Z]*/)(.*)$',dl_2) ,regexreplace('^([a-zA-Z]*[ ]*[a-zA-Z]*/)(.*)$',dl_2,'$2'),dl_2);
						 
  dl_4 := if(stringlib.stringfind(dl_3,'/',1) >0 and 
             regexfind('^(.*)(/[a-zA-Z.\' ]*)$',dl_3),regexreplace('^(.*)(/[a-zA-Z.\' ]*)$',dl_3,'$1'),dl_3);
						 
  dl_5 := If(stringlib.stringfind(dl_4,'#',1) >0 and 
  					 regexfind('^([a-zA-Z.]*[ ]*D[.]*L[.]*[ ]*[a-zA-Z]*[ ]*[ID]*#)(.*)$',dl_4) and 
						 ~regexfind('(DL[ ]*[a-zA-Z]*#)$',dl_4) , regexreplace('^([a-zA-Z.]*[ ]*D[.]*L[.]*[ ]*[a-zA-Z]*[ ]*[ID]*#)(.*)$',dl_4,'$2'),dl_4);
						 
  dl_6 := if(stringlib.stringfind(dl_5,'#',1) >0 and 
          	 regexfind('^(.*)(#[ ]*)$',dl_5) ,regexreplace('^(.*)(DL[ ]*[a-zA-Z]*#[ ]*)$',dl_5,'$1'),dl_5);						 
  
	dl_7 := if(stringlib.stringfind(dl_6,'/',1) >0 and 
                 regexfind('^(.*)([ ]+([0-9]*[0-9])*[/]*([0-9]*[0-9])*[/]([0-9]*[0-9])*)$',trim(dl_6)) ,regexreplace('^(.*)([ ]+([0-9]*[0-9])*[/]*([0-9]*[0-9])*[/]([0-9]*[0-9])*)$',trim(dl_6),'$1'),trim(dl_6));						 
						 
  dl_8 := if(stringlib.stringfind(dl_7,'/',1) >0 and 
                regexfind('^(.*)([/]*EXP)(.*)$',dl_7),regexreplace('^(.*)([/]+[ ]*EXP)(.*)$',dl_7,'$1'),trim(dl_7));		
	
	dl_9 := if(stringlib.stringfind(dl_8,'SUS',1) >0 and 
                regexfind('^(.*)(SUS[a-zA-Z\'. `]*)$',trim(dl_8)),regexreplace('^(.*)(SUS[a-zA-Z\'. `]*)$',trim(dl_8),'$1'),trim(dl_8));
								
  dl_10 := if(stringlib.stringfind(dl_9,'SUS',1) >0 and 
                regexfind('^(SUS[a-zA-Z\'. ]*)(.*)$',trim(dl_9)),regexreplace('^(SUS[a-zA-Z\'. ]*)(.*)$',trim(dl_9),'$2'),trim(dl_9));
											
  dl_11 := if(stringlib.stringfind(dl_10,'SUS',1) >0 and 
                 regexfind('^(.*)([/({"][ ]*SUS[a-zA-Z\'. ]*[/)}"][a-zA-Z\'. ]*)$',trim(dl_10)),
	   				     regexreplace('^(.*)([/({"][ ]*SUS[a-zA-Z\'. ]*[/)}"][a-zA-Z\'. ]*)$',trim(dl_10),'$1'),trim(dl_10));
								 
	dl_fixed := MAP(regexfind('^(.*) (ID[ ONLY]*|SC[ID]*|DL|REVOKED|SUSP)$',trim(dl_11)) => regexreplace('^(.*) (ID[ ONLY]*|-ID|SC[ID]*|DL|REVOKED|SUSP)$',trim(dl_11),'$1'),
	                regexfind('^(["]*ID["-.]*)(.*)$',trim(dl_11)) => regexreplace('^(["]*ID["-.]*)(.*)$',trim(dl_11),'$2'),
									trim(dl_11));
  dl_fixed1 := trim(dl_fixed,left,right);
	trim_dl   := MAP(stringlib.stringfind(dl_fixed1,'##',1) >0 => stringlib.stringfilterout(dl_fixed1,'#'),
	                 stringlib.stringfind(dl_fixed1,'**',1) >0 => stringlib.stringfilterout(dl_fixed1,'*'),
									 stringlib.stringfind(dl_fixed1,'..',1) >0 => stringlib.stringfilterout(dl_fixed1,'.'),
	                 dl_fixed1);
	
self.dlnumber := MAP(trim_dl[1..1] in ['#','/',',','-','+',')','(',']','[','*','.','\'','-'] => trim(trim_dl[2..],left,right),
                     trim_dl[length(trim_dl)..length(trim_dl)] in ['#','/',',','-','+',')','(',']','[','*','.','\'','-'] => trim(trim_dl[1..length(trim_dl)-1],left,right),
                     trim(trim_dl));
  
//self.fixed_dl   :=trim(L.dlnumber,left,right);
self.booking_sid:=trim(L.booking_sid,left,right);
END;

//df := PROJECT(file_bookings_base(did <> 0 and action <>'replace'),tSlim(LEFT));
ds := PROJECT(appriss.file_bookings_base(dlnumber <> '' and dlnumber not in ['SUSPENDED','EXPIRED'] and
                                 ~regexfind('L#3|DC[]*#|CELL[ ]*#|FINS[ ]*#|IFD[ ]*#|ALARM PERMIT[ ]*#|BOND[ ]*#|CONTROL[ ]*#|CR[ ]*#|CRUZRF[ ]*#|CSN[ ]*#|CTL[ ]*#|ACCIDENT[ ]*#|ADC[ ]*#|PID[ ]*#',dlnumber) and 
																 ~regexfind('CEL[L]*[ ]*#|FBI[ ]*#|DOT[ ]*#|PMT[ ]*#|DCO[ ]*#|CUST[ ]*#|#####|- DOC|PRISON[ ]*[ID]*[ ]*|002    [A-Z][A-Z]$',dlnumber) and 
																 ~regexfind('AIS[ ]*#|FILE[ ]*#|INS#|SID[ ]*#|&lt;|OPUS[ ]*#|DOC[ ]*[#/]|SS[N]*[I]*[ ]*#|ALIEN[ ]*#|INMATE[ ]*[ID]*[ ]*|PASSPORT[ ]*#|OTHERSS[ ]*#|A[ ]*#[ ]*|S.S.#',dlnumber)),tSlim(LEFT));

tosplit := ds(stringlib.stringfind(dlnumber,'/',2) = 0 and stringlib.stringfind(dlnumber,'/',1) > 0);
//output(count(tosplit));
keepsame:= ds(not(stringlib.stringfind(dlnumber,'/',2) = 0 and stringlib.stringfind(dlnumber,'/',1) > 0));
//output(count(keepsame));
layout_slim NormIt(tosplit L, INTEGER C) := TRANSFORM
le := trim(l.dlnumber[1..stringlib.stringfind(l.dlnumber,'/',1)-1],left,right);
le1 := IF(le[1..1] in ['#','/',',','-','+',')','(',']','[','*','.','\'','-'], le[2..],le );
le2 := if(le1[length(le1)..length(le1)] in ['#','/',',','-','+',')','(',']','[','*','.','\'','-'] , le1[1..length(le1)-1],le1);

ri  := trim(l.dlnumber[stringlib.stringfind(l.dlnumber,'/',1)+1..],left,right);
ri1 := IF(ri[1..1] in ['#','/',',','-','+',')','(',']','[','*','.','\'','-'], ri[2..],ri );
ri2 := if(ri1[length(le1)..length(ri1)] in ['#','/',',','-','+',')','(',']','[','*','.','\'','-'] , ri1[1..length(ri1)-1],ri1);

self.dlnumber := CHOOSE(C, le2, ri2 );
SELF := L;
END;
final_ds := NORMALIZE(tosplit,2,NormIt(LEFT,COUNTER));
df := final_ds(dlnumber <> '' and length(trim(dlnumber))>4 and regexfind('[0-9]',trim(dlnumber)))+keepsame;
export Key_prep_DL := 
 index(df,{dlnumber},{booking_sid},
         '~thor_200::key::appriss::'+ doxie.Version_SuperKey+'::dl' );

