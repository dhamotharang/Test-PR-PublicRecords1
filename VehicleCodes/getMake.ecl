export getMake(string2 st, string5 mcode, string pDefaultValue='') := 
map(
st = 'FL' => getMakeFL(mcode),
st = 'TX' => getMakeTX(mcode),
st = 'WI' => getMakeWI(mcode),
st = 'MS' => getMakeMS(mcode), //Mississippi
st = 'OH' => getMakeOH(mcode),
st = 'MN' => getMakeMN(mcode),
st = 'MO' => getMakeMO(mcode),
st = 'NC' => getMakeNC(mcode),
st = 'ME' => getMakeME(mcode),
st = 'NE' => getMakeNE(mcode),
st = 'ID' => getMakeID(mcode),
st = 'NM' => getMakeNM(mcode),
st = 'PA' => getMakePA(mcode),
st = 'ND' => getMakeND(pDefaultValue),
st = 'MT' => getMakePA(mcode),			//genericised
st = 'WY' => getMakeWY(mcode),			//genericised
st = 'NV' => getMakeNV(mcode),
st = 'KY' => getMakeKY(mcode),
getMakeMO(mcode));

// the pDefaultValue is to keep function in place but allow states that actually give us the 
//  descriptions to have them placed properly.