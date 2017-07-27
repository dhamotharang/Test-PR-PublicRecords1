hsr(string sr) := stringlib.stringfilter(sr,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
isalpha(string1 a) := a >= 'A' and a <= 'Z';
ord(string1 a) := transfer(a,unsigned1)-transfer('A',unsigned1)+1;

export AddressID_fromparts(string prim_range,string predir,string prim_name,
                           string suffix, string postdir,string sec_range,
                           string zip, string st) := 
transfer(hash(prim_name,predir,suffix,postdir),data4)+
transfer(hash(prim_range,zip,st),data4)+
transfer(MAP( hsr(sec_range)='' or (unsigned2)hsr(sec_range)=(unsigned8)hsr(sec_range) and (unsigned2)hsr(sec_range)<>0 => (unsigned2)sec_range,
                    length(trim(sec_range))=1 and isalpha(sec_range[1]) => ord(sec_range[1]),
					isalpha(hsr(sec_range)[1]) and (unsigned2)(hsr(sec_range)[2..8])<>0 => (ord(hsr(sec_range)[1])*1000+(unsigned2)(hsr(sec_range)[2..8])),
                    (unsigned2)hash(hsr(sec_range)) ),data2);