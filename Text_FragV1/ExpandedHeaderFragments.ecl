IMPORT Header, MDR, Text_Search;
// Should inherit IFragmentSource, but needs fix for 51580
EXPORT ExpandedHeaderFragments(Types.StateList st_list=ALL) := MODULE
	SHARED Persist_Stem 		:= '~THOR_DATA400::PERSIST::FRAGS_';
	SHARED Persist_Header		:= Persist_Stem + 'Header';
	EXPORT Persist_Name			:= Persist_Header;
	EXPORT DeletePersist 		:= FileServices.DeleteLogicalFile(Persist_Name);
	d0 :=  DATASET(header.Filename_Header,header.Layout_Header_v2,flat);
	d1 := d0(src NOT IN MDR.sourceTools.set_LnPropertyV2);	// no double up
	ds := d1(st IN st_list);
	SHARED hdrFile :=  PROJECT(ds, Layout_ExpandedHeader) : PERSIST(Persist_Header);
	SHARED hdr_mod := ExpandedHeaderBooleanSearch(hdrFile);  
	
	Text_Search.Layout_Posting patchHdr(Text_Search.Layout_Posting l) := TRANSFORM
		SELF.docRef.src := TRANSFER(l.src, UNSIGNED2);
		SELF := l;
	END;
	EXPORT DATASET(Text_Search.Layout_Posting) rawPostings 
						:= PROJECT(hdr_mod.Postings_RID, patchHdr(LEFT));

	Layout_AnswerListData xans(Layout_ExpandedHeader l) := TRANSFORM
		SELF.source_doc_type := 'HEADER';
		SELF.src := TRANSFER(l.src, UNSIGNED2);
		SELF.doc := l.rid;
		SELF.record_id := (STRING) l.rid;
		SELF.dt_last_seen := (STRING) l.dt_last_seen;
		SELF.dob := (STRING) l.dob;
		SELF.phone := StringLib.StringFilterOut(l.phone, ' -');
		SELF.address.addr_suffix := l.suffix;
		SELF.address.zip5 := l.zip;
		SELF.address := l;
		SELF.name := l;
		SELF := l;
		SELF := [];
	END;
	EXPORT DATASET(Layout_AnswerListData) answerRecs 
						:= PROJECT(hdrFile, xans(LEFT));

	EXPORT DATASET(Text_Search.Layout_Segment_ComposeDef) SegmentDefinitions 
									:= hdr_mod.SegmentDefinitions;
END;