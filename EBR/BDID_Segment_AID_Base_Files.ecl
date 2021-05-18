//////////////////////////////////////////////////////////////////////////////////////////////
// -- BDID_Segment_AID_Base_Files() function
// -- Pass it the segment code(ex, '0010') and the update file(in AID base file format)
// -- and it will BDID the combined update and base file
// -- and return the BDID'd file
//////////////////////////////////////////////////////////////////////////////////////////////
import ut, Business_Header, Business_Header_SS, did_add, AID;

export BDID_Segment_AID_Base_Files(segment_code, File_In, File_Out) := macro

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Declare value types
//////////////////////////////////////////////////////////////////////////////////////////////
#uniquename(File_Base)
#uniquename(Layout_Base)
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
#uniquename(HasAddress)
#uniquename(dWith_address)
#uniquename(dWithout_address)
#uniquename(lFlags)
#uniquename(dwithAID)

%Layout_Base% := recordof(File_In);

//////////////////////////////////////////////////////////////////////////////////////////
// -- Set Record Type flag
//////////////////////////////////////////////////////////////////////////////////////////
%File_Combined_Grpd_Sort%	:= SORT(File_In, FILE_NUMBER, -process_date_last_seen,  local);
%File_Combined_Grpd% 			:= GROUP(%File_Combined_Grpd_Sort%,	FILE_NUMBER, LOCAL);

%Layout_Base% %SetRecordType%(%File_Combined_Grpd% l, %File_Combined_Grpd% r) := 
transform
	self.record_type 	:= if(l.record_type = '' or l.process_date = r.process_date, 'C', 'H');
	SELF 			:= r;
END;

%File_Combined_Prop% := ITERATE(%File_Combined_Grpd%, %SetRecordType%(LEFT, RIGHT));

//////////////////////////////////////////////////////////////////////////////////////////
// -- Rollup on Raw Fields, setting date_first_seen, date_last_seen
//////////////////////////////////////////////////////////////////////////////////////////
%Layout_Base% %RollupBase%(%Layout_Base% L, %Layout_Base% R) := 
transform
	self.date_first_seen 					:= (string8)ut.EarliestDate(
																				ut.EarliestDate((unsigned6)L.date_first_seen,(unsigned6)R.date_first_seen),
																				ut.EarliestDate((unsigned6)L.date_last_seen,(unsigned6)R.date_last_seen));
	self.date_last_seen 					:= (string8)max((unsigned6)L.date_last_seen, (unsigned6)R.date_last_seen);
	self.process_date_first_seen	:= ut.EarliestDate(	L.process_date_first_seen,R.process_date_first_seen);
	self.process_date_last_seen 	:= max(	L.process_date_last_seen, R.process_date_last_seen);
	self := L;
END;

%File_Combined_dist% 	:= distribute(%File_Combined_Prop%,hash(FILE_NUMBER));

%File_Combined_sort% 	:= sort(%File_Combined_dist%, record, 
															except 	date_first_seen, date_last_seen, process_date_first_seen, 
															process_date_last_seen, record_type, process_date,
															local);

%File_Combined_rollup%	:= rollup(%File_Combined_sort%,%RollupBase%(left, right), record, 
																	except 	date_first_seen, date_last_seen, process_date_first_seen, 
																	process_date_last_seen, record_type, process_date,
																	local);

//////////////////////////////////////////////////////////////////////////////////////////
// -- Distribute both files
//////////////////////////////////////////////////////////////////////////////////////////
%File_dist% := distribute(%File_Combined_rollup%,hash(FILE_NUMBER));
%File_sort% := sort(%File_dist%,FILE_NUMBER,-process_date,local);

%File_Header_dist%  := distribute(ebr.File_0010_Header_Base,hash(FILE_NUMBER));
%File_Header_sort%  := sort(%File_Header_dist%,	FILE_NUMBER,-process_date_last_seen,local);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Match to the header record on FILE_NUMBER to get the bdid
//////////////////////////////////////////////////////////////////////////////////////////////
%Layout_Base% %getBDID%(%File_sort% l, %File_Header_sort% r) := 
transform
	self.DotID 					 	:= r.DotID;
	self.DotScore 		 		:= r.DotScore;
	self.DotWeight 		 		:= r.DotWeight;
	self.EmpID 				 		:= r.EmpID;
	self.EmpScore 		 		:= r.EmpScore;
	self.EmpWeight 		 		:= r.EmpWeight;
 	self.POWID 				 		:= r.POWID;
	self.POWScore 		 		:= r.POWScore;
	self.POWWeight 				:= r.POWWeight;
	self.ProxID 					:= r.ProxID;
	self.ProxScore 				:= r.ProxScore;
	self.ProxWeight 			:= r.ProxWeight;
	self.SELEID 					:= r.SELEID;
	self.SELEScore 				:= r.SELEScore;
	self.SELEWeight 			:= r.SELEWeight;	
	self.OrgID 						:= r.OrgID;
	self.OrgScore 				:= r.OrgScore;
	self.OrgWeight 				:= r.OrgWeight;
	self.UltID 				 		:= r.UltID;
	self.UltScore 		 		:= r.UltScore;
	self.UltWeight 		 		:= r.UltWeight;		
	self.bdid							:= r.bdid;
	self.date_first_seen	:= r.date_first_seen;
	self.date_last_seen		:= r.date_last_seen;
	self 	:= l;
end;

File_Out := join(	%File_sort%,
				%File_Header_sort%,
				left.FILE_NUMBER = right.FILE_NUMBER and 
				(unsigned)left.process_date >= (unsigned)right.process_date_first_seen and
				(unsigned)left.process_date <= (unsigned)right.process_date_last_seen,
				%getBDID%(left,right),keep(1),
				local);

endmacro;
