import Gong,Gong_v2, CellPhone, Address, ut;

export map_LSSasGong(infile,fileno,outfile) := macro
#uniquename(rawUpdate)
%rawUpdate% := infile(regexfind('[0-9]',recordID));

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Add Sequence Number and add temp fields to prep for: 
//		address cleaning
//		caption propogation and 
//		name cleaning
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#uniquename(temp_layout)
#uniquename(t_rawUpdate)
%temp_layout% := record
string		temp_hseno:='';
string		temp_hsesx:='';
string		temp_strt:='';

string 		temp_address1:= '';
string 		temp_address2:= '';

string		temp_cap1:='';
string     	temp_cap2:='';
string     	temp_cap3:='';
string     	temp_cap4:='';
string     	temp_cap5:='';
string     	temp_cap6:='';
string     	temp_cap7:='';

string5     name2_prefix:= '';
string20    name2_first:= '';
string20    name2_middle:= '';
string20    name2_last:= '';
string5     name2_suffix:= '';

string	    precleanName1:= '';
string	    precleanName2:= '';
string	    cleanName:= '';
string	    cleanName2:= '';

Gong_v2.layout_gongMaster;
end; 


%temp_layout% %t_rawUpdate%(%rawUpdate% L, integer C) := transform

#uniquename(isheader)
#uniquename(isSubHdr2dtl)
#uniquename(p_seqUpdate)
%isheader%				:= L.xcode='I' and L.lststy='8' and L.indent='0';
%isSubHdr2dtl%			:= L.xcode='I' and L.lststy='2' and L.indent > '1';

