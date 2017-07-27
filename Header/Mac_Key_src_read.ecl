export Mac_key_src_read(indxName, srcLayout, cdName, sffx, SF, srcOut) := macro

#uniquename(src_rec)
%src_rec% := record
	header.Layout_Source_ID;
	srcLayout;
end;

#uniquename(KeyLayout)
%KeyLayout%:=RECORD
	unsigned6 uid;
	string2 src;
	DATASET(srcLayout) cdName;
END;

#uniquename(srcFile)
%srcFile% := project(index(indxName,SF),%KeyLayout%);

#uniquename(get)
%src_rec% %get%(%srcFile% L) := transform
	self := l;
	self := l.cdName[1];
end;

srcOut  := project(%srcFile%, %get%(left)):persist('~thor_data400::temp::'+sffx);

endmacro;