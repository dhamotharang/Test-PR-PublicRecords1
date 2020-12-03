import std, ut;

	GetNameSources(dataset(Layouts.rEntity) src) := JOIN(DISTRIBUTE(src,Ent_id), 
								DISTRIBUTE(WorldCompliance.GetSanctions(src),Ent_id),
				LEFT.Ent_Id = RIGHT.Ent_Id,
			TRANSFORM(rComments,
				self.Ent_Id := LEFT.Ent_Id;
				self.sorter := 1;
				self.subcmts := '';
				self.cmts := 'Source: ' + TRIM(Right.Country) + ',' + TRIM(Right.SourceName);), INNER, LOCAL);
				


Layout_XG.rgeo xForm(Layouts.rEntity infile) := TRANSFORM, SKIP(infile.EntryType <> 'Country')
	self.id := infile.Ent_id;
	self.Country_Name := infile.name;
	self.Entity_Unique_id := 'WX'+IntFormat(infile.Ent_id,10,1);
	self.Reference_id := (string)infile.Ent_id;
	
	self.listed_date := ut.ConvertDate(infile.touchdate,'%Y-%m-%d', '%Y/%m/%d');
	self.reason_listed := infile.EntLevel+':'+infile.EntryCategory+':'+infile.EntrySubcategory;
	
	self.comments := TRIM(infile.Positions) + IF(infile.remarks='','',
											' || ' + CvtPilcrow(infile.remarks));
	self := [];

END;

EXPORT ProcessCountryFile(DATASET(Layouts.rEntity) infile) := FUNCTION

	basis := PROJECT(DISTRIBUTE(infile,Ent_id), xForm(LEFT));
	
	withsources := JOIN(basis, GetNameSources(infile), LEFT.id=RIGHT.ent_id,
									TRANSFORM(Layout_XG.rgeo,
										self.Comments := RIGHT.cmts + ' || ' + LEFT.Comments;
										self := LEFT;), LEFT OUTER, LOCAL);

	return SORT(withsources,Country_Name,Entity_Unique_id);
END;