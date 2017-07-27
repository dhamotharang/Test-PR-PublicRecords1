rParty_Layout
 :=
  record
	Civil_Court.File_In_Party.Vendor;
	Civil_Court.File_In_Party.Source_File;
	Total									:= count(group);
  end;

rMatter_Layout
 :=
  record
	Civil_Court.File_In_Matter.Vendor;
	Civil_Court.File_In_Matter.Source_File;
	Total									:= count(group);
  end;

rActivity_Layout
 :=
  record
	Civil_Court.File_In_Case_Activity.Vendor;
	Civil_Court.File_In_Case_Activity.Source_File;
	Total									:= count(group);
  end;

rCombined_Layout
 :=
  record
	string2		Vendor			:= '';
	string20	Source_File		:= '';
	string1		Party_Exists	:= '';
	string1		Matter_Exists	:= '';
	string1		Activity_Exists := '';
  end
 ;

dPartyList		:= table(Civil_Court.File_In_Party,rParty_Layout,Vendor,Source_File,few);
dMatterList		:= table(Civil_Court.File_In_Matter,rMatter_Layout,Vendor,Source_File,few);
dActivityList	:= table(Civil_Court.File_In_Case_Activity,rActivity_Layout,Vendor,Source_File,few);

rCombined_Layout tJoinPartyToMatter(rParty_Layout pParty,rMatter_Layout pMatter)
 :=
  transform
	self.Party_Exists	:= if(pParty.Vendor<>'','Y','');
	self.Matter_Exists	:= if(pMatter.Vendor<>'','Y','');
	self.Activity_Exists:= '';
	self.Vendor			:= if(pParty.Vendor<>'',pParty.Vendor,pMatter.Vendor);
	self.Source_File	:= if(pParty.Vendor<>'',pParty.Source_File,pMatter.Source_File);
  end
 ;

dPartyMatterJoined := join(dPartyList,dMatterList,
						   left.Vendor = right.Vendor,
						   tJoinPartyToMatter(left,right),
						   full outer
						  );

rCombined_Layout tJoinPartyMatterToActivity(rCombined_Layout pPartyMatter,rActivity_Layout pActivity)
 :=
  transform
	self.Party_Exists	:= if(pPartyMatter.Vendor<>'','Y','');
	self.Matter_Exists	:= if(pPartyMatter.Vendor<>'','Y','');
	self.Activity_Exists:= if(pActivity.Vendor<>'','Y','');
	self.Vendor			:= if(pPartyMatter.Vendor<>'',pPartyMatter.Vendor,pActivity.Vendor);
	self.Source_File	:= if(pPartyMatter.Vendor<>'',pPartyMatter.Source_File,pActivity.Source_File);
  end
 ;

dPartyMatterActivityJoined := join(dPartyMatterJoined,dActivityList,
								   left.Vendor = right.Vendor,
								   tJoinPartyMatterToActivity(left,right),
								   full outer
								  );

dJustThoseMissingSorted := sort(dPartyMatterActivityJoined(Party_Exists='' or Matter_Exists='' or Activity_Exists=''),vendor);
dJustThoseMissingDeduped:= dedup(dJustThoseMissingSorted,vendor);

lPartyList				:= output(choosen(sort(dedup(dPartyList,Vendor),Vendor),all));
lMatterList				:= output(choosen(sort(dedup(dMatterList,Vendor),Vendor),all));
lActivityList			:= output(choosen(sort(dedup(dActivityList,Vendor),Vendor),all));
lMissingDatasets		:= output(choosen(dJustThoseMissingDeduped,all));

export Out_Missing_Datasets
 := 
  parallel
   (
	lPartyList,
	lMatterList,
	lActivityList,
	lMissingDataSets
   )
 ;