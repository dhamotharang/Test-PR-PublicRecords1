import dca;
export fRemoveHoldings(

	 dataset(Layout_Business_Relative			)	pBusinessRelatives	= Files().Base.Business_Relatives.built
	,dataset(DCA.Layout_DCA_Base					) pDcaBase						= DCA.File_DCA_Base

) :=
function

br := pBusinessRelatives;
					  
/*
looks like I need to(in Business_Header.BH_Super_Group):
pass in dca base file as a parameter
Find all records with type_orig = 'holding'
join that dataset to the dca base file on parent_number to root, sub
grabbing the bdid for the matching record
so you have the bdid combos for the holding companies
then dup the bdids so you have them both ways(like the biz relative file)
filter the biz relatives for dca links only(no other link for that pair)
join the holding company links to the above, left only to remove them
add the dca with holding company removed dataset to the filtered biz relatives
*/
dDCAslimUP := dedup(project(pDcaBase(sub = '000'), transform(
	{string6 root, unsigned6 bdid}
	,self.root	:= left.root;
	 self.bdid	:= left.bdid;
	)
), hash(root, bdid), all);

dDCABase := join(
	 pDcaBase
	,dDCAslimUP
	,left.root = right.root
	,transform({recordof(pDcaBase), unsigned6 uparent_bdid}
		,self.uparent_bdid	:= right.bdid;
		 self								:= left;
	)
	,local
	,left outer
);

dDCAslim := project(dDcaBase, transform(
	{string10 child_number, string10 parent_number, unsigned6 child_bdid, unsigned6 parent_bdid, string70 Type_orig, unsigned6 uparent_bdid}
	,self.child_number	:= trim(trim(left.root,left,right) + '-' + trim(left.sub,left,right), left,right);
	 self.parent_number := left.parent_number;
	 self.child_bdid		:= left.bdid;
	 self.parent_bdid		:= 0;
	 self := left;
	)
);

dDCAslimUltimateParent := project(dDcaBase, transform(
	{string10 child_number, string10 parent_number, unsigned6 child_bdid, unsigned6 parent_bdid, string70 Type_orig, unsigned6 uparent_bdid}
	,self.child_number	:= trim(trim(left.root,left,right) + '-' + trim(left.sub,left,right), left,right);
	 self.parent_number := left.parent_number[1..7] + '000';
	 self.child_bdid		:= left.bdid;
	 self.parent_bdid		:= 0;
	 self := left;
	)
);


dDCAHoldings := dDCAslim(regexfind('holding',type_orig, nocase));
dDCAHoldingsUltimate := dDCAslimUltimateParent(regexfind('holding',type_orig, nocase));
//If company is a holding of another company, then break it's link to that holding company
//and go up the hierarchy of that holding company to break the holding's link to anything above it
//going up 7 links, that should cover almost everything.

//so going up one link here
dDCAHolder := join(
	 distribute(dDCAslim			, hash(child_number))
	,distribute(dDCAHoldings	, hash(parent_number))
	,left.child_number = right.parent_number
	,transform(recordof(dDCAslim)
		,self.parent_bdid		:= left.child_bdid		;
		 self.parent_number := left.parent_number	;	//go up hierarchy
		 self								:= right							;
	)
	,local
);

// two links
dDCAHolder2 := join(
	 distribute(dDCAslim			, hash(child_number))
	,distribute(dDCAHolder		, hash(parent_number))
	,left.child_number = right.parent_number
	,transform(recordof(dDCAslim)		
		,self.parent_bdid		:= left.child_bdid		;
		 self.parent_number := left.parent_number	;	//go up hierarchy
		 self								:= right							;
	)
	,local
);

// three links
dDCAHolder3 := join(
	 distribute(dDCAslim			, hash(child_number))
	,distribute(dDCAHolder2		, hash(parent_number))
	,left.child_number = right.parent_number
	,transform(recordof(dDCAslim)		
		,self.parent_bdid		:= left.child_bdid		;
		 self.parent_number := left.parent_number	;	//go up hierarchy
		 self								:= right							;
	)
	,local
);

// four links
dDCAHolder4 := join(
	 distribute(dDCAslim			, hash(child_number))
	,distribute(dDCAHolder3		, hash(parent_number))
	,left.child_number = right.parent_number
	,transform(recordof(dDCAslim)		
		,self.parent_bdid		:= left.child_bdid		;
		 self.parent_number := left.parent_number	;	//go up hierarchy
		 self								:= right							;
	)
	,local
);

// five links
dDCAHolder5 := join(
	 distribute(dDCAslim			, hash(child_number))
	,distribute(dDCAHolder4		, hash(parent_number))
	,left.child_number = right.parent_number
	,transform(recordof(dDCAslim)		
		,self.parent_bdid		:= left.child_bdid		;
		 self.parent_number := left.parent_number	;	//go up hierarchy
		 self								:= right							;
	)
	,local
);

// six links
dDCAHolder6 := join(
	 distribute(dDCAslim			, hash(child_number))
	,distribute(dDCAHolder5		, hash(parent_number))
	,left.child_number = right.parent_number
	,transform(recordof(dDCAslim)		
		,self.parent_bdid		:= left.child_bdid		;
		 self.parent_number := left.parent_number	;	//go up hierarchy
		 self								:= right							;
	)
	,local
);

