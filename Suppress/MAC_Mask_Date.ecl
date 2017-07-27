
export MAC_Mask_Date(
	inf, outf, date_field, dateto_mask,
	edobmask
) := MACRO

// assumes date_field is an unsigned4 YYYYMMDD  
// Year is always provided if month or day is provided
// month is always provided if day is provided



#uniquename(out_noKey)
#uniquename(ezMasker)
typeof(inf) %ezMasker%(inf L) := transform
	self.dateto_mask := suppress.date_mask(L.date_field,edobmask); 
	self.date_field := if(edobmask > suppress.constants.dateMask.none,0,L.date_field);
	self := L;
end;
%out_noKey% := project(inf, %ezMasker%(left));


outf :=  %out_noKey%;


ENDMACRO;