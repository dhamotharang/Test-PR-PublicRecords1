#workunit('name','LNCA families for Tom');
ddcav2 := 
    dcav2.files().input.privco.used
 + dcav2.files().input.pub.used
 + dcav2.files().input.prv.used
 + dcav2.files().input.int.used
;

output(ddcav2);
ddcav2_slim := project(ddcav2,transform({string9 Enterprise_num,string9 Ultimate_Enterprise_number,string country}
  ,self.Enterprise_num              := left.Enterprise_num
  ,self.Ultimate_Enterprise_number  := left.Ultimate_Enterprise_number 
  ,self.country                     := left.address1.country
));

ddca_join := join(ddcav2_slim,ddcav2_slim(trim(Ultimate_Enterprise_number) != ''),left.Enterprise_num = right.Ultimate_Enterprise_number,transform(
   {recordof(left),string ult_country,string9 us_ent_num,string foreign_ent_num}
  ,self.ult_country       := right.country
  ,self.us_ent_num        := if(left.country  = ''  ,left.Enterprise_num ,'')
  ,self.foreign_ent_num   := if(left.country != ''  ,left.Enterprise_num ,'')  
  ,self                   := left
)
,left outer
,keep(1)
);

dprepit := ddca_join(trim(Ultimate_Enterprise_number) != '');

drollupult := tools.mac_AggregateFieldsPerID(dprepit  ,Ultimate_Enterprise_number);
output(drollupult);

dprojUS := project(drollupult(ult_countrys[1].ult_country = ''),transform(
  {string mtype,unsigned Family_Tree_Size}
  ,self.Family_Tree_Size          := count(left.us_ent_nums)
  ,self.mtype                     := 'US'
));

dprojAll := project(drollupult,transform(
  {string mtype,unsigned Family_Tree_Size}
  ,self.Family_Tree_Size          := count(left.Enterprise_nums)
  ,self.mtype                     := 'all'
));

dconcatall := dprojUS + dprojAll;
  
dproj2 := project(dconcatall ,transform(
   {unsigned size,string Family_Tree_Size,unsigned Total_Number_of_Families,unsigned US_Families}
   ,self.size := map(left.Family_Tree_Size in [1,2,3,4]       => left.Family_Tree_Size
                                        ,left.Family_Tree_Size between 5   and 9    => 6
                                        ,left.Family_Tree_Size between 10  and 24   => 11 
                                        ,left.Family_Tree_Size between 25  and 49   => 21 
                                        ,left.Family_Tree_Size between 50  and 99   => 51 
                                        ,left.Family_Tree_Size between 100 and 299  => 101
                                        ,left.Family_Tree_Size between 300 and 999  => 501
                                        ,left.Family_Tree_Size               > 1000 => 1001
                                        ,left.Family_Tree_Size
                                     );
  ,self.Family_Tree_Size          := map(left.Family_Tree_Size in [1,2,3,4]       => (string)left.Family_Tree_Size + ' members'
                                        ,left.Family_Tree_Size between 5   and 9    => '5 - 9 members'
                                        ,left.Family_Tree_Size between 10  and 24   => '10 - 24 members'
                                        ,left.Family_Tree_Size between 25  and 49   => '25 - 49 members'
                                        ,left.Family_Tree_Size between 50  and 99   => '50 - 99 members'
                                        ,left.Family_Tree_Size between 100 and 299  => '100 - 299 members'
                                        ,left.Family_Tree_Size between 300 and 999  => '300 - 999 members'
                                        ,left.Family_Tree_Size               > 1000 => '> 1000 members'
                                        ,(string)left.Family_Tree_Size + ' members'
                                     )
  ,self.Total_Number_of_Families := if(left.mtype = 'all',1,0)
  ,self.US_Families              := if(left.mtype = 'US',1,0)
));


dtable := project(sort(table(dproj2 ,{size,Family_Tree_Size,unsigned Total_Number_of_Families := sum(group,Total_Number_of_Families),unsigned US_Families := sum(group,US_Families)} ,size,Family_Tree_Size,few),size)
,{recordof(left) - size});

output(ddcav2_slim ,named('ddcav2_slim'));
output(drollupult ,named('drollupult'));
output(dprojUS ,named('dprojUS'));
output(dprojAll ,named('dprojAll'));
output(dconcatall ,named('dconcatall'));
output(dproj2 ,named('dproj2'));
output(dtable ,named('BreakdownOfFamiliesAndMembers'),all);
