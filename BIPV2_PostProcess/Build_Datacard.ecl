import ut,bipv2,wk_ut,BIPV2_Findlinks,BIPV2_Postprocess,std;
thecurrentdate  := (STRING8)Std.Date.Today();         
highwuid        := 'W' + thecurrentdate + '-999999';

EXPORT Build_DataCard(
   string   pversion  = bipv2.KeySuffix
  ,string20 TheSprint = 'Sprint ' + BIPV2.KeySuffix_mod2.SprintNumber(pversion)//'Sprint 26'
  ,string   the_WU    = trim(sort(wk_ut.get_Running_Workunits('W' + pversion + '-000001',highwuid,'completed')(job = 'BIPV2_PostProcess.proc_segmentation ' + pversion),-wuid)[1].wuid)//'W20150217-055342'

) := Module

//------------------------ID_Segmentation Below---------------------------------------------
 Shared ProxSegmentationStatsV2_rec :={string20 segType, string20 segSubType, unsigned4 total};
 Shared Entity_Count_Rec :={string10 UniqueID, unsigned6 cnt};
 Shared TotalRecordCount_rec :={integer TotalRecordCount};

 Shared TotalRecordCount:=Dataset(WorkUnit(the_WU,'TotalRecordCount'),TotalRecordCount_rec);
 Shared ProxSegmentationStatsV2:=Dataset(WorkUnit(the_WU,'ProxSegmentationStatsV2'),ProxSegmentationStatsV2_rec);
 Shared PowSegmentationStatsV2:=Dataset(WorkUnit(the_WU,'PowSegmentationStatsV2'),ProxSegmentationStatsV2_rec);
 Shared SeleSegmentationStatsV2:=Dataset(WorkUnit(the_WU,'SeleSegmentationStatsV2'),ProxSegmentationStatsV2_rec);
 Shared OrgSegmentationStatsV2:=Dataset(WorkUnit(the_WU,'OrgSegmentationStatsV2'),ProxSegmentationStatsV2_rec);
 Shared Entity_Count:=Dataset(WorkUnit(the_WU,'EntityCount'),Entity_Count_Rec);

 Shared ProxSegmentationStatsV2Prob :=Dataset(WorkUnit(the_WU,'ProxSegmentationStatsV2Probation'),ProxSegmentationStatsV2_rec);
 Shared PowSegmentationStatsV2Prob  :=Dataset(WorkUnit(the_WU,'PowSegmentationStatsV2Probation'),ProxSegmentationStatsV2_rec);
 Shared SeleSegmentationStatsV2Prob :=Dataset(WorkUnit(the_WU,'SeleSegmentationStatsV2Probation'),ProxSegmentationStatsV2_rec);
 Shared OrgSegmentationStatsV2Prob  :=Dataset(WorkUnit(the_WU,'OrgSegmentationStatsV2Probation'),ProxSegmentationStatsV2_rec);
 
 Shared Segmentation_Rec :={string1000 description, string40 cnt};
//------------------------Probation_Segmentation Below--------------------------------------
Shared string100 zz1	:='LexisNexis Risk Solutions - Business Data Profile';
Shared string100 zz2	:='Date: ' + the_WU[2..5] + ' ' + TheSprint;
Shared string100 zz3	:='Date deployed to Production:';
Shared string100 zz4	:='Data fresh as of:';
Shared string100 zz5	:='US Businesses';
Shared string100 zz6	:='Total Records';
Shared string100 zz7	:=' ';
Shared string100 zz8	:='PROXID--LexIDÃ‚Â® Business Place';
Shared string100 zz9	:='Active';
//Shared string100 zz10	:='Tri-Major Sources';
//Shared string100 zz11	:='Dual-Major Sources';
Shared string100 zz12	:='Single Major and/or Single Source w/multiple records';
Shared string100 zz13	:='Single Source w/single record';
Shared string100 zz14	:='Inactive';
//Shared string100 zz15	:='Defunct';
Shared string100 zz16	:='';
Shared string100 zz17	:='SELE--LexIDÃ‚Â® Business Legal Entity';
Shared string100 zz18	:='Active';
//Shared string100 zz19	:='Tri-Major Sources';
//Shared string100 zz20	:='Dual-Major Sources';
Shared string100 zz21	:='Single Major and/or Single Source w/multiple records';
Shared string100 zz22	:='Single Source w/single record';
Shared string100 zz23	:='Inactive';
//Shared string100 zz24	:='Defunct';
Shared string100 zz25	:='Total SELEs from LGID3 Processing';
Shared string100 zz26	:='';
Shared string100 zz27	:='ORGID--LexIDÃ‚Â® Business Legal Family';
Shared string100 zz28	:='Active';
//Shared string100 zz29	:='Tri-Major Sources';
//Shared string100 zz30	:='Dual-Major Sources';
Shared string100 zz31	:='Single Major and/or Single Source w/multiple records';
Shared string100 zz32	:='Single Source w/single record';
Shared string100 zz33	:='Inactive';
//Shared string100 zz34	:='Defunct';
Shared string100 zz35	:='';
Shared string100 zz36	:='ULTID--LexIDÃ‚Â® Business Extended Family';
Shared string100 zz37	:='Active';
//Shared string100 zz38	:='Tri-Major Sources';
//Shared string100 zz39	:='Dual-Major Sources';
Shared string100 zz40	:='Single Major and/or Single Source w/multiple records';
Shared string100 zz41	:='Single Source w/single record';
Shared string100 zz42	:='Inactive';
//Shared string100 zz43	:='Defunct';
Shared string100 zz44	:='';
Shared string100 zz45	:='POWID--LexIDÃ‚Â® Business Place Group';
Shared string100 zz46	:='Active';
//Shared string100 zz47	:='Tri-Major Sources';
//Shared string100 zz48	:='Dual-Major Sources';
Shared string100 zz49	:='Single Major and/or Single Source w/multiple records';
Shared string100 zz50	:='Single Source w/single record';
Shared string100 zz51	:='Inactive';
//Shared string100 zz52	:='Defunct';
//-------------------------------
Shared string20 zn1	:='';
Shared string20 zn2	:=TheSprint;
Shared string20 zn3	:='';

Shared string20 zn4	:=the_WU[2..9]; // Provide the date
Shared string20 zn5	:='';
Shared string20 zn6	:=(string20)TotalRecordCount[1].TotalRecordCount; //Total Records

Shared string20 zn7	:='';
Shared string20 zn8	:='=SUM(B11:B13)'; //=SUM(B10:B15); //need to handle header
Shared string20 zn9	:='=SUM(B11:B12)';// =SUM(B10:B13)
//Shared string20 zn10	:=(string20)ProxSegmentationStatsV2Prob(segtype='CORE', segsubtype='TriCore')[1].total; 		//PROXID Tri-Major Sources
//Shared string20 zn11	:=(string20)ProxSegmentationStatsV2Prob(segtype='CORE', segsubtype='DualCore')[1].total;		//DualCore
Shared string20 zn12	:=(string20)(ProxSegmentationStatsV2Prob(segtype='CORE', segsubtype='TrustedSource')[1].total + 
	                             ProxSegmentationStatsV2Prob(segtype='EMERGINGCORE', segsubtype='TrustedSrcSingleton')[1].total); //TrustedSource + TrustedSrcSingleton
Shared string20 zn13	:=(string20)ProxSegmentationStatsV2Prob(segtype='CORE', segsubtype='SingleSource')[1].total;     //SingleSource
Shared string20 zn14	:=(string20)ProxSegmentationStatsV2Prob(segtype='INACTIVE', segsubtype='NoActivity')[1].total;	//NoActivity
//Shared string20 zn15	:=(string20)ProxSegmentationStatsV2Prob(segtype='INACTIVE', segsubtype='ReportedInactive')[1].total;	//ReportedInactive

Shared string20 zn16	:='';
Shared string20 zn17	:='=SUM(B17:B19)';   //=SUM(B19:B24); //need to handle header
Shared string20 zn18	:='=SUM(B17:B18)';   //=SUM(B19:B22); //need to handle header 
//Shared string20 zn19	:=(string20)SeleSegmentationStatsV2Prob(segtype='CORE', segsubtype='TriCore')[1].total;	//SELEID Tri-Major Sources	
//Shared string20 zn20	:=(string20)SeleSegmentationStatsV2Prob(segtype='CORE', segsubtype='DualCore')[1].total;	//DualCore	
Shared string20 zn21	:=(string20)(SeleSegmentationStatsV2Prob(segtype='CORE', segsubtype='TrustedSource')[1].total + 
                             SeleSegmentationStatsV2Prob(segtype='EMERGINGCORE', segsubtype='TrustedSrcSingleton')[1].total);	//TrustedSource + TrustedSrcSingleton
Shared string20 zn22	:=(string20)SeleSegmentationStatsV2Prob(segtype='CORE', segsubtype='SingleSource')[1].total;		//SingleSource
Shared string20 zn23	:=(string20)SeleSegmentationStatsV2Prob(segtype='INACTIVE', segsubtype='NoActivity')[1].total;	//NoActivity	
//Shared string20 zn24	:=(string20)SeleSegmentationStatsV2Prob(segtype='INACTIVE', segsubtype='ReportedInactive')[1].total;	//ReportedInactive
Shared string20 zn25	:=(string20)Entity_Count(uniqueid='LGID3')[1].cnt;		//Total SELEs from LGID3 Processing
	
Shared string20 zn26	:='';
Shared string20 zn27	:='=SUM(B24:B26)';  //=SUM(B29:B34); //need to handle header 
Shared string20 zn28	:='=SUM(B24:B25)';	//=SUM(B29:B32); //need to handle header 
//Shared string20 zn29	:=(string20)OrgSegmentationStatsV2Prob(segtype='CORE', segsubtype='TriCore')[1].total;			//ORGID Tri-Major Sources
//Shared string20 zn30	:=(string20)OrgSegmentationStatsV2Prob(segtype='CORE', segsubtype='DualCore')[1].total;			//DualCore	
Shared string20 zn31	:=(string20)(OrgSegmentationStatsV2Prob(segtype='CORE', segsubtype='TrustedSource')[1].total + 
					     OrgSegmentationStatsV2Prob(segtype='EMERGINGCORE', segsubtype='TrustedSrcSingleton')[1].total);		//TrustedSource + TrustedSrcSingleton
Shared string20 zn32	:=(string20)OrgSegmentationStatsV2Prob(segtype='CORE', segsubtype='SingleSource')[1].total;		//SingleSource
Shared string20 zn33	:=(string20)OrgSegmentationStatsV2Prob(segtype='INACTIVE', segsubtype='NoActivity')[1].total;	//NoActivity
//Shared string20 zn34	:=(string20)OrgSegmentationStatsV2Prob(segtype='INACTIVE', segsubtype='ReportedInactive')[1].total;		//ReportedInactive

