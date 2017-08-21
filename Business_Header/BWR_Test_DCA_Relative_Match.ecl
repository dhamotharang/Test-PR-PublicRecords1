ddcaash := project(dcav2.As_Business_Header(false,false)	,transform(business_header.Layout_Business_Header_Temp	,self := left,self := []));

ddcahierrel := Business_Header.BH_Relative_Match_DCA_Hierarchy(ddcaash,,,,false);
ddcahiergrp := Business_Header.BH_Relative_Match_DCA_Hierarchy(ddcaash,,business_header.persistnames().BHRelativeMatchDCAHierarchy + '.grp',,true);

ddcahierrel_filt := ddcahierrel(bdid1 != 0,bdid2 != 0);
ddcahiergrp_filt := ddcahiergrp(bdid1 != 0,bdid2 != 0);

ftable (dataset(dcav2.layouts.base.companies) pdata) := table(pdata,{rid,bdid,lncagid,lncaiid,lncaghid,file_type,rawfields.enterprise_num,rawfields.parent_enterprise_number,rawfields.company_type, rawfields.name,rawfields.root, rawfields.sub,rawfields.level,rawfields.parent_name, rawfields.parent_number});

ddca := ftable(dcav2.files().base.companies.qa);
dcaprep := {unsigned6 bdid, dataset(recordof(ddca)) dcarecs};
CombinationRecord := {unsigned6 bdid1, unsigned6 bdid2,dataset(recordof(ddca)) dcarecs};

ddca_proj := project(ddca	,transform(dcaprep,self.dcarecs := row(left,recordof(ddca)),self.bdid := left.bdid));

ddcahierrel_links1			:= join(ddca_proj	,ddcahierrel_filt
											,left.bdid = right.bdid1
											,transform(CombinationRecord,self := right,self.dcarecs := left.dcarecs)
									);

ddcahierrel_links2			:= join(ddca_proj	,ddcahierrel_links1	
											,left.bdid = right.bdid2
											,transform(CombinationRecord,self.dcarecs := left.dcarecs + right.dcarecs,self := right)
									);

ddcahiergrp_links1			:= join(ddca_proj	,ddcahiergrp_filt
											,left.bdid = right.bdid1
											,transform(CombinationRecord,self := right,self.dcarecs := left.dcarecs)
									);

ddcahiergrp_links2			:= join(ddca_proj	,ddcahiergrp_links1	
											,left.bdid = right.bdid2
											,transform(CombinationRecord,self.dcarecs := left.dcarecs + right.dcarecs,self := right)
									);

countddcahierrel := count(ddcahierrel);
countddcahiergrp := count(ddcahiergrp);

output(countddcahierrel	,named('countddcahierrel'));
output(countddcahiergrp	,named('countddcahiergrp'));

output(ddcahierrel	,named('ddcahierrel'));
output(ddcahiergrp	,named('ddcahiergrp'));

output(enth(ddcahierrel_links2,300)	,named('ddcahierrel_links2'),all);
output(enth(ddcahiergrp_links2,300)	,named('ddcahiergrp_links2'),all);
