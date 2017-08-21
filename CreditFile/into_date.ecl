shared into_date(unsigned2 mo,unsigned2 yr) :=  
IF(mo=0 and yr=0,0,mo & 15 + 100 * yr + IF(yr<5,200000,190000));