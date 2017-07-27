//this module standardizes TITLEs and seperates Executives from non-Executive positions.
import iesp;
export smart_paw(dataset(iesp.peopleatwork.t_PeopleAtWorkRecord) inPAW) := module
  allPawRec := record
	   inPaw;
		 boolean isExecutive
  end;
	allPawRec fillTitle(inPaw l, smartrollup.file_executive_titles r) := transform
	  self.title := if (trim(r.display_title) <>'',r.display_title, l.title);
		self.isExecutive := r.isExecutive;
		self := l;
	end;
	shared allPaw := join(inPAW, smartrollup.file_executive_titles, trim(stringlib.stringToUppercase(left.title)) = right.stored_title, fillTitle(left,right), left outer);
  export paw_exec := project(allPaw(isExecutive=true),iesp.peopleatwork.t_PeopleAtWorkRecord);
	export paw_nonExec := project(allPaw(isExecutive=false),iesp.peopleatwork.t_PeopleAtWorkRecord);
end;