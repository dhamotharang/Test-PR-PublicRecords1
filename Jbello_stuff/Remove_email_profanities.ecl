import entiera;

not_profanity :=
 '('
+'PEACOCK'
+'|COOK'
+')';
_profanity :=
 '('
+'AS[SH]{1,}[O0]{1,}LE'
+'|BI[T]{1,}CH'
+'|BLOW[ME]{1,}'
+'|C[O0]{1}[CK]{1,}K'
+'|C[OU]{1}NT'
+'|FAG[GEO]{1,}T'
+'|F[O0UC]{1,}K'
+'|PU[S]{1,}Y'
+'|SL[0O]{1,}T'
+'|WH[0O]{1,}RE'
+')';

fn_profanity(string pIn):=regexfind(_profanity, pIn,nocase) and ~regexfind(not_profanity, pIn,nocase);

ent := entiera.File_Entiera_Base;

f1 := ent(~fn_profanity(orig_email));

count(f1);
output(f1,,'~thor_200::base::entiera::basefile'+thorlib.wuid());


/*
// single_name_segment_obscenities := '(ASSHOLE|ASSHOLES|BITCH|BLOWME|BLOWMEBITCH|BLOWMEDOWN|COCK|COCKLICKING|COCKSUCKER|COCKSUCKERS|CUNT|CUNTLIPS|FAGGOT|FUCK|FUCKCHOPS|FUCKED|FUCKER|FUCKFACE|FUCKHEAD|FUCKINGASS|FUCKKKKKKYOU|FUCKOFF|FUCKYOU|FUCKYOUFOR|FUCKYOUMORE|FUCKYOURSELF|FUKFACE|MOTHERFOURKER|MOTHERFUCKER|PUSSY|PUSSYDILDOHEAD|PUSSYEAT|PUSSYFACE|PUSSYLICKER|PUSSYLIPS|PUSSYLOVER|SHIT|SLUT|WHOREFACE|YOUBLOW|YOUBLOWMEASSFUCK)';
not_profanity :=
 '('
 +'PEACOCK'
 +'|COOK'
 +')';
_profanity :=
 '('
 +'AS[SH]{1,}[O0]{1,}LE'
 +'|BI[T]{1,}CH'
 +'|BLOW[ME]{1,}'
 +'|C[O0]{1}[CK]{1,}K'
 +'|C[OU]{1}NT'
 +'|FAG[GEO]{1,}T'
 +'|F[O0UC]{1,}K'
 +'|PU[S]{1,}Y'
 +'|SL[0O]{1,}T'
 +'|WH[0O]{1,}RE'
 +')';

fn_profanity(string pIn)		:= regexfind(_profanity, pIn) and ~regexfind(not_profanity, pIn);
fn_profanity_word(string pIn)	:= regexfind(_profanity, pIn,1);

ent := entiera.File_Entiera_Base;

r1 := record
 boolean possible_profanity;
 string50 match_str:='';
 ent.orig_email;
end;

r1 t1(ent le) := transform
 boolean v_possible_profanity	:=	fn_profanity(le.orig_email)=true
									and	fn_profanity(le.clean_name.lname)=false;
 self.possible_profanity		:= v_possible_profanity;
 self.match_str					:= fn_profanity_word(le.orig_email);
 self                  			:= le;
end;

p1 := project(ent,t1(left));

f1 := p1(possible_profanity=true) :persist('~thor_data400::persist::jbello::onbscene_email_address2');
count(f1);
output(f1);


*/

/*
r:={ boolean possible_profanity, string50 match_str, string orig_email };

d:=dataset('~thor_data400::persist::jbello::onbscene_email_address2',r,flat);

r0:=record
	d.match_str;
	cnt:=count(group);
end;

t:=sort(table(d,r0,match_str),-cnt);

output(t);

*/