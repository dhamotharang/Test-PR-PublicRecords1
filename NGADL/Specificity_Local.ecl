export Specificity_Local(infile,infield,ufield,null_value_label,label,bfoul_label,spec_values,add_initials = false,word_bag = false) := MACRO
// Data must come in distributed by ufield
import ut;
#uniquename(h)
shared %h% := nofold(table(infile,{infield,ufield})); // Bug 28971

#uniquename(s0)
shared %s0% := dedup(sort(%h%,infield,ufield,local),infield,ufield,local);
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
shared %s% := %s0%;
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
export null_value_label := dataset([{'',0,0}],%r0%);
#else
export null_value_label := %topnf%(exists(%nv%) and cnt>%nv%[1].cnt);
#end
#uniquename(atot)
%atot% := sum(%t0%,cnt);
#uniquename(fsr)
%fsr% := record
  %t0%;
  real8 field_specificity := log( (real8)%atot% / (real8)%t0%.cnt ) / log(2);
  end;

export spec_values := table(%t0%,%fsr%);

#uniquename(s_nonull)
%s_nonull% := join(%s%,null_value_label,left.infield=right.infield,transform(left),left only,lookup);
#uniquename(r1)
%r1% := record
	unsigned8 cnt := count(group);
  end;
#uniquename(t1)		
%t1% := table(%s_nonull%,%r1%,ufield,local);
export bfoul_label := count(%t1%(cnt>1)) / count(%t1%);

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
	