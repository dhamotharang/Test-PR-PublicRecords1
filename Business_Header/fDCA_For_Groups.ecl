import ut, dca,mdr;

EXPORT fDCA_For_Groups(

	 dataset(DCA.Layout_DCA_Base				) pDcaBase									= DCA.File_DCA_Base
	,string																pPersistname							= persistnames().fDCAForGroups													
	,boolean															pShouldRecalculatePersist	= true													

) :=
function

//root is string6
holdingrec := {qstring34 source_group,unsigned8 root, unsigned6 bdid, boolean isholding};
both_rec := {unsigned8 rid, boolean didmatch := true,holdingrec parent,holdingrec last_child, dataset({unsigned4 rid, holdingrec}) children};
//child source group, child root, child bdid, child isholding.  parent source group

//prep dataset, fill in fields
ddca_all_slim	:= project(pDcaBase	,transform(both_rec, 
	self.rid											:= 1000000 + counter;
	self.last_child.source_group	:= trim(left.root) + '-' + trim(left.sub);
	self.last_child.isholding			:= regexfind('holding',left.type_orig, nocase);
	self.last_child.root					:= if(self.last_child.isholding	,self.rid, (unsigned8)trim(left.root));
	self.last_child.bdid					:= left.bdid;
	self.children									:= dataset([{1,self.last_child.source_group,self.last_child.root,self.last_child.bdid,self.last_child.isholding}], {unsigned4 rid, holdingrec});
	self.parent.source_group			:= trim(left.Parent_Number);
	self.parent.root							:= (unsigned8)trim(left.parent_number)[1..6];
	self.parent.bdid							:= 0;
	self.parent.isholding					:= false;
)) : global;

ddca_all_slim_wbdid 	:= ddca_all_slim(last_child.bdid != 0);
ddca_all_slim_wobdid	:= ddca_all_slim(last_child.bdid  = 0);

ddca_all_slim_dedup 					:= dedup(ddca_all_slim(parent.source_group != '')	, hash64(last_child.source_group, parent.source_group),all);
ddca_all_slim_dedup_on_child	:= dedup(ddca_all_slim														, hash64(last_child.source_group),all);

//join to full file to get bdid and isholding for parent
ddca_getparentinfo := join(
	 ddca_all_slim_dedup
	,ddca_all_slim_dedup_on_child
	,left.parent.source_group = right.last_child.source_group
	,transform(
		both_rec,
			self.rid											:= left.rid											;
			self.last_child.source_group	:= left.last_child.source_group	;
			self.last_child.isholding			:= left.last_child.isholding		;
			self.last_child.root					:= left.last_child.root					;
			self.last_child.bdid					:= left.last_child.bdid					;
			self.children									:= left.children								;
			self.parent.source_group			:= left.parent.source_group			;
			self.parent.root							:= left.parent.root							;
			self.parent.bdid							:= right.last_child.bdid				;
			self.parent.isholding					:= right.last_child.isholding		;
	)
	,left outer
);

//now, we want to descend the hierarchy, at each step, adding to the child dataset, adding a uniqueid in desending order
//take them, join to whole file minus holding companies, on left.child_number = right.parent_number
//take right child information, add it to child dataset of links
//so for children that are holdings, we remove those records completely since that link is not valid.
//for parents that are holdings, that is ok, since their parent is the holding company.

ddca_filterout_childholdings 	:= ddca_getparentinfo(last_child.isholding = false);
ddca_filter_childholdings 		:= ddca_getparentinfo(last_child.isholding = true	);

