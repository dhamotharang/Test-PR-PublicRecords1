import Data_Services;
export	Constants	:=
module
	// Autokey constants
	export	ak_keyname									:=	ln_propertyv2.cluster	+	'key::ln_propertyv2::autokey::';
	export	ak_logical(string	filedate)	:=	ln_propertyv2.cluster	+	'key::ln_propertyv2::'	+	filedate	+	'::autokey::';
	export	ak_dataset									:=	LN_PropertyV2.file_search_autokey;
	export	ak_typeStr									:=	'\'AK\'';
	export	ak_skipSet									:=	[];
	
	// boolean search
	export	STRING		stem							:=	Data_Services.Data_location.Prefix()+'thor_data400';
	export	STRING		srcType 					:=	'ln_propertyv2';
	export	STRING		srcTypeFastProp		:=	'property_fast';
	export	STRING		qual							:=	'test';
	export	STRING		dateSegName				:=	'process-date';
	export	UNSIGNED2	alertSWDays				:=	31;
	export	STRING		fileVerEnvVarName :=	'bool_property_file_version';
	
	export	PARTY_TYPE	:=
	MODULE
		export	unsigned1	NONE						:=	0;// NO PARTY TYPE
		export	unsigned1	OWNER						:=	1;
		export	unsigned1	BORROWER				:=	2;
		export	unsigned1	SELLER					:=	4;
		export	unsigned1	CARE_OF					:=	8;
		export	unsigned1	PROPERTY				:=	16;
		export	unsigned1	ALL_PARTY_TYPES	:=	31;
	END;
	
	export	RECORD_TYPE	:=
	MODULE
		export	STRING	ASSESSMENT	:=	'A'; 
		export	STRING	DEED				:=	'D';  
		export	STRING	MORTGAGE		:=	'M';  
	END;
	
	export	maxRecsByOwnership	:=	100;

	// Lookup constants
	export	Lookups	:=
	module
		export	Rights				:=	['CP','CT','EA','ES','EU','FM','IR','JS','JT','JV','LE','LV','RS','RT','TC','TE','TR','TS'];
		export	Relationships	:=	['AK','CO','DB','EX','FK','GV','HH','HW','MI','MM','MW','PA','SM','SO','SW','TN','WD'];
	end;
	
	export	ASSIGN_RELS	:=
	MODULE	
		export Assignments_Record_Type := 'Z';
		export Releases_Record_Type := 'P';
		export Assignments_HI_MN_Record_Type := 'M';
		export Releases_HI_MN_Record_Type := 'Q';
		
	END;
	
	EXPORT setAssignRelsRecordTypes := [ASSIGN_RELS.Assignments_Record_Type, ASSIGN_RELS.Releases_Record_Type, ASSIGN_RELS.Assignments_HI_MN_Record_Type, ASSIGN_RELS.Releases_HI_MN_Record_Type];
	
	export	SOURCE_CD_PARTY_TP	:=
	MODULE	
		export Owner := 'O';
		export Seller := 'S';
		export Borrower := 'B';
	END;
	
end;
