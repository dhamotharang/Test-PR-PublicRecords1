export MAC_ChooseJoinType(mainfile,null_dataset,valuefile,field_name,fieldweight_name,trans_name,outfile) := MACRO
   
#uniquename(sj)
%sj% := join(mainfile,valuefile,left.field_name=right.field_name,trans_name(left,right),lookup, left outer);
	 
#uniquename(sjb)
%sjb% := join(mainfile,topn(valuefile,100000,-cnt),left.field_name=right.field_name,trans_name(left,right),lookup, left outer);
#uniquename(sjbp)
%sjbp% := %sjb%(field_name IN set(null_dataset,field_name) or fieldweight_name<>0) + join(%sjb%(field_name NOT IN set(null_dataset,field_name),fieldweight_name=0),valuefile,left.field_name=right.field_name,trans_name(left,right), left outer, hash);
outfile :=	if ( count(valuefile)*sizeof(valuefile,max)<1000000000,%sj%,%sjbp%);
  endmacro;
    