Shared string20 zn35	:='';
Shared string20 zn36	:='=SUM(B30:B32)';	//=SUM(AN38:AN43);//need to handle header
Shared string20 zn37	:='=SUM(B30:B32)';	//=SUM(AN38:AN41);
//Shared string20 zn38	:=''; //ULTID No fill
//Shared string20 zn39	:=''; //ULTID No fill
Shared string20 zn40	:=''; //ULTID No fill
Shared string20 zn41	:=''; //ULTID No fill
Shared string20 zn42	:=''; //ULTID No fill
//Shared string20 zn43	:=''; //ULTID No fill

Shared string20 zn44	:='';
Shared string20 zn45	:='=SUM(B36:B38)';//=SUM(B47:B52);//
Shared string20 zn46	:='=SUM(B36:B37)'; //=SUM(B47:B50);
//Shared string20 zn47	:=(String20)PowSegmentationStatsV2Prob(segtype='CORE', segsubtype='TriCore')[1].total;		//POWID Tri-Major Sources
//Shared string20 zn48	:=(String20)PowSegmentationStatsV2Prob(segtype='CORE', segsubtype='DualCore')[1].total;		//DualCore	
Shared string20 zn49	:=(String20)(PowSegmentationStatsV2Prob(segtype='CORE', segsubtype='TrustedSource')[1].total + 
					     PowSegmentationStatsV2Prob(segtype='EMERGINGCORE', segsubtype='TrustedSrcSingleton')[1].total);		//TrustedSource + TrustedSrcSingleton
Shared string20 zn50	:=(String20)PowSegmentationStatsV2Prob(segtype='CORE', segsubtype='SingleSource')[1].total;	//SingleSource
Shared string20 zn51	:=(String20)PowSegmentationStatsV2Prob(segtype='INACTIVE', segsubtype='NoActivity')[1].total;	//NoActivity
//Shared string20 zn52	:=(String20)PowSegmentationStatsV2Prob(segtype='INACTIVE', segsubtype='ReportedInactive')[1].total;		//ReportedInactive


Shared SegmentationdsProb :=dataset([
   							{zz1,zn1},{zz2,zn2},{zz3,zn3},{zz4,zn4},{zz5,zn5},{zz6,zn6},{zz7,zn7},{zz8,zn8},{zz9,zn9},
								{zz12,zn12},{zz13,zn13},{zz14,zn14},{zz16,zn16},{zz17,zn17},{zz18,zn18},
								{zz21,zn21},{zz22,zn22},{zz23,zn23},{zz25,zn25},{zz26,zn26},{zz27,zn27},{zz28,zn28},
								{zz31,zn31},{zz32,zn32},{zz33,zn33},{zz35,zn35},{zz36,zn36},{zz37,zn37},
								{zz40,zn40},{zz41,zn41},{zz42,zn42},{zz44,zn44},{zz45,zn45},{zz46,zn46},
								{zz49,zn49},{zz50,zn50},{zz51,zn51}
   							],Segmentation_Rec);
								
								
Shared string100 ss1	:='LexisNexis Risk Solutions - Business Data Profile';
Shared string100 ss2	:='Date: ' + the_WU[2..5] + ' ' + TheSprint;
Shared string100 ss3	:='Date deployed to Production:';
Shared string100 ss4	:='Data fresh as of:';
Shared string100 ss5	:='US Businesses';
Shared string100 ss6	:='Total Records';
Shared string100 ss7	:=' ';
Shared string100 ss8	:='PROXID--LexIDÃ‚Â® Business Place';
Shared string100 ss9	:='Active';
Shared string100 ss10	:='Tri-Major Sources';
Shared string100 ss11	:='Dual-Major Sources';
Shared string100 ss12	:='Single Major and/or Single Source w/multiple records';
Shared string100 ss13	:='Single Source w/single record';
Shared string100 ss14	:='Inactive';
Shared string100 ss15	:='Defunct';
Shared string100 ss16	:='';
Shared string100 ss17	:='SELE--LexIDÃ‚Â® Business Legal Entity';
Shared string100 ss18	:='Active';
Shared string100 ss19	:='Tri-Major Sources';
Shared string100 ss20	:='Dual-Major Sources';
Shared string100 ss21	:='Single Major and/or Single Source w/multiple records';
Shared string100 ss22	:='Single Source w/single record';
Shared string100 ss23	:='Inactive';
Shared string100 ss24	:='Defunct';
Shared string100 ss25	:='Total SELEs from LGID3 Processing';
Shared string100 ss26	:='';
Shared string100 ss27	:='ORGID--LexIDÃ‚Â® Business Legal Family';
Shared string100 ss28	:='Active';
Shared string100 ss29	:='Tri-Major Sources';
Shared string100 ss30	:='Dual-Major Sources';
Shared string100 ss31	:='Single Major and/or Single Source w/multiple records';
Shared string100 ss32	:='Single Source w/single record';
Shared string100 ss33	:='Inactive';
Shared string100 ss34	:='Defunct';
Shared string100 ss35	:='';
Shared string100 ss36	:='ULTID--LexIDÃ‚Â® Business Extended Family';
Shared string100 ss37	:='Active';
Shared string100 ss38	:='Tri-Major Sources';
Shared string100 ss39	:='Dual-Major Sources';
Shared string100 ss40	:='Single Major and/or Single Source w/multiple records';
Shared string100 ss41	:='Single Source w/single record';
Shared string100 ss42	:='Inactive';
Shared string100 ss43	:='Defunct';
Shared string100 ss44	:='';
Shared string100 ss45	:='POWID--LexIDÃ‚Â® Business Place Group';
Shared string100 ss46	:='Active';
Shared string100 ss47	:='Tri-Major Sources';
Shared string100 ss48	:='Dual-Major Sources';
Shared string100 ss49	:='Single Major and/or Single Source w/multiple records';
Shared string100 ss50	:='Single Source w/single record';
Shared string100 ss51	:='Inactive';
Shared string100 ss52	:='Defunct';

//-------------------------------
Shared string20 nn1	:='';
Shared string20 nn2	:=TheSprint;
Shared string20 nn3	:='';

Shared string20 nn4	:=the_WU[2..9]; // Provide the date
Shared string20 nn5	:='';
Shared string20 nn6	:=(string20)TotalRecordCount[1].TotalRecordCount; //Total Records

Shared string20 nn7	:='';
Shared string20 nn8	:='=SUM(B11:B16)'; //=SUM(B10:B15); //need to handle header
Shared string20 nn9	:='=SUM(B11:B14)';// =SUM(B10:B13)
Shared string20 nn10	:=(string20)ProxSegmentationStatsV2(segtype='CORE', segsubtype='TriCore')[1].total; 		//PROXID Tri-Major Sources
Shared string20 nn11	:=(string20)ProxSegmentationStatsV2(segtype='CORE', segsubtype='DualCore')[1].total;		//DualCore
Shared string20 nn12	:=(string20)(ProxSegmentationStatsV2(segtype='CORE', segsubtype='TrustedSource')[1].total + 
	                             ProxSegmentationStatsV2(segtype='EMERGINGCORE', segsubtype='TrustedSrcSingleton')[1].total); //TrustedSource + TrustedSrcSingleton
Shared string20 nn13	:=(string20)ProxSegmentationStatsV2(segtype='CORE', segsubtype='SingleSource')[1].total;     //SingleSource
Shared string20 nn14	:=(string20)ProxSegmentationStatsV2(segtype='INACTIVE', segsubtype='NoActivity')[1].total;	//NoActivity
Shared string20 nn15	:=(string20)ProxSegmentationStatsV2(segtype='INACTIVE', segsubtype='ReportedInactive')[1].total;	//ReportedInactive

Shared string20 nn16	:='';
Shared string20 nn17	:='=SUM(B20:B25)';   //=SUM(B19:B24); //need to handle header
Shared string20 nn18	:='=SUM(B20:B23)';   //=SUM(B19:B22); //need to handle header 
Shared string20 nn19	:=(string20)SeleSegmentationStatsV2(segtype='CORE', segsubtype='TriCore')[1].total;	//SELEID Tri-Major Sources	
Shared string20 nn20	:=(string20)SeleSegmentationStatsV2(segtype='CORE', segsubtype='DualCore')[1].total;	//DualCore	
Shared string20 nn21	:=(string20)(SeleSegmentationStatsV2(segtype='CORE', segsubtype='TrustedSource')[1].total + 
                             SeleSegmentationStatsV2(segtype='EMERGINGCORE', segsubtype='TrustedSrcSingleton')[1].total);	//TrustedSource + TrustedSrcSingleton
Shared string20 nn22	:=(string20)SeleSegmentationStatsV2(segtype='CORE', segsubtype='SingleSource')[1].total;		//SingleSource
Shared string20 nn23	:=(string20)SeleSegmentationStatsV2(segtype='INACTIVE', segsubtype='NoActivity')[1].total;	//NoActivity	
Shared string20 nn24	:=(string20)SeleSegmentationStatsV2(segtype='INACTIVE', segsubtype='ReportedInactive')[1].total;	//ReportedInactive
Shared string20 nn25	:=(string20)Entity_Count(uniqueid='LGID3')[1].cnt;		//Total SELEs from LGID3 Processing
	
Shared string20 nn26	:='';
Shared string20 nn27	:='=SUM(B30:B35)';  //=SUM(B29:B34); //need to handle header 
Shared string20 nn28	:='=SUM(B30:B33)';	//=SUM(B29:B32); //need to handle header 
Shared string20 nn29	:=(string20)OrgSegmentationStatsV2(segtype='CORE', segsubtype='TriCore')[1].total;			//ORGID Tri-Major Sources
Shared string20 nn30	:=(string20)OrgSegmentationStatsV2(segtype='CORE', segsubtype='DualCore')[1].total;			//DualCore	
Shared string20 nn31	:=(string20)(OrgSegmentationStatsV2(segtype='CORE', segsubtype='TrustedSource')[1].total + 
					     OrgSegmentationStatsV2(segtype='EMERGINGCORE', segsubtype='TrustedSrcSingleton')[1].total);		//TrustedSource + TrustedSrcSingleton
Shared string20 nn32	:=(string20)OrgSegmentationStatsV2(segtype='CORE', segsubtype='SingleSource')[1].total;		//SingleSource
Shared string20 nn33	:=(string20)OrgSegmentationStatsV2(segtype='INACTIVE', segsubtype='NoActivity')[1].total;	//NoActivity
Shared string20 nn34	:=(string20)OrgSegmentationStatsV2(segtype='INACTIVE', segsubtype='ReportedInactive')[1].total;		//ReportedInactive

Shared string20 nn35	:='';
Shared string20 nn36	:='=SUM(AN39:AN44)';	//=SUM(AN38:AN43);//need to handle header
Shared string20 nn37	:='=SUM(AN39:AN42)';	//=SUM(AN38:AN41);
Shared string20 nn38	:=''; //ULTID No fill
Shared string20 nn39	:=''; //ULTID No fill
Shared string20 nn40	:=''; //ULTID No fill
Shared string20 nn41	:=''; //ULTID No fill
Shared string20 nn42	:=''; //ULTID No fill
Shared string20 nn43	:=''; //ULTID No fill

