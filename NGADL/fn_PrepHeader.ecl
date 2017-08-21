import header,ut,mdr;

export fn_PrepHeader(
	dataset(header.Layout_Header) h
	) := 
FUNCTION

ngadl.layout_header tr(h le) := transform
	genraw := ut.GenderTools.gender(le.fname, le.mname);
	self.gender := if(genraw in ut.GenderTools.set_gender_unks, '', genraw);
  self := le;
  end;

p := project(h(~MDR.flagTools.jflag2.isAmbiguous(jflag2)),tr(left));

sb := NGADL.mod_StandardizeBoxes(p).records;

//hopefully we can remove this part when ADL2 is ready to handle sec_range
dv := ngadl.fn_deValueOverusedApt(sb);

return dv;

END;