import std;

EXPORT Compile_Workunits_Ds(

   string pLowWuid
  ,string pHighWuid
  ,string pJobname
  ,string pOwner    = ''
  ,string pCluster  = ''

) :=
function

  dgetwuidlist := global(nothor(STD.System.Workunit.WorkunitList (
   pLowWuid      
  ,pHighWuid             
  ,pOwner       
  ,pCluster   
  ,pJobname        
  ,//pState      
  ,//pPriority  
  ,//pFileread  
  ,//pFilewritten   
  ,//pRoxiecluster  
  ,//pEclcontains   
  ,//pOnline        
  ,//pArchived      
  )),few)(wuid != '');      
  
  //do up to 20 for now
  wuid1  := iff(count(dgetwuidlist) >= 1  and dgetwuidlist[1 ].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[1 ].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[1 ].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid2  := iff(count(dgetwuidlist) >= 2  and dgetwuidlist[2 ].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[2 ].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[2 ].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid3  := iff(count(dgetwuidlist) >= 3  and dgetwuidlist[3 ].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[3 ].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[3 ].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid4  := iff(count(dgetwuidlist) >= 4  and dgetwuidlist[4 ].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[4 ].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[4 ].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid5  := iff(count(dgetwuidlist) >= 5  and dgetwuidlist[5 ].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[5 ].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[5 ].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid6  := iff(count(dgetwuidlist) >= 6  and dgetwuidlist[6 ].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[6 ].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[6 ].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid7  := iff(count(dgetwuidlist) >= 7  and dgetwuidlist[7 ].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[7 ].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[7 ].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid8  := iff(count(dgetwuidlist) >= 8  and dgetwuidlist[8 ].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[8 ].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[8 ].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid9  := iff(count(dgetwuidlist) >= 9  and dgetwuidlist[9 ].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[9 ].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[9 ].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid10 := iff(count(dgetwuidlist) >= 10 and dgetwuidlist[10].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[10].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[10].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  
  wuid11 := iff(count(dgetwuidlist) >= 11 and dgetwuidlist[11].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[11].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[11].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid12 := iff(count(dgetwuidlist) >= 12 and dgetwuidlist[12].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[12].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[12].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid13 := iff(count(dgetwuidlist) >= 13 and dgetwuidlist[13].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[13].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[13].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid14 := iff(count(dgetwuidlist) >= 14 and dgetwuidlist[14].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[14].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[14].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid15 := iff(count(dgetwuidlist) >= 15 and dgetwuidlist[15].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[15].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[15].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid16 := iff(count(dgetwuidlist) >= 16 and dgetwuidlist[16].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[16].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[16].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid17 := iff(count(dgetwuidlist) >= 17 and dgetwuidlist[17].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[17].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[17].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid18 := iff(count(dgetwuidlist) >= 18 and dgetwuidlist[18].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[18].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[18].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid19 := iff(count(dgetwuidlist) >= 19 and dgetwuidlist[19].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[19].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[19].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid20 := iff(count(dgetwuidlist) >= 20 and dgetwuidlist[20].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[20].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[20].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));

  wuid21 := iff(count(dgetwuidlist) >= 21 and dgetwuidlist[21].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[21].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[21].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid22 := iff(count(dgetwuidlist) >= 22 and dgetwuidlist[22].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[22].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[22].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid23 := iff(count(dgetwuidlist) >= 23 and dgetwuidlist[23].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[23].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[23].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid24 := iff(count(dgetwuidlist) >= 24 and dgetwuidlist[24].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[24].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[24].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid25 := iff(count(dgetwuidlist) >= 25 and dgetwuidlist[25].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[25].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[25].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid26 := iff(count(dgetwuidlist) >= 26 and dgetwuidlist[26].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[26].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[26].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid27 := iff(count(dgetwuidlist) >= 27 and dgetwuidlist[27].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[27].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[27].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid28 := iff(count(dgetwuidlist) >= 28 and dgetwuidlist[28].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[28].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[28].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid29 := iff(count(dgetwuidlist) >= 29 and dgetwuidlist[29].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[29].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[29].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid30 := iff(count(dgetwuidlist) >= 30 and dgetwuidlist[30].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[30].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[30].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));

  wuid31 := iff(count(dgetwuidlist) >= 31 and dgetwuidlist[31].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[31].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[31].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid32 := iff(count(dgetwuidlist) >= 32 and dgetwuidlist[32].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[32].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[32].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid33 := iff(count(dgetwuidlist) >= 33 and dgetwuidlist[33].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[33].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[33].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid34 := iff(count(dgetwuidlist) >= 34 and dgetwuidlist[34].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[34].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[34].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid35 := iff(count(dgetwuidlist) >= 35 and dgetwuidlist[35].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[35].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[35].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid36 := iff(count(dgetwuidlist) >= 36 and dgetwuidlist[36].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[36].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[36].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid37 := iff(count(dgetwuidlist) >= 37 and dgetwuidlist[37].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[37].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[37].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid38 := iff(count(dgetwuidlist) >= 38 and dgetwuidlist[38].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[38].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[38].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid39 := iff(count(dgetwuidlist) >= 39 and dgetwuidlist[39].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[39].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[39].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid40 := iff(count(dgetwuidlist) >= 40 and dgetwuidlist[40].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[40].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[40].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));

  wuid41 := iff(count(dgetwuidlist) >= 41 and dgetwuidlist[41].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[41].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[41].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid42 := iff(count(dgetwuidlist) >= 42 and dgetwuidlist[42].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[42].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[42].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid43 := iff(count(dgetwuidlist) >= 43 and dgetwuidlist[43].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[43].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[43].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid44 := iff(count(dgetwuidlist) >= 44 and dgetwuidlist[44].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[44].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[44].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid45 := iff(count(dgetwuidlist) >= 45 and dgetwuidlist[45].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[45].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[45].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid46 := iff(count(dgetwuidlist) >= 46 and dgetwuidlist[46].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[46].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[46].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid47 := iff(count(dgetwuidlist) >= 47 and dgetwuidlist[47].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[47].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[47].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid48 := iff(count(dgetwuidlist) >= 48 and dgetwuidlist[48].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[48].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[48].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid49 := iff(count(dgetwuidlist) >= 49 and dgetwuidlist[49].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[49].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[49].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  wuid50 := iff(count(dgetwuidlist) >= 50 and dgetwuidlist[50].wuid != '' and regexfind('rows',WorkMan.get_Scalar_Result(dgetwuidlist[50].wuid,'Workunits'),nocase),WorkMan.get_DS_Result(dgetwuidlist[50].wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));

  dconcat := 
  
    wuid1 
  + wuid2 
  + wuid3 
  + wuid4 
  + wuid5 
  + wuid6 
  + wuid7 
  + wuid8 
  + wuid9 
  + wuid10
  
  + wuid11
  + wuid12
  + wuid13
  + wuid14
  + wuid15
  + wuid16
  + wuid17
  + wuid18
  + wuid19
  + wuid20

  + wuid21  
  + wuid22  
  + wuid23  
  + wuid24  
  + wuid25  
  + wuid26  
  + wuid27  
  + wuid28  
  + wuid29  
  + wuid30  
    
  + wuid31  
  + wuid32  
  + wuid33  
  + wuid34  
  + wuid35  
  + wuid36  
  + wuid37  
  + wuid38
  + wuid39
  + wuid40
    
  + wuid41
  + wuid42
  + wuid43
  + wuid44
  + wuid45
  + wuid46
  + wuid47
  + wuid48
  + wuid49
  + wuid50
  ;
  
  dsort     := sort(dconcat,wuid);
  dproj     := project(dsort,transform(recordof(left),self.Run_Total_Time_secs := left.total_time_secs,self := left));
  diterate  := iterate(dproj,transform(recordof(left),self.Run_Total_Time_secs := left.Run_Total_Time_secs + right.Run_Total_Time_secs,self.Run_Total_Thor_Time := WorkMan.ConvertSecs2ReadableTime((real8)self.Run_Total_Time_secs),self := right)); 
  
  // dgetworkunits := project(dgetwuidlist,transform({dataset(WorkMan.layouts.wks_slim) workunits}
    // ,self.workunits := if(WorkMan.get_Scalar_Result(left.wuid,'Workunits') != '',WorkMan.get_DS_Result(left.wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim))  ));
  // dnorm := normalize(dgetworkunits,left.workunits,transform(WorkMan.layouts.wks_slim,self := right));


  // dgetworkunits := project(dgetwuidlist,transform({dataset(WorkMan.layouts.wks_slim) workunits}
    // ,self.workunits := if(WorkMan.get_Scalar_Result(left.wuid,'Workunits') != '',WorkMan.get_DS_Result(left.wuid,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim))  ));
  // dnorm := normalize(dgetworkunits,left.workunits,transform(WorkMan.layouts.wks_slim,self := right));
  // thiswuid            := if(WorkMan.get_Scalar_Result(pWuid       ,'Workunits',pesp) != '',WorkMan.get_DS_Result(pWuid        ,'Workunits',WorkMan.layouts.wks_slim),dataset([],WorkMan.layouts.wks_slim));
  // Run_Total_Time_secs := sum(thiswuid,Total_Time_secs) + thor_time_secs;
  // Run_Total_Thor_Time := WorkMan.ConvertSecs2ReadableTime((real8)Run_Total_Time_secs);
  
  return iff(count(dgetwuidlist) > 50 ,output('The number of wuids is over 50.  it is ' + (string)count(dgetwuidlist)) ,output(diterate,all));


end;