
RawSanctions := FUNCTION
			sanctions2 := SORT(
									DISTRIBUTE(GetSanctions(Files.dsEntities),Ent_id)
									,Ent_id);
									
		rSanctions RollRecs(rSanctions L, rSanctions R) := TRANSFORM
				self.Ent_id := L.Ent_id;
				self.comment := TRIM(L.Comment) + ' | ' + TRIM(R.Comment);
				self := L;
		END;
		
		sanctions := ROLLUP(sanctions2, Ent_id, RollRecs(LEFT, RIGHT));
	
		return sanctions;						
END;

EXPORT GetSanctionsAsAddlInfo := 

		PROJECT(RawSanctions, TRANSFORM({unsigned8 Ent_id,layout_XG.layout_addlinfo},
										self.Ent_id := LEFT.Ent_id;
										self.Type := 'Other';
										self.Information := 'Sanctions';
										self.Comments := LEFT.comment;
										self.parsed := '';));

