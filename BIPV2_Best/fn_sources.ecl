import  mdr;
export fn_sources(string src) := function
source_bitmap :=  map(
src = 'BF' => 1,
src = 'BR' => 2,
src = 'CI' => 3,
src = 'CP' => 4,
src = 'D' => 5, 
src = 'DF' => 6,
src = 'DN' => 7,
src = 'EF' => 8,
src = 'ER' => 9,
src = 'GF' => 10,
src = 'HF' => 11,
src = 'PF' => 12,
src = 'TF' => 13,
src = 'UF' => 14,
src = 'VF' => 15,
src = 'WF' => 16,
src = 'XF' => 17,
src = 'YF' => 18,
src = 'ZF' => 19,
20);

 return source_bitmap;
 end;