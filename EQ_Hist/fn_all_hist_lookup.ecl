import header;

EXPORT fn_all_hist_lookup := function

r:=record
	string18 cid;
	string75 fn { virtual(logicalfilename)};
	EQ_Hist.Layout.current_raw;
end;

EqFiles0
	:=
	  DATASET('~thor_data400::in::quickhdr_raw',             {string75 fn { virtual(logicalfilename)},EQ_Hist.Layout.current_raw}, THOR)
	+ DATASET('~thor_data400::in::quickhdr_raw_father',      {string75 fn { virtual(logicalfilename)},EQ_Hist.Layout.current_raw}, THOR)
	+ DATASET('~thor_data400::in::quickhdr_raw_history',     {string75 fn { virtual(logicalfilename)},EQ_Hist.Layout.current_raw}, THOR)
	;
EqFiles1
	:=
	DATASET('~thor_data400::in::quickhdr_raw_history_608', {string75 fn { virtual(logicalfilename)},EQ_Hist.Layout.old_raw},     THOR)
	;

EqFiles:=project(EqFiles0
								,transform(r
		,self.cid:= header.Cid_Converter(left.cid[1])
							+ header.Cid_Converter(left.cid[2])
							+ header.Cid_Converter(left.cid[3])
							+ header.Cid_Converter(left.cid[4])
							+ header.Cid_Converter(left.cid[5])
							+ header.Cid_Converter(left.cid[6])
							+ header.Cid_Converter(left.cid[7])
							+ header.Cid_Converter(left.cid[8])
							+ header.Cid_Converter(left.cid[9])
		,self:=left
		))
		+
		project(EqFiles1
								,transform(r
		,self.cid:= header.Cid_Converter(left.cid[1])
							+ header.Cid_Converter(left.cid[2])
							+ header.Cid_Converter(left.cid[3])
							+ header.Cid_Converter(left.cid[4])
							+ header.Cid_Converter(left.cid[5])
							+ header.Cid_Converter(left.cid[6])
							+ header.Cid_Converter(left.cid[7])
							+ header.Cid_Converter(left.cid[8])
							+ header.Cid_Converter(left.cid[9])
		,self:=left
		,self:=[];
		));

return EqFiles;

end;