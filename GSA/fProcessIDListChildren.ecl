import Worldcheck_Bridger;
export fProcessIDListChildren(dataset(GSA.Layouts_GSA.layout_GSA_ID) pRawFileInput) := function

		IDListChildRec := RECORD, MAXLENGTH(15000)
			UNSIGNED8 gsa_id;
			Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.ID_rollup idlist;
		END;

		// Need to assign the linking id and attach the item (which contains a dataset) we're interested in
		IDListChildRec NewIDListChildren(pRawFileInput L) := TRANSFORM
			SELF.gsa_id := L.gsa_id;
			SELF.idlist := L.identification_list;
			SELF 				:= L;
		END;

		IDChildRec := RECORD, MAXLENGTH(25000)
			UNSIGNED8 gsa_id;
			Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_sp;
		END;

		sp_layout := Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_sp;
		// normalize transform...take the Additional Info child dataset & break into a flat file - assign a 'linking-id' to each record.
		IDChildRec NewIDChildren(IDListChildRec L,sp_layout R) := TRANSFORM
			SELF.gsa_id := L.gsa_id;
			SELF := R;
		END;

		NewIDListChilds 	:= PROJECT(pRawFileInput, NewIDListChildren(LEFT));
		NormIDChilds 			:= NORMALIZE(NewIDListChilds, LEFT.idlist.identification, NewIDChildren(LEFT, RIGHT), LOCAL);
		grpNewIDChilds 		:= GROUP(NormIDChilds, gsa_id, ALL, LOCAL);
		ddGrpNewIDChilds 	:= DEDUP(GROUP(grpNewIDChilds, LOCAL), ALL, LOCAL);

		return ddGrpNewIDChilds;

end; //end fProcessIDListChildren function