IMPORT Worldcheck_Bridger, Std;

EXPORT CapOneFilters := MODULE

		oc := DowJones.Lists.OccupationList;
		roc := RECORD
			integer		code;
			unicode		position;
		END;
		ocr := PROJECT(oc, TRANSFORM(roc,
							self.code := (integer)left.code;
							self.position := (unicode)left.name;
							));

		shared dictoc := DICTIONARY(ocr, {Code=>position});
		
/************
	Segmentation Group 1: PEP File segmented per Occupation Type: US Domestic
		1) Primary Occupation
		2) Not Deceased
		3) Politically Exposed Persons
		4) Citizenship is United States
		5) All associates included
************/
EXPORT SegGroup1(dataset(Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.routp) xg, integer OccCode) := FUNCTION

		s := U'Type: Primary Occupation | Category: ' + dictoc[OccCode].position;
		f := xg(type='Individual', 
							STD.Str.Find(Reason_Listed, 'Politically Exposed Person (PEP)', 1) > 0,
							STD.Uni.Find(comments, U'Deceased:', 1)=0,
							EXISTS(additional_info_list.additionalInfo(Type='Citizenship',Information='United States')),
							EXISTS(additional_info_list.additionalInfo(STD.Uni.Find(comments, s, 1)>0)));
		return f;

END;

/************
	Segmentation Group 2: PEP File segmented per Occupation Type: Non-US foreign
		1) Primary Occupation
		2) Not Deceased
		3) Politically Exposed Persons
		4) Citizenship is NOT United States
		5) All associates included
************/
EXPORT SegGroup2(dataset(Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.routp) xg, integer OccCode) := FUNCTION

		s := U'Type: Primary Occupation | Category: ' + dictoc[OccCode].position;
		f := xg(type='Individual', 
							STD.Str.Find(Reason_Listed, 'Politically Exposed Person (PEP)', 1) > 0,
							STD.Uni.Find(comments, U'Deceased:', 1)=0,
							NOT EXISTS(additional_info_list.additionalInfo(Type='Citizenship',Information='United States')),
							EXISTS(additional_info_list.additionalInfo(STD.Uni.Find(comments, s, 1)>0)));
		return f;

END;

/************
	Segmentation Group 3: Deceased PEPs
		1) Politically Exposed Persons
		2) Deceased
		3) All associates included
************/
EXPORT SegGroup3(dataset(Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.routp) xg) := FUNCTION

		f := xg(type='Individual', 
							STD.Str.Find(Reason_Listed, 'Politically Exposed Person (PEP)', 1) > 0,
							STD.Uni.Find(comments, U'Deceased:', 1)>0);
		return f;

END;

/************
	Segmentation Group 4: Special Interest Persons 
		1) Special Interest Persons
		2) All associates included
************/
EXPORT SegGroup4(dataset(Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.routp) xg, string desc) := FUNCTION

		f := xg(
							type='Individual',
							STD.Uni.Find(comments, U'Deceased:', 1)=0,
							STD.str.Find(Reason_Listed, 'Special Interest Person', 1) > 0,
							STD.Uni.Find(Reason_Listed, desc, 1)>0);
		return f;

END;

/************
	Segmentation Group 4: Special Interest Entities
		1) Special Interest Entities
		2) All associates included
************/
EXPORT SegGroup4E(dataset(Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.routp) xg, string desc) := FUNCTION

		f := xg(
							type<>'Individual',
							STD.str.Find(Reason_Listed, 'Special Interest Entity', 1) > 0,
							STD.Uni.Find(Reason_Listed, desc, 1)>0);
		return f;

END;


END;