Shared string20 nn44	:='';
Shared string20 nn45	:='=SUM(B48:B53)';//=SUM(B47:B52);//
Shared string20 nn46	:='=SUM(B48:B51)'; //=SUM(B47:B50);
Shared string20 nn47	:=(String20)PowSegmentationStatsV2(segtype='CORE', segsubtype='TriCore')[1].total;		//POWID Tri-Major Sources
Shared string20 nn48	:=(String20)PowSegmentationStatsV2(segtype='CORE', segsubtype='DualCore')[1].total;		//DualCore	
Shared string20 nn49	:=(String20)(PowSegmentationStatsV2(segtype='CORE', segsubtype='TrustedSource')[1].total + 
					     PowSegmentationStatsV2(segtype='EMERGINGCORE', segsubtype='TrustedSrcSingleton')[1].total);		//TrustedSource + TrustedSrcSingleton
Shared string20 nn50	:=(String20)PowSegmentationStatsV2(segtype='CORE', segsubtype='SingleSource')[1].total;	//SingleSource
Shared string20 nn51	:=(String20)PowSegmentationStatsV2(segtype='INACTIVE', segsubtype='NoActivity')[1].total;	//NoActivity
Shared string20 nn52	:=(String20)PowSegmentationStatsV2(segtype='INACTIVE', segsubtype='ReportedInactive')[1].total;		//ReportedInactive

// Shared Segmentation_Rec :={string1000 description, string40 cnt};
Shared Segmentationds :=dataset([
   							{ss1,nn1},{ss2,nn2},{ss3,nn3},{ss4,nn4},{ss5,nn5},{ss6,nn6},{ss7,nn7},{ss8,nn8},{ss9,nn9},{ss10,nn10},
								{ss11,nn11},{ss12,nn12},{ss13,nn13},{ss14,nn14},{ss15,nn15},{ss16,nn16},{ss17,nn17},{ss18,nn18},{ss19,nn19},
								{ss20,nn20},{ss21,nn21},{ss22,nn22},{ss23,nn23},{ss24,nn24},{ss25,nn25},{ss26,nn26},{ss27,nn27},{ss28,nn28},
								{ss29,nn29},{ss30,nn30},{ss31,nn31},{ss32,nn32},{ss33,nn33},{ss34,nn34},{ss35,nn35},{ss36,nn36},{ss37,nn37},
								{ss38,nn38},{ss39,nn39},{ss40,nn40},{ss41,nn41},{ss42,nn42},{ss43,nn43},{ss44,nn44},{ss45,nn45},{ss46,nn46},
								{ss47,nn47},{ss48,nn48},{ss49,nn49},{ss50,nn50},{ss51,nn51},{ss52,nn52}
   							],Segmentation_Rec);
   
   
   //output(Segmentationds, named('ID_Segmentation'));
// -----------------------------------------------------------------Data Fill Rates Below-----------------------------



Shared Rec :={Unsigned8 countgroup,Unsigned1 nogrouping,Unsigned8 proxid,Unsigned8 rcid,Unsigned8 source,Unsigned8 ingest_status,Unsigned8 dotid,
Unsigned8 empid,Unsigned8 powid,Unsigned8 seleid,Unsigned8 lgid3,Unsigned8 orgid,Unsigned8  ultid,Unsigned8 vanity_owner_did, 
Unsigned8 cnt_rcid_per_dotid, Unsigned8 cnt_dot_per_proxid, Unsigned8  cnt_prox_per_lgid3, Unsigned8 cnt_prox_per_powid, 
Unsigned8 cnt_dot_per_empid, Unsigned8 has_lgid,
Unsigned8 is_sele_level, Unsigned8 is_org_level, Unsigned8 is_ult_level, Unsigned8 parent_proxid,Unsigned8 sele_proxid, Unsigned8 org_proxid, 
Unsigned8 ultimate_proxid,Unsigned8 levels_from_top, Unsigned8 nodes_below, Unsigned8 nodes_total, Unsigned8 sele_gold, Unsigned8 ult_seg,
Unsigned8 org_seg, Unsigned8 sele_seg, Unsigned8 prox_seg,Unsigned8 pow_seg, Unsigned8 ult_prob,Unsigned8 org_prob, Unsigned8 sele_prob,
Unsigned8 prox_prob, Unsigned8 pow_prob, Unsigned8 iscontact, Unsigned8 title, Unsigned8 fname, Unsigned8 mname, Unsigned8 lname, 
Unsigned8 name_suffix,Unsigned8 name_score, Unsigned8 iscorp, Unsigned8 company_name, Unsigned8 company_name_type_raw, 
Unsigned8 company_name_type_derived, Unsigned8 cnp_hasnumber, Unsigned8 cnp_name,Unsigned8 cnp_number, Unsigned8 cnp_store_number, 
Unsigned8 cnp_btype, Unsigned8 cnp_component_code,Unsigned8 cnp_lowv, Unsigned8 cnp_translated, Unsigned8 cnp_classid,Unsigned8 company_rawaid, 
Unsigned8 company_aceaid,Unsigned8 prim_range,Unsigned8 prim_range_derived, Unsigned8 predir, Unsigned8 prim_name, Unsigned8 prim_name_derived,Unsigned8 addr_suffix, 
Unsigned8 postdir, Unsigned8 unit_desig,Unsigned8 sec_range,Unsigned8 p_city_name, Unsigned8 v_city_name,Unsigned8 st,Unsigned8 zip, 
Unsigned8 zip4,Unsigned8 cart,Unsigned8 cr_sort_sz, Unsigned8 lot, Unsigned8 lot_order,Unsigned8 dbpc,Unsigned8 chk_digit, Unsigned8 rec_type, 
Unsigned8 fips_state,Unsigned8 fips_county,Unsigned8 geo_lat, Unsigned8 geo_long, Unsigned8 msa, Unsigned8 geo_blk, Unsigned8 geo_match, 
Unsigned8 err_stat,Unsigned8 corp_legal_name,Unsigned8 dba_name, Unsigned8 active_duns_number, Unsigned8 hist_duns_number,
Unsigned8 deleted_key, Unsigned8 deleted_fein, /*Newly added ????????? !!!!!!!!!!!!!!!  W20160503-114312 */
Unsigned8 active_enterprise_number, Unsigned8 hist_enterprise_number,Unsigned8 ebr_file_number, Unsigned8 active_domestic_corp_key,
Unsigned8 hist_domestic_corp_key, Unsigned8 foreign_corp_key, Unsigned8 unk_corp_key,Unsigned8 dt_first_seen, Unsigned8 dt_last_seen, 
Unsigned8 dt_vendor_first_reported,Unsigned8 dt_vendor_last_reported, Unsigned8 company_bdid, Unsigned8 company_address_type_raw, 
Unsigned8 company_fein, Unsigned8 best_fein_indicator, Unsigned8 company_phone, Unsigned8 phone_type, Unsigned8 company_org_structure_raw, 
Unsigned8 company_incorporation_date, Unsigned8 company_sic_code1, Unsigned8 company_sic_code2, Unsigned8 company_sic_code3, 
Unsigned8 company_sic_code4, Unsigned8 company_sic_code5, Unsigned8 company_naics_code1, Unsigned8 company_naics_code2, Unsigned8 company_naics_code3, 
Unsigned8 company_naics_code4, Unsigned8 company_naics_code5, Unsigned8 company_ticker, Unsigned8 company_ticker_exchange, 
Unsigned8 company_foreign_domestic, Unsigned8 company_url, Unsigned8 company_inc_state, Unsigned8 company_charter_number, 
Unsigned8 company_filing_date, Unsigned8 company_status_date, Unsigned8 company_foreign_date, Unsigned8 event_filing_date, 
Unsigned8 company_name_status_raw, Unsigned8 company_status_raw, Unsigned8 dt_first_seen_company_name, Unsigned8 dt_last_seen_company_name, 
Unsigned8 dt_first_seen_company_address,Unsigned8 dt_last_seen_company_address, Unsigned8 vl_id, Unsigned8 current, Unsigned8 source_record_id, 
Unsigned8 phone_score, Unsigned8 duns_number, Unsigned8 source_docid, Unsigned8 dt_first_seen_contact, Unsigned8 dt_last_seen_contact, 
Unsigned8 contact_did, Unsigned8 contact_type_raw, Unsigned8 contact_job_title_raw, Unsigned8 contact_ssn, Unsigned8 contact_dob, 
Unsigned8 contact_status_raw, Unsigned8 contact_email, Unsigned8 contact_email_username, Unsigned8 contact_email_domain, Unsigned8 contact_phone, 
Unsigned8 from_hdr, Unsigned8 company_department, Unsigned8 company_address_type_derived,Unsigned8 company_org_structure_derived, 
Unsigned8 company_name_status_derived, Unsigned8 company_status_derived, Unsigned8 contact_type_derived, Unsigned8 contact_job_title_derived, 
Unsigned8 contact_status_derived, Unsigned8 address_type_derived,	Unsigned8 is_vanity_name_derived

};

Shared  V2FieldStatsActivePROX	 :=Dataset(WorkUnit(the_WU,'V2_FieldStats_Active_PROX'),Rec); 
Shared  V2FieldStatsInactivePROX :=Dataset(WorkUnit(the_WU,'V2_FieldStats_Inactive_PROX'),Rec); 

Shared  V2FieldStatsActivePOW	 :=Dataset(WorkUnit(the_WU,'V2_FieldStats_Active_POW'),Rec); 
Shared  V2FieldStatsInactivePOW	 :=Dataset(WorkUnit(the_WU,'V2_FieldStats_Inactive_POW'),Rec); 

Shared  V2FieldStatsActiveSELE	 :=Dataset(WorkUnit(the_WU,'V2_FieldStats_Active_SELE'),Rec); 
Shared  V2FieldStatsInactiveSELE :=Dataset(WorkUnit(the_WU,'V2_FieldStats_Inactive_SELE'),Rec); 
Shared  V2FieldStatsActiveSELEGold:=Dataset(WorkUnit(the_WU,'V2_FieldStats_Active_SELE_GOLD'),Rec);

Shared  V2FieldStatsActiveORG	 :=Dataset(WorkUnit(the_WU,'V2_FieldStats_Active_ORG'),Rec); 
Shared  V2FieldStatsInactiveORG	 :=Dataset(WorkUnit(the_WU,'V2_FieldStats_Inactive_ORG'),Rec); 
  
