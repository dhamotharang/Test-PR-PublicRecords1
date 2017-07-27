//========================================================
// Attribute: DeathFunc
// Function to get the best death record.
//========================================================
/*Compile a death list
Group by DID and fname, then count the occurrences.
Pick the most frequent only if it is 1.5x as frequent as the next.
If not, don't pick any -- we don't have a 'best' fname*/

import header, mdr;
export DeathFunc(
    dataset(Header.Layout_Header) myDs, 
    unsigned3 myDate = 0, 
    boolean   dppa   = false, 
		boolean   glb    = false) := FUNCTION

death_flags := [':', '1', '2'];

f := myDs(src in ['DE', 'DS'] and 
          (
					 (prim_name[1..4] = 'DOD ' and prim_name[5] in death_flags) OR 
					 (trim(prim_name) = 'DOD' and prim_range <> '')
					)
		     );

rfields := record
  unsigned6 did;
  string8   dod;
end;

rfields slim(f le) := transform
  self.dod := Map(le.prim_name[5] = ':' => stringlib.StringFilterOut(le.prim_name,'DOD :'),
                  le.prim_name[5] = '1' => stringlib.StringFilterOut(le.prim_name,'DOD '),
			            le.prim_name[5] = '2' => stringlib.StringFilterOut(le.prim_name,'DOD '),
			            trim(le.prim_name) = 'DOD' and le.prim_range <> '' => le.prim_range,
			        '');
  self := le;
end;

slim_h10 := project(f, slim(left));

//Filter with myDate.
slim_h := slim_h10(myDate = 0 OR ((unsigned3)(dod[1..6]) <= myDate));

//Dedup to give one record per DID
dup_h := dedup(sort(slim_h(trim(dod) <> ''), did, dod, local), did, local);

//export records found on the Death Master
return dup_h;
END;

