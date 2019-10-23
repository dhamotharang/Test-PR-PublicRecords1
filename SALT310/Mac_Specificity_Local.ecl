export Mac_Specificity_Local(infile,infield,ufield,null_value_label,null_value_type,label,bfoul_label,spec_values,add_initials = false,word_bag = false,hyphenate=false,blank_null=false) := MACRO
// Data must come in grouped by ufield
// Assumes ClusterSizes has been set up with InCluster giving cluster size
#uniquename(s0)
shared %s0% := SALT310.MAC_Field_By_UID(infile,ufield,infield);
#uniquename(s)
#if(hyphenate)
SALT310.MAC_Field_Variants_Hyphen(%s0%,ufield,infield,sv)
shared %s% := sv;
#elsif(add_initials)
SALT310.MAC_Field_Variants_Initials(%s0%,ufield,infield,sv)
shared %s% := sv;
#elsif(word_bag)
SALT310.MAC_Field_Variants_WordBag(%s0%,ufield,infield,sv)
shared %s% := sv;
#else
shared %s% := group(%s0%);
#end
SALT310.MAC_Field_Count_UID(%s%,infield,ufield,sv,countedclusters);
r1 := record // the non-uniquename stuff is ok - have a shared coming up
  sv;
	unsigned4 id := 0;
	end;
t := table(sv,r1);
SALT310.utMAC_Sequence_Records(t,id,t1)
#uniquename(t0)
SALT310.MAC_Field_Specificities(t1,sv1)
export Spec_Values := sv1;
#if(add_initials or word_bag or blank_null)
export null_value_label := dataset([{'',0,0}],null_value_type);
#else
SALT310.MAC_Field_Nulls(spec_values,null_value_type,nv)
export null_value_label := nv;
#end
SALT310.MAC_Field_Bfoul(%s0%,infield,ufield,null_value_label,ClusterSizes,add_initials,hyphenate,bf)
export bfoul_label := bf;
SALT310.MAC_Field_Specificity(Spec_Values,infield,null_value_label,ol)
export label := ol;
  ENDMACRO;
