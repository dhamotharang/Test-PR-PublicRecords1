import InfoUSA;

file_in   := InfoUSA.Cleaned_IDEXEC_file;

file_sort := sort(file_in, record, except process_date);  

InfoUSA.Layout_Cleaned_IDEXEC_file  rollupXform(InfoUSA.Layout_Cleaned_IDEXEC_file l, InfoUSA.Layout_Cleaned_IDEXEC_file r) := transform
		
		self.Process_date    := if(l.Process_date > r.Process_date, l.Process_date, r.Process_date);
		self := l;
end;

export Update_IDEXEC := rollup(file_sort,rollupXform(LEFT,RIGHT),RECORD,
                                EXCEPT Process_date);





