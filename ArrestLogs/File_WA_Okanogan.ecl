Import ArrestLogs, Crim, data_services;

EXPORT File_WA_Okanogan :=  MODULE

	EXPORT	raw		:=	dataset(data_services.foreign_prod+'thor_data400::in::arrlog::wa::okanogan',ArrestLogs.layout_WA_Okanogan.raw_in, CSV(SEPARATOR(','),heading(1),quote('"')));
	
//Remove unnecessary fields at the end of file and headers throughout file
filter_raw := raw(trim(booking_date,ALL) <> 'DATE' AND TRIM(booking_time,ALL)<> 'Year');

//Add sequence number - parent and child records should have same sequence
with_seq_rec :=record
	seq_num_added :=0;
	parent_num		:=0;
	ArrestLogs.layout_WA_Okanogan.raw_in;
END;

with_sequence_num	:=	project(filter_raw,
												TRANSFORM(with_seq_rec, self := left, self.seq_num_added := COUNTER, SELF.parent_num	:=	IF(LEFT.booking_date<>'"',COUNTER,0), SELF	:=	[]));

//Add parent_num to child records
with_sequence_num	tFillParentNum(with_sequence_num	L,	with_sequence_num	R)	:=	TRANSFORM
	SELF.seq_num_added	:=	R.seq_num_added;
	SELF.parent_num			:=	IF(R.seq_num_added=R.parent_num,R.parent_num,L.parent_num);  
	SELF								:=	R;
END;

fill_parent_num	:=	ITERATE(SORT(with_sequence_num,(UNSIGNED)seq_num_added),tFillParentNum(LEFT,RIGHT));

//Split parent and child record and add fields needed for key creation, Booking_date and LFM_name, to child records.
parent		:=	fill_parent_num(seq_num_added=parent_num);
children	:=	fill_parent_num(seq_num_added<>parent_num);

with_sequence_num	tFillFields(children	L,	parent	R)	:=	TRANSFORM
	SELF.booking_date		:=	R.booking_date;
  SELF.lfm_name				:=	R.lfm_name;
	SELF								:=	L;
END;

j_FillChild	:= JOIN(children, parent,
									left.parent_num = right.parent_num,
									tFillFields(LEFT,RIGHT),left outer);
									
	EXPORT raw_out := sort(parent+j_FillChild,seq_num_added) :INDEPENDENT;

END;