fdescendhierarchy(
	  dataset(both_rec)	pParent
	 ,dataset(both_rec)	pChild
) :=
function

	//want to link child of one company with it's child 
	return join(
		 pParent(didmatch = true)
		,pChild
		,left.last_child.source_group = right.parent.source_group
		,transform(
			 both_rec,
				self.rid											:= left.rid;
				self.didmatch									:= if(right.parent.source_group = '', false, true);
				self.last_child.source_group	:= right.last_child.source_group	;
				self.last_child.root					:= right.last_child.root					;
				self.last_child.bdid					:= right.last_child.bdid					;
				self.last_child.isholding			:= right.last_child.isholding			;
				self.children									:= left.children + right.children	;
				self.parent.source_group			:= left.parent.source_group	;
				self.parent.root							:= left.parent.root					;
				self.parent.bdid							:= left.parent.bdid					;
				self.parent.isholding					:= left.parent.isholding		;
		)
		,left outer
	) 
	+ pParent(didmatch = false)
	;

end;

dDescend1 	:= fdescendhierarchy(ddca_filterout_childholdings	,ddca_filterout_childholdings	);
dDescend2 	:= fdescendhierarchy(dDescend1										,ddca_filterout_childholdings	);
dDescend3 	:= fdescendhierarchy(dDescend2										,ddca_filterout_childholdings	);
dDescend4 	:= fdescendhierarchy(dDescend3										,ddca_filterout_childholdings	);
dDescend5 	:= fdescendhierarchy(dDescend4										,ddca_filterout_childholdings	);
dDescend6 	:= fdescendhierarchy(dDescend5										,ddca_filterout_childholdings	);
dDescend7 	:= fdescendhierarchy(dDescend6										,ddca_filterout_childholdings	);
dDescend8 	:= fdescendhierarchy(dDescend7										,ddca_filterout_childholdings	);
dDescend9 	:= fdescendhierarchy(dDescend8										,ddca_filterout_childholdings	);
dDescend10 	:= fdescendhierarchy(dDescend9										,ddca_filterout_childholdings	);

dDescend1_didmatch 	:= dDescend1 (didmatch = true);
dDescend2_didmatch 	:= dDescend2 (didmatch = true); 
dDescend3_didmatch 	:= dDescend3 (didmatch = true); 
dDescend4_didmatch 	:= dDescend4 (didmatch = true); 
dDescend5_didmatch 	:= dDescend5 (didmatch = true); 
dDescend6_didmatch 	:= dDescend6 (didmatch = true); 
dDescend7_didmatch 	:= dDescend7 (didmatch = true); 
dDescend8_didmatch 	:= dDescend8 (didmatch = true); 
dDescend9_didmatch 	:= dDescend9 (didmatch = true); 
dDescend10_didmatch := dDescend10(didmatch = true);

//so now we have mini hierarchies in each record.
//to associate them together, we can normalize the child dataset out, 
//when the parent is a holding, we want to change the root to be the rid to remove it from that hierarchy
//but have to be consistent in the rid, so for same root, same rid
dparent_isholding 		:= dDescend10(parent.isholding = true	);
dparent_isNotholding	:= dDescend10(parent.isholding = false);

dparent_isholding_sort 	:= sort	(dparent_isholding			,parent.source_group, rid);
dparent_isholding_group := group(dparent_isholding_sort	,parent.source_group);

dparent_isholding_iterate := iterate(dparent_isholding_group, transform(
	both_rec,
	 self.rid := if(left.rid = 0, right.rid, left.rid);
	 self			:= right;
));

dparent_isNotholding_setrid	:= project(dparent_isNotholding	,transform(both_rec	,self.rid := (unsigned8)left.parent.root;self := left));

dconcat := dparent_isholding_iterate + dparent_isNotholding_setrid;

Layout_BH_Match := record
unsigned6 bdid;             // Seisint Business Identifier
qstring34	source_group;       
unsigned8 rid;
end;

dnormalize := normalize(dconcat,count(left.children) + 1, transform(
	Layout_BH_Match,
	self.bdid 				:= if(counter = 1, left.parent.bdid					,left.children[counter - 1].bdid				);
	self.source_group := if(counter = 1, left.parent.source_group	,left.children[counter - 1].source_group);
	self.rid 					:= left.rid;
));
//now need to normalize and associate the bdids

ddedup := dedup(dnormalize,hash64(source_group),all);

return ddedup;
end;