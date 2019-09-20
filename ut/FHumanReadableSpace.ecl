import std;

EXPORT FHumanReadableSpace(integer8 pint) :=
function

  insertcommas := fIntWithCommas(pint);
  cntcommas    := length(trim(std.str.filter(insertcommas,','),all));
  /*
    0 commas: hundreds         : 100                                    (Byte     )
    1 comma : thousands        : 1,000                              KB  (Kilobyte ) 10 bit
    2 commas: one million      : 1,000,000                          MB  (Megabyte ) 20 bit
    3 commas: one billion      : 1,000,000,000                      GB  (Gigabyte ) 30 bit
    4 commas: one trillion     : 1,000,000,000,000                  TB  (Terabyte ) 40 bit
    5 commas: one quadrillion  : 1,000,000,000,000,000              PB  (Petabyte ) 50 bit
    6 commas: one quintillion  : 1,000,000,000,000,000,000          EB  (Exabyte  ) 60 bit
    7 commas: one sextillion   : 1,000,000,000,000,000,000,000      ZB  (ZettaByte) 70 bit  -- not supported, max is 64 bits
    8 commas: one septillion   : 1,000,000,000,000,000,000,000,000  YB  (Yottabyte) 80 bit  -- not supported, max is 64 bits
  */
  mystring := realformat(((real8)pint / power(2.0,cntcommas * 10.0)),6,2) +
    choose(cntcommas  
      ,'KB'
      ,'MB'
      ,'GB'
      ,'TB'
      ,'PB'
      ,'EB' //-- 60 bit
      ,'ZB' //-- 70 bit not supported, max is 64 bits
      ,'YB' //-- 80 bit not supported, max is 64 bits
      ,''   //-- bytes
    );
  
  return trim(mystring,left,right);
  
end;