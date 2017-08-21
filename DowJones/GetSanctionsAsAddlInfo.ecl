Import Worldcheck_Bridger;
EXPORT GetSanctionsAsAddlInfo := FUNCTION

		rSanctions := RECORD
			string			id;
			string			status := '';
			string			dStart;
			string			dEnd;
			string			reference;
			unicode			refName := '';
			string			description2Id := '';
			unicode			comment := '';
		END;


RawSanctions := FUNCTION
			sanctions2 := SORT(
									//Functions.GetSanctions(File_Person) & Functions.GetSanctionsEntity(File_Entity)
									DISTRIBUTE(Functions.GetRawSanctions,(integer)id)
									,id, LOCAL);
									
		rSanctions RollRecs(rSanctions L, rSanctions R) := TRANSFORM
				self.id := L.id;
				self.comment := TRIM(L.Comment) + ' | ' + TRIM(R.Comment);
				self := L;
		END;
		
		sanctions := ROLLUP(sanctions2, id, RollRecs(LEFT, RIGHT), LOCAL);
	
		return sanctions;						
END;

Sanctions := PROJECT(RawSanctions, TRANSFORM({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo},
										self.ID := LEFT.id;
										self.Type := 'Other';
										self.Information := 'Sanctions';
										self.Comments := LEFT.comment;
										self.parsed := '';));

		pSanctions := 
				project(Sanctions,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup},
						self.id := left.id;
						self.additionalinfo := row(left, Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo); 
						)
				);
				
		{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup} rollRecs(
				{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup} L,
				{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup} R) := transform
						self.id  := L.id;
						self.additionalinfo:= L.additionalinfo + row({R.additionalinfo[1].type,
								R.additionalinfo[1].information,
								R.additionalinfo[1].parsed,
								R.additionalinfo[1].comments
					},Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo);
			end;
		 
	return
		rollup(pSanctions, id, rollRecs(left, right));

END;

