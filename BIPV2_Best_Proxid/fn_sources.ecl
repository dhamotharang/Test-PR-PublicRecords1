import BIPV2;
export fn_sources(string src) := BIPV2.mod_sources.src2bmap(trim(src[..2],all), trim(src[3..36], all));
// import  mdr, ut;
// export fn_sources(string src) := function
// source_bitmap :=  map(
  // MDR.sourceTools.SourceIsDunn_Bradstreet(trim(src[..2],all)) => ut.bit_set(0,0),
  // MDR.sourceTools.SourceIsProperty(trim(src[..2],all))        => ut.bit_set(0,1),
  // MDR.sourceTools.SourceIsEBR(trim(src[..2],all))             => ut.bit_set(0,2),
  // MDR.sourceTools.SourceIsDPPA(trim(src[..2],all))             => ut.bit_set(0,3),
  // 0);
/*
trim(src[..2],all) = 'BF' => ut.bit_set(0,0),
trim(src[..2],all) = 'BR' => ut.bit_set(0,1),
trim(src[..2],all) = 'CI' => ut.bit_set(0,2),
trim(src[..2],all) = 'CP' => ut.bit_set(0,3),
trim(src[..2],all) = 'D' => ut.bit_set(0,4),
trim(src[..2],all) = 'DF' => ut.bit_set(0,5),
trim(src[..2],all) = 'DN' => ut.bit_set(0,6),
trim(src[..2],all) = 'EF' => ut.bit_set(0,7),
trim(src[..2],all) = 'ER' => ut.bit_set(0,8),
trim(src[..2],all) = 'GF' => ut.bit_set(0,9),
trim(src[..2],all) = 'HF' => ut.bit_set(0,10),
trim(src[..2],all) = 'PF' => ut.bit_set(0,11),
trim(src[..2],all) = 'TF' => ut.bit_set(0,12),
trim(src[..2],all) = 'UF' => ut.bit_set(0,13),
trim(src[..2],all) = 'VF' => ut.bit_set(0,14),
trim(src[..2],all) = 'WF' => ut.bit_set(0,15),
trim(src[..2],all) = 'XF' => ut.bit_set(0,16),
trim(src[..2],all) = 'YF' => ut.bit_set(0,17),
trim(src[..2],all) = 'ZF' => ut.bit_set(0,18),
ut.bit_set(0,19));*/
// return source_bitmap;
 // end;