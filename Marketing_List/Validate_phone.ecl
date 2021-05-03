import Address,ut;
// -- this is also interesting  Phonesplus_v2.Mac_Filter_Bad_Phones, but I need a function to operate on a string, not a dataset because it is within a child dataset
EXPORT Validate_phone(

          string  pPhone
  ,set of string  pSet_Bad_Phones  = Marketing_List._Config().set_bad_phones

) := 
function

  lclean_phone := Address.CleanPhone(pPhone);
  
  remove_bad_phones := if(
       trim(lclean_phone)         in Marketing_List._Config().set_bad_phones
    or lclean_phone[1]            in ['0','1']
    or length(trim(lclean_phone)) != 10
      ,''
      ,lclean_phone
   );
 
  return remove_bad_phones;
  
end;