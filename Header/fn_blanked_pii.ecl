import ut,Std,PromoteSupers;

EXPORT fn_blanked_pii(string filedate) := function

b:=Header.File_Previous_Header_Raw(fname<>'',lname<>'');
a:=Header.File_Latest_Header_Raw()(fname<>'',lname<>'');

j:=join(distribute(b,hash(rid)),distribute(a,hash(rid))
				,left.rid=right.rid
				,transform(left)
				,left only
				,local
				);

dt:=Std.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE), '%F%H%M%S%u'):independent;
r:={string17 eventstamp,header.Layout_Header};
p:=project(j
			,transform(r
				,self.eventstamp:=dt
				,self:=left)
			);

d:= p + Header.File_header_raw_blanked_history;

PromoteSupers.MAC_SF_BuildProcess(d,'~thor400_data::base::header_raw_blanked_history',bing,3,,true,pVersion:=filedate);

t:=table(d,{src,cnt:=count(group)},src,few);
t1:=table(p,{src,cnt:=count(group)},src,few);
smp:=dedup(sort(p,src,skew(1)),src,keep(5));
return parallel(
								bing
								,output(t,named('All_Blanked_by_src_cnt'),all)
								,output(t1,named('New_Blanked_by_src_cnt'),all)
								,output(smp,named('New_Blanked_by_src_smp'),all)
								);

End;