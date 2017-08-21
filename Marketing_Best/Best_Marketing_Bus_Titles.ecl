import Business_Header, doxie,paw,mdr;

export Best_Marketing_Bus_Titles(
	 Dataset(marketing_best.layout_best												) mb_base
	,String																											fileDesc
	,dataset(paw.layout.Employment_Out												) pPawBase								= paw.File_Base
	,dataset(layouts.bustitle_standard_tbl										) pBusTitle_Standard_Tbl 	= File_BusTitle_Standard_Tbl
	,string																											pPersistName						= '~thor_data400::persist::Marketing_Best::Best_Marketing_Bus_Titles.'
) :=
function

dis_mb_base := distribute(mb_base, hash32(bdid));

paw_base := Business_Header.filters.keys.peopleatwork(pPawBase((integer)did != 0 and (integer)bdid != 0));

dis_paw_base := distribute(paw_base, hash32((unsigned6)bdid));

layout_out := Marketing_Best.Layout_Marketing_Title;
layout_temp := 
record
	layout_out;
	string from_hdr;
	string vendor_id;

end;

layout_temp trfBusTitles(dis_paw_base l, dis_mb_base r) := transform
	self.bdid    			 := r.bdid;
	self.did     			 := (unsigned6)l.did;
	self.dt_last_seen        := (integer)l.dt_last_seen;
	self.company_title       := l.company_title;
	self.title               := l.title;
	self.fname               := l.fname;
	self.mname               := l.mname;
	self.lname               := l.lname;
	self.name_suffix         := l.name_suffix;
	self.source 			 := l.source;
	self.decision_maker_flag := '';
	self											:= l;
end;

ds_bus_titles := join(dis_paw_base, dis_mb_base,  
										  (unsigned6)left.bdid = right.bdid,
											trfBusTitles(left,right),local);

dis_bus_titles := distribute(ds_bus_titles(
	not (			MDR.sourceTools.SourceIsYellow_Pages					(source)
				or	MDR.sourceTools.SourceIsEBR										(source)
				or	MDR.sourceTools.SourceIsBusiness_Registration	(source)
				or	MDR.sourceTools.SourceIsDCA										(source)
				or	MDR.sourceTools.SourceIsINFOUSA_ABIUS_USABIZ	(source)
	)
), hash32(bdid,did));

// dedup history did records and keep the latest for a did.
srt_dis_bus_title := dedup(sort(dis_bus_titles, bdid, did, -dt_last_seen, local),bdid, did, local);
											
st_file := dedup(sort(pBusTitle_Standard_Tbl(trim(std_company_title,left,right) <> '')
                 ,company_title),company_title);
						
layout_temp trfTitleStd(srt_dis_bus_title l, st_file r) := transform
	self.company_title       := trim(r.std_company_title,left,right);
	self.decision_maker_flag := if(trim(r.owner,left,right) <> '' and trim(r.bus_decision_maker,left,right) <> '', 'V',
	                              if(trim(r.owner,left,right) <> '' and trim(r.bus_decision_maker,left,right) = '', 'O',
								    if(trim(r.owner,left,right) = '' and trim(r.bus_decision_maker,left,right) <> '', 'B','')));
	self := l;
end;

ds_std_bus_title := join(srt_dis_bus_title, st_file,
						 trim(left.company_title,left,right) = trim(right.company_title,left,right),
						 trfTitleStd(left,right),lookup);

ds_std_bus_title_not_prop_old_codes := project(ds_std_bus_title
	,transform(
		 layout_out
			,self					:= left;
	)
);

returnds := ds_std_bus_title_not_prop_old_codes
				: persist(pPersistName + fileDesc);
				
return returnds;

end;