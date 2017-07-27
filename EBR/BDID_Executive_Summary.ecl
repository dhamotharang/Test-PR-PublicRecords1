import ut, Business_Header, Business_Header_SS, did_add;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Distribute and sort both files on unique id
//////////////////////////////////////////////////////////////////////////////////////////////
F_ES_in 	:= File_Executive_Summary_In;
F_ES_dist := distribute(F_ES_in,hash(FILE_NUMBER));
F_ES_sort := sort(F_ES_dist,FILE_NUMBER,local);

F_H_Base  := File_Header_Base;
F_H_dist  := distribute(F_H_Base,hash(FILE_NUMBER));
F_H_sort  := sort(F_H_dist,FILE_NUMBER,local);
F_H_dedup := dedup(F_H_sort,FILE_NUMBER,local);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Match to the header record on FILE_NUMBER to get the bdid
//////////////////////////////////////////////////////////////////////////////////////////////
Layout_Executive_Summary_Base getBDID(F_ES_sort l, F_H_sort r) := 
transform
	self.bdid := r.bdid;
	self 	:= l;
end;

EBR_Executive_Summary_Records_bdid_append := join(
					F_ES_sort,
					F_H_dedup,
					left.FILE_NUMBER = right.FILE_NUMBER,
					getBDID(left,right),
					local);

export BDID_Executive_Summary := EBR_Executive_Summary_Records_bdid_append : persist(EBR_thor + 'TEMP::BDID_' + dataset_name + '_Executive_Summary');
