import ut;
				
targus_mapped := daybatchpcnsr.Proc_targus_as_pcnsr(stringlib.stringfind(phone_number,'X',1)=0);
pcnsr         := daybatchpcnsr.file_pcnsr;

targus_with_dids    := targus_mapped(did>0);
//targus_without_dids := targus_mapped(did=0);

pcnsr_with_dids     := pcnsr(did>0);
//pcnsr_without_dids  := pcnsr(did=0);

r0 := record
 integer counter_;
 string1 source;
 targus_mapped;
end;

r0 t0(targus_mapped le, integer c) := transform
 self.counter_ := c+1;
 self.source   := 'T';
 self          := le;
end;

targus_with_counter := project(targus_mapped,t0(left,counter));
targus_no_of_recs   := max(targus_with_counter,counter_) : stored('no_of_targus_recs');

targus_dist   := distribute(targus_with_dids,hash(did,prim_range,prim_name,sec_range,zip));
pcnsr_dist    := distribute(pcnsr_with_dids ,hash(did,prim_range,prim_name,sec_range,zip));

recordof(pcnsr_dist) t_keep_pcnsr_uniques(pcnsr_dist le, targus_dist ri) := transform
 self := le;
end;

//we're essentially dropping all pcnsr records without a DID
//should be okay because we have to remove such a large amount of content
j1 := join(pcnsr_dist,targus_dist,
           left.did       =right.did        and
		   left.prim_range=right.prim_range and
		   left.prim_name =right.prim_name  and
		   left.sec_range =right.sec_range  and
		   left.zip       =right.zip        and
		   (ut.nneq(left.area_code+left.phone_number,right.area_code+right.phone_number) and left.phone_number<>''),
		   t_keep_pcnsr_uniques(left,right),
		   left only,
		   local
		  );

j1_dist := distribute(j1,hash(recency_date));
j1_sort := sort(j1_dist,-recency_date,local);

r1 := record
 integer counter_;
 string1 source;
 j1_sort;
end;

r1 t1(j1_sort le, integer c) := transform
 self.counter_ := c+1;
 self.source   := 'P';
 self          := le;
end;

p1 := project(j1_sort,t1(left,counter));

f1 := p1(counter_<targus_no_of_recs);

r2 := record
 daybatchpcnsr.Layout_PCNSR;
 string1 source;
end;

//drop the counter
pcnsr_with_source  := project(f1,r2);
targus_with_source := project(targus_with_counter,r2);

concat := (pcnsr_with_source+targus_with_source)  : persist('persist::pcnsr_keybuild');


//************************************



//macro to suppress cell phone numbers  this macro used  on " area_code and phone_number field"

layout_Extended:=record
string10 ph_temp;
r2;
end;

layout_Extended trans_Extended(concat input):=transform
 self.ph_temp:=trim(input.area_code,left,right)+trim(input.phone_number,left,right);
 self :=input;

 end;
 
 file_Extended:= project(concat,trans_Extended(left));
 
ut.mac_suppress_by_phonetype(file_Extended,ph_temp,st,pcnsr_recs_out,true,did);

r2 pcnsr_trans(pcnsr_recs_out input) := transform

		self.area_code				:= if(length(input.ph_temp)=10,input.ph_temp[1..3],'');
		self.phone_number			:= if(length(input.ph_temp)=10,input.ph_temp[4..10],input.ph_temp[length(input.ph_temp)-6 .. length(input.ph_temp)]);
		self 	          		    := input;
end;

ph_Blank1  := project(pcnsr_recs_out,pcnsr_trans(left));

 //macro to suppress cell phone numbers  this macro used  on " phone2_number "     
ut.mac_suppress_by_phonetype(ph_Blank1,phone2_number,st,pcnsr_recs_out2,true,did);


//************************************
export File_PCNSR_keybuild := pcnsr_recs_out2:persist('persist::PCNSR_Suppress_Phone');

