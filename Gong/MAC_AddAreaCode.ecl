import risk_indicators;

export MAC_AddAreaCode(infile, phonefield, zipfield, flagfield, flagval, outfile) := macro

h7 := infile(length(trim(phonefield)) = 7 and (integer)phonefield > 0);
hskip := infile(~(length(trim(phonefield)) = 7 and (integer)phonefield > 0));

/////////////////////////////////////////////////////////////////////////////////////

//Create a npa/nxx/zip table using Full/Current Gong

/////////////////////////////////////////////////////////////////////////////////////

currGong := Gong.File_GongBase(phoneno[1..6] != '' and z5 <> '');

slim_Gong := record
string3 npa;
string3 nxx;
string5 zip;
end;

slim_Gong slimRec(currGong L) := transform
self.npa := L.phoneno[1..3];
self.nxx := L.phoneno[4..6];
self.zip := L.z5;

end;

p_Gong := project(currGong,slimrec(left));
dd_Gong := sort(dedup(p_Gong,npa,nxx,zip,all),npa,nxx,zip);

/////////////////////////////////////////////////////////////////////////////////////

//Validate Gong npa/nxx using Telcordia TPM (As an extra precaution)

/////////////////////////////////////////////////////////////////////////////////////

tpm := sort(dedup(risk_indicators.File_Telcordia_tpm,npa,nxx,all),npa,nxx); 

dd_Gong valNPANxx(dd_Gong L, tpm R) := transform
self := L;
end;

validNPANXX := join(dd_gong, tpm, 
					left.npa = right.npa and
					left.nxx = right.nxx,
					valNPANXX(left,right),lookup) : persist('tpm_deduped');;
					
/////////////////////////////////////////////////////////////////////////////////////

// Fill in missing NPA's to input file

/////////////////////////////////////////////////////////////////////////////////////

typeof(infile) addnpa(h7 l, validNPANXX r) := transform
	self.phonefield := if(r.npa = '', l.phonefield, r.npa + trim(l.phonefield));
	self.flagfield := if(r.npa = '', l.flagfield, trim(l.flagfield) + flagval);
	self := l;
end;

outfile := join(h7, validNPANXX, left.phonefield[1..3] = right.nxx and left.zipfield = right.zip,
			addnpa(left, right), left outer, lookup)
		   + hskip;

endmacro;