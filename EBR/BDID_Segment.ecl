//////////////////////////////////////////////////////////////////////////////////////////////
// -- BDID_Segment() function
// -- Pass it the segment code(ex, '0010') and the update file(in base file format)
// -- and it will BDID the combined update and base file
// -- and return the BDID'd file
//////////////////////////////////////////////////////////////////////////////////////////////
import ut, Business_Header, Business_Header_SS, did_add,ebr;

export BDID_Segment(segment_code, File_In, File_Out) := macro

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Declare value types
//////////////////////////////////////////////////////////////////////////////////////////////
#uniquename(File_Base)
#uniquename(Layout_Base)
#uniquename(File_Base_blank_bdid)
#uniquename(File_Combined)
#uniquename(BlankBDIDBase)
#uniquename(PopulateBaseFields)
#uniquename(File_In_common_fields)
#uniquename(RollupBase)
#uniquename(File_Combined_dist)
#uniquename(File_Combined_sort)
#uniquename(File_Combined_rollup)
#uniquename(File_Combined_Grpd)
#uniquename(File_Combined_Grpd_Sort)
#uniquename(SetRecordType)
#uniquename(File_Combined_Prop)
#uniquename(File_dist)
#uniquename(File_sort)
#uniquename(File_Header_dist)
#uniquename(File_Header_sort)
#uniquename(File_Header_dedup)
#uniquename(getBDID)

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Input Files
//////////////////////////////////////////////////////////////////////////////////////////////
ebr.GetSegmentFile_Base(segment_code, %File_Base%)
%Layout_Base% := recordof(%File_Base%);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Populate common base fields on update file
//////////////////////////////////////////////////////////////////////////////////////////////
%Layout_Base% %PopulateBaseFields%(%Layout_Base% l) := 
transform
	self.bdid 				:= 0;
	self.process_date_first_seen	:= (unsigned4)l.process_date;
	self.process_date_last_seen 	:= self.process_date_first_seen;
	self.record_type			:= 'C';
	self 					:= l;
end;

%File_In_common_fields% := project(File_In, %PopulateBaseFields%(left));

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Clear bdid field on base file
//////////////////////////////////////////////////////////////////////////////////////////////
#if(EBR.EBR_Init_Flag(segment_code) = false)
%Layout_Base% %BlankBDIDBase%(%Layout_Base% l) := 
transform
	self.bdid 			:= 0;
	self 				:= l;
end;

%File_Base_blank_bdid% := project(%File_Base%, %BlankBDIDBase%(left));

%File_Combined% := %File_In_common_fields% + %File_Base_blank_bdid%;
#else
%File_Combined% := %File_In_common_fields%;
#end
//////////////////////////////////////////////////////////////////////////////////////////
// -- Rollup on Raw Fields, setting date_first_seen, date_last_seen
//////////////////////////////////////////////////////////////////////////////////////////
%Layout_Base% %RollupBase%(%Layout_Base% L, %Layout_Base% R) := 
transform
	self.date_first_seen 		:= (string8)ut.EarliestDate(
								ut.EarliestDate((unsigned6)L.date_first_seen,(unsigned6)R.date_first_seen),
								ut.EarliestDate((unsigned6)L.date_last_seen,(unsigned6)R.date_last_seen));
	self.date_last_seen 		:= (string8)ut.LatestDate((unsigned6)L.date_last_seen, (unsigned6)R.date_last_seen);
	self.process_date_first_seen	:= ut.EarliestDate(	L.process_date_first_seen,R.process_date_first_seen);
	self.process_date_last_seen 	:= ut.LatestDate(	L.process_date_last_seen, R.process_date_last_seen);
	self := L;
END;

%File_Combined_dist% 	:= distribute(%File_Combined%,hash(FILE_NUMBER));
%File_Combined_sort% 	:= sort(%File_Combined_dist%, record, 
					except 	bdid, date_first_seen, date_last_seen, process_date_first_seen, 
							process_date_last_seen, record_type, process_date,
					local);

%File_Combined_rollup% 	:= rollup(%File_Combined_sort%,%RollupBase%(left, right), record, 
					except 	bdid, date_first_seen, date_last_seen, process_date_first_seen, 
							process_date_last_seen, record_type, process_date,
					local);

//////////////////////////////////////////////////////////////////////////////////////////
// -- Set Record Type flag
//////////////////////////////////////////////////////////////////////////////////////////
%File_Combined_Grpd% 		:= GROUP(%File_Combined_rollup%, 	FILE_NUMBER, LOCAL);
%File_Combined_Grpd_Sort% 	:= SORT(%File_Combined_Grpd%, 	-process_date_last_seen);

%Layout_Base% %SetRecordType%(%File_Combined_Grpd_Sort% l, %File_Combined_Grpd_Sort% r) := 
transform
	self.record_type 	:= if(l.record_type = '' or l.process_date = r.process_date, 'C', 'H');
	SELF 			:= r;
END;

%File_Combined_Prop% := GROUP(ITERATE(%File_Combined_Grpd_Sort%, %SetRecordType%(LEFT, RIGHT)));

//////////////////////////////////////////////////////////////////////////////////////////
// -- Distribute both files
//////////////////////////////////////////////////////////////////////////////////////////
%File_dist% := distribute(%File_Combined_Prop%,hash(FILE_NUMBER));
%File_sort% := sort(%File_dist%,FILE_NUMBER,-process_date,local);

%File_Header_dist%  := distribute(ebr.File_0010_Header_Base,hash(FILE_NUMBER));
%File_Header_sort%  := sort(%File_Header_dist%,	FILE_NUMBER,-process_date_last_seen,local);
%File_Header_dedup% := dedup(%File_Header_sort%,	FILE_NUMBER,local);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Match to the header record on FILE_NUMBER to get the bdid
//////////////////////////////////////////////////////////////////////////////////////////////
%Layout_Base% %getBDID%(%File_sort% l, %File_Header_sort% r) := 
transform
	self.bdid				:= r.bdid;
	self.date_first_seen	:= if(l.date_first_seen != '',l.date_first_seen,	r.date_first_seen);
	self.date_last_seen		:= if(l.date_last_seen != '', l.date_last_seen,	r.date_last_seen);
	self 	:= l;
end;

File_Out := join(	%File_sort%,
				%File_Header_dedup%,
				left.FILE_NUMBER = right.FILE_NUMBER and 
				(unsigned)left.process_date >= (unsigned)right.process_date_first_seen and
				(unsigned)left.process_date <= (unsigned)right.process_date_last_seen,
				%getBDID%(left,right),
				local);

endmacro;
