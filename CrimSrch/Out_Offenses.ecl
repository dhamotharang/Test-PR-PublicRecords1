import Crim_Common, Corrections,codes;

fcra_v1 := Offenses_Joined(offender_key[1..4] not in CrimSrch.Sex_Offenders_Not_Updating
           and vendor != '99' 
					 and source_file != 'AR-DOC              '
					 and source_file != 'NJ-DOC-INMATE-OBCIS ' 
					 and source_file != 'PA STATEWIDE CRIM CT'
					 and source_file != 'PA_STATEWIDE_HIS(CV)'
					 and source_file != 'FL-DOC              '
					 and source_file != 'TX-DOC-Inmate-HIST  '
					 and source_file != 'NM-BernalilloCtyArr '
					 and source_file != 'AZ-MaricopaArrest   ');
					 //and source_file != 'FL-ALACHUA-CNTY-CRIM')
					 
					 
					 
/////////////////////////////////////////////////////////////////////////////////////////
//Mapping temp layout back to original fcra layout, so that existing keys are not changed
/////////////////////////////////////////////////////////////////////////////////////////
Crimsrch.Layout_Moxie_Offenses trecs(fcra_v1 L) := transform

self := L;
end;

fcra_v1_as_v1 := project(fcra_v1, trecs(left));

/////////////////////////////////////////////////////////////////////////////////////////
//Mapping temp layout to nonfra layout to faciliate new key request regarding the Life EIR project
/////////////////////////////////////////////////////////////////////////////////////////
corrections.layout_CourtOffenses trecs2(fcra_v1 L) := transform

self := L;
end;

df := project(fcra_v1, trecs2(left));

corrections.layout_CourtOffenses into_cof(df L, codes.File_Codes_V3_In R) := transform
	self.court_off_lev_mapped := R.long_desc;
	self.arr_off_lev_mapped := '';
	self := L;
end;

df2 := join(df,codes.File_Codes_V3_In,right.file_name='COURT_OFFENSES' and 
			right.field_name = 'COURT_OFF_LEV' and 
			right.field_name2 = left.vendor and 
			right.code = left.court_off_lev,
			into_cof(LEFT,RIGHT),lookup,left outer);
			
corrections.layout_CourtOffenses into_aof(df2 L, codes.File_Codes_V3_In R) := transform
	self.arr_off_lev_mapped := R.long_desc;
	self := L;
end;

fcra_v1_as_v2
    := join(df2,codes.File_Codes_V3_In,right.file_name='COURT_OFFENSES' and 
			right.field_name = 'ARR_OFF_LEV' and 
			right.field_name2 = left.vendor and 
			right.code = left.arr_off_lev,
			into_aof(LEFT,RIGHT),lookup,left outer);
			



					 
					 
export Out_Offenses := sequential(
																	output(fcra_v1_as_v1,,CrimSrch.Name_Moxie_Offenses_Dev,overwrite, __compressed__),
																	output(fcra_v1_as_v2,,'~thor_Data400::base::fcra::life_eir::court_offenses_' + CrimSrch.Version.Development,overwrite, __compressed__)
																	);