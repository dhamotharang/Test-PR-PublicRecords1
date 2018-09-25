// Module contains support functions. They help to add or remove candidates from the attribute file containting underlink clusters.
export ManualUnderLinks := module

	export recLayout := record
		unsigned6 lgid3;
		integer   underLinkId;
	end;

	export file_prefix := '~thor_data400::bip::lgid3::underlink::';

	shared superfile 						:= file_prefix + 'qa';
	shared superfile_father 			:= file_prefix + 'father';
	shared superfile_grandfather 	:= file_prefix + 'grandfather';

	shared wuid            := thorlib.wuid();
	export logicalFilename := file_prefix + wuid;

	/* -- File contains ManualOverLink records -- */
	export dataIn_file := dataset(superfile, recLayout, flat, opt);

	/* -- UpdateUnderLinkSuperFile -- */
	export updateUnderLinkSuperFile(string inFile) := function
		action := Sequential(
								nothor(FileServices.PromoteSuperFileList([superfile, 
																								  superfile_father,
																								  superfile_grandfather], inFile, true))
							);
		return action;
	end;

	/* -- CreateLogicalFile -- */
	export createLogicalFile(dataset(recLayout) newData) := function	
		oldData := IF(NOTHOR(FileServices.FileExists(superfile)),  dataset(superfile, recLayout, thor),  dataset([], recLayout));
		
		maxId := IF(NOTHOR(FileServices.FileExists(superfile)), max(oldData, UnderLinkId), 0);
		
		linksLgid3s := dedup(sort(newData, underLinkId), underLinkId);
		
		rec := record
			newData;
			integer new_underLinkId;
		end;
		// increment ids by did only.
		rec addId(linksLgid3s L, integer cnt) := transform
			self.new_underLinkId := maxId + cnt;
			self 							:= L;
		end;
		linksWithIds := project(linksLgid3s, AddId(left, counter));
		
		newlinks := join(newData, linksWithIds, 
													left.underLinkId = right.underLinkId,
													transform(recLayout, self.underLinkId := right.new_underLinkId, self:= left));

		AllData := oldData + newlinks;
						
		a := output(allData, ,logicalFilename, overwrite);
		return a;
	end;
		
	/* -- It adds candidates to the ManualLink file -- */
	export addCandidates(dataset(recLayout) newData) := function
	
		a := createLogicalFile(newData);

		b := updateUnderLinkSuperFile(logicalFilename);

		c := sequential(a,b);
		
		return c;
	end;

	/* -- It removes candidates from the ManualLink file -- */
	export removeCandidates(integer gid) := function
	
		ds := dataIn_file(underLinkId != gid);
		
		a := output(ds, ,logicalFilename, overwrite);
		
		b := updateUnderLinkSuperFile(logicalFilename);
		
		c := sequential(a, b);

		return c;
	end;

end;