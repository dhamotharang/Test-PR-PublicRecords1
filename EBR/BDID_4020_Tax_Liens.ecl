import _control, ut, Business_Header, Business_Header_SS, did_add, Mdr, Std;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Value Types
//////////////////////////////////////////////////////////////////////////////////////////////
File_in 			:= File_4020_Tax_Liens_In;
segment_code	:= '4020';
dBase					:=	ebr.File_4020_Tax_Liens_Base;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Convert the Input File to Base format
//////////////////////////////////////////////////////////////////////////////////////////////
Layout_4020_Tax_Liens_Base Convert2Base(File_in l) := 
transform
	self.date_first_seen					:= 	business_header.validatedate(l.date_filed);
	self.date_last_seen 					:= 	self.date_first_seen;
	self.process_date_first_seen	:= 	(unsigned4)l.process_date;
	self.process_date_last_seen		:= 	self.process_date_first_seen;
	self.record_type							:= 	'C';
	self 													:= 	l;
	self													:=	[];
end;

File_in2base := project(File_in, Convert2Base(left));

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Clear bdid field on base file
//////////////////////////////////////////////////////////////////////////////////////////////
ebr.Layout_4020_Tax_Liens_Base BlankBDIDBase(ebr.Layout_4020_Tax_Liens_Base l) := 
transform
  self.file_number 			:= regexreplace('\n', l.file_number, ' ');
	self.bdid 						:= 0;
	self.DotID 					 	:= 0;
	self.DotScore 		 		:= 0;
	self.DotWeight 		 		:= 0;
	self.EmpID 				 		:= 0;
	self.EmpScore 		 		:= 0;
	self.EmpWeight 		 		:= 0;
 	self.POWID 				 		:= 0;
	self.POWScore 		 		:= 0;
	self.POWWeight 				:= 0;
	self.ProxID 					:= 0;
	self.ProxScore 				:= 0;
	self.ProxWeight 			:= 0;
	self.SeleID						:= 0;
	self.SeleScore 				:= 0;
	self.SeleWeight 			:= 0;	
	self.OrgID 						:= 0;
	self.OrgScore 				:= 0;
	self.OrgWeight 				:= 0;
	self.UltID 				 		:= 0;
	self.UltScore 		 		:= 0;
	self.UltWeight 		 		:= 0;		
	self 									:= l;
end;

File_Base_blank_bdid := project(dBase, BlankBDIDBase(left));

File_Combined	:=	if(EBR.EBR_Init_Flag(segment_code) = false,
											File_in2base + File_Base_blank_bdid,
											File_in2base
										 );
										 
//////////////////////////////////////////////////////////////////////////////////////////
// -- Set Record Type flag
//////////////////////////////////////////////////////////////////////////////////////////
File_Combined_Grpd_Sort	:= SORT(File_Combined, FILE_NUMBER, Action_code, Document_number, -process_date_last_seen,  local);
File_Combined_Grpd 			:= GROUP(File_Combined_Grpd_Sort,	FILE_NUMBER, Action_code, Document_number, LOCAL);

EBR.Layout_4020_Tax_Liens_Base SetRecordType(EBR.Layout_4020_Tax_Liens_Base l, EBR.Layout_4020_Tax_Liens_Base r) := 
transform
	self.record_type			:=	if(l.record_type = '' or l.process_date = r.process_date, 'C', 'H');
	self									:=	r;
END;

File_Combined_Prop := ITERATE(File_Combined_Grpd, SetRecordType(LEFT, RIGHT));										 
										 
//////////////////////////////////////////////////////////////////////////////////////////
// -- Rollup on Raw Fields, setting date_first_seen, date_last_seen
//////////////////////////////////////////////////////////////////////////////////////////
ebr.Layout_4020_Tax_Liens_Base RollupBase(ebr.Layout_4020_Tax_Liens_Base L, ebr.Layout_4020_Tax_Liens_Base R) := 
transform
	self.date_first_seen 					:= (string8)ut.EarliestDate(
																			ut.EarliestDate((unsigned6)L.date_first_seen,(unsigned6)R.date_first_seen),
																			ut.EarliestDate((unsigned6)L.date_last_seen,(unsigned6)R.date_last_seen));
	self.date_last_seen 					:= (string8)max((unsigned6)L.date_last_seen, (unsigned6)R.date_last_seen);
	self.process_date		 					:= (string8)max((unsigned6)L.process_date, (unsigned6)R.process_date);		
	self.process_date_first_seen	:= 	ut.EarliestDate(	L.process_date_first_seen,R.process_date_first_seen);
	self.process_date_last_seen 	:= 	max(L.process_date_last_seen, R.process_date_last_seen);
	self := L;
END;

File_Combined_dist 	:= distribute(File_Combined_Prop,hash(FILE_NUMBER));
File_Combined_sort 	:= sort		(File_Combined_dist, record, 
																except 	bdid, date_first_seen, date_last_seen, process_date_first_seen, 
																process_date_last_seen, record_type, process_date, 
																local);

File_Combined_rollup:= rollup	(File_Combined_sort,RollupBase(left, right), record, 
																except 	bdid, date_first_seen, date_last_seen, process_date_first_seen, 
																process_date_last_seen, record_type, process_date, 
																local);

//////////////////////////////////////////////////////////////////////////////////////////
// -- Distribute both files
//////////////////////////////////////////////////////////////////////////////////////////
File_dist 				:= distribute(File_Combined_rollup,hash(FILE_NUMBER));
File_sort 				:= sort(File_dist,FILE_NUMBER,-process_date,local);

File_Header_dist  := distribute(ebr.File_0010_Header_Base,	hash(FILE_NUMBER));
File_Header_sort  := sort(File_Header_dist,	FILE_NUMBER,	-process_date_last_seen,	local);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Match to the header record on FILE_NUMBER to get the bdid
//////////////////////////////////////////////////////////////////////////////////////////////
ebr.Layout_4020_Tax_Liens_Base getBDID(File_sort l, File_Header_sort r) := 
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
	self.SeleID 					:= r.SeleID;
	self.SeleScore 				:= r.SeleScore;
	self.SeleWeight 			:= r.SeleWeight;	
	self.OrgID 						:= r.OrgID;
	self.OrgScore 				:= r.OrgScore;
	self.OrgWeight 				:= r.OrgWeight;
	self.UltID 				 		:= r.UltID;
	self.UltScore 		 		:= r.UltScore;
	self.UltWeight 		 		:= r.UltWeight;		
	self.bdid							:= r.bdid;
	self.date_first_seen	:= r.date_first_seen;
	self.date_last_seen		:= r.date_last_seen;
	self									:= l;
end;

File_Out := join(	File_sort,
									File_Header_sort,
									left.FILE_NUMBER = right.FILE_NUMBER and 
									(unsigned)left.process_date >= (unsigned)right.process_date_first_seen and
									(unsigned)left.process_date <= (unsigned)right.process_date_last_seen,
									getBDID(left,right),keep(1),
									local);
				
ebr.Layout_4020_Tax_Liens_Base	tAddProcessDate(ebr.Layout_4020_Tax_Liens_Base	l) :=
transform
	self.process_date := (string)l.process_date_last_seen;
	self 							:= l;
end;

projectBase  := project(File_Out, tAddProcessDate(left));

addGlobalSID := mdr.macGetGlobalSID(projectBase,'EBR','','global_sid'); //DF-26349: Populate Global_SID Field

export BDID_4020_Tax_Liens := addGlobalSID
	/*: persist(EBR_thor + 'TEMP::BDID_' + dataset_name + '_' + segment_code + '_' + decode_segments(segment_code))*/;