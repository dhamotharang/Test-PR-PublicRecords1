/*2017-02-28T09:45:43Z (Wendy Ma)
DF-18485
*/
/*2016-10-30T21:15:38Z (Wendy Ma)
DF-17551 adding FCRA best 
*/
import header,codes,mdr,drivers,_control,infutor, AID, ut, FCRA_list,dx_header;

// adjust layout for CCPA and 
ccpa (in_hdr) := FUNCTIONMACRO
    
    #UNIQUENAME(with_global_sid);
    %with_global_sid%:=PROJECT(in_hdr,                                          TRANSFORM({dx_header.layout_header},SELF:=LEFT));
    RETURN             PROJECT(header.fn_suppress_ccpa(%with_global_sid%,TRUE), TRANSFORM({header.layout_header}   ,SELF:=LEFT));

ENDMACRO;


string20 var1 := '' : stored('watchtype');
fcrahdr_list := ccpa(FCRA_list.file_base);
fcrahdr      := ccpa(watchdog.Prep_FCRA_header);
hdr          := ccpa(Files_ReCleaned .Header_(mdr.sourcetools.sourceisonprobation(src)=false));
hdr_nonglb   := ccpa(Files_ReCleaned .Header_NonGLB(mdr.sourcetools.sourceisonprobation(src)=false));

//could have changed the function to not return everything else
//but instead decided to filter what's going in just in case future processes have need for it as well
//before this in fil_header's default option you can basically end up with 3 headers

dppa_three := drivers.state_dppa_ok_thor(hdr(mdr.sourcetools.sourceisdppa(src)=true),'3');
dppa_four  := drivers.state_dppa_ok_thor(hdr(mdr.sourcetools.sourceisdppa(src)=true),'4');
dppa_six   := drivers.state_dppa_ok_thor(hdr,'6');


hdr4mktng0:=hdr_nonglb(mdr.Source_is_Marketing_Eligible(src,vendor_id,st,county,dt_nonglb_last_seen,dt_first_seen));
hdr4mktng:=project(hdr4mktng0,transform({hdr4mktng0},self.dob:=if(left.src='TS',0,left.dob),self:=left)) 
           + project(Files_ReCleaned.infutor_,transform(recordof(left),self.ssn := '',self:=LEFT),local)
					 + Files_ReCleaned.infutor_narc;


fil_header := map(var1='nonglb'             => hdr_nonglb(~mdr.Source_is_DPPA(src))
									,var1='nonglb_noneq'			=> hdr_nonglb(~mdr.Source_is_DPPA(src) AND src<>'EQ')
									,var1='marketing'         => hdr4mktng
									,var1='marketing_noneq'		=> hdr4mktng(~mdr.sourceTools.SourceIsEquifax(src))
									,var1='glb_noneq'         => (hdr(~mdr.Source_is_DPPA(src)) + dppa_three + dppa_four)(src<>'EQ') 
									,var1='glb_nonen'         => (hdr(~mdr.Source_is_DPPA(src)) + dppa_three + dppa_four)(src<>'EN')
                  ,var1='glb_nonen_noneq'   => (hdr(~mdr.Source_is_DPPA(src)) + dppa_three + dppa_four)(src not in ['EN', 'EQ'])
									,var1='nonutility'        => (hdr(~mdr.Source_is_DPPA(src)) + dppa_three + dppa_four)(header.translateSource(src)<>'Utilities')
                  ,var1='nonglb_nonutility'	=> hdr_nonglb(~mdr.Source_is_DPPA(src) and header.translateSource(src)<>'Utilities')
                  ,var1='fcra_best_append'	=> fcrahdr_list
									,var1='fcra_best_nonEN'	  => fcrahdr(src<>'EN')
                  ,var1='fcra_best_nonEQ'	  => fcrahdr(src<>'EQ') 
									,                            hdr(~mdr.Source_is_DPPA(src)) + dppa_three + dppa_four
									);

dup_for_dppa       := dedup(sort(distribute(fil_header,hash(did,rid)),did,rid,local),did,rid,local);
back_from_the_dead0 := header.fn_remove_deaths_not_in_death_master(dup_for_dppa) : independent;
							  
//write files for _nonblank keys
write_outs := if(var1='nonglb',output(back_from_the_dead0,,'~thor400_84::out::watchdog_filtered_header_nonglb',__compressed__,overwrite),
							if(var1='nonglb_noneq',output(back_from_the_dead0,,'~thor400_84::out::watchdog_filtered_header_nonglb_noneq',__compressed__,overwrite),
              if(var1='glb',      output(back_from_the_dead0,,'~thor400_84::out::watchdog_filtered_header',       __compressed__,overwrite), 
              if(var1='nonutility', output(back_from_the_dead0,,'~thor400_84::out::watchdog_filtered_header_nonutil',       __compressed__,overwrite), 
              if(var1='glb_nonen',output(back_from_the_dead0,,'~thor400_84::out::watchdog_filtered_header_nonen',__compressed__,overwrite),
							if(var1='glb_noneq',output(back_from_the_dead0,,'~thor400_84::out::watchdog_filtered_header_noneq',__compressed__,overwrite), 
							if(var1='glb_nonen_noneq',output(back_from_the_dead0,,'~thor400_84::out::watchdog_filtered_header_nonen_noneq',__compressed__,overwrite)
				)))))));
			  
back_from_the_dead := back_from_the_dead0 : success(sequential(write_outs));

export file_header_filtered := distribute(back_from_the_dead,hash(did)) : persist('persist::watchdog_filtered_header');