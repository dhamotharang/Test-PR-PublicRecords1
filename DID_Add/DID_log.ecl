/* before calling this, set a stored variable as below, with one of 3 values:

       dev = 40way dev roxie (windows)

       10way = 10way dev roxie (linux)

       lin_prod = 100way production roxie (linux)
       example:

       #stored('roxie_regression_system','dev');

*/
import DID_add,DIDville,lib_WorkunitServices,lib_StringLib,lib_thorlib, _control;

export DID_log := module

//********time record********

shared    rTimeRecord   :=

       record

              unsigned8     TotalTime;
			  string        Bogus;

       end;


       rTimeRecord   tTimeRecord(rTimeRecord pInput, string pSSN, unsigned pTiming)       :=

       transform

              self.TotalTime       :=     pTiming;
              self.Bogus           :=     pSSN;

       end;

shared   fOutputWUTime(string pSSN, unsigned8 pTiming)   :=     output(project(dataset([{'', random()}], rTimeRecord), tTimeRecord(left, pSSN, pTiming)), named('ADL_Time_Log'), extend);

//********thor time logging in ROXIE batch********

//export  dologging := DID_add.do_logging;
export   fLogStartTime_roxie(dataset(DIDville.Layout_DID_InBatch) 
pPassThru, boolean dologging)    := 

     function

         if(dologging, fOutputWUTime(pPassThru[1].SSN, sum(lib_WorkunitServices.WorkunitServices.WorkunitTimings(workunit), duration)), output('no logging'));

           return pPassThru;
			 
       end;

export   fLogStopTime_roxie(dataset(DIDville.Layout_DID_OutBatch) 
pPassThru, boolean dologging)    := 

     function

         if(dologging, fOutputWUTime(pPassThru[1].SSN, sum(lib_WorkunitServices.WorkunitServices.WorkunitTimings(lib_StringLib.StringLib.StringFindReplace(lib_thorlib.thorlib.wuid() + 'AAAA', 'A', '')), duration)),
		 output('no logging'));

       return pPassThru;

       end;

	   
//********thor time logging in DID_add.MAC_Match_Flex ********
export layout_did_log := record

string9 SSN;
end;


export   fLogStartTime(dataset(layout_DID_log) 
pPassThru)    := 

     function

              fOutputWUTime(pPassThru[1].SSN, sum(lib_WorkunitServices.WorkunitServices.WorkunitTimings(workunit), duration));

             return pPassThru;
			 
			 end;

export   fLogStopTime(dataset(layout_DID_log) 
pPassThru)    := 

      function

              fOutputWUTime(pPassThru[1].SSN, sum(lib_WorkunitServices.WorkunitServices.WorkunitTimings(lib_StringLib.StringLib.StringFindReplace(lib_thorlib.thorlib.wuid() + 'AAAA', 'A', '')), duration));

            return pPassThru;

       end;

//********NOTIFY action fires the event so that the WHEN workflow service in the scheduler can proceed when dologging switch on ********

export   Mac_Notify(pPassThru, low_score_threshold, matchset, did_field,outlog,hit_thor,bool_infile_has_name_source, dologging = 'false')    := 

macro

#uniquename(rTimeRecord)
  %rTimeRecord%   :=

       record

              unsigned8     TotalTime;
			  string       Bogus;

       end;
#uniquename(dADLTimelog)
#uniquename(cnt_total)
#uniquename(cnt_did)
#uniquename(matchset_log)
#uniquename(startime)
#uniquename(stoptime)
#uniquename(ADL_route)

%dADLTimelog% := dataset(workunit('ADL_Time_Log'),%rTimeRecord%):global;
	   
%cnt_total% := count(pPassThru):global;
%cnt_did% := count(pPassThru((unsigned)did_field > 0)):global;
%matchset_log% := if('S' in matchset, 'S', '') + ' ' + 
                if('A' in matchset, 'A', '') + ' ' + 
			    if('D' in matchset, 'D', '') + ' ' +
			    if('P' in matchset, 'P', '') + ' ' + 
				if('Q' in matchset, 'Q', '') + ' ' + 
			    if('Z' in matchset, 'Z', '') + ' ' +
				if('G' in matchset, 'G', '') + ' ' +
				if('4' in matchset, '4', '') + ' ' + 
				if(bool_infile_has_name_source, 'SRC', ''):global;	
%ADL_route%    := if(hit_thor, 'THOR','ROXIE'):global;
		
//read thor time from thor time logging
%startime% := if(~hit_thor and count(%dADLTimelog%) >= 2, %dADLTimelog%[1].TotalTime, 0):global;
%stoptime% := if(~hit_thor and count(%dADLTimelog%) >= 2, %dADLTimelog%[2].TotalTime, 0):global;

outlog := if(dologging,nothor(notify('xADLlogger','<Event>  + <wuid>'+thorlib.wuid()+'</wuid>'
						  + '<jobname>'+thorlib.jobname()+'</jobname>'
						  + '<jobowner>'+thorlib.jobowner()+'</jobowner>'
						  + '<platform>'+thorlib.platform()+'</platform>'
						  + '<cluster>'+thorlib.cluster()+'</cluster>'
						  + '<count>' + %cnt_total%+ '</count>'
                          + '<DIDcount>' + %cnt_did% + '</DIDcount>'
						  //low_score_threshold is the parameter passing from external  
						  + '<threshold>'+low_score_threshold+'</threshold>'
					      + '<matchset>'+ %matchset_log% +'</matchset>'
                          + '<start>' + %startime% + '</start>'
                          + '<stop>' + %stoptime% + '</stop>'
						  + '<ADLroute>' + %ADL_route% + '</ADLroute>'
						  + '</Event>')), output('no_logging')) :global;
              

endmacro;

end;