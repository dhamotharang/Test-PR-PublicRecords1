import NID, STD;
export string20 PreferredFirst(string20 name) := 
					NID.FindBName(NID.Dictionary_NamesV1, Std.Str.ToUpperCase(name));

