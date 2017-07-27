IMPORT STD;

export nneq_phone(string l, string r) := l=r or STD.Str.EndsWith(l,r) or STD.Str.EndsWith(r,l);