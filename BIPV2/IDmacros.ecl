//see also:  Business_Header_SS.MAC_Match_Flex_V2

import ut;

EXPORT IDmacros := 
MODULE

//THIS ADDS AND POPULATES THE FIELD ParentAbovSeleField, which indicates whether the hrchy has a parent above and beyond the current sele
export mac_AddParentAbovSeleField(inf) := 
FUNCTIONMACRO

outrec := record({inf})
	boolean ParentAboveSELE;
end;

p := 
project(
	inf,
	transform(
		outrec,
		self.ParentAboveSELE := left.ultimate_proxid > 0 and left.sele_proxid > 0 and left.ultimate_proxid <> left.sele_proxid;
		self := left
	)
);

return p;

ENDMACRO;


//THIS ADDS BLANK XLINK IDS
export mac_AddBlankXLinkIDs(infileWithoutIDs, OutfileWithXLinkIDs) :=
MACRO

	#uniquename(outrec)
	%outrec% :=  record
		recordof(infileWithoutIDs);
		BIPV2.IDlayouts.l_xlink_ids;
	end;

	OutfileWithXLinkIDs := project(infileWithoutIDs, transform(%outrec%, self := left, self := []));

ENDMACRO;


//THIS REMOVES THE XLINK IDS AND ADDS THE KEY IDS
export xf_xLinkIDsToKeyIDs(infileWithXLinkIDs, OutfileWithKeyIDs) :=
MACRO

	#uniquename(outrec)
	%outrec% := record					
		BIPV2.IDlayouts.l_key_ids;
		recordof(infileWithXLinkIDs) - BIPV2.IDlayouts.l_xlink_ids;  //does this inherit maxsize, etc?
		integer1 fp := 0;	//for platform?
	end;

	OutfileWithKeyIDs := project(infileWithXLinkIDs, transform(%outrec%, self := left, self := []));

ENDMACRO;


//THIS DEFINES THE INDEX FROM AN INFILE WITH XLINK IDS
export mac_IndexWithXLinkIDs(infileWithXLinkIDs, key, logname = '\'\'') :=
MACRO
  #uniquename(inFileWithKeyIDs)
	BIPV2.IDmacros.xf_xLinkIDsToKeyIDs(infileWithXLinkIDs, %inFileWithKeyIDs%)

	Key := 
	index(
		%inFileWithKeyIDs%(UltID > 0),
		{UltID,OrgID,SELEID,ProxID,POWID,EmpID,DotID},
		{%inFileWithKeyIDs%},
		logname
	);

ENDMACRO;


//THIS DEFINES THE INDEX FROM AN INFILE WITH NO IDS - ONLY FOR INDEX DEFINITION FOR INDEX READ	
export mac_IndexWithoutIDs(infileWithoutIDs, key, logname = '') :=
MACRO

	#uniquename(a)
	%a% := 'throw the compiler a bone';
	BIPV2.IDmacros.mac_AddBlankXLinkIDs(infileWithoutIDs, infileWithXLinkIDs)
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(infileWithXLinkIDs, key, logname)

ENDMACRO;




