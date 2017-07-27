EXPORT MAC_Enhance_Phones(inpfile, phone10_field, state_field, city_field, zip5_field, outfile) := MACRO

// Unique NPA/NXX Combination Files
// I am assuming these two come in distributed by state,nxx
npaf1 := DISTRIBUTED(Gong.File_TPM_StCtyExc, HASH(state,nxx));
npaf2 := DISTRIBUTED(Gong.File_TPM_StZ3Exc, HASH(state,nxx));

// Only process records with 7-digit phone numbers
inpf7 := distribute(inpfile(state_field<>'', (integer)phone10_field<>0, (integer)(phone10_field[1..3])=0), hash(state_field,phone10_field[4..6]));
inpf0 := inpfile(state_field = '' OR (integer)phone10_field=0 OR (integer)(phone10_field[1..3])<>0);

// Add NPA (Numbering Plan Area/Area Code) to 7-digit phone number
inpfile AddNPA(inpfile le, gong.Layout_TPM ri) := transform
  self.phone10_field := if(ri.npa='', le.phone10_field,ri.npa+le.phone10_field[4..10]);
  self := le;
  end;

// Use Use city, state, and exchange first
npaj1 := join(inpf7,npaf1,
              left.state_field=right.state and
                left.phone10_field[4..6]=right.nxx and
                left.city_field=right.city,
              AddNPA(left,right),
              left outer,local);

// Only process records with 7-digit phone numbers
npaj7 := npaj1((integer)(phone10_field[1..3])=0);
npaj0 := npaj1((integer)(phone10_field[1..3])<>0);

// Use state, zip3, and exchange next
npaj2 := join(npaj7,
              npaf2,
              left.state_field=right.state and 
                left.phone10_field[4..6]=right.nxx and
                left.zip5_field[1..3]=right.zip[1..3],
                AddNPA(left,right),
                left outer,local);

// Append to create result file
outfile := inpf0+npaj0+npaj2;

ENDMACRO;