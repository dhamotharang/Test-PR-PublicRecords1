import	ut,Header;

export fn_remove_neq_sffx	(
							dataset(recordof(Header.Layout_PairMatch)) inFile
							)
							:= function

// 1.append the suffix for each of the did pairs
// 2.remove did pairs where any of the did's have more than one distinct name_suffix
// 3.remove pairs with different name_suffix
	suffixValues:=	[
					'SR'
					,'JR'
					,'I'
					,'II'
					,'III'
					,'IV'
					,'V'
					,'VI'
					,'VII'
					,'VIII'
					,'IX'
					,'X'
					,'1'
					,'2'
					,'3'
					,'4'
					,'5'
					,'6'
					];

	h:=header.file_headers(name_suffix in suffixValues);

	rsffx := record
		header.layout_pairmatch
		,qstring5	suffix1:=''
		,qstring5	suffix2:=''
	end;

	// append the suffix for new_rid
	ds1:=distribute(inFile,hash(new_rid));
	ds2 := join(ds1, h
					,left.new_rid=right.did
					,transform(rsffx,self.suffix1:=right.name_suffix,self:=left)
					,left outer
					,local);
	ds3:=dedup(sort(ds2,new_rid,suffix1,local),new_rid,suffix1,local);
	// keep did pairs where new_rid has only one distinct name_suffix
	ds4:=table(ds3,{ds3,cnt:=count(group)},new_rid,local)(cnt=1);

	// append the suffix for old_rid
	ds5:=distribute(ds4,hash(old_rid));
	ds6 := join(ds5, h
					,left.old_rid=right.did
					,transform(rsffx,self.suffix2:=right.name_suffix,self:=left)
					,left outer
					,local);
	ds7:=dedup(sort(ds6,old_rid,suffix2,local),old_rid,suffix2,local);
	// keep did pairs where old_rid has only one distinct name_suffix
	outfile:=table(ds7,{ds7,cnt:=count(group)},old_rid,local)(cnt=1);

	// return pairs with not-not-equal name_suffix
	return project(outfile(ut.nneq_suffix(suffix1,suffix2)),transform(header.layout_pairmatch,self:=left));

end;