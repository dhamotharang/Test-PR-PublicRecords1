Import ut;

EXPORT fn_concat_name_KY(string fname, string mname, string lname) := function

temp_name:=   if(REGEXFIND('SALES ',fname) OR
              REGEXFIND('AUTO ',fname) OR
              REGEXFIND('INC. ',fname) OR
              REGEXFIND('INC, ',fname) OR
              REGEXFIND('ASSOCIATES',fname) OR
              REGEXFIND('CORP',fname) OR
              REGEXFIND('TRUST',fname) OR
              REGEXFIND('L.L.C. ',fname) OR
              REGEXFIND('L.L.P. ',fname) OR
              REGEXFIND('CONTRACTORS',fname) OR
              REGEXFIND('CONSTRUCTION',fname) OR
							REGEXFIND('COUNCIL ',fname) OR
              REGEXFIND('PLUMBING ',fname) OR
              REGEXFIND('MFG ',fname) OR
              REGEXFIND('DEPT ',fname) OR
              REGEXFIND('COMPANY ',fname) OR
              REGEXFIND('CARPET ',fname) OR
              REGEXFIND('TRST ',fname) OR  
              REGEXFIND(' LP ',fname) OR 
              REGEXFIND('BOAT ',fname) OR
							REGEXFIND('BOATS ',fname) OR
              REGEXFIND('CO ',fname) OR
							REGEXFIND('CO.',fname) OR
              REGEXFIND('REC ',fname) OR
              REGEXFIND('MOTORS ',fname) OR
              REGEXFIND('MOTOR ',fname) OR
              REGEXFIND('INSURANCE ',fname) OR
							trim(fname,left,right)[1..4] = 'INC ' OR
              trim(fname,left,right)[1..4] = 'LLC ' OR
              trim(fname,left,right)[1..4] = 'LLP ' OR
              REGEXFIND('CREDIT UNION ',fname) OR
							REGEXFIND('VALLEY ',fname) OR
							REGEXFIND('RECREATION ',fname) OR
							REGEXFIND('YAMAHA ',fname) OR
							REGEXFIND('TRUCKS ',fname) OR
							REGEXFIND('TRAILER ',fname) OR
							REGEXFIND('LANDSCAPE ',fname) OR
							REGEXFIND('SAILING ',fname) OR
							REGEXFIND('CREEK ',fname) OR
							REGEXFIND('ENTERPRISE',fname) OR
							REGEXFIND('RANCH ',fname) OR
							REGEXFIND('STATE ',fname) OR
							REGEXFIND('FEDERAL ',fname) OR
							REGEXFIND('BANK ',fname) OR
							REGEXFIND('AGRICULTUR',fname) OR
							REGEXFIND('CREDIT ',fname) OR
							REGEXFIND('PRODUCTS ',fname) OR
							REGEXFIND('CHURCH ',fname) OR
							REGEXFIND('OF ',fname) OR
							REGEXFIND('^OR ',fname) OR
							trim(fname,left,right)[1..1] ='&' OR
							REGEXFIND('^THE ',lname) OR
							REGEXFIND('CAR ',lname) OR
							REGEXFIND('US ',lname) OR
							REGEXFIND('COUNCIL ',lname) OR
							REGEXFIND('^CITY ',lname) OR
							REGEXFIND('NAT\'L',lname) OR
							(StringLib.StringFind(lname,',',1)>0 AND REGEXFIND(' OR$| AND$',trim(lname,left,right))),
							ut.CleanSpacesAndUpper(trim(lname,left,right)+' '+trim(fname,left,right)), 
							ut.CleanSpacesAndUpper(trim(fname)+' '+trim(mname,left,right)+' '+trim(lname)));
		   
temp_name0 := StringLib.StringFindReplace(temp_name, '(OR)',' ');
temp_name1 := REGEXREPLACE(',$',trim(temp_name0,left,right),'');
temp_name2 := REGEXREPLACE(', OR$',trim(temp_name1,left,right),'');
temp_name3 := REGEXREPLACE(' OR$',trim(temp_name2,left,right),'');
temp_name4 := REGEXREPLACE(' AND/OR$',trim(temp_name3,left,right),'');
temp_name5 := REGEXREPLACE(' AND$',trim(temp_name4,left,right),'');
temp_name6 := IF(REGEXFIND('[ ]AND[ ]OR$',trim(fname,left,right)),REGEXREPLACE('AND |OR ',temp_name5,' '),temp_name5);
temp_name7 := IF(REGEXFIND(' OR$',trim(fname,left,right)),REGEXREPLACE(' OR ',temp_name6,' '),temp_name6);
temp_name8 := IF(REGEXFIND(' AND$',trim(fname,left,right)),REGEXREPLACE(' AND ',temp_name7,' '),temp_name7);
temp_name9 := StringLib.StringFindReplace(temp_name8,'C/O','');
temp_name10 := StringLib.StringFindReplace(temp_name9,'ATTN:',''); 

return trim(temp_name10,left,right) ;  
end; 