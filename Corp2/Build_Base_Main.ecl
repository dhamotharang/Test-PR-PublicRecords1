IMPORT Corp2_Mapping, corp2, _validate;

EXPORT Build_Base_Main(STRING 																		 								pversion,
											 DATASET(Corp2.Layout_Corporate_Direct_Corp_Base_expanded)	inCorpBase,
											 DATASET(Corp2.Layout_Corporate_Direct_Cont_Base_expanded)	inContBase,
											 DATASET(Corp2_Mapping.LayoutsCommon.main)									inMainUpdate,
											 DATASET(Corp2.Layout_Corporate_Direct_Event_Base_Expanded) inEventBase,
											 DATASET(Corp2_Mapping.LayoutsCommon.events)								inEventUpdate) := MODULE
											 
	corp2.Layout_Corp_EventDate trfUpdate(Corp2_Mapping.LayoutsCommon.events l)	:=	transform	
		self.corp_key									:=	l.corp_key;
		self.event_filing_date				:=	(unsigned4)fCheckDate(l.event_filing_date);
		self.dt_vendor_first_reported := 	(unsigned4)fCheckDate(l.corp_process_date);
		self.dt_vendor_last_reported	:= 	(unsigned4)fCheckDate(l.corp_process_date);	
	end;
	
	export SlimUpdate		:=	project(inEventUpdate, trfUpdate(left));
	
	corp2.Layout_Corp_EventDate trfBase(Corp2.Layout_Corporate_Direct_Event_Base_Expanded l)	:=	transform
		self.event_filing_date				:=	(unsigned4)fCheckDate(l.event_filing_date);
		self													:=	l;
	end;
	
	export 	SlimBase		:=	project(inEventBase, trfBase(left));
	
	export 	inEvents		:=	dedup(sort(distribute((SlimUpdate + SlimBase)(_validate.date.fIsValid((string)event_filing_date)),hash(corp_key)),corp_key,event_filing_date,dt_vendor_first_reported,dt_vendor_last_reported,local),corp_key,event_filing_date,dt_vendor_first_reported,dt_vendor_last_reported,local);
										 
	export 	prepBases		:=	corp2.PrepAllBases.fAll(inCorpBase, inContBase, inMainUpdate);
	export	MapTheBases	:=	corp2.MapMainBases(prepBases, pversion, inEvents).All;
											 
	export 	All :=	sequential(
															MapTheBases
 								  					 );
	
end;											 