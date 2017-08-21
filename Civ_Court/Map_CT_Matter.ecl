Import Civ_Court, Civil_Court, ut;
#option('multiplePersistInstances',FALSE);

Matt_Act := Civ_Court.Map_CT_Joins;

Civil_Court.Layout_In_Matter tCTCiv(Matt_Act L) := Transform
Self.process_date			:= civil_court.Version_Development;
Self.vendor					:='04';
Self.state_origin				:='CT';
Self.source_file				:='CT-CIVIL-COURT';
Self.case_key					:='04'+ Trim(L.LocCode, Left, Right) +(String)L.CaseRefNum;
Self.court_code				:= L.LocCode;
Self.court						:= L.LocDesc;
Self.case_number				:= (String)L.CaseRefNum;
Self.case_type_code				:= Trim(L.CTMajorCd, Left, Right) + Trim(L.CTMinorCd, Left, Right);
Self.case_type					:= L.CTDesc;
Self.case_title	:= If(L.PlaintCapName <>'' and L.DefnCapName <>'', ut.CleanSpacesAndUpper(L.PlaintCapName) + ' ' +If(L.PlaintETAL<>'', Trim(L.PlaintETAL, Left, Right), '') + ' VS ' 
										 + Trim(L.DefnCapName, Left, right) + ' ' +If(L.DefnETAL<>'', Trim(L.DefnETAL, Left, Right), ''), '');
Self.case_cause_code			:= Trim(L.CTMajorCd, Left, Right) + Trim(L.CTMinorCd, Left, Right);
Self.case_cause		:=  Map(	L.CTMajorCd =  'A' => 'APPEALS FROM ADMINISTRATIVE BOARDS', 
													L.CTMajorCd =  'M' => 'MISCELLANEOUS', 
													L.CTMajorCd =  'P' => 'PROPERTY', 
													L.CTMajorCd =  'C' => 'CONTRACTS', 
													L.CTMajorCd =  'T' => 'TORTS (OTHER THAN VEHICULAR)', 
													L.CTMajorCd =  'E' => 'EMINENT DOMAIN', 
													L.CTMajorCd =  'F' => 'FAMILY RELATIONS', 
													L.CTMajorCd =  'V' => 'VEHICULAR TORTS', 
													L.CTMajorCd =  'W' => 'WILLS ESTATES AND TRUSTS', '');
Self.filing_date				:=  If ((Integer)L.DispositionDate <> 0 and L.FileDate <= Self.process_date, L.FileDate, '');
Self.manner_of_judgmt_code		:= L.ListTypeCode;
Self.manner_of_judgmt			:= L.ListTypeDesc;
Self.disposition_code			:= L.DispositionDockLegCode;
Self.disposition_description	:= ut.CleanSpacesAndUpper(L.DocName);
Self.disposition_date			:= If ((integer) L.DispositionDate <> 0 and L.DispositionDate <= '20130307', L.DispositionDate, '');
Self.award_amount				:= '';
Self := L;
Self := [];
end;
CT_Matter := Project(Matt_Act, tCTCiv(Left));
ddCT_Matter 	:= dedup(sort(distribute(CT_Matter),
									record,local),
									record,local,left): PERSIST('~thor_200::in::civil_CT_matter');

Export Map_CT_Matter := ddCT_Matter;