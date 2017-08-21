import tools;

EXPORT Prep_Kill_Merger(

	 string 																pversion
	,dataset(layouts.input.killreport			)	pSprayedkillReport		= Files().input.killReport.using
	,dataset(layouts.input.MergerAcquis		)	pSprayedMergerAcquis	= Files().input.MergerAcquis.using

) :=
module

	dkillprep := project(pSprayedkillReport	,transform(layouts.input.killreport_clean
		,self.kill_date_raw				:= left.kill_date
		,self.kill_reason_clean		:= if(regexfind('(unconfirmed|duplicate|ceased|absorbed|not meet criteria|merged|bankruptcy|shell|old SENEWS|dummy|floater)',left.kill_reason,nocase)	,regexfind('(unconfirmed|duplicate|ceased|absorbed|not meet criteria|merged|bankruptcy|shell|old SENEWS|dummy|floater)',left.kill_reason,0,nocase)	,'')
		,self.kill_enterprise_nbr	:= if(regexfind('(.*?[[].*?([0-9]+).*?[]])?',left.kill_reason,nocase)	,regexfind('(.*?[[].*?([0-9]+).*?[]])?',left.kill_reason,2,nocase)	,'')
		,self											:= left
		,self											:= []
	));
	
	dKillAppendDates := tools.mac_Append_Dates	(dkillprep	,['kill_date_raw','__filename'],['kill_date_clean','filedate']);

	export dkillfixdates := project(dKillAppendDates, transform(recordof(dKillAppendDates),
	self.filedate		:= if(left.filedate != ''	,left.filedate	,pversion);
self := left;
	));
	
	regex := '(.*?[(].*?([0-9]+).*?[)])?';	//works
	regex3 := '^' + regex + regex + regex + '.*$';
	
	dMergeprep := project(pSprayedMergerAcquis	,transform(layouts.input.MergerAcquis_clean,
		splitindex 	:= if(stringlib.stringfind(stringlib.stringtouppercase(left.what_happened),' FROM ',1) = 0
											,length(left.what_happened)
											,stringlib.stringfind(stringlib.stringtouppercase(left.what_happened),' FROM ',1)
										);
		buyer 			:= left.what_happened[1..splitindex];
		seller 			:= left.what_happened[splitindex..];
//		self.buyer									:= buyer;
//		self.seller									:= seller;
//		self.split_index						:= splitindex;
		self.target_enterprise_nbr	:= if(regexfind('[0-9]+',left.target_company,nocase)	,regexfind('[0-9]+',left.target_company,0,nocase)	,'');
		self.buyer1_enterprise_nbr	:= if(regexfind(regex3,buyer,2,nocase)	!= ''				,regexfind(regex3,buyer,2,nocase)								,'');
		self.buyer2_enterprise_nbr	:= if(regexfind(regex3,buyer,4,nocase)	!= ''				,regexfind(regex3,buyer,4,nocase)								,'');
		self.buyer3_enterprise_nbr	:= if(regexfind(regex3,buyer,6,nocase)	!= ''				,regexfind(regex3,buyer,6,nocase)								,'');
		self.seller1_enterprise_nbr	:= if(regexfind(regex3,seller,2,nocase)	!= ''				,regexfind(regex3,seller,2,nocase)							,'');
		self.seller2_enterprise_nbr	:= if(regexfind(regex3,seller,4,nocase)	!= ''				,regexfind(regex3,seller,4,nocase)							,'');
		self.seller3_enterprise_nbr	:= if(regexfind(regex3,seller,6,nocase)	!= ''				,regexfind(regex3,seller,6,nocase)							,'');
		self												:= left;
		self												:= [];
	));
	
	dMergeAppendDates := tools.mac_Append_Dates	(dMergeprep	,['MnA_Close_Date','LexisNexis_Posting_Date','Last_Change_Date','__filename'],['MnA_Close_Date_clean','LN_Posting_Date_clean','Last_Change_Date_clean','filedate']);
	export dMergefixDates := project(dMergeAppendDates, transform(recordof(dMergeAppendDates),
	self.filedate		:= if(left.filedate != ''	,left.filedate	,pversion);
self := left;
	));
	
end;