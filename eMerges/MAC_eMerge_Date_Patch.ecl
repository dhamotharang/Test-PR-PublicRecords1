import ut;

export MAC_eMerge_Date_Patch(infile, regdate_field, lastdayvote_field, datelicense_field, ccwregdate_field, outfile) := macro

#uniquename(eMerge_dateFix)
typeof(infile) %eMerge_dateFix%(infile le) := transform

 #uniquename(v_regdate)
 #uniquename(v_lastdayvote)
 #uniquename(v_datelicense)
 #uniquename(v_ccwregdate)
 
 %v_regdate%     := le.regdate_field;
 %v_lastdayvote% := le.lastdayvote_field;
 %v_datelicense% := le.datelicense_field;
 %v_ccwregdate%  := le.ccwregdate_field;
 
 string8 v_regdate2     := if((%v_regdate%     between '19500101' and ut.GetDate) and length(trim(%v_regdate%))=8    ,%v_regdate%,'');
 string8 v_lastdayvote2 := if((%v_lastdayvote% between '19500101' and ut.GetDate) and length(trim(%v_lastdayvote%))=8,%v_lastdayvote%,'');
 string8 v_datelicense2 := if((%v_datelicense% between '19500101' and ut.GetDate) and length(trim(%v_datelicense%))=8,%v_datelicense%,'');
 string8 v_ccwregdate2  := if((%v_ccwregdate%  between '19500101' and ut.GetDate) and length(trim(%v_ccwregdate%))=8 ,%v_ccwregdate%,'');
 
 string8 v_date_first_seen := if(trim(le.file_id)='VOTE',v_lastdayvote2,
                              if(trim(le.file_id)='HUNT',v_lastdayvote2,
					          if(trim(le.file_id)='FISH',v_lastdayvote2,
					          if(trim(le.file_id)='CENS',v_lastdayvote2,
					          if(trim(le.file_id)='CCW', v_lastdayvote2,
					          '')))));

 string8 v_date_last_seen :=  if(trim(le.file_id)='VOTE',v_lastdayvote2,
                              if(trim(le.file_id)='HUNT',v_lastdayvote2,
					          if(trim(le.file_id)='FISH',v_lastdayvote2,
					          if(trim(le.file_id)='CENS',v_lastdayvote2,
					          if(trim(le.file_id)='CCW', v_lastdayvote2,
					          '')))));

 self.date_first_seen := if(le.date_first_seen!=le.file_acquired_date,
                          if((integer)v_date_first_seen=0,'',v_date_first_seen),
						 le.date_first_seen);
 self.date_last_seen  := if(le.date_first_seen!=le.file_acquired_date,
                          if((integer)v_date_last_seen=0, '',v_date_last_seen),
						 le.date_last_seen);
 self                 := le;

end;

outfile := project(infile, %eMerge_dateFix%(left));

endmacro;