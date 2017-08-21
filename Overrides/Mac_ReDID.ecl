/*2015-10-10T00:50:22Z (Ananth Vankatachalam)

*/


import Doxie,_Control,did_add;
EXPORT Mac_ReDID(inds,didfield,retval) := macro
	
	
	
	#uniquename(ridkey)
	%ridkey% := Doxie.Key_Did_Rid2;

	#uniquename(getmatchingdids)
	typeof(inds) %getmatchingdids%(inds l, %ridkey% r) := transform
		self.newdid := r.did;
		self.ischanged := if (l.olddid <> r.did, true, false);
		self := l;
	end;
	
  #uniquename(newoverridedids)
	%newoverridedids% := join(inds, %ridkey%,
														left.olddid = right.rid,
														%getmatchingdids%(left,right),
														left outer);
	
	#uniquename(project_to_original)
	typeof(inds) %project_to_original%(%newoverridedids% l) := transform
		self.didfield := if (l.newdid <> 0,(typeof(l.didfield))l.newdid,(typeof(l.didfield))l.olddid);
		self := l;
	end;

	// get only those that changed
	#uniquename(tooriginal)
	%tooriginal% := project(%newoverridedids%(ischanged),%project_to_original%(left));
	
	retval := %tooriginal%(newdid <> 0); // filter out records with newdid = 0 (dids that are not in header anymore)
											
	
endmacro;