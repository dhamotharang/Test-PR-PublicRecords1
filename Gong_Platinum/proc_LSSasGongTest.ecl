import Gong,Gong_v2, CellPhone, Address, ut, nid;

export proc_LSSasGongTest(dataset(recordof(Gong_v2.File_Raw_LSS)) infile, string fileno, string histflag = '') := function

rawUpdate := infile(regexfind('[0-9]',recordID));

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Add Sequence Number and add temp fields to prep for: 
//		address cleaning
//		caption propogation and 
//		name cleaning
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

layout_temp_for_daily_raw_processing t_rawUpdate(rawUpdate L, integer C) := transform

isheader				:= L.xcode='I' and L.lststy='8' and L.indent='0';
isSubHdr2dtl			:= L.xcode='I' and L.lststy='2' and L.indent > '1';

self.sequence_number 	:= c;
self.RecordID    		:= stringlib.stringfilter(stringlib.stringtouppercase(l.RecordID),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
self.SeisintID  		:= map(isheader  => stringlib.stringfilter(stringlib.stringtouppercase(l.RecordID),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),'');
self.temp_hseno			:= map(isSubHdr2dtl => L.hseno,'');
self.temp_hsesx			:= map(isSubHdr2dtl => L.hsesx,'');
self.temp_strt			:= map(isSubHdr2dtl => L.strt ,'');
self.filedate	 		:= fileno[1..8] + '_' + fileno[9..10];
self.ven_reg			:= stringlib.stringfilter(L.ven_reg,'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
self.special_listing_txt:= stringlib.stringtouppercase(L.spltx);
self.fsn				:= stringlib.stringtouppercase(L.fsn);
self                    := L;
end;

p_seqUpdate := project(rawUpdate, t_rawUpdate(left,counter));

//Seperate Adds and Deletes
//project back to old temp layout to avoid having to run all the deletes thru the new one
deletes	:= project(p_seqUpdate(xcode='O'),gong_v2.layout_temp_for_daily_raw_processing_old);
adds    := p_seqUpdate(xcode='I');

//Group and Propogate Seisint ID for IN's
g_adds  := group(adds,fsn);

//Add Header recID to each detail record
layout_temp_for_daily_raw_processing t_propID(g_adds L, g_adds R, integer c) := transform
 self.SeisintID := map(L.SeisintID !='' => L.SeisintID, R.SeisintID);
 self           := R;
end;

preppedUpdate := iterate(g_adds,t_propID(left,right,counter));

//Ungroup and Create Captions for IN's
ungroupUpdate := ungroup(preppedUpdate);

layout_temp_for_daily_raw_processing  concatCaps(ungroupUpdate L,ungroupUpdate R ) := transform

 self.temp_cap1 := if(r.indent = '1',r.dirtx,if(r.indent > '1',l.temp_cap1,''));
 self.temp_cap2 := if(r.indent = '2',r.dirtx,if(r.indent > '2',l.temp_cap2,''));
 self.temp_cap3 := if(r.indent = '3',r.dirtx,if(r.indent > '3',l.temp_cap3,''));
 self.temp_cap4 := if(r.indent = '4',r.dirtx,if(r.indent > '4',l.temp_cap4,''));
 self.temp_cap5 := if(r.indent = '5',r.dirtx,if(r.indent > '5',l.temp_cap5,''));
 self.temp_cap6 := if(r.indent = '6',r.dirtx,if(r.indent > '6',l.temp_cap6,''));
 self.temp_cap7 := if(r.indent = '7',r.dirtx,if(r.indent > '7',l.temp_cap7,''));
 
 //Propogate SubHd2 detail records that have addresses
 self.temp_hseno := map(R.temp_hseno != '' and R.lststy = '2' and R.indent > '1'  => R.temp_hseno, L.hseno);
 self.temp_hsesx := map(R.temp_hsesx != '' and R.lststy = '2' and R.indent > '1'  => R.temp_hsesx, L.hsesx);
 self.temp_strt  := map(R.temp_strt  != '' and R.lststy = '2' and R.indent > '1'  => R.temp_strt , L.strt );
 self := R;

end;

iCaps := iterate(ungroupUpdate,concatCaps(left,right));

layout_temp_for_daily_raw_processing t_addr(iCaps  le) := transform

 isSubHdr2dtl:= le.lststy='2'  and le.indent > '1';

 self.hseno := if(isSubHdr2dtl	,le.temp_hseno, le.hseno);
 self.hsesx := if(isSubHdr2dtl	,le.temp_hsesx, le.hsesx);
 self.strt  := if(isSubHdr2dtl	,le.temp_strt , le.strt );
 self       := le;
 
end;

p_temp := project(distribute(iCaps,hash(sequence_number)), t_addr(left)); 

layout_temp_for_daily_raw_processing t_seqUpdate(p_temp le) := transform

 self.bell_id	 			:= 'LSS';
 self.SeisintID				:= map(le.SeisintID !='' => le.SeisintID,le.RecordID);//fill in straightline rec seisintID
 self.group_id				:= self.SeisintID;
 
 set_typeBus 				:= ['4','5','7'];
 set_typeRes				:= ['1','5','7'];
 set_typeGov				:= ['6','7'];
 isResidence				:= le.split in set_typeRes;
 isResBus					:= le.split in set_typeRes and le.split in set_typeBus;
 isBus						:= le.split in set_typeBus; 

 self.listing_type_bus		:= map(le.split in set_typeBus => 'B',
								   le.split in set_typeGov => 'B','');
 self.listing_type_res		:= map(le.split in set_typeRes => 'R','');
 self.listing_type_gov		:= map(le.split in set_typeGov => 'G','');

 set_nonPub 				:= ['3','4','5','7','8','9'];
 set_unlisted 				:= ['2','6'];
 set_pub 					:= ['0','1'];

 self.publish_code			:= map(le.nstel = 'NP' and regexfind('[1-9]',le.telno) => 'N',
							       le.lsttyp in set_nonPub                         => 'N',
							       le.lsttyp in set_unlisted                       => 'U',
							       le.lsttyp in set_pub                            => 'P',
								  '');
							   
 set_X 						:= ['0'];             //straight line listing
 set_S						:= ['1','2','3'];     //straight line indent header
 set_C 						:= ['6','7','8','9']; //caption set header

 self.style_code			:= map(le.lststy in set_X => 'X',
							       le.lststy in set_S => 'S',
							       le.lststy in set_C => 'C',
								   '');
								   
 self.indent_code			:= le.indent;
 self.caption_text	    	:= stringlib.stringtouppercase(
							   if(le.temp_cap1 = '','',le.temp_cap1)+
							   if(le.temp_cap2 = '','','|'+le.temp_cap2)+
							   if(le.temp_cap3 = '','','|'+le.temp_cap3)+
							   if(le.temp_cap4 = '','','|'+le.temp_cap4)+
							   if(le.temp_cap5 = '','','|'+le.temp_cap5)+
							   if(le.temp_cap6 = '','','|'+le.temp_cap6)+
							   if(le.temp_cap7 = '','','|'+le.temp_cap7));

 CleanPhone					:= CellPhone.CleanPhones(le.npa + le.telno);	

 self.phone10				:= if(self.publish_code = 'N' or cleanphone[4..10]='0000000','',cleanphone);

 //self.omit_address			:= if(regexfind('1',le.privacy),'Y','N');
 //self.omit_phone				:= if(regexfind('3',le.privacy),'Y','N');
 //self.omit_locality			:= if(regexfind('2',le.privacy),'Y','N');
 //just because regexfind's are slower
 self.omit_address  := if(stringlib.stringfind(le.privacy,'1',1)>0,'Y','N');
 self.omit_phone    := if(stringlib.stringfind(le.privacy,'3',1)>0,'Y','N');
 self.omit_locality := if(stringlib.stringfind(le.privacy,'2',1)>0,'Y','N');
 
 self.privacy_flag 			:= if(stringlib.stringfilterout(le.privacy,' 123') = '','N','Y');//need to switch for moxie

 precleanName1        	:= fn_NamePreprocess(le.lstnm, le.lstgn, le.ftd, le.split, false);	// for person
	self.precleanName1 := precleanName1;
 precleanName2        	:= fn_NamePreprocess(le.lstnm, le.lstgn, le.ftd, le.split, true);	// for company
 self.precleanName2 := precleanName2;
 self.CleanName				:= precleanName1;

 self.CleanName2			:= precleanName2;

 coname        	:= map(length(le.lstnm)=1 and le.lstnm[1]=le.lstgn[1] => le.lstgn,
								   stringlib.stringcleanspaces(le.lstnm+' '+le.lstgn)
								  );
 self.company_name			:= stringlib.stringtouppercase(coname);
 //self.dual_name_flag		:= if(self.name2_last!='','Y','N');
 self						:= le; 

end;

p_appndAddr := project(p_temp,t_seqUpdate(left));

Nid.Mac_CleanFullNames(p_appndAddr, p_cleanName1, precleanName1,
		_title := name_prefix,	
		_fname := name_first,		
		_mname := name_middle,		
		_lname := name_last,		
		_suffix := name_suffix,	
		_title2 := name2_prefix,	
		_fname2 := name2_first,	
		_mname2 := name2_middle,	
		_lname2 := name2_last,	
		_suffix2 := name2_suffix,	 
		includeInRepository := true, normalizeDualNames := true);

p_cleanName2 := PROJECT(p_cleanName1, TRANSFORM(layout_temp_for_daily_raw_processing,
							self.preppedname := LEFT.precleanName1,
							self.dual_name_flag := IF(Nid.NameIndicators.fn_IsDerivedName(LEFT.name_ind),'Y','N');
							self := LEFT;));
return p_cleanName2;
END;