import Ingenix_natlprof,ut;

in_file 	:= ingenix_natlprof.BWR_Sanctions_Did_File;

file_sort := sort(in_file, did, filetyp, SANC_ID, -process_date, SANC_LNME,SANC_FNME,SANC_MID_I_NM, SANC_BUSNME, SANC_DOB, SANC_STREET, SANC_CITY,SANC_ZIP, SANC_STATE, 
									SANC_CNTRY, SANC_TIN, SANC_UPIN, SANC_PROVTYPE,SANC_SANCST, SANC_LICNBR, SANC_BRDTYPE, SANC_SRC_DESC, SANC_TYPE, SANC_REAS, 
									SANC_TERMS, SANC_COND, SANC_FINES, SANC_FAB,SANC_UNAMB_IND,-SANC_SANCDTE_form, -SANC_UPDTE_form,-SANC_REINDTE_form);

ingenix_natlprof.layout_sanctions_DID_RecID  rollupXform(ingenix_natlprof.layout_sanctions_DID_RecID l, ingenix_natlprof.layout_sanctions_DID_RecID r) := transform
		self.Process_date        := if(l.Process_date > r.Process_date, l.Process_date, r.Process_date);
		self.date_First_Seen     := if(l.date_First_Seen > r.date_First_Seen, r.date_First_Seen, l.date_First_Seen);
		self.date_Last_Seen      := if(l.date_Last_Seen  < r.date_Last_Seen,  r.date_Last_Seen,  l.date_Last_Seen);
		self.date_First_Reported := if(l.date_First_Reported > r.date_First_Reported, r.date_First_Reported, l.date_First_Reported);
		self.date_Last_Reported  := if(l.date_Last_Reported  < r.date_Last_Reported,  r.date_Last_Reported, l.date_Last_Reported);
    self.source_rec_id       := if(l.source_rec_id<>0, l.source_rec_id,r.source_rec_id);
		self := l;
end;

ds_file_rollup :=rollup(file_sort,rollupXform(LEFT,RIGHT),RECORD,
                        EXCEPT Process_date, date_First_Seen, date_Last_Seen,
															 date_First_Reported, date_Last_Reported,SANC_UNAMB_IND,source_rec_id);
                
//*** appending the source record ids for the newer records.                                                                                                                                                   
ut.MAC_Append_Rcid (ds_file_rollup,source_rec_id,out_file);

export update_BWR_Sanctions_Did_File := out_file;