Shared string80 u1		:='LexisNexis Risk Solutions - Business Data Profile';
Shared string80 u2		:='Demographics of Current Header and Previous Header Comparison';
Shared string80 u3		:='Date: ' + the_WU[2..9] + ' '+ TheSprint;
Shared string80 u4		:='Header Element';
Shared string80 u5		:='Address';
Shared string80 u6		:='Street';
Shared string80 u7		:='City';
Shared string80 u8		:='State';
Shared string80 u9		:='ZIP';
Shared string80 u10	:='Phone';
Shared string80 u11	:='DBA';
Shared string80 u12	:='';
Shared string80 u13	:='Industry';
Shared string80 u14	:='SIC Primary';
Shared string80 u15	:='NAICS Primary';
Shared string80 u16	:='';
Shared string80 u17	:='Contact';
Shared string80 u18	:='Name';
Shared string80 u19	:='Email';
Shared string80 u20	:='Phone';
Shared string80 u21	:='';
Shared string80 u22	:='Other Content';
Shared string80 u23	:='FEIN';
Shared string80 u24	:='Ticker ';
Shared string80 u25	:='URL';
Shared string80 u26	:='';
//--------------------------------
Shared string40 v1		:='';
Shared string40 v2		:='WU: ' + the_WU;
Shared string40 v3		:='PROXID--LexIDÃ‚Â® Business Place';
Shared string40 v4		:='Active';
Shared string40 v5		:='';
Shared string40 v6		:='=+M7/M27';
Shared string40 v7		:='=+M8/M27';
Shared string40 v8		:='=+M9/M27';
Shared string40 v9		:='=+M10/M27';
Shared string40 v10	:='=+M11/M27';
Shared string40 v11	:='=+M12/M27';
Shared string40 v12	:='';
Shared string40 v13	:='';
Shared string40 v14	:='=+M15/M27';
Shared string40 v15	:='=+M16/M27';
Shared string40 v16	:='';
Shared string40 v17	:='';
Shared string40 v18	:='=+M19/M27';
Shared string40 v19	:='=+M20/M27';
Shared string40 v20	:='=+M21/M27';
Shared string40 v21	:='';
Shared string40 v22	:='';
Shared string40 v23	:='=+M24/M27';
Shared string40 v24	:='=+M25/M27';
Shared string40 v25	:='=+M26/M27';
Shared string40 v26	:='';
// --------------------------------------------
Shared string40 w1		:='';
Shared string40 w2		:='';
Shared string40 w3		:='';
Shared string40 w4		:='Inactive';
Shared string40 w5		:='';
Shared string40 w6		:='=+N7/N27';
Shared string40 w7		:='=+N8/N27';
Shared string40 w8		:='=+N9/N27';
Shared string40 w9		:='=+N10/N27';
Shared string40 w10	:='=+N11/N27';
Shared string40 w11	:='=+N12/N27';
Shared string40 w12	:='';
Shared string40 w13	:='';
Shared string40 w14	:='=+N15/N27';
Shared string40 w15	:='=+N16/N27';
Shared string40 w16	:='';
Shared string40 w17	:='';
Shared string40 w18	:='=+N19/N27';
Shared string40 w19	:='=+N20/N27';
Shared string40 w20	:='=+N21/N27';
Shared string40 w21	:='';
Shared string40 w22	:='';
Shared string40 w23	:='=+N24/N27';
Shared string40 w24	:='=+N25/N27';
Shared string40 w25	:='=+N26/N27';
Shared string40 w26	:='';
//-------------------------------------
Shared string40 e1		:='';
Shared string40 e2		:='';
Shared string40 e3		:='SELE--LexIDÃ‚Â® Business Legal Entity';
Shared string40 e4		:='Active';
Shared string40 e5		:='';
Shared string40 e6		:='=+O7/O27';
Shared string40 e7		:='=+O8/O27';
Shared string40 e8		:='=+O9/O27';
Shared string40 e9		:='=+O10/O27';
Shared string40 e10	:='=+O11/O27';
Shared string40 e11	:='=+O12/O27';
Shared string40 e12	:='';
Shared string40 e13	:='';
Shared string40 e14	:='=+O15/O27';
Shared string40 e15	:='=+O16/O27';
Shared string40 e16	:='';
Shared string40 e17	:='';
Shared string40 e18	:='=+O19/O27';
Shared string40 e19	:='=+O20/O27';
Shared string40 e20	:='=+O21/O27';
Shared string40 e21	:='';
Shared string40 e22	:='';
Shared string40 e23	:='=+O24/O27';
Shared string40 e24	:='=+O25/O27';
Shared string40 e25	:='=+O26/O27';
Shared string40 e26	:='';
//-----------------------------------------
Shared string40 f1		:='';
Shared string40 f2		:='';
Shared string40 f3		:='';
Shared string40 f4		:='Inactive';
Shared string40 f5		:='';
Shared string40 f6		:='=+P7/P27';
Shared string40 f7		:='=+P8/P27';
Shared string40 f8		:='=+P9/P27';
Shared string40 f9		:='=+P10/P27';
Shared string40 f10	:='=+P11/P27';
Shared string40 f11	:='=+P12/P27';
Shared string40 f12	:='';
Shared string40 f13	:='';
Shared string40 f14	:='=+P15/P27';
Shared string40 f15	:='=+P16/P27';
Shared string40 f16	:='';
Shared string40 f17	:='';
Shared string40 f18	:='=+P19/P27';
Shared string40 f19	:='=+P20/P27';
Shared string40 f20	:='=+P21/P27';
Shared string40 f21	:='';
Shared string40 f22	:='';
Shared string40 f23	:='=+P24/P27';
Shared string40 f24	:='=+P25/P27';
Shared string40 f25	:='=+P26/P27';
Shared string40 f26	:='';
// ----- Add Gold -----------
Shared string40 ff1		:='';
Shared string40 ff2		:='';
Shared string40 ff3		:='';
Shared string40 ff4		:='Active Gold';
Shared string40 ff5		:='';
Shared string40 ff6		:='=+Q7/Q27';
Shared string40 ff7		:='=+Q8/Q27';
Shared string40 ff8		:='=+Q9/Q27';
Shared string40 ff9		:='=+Q10/Q27';
Shared string40 ff10	:='=+Q11/Q27';
Shared string40 ff11	:='=+Q12/Q27';
Shared string40 ff12	:='';
Shared string40 ff13	:='';
Shared string40 ff14	:='=+Q15/Q27';
Shared string40 ff15	:='=+Q16/Q27';
Shared string40 ff16	:='';
Shared string40 ff17	:='';
Shared string40 ff18	:='=+Q19/Q27';
Shared string40 ff19	:='=+Q20/Q27';
Shared string40 ff20	:='=+Q21/Q27';
Shared string40 ff21	:='';
Shared string40 ff22	:='';
Shared string40 ff23	:='=+Q24/Q27';
Shared string40 ff24	:='=+Q25/Q27';
Shared string40 ff25	:='=+Q26/Q27';
Shared string40 ff26	:='';


