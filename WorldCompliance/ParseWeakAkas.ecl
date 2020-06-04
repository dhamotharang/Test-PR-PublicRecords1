import std;

EXPORT ParseWeakAkas() := FUNCTION
				
		dsAllWeakAKA := GetAkas(Files.dsEntities)(Category = 'Weak');
		dsWeakAKA := dsAllWeakAKA(Comments[1..3] <> 'ID:');
		dsNonWeakAKA := GetAkas(Files.dsEntities)(Category <> 'Weak');
		
		{unsigned8 Ent_ID, unsigned2 Cnt, Layout_XG.layout_aliases} 
			xFormWeakAkas(dsWeakAKA infile) := TRANSFORM
						self.Ent_ID			 	:= infile.Ent_ID,
						self.Cnt				 	:= STD.Str.FindCount((string)infile.full_name, ',') + 1;
						self 							:= infile;
		END;
				
		dsWeakAkaWithCnt := PROJECT(dsWeakAKA, xFormWeakAkas(LEFT));		
		
		{unsigned8 Ent_ID, Layout_XG.layout_aliases} NormWeakAkas(dsWeakAkaWithCnt infile, INTEGER C) := TRANSFORM
				self.Ent_ID 	 := infile.Ent_ID;
				self.Full_Name := STD.Uni.CleanSpaces(STD.Uni.Extract(infile.Full_Name, C));
				self					 := infile;
		END;
		
		dsNormWeakAkas := NORMALIZE(dsWeakAkaWithCnt, LEFT.Cnt, NormWeakAkas(LEFT,COUNTER));
		
		dsDerivedWeakAkas := PROJECT(dsAllWeakAKA(Comments[1..3] = 'ID:'), TRANSFORM(
								{unsigned8 Ent_ID, Layout_XG.layout_aliases},
								self := LEFT;
									));
		
		return SORT(DISTRIBUTE(dsNormWeakAkas&dsDerivedWeakAkas&dsNonWeakAKA, Ent_ID), Ent_ID, category, type, full_name, last_name, first_name, local);
END;