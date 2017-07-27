import Worldcheck_Bridger;
export fProcessAdditionalInfoChildren(dataset(GSA.Layouts_GSA.layout_GSA_ID) pRawFileInput) := function

			AdditionalInfoListChildRec := RECORD, MAXLENGTH(15000)
			UNSIGNED8 gsa_id;
			Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.addlinfo_rollup addinfolist;
		END;

		// Need to assign the linking id and attach the item (which contains a dataset) we're interested in
		AdditionalInfoListChildRec NewAdditionalInfoListChildren(pRawFileInput L) := TRANSFORM
			SELF.gsa_id 			:= L.gsa_id;
			SELF.addinfolist 	:= L.additional_info_list;
			SELF 							:= L;
		END;

		AdditionalInfoChildRec := RECORD, MAXLENGTH(25000)
			UNSIGNED8 gsa_id;
			Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.Layout_AddlInfo;
		END;

		addlinfo_layout := Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo;
		// normalize transform...take the Additional Info child dataset & break into a flat file - assign a 'linking-id' to each record.
		AdditionalInfoChildRec NewAdditionalInfoChildren(AdditionalInfoListChildRec L, addlinfo_layout R) := TRANSFORM
			SELF.gsa_id := L.gsa_id;			
			SELF 				:= R;
		END;

		NewAdditionalInfoListChilds 	:= PROJECT(pRawFileInput, NewAdditionalInfoListChildren(LEFT));
		NormAdditionalInfoChilds 			:= NORMALIZE(NewAdditionalInfoListChilds, LEFT.addinfolist.additionalinfo, NewAdditionalInfoChildren(LEFT, RIGHT), LOCAL);
		grpNewAdditionalInfoChilds 		:= GROUP(NormAdditionalInfoChilds, gsa_id, ALL, LOCAL);
		ddGrpNewAdditionalInfoChilds 	:= DEDUP(GROUP(grpNewAdditionalInfoChilds, LOCAL), ALL, LOCAL);

		return ddGrpNewAdditionalInfoChilds;

end; //end fProcessAdditionalInfoChildren function