// -----------------------------------------
Shared string40 g1		:='';
Shared string40 g2		:='';
Shared string40 g3		:='ORGID--LexIDÃ‚Â® Business Legal Family';
Shared string40 g4		:='Active';
Shared string40 g5		:='';
Shared string40 g6		:='=+R7/R27';
Shared string40 g7		:='=+R8/R27';
Shared string40 g8		:='=+R9/R27';
Shared string40 g9		:='=+R10/R27';
Shared string40 g10	:='=+R11/R27';
Shared string40 g11	:='=+R12/R27';
Shared string40 g12	:='';
Shared string40 g13	:='';
Shared string40 g14	:='=+R15/R27';
Shared string40 g15	:='=+R16/R27';
Shared string40 g16	:='';
Shared string40 g17	:='';
Shared string40 g18	:='=+R19/R27';
Shared string40 g19	:='=+R20/R27';
Shared string40 g20	:='=+R21/R27';
Shared string40 g21	:='';
Shared string40 g22	:='';
Shared string40 g23	:='=+R24/R27';
Shared string40 g24	:='=+R25/R27';
Shared string40 g25	:='=+R26/R27';
Shared string40 g26	:='';
//---------------------------------
Shared string40 h1		:='';
Shared string40 h2		:='';
Shared string40 h3		:='';
Shared string40 h4		:='Inactive';
Shared string40 h5		:='';
Shared string40 h6		:='=+S7/S27';
Shared string40 h7		:='=+S8/S27';
Shared string40 h8		:='=+S9/S27';
Shared string40 h9		:='=+S10/S27';
Shared string40 h10	:='=+S11/S27';
Shared string40 h11	:='=+S12/S27';
Shared string40 h12	:='';
Shared string40 h13	:='';
Shared string40 h14	:='=+S15/S27';
Shared string40 h15	:='=+S16/S27';
Shared string40 h16	:='';
Shared string40 h17	:='';
Shared string40 h18	:='=+S19/S27';
Shared string40 h19	:='=+S20/S27';
Shared string40 h20	:='=+S21/S27';
Shared string40 h21	:='';
Shared string40 h22	:='';
Shared string40 h23	:='=+S24/S27';
Shared string40 h24	:='=+S25/S27';
Shared string40 h25	:='=+S26/S27';
Shared string40 h26	:='';
// ---------------------------
Shared string40 i1		:='';
Shared string40 i2		:='';
Shared string40 i3		:='ULTID--LexIDÃ‚Â® Business Extended Family';
Shared string40 i4		:='Active';
Shared string40 i5		:='';
Shared string40 i6		:='';
Shared string40 i7		:='';
Shared string40 i8		:='';
Shared string40 i9		:='';
Shared string40 i10	:='';
Shared string40 i11	:='';
Shared string40 i12	:='';
Shared string40 i13	:='';
Shared string40 i14	:='';
Shared string40 i15	:='';
Shared string40 i16	:='';
Shared string40 i17	:='';
Shared string40 i18	:='';
Shared string40 i19	:='';
Shared string40 i20	:='';
Shared string40 i21	:='';
Shared string40 i22	:='';
Shared string40 i23	:='';
Shared string40 i24	:='';
Shared string40 i25	:='';
Shared string40 i26	:='';
//----------------------------
Shared string40 j1		:='';
Shared string40 j2		:='';
Shared string40 j3		:='';
Shared string40 j4		:='Inactive';
Shared string40 j5		:='';
Shared string40 j6		:='';
Shared string40 j7		:='';
Shared string40 j8		:='';
Shared string40 j9		:='';
Shared string40 j10	:='';
Shared string40 j11	:='';
Shared string40 j12	:='';
Shared string40 j13	:='';
Shared string40 j14	:='';
Shared string40 j15	:='';
Shared string40 j16	:='';
Shared string40 j17	:='';
Shared string40 j18	:='';
Shared string40 j19	:='';
Shared string40 j20	:='';
Shared string40 j21	:='';
Shared string40 j22	:='';
Shared string40 j23	:='';
Shared string40 j24	:='';
Shared string40 j25	:='';
Shared string40 j26	:='';
//-----------------------
Shared string40 k1		:='';
Shared string40 k2		:='';
Shared string40 k3		:='POWID--LexIDÃ‚Â® Business Place Group';
Shared string40 k4		:='Active';
Shared string40 k5		:='';
Shared string40 k6		:='=+V7/V27';
Shared string40 k7		:='=+V8/V27';
Shared string40 k8		:='=+V9/V27';
Shared string40 k9		:='=+V10/V27';
Shared string40 k10	:='=+V11/V27';
Shared string40 k11	:='=+V12/V27';
Shared string40 k12	:='';
Shared string40 k13	:='';
Shared string40 k14	:='=+V15/V27';
Shared string40 k15	:='=+V16/V27';
Shared string40 k16	:='';
Shared string40 k17	:='';
Shared string40 k18	:='=+V19/V27';
Shared string40 k19	:='=+V20/V27';
Shared string40 k20	:='=+V21/V27';
Shared string40 k21	:='';
Shared string40 k22	:='';
Shared string40 k23	:='=+V24/V27';
Shared string40 k24	:='=+V25/V27';
Shared string40 k25	:='=+V26/V27';
Shared string40 k26	:='';
// ------------------------
Shared string40 l1		:='';
Shared string40 l2		:='';
Shared string40 l3		:='';
Shared string40 l4		:='Inactive';
Shared string40 l5		:='';
Shared string40 l6		:='=+W7/W27';
Shared string40 l7		:='=+W8/W27';
Shared string40 l8		:='=+W9/W27';
Shared string40 l9		:='=+W10/W27';
Shared string40 l10	:='=+W11/W27';
Shared string40 l11	:='=+W12/W27';
Shared string40 l12	:='';
Shared string40 l13	:='';
Shared string40 l14	:='=+W15/W27';
Shared string40 l15	:='=+W16/W27';
Shared string40 l16	:='';
Shared string40 l17	:='';
Shared string40 l18	:='=+W19/W27';
Shared string40 l19	:='=+W20/W27';
Shared string40 l20	:='=+W21/W27';
Shared string40 l21	:='';
Shared string40 l22	:='';
Shared string40 l23	:='=+W24/W27';
Shared string40 l24	:='=+W25/W27';
Shared string40 l25	:='=+W26/W27';
Shared string40 l26	:='';
// ---------------------------------
Shared string40 al1	:='';
Shared string40 al2	:='Current Build Fill Rates';
Shared string40 al3	:='PROXID';
Shared string40 al4	:='Active'; 
Shared string40 al5	:='';
Shared string40 al6	:=(string40)V2FieldStatsActivePROX[1].prim_name;//prim_name
Shared string40 al7	:=(string40)V2FieldStatsActivePROX[1].v_city_name; //v_city_name
Shared string40 al8	:=(string40)V2FieldStatsActivePROX[1].st; 
Shared string40 al9	:=(string40)V2FieldStatsActivePROX[1].zip;
Shared string40 al10	:=(string40)V2FieldStatsActivePROX[1].company_phone;
Shared string40 al11	:=(string40)V2FieldStatsActivePROX[1].dba_name;
Shared string40 al12	:='';
Shared string40 al13	:='';
Shared string40 al14	:=(string40)V2FieldStatsActivePROX[1].company_sic_code1;
Shared string40 al15	:=(string40)V2FieldStatsActivePROX[1].company_naics_code1;
Shared string40 al16	:='';
Shared string40 al17	:='';
Shared string40 al18	:=(string40)V2FieldStatsActivePROX[1].lname;
Shared string40 al19	:=(string40)V2FieldStatsActivePROX[1].contact_email;
Shared string40 al20	:=(string40)V2FieldStatsActivePROX[1].contact_phone;
Shared string40 al21	:='';
Shared string40 al22	:='';
Shared string40 al23	:=(string40)V2FieldStatsActivePROX[1].company_fein;
Shared string40 al24	:=(string40)V2FieldStatsActivePROX[1].company_ticker; 
Shared string40 al25	:=(string40)V2FieldStatsActivePROX[1].company_url;
Shared string40 al26	:=(string40)V2FieldStatsActivePROX[1].countgroup; 
// --------------------------
Shared string40 am1	:='';
Shared string40 am2	:='';
Shared string40 am3	:='';
Shared string40 am4	:='Inactive'; 
Shared string40 am5	:='';
Shared string40 am6	:=(string40)V2FieldStatsInactivePROX[1].prim_name;
Shared string40 am7	:=(string40)V2FieldStatsInactivePROX[1].v_city_name;
Shared string40 am8	:=(string40)V2FieldStatsInactivePROX[1].st;
Shared string40 am9	:=(string40)V2FieldStatsInactivePROX[1].zip;
Shared string40 am10	:=(string40)V2FieldStatsInactivePROX[1].company_phone; 
Shared string40 am11	:=(string40)V2FieldStatsInactivePROX[1].dba_name;
Shared string40 am12	:='';
Shared string40 am13	:='';
Shared string40 am14	:=(string40)V2FieldStatsInactivePROX[1].company_sic_code1;
Shared string40 am15	:=(string40)V2FieldStatsInactivePROX[1].company_naics_code1;
Shared string40 am16	:='';
Shared string40 am17	:='';
Shared string40 am18	:=(string40)V2FieldStatsInactivePROX[1].lname;
Shared string40 am19	:=(string40)V2FieldStatsInactivePROX[1].contact_email;
Shared string40 am20	:=(string40)V2FieldStatsInactivePROX[1].contact_phone; 
Shared string40 am21	:='';
Shared string40 am22	:='';
Shared string40 am23	:=(string40)V2FieldStatsInactivePROX[1].company_fein; 
Shared string40 am24	:=(string40)V2FieldStatsInactivePROX[1].company_ticker; 
Shared string40 am25	:=(string40)V2FieldStatsInactivePROX[1].company_url;
Shared string40 am26	:=(string40)V2FieldStatsInactivePROX[1].countgroup;

