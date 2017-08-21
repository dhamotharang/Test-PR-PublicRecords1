import corp,ut;

export KeyFilters := module

	shared Layout_Corp_Base		:= Corp2.Layout_Corporate_Direct_Corp_Base_expanded;
	shared Layout_Cont_Base		:= Corp2.Layout_Corporate_Direct_Cont_Base_expanded;
	shared Layout_Event_Base	:= Corp2.Layout_Corporate_Direct_Event_Base_expanded;
	shared Layout_Stock_Base	:= Corp2.Layout_Corporate_Direct_Stock_Base_expanded;
	shared Layout_AR_Base			:= Corp2.Layout_Corporate_Direct_AR_Base_expanded;
	
	// These corp keys need to be filtered out of all base files.
	shared KeySet	:=	[	'06-03155932',
											'06-200820510058',
											'06-200620910099',
											'08-20041437399',
											'34-0600349973',
											'34-0600361150',
											'01-037060'
											];

	export Corp(dataset(Layout_Corp_Base) pInput) := function
		lfile		:= pInput(corp_key not in KeySet);
		return	lfile;
	end;
	
	export Cont(dataset(Layout_Cont_Base) pInput) := function
		lfile		:= pInput(corp_key not in KeySet);
		return	lfile;
	end;	
	
	export Events(dataset(Layout_Event_Base) pInput) := function
		lfile		:= pInput(corp_key not in KeySet);
		return	lfile;
	end;
	
	export Stock(dataset(Layout_Stock_Base) pInput) := function
		lfile		:= pInput(corp_key not in KeySet);
		return	lfile;
	end;
	
	export AR(dataset(Layout_AR_Base) pInput) := function
		lfile		:= pInput(corp_key not in KeySet);
		return	lfile;
	end;
	
end;