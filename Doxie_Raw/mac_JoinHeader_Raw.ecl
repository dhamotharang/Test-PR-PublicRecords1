export mac_JoinHeader_Raw(
		infile, outfile, did_field = 'did', outerjoin = false,
    /*unsigned3*/ dateVal = 0,
    /*unsigned1*/ dppa_purpose = 0,
    /*unsigned1*/ glb_purpose = 0,
	/*string6*/ ssn_mask_value = 'NONE',
	/*boolean*/ ln_branded_value = false,
	/*boolean*/ probation_override_value = false
) := MACRO

//*** prep for the raw call
#uniquename(makeDIDs)
Doxie.layout_references %makeDIDs%(infile l) := transform
	self.did := l.did_field;
end;

#uniquename(myDIDs)
%myDIDs% := project(infile, %makeDIDs%(left));

//*** call raw
#uniquename(raw)
%raw% := doxie_raw.Header_Raw(%myDIDs%,dateVal,dppa_purpose,glb_purpose,ssn_mask_value,ln_branded_value,probation_override_value);

//*** join the infile back to the raw
#uniquename(outrec)
%outrec% := record
	infile;
	%raw%;
end;

#uniquename(reAppend)
%outrec% %reAppend%(infile l, %raw% r) := transform
	self := l;
	self := r;
end;

outfile := join(infile, %raw%, left.did_field = right.did, %reAppend%(left, right)
	#if(outerjoin)
		, left outer
	#end
	);

ENDMACRO;