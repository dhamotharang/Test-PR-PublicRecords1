import Business_DOT,mdr,BIPV2,tools,BIPV2_Files; 

EXPORT fAddForeignCorpKeyStateFields(

  dataset(recordof(BIPV2_Files.files_dotid.DS_DOTID_BASE)) pDataset = Files().dotfile
  
) :=
function

dDOT_Base       := pDataset;

return  project(dDOT_Base,transform(layouts.dot_base,
  corpkey     := trim(left.company_inc_state,left,right) + '-' + trim(left.company_charter_number,left,right);
  org_struct  := left.company_org_structure_raw + left.company_org_structure_derived;

  foreign_corp_key          := if(left.company_inc_state != '' and left.company_charter_number != '' and  (left.company_foreign_domestic = 'F' or regexfind('foreign',org_struct,nocase)	),trim(left.company_inc_state,left,right) + '-' + trim(left.company_charter_number,left,right)	,'');
  domestic_corp_key         := if(left.company_inc_state != '' and left.company_charter_number != '' and ~(left.company_foreign_domestic = 'F' or regexfind('foreign',org_struct,nocase)	),trim(left.company_inc_state,left,right) + '-' + trim(left.company_charter_number,left,right)	,'');

  self.domestic_corp_key    := domestic_corp_key;

  self.AK_foreign_corp_key := if(left.company_inc_state = 'AK' ,foreign_corp_key  ,'');
  self.AL_foreign_corp_key := if(left.company_inc_state = 'AL' ,foreign_corp_key  ,'');
  self.AR_foreign_corp_key := if(left.company_inc_state = 'AR' ,foreign_corp_key  ,'');
  self.AZ_foreign_corp_key := if(left.company_inc_state = 'AZ' ,foreign_corp_key  ,'');
  self.CA_foreign_corp_key := if(left.company_inc_state = 'CA' ,foreign_corp_key  ,'');
  self.CO_foreign_corp_key := if(left.company_inc_state = 'CO' ,foreign_corp_key  ,'');
  self.CT_foreign_corp_key := if(left.company_inc_state = 'CT' ,foreign_corp_key  ,'');
  self.DC_foreign_corp_key := if(left.company_inc_state = 'DC' ,foreign_corp_key  ,'');
  self.DE_foreign_corp_key := if(left.company_inc_state = 'DE' ,foreign_corp_key  ,'');
  self.FL_foreign_corp_key := if(left.company_inc_state = 'FL' ,foreign_corp_key  ,'');
  self.GA_foreign_corp_key := if(left.company_inc_state = 'GA' ,foreign_corp_key  ,'');
  self.HI_foreign_corp_key := if(left.company_inc_state = 'HI' ,foreign_corp_key  ,'');
  self.IA_foreign_corp_key := if(left.company_inc_state = 'IA' ,foreign_corp_key  ,'');
  self.ID_foreign_corp_key := if(left.company_inc_state = 'ID' ,foreign_corp_key  ,'');
  self.IL_foreign_corp_key := if(left.company_inc_state = 'IL' ,foreign_corp_key  ,'');
  self.IN_foreign_corp_key := if(left.company_inc_state = 'IN' ,foreign_corp_key  ,'');
  self.KS_foreign_corp_key := if(left.company_inc_state = 'KS' ,foreign_corp_key  ,'');
  self.KY_foreign_corp_key := if(left.company_inc_state = 'KY' ,foreign_corp_key  ,'');
  self.LA_foreign_corp_key := if(left.company_inc_state = 'LA' ,foreign_corp_key  ,'');
  self.MA_foreign_corp_key := if(left.company_inc_state = 'MA' ,foreign_corp_key  ,'');
  self.MD_foreign_corp_key := if(left.company_inc_state = 'MD' ,foreign_corp_key  ,'');
  self.ME_foreign_corp_key := if(left.company_inc_state = 'ME' ,foreign_corp_key  ,'');
  self.MI_foreign_corp_key := if(left.company_inc_state = 'MI' ,foreign_corp_key  ,'');
  self.MN_foreign_corp_key := if(left.company_inc_state = 'MN' ,foreign_corp_key  ,'');
  self.MO_foreign_corp_key := if(left.company_inc_state = 'MO' ,foreign_corp_key  ,'');
  self.MS_foreign_corp_key := if(left.company_inc_state = 'MS' ,foreign_corp_key  ,'');
  self.MT_foreign_corp_key := if(left.company_inc_state = 'MT' ,foreign_corp_key  ,'');
  self.NC_foreign_corp_key := if(left.company_inc_state = 'NC' ,foreign_corp_key  ,'');
  self.ND_foreign_corp_key := if(left.company_inc_state = 'ND' ,foreign_corp_key  ,'');
  self.NE_foreign_corp_key := if(left.company_inc_state = 'NE' ,foreign_corp_key  ,'');
  self.NH_foreign_corp_key := if(left.company_inc_state = 'NH' ,foreign_corp_key  ,'');
  self.NJ_foreign_corp_key := if(left.company_inc_state = 'NJ' ,foreign_corp_key  ,'');
  self.NM_foreign_corp_key := if(left.company_inc_state = 'NM' ,foreign_corp_key  ,'');
  self.NV_foreign_corp_key := if(left.company_inc_state = 'NV' ,foreign_corp_key  ,'');
  self.NY_foreign_corp_key := if(left.company_inc_state = 'NY' ,foreign_corp_key  ,'');
  self.OH_foreign_corp_key := if(left.company_inc_state = 'OH' ,foreign_corp_key  ,'');
  self.OK_foreign_corp_key := if(left.company_inc_state = 'OK' ,foreign_corp_key  ,'');
  self.OR_foreign_corp_key := if(left.company_inc_state = 'OR' ,foreign_corp_key  ,'');
  self.PA_foreign_corp_key := if(left.company_inc_state = 'PA' ,foreign_corp_key  ,'');
  self.PR_foreign_corp_key := if(left.company_inc_state = 'PR' ,foreign_corp_key  ,'');
  self.RI_foreign_corp_key := if(left.company_inc_state = 'RI' ,foreign_corp_key  ,'');
  self.SC_foreign_corp_key := if(left.company_inc_state = 'SC' ,foreign_corp_key  ,'');
  self.SD_foreign_corp_key := if(left.company_inc_state = 'SD' ,foreign_corp_key  ,'');
  self.TN_foreign_corp_key := if(left.company_inc_state = 'TN' ,foreign_corp_key  ,'');
  self.TX_foreign_corp_key := if(left.company_inc_state = 'TX' ,foreign_corp_key  ,'');
  self.UT_foreign_corp_key := if(left.company_inc_state = 'UT' ,foreign_corp_key  ,'');
  self.VA_foreign_corp_key := if(left.company_inc_state = 'VA' ,foreign_corp_key  ,'');
  self.VI_foreign_corp_key := if(left.company_inc_state = 'VI' ,foreign_corp_key  ,'');
  self.VT_foreign_corp_key := if(left.company_inc_state = 'VT' ,foreign_corp_key  ,'');
  self.WA_foreign_corp_key := if(left.company_inc_state = 'WA' ,foreign_corp_key  ,'');
  self.WI_foreign_corp_key := if(left.company_inc_state = 'WI' ,foreign_corp_key  ,'');
  self.WV_foreign_corp_key := if(left.company_inc_state = 'WV' ,foreign_corp_key  ,'');
  self.WY_foreign_corp_key := if(left.company_inc_state = 'WY' ,foreign_corp_key  ,'');

  self.proxid             := if(left.proxid<>0,left.proxid,left.dotid);  
  self                    := left                                  ;
))
  ;	//to make it easier, starting from scratch is iteration 0
end;