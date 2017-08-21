import ut;
EXPORT fn_Best_Address_Fields_Votes (STRING source,INTEGER Dups) :=
		MAP((unsigned)source[37..39] & ut.bit_set(0,0) > 0 and // prim_range populated
        (unsigned)source[37..39] & ut.bit_set(0,1) > 0 and // prim_name populated
				(unsigned)source[37..39] & ut.bit_set(0,3) > 0 and // city_name populated
        (unsigned)source[37..39] & ut.bit_set(0,2) > 0 and // sec_range populated
				(unsigned)source[37..39] & ut.bit_set(0,4) > 0 and // zip5 is populated
				(unsigned)source[37..39] & ut.bit_set(0,5) > 0 and // zip4 is populated
				(unsigned)source[37..39] & ut.bit_set(0,6) > 0 and //state is populated
				(unsigned)source[37..39] & ut.bit_set(0,7) > 0 and //not PO Box
				(unsigned)source[37..39] & ut.bit_set(0,8) > 0 =>  2000.0 * Dups,// unit_desig is populated
				(unsigned)source[37..39] & ut.bit_set(0,0) > 0 and // prim_range populated
        (unsigned)source[37..39] & ut.bit_set(0,1) > 0 and // prim_name populated
				(unsigned)source[37..39] & ut.bit_set(0,3) > 0 and // city_name populated
        (unsigned)source[37..39] & ut.bit_set(0,2) > 0 and // sec_range populated
				(unsigned)source[37..39] & ut.bit_set(0,4) > 0 and // zip5 is populated
				(unsigned)source[37..39] & ut.bit_set(0,5) > 0 and // zip4 is populated
				(unsigned)source[37..39] & ut.bit_set(0,6) > 0 and //state is populated
				(unsigned)source[37..39] & ut.bit_set(0,7) > 0 =>  100.0 * Dups,//not PO Box
				(unsigned)source[37..39] & ut.bit_set(0,5) > 0  and // zip4 is populated
				(unsigned)source[37..39] & ut.bit_set(0,7) > 0 => 9 * Dups,//not PO Box				
				(unsigned)source[37..39] & ut.bit_set(0,1) > 0 and // prim_name populated
				(unsigned)source[37..39] & ut.bit_set(0,7) > 0 => 8 * Dups,//not PO Box	
				(unsigned)source[37..39] & ut.bit_set(0,0) > 0 and // prim_range populated
				(unsigned)source[37..39] & ut.bit_set(0,7) > 0 => 7 * Dups,//not PO Box	
				(unsigned)source[37..39] & ut.bit_set(0,2) > 0 and // sec_range populated
				(unsigned)source[37..39] & ut.bit_set(0,7) > 0 => 6 * Dups,//not PO Box	
				(unsigned)source[37..39] & ut.bit_set(0,5) > 0 => 5 * Dups,// zip4 is populated
				(unsigned)source[37..39] & ut.bit_set(0,1) > 0 => 4 * Dups, // prim_name populated			
				(unsigned)source[37..39] & ut.bit_set(0,0) > 0 => 3 * Dups, // prim_range populated	
				(unsigned)source[37..39] & ut.bit_set(0,0) > 0 => 2 * Dups, // sec_range populated	,
				Dups);