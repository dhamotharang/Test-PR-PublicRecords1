import header,address,ut,LN_TU;				

Ln_TU_File_To_Join := LN_TU.LN_TU_as_Header;

Header_File_To_Join := Header.file_headers(src ='EQ' or src='MI');								
															
JoinedFile := Join(Header_File_To_Join,Ln_TU_File_To_Join,
									left.phone=right.phone and
									left.ssn=right.ssn and
									left.dob=right.dob and
                  left.title=right.title and
									left.fname=right.fname and
									left.mname=right.mname and
									left.lname=right.lname and
									left.name_suffix=right.name_suffix and
									left.prim_range=right.prim_range and
									left.predir=right.predir and
									left.prim_name=right.prim_name and
									left.suffix=right.suffix and
									left.postdir=right.postdir and
									left.unit_desig=right.unit_desig and
									left.sec_range=right.sec_range and
									left.city_name=right.city_name and
									left.st=right.st and
									left.zip=right.zip and
									left.zip4=right.zip4 and
									left.county=right.county)	;	
									
output(JoinedFile, ,'base::innerjoin_header_tu',overwrite);



/*
dedup(LN_TU.LN_TU_as_Header,phone,ssn,dob,title,fname,
                              mname,lname,name_suffix,prim_range,
                              predir,prim_name,suffix,postdir,
															unit_desig,sec_range,city_name,st,
															zip,zip4,county);				
*/							



