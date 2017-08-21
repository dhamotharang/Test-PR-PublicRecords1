
//dHeader	:=	dataset('~thor_data400::base::headerw20060831-103941',header.Layout_Header,flat);
dHeader	:=	dataset('~thor_data400::base::headerw20060907-172112',header.Layout_Header,flat);

dRelatives := dataset('~thor_data400::base::relatives',header.layout_relatives,flat);
//output(ds);

rSlimHeader := record
 dHeader.did;
 unsigned3 count_ := 1;
end;

rSlimHeader tSlimHeader(dHeader l) := transform
 self := l;
end;

dSlimHeader_      := project(   dHeader,tSlimHeader(left));
dSlimHeader_dist  := distribute(dSlimHeader_,hash(did));
dSlimHeader_sort  := sort(      dSlimHeader_dist, did,local);
//dSlimHeader_dedup := dedup(     dSlimHeader_sort,did,local);

rSlimHeader tRollupSlimHeader(dSlimHeader_sort l, dSlimHeader_sort r) := transform
 self.count_ := l.count_ + 1;
 self        := l;
end;

dSlimHeader             := rollup(dSlimHeader_sort,left.did=right.did,tRollupSlimHeader(left,right));
dSlimHeader_Fragment    := dSlimHeader(count_<=1);
dSlimHeader_notFragment := dSlimHeader(count_>1);

output(count(dSlimHeader),            named('Unique_ADLs_0907'));
output(count(dSlimHeader_Fragment),   named('Fragmented_Unique_ADLs_0907'));
output(count(dSlimHeader_notFragment),named('NonFragmented_Unique_ADLs_0907'));


rNormRelatives := record
 //relatives orig fields are unsigned5 but changed mapped to unsigned6 b/c header did is that datatype
 unsigned6 person;
end;

rNormRelatives tNormRelatives(dRelatives l, integer c) := transform
 self.person := choose(c,l.person1,l.person2);
end;

dNormRelatives       := normalize( dRelatives,2,tNormRelatives(left,counter));
dNormRelatives_dist  := distribute(dNormRelatives,hash(person));
dNormRelatives_sort  := sort(      dNormRelatives_dist,person,local);
dNormRelatives_dedup := dedup(     dNormRelatives_sort,person,local);

rNormRelatives tKeepnonFragmentedRelatives(dSlimHeader_notFragment l, dNormRelatives_dedup r) := transform
 self := r;
end;

dNonFragmentedRelatives := join(dSlimHeader_notFragment,dNormRelatives_dedup,
                                left.did=right.person,
								tKeepnonFragmentedRelatives(left,right)
							    ,local
							   );

rSlimHeader tADLhasRelative(dSlimHeader_notFragment l, dNonFragmentedRelatives r) := transform
 self := l;
end;

dADLhasRelative := join(dSlimHeader_notFragment,dNonFragmentedRelatives,
                        left.did=right.person,
						tADLhasRelative(left,right)
						,local
					   );
output(count(dADLhasRelative),named('NonFragmented_ADLs_with_Relatives_0907'));

dADLhasNoRelative := join(dSlimHeader_notFragment,dNonFragmentedRelatives,
                          left.did=right.person,
			    		  tADLhasRelative(left,right),
						  left only
					      ,local
						  );
output(count(dADLhasNoRelative),named('NonFragmented_ADLs_with_No_Relatives_0907'));