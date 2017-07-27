import standard;
export Layout_Payload := record
 unsigned6 BDID;
 unsigned6 DID;
 string50 company;
 unsigned6 FCC_seq;
 standard.Name_slim name;
 standard.L_Address.base addr;
 standard.Phone phone;
 unsigned1 zero := 0;
end;
 