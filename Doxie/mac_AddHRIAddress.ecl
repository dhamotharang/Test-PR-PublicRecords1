
export mac_AddHRIAddress(infile, outfile, inzip='zip',
							inprimname='prim_name',
							insuffix='suffix',inpredir='predir',
							inpostdir='postdir',inprimrange='prim_range',
							insecrange='sec_range', hri_field = 'HRI_Address') := macro

import Risk_Indicators, ut, codes, doxie;

#uniquename(maxHri)
%maxHri% := ut.min2(maxHriPer_value,ut.limits.HRI_MAX);

#uniquename(getAHRI)
Risk_Indicators.Layout_Desc %getAHRI%(Risk_Indicators.Key_HRI_Address_To_Sic le) :=
TRANSFORM
	SELF.hri := le.sic_code;
	SELF.desc := codes.VARIOUS_HRI_FILES.HRI_CODE(SELF.hri);
END;

#uniquename(addRisk)
infile %addRisk%(infile le,
								DATASET(recordof(risk_indicators.Key_HRI_Address_To_Sic)) ri) :=
TRANSFORM
	// per bug 127241, the following HRIs are considered derogatory.  These should only be applied if
	// the sec_ranges exactly match
	//
	//2225   Correctional Institution                                      
	//2260   General medical or surgical hospital                                 
	//2275   Skilled nursing care facility
	//2295   National security                                             
	//2315   Psychiatric hospital                                             
	//2384   Intermediate Care Facility         
	derogs := ['2225', '2260', '2275', '2295', '2315', '2384'];
	goodMatch := ri.sic_code not in derogs or le.insecrange = ri.sec_range;
	SELF.hri_field := PROJECT(choosen(dedup(ri(goodMatch), sic_code, all),%maxHri%), %getAHRI%(LEFT));
	SELF := le;
END;

#uniquename(dk)
%dk% := Doxie.Key_PullZip;

#uniquename(dksic)
%dksic% := '0911';

#uniquename(outfile1)
%outfile1% := DENORMALIZE(infile, risk_indicators.Key_HRI_Address_To_Sic,
														KEYED(LEFT.inzip=RIGHT.z5) AND
												    KEYED(LEFT.inprimname=RIGHT.prim_name) AND
												    KEYED(LEFT.insuffix=RIGHT.suffix) AND
												    KEYED(LEFT.inpredir=RIGHT.predir) AND
												    KEYED(LEFT.inpostdir=RIGHT.postdir) AND
												    KEYED(LEFT.inprimrange=RIGHT.prim_range) AND
												    KEYED(ut.NNEQ_SEC(LEFT.insecrange,RIGHT.sec_range)), //l <> '' and r='' or l=r;
												    GROUP,
												    %addRisk%(LEFT,rows(RIGHT)),
												    // actual number is ~30 (not considering sec. range)
												    LIMIT (10000));

#uniquename(addDisaster)
infile %addDisaster%(%outfile1% l, %dk% r) := transform
	SELF.hri_field := 
					choosen(if(r.zip <> '', dataset([{%dksic%,codes.VARIOUS_HRI_FILES.HRI_CODE(%dksic%)}],
									   risk_indicators.Layout_Desc)) & l.hri_field, %maxHri%);

	self := l;
end;

outfile := join(%outfile1%, %dk%, (integer)left.inzip > 1000 and keyed(left.inzip = right.zip),
			 %addDisaster%(left, right), keep(1), limit (0), left outer);

endmacro;