//--------------------------
Shared string40 an1	:='';
Shared string40 an2	:='';
Shared string40 an3	:='SELE';
Shared string40 an4	:='Active'; 
Shared string40 an5	:='';
Shared string40 an6	:=(string40)V2FieldStatsActiveSELE[1].prim_name;
Shared string40 an7	:=(string40)V2FieldStatsActiveSELE[1].v_city_name; 
Shared string40 an8	:=(string40)V2FieldStatsActiveSELE[1].st;
Shared string40 an9	:=(string40)V2FieldStatsActiveSELE[1].zip;
Shared string40 an10	:=(string40)V2FieldStatsActiveSELE[1].company_phone; 
Shared string40 an11	:=(string40)V2FieldStatsActiveSELE[1].dba_name;
Shared string40 an12	:='';
Shared string40 an13	:='';
Shared string40 an14	:=(string40)V2FieldStatsActiveSELE[1].company_sic_code1;
Shared string40 an15	:=(string40)V2FieldStatsActiveSELE[1].company_naics_code1;
Shared string40 an16	:='';
Shared string40 an17	:='';
Shared string40 an18	:=(string40)V2FieldStatsActiveSELE[1].lname;
Shared string40 an19	:=(string40)V2FieldStatsActiveSELE[1].contact_email; 
Shared string40 an20	:=(string40)V2FieldStatsActiveSELE[1].contact_phone; 
Shared string40 an21	:='';
Shared string40 an22	:='';
Shared string40 an23	:=(string40)V2FieldStatsActiveSELE[1].company_fein; 
Shared string40 an24	:=(string40)V2FieldStatsActiveSELE[1].company_ticker; 
Shared string40 an25	:=(string40)V2FieldStatsActiveSELE[1].company_url;
Shared string40 an26	:=(string40)V2FieldStatsActiveSELE[1].countgroup; 
//------------------
Shared string40 ao1	:='';
Shared string40 ao2	:='';
Shared string40 ao3	:='';
Shared string40 ao4	:='Inactive'; 
Shared string40 ao5	:='';
Shared string40 ao6	:=(string40)V2FieldStatsInactiveSELE[1].prim_name;
Shared string40 ao7	:=(string40)V2FieldStatsInactiveSELE[1].v_city_name;
Shared string40 ao8	:=(string40)V2FieldStatsInactiveSELE[1].st;
Shared string40 ao9	:=(string40)V2FieldStatsInactiveSELE[1].zip;
Shared string40 ao10	:=(string40)V2FieldStatsInactiveSELE[1].company_phone;
Shared string40 ao11	:=(string40)V2FieldStatsInactiveSELE[1].dba_name;
Shared string40 ao12	:='';
Shared string40 ao13	:='';
Shared string40 ao14	:=(string40)V2FieldStatsInactiveSELE[1].company_sic_code1; 
Shared string40 ao15	:=(string40)V2FieldStatsInactiveSELE[1].company_naics_code1;
Shared string40 ao16	:='';
Shared string40 ao17	:='';
Shared string40 ao18	:=(string40)V2FieldStatsInactiveSELE[1].lname;
Shared string40 ao19	:=(string40)V2FieldStatsInactiveSELE[1].contact_email;
Shared string40 ao20	:=(string40)V2FieldStatsInactiveSELE[1].contact_phone;
Shared string40 ao21	:='';
Shared string40 ao22	:='';
Shared string40 ao23	:=(string40)V2FieldStatsInactiveSELE[1].company_fein;
Shared string40 ao24	:=(string40)V2FieldStatsInactiveSELE[1].company_ticker;
Shared string40 ao25	:=(string40)V2FieldStatsInactiveSELE[1].company_url;
Shared string40 ao26	:=(string40)V2FieldStatsInactiveSELE[1].countgroup;
//----------------------------add additional SELE GOLD part
Shared string40 ang1	:='';
Shared string40 ang2	:='';
Shared string40 ang3	:='SELE';
Shared string40 ang4	:='Active GOLD'; 
Shared string40 ang5	:='';
Shared string40 ang6	:=(string40)V2FieldStatsActiveSELEGold[1].prim_name;
Shared string40 ang7	:=(string40)V2FieldStatsActiveSELEGold[1].v_city_name; 
Shared string40 ang8	:=(string40)V2FieldStatsActiveSELEGold[1].st;
Shared string40 ang9	:=(string40)V2FieldStatsActiveSELEGold[1].zip;
Shared string40 ang10	:=(string40)V2FieldStatsActiveSELEGold[1].company_phone; 
Shared string40 ang11	:=(string40)V2FieldStatsActiveSELEGold[1].dba_name;
Shared string40 ang12	:='';
Shared string40 ang13	:='';
Shared string40 ang14	:=(string40)V2FieldStatsActiveSELEGold[1].company_sic_code1;
Shared string40 ang15	:=(string40)V2FieldStatsActiveSELEGold[1].company_naics_code1;
Shared string40 ang16	:='';
Shared string40 ang17	:='';
Shared string40 ang18	:=(string40)V2FieldStatsActiveSELEGold[1].lname;
Shared string40 ang19	:=(string40)V2FieldStatsActiveSELEGold[1].contact_email; 
Shared string40 ang20	:=(string40)V2FieldStatsActiveSELEGold[1].contact_phone; 
Shared string40 ang21	:='';
Shared string40 ang22	:='';
Shared string40 ang23	:=(string40)V2FieldStatsActiveSELEGold[1].company_fein; 
Shared string40 ang24	:=(string40)V2FieldStatsActiveSELEGold[1].company_ticker; 
Shared string40 ang25	:=(string40)V2FieldStatsActiveSELEGold[1].company_url;
Shared string40 ang26	:=(string40)V2FieldStatsActiveSELEGold[1].countgroup;
//----------------
Shared string40 ap1	:='';
Shared string40 ap2	:='';
Shared string40 ap3	:='ORGID';
Shared string40 ap4	:='Active'; 
Shared string40 ap5	:='';
Shared string40 ap6	:=(string40)V2FieldStatsActiveORG[1].prim_name;	
Shared string40 ap7	:=(string40)V2FieldStatsActiveORG[1].v_city_name;
Shared string40 ap8	:=(string40)V2FieldStatsActiveORG[1].st;
Shared string40 ap9	:=(string40)V2FieldStatsActiveORG[1].zip;
Shared string40 ap10	:=(string40)V2FieldStatsActiveORG[1].company_phone;
Shared string40 ap11	:=(string40)V2FieldStatsActiveORG[1].dba_name;
Shared string40 ap12	:='';
Shared string40 ap13	:='';
Shared string40 ap14	:=(string40)V2FieldStatsActiveORG[1].company_sic_code1;
Shared string40 ap15	:=(string40)V2FieldStatsActiveORG[1].company_naics_code1; 
Shared string40 ap16	:='';
Shared string40 ap17	:='';
Shared string40 ap18	:=(string40)V2FieldStatsActiveORG[1].lname; 
Shared string40 ap19	:=(string40)V2FieldStatsActiveORG[1].contact_email; 
Shared string40 ap20	:=(string40)V2FieldStatsActiveORG[1].contact_phone; 
Shared string40 ap21	:='';
Shared string40 ap22	:='';
Shared string40 ap23	:=(string40)V2FieldStatsActiveORG[1].company_fein;
Shared string40 ap24	:=(string40)V2FieldStatsActiveORG[1].company_ticker;
Shared string40 ap25	:=(string40)V2FieldStatsActiveORG[1].company_url;
Shared string40 ap26	:=(string40)V2FieldStatsActiveORG[1].countgroup; 
//---------------------
Shared string40 aq1	:='';
Shared string40 aq2	:='';
Shared string40 aq3	:='';
Shared string40 aq4	:='Inactive'; 
Shared string40 aq5	:='';
Shared string40 aq6	:=(string40)V2FieldStatsInactiveORG[1].prim_name;	
Shared string40 aq7	:=(string40)V2FieldStatsInactiveORG[1].v_city_name; 
Shared string40 aq8	:=(string40)V2FieldStatsInactiveORG[1].st;
Shared string40 aq9	:=(string40)V2FieldStatsInactiveORG[1].zip;
Shared string40 aq10	:=(string40)V2FieldStatsInactiveORG[1].company_phone; 
Shared string40 aq11	:=(string40)V2FieldStatsInactiveORG[1].dba_name;
Shared string40 aq12	:='';
Shared string40 aq13	:='';
Shared string40 aq14	:=(string40)V2FieldStatsInactiveORG[1].company_sic_code1; 
Shared string40 aq15	:=(string40)V2FieldStatsInactiveORG[1].company_naics_code1;
Shared string40 aq16	:='';
Shared string40 aq17	:='';
Shared string40 aq18	:=(string40)V2FieldStatsInactiveORG[1].lname;
Shared string40 aq19	:=(string40)V2FieldStatsInactiveORG[1].contact_email; 
Shared string40 aq20	:=(string40)V2FieldStatsInactiveORG[1].contact_phone; 
Shared string40 aq21	:='';
Shared string40 aq22	:='';
Shared string40 aq23	:=(string40)V2FieldStatsInactiveORG[1].company_fein; 
Shared string40 aq24	:=(string40)V2FieldStatsInactiveORG[1].company_ticker; 
Shared string40 aq25	:=(string40)V2FieldStatsInactiveORG[1].company_url;
Shared string40 aq26	:=(string40)V2FieldStatsInactiveORG[1].countgroup; 
//---------------------
Shared string40 ar1	:='';
Shared string40 ar2	:='';
Shared string40 ar3	:='ULTID';
Shared string40 ar4	:='Active'; 
Shared string40 ar5	:='';
Shared string40 ar6	:='';
Shared string40 ar7	:='';
Shared string40 ar8	:='';
Shared string40 ar9	:='';
Shared string40 ar10	:='';
Shared string40 ar11	:='';
Shared string40 ar12	:='';
Shared string40 ar13	:='';
Shared string40 ar14	:='';
Shared string40 ar15	:='';
Shared string40 ar16	:='';
Shared string40 ar17	:='';
Shared string40 ar18	:='';
Shared string40 ar19	:='';
Shared string40 ar20	:='';
Shared string40 ar21	:='';
Shared string40 ar22	:='';
Shared string40 ar23	:='';
Shared string40 ar24	:='';
Shared string40 ar25	:='';
Shared string40 ar26	:='';
//---------
Shared string40 as1	:='';
Shared string40 as2	:='';
Shared string40 as3	:='';
Shared string40 as4	:='Inactive'; 
Shared string40 as5	:='';
Shared string40 as6	:='';
Shared string40 as7	:='';
Shared string40 as8	:='';
Shared string40 as9	:='';
Shared string40 as10	:='';
Shared string40 as11	:='';
Shared string40 as12	:='';
Shared string40 as13	:='';
Shared string40 as14	:='';
Shared string40 as15	:='';
Shared string40 as16	:='';
Shared string40 as17	:='';
Shared string40 as18	:='';
Shared string40 as19	:='';
Shared string40 as20	:='';
Shared string40 as21	:='';
Shared string40 as22	:='';
Shared string40 as23	:='';
Shared string40 as24	:='';
Shared string40 as25	:='';
Shared string40 as26	:='';
//-------------------
Shared string40 at1	:='';
Shared string40 at2	:='';
Shared string40 at3	:='POWID';
Shared string40 at4	:='Active'; 
Shared string40 at5	:='';
Shared string40 at6	:=(string40)V2FieldStatsActivePOW[1].prim_name;
Shared string40 at7	:=(string40)V2FieldStatsActivePOW[1].v_city_name;
Shared string40 at8	:=(string40)V2FieldStatsActivePOW[1].st;
Shared string40 at9	:=(string40)V2FieldStatsActivePOW[1].zip;
Shared string40 at10	:=(string40)V2FieldStatsActivePOW[1].company_phone;
Shared string40 at11	:=(string40)V2FieldStatsActivePOW[1].dba_name;
Shared string40 at12	:='';
Shared string40 at13	:='';
Shared string40 at14	:=(string40)V2FieldStatsActivePOW[1].company_sic_code1; 
Shared string40 at15	:=(string40)V2FieldStatsActivePOW[1].company_naics_code1;
Shared string40 at16	:='';
Shared string40 at17	:='';
Shared string40 at18	:=(string40)V2FieldStatsActivePOW[1].lname;
Shared string40 at19	:=(string40)V2FieldStatsActivePOW[1].contact_email; 
Shared string40 at20	:=(string40)V2FieldStatsActivePOW[1].contact_phone; 
Shared string40 at21	:='';
Shared string40 at22	:='';
Shared string40 at23	:=(string40)V2FieldStatsActivePOW[1].company_fein; 
Shared string40 at24	:=(string40)V2FieldStatsActivePOW[1].company_ticker;
Shared string40 at25	:=(string40)V2FieldStatsActivePOW[1].company_url;
Shared string40 at26	:=(string40)V2FieldStatsActivePOW[1].countgroup;
//-------------------------
Shared string40 au1	:='';
Shared string40 au2	:='';
Shared string40 au3	:='';
Shared string40 au4	:='Inactive'; 
Shared string40 au5	:='';
Shared string40 au6	:=(string40)V2FieldStatsInactivePOW[1].prim_name;	
Shared string40 au7	:=(string40)V2FieldStatsInactivePOW[1].v_city_name;
Shared string40 au8	:=(string40)V2FieldStatsInactivePOW[1].st; 
Shared string40 au9	:=(string40)V2FieldStatsInactivePOW[1].zip;
Shared string40 au10	:=(string40)V2FieldStatsInactivePOW[1].company_phone; 
Shared string40 au11	:=(string40)V2FieldStatsInactivePOW[1].dba_name;
Shared string40 au12	:='';
Shared string40 au13	:='';
Shared string40 au14	:=(string40)V2FieldStatsInactivePOW[1].company_sic_code1;
Shared string40 au15	:=(string40)V2FieldStatsInactivePOW[1].company_naics_code1;
Shared string40 au16	:='';
Shared string40 au17	:='';
Shared string40 au18	:=(string40)V2FieldStatsInactivePOW[1].lname;
Shared string40 au19	:=(string40)V2FieldStatsInactivePOW[1].contact_email; 
Shared string40 au20	:=(string40)V2FieldStatsInactivePOW[1].contact_phone;
Shared string40 au21	:='';
Shared string40 au22	:='';
Shared string40 au23	:=(string40)V2FieldStatsInactivePOW[1].company_fein;
Shared string40 au24	:=(string40)V2FieldStatsInactivePOW[1].company_ticker; 
Shared string40 au25	:=(string40)V2FieldStatsInactivePOW[1].company_url; 
Shared string40 au26	:=(string40)V2FieldStatsInactivePOW[1].countgroup;

/* // Template:
(string40)V2FieldStatsInactivePOW[1].prim_name;	//street
(string40)V2FieldStatsInactivePOW[1].v_city_name; //city
(string40)V2FieldStatsInactivePOW[1].st; //State
(string40)V2FieldStatsInactivePOW[1].zip;
(string40)V2FieldStatsInactivePOW[1].company_phone; //Phone
(string40)V2FieldStatsInactivePOW[1].dba_name; //DBA
(string40)V2FieldStatsInactivePOW[1].company_sic_code1; //SIC Primary
(string40)V2FieldStatsInactivePOW[1].company_naics_code1; //NAICS Primary
(string40)V2FieldStatsInactivePOW[1].lname; //Name
(string40)V2FieldStatsInactivePOW[1].contact_email; //Email
(string40)V2FieldStatsInactivePOW[1].contact_phone; //Phone
(string40)V2FieldStatsInactivePOW[1].company_fein; //FEIN
(string40)V2FieldStatsInactivePOW[1].company_ticker; //Ticker
(string40)V2FieldStatsInactivePOW[1].company_url; //URL
(string40)V2FieldStatsInactivePOW[1].countgroup; //???
*/
Shared Data_Fill_Rates_Rec :={string100 t1, string40 t2, string40 t3, string40 t4, string40 t5, string40 t6, string40 t7, 
					   string40 t8, string40 t9, string40 t10, string40 t11, string40 t12, string40 t13, string40 t14, 
					   string40 t15, string40 t16, string40 t17, string40 t18, string40 t19, string40 t20, string40 t21, string40 t22,string40 t23};
