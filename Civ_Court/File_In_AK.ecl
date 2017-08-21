import Civ_Court, ut;

export File_In_AK := module

export Input := dataset('~thor_data400::in::civil::ak_civil', civ_court.Layout_In_AK.Layout_AK, flat);
export AttorneyCodesLkp := dataset('~thor_data400::in::civil_ak_attorney_codes_lkp', civ_court.Layout_In_AK.Attorney_Codes, flat);
export CaseDispositionCodesLkp := dataset('~thor_data400::in::civil_ak_case_disp_codes_lkp', civ_court.Layout_In_AK.CaseDispositionCodes, flat);
export PersonTypeCodesLkp := dataset('~thor_data400::in::civil_ak_person_type_codes_lkp', civ_court.Layout_In_AK.PersonTypeCodes, flat);

end;