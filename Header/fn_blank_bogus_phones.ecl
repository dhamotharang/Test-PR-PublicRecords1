import ut ; 

export fn_blank_bogus_phones(string phone) := function

phone_out := if(phone in ut.Set_BadPhones
                or (length(trim(phone,left,right)) = 7 and  trim(phone,left,right)[1] = '0')
                or (length(trim(phone,left,right)) = 10 and trim(phone,left,right)[4] = '0'), '', phone);
return phone_out;

end; 