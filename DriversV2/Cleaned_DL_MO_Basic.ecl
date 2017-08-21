import Drivers, Address, ut, lib_stringlib;

export Cleaned_DL_MO_Basic(string processDate, string fileDate) := function

	in_file := ascii(DriversV2.File_DL_MO_Basic_Update(fileDate));

	layout_out := drivers.Layout_MO_Bascdata_Raw;
	
	alpha := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ- ';
	
	layout_out mapClean(in_file l) := transform
		string73 tempName := stringlib.StringToUpperCase(if(trim(trim(l.Firstname,left,right) + ' ' +
														   trim(l.Lastname,left,right),left,right) <> '',
													 	   Address.CleanPersonFML73(trim(trim(l.Firstname,left,right) + ' ' +
																				         trim(l.Middlename,left,right) + ' ' +
																						 trim(l.Lastname,left,right),left,right)),
														   ''));

		self.title                 := tempName[1..5];
		self.fname                 := tempName[6..25];
		self.mname                 := tempName[26..45];
		self.lname                 := tempName[46..65];
		self.name_suffix	       := tempName[66..70];
		self.cleaning_score        := tempName[71..73];
		self.prim_range            := '';
		self.predir 	             := '';
		self.prim_name 	           := '';
		self.suffix                := '';
		self.postdir 	             := '';
		self.unit_desig 	         := '';
		self.sec_range 	           := '';
		self.p_city_name	         := '';
		self.v_city_name	         := '';
		self.st   	               := '';
		self.zip5		               := '';
		self.zip4 		             := '';
		self.cart 		             := '';
		self.cr_sort_sz 	         := '';
		self.lot 		               := '';
		self.lot_order 	           := '';
		self.dbpc 		             := '';
		self.chk_digit 	           := '';
		self.rec_type	             := '';
		self.ace_fips_st	         := '';
		self.county     	         := '';
		self.geo_lat 	             := '';
		self.geo_long 	           := '';
		self.msa 		               := '';
		self.geo_blk               := '';
		self.geo_match 	           := '';
		self.err_stat 	           := '';	
		self.process_date          := lib_stringlib.stringlib.stringfilter(processDate,'0123456789');
		self.Lastname              := stringlib.StringToUpperCase(trim(l.Lastname,left,right));
		self.Firstname             := stringlib.StringToUpperCase(trim(l.Firstname,left,right));
		self.Middlename            := stringlib.StringToUpperCase(trim(l.Middlename,left,right));
		self.STREET                := stringlib.StringToUpperCase(trim(l.STREET,left,right));
		self.CITY                  := stringlib.StringToUpperCase(trim(l.CITY,left,right));
		self.STATE                 := stringlib.StringToUpperCase(trim(l.STATE,left,right));
		self.ZIP                   := stringlib.StringToUpperCase(trim(l.ZIP,left,right));
		self.HEIGHT                := lib_stringlib.stringlib.stringfilter(l.HEIGHT,'0123456789');
		self.WEIGHT                := lib_stringlib.stringlib.stringfilter(l.WEIGHT,'0123456789');
		self.EYES                  := stringlib.StringToUpperCase(trim(l.EYES,left,right));
		self.SEX                   := stringlib.StringToUpperCase(trim(l.SEX,left,right));
		self.COUTY_MODL            := stringlib.StringToUpperCase(trim(l.COUTY_MODL,left,right));
		self.OPER_STATUS           := stringlib.StringToUpperCase(trim(l.OPER_STATUS,left,right));
		self.COMM_STATUS           := stringlib.StringToUpperCase(trim(l.COMM_STATUS,left,right));
		self.SCHL_BUS_STATUS       := stringlib.StringToUpperCase(trim(l.SCHL_BUS_STATUS,left,right));
		self.STOP_ACTIVITY         := stringlib.StringToUpperCase(trim(l.STOP_ACTIVITY,left,right));
		self.HOLD_ACTION           := stringlib.StringToUpperCase(trim(l.HOLD_ACTION,left,right));
		self.ID_CARD_IC            := stringlib.StringToUpperCase(trim(l.ID_CARD_IC,left,right));
		self.LIC_IC                := stringlib.StringToUpperCase(trim(l.LIC_IC,left,right));
		self.PERMIT_IND            := stringlib.StringToUpperCase(trim(l.PERMIT_IND,left,right));
		self.DONOR_IND             := stringlib.StringToUpperCase(trim(l.DONOR_IND,left,right));
		self.MULTI_IC              := stringlib.StringToUpperCase(trim(l.MULTI_IC,left,right));
		self.DECEASED_IND          := stringlib.StringToUpperCase(trim(l.DECEASED_IND,left,right));
		self.SPEC_HANDLG           := stringlib.StringToUpperCase(trim(l.SPEC_HANDLG,left,right));
		self.LIS_HIST              := stringlib.StringToUpperCase(trim(l.LIS_HIST,left,right));
		self.MICRO_FILM            := stringlib.StringToUpperCase(trim(l.MICRO_FILM,left,right));
		self.DOC_DATE              := lib_stringlib.stringlib.stringfilter(l.DOC_DATE,'0123456789');
		self.NA_USER_ID            := stringlib.StringToUpperCase(trim(l.NA_USER_ID,left,right));
		self.LUPT_DATE             := lib_stringlib.stringlib.stringfilter(l.LUPT_DATE,'0123456789');
		self.CLASS                 := stringlib.StringToUpperCase(trim(l.CLASS,left,right));
		self.LIC_EXP_DATE          := lib_stringlib.stringlib.stringfilter(l.LIC_EXP_DATE,'0123456789');
		self.ID_EXP_DATE           := lib_stringlib.stringlib.stringfilter(l.ID_EXP_DATE,'0123456789');
		self.RDP_TDP_CD            := stringlib.StringToUpperCase(trim(l.RDP_TDP_CD,left,right));
		self.PEND_ACTION           := stringlib.StringToUpperCase(trim(l.PEND_ACTION,left,right));
		self.MUST_TEST             := stringlib.StringToUpperCase(trim(l.MUST_TEST,left,right));
		self.RDPA_ELIG             := stringlib.StringToUpperCase(trim(l.RDPA_ELIG,left,right));
		self.LIC_ISS_CD            := stringlib.StringToUpperCase(trim(l.LIC_ISS_CD,left,right));
		self.ISS_DATE              := lib_stringlib.stringlib.stringfilter(l.ISS_DATE,'0123456789');
		self.PREV_CLASS            := stringlib.StringToUpperCase(trim(l.PREV_CLASS,left,right));
		self.OPEN_MI               := stringlib.StringToUpperCase(trim(l.OPEN_MI,left,right));
		self.PDPS_PTR              := stringlib.StringToUpperCase(trim(l.PDPS_PTR,left,right));
		self.LIS_PTR               := stringlib.StringToUpperCase(trim(l.LIS_PTR,left,right));
		self.WALKIN_DATE           := lib_stringlib.stringlib.stringfilter(l.WALKIN_DATE,'0123456789');
		self.DPPA_CODE             := stringlib.StringToUpperCase(trim(l.DPPA_CODE,left,right));
		self.FILLER_1              := stringlib.StringToUpperCase(trim(l.FILLER_1,left,right));			
		self.NAME                  := stringlib.StringToUpperCase(trim(l.NAME,left,right));
		self.CLN                   := stringlib.StringToUpperCase(trim(l.CLN,left,right));
		self.FILLER_2              := stringlib.StringToUpperCase(trim(l.FILLER_2,left,right));
		self.BIRTHDATE             := lib_stringlib.stringlib.stringfilter(l.BIRTHDATE,'0123456789');
		self.RECORD_TYPE           := stringlib.StringToUpperCase(trim(l.RECORD_TYPE,left,right));
		self.USER_ID_DRV           := stringlib.StringToUpperCase(trim(l.USER_ID_DRV,left,right));
		self.LUPDT_BD              := stringlib.StringToUpperCase(trim(l.LUPDT_BD,left,right));
		self.FILLER_3              := stringlib.StringToUpperCase(trim(l.FILLER_3,left,right));
		self                       := l;		
	end;

	Cleaned_MO_Basic_File := project(in_file, mapClean(left));
	
	return Cleaned_MO_Basic_File;
end;