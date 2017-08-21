EXPORT fn_iRelatives(dataset(layout_relatives_v2.main) boca_relatives) := function

h:=dedup(header.File_Headers,did,all,local);
i:=header.File_Relatives_Insurance(true)(copolicy_cnt>0);

i1:=join(h,distribute(i,hash(did1))
			,left.did=right.did1
			,transform(right)
			,local);

i2:=join(h,distribute(i1,hash(did2))
			,left.did=right.did2
			,transform(right)
			,local);

i3:=project(i2
			,transform(header.layout_relatives_v2.main
				,self.person1:=if(left.did1>left.did2,left.did1,left.did2)
				,self.person2:=if(left.did1>left.did2,left.did2,left.did1)
				,self.same_lname:=left.lname_score>0
				,self.nbr_of_addresses:=left.cohabit_cnt
				,self.shared_addr_score:=left.cohabit_score
				,self.relative_matches:= stringlib.stringcleanspaces(
												'IR '
												+if(left.cohabit_cnt>0,'addr-'+trim((string)left.cohabit_cnt)+' ','')
												+if(left.cossn_cnt>0,'ssn-'+trim((string)left.cossn_cnt)+' ','')
												+if(left.copolicy_cnt>0,'pol-'+trim((string)left.copolicy_cnt)+' ','')
												+if(left.total_cnt>0,'tot-'+trim((string)left.total_cnt),'')
												)
				,self.relatives_match_score:= stringlib.stringcleanspaces(
												if(left.cohabit_score>0,'addr-'+trim((string)left.cohabit_score)+' ','')
												+if(left.cossn_score>0,'ssn-'+trim((string)left.cossn_score)+' ','')
												+if(left.copolicy_score>0,'pol-'+trim((string)left.copolicy_score)+' ','')
												+if(left.lname_score>0,'lna-'+trim((string)left.lname_score)+' ','')
												+if(left.total_score>0,'tot-'+trim((string)left.total_score),'')
												)
				,self.number_cohabits:=left.total_score
				,self.dt_last_relative := (unsigned) header.version_build[1..6]
				,self.current_relatives:=true
				,self:=[]));

all_Relatives:=join(distribute(boca_relatives,hash(person1)),dedup(distribute(i3,hash(person1)),person1,person2,all,local)
			,   left.person1=right.person1
			and left.person2=right.person2
			,transform(header.layout_relatives_v2.main
					,self.current_relatives:=if(right.person1>0,true,left.current_relatives)
					,self.number_cohabits:=map(left.person1=right.person1 => left.number_cohabits + 6
											  ,right.person1=0 => left.number_cohabits
											  ,right.number_cohabits)
					,self.relatives_match_score:=map(left.person1=right.person1 => 'IR'+trim(left.relatives_match_score)
											  ,right.person1=0 => left.relatives_match_score
											  ,right.relatives_match_score)
					,self:=if(left.person1>0,left,right)
					)
			,full outer
			,local);

return all_Relatives;

end;