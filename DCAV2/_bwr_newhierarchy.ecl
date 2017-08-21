fhier(dataset(dcav2.layouts.input.sprayedflat)	pinput) := function
dinput := project(pinput	,transform({unsigned8 rid,unsigned8 groupid,unsigned8 g2id,unsigned8 indid,unsigned8 maxg2id,string levels,string g2ids {maxlength(100000)},recordof(left)}
	,self.rid			:= counter
	,self.groupid := 1
	,self.g2id 		:= 1
	,self.indid		:= 0
	,self.maxg2id := 1
	,self.levels	:= left.level
	,self.g2ids		:= '1'
	,self := left
));


recordof(dinput)	titerate(recordof(dinput)	le,recordof(dinput) ri) := 
transform

		indexoldlevel := stringlib.stringfind(le.levels,(string)((unsigned2)ri.level - 1),1);
		oldlevels 		:= le.levels[indexoldlevel..];
		countcommas 	:= stringlib.stringfindcount(le.levels[1..indexoldlevel],',');
		startindex 		:= stringlib.stringfind(le.g2ids,',',countcommas)+1;
		g2ids					:= (string)le.g2ids[startindex..];

		indexnewlevel 	:= stringlib.stringfind(le.levels,(string)((unsigned2)ri.level - 1),1);
		newlevels 			:= le.levels[indexnewlevel..];
		countcommasnew 	:= stringlib.stringfindcount(le.levels[1..indexnewlevel],',');
		startindexnew 	:= stringlib.stringfind(le.g2ids,',',countcommasnew)+1;
		g2idsnew				:= (string)le.g2ids[startindexnew..];
		dnewg2id				:= stringlib.stringextract(g2idsnew,1);

		
	 self.groupid := if(ri.level = '0'	,le.groupid + ri.groupid	,le.groupid);
//	,self.g2id 		:= if(ri.level = '0' or regexfind('holding',ri.Company_Type, nocase)	,le.g2id + ri.g2id	,le.g2id)
	 self.g2id 		:= map(ri.level = '0' or regexfind('holding',ri.Company_Type, nocase)	=> if(le.g2id > le.maxg2id,le.g2id,le.maxg2id) + ri.g2id	//increment it
											,(unsigned2)le.level > (unsigned2)ri.level => (unsigned6)dnewg2id
											,le.g2id
									);
	 self.maxg2id	:= map(self.g2id	>= ri.maxg2id	and self.g2id 	>= le.maxg2id	=> self.g2id	
											,le.maxg2id >= self.g2id 	and le.maxg2id 	>= ri.maxg2id	=> le.maxg2id
											,																													 ri.maxg2id
									);
	 self.indid		:= if(ri.level = '0'	,1															,le.indid + 1);
//	,self.levels	:= if(ri.levels = '0'	,'0',trim(ri.levels) + ',' + trim(le.levels))
	 self.levels	:= map(ri.levels = '0'														=> 	'0'
											,(unsigned2)le.level < (unsigned2)ri.level 	=> 	trim(ri.levels) + ',' + trim(le.levels)
											,																								trim(ri.levels) + ',' + oldlevels
									);
//	,self.g2ids		:= if(ri.levels = '0'	,(string)self.g2id	,(string)self.g2id + ',' + (string)le.g2ids)
	 self.g2ids		:= map(ri.levels = '0'	=>	(string)self.g2id	
											,(unsigned2)le.level < (unsigned2)ri.level => (string)self.g2id + ',' + (string)le.g2ids
//											,(string)le.g2ids[stringlib.stringfind(le.g2ids,',',stringlib.stringfindcount(le.levels[1..stringlib.stringfind(le.levels,(string)((unsigned2)ri.level),1)],','))+1..]
											,(string)self.g2id + ',' + g2ids
									);
	self					:= ri;

end;


