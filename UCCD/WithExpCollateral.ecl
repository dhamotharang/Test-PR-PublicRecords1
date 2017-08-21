import ucc,codes,ut;
outrec := uccd.Layout_WithExpCollateral;

//****** EXPERIAN ******
df := ucc.File_UCC_Filing_Events(file_state not in uccd.set_DirectStates or file_state in uccd.set_UseExpCollateralStates);
/* the second set should be removed to force investigation of the direct source data, rvh */

df_filtered := df(collateral_code<>'');

rec := record
	unsigned4	seq;
	outrec;
end;

rec into_withExp(df_filtered L, integer C) := transform	
	self.record_type := 'C';
	self.isDirect := false;
	self.collateral_type_cd := stringlib.stringfilterout(L.collateral_code,',');
	self.collateral_type_desc := '';
	self.seq := C;
	self.ucc_vendor := ut.st2FipsCode(l.file_state);
	self.ucc_key := uccd.constructUCCkey(l.file_state, l.orig_filing_num);
//	self.event_key 	:= if (l.filing_type='0801', uccd.constructUCCkey(l.file_state, l.orig_filing_num),l.filing_type+'-'+l.filing_date);
	self.event_key 	:= if (l.filing_type='0801', uccd.constructUCCkey(l.file_state, l.orig_filing_num),l.filing_type+trim(l.document_num,left,right)+l.filing_date);
	self.ucc_process_date := '';
	self.collateral_status_cd := '';
	self.collateral_status_desc := '';
	self.collateral_eff_date := '';
	self.collateral_exp_date := '';
	self.collateral_value_assessed_amt := '';
	self.collateral_qty := '';
	self.collateral_units_cd := '';
	self.collateral_units_desc :='';
	self.collateral_place_cd := '';
	self.collateral_place_desc := '';
	self.collateral_desc  := '';
	self := L;
end;

o1 := project(df_filtered,into_withExp(LEFT,COUNTER));

collat_rec := record
	string512	temp_desc := '';
	o1;
end;

collat_rec norm_collat(o1 L, integer C) := transform
	self.temp_desc := if (L.collateral_type_cd[C] = '', skip, codes.UCC_FILING.COL_CODE(L.collateral_type_cd[C]));
	self := L;
end;

o2 := normalize(o1(length(trim(collateral_type_cd)) > 0),25,norm_collat(LEFT,COUNTER));

o2 roll_collat(o2 L, o2 R) := transform
	self.temp_desc := trim(L.temp_desc) + ', ' + trim(R.temp_desc);
	self := L;
end;

o3 := rollup(sort(distribute(o2,hash(seq)),seq,local),left.seq = right.seq,roll_collat(LEFT,RIGHT),local);

outrec into_final(o3 L) := transform
	self.collateral_type_desc := if (length(trim(L.temp_desc)) <= 60, L.temp_desc, uccd.string_SeeCollateralDescription);
	self.collateral_desc := if (length(trim(L.temp_desc)) > 60, L.temp_desc,'');
	self := L;
end;

fromexp := project(o3 + table(o1(Length(trim(collateral_type_cd)) = 0),collat_rec),into_final(LEFT));
//output(fromexp);

//****** DIRECT ******
dirin := uccd.Updated_Collateral;

outrec formatdir(dirin l) := transform
	self.isDirect := true;
	self.file_state := l.ucc_state_origin;
	self.orig_filing_num := l.ucc_key[4..50];
	self := l;
end;


fromdir := project(dirin, formatdir(left));
//output(fromdir);

export WithExpCollateral := fromexp + fromdir;
