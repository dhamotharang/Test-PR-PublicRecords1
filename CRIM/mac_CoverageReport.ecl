
export mac_CoverageReport(infile,pdate,outfile) := macro

///////////////////////////////////////////////////////////////////////////////////////////////
#uniquename(new_layout)
#uniquename(t_recs)
#uniquename(new_infile)

%new_layout% := record
infile;
string6 cvg_dt;
end;

%new_layout% %t_recs%(infile L ) := transform
self.cvg_dt := if(trim(l.pdate,all)[1..2]>='19' and trim(l.pdate,all)<>'',l.pdate,'99999999');
self := L; 
end;						

%new_infile% := project(infile,%t_recs%(left));
///////////////////////////////////////////////////////////////////////////////////////////////
#uniquename(layout_counts)
#uniquename(counts)

%layout_counts% := record
%new_infile%.source_file;
PROCdate := MAX(group,if(%new_infile%.process_date<>'',%new_infile%.process_date,'99999999'));
MINdate  := MIN(group,if(%new_infile%.cvg_dt<>'' and %new_infile%.cvg_dt<>'99999999',%new_infile%.cvg_dt,'99999999'));
MAXdate  := MAX(group,map(%new_infile%.cvg_dt<>''and %new_infile%.cvg_dt< %new_infile%.process_date and %new_infile%.cvg_dt<>'99999999'=> %new_infile%.cvg_dt,'00000000'));
//has_did  := AVE(group,IF(%new_infile%.did != '',100,0));
end;

%counts%   := sort(table(%new_infile%,%layout_counts%,source_file,few),source_file);
///////////////////////////////////////////////////////////////////////////////////////////////
#uniquename(layout_slim)
#uniquename(slim_recs)
#uniquename(slim_infile)

%layout_slim% := record
string8 process_date;
string100 source_file;
string6 cvg_dt;
end;

%layout_slim% %slim_recs%(%new_infile% input) := Transform
self.source_file  := input.source_file;
self.cvg_dt       := input.cvg_dt;

self              := input;
end;

%slim_infile%     := project(%new_infile%,%slim_recs%(left));

///////////////////////////////////////////////////////////////////////////////////////////////
#uniquename(layout_stat)
#uniquename(stat)

%layout_stat% :=  record
%slim_infile%.source_file;
%slim_infile%.cvg_dt;

ctDate      := count(group);
end;

%stat%      := sort(table(%slim_infile%,%layout_stat%,source_file,cvg_dt,few),source_file,cvg_dt)(cvg_dt!='');

///////////////////////////////////////////////////////////////////////////////////////////////
#uniquename(layout_stdev)
#uniquename(p_stat)

%layout_stdev% := record
%stat%.source_file;
aveCt          := ave(group,%stat%.ctDate);

end;

%p_stat%       := sort(table(%stat%,%layout_stdev%,source_file,few),source_file);


///////////////////////////////////////////////////////////////////////////////////////////////
#uniquename(layout_ctRec)
#uniquename(ctRecstat)
#uniquename(temp_layout)
#uniquename(t_recs2)
#uniquename(statOut)
#uniquename(t_recs3)
#uniquename(statOut2)
#uniquename(sumSquaredf)
#uniquename(statOut3)
#uniquename(t_recs4)
#uniquename(layout_sumSquared)
#uniquename(f_statOut3)
#uniquename(layout_startDate)
#uniquename(stdev)

%layout_ctRec%  :=  record
%stat%.source_file;
ctRec           := count(group);
end;

%ctRecstat%     := sort(table(%stat%,%layout_ctRec%,source_file,few),source_file);


%temp_layout%   := record
%stat%.source_file;
%stat%.cvg_dt;
integer ctDate;
integer aveCt;
integer ctRec   :=0;
integer squared :=0;
integer stdev   :=0;
end;

%temp_layout% %t_recs2%(%stat% L, %p_stat% R) := transform
self.avect      := R.avect;
self            := L;
self            := R;
end;

%statOut%	    := join(%stat%,%p_stat%,
					left.source_file = right.source_file,
					%t_recs2%(left,right),lookup);
					
%temp_layout% %t_recs3%(%statout% L ,%ctRecstat% R) := transform
self.ctRec  := R.ctrec;
self.squared:= power(L.ctDate - L.aveCt,2);
self        := L;
self        := R;
end;

%statOut2%	:= join(%statout%,%ctRecstat%,
					left.source_file = right.source_file,
					%t_recs3%(left,right),lookup);
					


%layout_sumSquared% :=  record
%statOut2%.source_file;
sumSquared          := sum(group,%statout2%.squared);


end;

%sumSquaredf%        := sort(table(%statOut2%,%layout_sumSquared%,source_file,few),source_file);


%temp_layout% %t_recs4%(%statout2% L, %sumSquaredf% R) := transform
self.stdev  := sqrt(R.sumSquared/L.ctRec-1);
self        := L;
self        := R;
end;

%statOut3%	:= join(%statout2%,%sumSquaredf%,
					left.source_file = right.source_file,
					%t_recs4%(left,right),lookup);
					

%f_statOut3%       := %statout3%(%statOut3%.ctDate > %statOut3%.stdev);

%layout_startDate% :=  record
%f_statOut3%.source_file;
startDate          := MIN(group,%f_statOut3%.cvg_dt);


end;

%stdev%            := sort(table(%f_statOut3%,%layout_startDate%,source_file,few),source_file);


outfile:= 
sequential(
			output(%counts%,named('ProcMinMaxdtDIDcounts'),all),
			output(%stat%,named('Daterangepersource'),all),
			//output(%p_stat%,all),
			//output(%ctRecstat%,all),
			//output(%statOut2%,all),
			//output(%sumSquared%,all),
			//output(%statout3%,all),
			output(%stdev%,named('CoverageStartDatesPerSource'),all)
			);

endmacro;

				