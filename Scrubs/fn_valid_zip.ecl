import std,scrubs;

EXPORT fn_valid_zip(string zip) := function

string TrimedZip:=trim(zip,left,right);

boolean ValidZip	:=	if((length(TrimedZip)=5 or length(TrimedZip)=9)and 
											std.str.filterout(TrimedZip[1..5],'0123456789')='' ,true,
																										
											if(length(TrimedZip)<>10,false,
																											
											if((std.str.filterout(TrimedZip[1..5],'0123456789')='')
											and(std.str.filterout(TrimedZip[6],' -')='')
											and(std.str.filterout(TrimedZip[7..10],'0123456789')=''),true,false)));

return if(zip = '' or ValidZip,1,0);

end;