//THIS DOES A KEYED JOIN BASED ON KEYIDS
export mac_IndexFetch2(infileWithIDs0, inKey, outfile, Level, JoinLimit=25000, JoinType=BIPV2.IDconstants.JoinTypes.KeepJoin) := 
MACRO

	import BizLinkFull, AutoKeyI;
  IMPORT BIPV2_Suppression;
	
	infileWithIDs1 :=
	project(
		infileWithIDs0,
		transform(
			BizLinkFull.Process_Biz_Layouts.id_stream_layout,
			self := left,
			self.weight := 0
		)
	);	
	
	infileWithIDs := BizLinkFull.Process_Biz_Layouts.id_stream_complete(infileWithIDs1);
	
	infileWithIDsLeveled :=  //there is a better way to do this i am sure.  at least get the magic contants out of here.
	project(
		infileWithIDs,	
		transform(
			BIPV2.IDlayouts.l_xlink_ids2,
			self.EmpID := 0,
			self.POWID := 0,	//This (as well as outfile join) needs attention before a real POWID fetch can be done
			self.ProxID := 	if(level in bipv2.IDconstants.Set_Fetch_Level_ProxID_And_Down, left.ProxID, 0),
			self.SELEID := 	if(level in bipv2.IDconstants.Set_Fetch_Level_SELEID_And_Down, left.SELEID, 0),
			self.OrgID := 	if(level in bipv2.IDconstants.Set_Fetch_Level_OrgID_And_Down,  left.OrgID, 0),
			self.UltID := left.UltID, //always
			self.UniqueId := left.UniqueID,
			self := []								//blanking out so i can dedup. score and weight
		)
	);

	#uniquename(infileWithIDsLeveled2)
	%infileWithIDsLeveled2% :=
		dedup(sort(distribute(infileWithIDsLeveled, hash32(ultid)), 
		           ultid, orgid, seleid, proxid, powid, empid, uniqueId,local),
		      ultid, orgid, seleid, proxid, powid, empid, uniqueId,local);

	IDsReadyForKeyedJoin := dedup(%infileWithIDsLeveled2%, ultid, orgid, seleid, proxid, powid, empid, local);

	outrec := record	
		unsigned2 fetch_error_code;
		IDsReadyForKeyedJoin.UniqueID;
		inkey;
	end;
	
	outrec xf(IDsReadyForKeyedJoin le, recordof(inkey) ri, unsigned2 ec = 0) := transform	//NEW
		self.fetch_error_code := ec;
		self.UniqueID := le.UniqueID;
		self := ri;
	end;
	
	outrec xfail(IDsReadyForKeyedJoin le, recordof(inkey) ri, unsigned2 ec = 0) := transform	//NEW
		self.fetch_error_code := ec;
		self.UniqueID := le.UniqueID;
		self := [];
	end;

	outfile_Keep := 	//identical to outfile_1 except for last line (and should probably stay that way)
	join(
		IDsReadyForKeyedJoin,
		inKey,
		keyed(left.ultID = right.UltID) and
		keyed(left.OrgID = right.OrgID or left.OrgID = 0, OPT) and			
		keyed(left.SELEID = right.SELEID or left.SELEID = 0, OPT) and			
		keyed(left.ProxID = right.ProxID or left.ProxID = 0, OPT)
		,
		xf(left, right),
		KEEP(JoinLimit)
	);
	
	outfile_LimitTransform :=	//identical to outfile_0 except for last line (and should probably stay that way)
	join(
		IDsReadyForKeyedJoin,
		inKey,
		keyed(left.ultID = right.UltID) and
		keyed(left.OrgID = right.OrgID or left.OrgID = 0, OPT) and			
		keyed(left.SELEID = right.SELEID or left.SELEID = 0, OPT) and			
		keyed(left.ProxID = right.ProxID or left.ProxID = 0, OPT)
		,
		xf(left, right),
		limit(JoinLimit, xfail(left, right, AutoKeyI.errorcodes._codes.TOO_MANY_SUBJECTS))
	);
	
	#uniquename(outfile0)
	%outfile0% := 
	case(
		joinType,
		BIPV2.IDconstants.JoinTypes.LimitTransformJoin	=> outfile_LimitTransform,
		outfile_keep //this is for the default setting of BIPV2.IDconstants.JoinTypes.KeepJoin
	);
	
  #uniquename(outfile1)
	%outfile1% :=
		join(%infileWithIDsLeveled2%, %outfile0%,
		     left.ultID = right.UltID and
		       (left.OrgID = right.OrgID or left.OrgID = 0) and			
		       (left.SELEID = right.SELEID or left.SELEID = 0) and			
		       (left.ProxID = right.ProxID or left.ProxID = 0),
		     transform(recordof(right),
		       self.uniqueId := left.uniqueID,
		       self := right), hash);
           
  outfile:=BIPV2_Suppression.macSuppress(%outfile1%);

ENDMACRO;




//THIS DOES A KEYED JOIN BASED ON KEYIDS
export mac_IndexFetch(infileWithIDs0, inKey, outfile, Level, JoinLimit=25000) := 
MACRO
	infileWithIDs_for2 := project(infileWithIDs0, {infileWithIDs0, unsigned6 UniqueID := 0});		//the v2 macro requires a UniqueID field.  assigning it to zero keeps the old behavior
	BIPV2.IDmacros.mac_IndexFetch2(infileWithIDs_for2, inKey, outfile_from2, Level, JoinLimit);
	outfile := project(outfile_from2, recordof(inKey));																					//the v2 macro returns the UniqueID field, as well as fetch_error_code, so remove them to preserve old behavior

ENDMACRO;





//THIS IS REALLY JUST A PLACEHOLDER TO USE IN THE XLINK MACROS.  I WANT TO CONFIRM THAT THOSE BUILDS SELECTING BIP IDS ARE USING CORRECT LAYOUTS
export mac_SetIDsZero() := 
MACRO
	self.DotID := 0;
	self.DotScore:= 0;
	self.DotWeight:= 0;
	self.EmpID:= 0;
	self.EmpScore:= 0;
	self.EmpWeight:= 0;
	self.POWID:= 0;
	self.POWScore:= 0;
	self.POWWeight:= 0;
	self.ProxID:= 0;
	self.ProxScore:= 0;
	self.ProxWeight:= 0;
	self.OrgID:= 0;
	self.OrgScore:= 0;
	self.OrgWeight:= 0;
	self.UltID:= 0;
	self.UltScore:= 0;
	self.UltWeight:= 0;	
ENDMACRO;

//THIS HELPS THE DATA BUILD DECIDE WHICH RECORDS TO SEND TO XLINK AFTER A PASS THRU SRC MATCHING
export mac_SelectRecordForXLink(infile, outfileTryXlink, outfileSkipXlink) :=
MACRO

