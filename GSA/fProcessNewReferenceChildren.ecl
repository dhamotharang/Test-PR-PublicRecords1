import STD;
export fProcessNewReferenceChildren(dataset(GSA.Layouts_GSA.layout_GSA_ID) pRawFileInput) := function

		trimUpper(string s) := function
			return trim(stringlib.StringToUppercase(s),left,right);
		end;

		references_rec := RECORD
			UNSIGNED8     gsa_id;
			STRING1       primary_aka_name := '';
			STRING        name := '';
			SET OF STRING references;
		END;

		references_rec get_references(pRawFileInput L) := TRANSFORM
			clean_reference := REGEXREPLACE('^Cross-Reference: ', L.comments, '');			
			SELF.references := STD.Str.SplitWords(clean_reference, '|');		
			SELF := L;
		END;

		NewReferences := PROJECT(pRawFileInput, get_references(LEFT));

		references_rec NewReferenceChildren(references_rec L, INTEGER C) := TRANSFORM
			// There's no longer aka(s) with SAM data, so if it's not (P)rimary, then it's a (R)eference.
			SELF.primary_aka_name := 'R';
			SELF.name 						:= trimUpper(L.references[C]);
			SELF 									:= L;
		END;

		// call to normalize the Reference child dataset. left parameter is the parent record, right parameter is the Reference child dataset.
		xNewReferenceChilds 	:= normalize(NewReferences,count(left.references),NewReferenceChildren(left,counter),local);

		grpNewReferenceChilds := group(xNewReferenceChilds,gsa_id,all,local);
		NewReferenceChilds 		:= dedup(group(grpNewReferenceChilds,local),all,local);

		return NewReferenceChilds;

	end; //end fProcessNewReferenceChildren function