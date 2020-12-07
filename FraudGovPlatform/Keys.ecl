import tools,FraudgovKEL;

export Keys(
	 string pversion = ''

) := module
	shared Base_EntityProfile							:= PROJECT(FraudgovKEL.KEL_PivotIndexPrep.ds_KEL_PivotIndexPrep(aotcurrprofflag=1)
																											,Transform(Layouts_Key.EntityProfile
																											,self.entitycontextuid :=left.entitycontextuid,self:=left));	
	shared Base_ConfigAttributes					:= PROJECT(Files().Input.ConfigAttributes.Sprayed
																							,Transform(Layouts_Key.ConfigAttributes
																								,self.entitytype	:= (integer8)left.entitytype
																								,self.field	:= (string200)left.field
																								,self.low:=(decimal)left.low
																								,self.high:=(decimal)left.high
																								,self.risklevel	:=(integer)left.risklevel
																								,self.weight	:=(integer)left.weight
																								,self.customerid	:=(unsigned)left.customerid
																								,self.industrytype	:=(unsigned)left.industrytype
																								,Self:=left));
	shared Base_ConfigRules								:= PROJECT(Files().Input.ConfigRules.Sprayed,Transform(Layouts_Key.ConfigRules,Self:=left));
																																																		
 export Main := module
	tools.mac_FilesIndex('Base_EntityProfile,{customerid,industrytype,entitycontextuid},{Base_EntityProfile}',KeyNames(pversion).Main.EntityProfile,EntityProfile);
	tools.mac_FilesIndex('Base_ConfigAttributes,{Field, EntityType, CustomerId, IndustryType,value},{Base_ConfigAttributes}',KeyNames(pversion).Main.ConfigAttributes,ConfigAttributes);
	tools.mac_FilesIndex('Base_ConfigRules,{CustomerId, IndustryType, Field, EntityType,rulename},{Base_ConfigRules}',KeyNames(pversion).Main.ConfigRules,ConfigRules);
	end; 	
end;