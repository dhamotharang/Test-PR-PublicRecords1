EXPORT boolean isChanged(string filename, string srcesp, string destesp) := function
	src := sort(thorbackup.GetFilePartInfo(filename,srcesp),partnumber);
	dest := sort(thorbackup.GetFilePartInfo(filename,destesp),partnumber);
	
	getdiffs := record
		string srcnum;
		string srcmod;
		string destnum;
		string destmod;
	end;
	
	getdiffs GetChanges(src l, dest r) := transform
		self.srcnum := l.partnumber;
		self.srcmod := l.modified;
		self.destnum := r.partnumber;
		self.destmod := r.modified;
	end;
	
	ismodified := join(src, dest,
											left.partnumber = right.partnumber and
											left.modified = right.modified,
											getchanges(left,right),
											full only
											);
	return if (count(ismodified) > 0, true, false);
	
end;