#uniquename(try)
//%try% := infile.ProxId = 0 or infile.ProxScore <= 50; //could change, just a starting point
%try% := (integer)infile.bdid = 0; //could change, once source match append process is fixed for BIP ids.

outfileTryXlink 	:= infile(%try%);
outfileSkipXlink 	:= infile(not %try%);

ENDMACRO;

//THESE MACROs CAN BE USED WHEN YOU NEED TO SORT, DEDUP, GROUP, ETC. ON ALL OR JUST THE 
//TOP 3 LINKIDS.
// NOTE: when calling this macro, you will need to add a "#expand(...)" before the actual
// fully qualified macro name or it will sort/dedup/group on the full string below 
// instead of the field names inside the string.
// i.e. use this: sort(ds1,#expand(BIPV2.IDmacros.mac_LIST_ALL_LINKIDS()));
// See the TopBusiness_Services.*Section attributes for examples of how these macros 
// should be used.
export mac_ListAllLinkids := MACRO
    'UltID,OrgID,SELEID,ProxID,PowID,EmpID,DotID'
ENDMACRO;

export mac_ListTop4Linkids := MACRO
    'UltID,OrgID,SELEID,ProxID'
ENDMACRO;

export mac_ListTop3Linkids := MACRO
    'UltID,OrgID,SELEID'
ENDMACRO;

//THESE MACROs CAN BE USED WHEN YOU NEED TO JOIN ON ALL OR JUST THE TOP 3 LINKIDS.
// See the TopBusiness_Services.*Section attributes for examples of how these macros 
// should be used.
export mac_JoinAllLinkids := MACRO
		(left.UltID  = right.UltID  and  
     left.OrgID  = right.OrgID  and 
     left.SELEID = right.SELEID and 
     left.ProxID = right.ProxID and
		 left.PowID  = right.PowID  and
		 left.EmpID  = right.EmpID  and
		 left.DotID  = right.DotID)
ENDMACRO;

export mac_JoinTop3Linkids := MACRO
		(left.UltID  = right.UltID  and  
     left.OrgID  = right.OrgID  and 
     left.SELEID = right.SELEID)
ENDMACRO;

// This macro can be used to join linkids. A parameter can be passed to define the level you want to
// join at. Default is SeleId, 'S'. The setting of the condition to true if zero, matches was added
// to match the keyfetch logic.
export mac_JoinLinkids(FetchLevel='S') := MACRO
		(left.UltID  = right.UltID  and  
     (left.OrgID  = right.OrgID or left.OrgId = 0 or right.OrgID = 0 or FetchLevel in bipv2.IDconstants.Set_Fetch_Level_Above_OrgID) and 
     (left.SeleID = right.SeleID or left.SeleID = 0 or right.SeleID = 0 or FetchLevel in bipv2.IDconstants.Set_Fetch_Level_Above_SELEID) and 
     (left.ProxID = right.ProxID or left.ProxID = 0 or right.ProxID = 0 or FetchLevel in bipv2.IDconstants.Set_Fetch_Level_Above_ProxID) and
		 (left.PowID  = right.PowID or left.PowID = 0 or right.PowID = 0 or FetchLevel in bipv2.IDconstants.Set_Fetch_Level_Above_PowID) and
		 (left.EmpID  = right.EmpID or left.EmpID = 0 or right.EmpID = 0 or FetchLevel in bipv2.IDconstants.Set_Fetch_Level_Above_EmpID) and
		 (left.DotID  = right.DotID or left.DotID = 0 or right.DotID = 0 or FetchLevel in bipv2.IDconstants.Set_Fetch_Level_Above_DotID))
ENDMACRO;

// This macro should be used whenever you have a dataset that includes ProxID values,
// and you want to look up the corresponding hierarchy id values and add them to the
// dataset.  If the hierarchy fields already exist in the dataset the values will be
// assigned in-place, but if not the layout will be widened to accomodate them.
export mac_AppendHierarchyIDs(ds_in, fld_proxid) := functionmacro

	// ** Please call BizLinkFull.Process_Biz_Layouts.id_stream_complete instead
	// ** If updates needed here, please try to make this call BizLinkFull.Process_Biz_Layouts.id_stream_complete

	import BizLinkFull;

	k_hierIDs := BizLinkFull.Process_Biz_Layouts.KeyproxidUp;
	
	l_append := record
		BIPV2.IDlayouts.l_xlink_ids.SELEID;
		BIPV2.IDlayouts.l_xlink_ids.OrgID;
		BIPV2.IDlayouts.l_xlink_ids.UltID;
	end;
	l_in := recordof(ds_in);
	l_out := {l_in or l_append};
	
	l_out tr(ds_in L, k_hierIDs R) := transform
		self.SELEID	:= R.SELEID;
		self.OrgID	:= R.OrgID;
		self.UltID	:= R.UltID;
		self := L;
	end;
	
	return join(ds_in, k_hierIDs, keyed(left.fld_proxid=right.proxid), tr(left,right), left outer, keep(1));
	
endmacro;


END;
