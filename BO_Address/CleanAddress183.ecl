export CleanAddress183(const string line1,const string line2,
							const string server = BO_Server, 
							unsigned2 port = BO_Port)	:= FUNCTION
							
return(BO_Address.CleanAddress182(
				RegexReplace('(<)|(>)',line1,''),
				RegexReplace('(<)|(>)',line2,''),
				server,port)+ '0');
end;							