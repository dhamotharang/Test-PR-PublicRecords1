export Mac_Specificity_Local(infile,infield,ufield,null_value_label,null_value_type,label,bfoul_label,spec_values,add_initials = false,word_bag = false,hyphenate=false,blank_null=false) := MACRO
// Data must come in grouped by ufield
// Assumes ClusterSizes has been set up with InCluster giving cluster size
import ut;
#uniquename(s0)
shared %s0% := SALT28.MAC_Field_By_UID(infile,ufield,infield);
#uniquename(s)
#if(hyphenate)
SALT28.MAC_Field_Variants_Hyphen(%s0%,ufield,infield,sv)
shared %s% := sv;
#elsif(add_initials)
SALT28.MAC_Field_Variants_Initials(%s0%,ufield,infield,sv)
shared %s% := sv;
#elsif(word_bag)
SALT28.MAC_Field_Variants_WordBag(%s0%,ufield,infield,sv)
shared %s% := sv;
#else
shared %s% := group(%s0%);
#end
/*
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
shared %t00% := table(%t%,%r0%,infield); // then count them globally, two stage process to avoid skew */
SALT28.MAC_Field_Count_UID(%s%,infield,ufield,sv,countedclusters);
r1 := record // the non-uniquename stuff is ok - have a shared coming up
  sv;
	unsigned4 id := 0;
	end;
t := table(sv,r1);
ut.MAC_Sequence_Records(t,id,t1)
#uniquename(t0)
SALT28.MAC_Field_Specificities(t1,sv1)
export Spec_Values := sv1;
/*#uniquename(atot)
%atot% := sum(%t0%,cnt);
#uniquename(fsr)
%fsr% := record
  %t0%;
  real8 field_specificity := log( (real8)%atot% / (real8)%t0%.cnt ) / log(2);
  end;
export spec_values := table(%t0%,%fsr%);
*/
/*#uniquename(t0)		
shared %t0% := t1;
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
%nv% := sort(iterate(%topnf%,%note_rat%(left,right))(rat>5,cnt>%acnt%),cnt); */
#if(add_initials or word_bag or blank_null)
export null_value_label := dataset([{'',0,0}],null_value_type);
#else
SALT28.MAC_Field_Nulls(spec_values,null_value_type,nv)
export null_value_label := nv;
/*#uniquename(tnv)
%tnv% := %topnf%(exists(%nv%) and cnt>%nv%[1].cnt)+dataset([{'',0,0,0}],%topn_r%);
#uniquename(inv)
null_value_type %inv%(%tnv% le) := transform
  self := le;
  end;
export null_value_label := project(%tnv%,%inv%(left));*/
#end
SALT28.MAC_Field_Bfoul(%s0%,infield,ufield,null_value_label,ClusterSizes,add_initials,hyphenate,bf)
export bfoul_label := bf;
/*
#uniquename(s_nonull0)
%s_nonull0% := join(%s0%,null_value_label,left.infield=right.infield,transform(left),left only,lookup);
#uniquename(s_singles)
%s_singles% := join(%s_nonull0%,ClusterSizes(InCluster>1),left.ufield=right.ufield,transform(left),local);
#uniquename(r1)
%r1% := record
	unsigned8 cnt := count(group);
  end;
#uniquename(t1)		
#if(add_initials or hyphenate)
%t1% := table(dedup(sort(%s_singles%,ufield,-infield,local),left.ufield=right.ufield and left.infield[1..length(trim(right.infield))]=right.infield,local),%r1%,ufield,local);
#else
%t1% := table(%s_singles%,%r1%,ufield,local);
#end
export bfoul_label := if(count(%t1%)=0,0,count(%t1%(cnt>1)) / count(%t1%));
*/
// Prob Left=Right | l.fname=right.fname
// = P(left=right and l.fname=right.fname) / P(l.fname=r.fname)
/*#uniquename(ct0)
%ct0% := join(Spec_Values,null_value_label,left.infield=right.infield,transform(left),left only,lookup);
#uniquename(ssq)
%ssq% := sum( %ct0%,(real8)cnt*cnt);
#uniquename(sss)
%sss% := sum( %ct0%,(real8)cnt);
export label := log(%sss%*%sss%/%ssq%)/log(2);*/
SALT28.MAC_Field_Specificity(Spec_Values,infield,null_value_label,ol)
export label := ol;
  ENDMACRO;
