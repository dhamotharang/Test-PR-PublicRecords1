IMPORT STD;
 //fmtName(string title, string nm1, string nm2, string nm3, string sfx) := Std.Str.CleanSpaces(title+' '+nm1+' '+nm2+' '+nm3+' '+sfx); 
 fmtName(string title, string nm1, string nm2, string nm3, string sfx) := Std.Str.CleanSpaces(nm1+' '+nm2+' '+nm3+' '+sfx); 
 fmtAddr2(string city, string state, string zip, string zip4) := Std.Str.CleanSpaces(
					TRIM(city) + IF(city='','',', ') + TRIM(state) + ' ' + TRIM(zip) + IF(zip4='','','-') + zip4);

EXPORT To_Slim (dataset($.Layouts.Legacy) file) := FUNCTION

	result := PROJECT(file, TRANSFORM($.Layouts.Slim,
								self.name := fmtName(left.title,left.fname,left.mname,left.lname,left.name_suffix);
								self.addrline := Std.Str.CleanSpaces(left.prim_range+' '+left.predir+' '+left.prim_name+' '+left.suffix+' '+left.postdir+' '+
											IF(left.sec_range='','',left.unit_desig)+' '+left.sec_range);
								self.lastline := fmtAddr2(TRIM(left.city_name),left.st,left.zip,left.zip4);
								self := left;));
								
	return result;

END;