IMPORT Civ_Court, ut;

EXPORT Files_In_PA_Bucks := MODULE

	EXPORT DOC_in := dataset('~thor_data400::in::civil::pa_bucks_doc', Civ_Court.Layouts_In_PA_Buck.DOC_In, csv(terminator('\n'), separator('|')));
	EXPORT Name_in := dataset('~thor_data400::in::civil::pa_bucks_name', Civ_Court.Layouts_In_PA_Buck.Name_In, csv(terminator('\n'), separator('|')));
	
	dedDOC := dedup(sort(DOC_in,dock_no,d_date_filed),RECORD);
	dedName	:= dedup(sort(Name_in,dock_no,n_date_filed,n_last_name,n_first_name),RECORD);
	
	//Join both files for final Input file for mapping
	Civ_Court.Layouts_In_PA_Buck.Civil_join_in jDOCName(dedDOC l, dedName r) := TRANSFORM 
		self := l;
		self := r;
		self := [];
	END;
	
	jAll := JOIN(sort(distribute(dedDOC,hash(DOCK_NO)),DOCK_NO,local), sort(distribute(dedName,hash(DOCK_NO)),DOCK_NO,local),
														trim(left.DOCK_NO,all) = trim(right.DOCK_NO,all),
														jDOCName(left,right),full outer,local);
														
	EXPORT Civil_join := dedup(sort(jall,DOCK_NO,d_date_filed,n_date_filed,n_last_name,n_first_name),record);
	
END;