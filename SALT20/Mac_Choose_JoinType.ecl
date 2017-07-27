export Mac_Choose_JoinType(mainfile,null_dataset,valuefile,field_name,fieldweight_name,trans_name,outfile) := MACRO
   
#uniquename(sj)
%sj% := join(mainfile,PULL(valuefile),left.field_name=right.field_name,trans_name(left,right,true),lookup, left outer);
#uniquename(tpn)
%tpn% := topn(valuefile,100000,-cnt);	 
#uniquename(sjb)
%sjb% := join(mainfile,%tpn%,left.field_name=right.field_name,trans_name(left,right,false),lookup);
#uniquename(sjbp)
%sjbp% := %sjb% + JOIN(JOIN(mainfile,%tpn%,left.field_name=right.field_name,transform(left),LOOKUP,LEFT ONLY),PULL(valuefile),left.field_name=right.field_name,trans_name(left,right,true), left outer, HASH);
outfile :=	if ( count(valuefile)*sizeof(valuefile,max)<1000000000,%sj%,%sjbp%);
  endmacro;
  