Shared Data_Fill_Rates :=dataset([
   						{u1,v1,w1,e1,f1,ff1,g1,h1,i1,j1,k1,l1,al1,am1,an1,ao1,ang1,ap1,aq1,ar1,as1,at1,au1},
							{u2,v2,w2,e2,f2,ff2,g2,h2,i2,j2,k2,l2,al2,am2,an2,ao2,ang2,ap2,aq2,ar2,as2,at2,au2},
							{u3,v3,w3,e3,f3,ff3,g3,h3,i3,j3,k3,l3,al3,am3,an3,ao3,ang3,ap3,aq3,ar3,as3,at3,au3},
							{u4,v4,w4,e4,f4,ff4,g4,h4,i4,j4,k4,l4,al4,am4,an4,ao4,ang4,ap4,aq4,ar4,as4,at4,au4},
							{u5,v5,w5,e5,f5,ff5,g5,h5,i5,j5,k5,l5,al5,am5,an5,ao5,ang5,ap5,aq5,ar5,as5,at5,au5},
							{u6,v6,w6,e6,f6,ff6,g6,h6,i6,j6,k6,l6,al6,am6,an6,ao6,ang6,ap6,aq6,ar6,as6,at6,au6},
							{u7,v7,w7,e7,f7,ff7,g7,h7,i7,j7,k7,l7,al7,am7,an7,ao7,ang7,ap7,aq7,ar7,as7,at7,au7},
							{u8,v8,w8,e8,f8,ff8,g8,h8,i8,j8,k8,l8,al8,am8,an8,ao8,ang8,ap8,aq8,ar8,as8,at8,au8},
							{u9,v9,w9,e9,f9,ff9,g9,h9,i9,j9,k9,l9,al9,am9,an9,ao9,ang9,ap9,aq9,ar9,as9,at9,au9},
							{u10,v10,w10,e10,f10,ff10,g10,h10,i10,j10,k10,l10,al10,am10,an10,ao10,ang10,ap10,aq10,ar10,as10,at10,au10},
							{u11,v11,w11,e11,f11,ff11,g11,h11,i11,j11,k11,l11,al11,am11,an11,ao11,ang11,ap11,aq11,ar11,as11,at11,au11},
							{u12,v12,w12,e12,f12,ff12,g12,h12,i12,j12,k12,l12,al12,am12,an12,ao12,ang12,ap12,aq12,ar12,as12,at12,au12},
							{u13,v13,w13,e13,f13,ff13,g13,h13,i13,j13,k13,l13,al13,am13,an13,ao13,ang13,ap13,aq13,ar13,as13,at13,au13},
							{u14,v14,w14,e14,f14,ff14,g14,h14,i14,j14,k14,l14,al14,am14,an14,ao14,ang14,ap14,aq14,ar14,as14,at14,au14},
							{u15,v15,w15,e15,f15,ff15,g15,h15,i15,j15,k15,l15,al15,am15,an15,ao15,ang15,ap15,aq15,ar15,as15,at15,au15},
							{u16,v16,w16,e16,f16,ff16,g16,h16,i16,j16,k16,l16,al16,am16,an16,ao16,ang16,ap16,aq16,ar16,as16,at16,au16},
							{u17,v17,w17,e17,f17,ff17,g17,h17,i17,j17,k17,l17,al17,am17,an17,ao17,ang17,ap17,aq17,ar17,as17,at17,au17},
							{u18,v18,w18,e18,f18,ff18,g18,h18,i18,j18,k18,l18,al18,am18,an18,ao18,ang18,ap18,aq18,ar18,as18,at18,au18},
							{u19,v19,w19,e19,f19,ff19,g19,h19,i19,j19,k19,l19,al19,am19,an19,ao19,ang19,ap19,aq19,ar19,as19,at19,au19},
							{u20,v20,w20,e20,f20,ff20,g20,h20,i20,j20,k20,l20,al20,am20,an20,ao20,ang20,ap20,aq20,ar20,as20,at20,au20},
							{u21,v21,w21,e21,f21,ff21,g21,h21,i21,j21,k21,l21,al21,am21,an21,ao21,ang21,ap21,aq21,ar21,as21,at21,au21},
							{u22,v22,w22,e22,f22,ff22,g22,h22,i22,j22,k22,l22,al22,am22,an22,ao22,ang22,ap22,aq22,ar22,as22,at22,au22},
							{u23,v23,w23,e23,f23,ff23,g23,h23,i23,j23,k23,l23,al23,am23,an23,ao23,ang23,ap23,aq23,ar23,as23,at23,au23},
							{u24,v24,w24,e24,f24,ff24,g24,h24,i24,j24,k24,l24,al24,am24,an24,ao24,ang24,ap24,aq24,ar24,as24,at24,au24},
							{u25,v25,w25,e25,f25,ff25,g25,h25,i25,j25,k25,l25,al25,am25,an25,ao25,ang25,ap25,aq25,ar25,as25,at25,au25},
							{u26,v26,w26,e26,f26,ff26,g26,h26,i26,j26,k26,l26,al26,am26,an26,ao26,ang26,ap26,aq26,ar26,as26,at26,au26}							
   						  ],Data_Fill_Rates_Rec);
   
   
   //output(Data_Fill_Rates, named('Data_Fill_Rates'));
   
   // ------------------------------------------GOLD Below-----------------------------
   

 Shared GOLD :={string1000 description, string40 cnt};
 Shared Attribute_Table_SELEID_V2_rec:=record
   boolean              isgold                                                                      ;
   boolean              isactive                                                                    ;
   boolean              hassupercoresrc                                                             ;
   boolean              hasothercoresrc                                                             ;
   boolean              has2tsrc                                                                    ;
   boolean              hasmultiplesources                                                          ;
   boolean              hasbizaddr                                                                  ;
   boolean              isnotjustpobox                                                              ;
   integer8             cnt                                                                         ;
   integer8             pct_of_all                                                                  ;
   integer8             pct_of_gold                                                                 ;
   integer8             pct_of_not_gold                                                             ;
   string               description                                                                 ;
end;

 Shared Attribute_Table_SELEID_V2:=Dataset(WorkUnit(the_WU,'Attribute_Table_SELEID V2'),Attribute_Table_SELEID_V2_rec);

Shared string s1:='LexisNexis Risk Solutions - Business Data Profile';
Shared string s2:='Date: ' + the_WU[2..5] + ' ' + TheSprint;
Shared string s3:='SELE--LexIDÃ‚Â® Business Legal Entity';
Shared string s4:='GOLD';
Shared string s5:='Multiple Sources at a Business Address';
Shared string s6:='Gold: Active, No LNCA, Has 1 or more of DMI/EBR, Has 1 or more second tier source, Has 2 or more total sources, At Business Address';
Shared string s7:='Gold: Active, No LNCA, No DMI/EBR, Has 1 or more second tier source, Has 2 or more total sources, At Business Address';
Shared string s8:='Gold: Active, No LNCA, Has 1 or more of DMI/EBR, No second tier source, Has 2 or more total sources, At Business Address';
Shared string s9:='Gold: Active, Has LNCA, Has 1 or more of DMI/EBR, Has 1 or more second tier source, Has 2 or more total sources, At Business Address';
Shared string s10:='Gold: Active, Has LNCA, Has 1 or more of DMI/EBR, No second tier source, Has 2 or more total sources, At Business Address';
Shared string s11:='Gold: Active, Has LNCA, No DMI/EBR, Has 1 or more second tier source, Has 2 or more total sources, At Business Address';
Shared string s12:='Gold: Active, Has LNCA, No DMI/EBR, No second tier source, Has 2 or more total sources, At Business Address';
Shared string s13:='';
Shared string s14:='Mutliple Sources at an Unknown or Residential Address';
Shared string s15:='Gold: Active, No LNCA, Has 1 or more of DMI/EBR, Has 1 or more second tier source, Has 2 or more total sources, At Residential or Unknown Address';
Shared string s16:='Gold: Active, No LNCA, No DMI/EBR, Has 1 or more second tier source, Has 2 or more total sources, At Residential or Unknown Address';
Shared string s17:='Gold: Active, No LNCA, Has 1 or more of DMI/EBR, No second tier source, Has 2 or more total sources, At Residential or Unknown Address';
Shared string s18:='Gold: Active, Has LNCA, Has 1 or more of DMI/EBR, Has 1 or more second tier source, Has 2 or more total sources, At Residential or Unknown Address';
Shared string s19:='Gold: Active, Has LNCA, Has 1 or more of DMI/EBR, No second tier source, Has 2 or more total sources, At Residential or Unknown Address';
Shared string s20:='Gold: Active, Has LNCA, No DMI/EBR, Has 1 or more second tier source, Has 2 or more total sources, At Residential or Unknown Address';
Shared string s21:='Gold: Active, Has LNCA, No DMI/EBR, No second tier source, Has 2 or more total sources, At Residential or Unknown Address';
Shared string s22:='';
Shared string s23:='Single Source at a Business Address';
Shared string s24:='Gold: Active, No LNCA, No DMI/EBR, Has 1 or more second tier source, Has 1 total source, At Business Address';
Shared string s25:='Gold: Active, No LNCA, Has 1 or more of DMI/EBR, No second tier source, Has 1 total source, At Business Address';
Shared string s26:='Gold: Active, Has LNCA, No DMI/EBR, No second tier source, Has 1 total source, At Business Address';
Shared string s27:='';
Shared string s28:='Single Source at an Unknown or Residential Address';
Shared string s29:='Gold: Active, Has LNCA, No DMI/EBR, No second tier source, Has 1 total source, At Residential or Unknown Address';
Shared string s30:='';
Shared string s31:='NON-GOLD';
Shared string s32:='Single Source at a Business';
Shared string s33:='Not Gold: Active, No LNCA, No DMI/EBR, No second tier source, Has 1 total source, At Business Address';
Shared string s34:='Not Gold: Active, Has HV Source, Has 1 total source, At Business Address';
Shared string s34b:='';
Shared string s35:='Single Source at an Unknown or Residental Address';
Shared string s36:='Not Gold: Active, No LNCA, No DMI/EBR, Has 1 or more second tier source, Has 1 total source, At Residential or Unknown Address';
Shared string s37:='Not Gold: Active, No LNCA, Has 1 or more of DMI/EBR, No second tier source, Has 1 total source, At Residential or Unknown Address';
Shared string s38:='Not Gold: Active, No LNCA, No DMI/EBR, No second tier source, Has 1 total source, At Residential or Unknown Address';
Shared string s39 := 'Not Gold: Active, Has LNCA, Has 1 total source, At Residential or Unknown Address';
Shared string s39b := '';
Shared string s40:='Multiple Sources at an Unknown or Residential Address';
Shared string s41:='Not Gold: Active, No LNCA, No DMI/EBR, No second tier source, Has 2 or more total sources, At Residential or Unknown Address';
Shared string s42:='Not Gold: Active, has HV Source, Has 2 or more total sources, At Residential or Unknown Address';
Shared string s42b:='';
Shared string s43:='Multiple Sources at a Business Address';
Shared string s44:='Non HV Sources'; 
Shared string _s44 :='Not Gold: Active, No LNCA, No DMI/EBR, No second tier source, Has 2 or more total sources, At Business Address';

