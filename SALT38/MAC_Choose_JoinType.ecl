export Mac_Choose_JoinType(mainfile,null_dataset,valuefile,field_name,fieldweight_name,trans_name,outfile) := MACRO
   
// This is the 'nice' path; common, rare and nulls all handled in one lookup,left outer join
#uniquename(sj)
%sj% := JOIN(mainfile,PULL(valuefile),LEFT.field_name=RIGHT.field_name,trans_name(LEFT,RIGHT,TRUE),LOOKUP, LEFT OUTER);
// For doing this the hard way there are three different groups to identify
// 1. the nulls - these still have to go through the transform - which is a little bit painful
#uniquename(nulls)
%nulls% := PROJECT(mainfile(field_name IN SET(null_dataset,field_name)),trans_name(LEFT,DATASET([],RECORDOF(valuefile))[1],TRUE));
// We are now going to peel the 'common' items out to perform a lookup join
#uniquename(tpn)
%tpn% := TOPN(valuefile,100000,-cnt);	 
#uniquename(sjb)
// 2. Do the work on the 'common' values - note - this does NOT include nulls
%sjb% := JOIN(mainfile(field_name NOT IN SET(null_dataset,field_name)),%tpn%,LEFT.field_name=RIGHT.field_name,trans_name(LEFT,RIGHT,FALSE),LOOKUP);
#uniquename(remain)
// 3. Those values of the original file with non-common values
%remain% := JOIN(mainfile(field_name NOT IN SET(null_dataset,field_name)),%tpn%,LEFT.field_name=RIGHT.field_name,TRANSFORM(LEFT),LOOKUP,LEFT ONLY);
#uniquename(sjbp)
%sjbp% := %nulls% + %sjb% + JOIN(%remain%,PULL(valuefile),LEFT.field_name=RIGHT.field_name,trans_name(LEFT,RIGHT,TRUE), LEFT OUTER, HASH);
//outfile :=	if ( count(valuefile)*sizeof(valuefile,max)<1000000000,%sj%,%sjbp%);
outfile :=	IF ( COUNT(valuefile)*SIZEOF(valuefile,MAX)<SALT38.Config.LookupMaxSize,%sj%,%sjbp%);
  ENDMACRO;
  
