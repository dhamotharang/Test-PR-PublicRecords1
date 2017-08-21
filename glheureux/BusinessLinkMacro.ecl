import Business_Header, Business_Header_SS;

export BusinessLinkMacro() := macro
	unsigned temp_GroupID := 0 : stored('GroupID');
	string temp_CompanyName1 := '' : stored('CompanyName1');
	string temp_CompanyName2 := '' : stored('CompanyName2');

	temp_ActualGroupID := Business_Header.Key_BH_SuperGroup_BDID(bdid = temp_GroupID)[1].group_id;

	temp_BDIDs_From_GroupID := table(Business_Header.Key_BH_SuperGroup_GroupID(group_id = temp_ActualGroupID),{bdid});

	temp_Records := join(temp_BDIDs_From_GroupID,Business_Header_SS.Key_BH_BDID_pl,
		keyed(left.bdid = right.bdid) and
		right.company_name in [temp_CompanyName1,temp_CompanyName2],
		transform(right));

	temp_StartBDIDs := dedup(sort(table(temp_Records(company_name = temp_CompanyName1),{bdid}),bdid),bdid);
	temp_FinalBDIDs := set(dedup(sort(table(temp_Records(company_name = temp_CompanyName2),{bdid}),bdid),bdid),bdid);

	key := business_header.Key_Business_Relatives;

	temprec := record
		unsigned1 lvl := 0;
		unsigned head := 0;
		unsigned bdid01 := 0;
		unsigned bdid02 := 0;
		unsigned bdid03 := 0;
		unsigned bdid04 := 0;
		unsigned bdid05 := 0;
		unsigned bdid06 := 0;
		unsigned bdid07 := 0;
		unsigned bdid08 := 0;
		unsigned bdid09 := 0;
		unsigned bdid10 := 0;
	end;

	tempds01 := dedup(sort(project(temp_StartBDIDs,transform(temprec,self.lvl:=1,self.head:=left.bdid,self.bdid01:=left.bdid,self:=[])),head,lvl),head);
	
	tempds02 := module
		export ds := dedup(sort(
		join(tempds01,join(join(dedup(
		sort(tempds01,head),head),key,left.head=right.bdid1 and Business_Header.mac_isGroupRel(right),transform(temprec,
			self.lvl := left.lvl + 1,
			self.bdid02 := right.bdid2,
			self := left),limit(20000,skip)),
			tempds01,
			left.bdid02=right.head,transform(left),left only),left.head=right.head,transform(temprec,
			self.lvl := right.lvl,
			self.head := right.bdid02,
			self.bdid02 := right.bdid02,
			self := left)) + tempds01,head,lvl),head);
		shared winn := ds(head in temp_FinalBDIDs);
		export succ := exists(winn);
		export rel := Business_Header.Key_Business_Relatives(bdid1 = winn[1].bdid01 and bdid2 = winn[1].bdid02);
	end;
	tempds03 := module
		export ds := dedup(sort(
		join(tempds02.ds,join(join(dedup(
		sort(tempds02.ds,head),head),key,left.head=right.bdid1 and Business_Header.mac_isGroupRel(right),transform(temprec,
			self.lvl := left.lvl + 1,
			self.bdid03 := right.bdid2,
			self := left),limit(20000,skip)),
			tempds02.ds,
			left.bdid03=right.head,transform(left),left only),left.head=right.head,transform(temprec,
			self.lvl := right.lvl,
			self.head := right.bdid03,
			self.bdid03 := right.bdid03,
			self := left)) + tempds02.ds,head,lvl),head);
		shared winn := ds(head in temp_FinalBDIDs);
		export succ := exists(winn);
		export rel := Business_Header.Key_Business_Relatives(bdid1 = winn[1].bdid02 and bdid2 = winn[1].bdid03);
	end;
	tempds04 := module
		export ds := dedup(sort(
		join(tempds03.ds,join(join(dedup(
		sort(tempds03.ds,head),head),key,left.head=right.bdid1 and Business_Header.mac_isGroupRel(right),transform(temprec,
			self.lvl := left.lvl + 1,
			self.bdid04 := right.bdid2,
			self := left),limit(20000,skip)),
			tempds03.ds,
			left.bdid04=right.head,transform(left),left only),left.head=right.head,transform(temprec,
			self.lvl := right.lvl,
			self.head := right.bdid04,
			self.bdid04 := right.bdid04,
			self := left)) + tempds03.ds,head,lvl),head);
		shared winn := ds(head in temp_FinalBDIDs);
		export succ := exists(winn);
		export rel := Business_Header.Key_Business_Relatives(bdid1 = winn[1].bdid03 and bdid2 = winn[1].bdid04);
	end;
	tempds05 := module
		export ds := dedup(sort(
		join(tempds04.ds,join(join(dedup(
		sort(tempds04.ds,head),head),key,left.head=right.bdid1 and Business_Header.mac_isGroupRel(right),transform(temprec,
			self.lvl := left.lvl + 1,
			self.bdid05 := right.bdid2,
			self := left),limit(20000,skip)),
			tempds04.ds,
			left.bdid05=right.head,transform(left),left only),left.head=right.head,transform(temprec,
			self.lvl := right.lvl,
			self.head := right.bdid05,
			self.bdid05 := right.bdid05,
			self := left)) + tempds04.ds,head,lvl),head);
		shared winn := ds(head in temp_FinalBDIDs);
		export succ := exists(winn);
		export rel := Business_Header.Key_Business_Relatives(bdid1 = winn[1].bdid04 and bdid2 = winn[1].bdid05);
	end;
	tempds06 := module
		export ds := dedup(sort(
		join(tempds05.ds,join(join(dedup(
		sort(tempds05.ds,head),head),key,left.head=right.bdid1 and Business_Header.mac_isGroupRel(right),transform(temprec,
			self.lvl := left.lvl + 1,
			self.bdid06 := right.bdid2,
			self := left),limit(20000,skip)),
			tempds05.ds,
			left.bdid06=right.head,transform(left),left only),left.head=right.head,transform(temprec,
			self.lvl := right.lvl,
			self.head := right.bdid06,
			self.bdid06 := right.bdid06,
			self := left)) + tempds05.ds,head,lvl),head);
		shared winn := ds(head in temp_FinalBDIDs);
		export succ := exists(winn);
		export rel := Business_Header.Key_Business_Relatives(bdid1 = winn[1].bdid05 and bdid2 = winn[1].bdid06);
	end;
	tempds07 := module
		export ds := dedup(sort(
		join(tempds06.ds,join(join(dedup(
		sort(tempds06.ds,head),head),key,left.head=right.bdid1 and Business_Header.mac_isGroupRel(right),transform(temprec,
			self.lvl := left.lvl + 1,
			self.bdid07 := right.bdid2,
			self := left),limit(20000,skip)),
			tempds06.ds,
			left.bdid07=right.head,transform(left),left only),left.head=right.head,transform(temprec,
			self.lvl := right.lvl,
			self.head := right.bdid07,
			self.bdid07 := right.bdid07,
			self := left)) + tempds06.ds,head,lvl),head);
		shared winn := ds(head in temp_FinalBDIDs);
		export succ := exists(winn);
		export rel := Business_Header.Key_Business_Relatives(bdid1 = winn[1].bdid06 and bdid2 = winn[1].bdid07);
	end;

	temp_Successes := tempds07.ds(head in temp_FinalBDIDs)[1];
	output(temp_Successes,named('Linkages'));

	temp_Relatives :=
		if(tempds02.succ or tempds03.succ or tempds04.succ or tempds05.succ or tempds06.succ or tempds07.succ,tempds02.rel) +
		if(tempds03.succ or tempds04.succ or tempds05.succ or tempds06.succ or tempds07.succ,tempds03.rel) +
		if(tempds04.succ or tempds05.succ or tempds06.succ or tempds07.succ,tempds04.rel) +
		if(tempds05.succ or tempds06.succ or tempds07.succ,tempds05.rel) +
		if(tempds06.succ or tempds07.succ,tempds06.rel) +
		if(tempds07.succ,tempds07.rel);
	output(temp_Relatives,named('Relatives'));

	temp_Out_Records := Business_Header_SS.Key_BH_BDID_pl(bdid in
		if(tempds02.succ or tempds03.succ or tempds04.succ or tempds05.succ or tempds06.succ or tempds07.succ,[tempds07.ds(head in temp_FinalBDIDs)[1].bdid01,tempds07.ds(head in temp_FinalBDIDs)[1].bdid02],[]) +
		if(tempds03.succ or tempds04.succ or tempds05.succ or tempds06.succ or tempds07.succ,[tempds07.ds(head in temp_FinalBDIDs)[1].bdid03],[]) +
		if(tempds04.succ or tempds05.succ or tempds06.succ or tempds07.succ,[tempds07.ds(head in temp_FinalBDIDs)[1].bdid04],[]) +
		if(tempds05.succ or tempds06.succ or tempds07.succ,[tempds07.ds(head in temp_FinalBDIDs)[1].bdid05],[]) +
		if(tempds06.succ or tempds07.succ,[tempds07.ds(head in temp_FinalBDIDs)[1].bdid06],[]) +
		if(tempds07.succ,[tempds07.ds(head in temp_FinalBDIDs)[1].bdid07],[]));
	output(choosen(temp_Out_Records,5000),named('Records'));

endmacro;	
