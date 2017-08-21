pattern sws := pattern('[ \t\r\n]');
pattern ws := sws+;
pattern numbers := pattern('[0-9]')+;
pattern alphaspc := pattern('[-!.,a-zA-Z]');
pattern pobox := ['P.O.','PO'];
pattern AddressStart := (numbers | pobox);
pattern AddressField := (ws | first) AddressStart (ws | last);

f := TM_Test.File_BayArea2000_Test_In;

layout_address_position := record
unsigned2 addrpos := MATCHPOSITION(AddressField/AddressStart);
string addrtext := f.companyaddress1[MATCHPOSITION(AddressField/AddressStart)..];
f;
end;

faddr := parse(f, companyaddress1, AddressField, layout_address_position, not matched, noscan);

count(faddr);
output(faddr);

