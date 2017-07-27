export Layout_AddressCleaning_Out := record
 string120 addr1;
 string120 addr2;
 Layout_Clean182;
//Bit mapping:  bit7 = in cache, bit6 = added st, bit5 added zip
 unsigned1 clean_appends;
end;