diterate := iterate(dinput	,titerate(left,right));
/*
	,self.groupid := if(right.level = '0'	,left.groupid + right.groupid	,left.groupid)
//	,self.g2id 		:= if(right.level = '0' or regexfind('holding',right.Company_Type, nocase)	,left.g2id + right.g2id	,left.g2id)
	,self.g2id 		:= map(right.level = '0' or regexfind('holding',right.Company_Type, nocase)	=>left.g2id + right.g2id	
											,(unsigned2)left.level > (unsigned2)right.level => 
											,left.g2id
									)
	,self.indid		:= if(right.level = '0'	,1															,left.indid + 1)
//	,self.levels	:= if(right.levels = '0'	,'0',trim(right.levels) + ',' + trim(left.levels))
	,self.levels	:= map(right.levels = '0'	=> '0'
											,(unsigned2)left.level < (unsigned2)right.level => trim(right.levels) + ',' + trim(left.levels)
											,trim(right.levels) + ',' + left.levels[stringlib.stringfind(left.levels,(string)((unsigned2)right.level - 1),1)..]
									)
//	,self.g2ids		:= if(right.levels = '0'	,(string)self.g2id	,(string)self.g2id + ',' + (string)left.g2ids)
	,self.g2ids		:= map(right.levels = '0'	=>	(string)self.g2id	
											,(unsigned2)left.level < (unsigned2)right.level => (string)self.g2id + ',' + (string)left.g2ids
//											,(string)left.g2ids[stringlib.stringfind(left.g2ids,',',stringlib.stringfindcount(left.levels[1..stringlib.stringfind(left.levels,(string)((unsigned2)right.level),1)],','))+1..]
											,(string)self.g2id + ',' + (string)left.g2ids[stringlib.stringfind(left.g2ids,',',stringlib.stringfindcount(left.levels[1..stringlib.stringfind(left.levels,(string)((unsigned2)right.level - 1),1)],','))+1..]
									)
	,self					:= right;
));
*/
//output(dinput(regexfind('^.*?Lexis.*?Nexis.*$',name,nocase))	,named('DCAV2InputDDCA'),all);
//output(diterate(enterprise_num = '246589')	,named('DCAV2InputLNGroup'),all);
//output(dinput(enterprise_num = '1346092')	,named('DCAV2InputLNSA'),all);
//output(dinput(enterprise_num = '246594')	,named('DCAV2InputLNEurope'),all);
thegid 					:= diterate(enterprise_num = '485361')[1].groupid;
lexisgroup 			:= diterate(groupid = thegid);
countlexisgroup := count(lexisgroup);

return diterate;
//output(dinput						,named('dinput'					));
//output(diterate					,named('diterate'				));
//output(thegid 					,named('thegid'					));
//output(lexisgroup 			,named('lexisgroup'			),all);
//output(countlexisgroup 	,named('countlexisgroup'));
//output(sort(lexisgroup,indid)	,,'~thor_data400::temp::DCALexisHier1');

end;

dddca 	:= fhier(dcav2.files().input.ddca.used);
dprivco := fhier(dcav2.files().input.privco.used);

theasiapaxgid 		:= dddca(enterprise_num = '1261756')[1].groupid;
asiapaxgroup 			:= table(dddca(groupid = 80495),{groupid,g2id,indid,maxg2id,levels,g2ids,enterprise_num,level,company_type,name});
countasiapaxgroup := count(asiapaxgroup);

output(count(dddca 		)		,named('countdddca'		));
output(choosen(dddca,200)	,named('dddca'				),all);
output(theasiapaxgid			,named('theasiapaxgid'));
output(asiapaxgroup				,named('asiapaxgroup'),all);
output(countasiapaxgroup	,named('countasiapaxgroup'));
output(count(table(dddca		,{groupid}	,groupid))	,named('countGroupidsDdca'));
output(topn(table(dddca		,{groupid,unsigned8 cnt := count(group)}	,groupid),100,-cnt)	,named('TopnGroupidsDdca'));

output(dprivco 					,named('dprivco'			));
output(count(dprivco 	)	,named('countdprivco'	));
output(count(table(dprivco	,{groupid}	,groupid))	,named('countGroupidsPrivco'));
output(topn(table(dprivco		,{groupid,unsigned8 cnt := count(group)}	,groupid),100,-cnt)	,named('TopnGroupidsPrivco'));
