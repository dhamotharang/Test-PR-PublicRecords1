import header,codes,mdr,drivers,_control,infutor;

string20 var1 := '' : stored('watchtype');

hdr        := header.File_Headers       (mdr.sourcetools.sourceisonprobation(src)=false);
hdr_nonglb := header.File_Headers_NonGLB(mdr.sourcetools.sourceisonprobation(src)=false);

//could have changed the function to not return everything else
//but instead decided to filter what's going in just in case future processes have need for it as well
//before this in fil_header's default option you can basically end up with 3 headers

dppa_three := drivers.state_dppa_ok_thor(hdr(mdr.sourcetools.sourceisdppa(src)=true),'3');
dppa_four  := drivers.state_dppa_ok_thor(hdr(mdr.sourcetools.sourceisdppa(src)=true),'4');
dppa_six   := drivers.state_dppa_ok_thor(hdr,'6');
									   			   
fil_header := map(var1='nonglb'	      =>hdr_nonglb(~mdr.Source_is_DPPA(src)),
				  //non_glb non equifax
				  //var1='nonglb_noneq' =>hdr_nonglb(~mdr.Source_is_DPPA(src) and src<>'EQ'),
				  var1='marketing'    =>project(hdr_nonglb(mdr.Source_is_Marketing_Eligible(src,vendor_id,st,county)),transform({recordof(hdr)},self.dob:=if(left.src='TS',0,left.dob),self:=left)) + infutor.infutor_into_watchdog,
				  var1='compid'	      =>dppa_six(src<>'EQ' or header.isPreGLB(dppa_six)),
				  //non equifax
				  //var1='glb_noneq'    =>(hdr(~mdr.Source_is_DPPA(src))+dppa_three+dppa_four)(src<>'EQ'), 
                  //non experian											  
				  var1='glb_nonen'    =>(hdr(~mdr.Source_is_DPPA(src))+dppa_three+dppa_four)(src<>'EN'),						  
				  hdr(~mdr.Source_is_DPPA(src))+dppa_three+dppa_four
				 );
				   
dup_for_dppa       := dedup(sort(distribute(fil_header,hash(did,rid)),did,rid,local),did,rid,local);
back_from_the_dead := header.fn_remove_deaths_not_in_death_master(dup_for_dppa);
							  
//write files for _nonblank keys
write_outs := if(var1='nonglb',output(back_from_the_dead,,'~thor400_84::out::watchdog_filtered_header_nonglb',__compressed__,overwrite),
              if(var1='',      output(back_from_the_dead,,'~thor400_84::out::watchdog_filtered_header',       __compressed__,overwrite) 
		      ));

sequential(write_outs);
	
export file_header_filtered := back_from_the_dead : persist('~thor400_84::persist::watchdog_filtered_header',_control.TargetQueue.adl_400);