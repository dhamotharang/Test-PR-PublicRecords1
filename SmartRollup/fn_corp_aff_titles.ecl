import iesp;
export fn_corp_aff_titles(dataset(iesp.bpsreport.t_BpsCorpAffiliation) inCorpAff) := function
  inCorpAff fillTitle(inCorpAff l, smartrollup.file_executive_titles r) := transform
	  self.title := if (trim(r.display_title) <>'',r.display_title, l.title);
		self := l;
	end;
  outrecs := join(inCorpAff, smartrollup.file_executive_titles, trim(stringlib.stringToUppercase(left.title)) = right.stored_title, fillTitle(left,right));
	return outrecs;
end;