Shared string s45:='Has HV Sources';
Shared string s45b:='';
Shared string s46:='Single Source at PO Box';
Shared string s47:='Not Gold: Active, Has 1 total source, Only has PO Box';
Shared string s48:='';
Shared string s49:='Multiple Sources at PO Box';
Shared string s50:='Not Gold: Active, Has 2 or more total sources, Only has PO Box';
Shared string s51:='';
Shared string s52:='Inactive';
Shared string s53:='';
Shared string s54:='Total Header SELEs';
//----------------------------------------
	shared string40 nb := '';
	Shared string40 n1	:='';
	Shared string40 n2	:='';
	Shared string40 n3	:=TheSprint;
   Shared string40 n6	:=(string40)Attribute_Table_SELEID_V2(description=s6)[1].cnt;
   Shared string40 n7	:=(string40)Attribute_Table_SELEID_V2(description=s7)[1].cnt;
   Shared string40 n8	:=(string40)Attribute_Table_SELEID_V2(description=s8)[1].cnt;
   Shared string40 n9	:=(string40)Attribute_Table_SELEID_V2(description=s9)[1].cnt;
   Shared string40 n10	:=(string40)Attribute_Table_SELEID_V2(description=s10)[1].cnt;
   Shared string40 n11	:=(string40)Attribute_Table_SELEID_V2(description=s11)[1].cnt;
   Shared string40 n12	:=(string40)Attribute_Table_SELEID_V2(description=s12)[1].cnt;
   //Shared string40 n5	:=(string40)((integer)n6 + (integer)n7 + (integer)n8 + (integer)n9 + (integer)n10 + (integer)n11 + (integer)n12); //sum of n6 to n12
   Shared string40 n5	:='=sum(B6:B12)';     //Shared string40 n5	:='=sum(B6:B12)'; //We have to shift one row to handle the worksheet header
   //----------------------------------------------------------------------------------------------------------------
   
   Shared string40 n13	:='';
   Shared string40 n15	:=(string40)Attribute_Table_SELEID_V2(description=s15)[1].cnt;
   Shared string40 n16	:=(string40)Attribute_Table_SELEID_V2(description=s16)[1].cnt;
   Shared string40 n17	:=(string40)Attribute_Table_SELEID_V2(description=s17)[1].cnt;
   Shared string40 n18	:=(string40)Attribute_Table_SELEID_V2(description=s18)[1].cnt;
   Shared string40 n19	:=(string40)Attribute_Table_SELEID_V2(description=s19)[1].cnt;
   Shared string40 n20	:=(string40)Attribute_Table_SELEID_V2(description=s20)[1].cnt;
   Shared string40 n21	:=(string40)Attribute_Table_SELEID_V2(description=s21)[1].cnt;
   Shared string40 n22	:='';
   //Shared string40 n14	:=(string40)((integer)n15 + (integer)n16 + (integer)n17 + (integer)n18 + (integer)n19 + (integer)n20 + (integer)n21); //will be sum of n15 to n21
   Shared string40 n14	:='=Sum(B15:B22)'; //Shared string40 n14	:='=Sum(B15:B21)';  //We have to shift one row to handle the worksheet header
   //----------------------------------------------------------------------------------------------------------------
   
   Shared string40 n24	:=(string40)Attribute_Table_SELEID_V2(description=s24)[1].cnt;
   Shared string40 n25	:=(string40)Attribute_Table_SELEID_V2(description=s25)[1].cnt;
   Shared string40 n26	:=(string40)Attribute_Table_SELEID_V2(description=s26)[1].cnt;
   //Shared string40 n23	:=(string40)((integer)n24 + (integer)n25 + (integer)n26); 	//will be sum 24 to 26
   Shared string40 n23	:='=Sum(B24:B27)'; //Shared string40 n23	:='=Sum(B24:B26)'; //We have to shift one row to handle the worksheet header
   //----------------------------------------------------------------------------------------------------------------
   
   Shared string40 n27	:='';
   Shared string40 n28	:=(string40)Attribute_Table_SELEID_V2(description=s29)[1].cnt;  //28 is 29
   Shared string40 n29	:=(string40)Attribute_Table_SELEID_V2(description=s29)[1].cnt;
   Shared string40 n30	:='';
   //Shared string40 n4	:=(string40)((integer)n5 + (integer)n14 + (integer)n23 + (integer)n28);           // sum of GOLD Active (=+N5+N14+N23+N28)
   Shared string40 n4	:='=B5+B14+B23+B28'; //Shared string40 n4	:='=B5+B14+B23+B28'; //We have to shift one row to handle the worksheet header
   //-----------------------------------------------------------------------------------------------------------------
   
   Shared string40 n32	:='=B33+B34';
   Shared string40 n33	:=(string40)sum(Attribute_Table_SELEID_V2(not isgold, isactive, not hasSuperCoreSrc, not hasOtherCoreSrc, not has2TSrc, not hasMultipleSources, hasBizAddr, isNotJustPoBox), cnt);
   Shared string40 n34	:=(string40)sum(Attribute_Table_SELEID_V2(not isgold, isactive, hasSuperCoreSrc or hasOtherCoreSrc or has2TSrc, not hasMultipleSources, hasBizAddr, isNotJustPoBox), cnt);
   
   Shared string40 n36	:=(string40)Attribute_Table_SELEID_V2(description=s36)[1].cnt;
   Shared string40 n37	:=(string40)Attribute_Table_SELEID_V2(description=s37)[1].cnt;
   Shared string40 n38	:=(string40)Attribute_Table_SELEID_V2(description=s38)[1].cnt;
   Shared string40 n39	:=(string40)sum(Attribute_Table_SELEID_V2(not isgold, isactive, hasSuperCoreSrc, not hasMultipleSources, not hasBizAddr, isNotJustPoBox), cnt);
   //Shared string40 n35	:=(string40)((integer)n36 + (integer)n37 + (integer)n38); 														// sum 36 to 38
   Shared string40 n35	:='=Sum(B36:B39)'; //Shared string40 n35	:='=Sum(B36:B39)';//We have to shift one row to handle the worksheet header
   //---------------------------------------------------------------------------------------------------------------
   Shared string40 n40	:='=B41+B42';
   Shared string40 n41	:=(string40)Attribute_Table_SELEID_V2(description=s41)[1].cnt;
   Shared string40 n42	:=(string40)sum(Attribute_Table_SELEID_V2(not isgold, isactive, hasSuperCoreSrc or hasOtherCoreSrc or has2TSrc, hasMultipleSources, not hasBizAddr, isNotJustPoBox), cnt);
   
   Shared string40 n43	:='=B44+B45';
   Shared string40 n44	:=(string40)Attribute_Table_SELEID_V2(description=_s44)[1].cnt; //Note We use _s44
   Shared string40 n45	:=(string40)sum(Attribute_Table_SELEID_V2(not isgold, isactive, hasSuperCoreSrc or hasOtherCoreSrc or has2TSrc, hasMultipleSources, hasBizAddr, isNotJustPoBox), cnt);
   
   Shared string40 n47	:=(string40)sum(Attribute_Table_SELEID_V2(isgold=FALSE, isactive=TRUE, hasmultiplesources=FALSE,isnotjustpobox=FALSE),cnt);
   Shared string40 n48	:='';
   Shared string40 n46	:='=B47';
   
   Shared string40 n50	:=(string40)sum(Attribute_Table_SELEID_V2(isgold=FALSE, isactive=TRUE, hasmultiplesources=TRUE,isnotjustpobox=FALSE),cnt);
   Shared string40 n51	:='';
   Shared string40 n49	:='=B50';
   
   Shared string40 n31	:='=B32+B35+B40+B43+B46+B49'; //Shared string40 n31	:='=B32+B35+B40+B43+B46+B49'; //We have to shift one row to handle the worksheet header
   
   Shared string40 n52	:=(string40)SUM(Attribute_Table_SELEID_V2(isactive=FALSE),cnt); //Sum of the Not Gold Inactive Part. ?????
   Shared string40 n53	:='';
   
   Shared string40 n54	:='=B52+B31+B4';
   
  export GOLD_ds :=dataset([
   							{s1,n1},{s2,n2},{s3,n3},{s4,n4},{s5,n5},{s6,n6},{s7,n7},{s8,n8},{s9,n9},{s10,n10},{s11,n11},{s12,n12},
   							{s13,n13},{s14,n14},{s15,n15},{s16,n16},{s17,n17},{s18,n18},{s19,n19},{s20,n20},{s21,n21},{s22,n22},{s23,n23},{s24,n24},
   							{s25,n25},{s26,n26},{s27,n27},{s28,n28},{s29,n29},{s30,n30},{s31,n31},{s32,n32},{s33,n33},{s34,n34},{s35,n35},{s36,n36},
   							{s37,n37},{s38,n38},{s39,n39},{s40,n40},{s41,n41},{s42,n42},{s43,n43},{s44,n44},{s45,n45},{s46,n46},{s47,n47},{s48,n48},
   							{s49,n49},{s50,n50},{s51,n51},{s52,n52},{s53,n53},{s54,n54}
   							],GOLD);
   
	 shared path1:='~' + BIPV2_postProcess.DataCollector().superfile_version_wuid;
	 shared xx :=dataset(path1,BIPV2_postProcess.DataCollector().version_wuid_rec,flat);
	 shared wu :=(string)xx(version=pversion)[1].wuid;
	 shared rr :=wk_ut.Restore_Workunit(wu);

   shared Prox:=BIPV2_postProcess.Data_GetProxConfStat();
	 shared Lgid:=BIPV2_postProcess.Data_GetLgidConfStat();


   //output(GOLD_ds, named('GOLD'));
  export run :=sequential(
													output(rr),
													output(Prox,named('ProxConf')),
													output(Lgid,named('LgidConf')),		
													BIPV2_Findlinks.DS_Version_IterNumber.UpdateProxVersionIterNumber(),
													BIPV2_Findlinks.DS_Version_IterNumber.UpdateLgid3VersionIterNumber(),
  												output(SegmentationdsProb, named('ID_Probation')), 
													output(Segmentationds, named('ID_Segmentation')),   
													output(Data_Fill_Rates, named('Data_Fill_Rates')),
													output(GOLD_ds, named('GOLD'))
												);
end;

								