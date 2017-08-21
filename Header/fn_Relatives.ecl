import business_header;

export fn_Relatives(
	dataset(header.Layout_Header) h,
	dataset(header.layout_relatives_v2.main) r,
	boolean IncludeOutsideMatches = true	
	) := 
FUNCTION

Relatives_By_Address0:=Relatives_By_Address(h):persist('Relatives_By_Address'); 
j :=     Relatives_By_Address0 +																					//prim_range is actual prim_range or -3
	     Relatives_By_SSN(h) + 																								//prim_range:=-1
		 Relatives_By_Relatives(r) + 																				//prim_range:=-2
		 if(IncludeOutsideMatches, business_header.Business_Associates) +		//prim_range:=-4
		 if(IncludeOutsideMatches, Relatives_By_Property) +									//prim_range is -5.
		 if(IncludeOutsideMatches, Relatives_By_Vehiclev2) +										//prim_range is -6.
		 if(IncludeOutsideMatches, Relatives_By_Spouse)							//prim_range is -7.
		 ;

// work around for platform bug
dj_0 := distribute(j(number_cohabits>0),hash(person1,person2));
dj_1 := project(NOFOLD(dj_0)
				,transform({layout_relatives_v2.temp,string1 dummy:=''}
					,self.dummy:=if(left.person1>1000,'x','y')
					,self:=left));

dj := Header.fn_map_relatives_v2(dj_1); 

gj := group(dj,person1,person2,all);

sg := sort(gj,prim_range,IF(same_lname,0,1),-number_cohabits,zip, record);

rolls := rollup(sg,true, header.tra_roll_relatives(left,right));

out := ungroup(rolls(same_lname OR number_cohabits>=6));

// append history flag and keep full history

relatives_current_:= project(out,transform(layout_relatives_v2.main ,self.dt_last_relative := if(left.number_cohabits>=6 ,(unsigned) header.version_build[1..6], left.dt_last_relative),self:= left)); 

relatives_current:=fn_iRelatives(relatives_current_);

relatves_all := join(distribute(relatives_current,hash(person1)),distribute(File_Relatives_full,hash(person1)),
                        left.person1=right.person1
                        and left.person2=right.person2,
						transform(layout_relatives_v2.main
							,self.current_relatives := if( left.person1 <> 0 ,true,false)
							,self:= if(left.person1 <>0,left,right))
						,full outer
						,local);
						
return dedup(relatves_all,record,all,local); 

END;