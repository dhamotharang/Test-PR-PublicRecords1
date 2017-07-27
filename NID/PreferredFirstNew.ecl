import NID, STD;

export string20 PreferredFirstNew(string20 name, boolean usenew=true) :=
			If(usenew,
         NID.FindBName(NID.Dictionary_NamesNew, Std.Str.ToUpperCase(name)), 
         NID.FindBName(NID.Dictionary_NamesV1, Std.Str.ToUpperCase(name)));