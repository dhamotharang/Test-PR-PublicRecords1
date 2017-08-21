EXPORT Create_Groups(
	 
	  dataset(Layouts.Input.sprayed	)	pSprayedFile
	 ,string6													pFileType
	 ,unsigned8												pMaxRid				= 0
	 ,unsigned8												pMaxGID				= 0
	 ,unsigned8												pMaxGHID			= 0

) :=
function

	dinput := project(pSprayedFile	,transform({unsigned8 maxlncaGHID,string levels,string lncaGHIDs {maxlength(100000)},layouts.temporary.big}
		,self.rid					:= counter + pMaxRid
		,self.lncaGID 		:= if(counter = 1, pMaxGID + 1,1)
		,self.lncaGHID 		:= pMaxGHID + 1
		,self.lncaIID			:= 0
		,self.maxlncaGHID := pMaxGHID + 1
		,self.levels			:= left.level
		,self.lncaGHIDs		:= (string)self.maxlncaGHID
		,self.file_type 	:= pFileType
		,self.rawfields 	:= left
		,self							:= []
	));


	recordof(dinput)	titerate(recordof(dinput)	le,recordof(dinput) ri) := 
	transform

		indexoldlevel := stringlib.stringfind(le.levels,(string)((unsigned2)ri.rawfields.level - 1),1);
		oldlevels 		:= le.levels[indexoldlevel..];
		countcommas 	:= stringlib.stringfindcount(le.levels[1..indexoldlevel],',');
		startindex 		:= stringlib.stringfind(le.lncaGHIDs,',',countcommas)+1;
		lncaGHIDs			:= (string)le.lncaGHIDs[startindex..];

		indexnewlevel 	:= stringlib.stringfind(le.levels,(string)((unsigned2)ri.rawfields.level - 1),1);
		newlevels 			:= le.levels[indexnewlevel..];
		countcommasnew 	:= stringlib.stringfindcount(le.levels[1..indexnewlevel],',');
		startindexnew 	:= stringlib.stringfind(le.lncaGHIDs,',',countcommasnew)+1;
		lncaGHIDsnew		:= (string)le.lncaGHIDs[startindexnew..];
		dnewlncaGHID		:= stringlib.stringextract(lncaGHIDsnew,1);

			
		self.lncaGID 			:= if(ri.rawfields.level = '0'	,le.lncaGID + ri.lncaGID	,le.lncaGID			);
		self.lncaIID			:= if(ri.rawfields.level = '0'	,1												,le.lncaIID + 1	);
		self.lncaGHID 		:= map(
			 ri.rawfields.level = '0' or regexfind('holding',ri.rawfields.Company_Type, nocase)	=> if(le.lncaGHID > le.maxlncaGHID,le.lncaGHID	,if(le.lncaGHID != 0	,le.maxlncaGHID + 1, ri.lncaGHID))	//increment it
			,(unsigned2)le.rawfields.level > (unsigned2)ri.rawfields.level 											=> (unsigned6)dnewlncaGHID
			,																																												le.lncaGHID
		);
		self.maxlncaGHID	:= map(
			 self.lncaGHID	>= ri.maxlncaGHID	and self.lncaGHID 	>= le.maxlncaGHID	=> self.lncaGHID	
			,le.maxlncaGHID >= self.lncaGHID 	and le.maxlncaGHID 	>= ri.maxlncaGHID	=> le.maxlncaGHID
			,																																					 ri.maxlncaGHID
		);
		self.levels				:= map(
			 ri.levels = '0'																								=> 	'0'
			,(unsigned2)le.rawfields.level < (unsigned2)ri.rawfields.level 	=> 	trim(ri.levels) + ',' + trim(le.levels)
			,																																		trim(ri.levels) + ',' + oldlevels
		);
		self.lncaGHIDs		:= map(
			 ri.levels = '0'																								=>	(string)self.lncaGHID	
			,(unsigned2)le.rawfields.level < (unsigned2)ri.rawfields.level	=>	(string)self.lncaGHID + ',' + (string)le.lncaGHIDs
			,																																		(string)self.lncaGHID + ',' + lncaGHIDs
		);
		self							:= ri;

	end;

	diterate := iterate(dinput	,titerate(left,right));

	return diterate;

end;