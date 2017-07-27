export filterBodyStyleCode(string2 st, string bsc) := map(
st = 'MO' and bsc ~in setBodyStyleCodeMO => '',
st = 'MN' and bsc ~in setBodyStyleCodeMN => '',
st = 'MS' and bsc ~in setBodyStyleCodeMS => '',
st = 'ME' and bsc ~in setBodyStyleCodeME => '',
st = 'NE' and bsc ~in setBodyStyleCodeNE => '',
st = 'ID' and bsc ~in setBodyStyleCodeID => '',
st = 'PA' and bsc ~in setBodyStyleCodePA => '',
st = 'NV' and bsc ~in setBodyStyleCodeNV => '',
st = 'KY' and bsc ~in setBodyStyleCodeKY => '',
st in ['AL','CT','DE','MD','OK','OR','SC'] and bsc ~in setBodyStyleCodeNonUpdatingExperian => '',
bsc);