self.sequence_number 	:= c;
self.RecordID    		:= stringlib.stringfilter(stringlib.stringtouppercase(l.RecordID),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
self.SeisintID  		:= map(%isheader%  => stringlib.stringfilter(stringlib.stringtouppercase(l.RecordID),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),'');
self.temp_hseno			:= map(%isSubHdr2dtl% => L.hseno,'');
self.temp_hsesx			:= map(%isSubHdr2dtl% => L.hsesx,'');
self.temp_strt			:= map(%isSubHdr2dtl% => L.strt ,'');
self.filedate	 		:= '200' + fileno[1..5] + '_' + fileno[6..7];
self.ven_reg			:= stringlib.stringfilter(L.ven_reg,'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
self.special_listing_txt:= stringlib.stringtouppercase(L.spltx);
self.fsn				:= stringlib.stringtouppercase(L.fsn);
self := L;
end;
%p_seqUpdate% := project(%rawUpdate%, %t_rawUpdate%(left,counter));

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Seperate Adds and Deletes
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#uniquename(deletes)
%deletes%	:= %p_seqUpdate%(xcode = 'O');

#uniquename(adds)
%adds%		:= %p_seqUpdate%(xcode = 'I');

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Group and Propogate Seisint ID for IN's
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#uniquename(g_adds)
#uniquename(t_propID)
#uniquename(preppedUpdate)
%g_adds%:= group(%adds%,fsn);

//Add Header recID to each detail record
%temp_layout% %t_propID%(%g_adds% L, %g_adds% R, integer c) := transform

self.SeisintID	    := map(L.SeisintID !='' => L.SeisintID, R.SeisintID);
self := R;
end;

%preppedUpdate% := iterate(%g_adds%,%t_propID%(left,right,counter));

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Ungroup and Create Captions for IN's
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#uniquename(ungroupUpdate)
#uniquename(icaps)
#uniquename(concatCaps)

%ungroupUpdate% := ungroup(%preppedUpdate%);

%ungroupUpdate%  %concatCaps%(%ungroupUpdate% L,%ungroupUpdate% R ) := transform

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

%iCaps% := iterate(%ungroupUpdate%,%concatCaps%(left,right));

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Clean Names and Addresses then Map to Common
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////				

#uniquename(t_addr)
#uniquename(isSubHdr2dtl)
#uniquename(p_temp)
%iCaps% %t_addr%(%iCaps%  L) := transform

%isSubHdr2dtl%			:= L.lststy='2'  and L.indent > '1';

self.hseno 				:= if(%isSubHdr2dtl%	,L.temp_hseno, L.hseno);
self.hsesx 				:= if(%isSubHdr2dtl%	,L.temp_hsesx, L.hsesx);
self.strt  				:= if(%isSubHdr2dtl%	,L.temp_strt , L.strt );

self.temp_address1 		:= map(L.hseno = '' and
							   L.hsesx = '' and 
							   L.strt  = '' and 
							   L.orig_hseno = '' and
							   L.orig_hsesx = '' and 
							   L.orig_strt  = '' => L.dirtx,//if both vendor_cleaned and orig addr fields are blank clean dirtx
							   if(L.hseno != '',L.hseno,L.orig_hseno) + ' ' + L.hsesx + ' ' + if(L.strt != '',L.strt,L.orig_strt));
							   //if vendor cleaned fields are blank use orig fields
self.temp_address2 		:= L.locnm + ' ' + L.state+' '+ L.zip;
self := L;
end;

%p_temp% := project(distribute(%iCaps%,hash(sequence_number)), %t_addr%(left)); 

#uniquename(temp_address1)
#uniquename(temp_address2)
#uniquename(appndAddr)
#uniquename(newfile)
#uniquename(t_seqUpdate)
#uniquename(p_appndAddr)
Address.MAC_Address_Clean(%p_temp%,temp_address1,temp_address2,true,%appndAddr%);	

%newfile% := %appndAddr%;						

%temp_layout% %t_seqUpdate%(%newfile% input) := transform

self.bell_id	 			:= 'LSS';
self.SeisintID				:= map(input.SeisintID !='' => input.SeisintID,input.RecordID);//fill in straightline rec seisintID
//-------------------------------------------------------------------------------

set_typeBus 				:= ['4','5','7'];
set_typeRes					:= ['1','5','7'];
set_typeGov					:= ['6','7'];
isResidence					:= input.split in set_typeRes;
isResBus					:= input.split in set_typeRes and input.split in set_typeBus;
isBus						:= input.split in set_typeBus; 

self.listing_type_bus		:= map(input.split in set_typeBus => 'B',
								   input.split in set_typeGov => 'B','');
self.listing_type_res		:= map(input.split in set_typeRes => 'R','');
self.listing_type_gov		:= map(input.split in set_typeGov => 'G','');

//-------------------------------------------------------------------------------

set_nonPub 					:= ['3','4','5','7','8','9'];
set_unlisted 				:= ['2','6'];
set_pub 					:= ['0','1'];

self.publish_code			:= map(input.nstel = 'NP' and regexfind('[1-9]',input.telno) => 'N',
							   input.lsttyp in set_nonPub => 'N',
							   input.lsttyp in set_unlisted => 'U',
							   input.lsttyp in set_pub => 'P','');
							   
//-------------------------------------------------------------------------------
set_X 						:= ['0']; //straight line listing
set_S						:= ['1','2','3']; // straight line indent header
set_C 						:= ['6','7','8','9']; //caption set header
self.style_code				:= map(input.lststy in set_X => 'X',
							   input.lststy in set_S => 'S',
							   input.lststy in set_C => 'C','');
self.indent_code			:= input.indent;
self.caption_text	    	:= stringlib.stringtouppercase(
							   if(input.temp_cap1 = '','',input.temp_cap1)+
							   if(input.temp_cap2 = '','','|'+input.temp_cap2)+
							   if(input.temp_cap3 = '','','|'+input.temp_cap3)+
							   if(input.temp_cap4 = '','','|'+input.temp_cap4)+
							   if(input.temp_cap5 = '','','|'+input.temp_cap5)+
							   if(input.temp_cap6 = '','','|'+input.temp_cap6)+
							   if(input.temp_cap7 = '','','|'+input.temp_cap7));
//-------------------------------------------------------------------------------

CleanPhone					:= CellPhone.CleanPhones(input.npa + input.telno);	
self.phone10				:= if(self.publish_code = 'N','',
							   if(CleanPhone[4..10]= '0000000','',CleanPhone));

//-------------------------------------------------------------------------------

self.group_id				:= self.SeisintID;

self.omit_address			:= if(regexfind('1',input.privacy),'Y','N');
self.omit_phone				:= if(regexfind('3',input.privacy),'Y','N');
self.omit_locality			:= if(regexfind('2',input.privacy),'Y','N');

//-------------------------------------------------------------------------------


AddlAddr := input.hseno = '' and
			input.hsesx = '' and 
			input.strt  = '' and 
			input.orig_hseno = '' and
			input.orig_hsesx = '' and 
			input.orig_strt  = '' ; /*if both vendor_cleaned and orig addr fields are blank clean dirtx is checked for additional addresses.  
				                   Now that these addt'l addrs have been cleaned the err_stat field will be used 
								   to determine if they should be used or not*/

temp_prim_range 			:= input.clean[1..10]; 
temp_predir 				:= input.clean[11..12];					   
temp_prim_name 				:= input.clean[13..40];
temp_suffix 				:= input.clean[41..44];
temp_postdir 				:= input.clean[45..46];
temp_unit_desig 			:= input.clean[47..56];
temp_sec_range 				:= input.clean[57..64];

self.p_city_name 			:= input.clean[65..89];
self.v_city_name 			:= input.clean[90..114];
self.st 					:= if(input.clean[115..116]='',ziplib.ZipToState2(input.clean[117..121]),
								input.clean[115..116]);

self.z5 					:= input.clean[117..121];
self.z4 					:= input.clean[122..125];
self.cart 					:= input.clean[126..129];
self.cr_sort_sz 			:= input.clean[130];//need to switch for moxie
self.privacy_flag 			:= if(stringlib.stringfilterout(input.privacy,' 123') = '','N','Y');//need to switch for moxie
self.lot 					:= input.clean[131..134];
self.lot_order 				:= input.clean[135];
self.dpbc 					:= input.clean[136..137];
self.chk_digit 				:= input.clean[138];
self.rec_type 				:= input.clean[139..140];
self.county_code			:= input.clean[141..145];
self.geo_lat 				:= input.clean[146..155];
self.geo_long 				:= input.clean[156..166];
self.msa 					:= input.clean[167..170];
self.geo_blk 				:= input.clean[171..177];
self.geo_match 				:= input.clean[178];
self.err_stat 				:= input.clean[179..182];

self.prim_range 			:= if(AddlAddr,if(self.err_stat[1]= 'S',temp_prim_range,''),temp_prim_range);
self.predir 				:= if(AddlAddr,if(self.err_stat[1]= 'S',temp_predir,''),temp_predir);					   
self.prim_name 				:= if(AddlAddr,if(self.err_stat[1]= 'S',temp_prim_name,''), temp_prim_name);
self.suffix 				:= if(AddlAddr,if(self.err_stat[1]= 'S',temp_suffix,''),temp_suffix);
self.postdir 				:= if(AddlAddr,if(self.err_stat[1]= 'S',temp_postdir,''),temp_postdir);
self.unit_desig 			:= if(AddlAddr,if(self.err_stat[1]= 'S',temp_unit_desig ,''),temp_unit_desig);
self.sec_range 				:= if(AddlAddr,if(self.err_stat[1]= 'S',temp_sec_range ,''),temp_sec_range);

//-------------------------------------------------------------------------------

self.precleanName1        	:= map(length(input.lstnm) = 1 and input.lstnm[1] = input.lstgn[1] => input.lstgn,
									 trim(input.lstnm,left,right) + ' ' + trim(input.lstgn,left,right));

self.precleanName2        	:= map(isResidence and regexfind('&',input.lstgn) and CellPhone.func_is_company(input.preCleanName1) = '' => 
									 trim(input.lstnm,left,right) + ' ' + trim(input.lstgn[StringLib.StringFind(input.lstgn,'&',1)+1.. length(input.lstgn)],left,right),
									 '');

self.CleanName				:= map(isResBus and CellPhone.func_is_company(self.preCleanName1) = '' => Address.CleanPersonLFM73(self.precleanName1),
									isResBus and CellPhone.func_is_company(self.preCleanName1) != '' =>'',
									isResidence => Address.CleanPersonLFM73(self.precleanName1),'');

self.CleanName2				:= Address.CleanPersonLFM73(self.precleanName2);


self.name_prefix			:= self.CleanName[1..5];
self.name_first				:= self.CleanName[6..25];
self.name_middle			:= self.CleanName[26..45];
self.name_last				:= self.CleanName[46..65];
self.name_suffix 			:= self.CleanName[66..70];

self.name2_prefix			:= self.CleanName2[1..5];
self.name2_first			:= self.CleanName2[6..25];
self.name2_middle			:= self.CleanName2[26..45];
self.name2_last				:= self.CleanName2[46..65];
self.name2_suffix 			:= self.CleanName2[66..70];

self.company_name			:= stringlib.stringtouppercase(self.precleanname1);
self.dual_name_flag			:= if(self.name2_last != '','Y','N');
self						:= input; 

end;

%p_appndAddr% := project(%newfile%,%t_seqUpdate%(left));



#uniquename(nodualNames)
#uniquename(t_nodualNames)
#uniquename(p_nodualNames)
//Flag Records w/ Dual Names
//------------------------------------------------------------------------------
%nodualNames% := %p_appndAddr%(dual_name_flag = 'N');
Gong_v2.layout_DailyAdditions %t_nodualNames%(%nodualNames% input) := transform

self := input;
end;

%p_nodualNames% := project(%nodualNames%,%t_nodualNames%(left));
//Normalize Dual Names
//------------------------------------------------------------------------------

#uniquename(dualNames)
#uniquename(t_dualNames)
#uniquename(n_dualNames)
#uniquename(cleanUpdate)
%dualNames%   := %p_appndAddr%(dual_name_flag = 'Y');

Gong_v2.layout_DailyAdditions %t_dualNames%(%dualNames% l, unsigned1 cnt) := transform

//normalize name
self.name_prefix 			:= choose(cnt,l.name_prefix,l.name2_prefix);
self.name_first 			:= choose(cnt,l.name_first,l.name2_first);
self.name_middle  			:= choose(cnt,l.name_middle,l.name2_middle);
self.name_last 				:= choose(cnt,l.name_last,l.name2_last);
self.name_suffix  			:= choose(cnt,l.name_suffix,l.name2_suffix);



self := l;
end;


%n_dualNames% := normalize(%dualNames%, 2, %t_dualNames%(left, counter));
%cleanUpdate% := sort(%n_dualnames% + %p_nodualNames%,sequence_number,local);

//Group and Propogate group id 
//==================================================================================================
#uniquename(g_cleanUpdate)
#uniquename(i_cleanUpdate)
#uniquename(u_cleanUpdate)
#uniquename(t_propseq)
%g_cleanUpdate%:= group(%cleanUpdate%,seisintid);

%g_cleanUpdate% %t_propseq%(%g_cleanUpdate% L, %g_cleanUpdate% R, integer c) := transform

self.group_seq				:= (string10)c;
self := R;
end;

%i_cleanUpdate% := iterate(%g_cleanUpdate%,%t_propseq%(left,right,counter));
%u_cleanUpdate% := ungroup(%i_cleanUpdate%);

outfile:=
 sequential(
			 output(%deletes%,,Gong_v2.thor_cluster +'out::' + fileno[1..5] + '_' + fileno[6..7]+ '::lss_deletions' ,overwrite),
			 output(sort(%u_cleanUpdate%,recordid),,Gong_v2.thor_cluster+'out::' + fileno[1..5] + '_' + fileno[6..7]+ '::lss_clean_additions',overwrite);
			 output(enth(%u_cleanUpdate%,100),named('PreProcessDataSample')),

			 FileServices.StartSuperFileTransaction(),
			 FileServices.AddSuperFile(Gong_v2.thor_cluster +'base::gongv2_daily_deletions_building',
									   Gong_v2.thor_cluster +'out::' + fileno[1..5] + '_' + fileno[6..7]+ '::lss_deletions', 
		                               ,,),
			 FileServices.AddSuperFile(Gong_v2.thor_cluster +'base::gongv2_daily_additions_building',
									   Gong_v2.thor_cluster+'out::' + fileno[1..5] + '_' + fileno[6..7]+ '::lss_clean_additions', 
		                               ,,),
			 FileServices.sendemail('qualityassurance@seisint.com; camaral@seisint.com; tavella@seisint.com; kdavis@seisint.com; sbraze@seisint.com'
										,'Gong v2: DAILY ORIG SAMPLE READY','at ' + thorlib.WUID()),
             FileServices.FinishSuperFileTransaction());

endmacro;								 
  





















