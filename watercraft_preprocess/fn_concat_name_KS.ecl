Import ut;

export fn_concat_name_KS( string fname , string lname) := function

temp_name:=   if(REGEXFIND('USED CARS',fname) OR
							REGEXFIND('INC ',fname) OR
              REGEXFIND('SALES ',fname) OR
              REGEXFIND('AUTO ',fname) OR
              REGEXFIND('INC. ',fname) OR
              REGEXFIND('INC, ',fname) OR
              REGEXFIND('ASSOCIATES',fname) OR
              REGEXFIND('ES W SMITH TRST',fname) OR
              REGEXFIND('FORD & MERCURY',fname) OR
              REGEXFIND('TRSTUAT',fname) OR
              REGEXFIND('CORP',fname) OR
              REGEXFIND('TRUST',fname) OR
              REGEXFIND('FIRSTTRUST ',fname) OR
              REGEXFIND('L.L.C. ',fname) OR
              REGEXFIND('L.L.P. ',fname) OR
              REGEXFIND('MACHINE',fname) OR
              REGEXFIND('METALS',fname) OR
              REGEXFIND('CONTRACTORS',fname) OR
              REGEXFIND('CONSTRUCTION',fname) OR
              REGEXFIND('COUNCIl ',fname) OR
							REGEXFIND('COUNCIL ',fname) OR
              REGEXFIND('PLUMBING ',fname) OR
              REGEXFIND('MFG ',fname) OR
              REGEXFIND('LIFE & PARKS',fname) OR
              REGEXFIND('DEPT ',fname) OR
              REGEXFIND('ELECTRIC COY IN',fname) OR
              REGEXFIND('COMPANY ',fname) OR
              REGEXFIND('CARPET ',fname) OR
              REGEXFIND('TRUCK SALVAGE',fname) OR
              REGEXFIND('TRST ',fname) OR  
              REGEXFIND(' LP ',fname) OR 
              REGEXFIND('ROAD & TRACK',fname) OR
              REGEXFIND('BOAT ',fname) OR
							REGEXFIND('BOATS ',fname) OR
              REGEXFIND('TRUCKS & EQ INC',fname) OR
              REGEXFIND('TRUCKS & EQUIP',fname) OR
              REGEXFIND('CO ',fname) OR
							REGEXFIND('CO.',fname) OR
              REGEXFIND('REC ',fname) OR
              REGEXFIND('P TABOR FAM TRU',fname) OR
              REGEXFIND('MOTORS ',fname) OR
              REGEXFIND('MOTOR ',fname) OR
              REGEXFIND('INSURANCE ',fname) OR
              REGEXFIND('LLC ',fname) OR
              trim(fname,left,right)[1..4] = 'LLC ' OR
              trim(fname,left,right)[1..4] = 'LLP ' OR
              REGEXFIND('CREDIT UNION ',fname) OR
              REGEXFIND('NORTON & ASSOC. ',fname) OR
							REGEXFIND('VALLEY ',fname) OR
							REGEXFIND('RECREATION ',fname) OR
							REGEXFIND('YAMAHA ',fname) OR
							REGEXFIND('TRUCKS ',fname) OR
							REGEXFIND('TRAILER ',fname) OR
							REGEXFIND('LANDSCAPE ',fname) OR
							REGEXFIND('SAILING ',fname) OR
							REGEXFIND('CREEK ',fname) OR
							REGEXFIND('HALLOW ',fname) OR
							REGEXFIND('ENTERPRISE',fname) OR
							REGEXFIND('RANCH ',fname) OR
							REGEXFIND('SUZUKI ',fname) OR
							REGEXFIND('MOTORCYCLE',fname) OR
							REGEXFIND('STATE ',fname) OR
							REGEXFIND('FEDERAL ',fname) OR
							REGEXFIND('BANK ',fname) OR
							REGEXFIND('AGRICULTUR',fname) OR
							REGEXFIND('CREDIT ',fname) OR
							REGEXFIND('PRODUCTS ',fname) OR
							REGEXFIND('OF ',fname) OR
							trim(fname,left,right)[1..1] ='&' OR
							REGEXFIND('THE ',lname) OR
							REGEXFIND('CAR ',lname) OR
							REGEXFIND('US ',lname) OR
							REGEXFIND('FT ',lname) OR
							REGEXFIND('HAZ-MAT',lname) OR
							REGEXFIND('COUNCIL ',lname) OR
							REGEXFIND('NAT\'L',lname),
							ut.CleanSpacesAndUpper(trim(lname,left,right)+' '+trim(fname,left,right)), 
							ut.CleanSpacesAndUpper(trim(fname)+' '+trim(lname)));
		   
temp_name0 := StringLib.StringFindReplace(temp_name,'DTD11-7-95','');
temp_name1 := StringLib.StringFindReplace(temp_name0,'DATED 5-13-99','');
temp_name2 := StringLib.StringFindReplace(temp_name1,'2-3-00','');
temp_name3 := StringLib.StringFindReplace(temp_name2,'4-13-04','');
temp_name4 := StringLib.StringFindReplace(temp_name3,'DT 8-6-03','');
temp_name5 := StringLib.StringFindReplace(temp_name4,'11-13-92','');
temp_name6 := StringLib.StringFindReplace(temp_name5,'--','');
temp_name7 := StringLib.StringFindReplace(temp_name6,'C/O','');
temp_name8 := StringLib.StringFindReplace(temp_name7,'ATTN:',''); 

return trim(temp_name8,left,right) ; 
end; 