Import Worldcheck_Bridger;
EXPORT GetImagesAsAddlInfo := FUNCTION

RawImages := Functions.GetImages(File_Person);

Images := PROJECT(RawImages, TRANSFORM({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo},
										self.ID := LEFT.id;
										self.Type := 'Other';
										self.Information := 'Images';
										self.Comments := LEFT.cmts;
										self.parsed := '';));

		pImages := 
				project(Images,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup},
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
		rollup(pImages, id, rollRecs(left, right),local);


END;