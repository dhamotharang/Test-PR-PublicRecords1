import STD;

EXPORT StandardizeName(string s) := (string)Std.Uni.CleanAccents(Std.Str.CleanSpaces(STD.Str.ToUpperCase(
																	Std.Str.SubstituteIncluded(
																		Std.Str.SubstituteIncluded(s, '_',' ')
																		,'¿·','?'))));