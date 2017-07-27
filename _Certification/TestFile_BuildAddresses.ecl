//Build a test base of 1000 Names
layout_addr_stub := RECORD
String Street;
String City;
String State;
String Zip;
END;
Addresses :=DATASET(
          [{'Island Lakes', 'Boca Raton', 'FL', '33498'},
           {'Camino Real', 'Boca Raton', 'FL', '33433'},
           {'Congress Av', 'Boca Raton', 'FL', '33487'},
					 {'Wilson Avenue', 'Arlington',  'VA', '22209'},
					 {'Kingstowne Lane','Alexandria', 'VA', '22315'},
					 {'King Street','Alexandria', 'VA', '22301'}, 
           {'Glebe Road','Alexandria', 'VA','22303'},  
					 {'Coolidge' , 'Troy', 'MI', '480007'},
					 {'Big Beaver', 'Troy', 'MI', '480084'},
					 {'Long Lake', 'Troy', 'MI', '480098'}],layout_addr_stub)
					;


					
layout_Addresses := RECORD
Integer num;
String Street;
String City;
String State;
String Zip;
END;

layout_Addresses genAddresses(Addresses l, integer C) := TRANSFORM
self.num := 1000+C;
self := l;
END;

layout_CleanAddress:=RECORD
layout_Addresses;
String182 clean_Address;
END;

layout_CleanAddress cleanAddrTransform(layout_Addresses l):= TRANSFORM
temp1:=TRIM((L.num+' '+L.Street),left,right);
temp2:=TRIM((L.City+' '+l.State+' '+l.zip),left,right);
self.clean_address := AddrCleanLib.CleanAddress182(temp1,temp2);
self:=l;
END;

addresses_ds := normalize(Addresses,100,genAddresses(left,counter));
cleanAddress_ds := project(addresses_ds,cleanAddrTransform(left));
//hash_address:=sum(cleanAddress_ds,hash(clean_address[179..182]));
//result:=if (hash_address = 2661088419176  ,count(cleanAddress_ds)+' ADDRESS CLEANING TEST: PASS','ADDRESS CLEAN FAILED');
export TestFile_BuildAddresses := cleanAddress_ds;