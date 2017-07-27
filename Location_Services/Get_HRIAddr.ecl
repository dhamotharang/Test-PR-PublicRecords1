export Get_HRIAddr(infile, outfile) := macro

import doxie, Risk_Indicators, ut, codes;

#uniquename(layout_AHRI)
%layout_AHRI% := record
	infile.prim_Range;
	infile.prim_name;
	infile.sec_range;
	infile.suffix;
	infile.predir;
	infile.postdir;
	infile.zip;
	string4	hri;
	string100	desc;
end;

#uniquename(getAHRI)
%layout_AHRI% %getAHRI%(infile Le, Risk_Indicators.Key_HRI_Address_To_Sic Ri) :=
TRANSFORM
	SELF.hri := Ri.sic_code; 
	self.desc := codes.VARIOUS_HRI_FILES.HRI_CODE(Ri.sic_Code);
	self := Le;
END;

#uniquename(AHRI)
%AHRI% := join(infile, risk_indicators.Key_HRI_Address_To_Sic,
				KEYED(left.zip=right.z5) and
				KEYED(left.prim_name=right.prim_name) and
				KEYED(left.suffix=right.suffix) and
				KEYED(left.predir=right.predir) and
				KEYED(left.postdir=right.postdir) and
				KEYED(left.prim_range=right.prim_range) and
				ut.NNEQ(left.sec_range,right.sec_range),
				%getAHRI%(LEFT,RIGHT),
				LIMIT (10000));
				

#uniquename(AddRisk)
infile %addRisk%(infile le, %AHRI% Ri) :=
TRANSFORM
	SELF.hri_address := Le.hri_address + dataset([{Ri.hri, Ri.desc}], risk_indicators.layout_desc);
	self := Le;
END;

#uniquename(dk)
%dk% := Doxie.Key_PullZip;

#uniquename(dksic)
%dksic% := '0911';

#uniquename(outfile1)
%outfile1% := denormalize(infile, %AHRI%,
					left.prim_Range = right.prim_range and
					left.prim_name = right.prim_name and
					left.zip = right.zip and
					left.sec_range =right.sec_range and
					left.suffix = right.suffix and
					left.predir = right.predir and
					left.postdir = right.postdir,
				%addRisk%(LEFT, RIGHT));


#uniquename(addDisaster)
infile %addDisaster%(%outfile1% l, %dk% r) := transform
	SELF.hri_address := choosen(if(r.zip <> '', dataset([{%dksic%,codes.VARIOUS_HRI_FILES.HRI_CODE(%dksic%)}],
									   risk_indicators.Layout_Desc)) & l.hri_address, ut.min2(maxHriPer_value,50));

	self := l;
end;

outfile := join(%outfile1%, %dk%,
				(integer)left.zip > 1000 and keyed(left.zip = right.zip),
			%addDisaster%(LEFT, RIGHT), left outer, keep(1), limit (0));

endmacro;