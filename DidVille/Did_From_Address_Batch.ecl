import doxie, header, header_services, ut;
// make sure the indata.rid field is populated with a unique value
export Did_From_Address_Batch (DATASET(DidVille.Layout_BestInfo_BatchIn) indata,
					boolean dodedup,  boolean name_phonetics, unsigned1 loose_match_type)
:= function
unsigned4 reclimit := ut.limits.default;

parent_rec := RECORD,maxlength(100 + (reclimit*6))
	qstring20 acctno;
	DATASET(doxie.layout_references) child_dids;
END;

parent_rec tranALF(DidVille.Layout_BestInfo_BatchIn l, unsigned1 loose_type) := TRANSFORM
	bigaddrs := map(loose_type=1 =>
	                  Header_Services.Fetch_Address_MOXIE_Function(l.prim_range,ut.StripOrdinal(stringlib.StringCleanSpaces(l.prim_name)), 
	   				                               l.p_city_name,l.st,l.z5,0,l.sec_range,l.name_last,l.name_first,l.name_middle,
											 name_phonetics),
				 loose_type=2 =>							  
				   Header_Services.Fetch_Address_MOXIE_Loose_Function(l.prim_range,ut.StripOrdinal(stringlib.StringCleanSpaces(l.prim_name)), 
	 										 l.p_city_name,l.st,l.z5,0,l.sec_range,l.name_last,l.name_first,l.name_middle,
											 name_phonetics),
				   Header_Services.Fetch_Address_MOXIE_LastTry_Function(l.prim_range,ut.StripOrdinal(stringlib.StringCleanSpaces(l.prim_name)), 
	 										 l.p_city_name,l.st,l.z5,0,l.sec_range,l.name_last,l.name_first,l.name_middle,
											 name_phonetics)							 
											 );
	SELF.child_dids := CHOOSEN(DEDUP(SORT(bigaddrs, did),did),reclimit);
	SELF := l;
END;
ParentRecsALF := project(indata(prim_name!=''),tranALF(LEFT, loose_match_type));
/*
parent_rec tranZ(DidVille.Layout_BestInfo_BatchIn l) :=
TRANSFORM
	bigaddrs := Header_Services.Fetch_Header_Zip_Function(l.prim_range, l.prim_name, 
								  			    l.p_city_name,l.st,l.z5,0,
											    l.sec_range,l.name_last,l.name_first,
											    name_phonetics);
	SELF.child_dids := CHOOSEN(DEDUP(SORT(bigaddrs.outrecszip, did),did),reclimit);
	SELF := l;
END;
ParentRecsZ := project(indata(z5!='', name_last!=''),tranZ(LEFT));
*/
ParentRecs := ParentRecsALF;

out_rec := record
     qstring20 acctno;
	doxie.layout_references;
end;

out_rec NormIt(ParentRecs l, doxie.layout_references r) := TRANSFORM
     SELF.acctno := l.acctno;
	SELF.did := r.did;
END;

NormRecs := NORMALIZE(ParentRecs,LEFT.child_dids,NormIt(Left,Right));

Outrecs := IF(dodedup, DEDUP(SORT(NormRecs,acctno,did),acctno,did), NormRecs);

return Outrecs;

END;
