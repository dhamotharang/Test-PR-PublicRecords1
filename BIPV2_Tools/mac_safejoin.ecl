EXPORT mac_safejoin(

   pDs_Left
  ,pDs_right
  ,pField
  ,pLowerField

) := 
functionmacro
//nosort
//local

  #uniquename(savefield)
  #SET(savefield  ,#TEXT(pField) + '_right')

  ds_join1 := join(sort(distribute(pDs_Left,pLowerField),pField,local) ,sort(distribute(pDs_right,pLowerField),pField,local)  ,left.pField = right.pField ,transform({unsigned6 %savefield%,recordof(left)},self.%savefield% := right.pField,self := left),nosort,local,left outer);
  ds_matched      := ds_join1(%savefield% != 0);
  ds_not_matched  := ds_join1(%savefield%  = 0);
  
  ds_join2 := join(ds_not_matched ,pDs_right  ,left.pField = right.pField  ,transform(recordof(left),self.%savefield% := right.pField,self := left),hash,left outer);

  return ds_join2 & ds_matched;
  
endmacro;