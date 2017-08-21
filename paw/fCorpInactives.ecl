IMPORT corp2,ut;

/* 	

NOTE:  	The inactive lookup table is a stagnant table & at the time of this process being created, no automated 
				way of re-creating this file was deemed feasible. It requires human intervention to determine what 
				statuses are considered inactive. From time to time it might benefit us to dump all unique description
				values in the corpv2 base file & see if any new inactive ones have been delivered. 

The process for determining inactive Corporations

1.	Sort non zero bdid records from the corps file in bdid (ascending), charter number(ascending), process 
		date (descending), status date (descending) & filing date (descending) order to get the latest corp 
		record for each bdid/charter number combination to the top. 
		
2.	Dedup this sorted record to just get the latest record for each bdid/charter number combination.

3.  Extract (via a join) all 'Inactive' records based upon the inactive description lookup table. Set DeadFlag 
		value to true.
		
4.	Extract (via a join) all 'Active' records based upon not finding the description in the lookup table. Set
		DeadFlag value to false. 

5.	Merge Inactive & Active records together again. 

6.	Sort by bdid & Deadflag...this will put any records that have a false Deadflag value to the top. Dedup by 
		bdid. Any records that have an active charter number withing the bdid group will be retained after the dedup
		by having the false deadflag values sorted to the top. 
		
7.	Filter out & return only those bdids that have a inactive (true) DeadFlag value.
		
*/

//	Inactive Description table 
EXPORT fCorpInactives(

	 dataset(layout.StatusDescLayout								) pInactiveDescFile 				= dataset('~thor_data400::lookup::paw::inactive_desc::table',layout.StatusDescLayout,CSV(SEPARATOR([',']), quote('"'),TERMINATOR(['\r\n'])))
	,dataset(corp2.Layout_Corporate_Direct_Corp_Base) pCorpBase									= corp2.files().base.corp.prod
	,string																						pPersistname							= persistnames().f_CorpInactives
	,boolean																					pShouldRecalculatePersist	= true
)	:= 
function

InactiveDescFile			:=	pInactiveDescFile;

// 	Pull current corporation base file & only look at those that have a bdid
corps									:= 	distribute(pCorpBase(bdid!=0),hash(bdid));

// 	Layout of corps record plus a flag for determining active/inactive.
flagLayout	:=	record
	corp2.Layout_Corporate_Direct_Corp_Base;
	boolean	deadFlag;
end;

// Transform to append a default flag value to the corps record.		
flagLayout	trfAddFlag(corp2.Layout_Corporate_Direct_Corp_Base input)	:= transform
	self.DeadFlag				:=	false;
	self								:= 	input;
end;
																	
FlagAdded							:= 	project(Corps,trfAddFlag(left));

//	Sort to get the latest record for each bdid/charter number to the top for examination 
srtCorps							:= 	dedup(sort(FlagAdded, bdid, corp_orig_sos_charter_nbr, -corp_process_Date, -corp_status_date, -corp_filing_date, local), bdid, corp_orig_sos_charter_nbr,local);

//	Records deemed 'INACTIVE' pass thru this transform.  Flag set to true.
flagLayout trfPopDeadFlag(flagLayout pLeft, layout.StatusDescLayout pRight)	:=	transform
	self.DeadFlag				:= true;
	self								:= pLeft;
end;

//	Records deemed 'ACTIVE' pass thru this transform.  Flag defaults to false.
flagLayout trfPopNotDeadFlag(flagLayout pLeft, layout.StatusDescLayout pRight)	:=	transform
	self								:= pLeft;
end;

//	Extract Inactives
Dead						 			:= join(	srtCorps,
																InactiveDescFile,
																trim(left.corp_status_desc,left,right)=right.StatusDesc,
																trfPopDeadFlag(left,right),
																lookup
															);
															
//	Extract Actives
NotDead								:= join(	srtCorps,
																InactiveDescFile,
																trim(left.corp_status_desc,left,right)=right.StatusDesc,
																trfPopNotDeadFlag(left,right),
																left only,
																lookup
															);

//	Merge back together														
AllRecs								:= Dead + NotDead;			

//	Sort on BDID & deadflag. This will put a false flag (ACTIVE) at the top of any BDID group, so that when 
//	the dedup is performed, if a false flag is present for the bdid group, it will be retained. Extract only
//	INACTIVES (true Deadflag value).
ChkFlag								:= dedup(sort(AllRecs, bdid, deadflag,local),bdid,local)(deadFlag);

// 	Transform back to the original corp layout (remove DeadFlag field)
corp2.Layout_Corporate_Direct_Corp_Base trfBackToCorpsLayout(flagLayout input)	:=	transform
	self								:= input;
end;

dedupOnFlag						:= project(ChkFlag,trfBackToCorpsLAyout(left));

// return dataset of BDIDs for all inactive corps records

resultpersisted := distribute(dedupOnFlag, hash(bdid)):persist(pPersistname);
resultdataset		:= dataset(pPersistname,corp2.Layout_Corporate_Direct_Corp_Base,flat);

result := if(pShouldRecalculatePersist	,resultpersisted
																				,resultdataset
					);
																				

return result;

end;