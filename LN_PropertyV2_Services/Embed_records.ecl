import Suppress;

l_out := LN_PropertyV2_Services.layouts.out_wider;
export dataset(l_out) Embed_records(
	boolean isAssetReport=false,
	dataset(layouts.search_did)		in_dids		= dataset([], layouts.search_did),
	dataset(layouts.search_bdid)	in_bdids	= dataset([], layouts.search_bdid),
	unsigned inMaxProperties = 0,
	dataset(LN_PropertyV2_Services.layouts.parties.pparty) parties = 	dataset([],LN_PropertyV2_Services.layouts.parties.pparty),
	boolean isPeopleWise=false,
	boolean includeBlackKnight=false
) := function

// determine records to display
ids := SearchService_ids(isAssetReport,,in_dids,in_bdids);

// retrieve results
results := LN_PropertyV2_Services.resultFmt.wider_view.get_by_sid(ids,inMaxProperties,TRUE,,,,,, includeBlackKnight);
app_type := IF (isPeopleWise, Suppress.Constants.ApplicationTypes.PeopleWise, '');
Suppress.MAC_Suppress(results,suppress_fares_id,app_type,,,Suppress.Constants.DocTypes.FaresID,ln_fares_id);

//suppress_fares_id sequence
out_rec_suppress := record
	integer seq := 0;
	suppress_fares_id;
end;

out_rec_suppress suppress1(suppress_fares_id l,integer c):=transform
	self.seq := c;
	self := l;
end;
Suppress_faresId:=project(suppress_fares_id,suppress1(left,counter));

//parties
out_rec_party := record
	integer seq := 0;
	parties;
end;

out_rec_party party(parties l,integer c):=transform
	self.seq := c;
	self := l;
end;


//suppress party
suppress_party := Normalize(suppress_fares_id,left.parties,party(right,counter));

//entity
out_rec_entity := record
	integer seq :=0;
	LN_PropertyV2_Services.layouts.parties.entity;
end;
out_rec_entity entity1(LN_PropertyV2_Services.layouts.parties.entity l,integer c):=transform
	self.seq := c;
	self := l;
end;

//suppress entity
suppress_entity := Normalize(suppress_party,left.entity,entity1(right,counter));

//suppress MAC
Suppress.MAC_Suppress(suppress_entity,suppress_bdid,app_type ,Suppress.Constants.LinkTypes.BDID,bdid);//,Suppress.Constants.DocTypes.FaresID,ln_fares_id);  

//denorm party,entity
denormedrec := record
	out_rec_party;
	out_rec_entity;
end;

denormedrec denormthem(out_rec_party l,out_rec_entity r):=transform
	self:=l;
	self:=r;		
end;
denormedrecs:=denormalize(suppress_party,suppress_entity,left.seq=right.seq,group,denormthem(left,right));

//denorm suppress_fares_id,party

denormedrec1 := record
	denormedrec;  		    
	out_rec_suppress;
end;
l_out denormthem1(out_rec_suppress l,denormedrec r):=transform
	self:=l;
	self:=r;			
end;
denormedrecs1:=denormalize(Suppress_faresId,denormedrecs,left.seq=right.seq,group,denormthem1(left,rows(right)));


return if(input.incProp, denormedrecs1);
end;