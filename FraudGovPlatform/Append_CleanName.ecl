Export Append_CleanName (
	FileBase
) := FUNCTIONMACRO
		IMPORT NID, Address;		

		useFullname := FileBase(raw_first_name = '' and raw_middle_name = '' and raw_last_name ='' and raw_full_name != '');
		useFields := FileBase(raw_first_name != '' or raw_middle_name !='' or raw_last_name != '');

        #uniquename(cleaned_full) 
		NID.Mac_CleanFullNames(useFullname,%cleaned_full% 
														, raw_full_name
														, includeInRepository:=FALSE, normalizeDualNames:=TRUE
														, useV2:=TRUE);
		#uniquename(cleaned_names) 
		NID.Mac_CleanParsedNames(useFields,%cleaned_names%
														, raw_first_name, raw_middle_name,raw_last_name, raw_Orig_Suffix
														, includeInRepository:=TRUE, normalizeDualNames:=FALSE
														, useV2:=TRUE);
		
		#uniquename(add_clean_name) 
		typeof(FileBase) %add_clean_name%(%cleaned_names% L) := TRANSFORM
			SELF.cleaned_name.title       := L.cln_title;
			SELF.cleaned_name.fname       := L.cln_fname;
			SELF.cleaned_name.mname       := L.cln_mname;
			SELF.cleaned_name.lname       := L.cln_lname;
			SELF.cleaned_name.name_suffix := L.cln_suffix;
			Self.nid                      := L.nid;
			Self.name_ind                 := L.name_ind;
			SELF := L;
		END;		
	
		#uniquename(add_clean_fullname) 
		typeof(FileBase) %add_clean_fullname%(%cleaned_full% L) := TRANSFORM
			SELF.cleaned_name.title       := L.cln_title;
			SELF.cleaned_name.fname       := L.cln_fname;
			SELF.cleaned_name.mname       := L.cln_mname;
			SELF.cleaned_name.lname       := L.cln_lname;
			SELF.cleaned_name.name_suffix := L.cln_suffix;
			Self.nid                      := L.nid;
			Self.name_ind                 := L.name_ind;
			SELF := L;
		END;	
		newCleanFullNames:= PROJECT(%cleaned_full%, %add_clean_fullname%(LEFT));
		newCleanNames:= PROJECT(%cleaned_names%, %add_clean_name%(LEFT));
		
		
		CleanedNames := newCleanFullNames + newCleanNames;

		CleanedRecs := join(
            FileBase, 
            CleanedNames, 
                LEFT.record_id = RIGHT.record_id,
            TRANSFORM(FraudGovPlatform.Layouts.Base.Main, 
				SELF.cleaned_name.title       := IF (LEFT.record_id = RIGHT.record_id, RIGHT.cleaned_name.title, LEFT.cleaned_name.title);
				SELF.cleaned_name.fname       := IF (LEFT.record_id = RIGHT.record_id, RIGHT.cleaned_name.fname, LEFT.cleaned_name.fname);
				SELF.cleaned_name.mname       := IF (LEFT.record_id = RIGHT.record_id, RIGHT.cleaned_name.mname, LEFT.cleaned_name.mname);
				SELF.cleaned_name.lname       := IF (LEFT.record_id = RIGHT.record_id, RIGHT.cleaned_name.lname, LEFT.cleaned_name.lname);
				SELF.cleaned_name.name_suffix := IF (LEFT.record_id = RIGHT.record_id, RIGHT.cleaned_name.name_suffix, LEFT.cleaned_name.name_suffix);
				Self.cleaned_name.name_score  := IF (LEFT.record_id = RIGHT.record_id, RIGHT.cleaned_name.name_score, LEFT.cleaned_name.name_score);
				Self.name_ind                 := IF (LEFT.record_id = RIGHT.record_id, RIGHT.name_ind, LEFT.name_ind);
				Self.nid                      := IF (LEFT.record_id = RIGHT.record_id, RIGHT.nid, LEFT.nid);
                SELF := LEFT),
            LEFT OUTER
        );

		CleanedRecs15 := PROJECT(
            CleanedRecs,
            TRANSFORM(FraudGovPlatform.Layouts.Base.Main, 
				cleaned_fullname:= ut.CleanSpacesAndUpper(LEFT.cleaned_name.fname+LEFT.cleaned_name.mname+LEFT.cleaned_name.lname);
				raw_fullname:=ut.CleanSpacesAndUpper(LEFT.raw_first_name+LEFT.raw_middle_name+LEFT.raw_middle_name);
				SELF.cleaned_name.title       := IF (cleaned_fullname = '' and raw_fullname != '', LEFT.raw_title, LEFT.cleaned_name.title);
				SELF.cleaned_name.fname       := IF (cleaned_fullname = '' and raw_fullname != '', LEFT.raw_first_name, LEFT.cleaned_name.fname);
				SELF.cleaned_name.mname       := IF (cleaned_fullname = '' and raw_fullname != '', LEFT.raw_middle_name, LEFT.cleaned_name.mname);
				SELF.cleaned_name.lname       := IF (cleaned_fullname = '' and raw_fullname != '', LEFT.raw_last_name, LEFT.cleaned_name.lname);
				SELF.cleaned_name.name_suffix := IF (cleaned_fullname = '' and raw_fullname != '', IF( LEFT.raw_Orig_Suffix in ['JR','SR','I','II','III','IV','V','VI','VII','VIII','IX','X',''],LEFT.raw_Orig_Suffix,'' ), LEFT.cleaned_name.name_suffix);
				Self.cleaned_name.name_score  := IF (cleaned_fullname = '' and raw_fullname != '', '15', LEFT.cleaned_name.name_score);
                SELF := LEFT));		

		RETURN( CleanedRecs15 );
ENDMACRO;
