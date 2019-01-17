EXPORT utMAC_Patch_Id(infile,patch_Field,patchfile,left_field,right_field,outfile) := MACRO
	// If there is a new ID in the patchfile, replace the old ID.  Otherwise retain it.
	#UNIQUENAME(tra)
	TYPEOF(infile) %tra%(infile l, patchfile rec) := TRANSFORM
		SELF.patch_Field := IF(rec.right_field<>0,rec.right_field,l.patch_Field); 
		SELF := l;
	END;
	outfile := JOIN(infile,patchfile,LEFT.patch_Field=RIGHT.left_field,%tra%(LEFT,RIGHT),LEFT OUTER, SMART);
ENDMACRO;
