EXPORT GetLexID(dataset(rAsciiUSNamesANDAddress) infile) := FUNCTION

return DEDUP(PROJECT(infile(LexId <> 0), TRANSFORM({unsigned8 Ent_ID, Layout_XG.layout_sp},
													self.Ent_ID := LEFT.Ent_ID;
													self.type := 'LexId';
													self.number := (string)LEFT.LexId;
													self := [];
													)
							),Ent_ID,type,number,ALL);

END;