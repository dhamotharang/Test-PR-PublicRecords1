IMPORT  address, ut, header_slimsort, did_add, didville,watchdog;
Transunion_PTrak.Layout_Transunion_Out.LayoutTransunionBaseOut t_dates_fix (Transunion_PTrak.File_Transunion_DID_Out L) := TRANSFORM
	SELF.dt_first_seen := IF((L.FileType = 'U' AND L.CitedID <> '') OR
						     (L.FileType = 'F' AND L.COMPILATIONDATE <> ''), 20080601, (INTEGER) (L.FileDate + '01'));
	SELF.dt_last_seen := IF((L.FileType = 'U' AND L.CitedID <> '') OR
						     (L.FileType = 'F' AND L.COMPILATIONDATE <> ''), 20080701, (INTEGER) (L.FileDate + '01'));
	SELF := L;
END;

date_fix := PROJECT(Transunion_PTrak.File_Transunion_DID_Out, t_dates_fix(LEFT));

//-----------------------------------------------------------------
//BUILD
//-----------------------------------------------------------------
ut.mac_sf_buildprocess(date_fix, '~thor400::base::transunion_PTrak', build_transunionPTrak, 2,,TRUE);

EXPORT date_fix := build_transunionPTrak;