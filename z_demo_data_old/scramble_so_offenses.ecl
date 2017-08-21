import demo_data;
import sexoffender;

file_in:= dataset('~thor::base::demo_data_file_so_offenses_prodcopy',sexoffender.layout_common_offense,flat);

recordof(file_in) scrambleIt(file_in L):= TRANSFORM
//--------------------  Jayants Changes ------------------------------------- 
//Please comment out the primary key if you do not want it scrambled I DID!
//self.seisint_primary_key:=L.seisint_primary_key[1..4]+fn_scramblePII('NUMBER',L.seisint_primary_key[5..11]);
self.court := 'County Court 16';
self.conviction_date:=fn_scramblePII('DOB',L.conviction_date);
self.court_case_number:=fn_scramblePII('NUMBER',(string8)L.court_case_number);
self.offense_date:=fn_scramblePII('DOB',L.offense_date);
self:=L;

END;

export scramble_so_offenses := dedup(sort(PROJECT(file_in, scrambleIt(LEFT)),record),all);
