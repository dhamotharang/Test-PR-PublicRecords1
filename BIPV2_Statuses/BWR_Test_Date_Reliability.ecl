// -- examine clusters with corp records in them  
// -- idea is that corp provides good dates
// -- so we will rate the reliability of other sources against corp.

ds_base := table(bipv2.commonbase.ds_base ,{proxid,source,string company_status_derived := if(trim(company_status_derived) = '' ,'ACTIVE',company_status_derived),proxid_status_private,unsigned6 dt_last_seen := max(group,dt_last_seen)} ,proxid,source,if(trim(company_status_derived) = '' ,'ACTIVE',company_status_derived),proxid_status_private ,merge)
  : persist('~persist::lbentley::ds_base');

ds_corp := ds_base(source in MDR.sourceTools.set_CorpV2);

ds_corp_best := table(ds_corp ,{proxid,company_status_derived,unsigned6 dt_last_seen := max(group,dt_last_seen)} ,proxid,company_status_derived ,merge);

ds_corp_best2 := dedup(sort(distribute(ds_corp_best,proxid) ,proxid,-dt_last_seen,if(company_status_derived = 'ACTIVE',1,2) ,local) ,proxid ,local);

ds_corp_clusters := join(ds_base(source not in MDR.sourceTools.set_CorpV2)  ,ds_corp_best2  ,left.proxid = right.proxid ,transform({unsigned4 corp_dt_last_seen,string corp_status,recordof(left)}
  ,self.corp_dt_last_seen := right.dt_last_seen
  ,self.corp_status       := right.company_status_derived
  ,self                   := left
)  ,hash);



/*
  how to figure out if another source agrees with corp
  1. corp has record within last two years that is active
  2. corp has record within last two years that is inactive or defunct
  3. corp has record older than two years
*/

// ut.Age
/*
source  total_clusters  agree_with_corp disagree_with_corp  agree_active  agree_inactive_or_defunct
total   
D&B DMI
LNCA
etc
*/