// seven links
dDCAHolder7 := join(
	 distribute(dDCAslim			, hash(child_number))
	,distribute(dDCAHolder6		, hash(parent_number))
	,left.child_number = right.parent_number
	,transform(recordof(dDCAslim)		
		,self.parent_bdid		:= left.child_bdid		;
		 self.parent_number := left.parent_number	;	//go up hierarchy
		 self								:= right							;
	)
	,local
);

// going up to top of hierarchy
dDCAHolderU := join(
	 distribute(dDCAslimUltimateParent	, hash(child_number))
	,distribute(dDCAHoldingsUltimate		, hash(parent_number))
	,left.child_number = right.parent_number
	,transform(recordof(dDCAslimUltimateParent), self.parent_bdid := left.child_bdid; self := right;)
	,local
);

// -- going down one level
dDCAHoldingdownward1 := join(
	 distribute(dDCAslim								, hash(parent_number))
	,distribute(dDCAHoldingsUltimate		, hash(child_number))
	,left.parent_number = right.child_number
	,transform(recordof(dDCAslim)
		,self.parent_bdid		:= right.child_bdid;
		 self.parent_number := left.parent_number[1..7] + '000';
		 self								:= left;
	)
	,local
);

// -- going down two levels
dDCAHoldingdownward2 := join(
	 distribute(dDCAslim								, hash(parent_number))
	,distribute(dDCAHoldingdownward1		, hash(child_number))
	,left.parent_number = right.child_number
	,transform(recordof(dDCAslim)
		,self.parent_bdid		:= right.child_bdid;
		 self.parent_number := left.parent_number[1..7] + '000';
		 self								:= left;
	)
	,local
);

// -- going down three levels
dDCAHoldingdownward3 := join(
	 distribute(dDCAslim								, hash(parent_number))
	,distribute(dDCAHoldingdownward2		, hash(child_number))
	,left.parent_number = right.child_number
	,transform(recordof(dDCAslim)
		,self.parent_bdid		:= right.child_bdid;
		 self.parent_number := left.parent_number[1..7] + '000';
		 self								:= left;
	)
	,local
);

// -- going down four levels
dDCAHoldingdownward4 := join(
	 distribute(dDCAslim								, hash(parent_number))
	,distribute(dDCAHoldingdownward3		, hash(child_number))
	,left.parent_number = right.child_number
	,transform(recordof(dDCAslim)
		,self.parent_bdid		:= right.child_bdid;
		 self.parent_number := left.parent_number[1..7] + '000';
		 self								:= left;
	)
	,local
);

// -- going down five levels
dDCAHoldingdownward5 := join(
	 distribute(dDCAslim								, hash(parent_number))
	,distribute(dDCAHoldingdownward4		, hash(child_number))
	,left.parent_number = right.child_number
	,transform(recordof(dDCAslim)
		,self.parent_bdid		:= right.child_bdid;
		 self.parent_number := left.parent_number[1..7] + '000';
		 self								:= left;
	)
	,local
);

dDCAHoldingsDown := project(
		dDCAHoldingdownward1
	+ dDCAHoldingdownward2
	+ dDCAHoldingdownward3
	+ dDCAHoldingdownward4
	+ dDCAHoldingdownward5
	,transform(
		recordof(dDCAHolder)
		,self.parent_bdid := left.uparent_bdid;
		 self.child_bdid	:= left.child_bdid;
		 self							:= left;
	)
);

dDCAHolderAll := 
		dDCAHolder 
	+ dDCAHolder2
	+ dDCAHolder3
	+ dDCAHolder4
	+ dDCAHolder5
	+ dDCAHolder6
	+ dDCAHolder7
	+ dDCAHolderU
	+ dDCAHoldingsDown
	;

dDCAbdids := table(dDCAHolderAll(child_bdid != 0, parent_bdid != 0, child_bdid != parent_bdid), {child_bdid, parent_bdid}, child_bdid, parent_bdid);

dDCAbdidsDup := project(dDCAbdids
	,transform(recordof(dDCAbdids)
		,self.child_bdid	:= left.parent_bdid; 
		,self.parent_bdid := left.child_bdid; 
	)
);

dDCABdidsAll := table(dDCAbdids + dDCAbdidsDup, {child_bdid, parent_bdid}, child_bdid, parent_bdid);


dfilteredDCABR := join(distribute(br						, hash(bdid1			, bdid2				))
											,distribute(dDCABdidsAll	, hash(child_bdid	, parent_bdid	))
											,		left.bdid1 = right.child_bdid
											and left.bdid2 = right.parent_bdid
											,transform(recordof(br)
												,self.dca_company_number 	:= false;
												 self.dca_hierarchy				:= false;
												 self											:= left;
											)
											,local
											,keep(1)
									);

drestDCABR 		 := join(distribute(br						, hash(bdid1			, bdid2				))
											,distribute(dDCABdidsAll	, hash(child_bdid	, parent_bdid	))
											,		left.bdid1 = right.child_bdid
											and left.bdid2 = right.parent_bdid
											,transform(recordof(br)
												,self										:= left;
											)
											,left only
									);

dbr_filtered := dfilteredDCABR + drestDCABR;

return dbr_filtered;

end;