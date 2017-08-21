export Mac_Specificity_Local(infile,infield,ufield,null_value_label,null_value_type,label,bfoul_label,spec_values,add_initials = false,word_bag = false) := MACRO
// Data must come in grouped by ufield
import ut;
#uniquename(h)
//shared %h% := nofold(table(infile,{infield,ufield})); // Bug 28971
shared %h% := table(infile,{infield,ufield});
#uniquename(s00)
#uniquename(r00)
#uniquename(c00)
shared %s00% := sort(%h%,ufield,infield,local);
%r00% := record
	%s00%.ufield;
	unsigned4 c := count(group);
  end;
shared %c00% := table(%s00%,%r00%,ufield,local)(c>1);
#uniquename(s0)
shared %s0% := dedup(%s00%,ufield,infield,local);
#uniquename(s)
#if(add_initials)
#uniquename(apfx)
typeof(%h%) %apfx%(%s0% le,unsigned c) := transform
  self.infield := le.infield[1..c];
  self.ufield := le.ufield;
  end;
	
#uniquename(n)
%n% := distributed(normalize(%s0%,length(trim(left.infield)),%apfx%(left,counter)),ufield);	
#uniquename(s1)
%s1% := dedup(sort(%n%,infield,ufield,local),infield,ufield,local);
shared %s% := %s1%;
#elsif(word_bag)
#uniquename(apfx)
typeof(%h%) %apfx%(%s0% le,unsigned c) := transform
  self.infield := ut.Word(le.infield,c);
  self.ufield := le.ufield;
  end;
	
#uniquename(n)
%n% := distributed(normalize(%s0%,ut.NoWords(left.infield),%apfx%(left,counter)),ufield);	
#uniquename(s1)
%s1% := dedup(sort(%n%,infield,ufield,local),infield,ufield,local);
shared %s% := %s1%;
#else
shared %s% := group(%s0%);
#end
#uniquename(r)
%r% := record
  %s%.infield;
	unsigned8 cnt := count(group);
  end;
#uniquename(t)		
shared %t% := table(%s%,%r%,infield,local); // first count infield values locally
#uniquename(r0)
shared %r0% := record
  %t%.infield;
	unsigned8 cnt := sum(group,%t%.cnt);
	unsigned4 id  := 0;
  end;
#uniquename(t00)
#uniquename(t01)
shared %t00% := table(%t%,%r0%,infield); // then count them globally, two stage process to avoid skew
ut.MAC_Sequence_Records(%t00%,id,%t01%)
#uniquename(t0)		
shared %t0% := %t01%; // then count them globally, two stage process to avoid skew
#uniquename(topn_r)
%topn_r% := record
  %t0%;
	real8 rat := 0.0;
  end;
#uniquename(topnf)
%topnf% := topn(table(%t0%,%topn_r%),2000,-cnt);
#uniquename(note_rat)
%topn_r% %note_rat%(%topnf% le,%topnf% ri) := transform
  self.rat := if ( ri.cnt=0, 1, le.cnt/ri.cnt );
  self := ri;
  end;
		
#uniquename(acnt)
%acnt% := ave(%t0%,cnt) * 0.25;
#uniquename(nv)
%nv% := sort(iterate(%topnf%,%note_rat%(left,right))(rat>5,cnt>%acnt%),cnt);
#if(add_initials or word_bag)
export null_value_label := dataset([{'',0,0}],null_value_type);
#else
#uniquename(tnv)
%tnv% := %topnf%(exists(%nv%) and cnt>%nv%[1].cnt)+dataset([{'',0,0,0}],%topn_r%);
#uniquename(inv)
null_value_type %inv%(%tnv% le) := transform
  self := le;
  end;
export null_value_label := project(%tnv%,%inv%(left));
#end
#uniquename(atot)
%atot% := sum(%t0%,cnt);
#uniquename(fsr)
%fsr% := record
  %t0%;
  real8 field_specificity := log( (real8)%atot% / (real8)%t0%.cnt ) / log(2);
  end;
export spec_values := table(%t0%,%fsr%);
#uniquename(s_nonull0)
%s_nonull0% := join(%s%,null_value_label,left.infield=right.infield,transform(left),left only,lookup);
#uniquename(s_singles)
%s_singles% := join(%s_nonull0%,%c00%,left.ufield=right.ufield,transform(left),local);
#uniquename(r1)
%r1% := record
	unsigned8 cnt := count(group);
  end;
#uniquename(t1)		
#if(add_initials)
%t1% := table(dedup(sort(%s_singles%,ufield,-infield,local),left.ufield=right.ufield and left.infield[1..length(trim(right.infield))]=right.infield,local),%r1%,ufield,local);
#else
%t1% := table(%s_singles%,%r1%,ufield,local);
#end
export bfoul_label := if(count(%t1%)=0,0,count(%t1%(cnt>1)) / count(%t1%));
// Prob Left=Right | l.fname=right.fname
// = P(left=right and l.fname=right.fname) / P(l.fname=r.fname)
#uniquename(ct0)
%ct0% := join(%t0%,null_value_label,left.infield=right.infield,transform(left),left only,lookup);
#uniquename(ssq)
%ssq% := sum( %ct0%,(real8)cnt*cnt);
#uniquename(sss)
%sss% := sum( %ct0%,(real8)cnt);
export label := log(%sss%*%sss%/%ssq%)/log(2);
  ENDMACRO;