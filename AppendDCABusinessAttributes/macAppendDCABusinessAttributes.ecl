EXPORT macAppendDCABusinessAttributes(dIn, InUltId, InOrgId, InSeleId,
  appendPrefix = '\'\'', UseIndexThreshold=20000000) := FUNCTIONMACRO
  
  IMPORT DCAV2, hipie_ecl, ut;
   
  LOCAL dDistributed    := DISTRIBUTE(dIn((UNSIGNED)InUltId <> 0), HASH32(InUltId));
  LOCAL rSearch := {RECORDOF(dIn) OR {INTEGER _searchUlt,INTEGER _searchOrg,INTEGER _searchSele}};
  LOCAL dSearch := PROJECT(dDistributed, TRANSFORM(rSearch,
    SELF._searchUlt   := (INTEGER)LEFT.InUltId,
    SELF._searchOrg   := (INTEGER)LEFT.InOrgId,
    SELF._searchSele  := (INTEGER)LEFT.InSeleId,
    SELF := LEFT));
  LOCAL dDeduped        := DEDUP(SORT(dSearch, InUltId, InSeleId, LOCAL), InUltId, InSeleId, LOCAL);
  
  LOCAL dBipDca := hipie_ecl.macJoinKey(dDeduped, DCAV2.Key_Linkids.Key,
    'KEYED((UNSIGNED)LEFT._searchUlt = RIGHT.UltId) AND	WILD(RIGHT.OrgId) AND	KEYED((UNSIGNED)LEFT._searchSele = RIGHT.SeleId)', 
    'LEFT.UltID = (UNSIGNED)RIGHT._searchUlt AND LEFT.SeleID = (UNSIGNED)RIGHT._searchSele', 
    UseIndexThreshold,,true,25000); 
    
  LOCAL rDcaLayout := RECORD
    dBipDca.InUltId;
    dBipDca.InOrgId;
    dBipDca.InSeleId;
    STRING    enterprise_num    := dBipDca.rawfields.enterprise_num; //100%
    INTEGER    num_employees    := MAX(GROUP,dBipDca.rawfields.emp_num);//68%
    STRING    sales_or_revenue  := dBipDca.rawfields.sales_desc;//32%
    INTEGER    sales            := MAX(GROUP,dBipDca.rawfields.sales);//32%
    INTEGER    earnings         := MAX(GROUP,dBipDca.rawfields.earnings);//3%
    INTEGER    net_worth        := MAX(GROUP,dBipDca.rawfields.net_worth);//3%
    INTEGER    assets           := MAX(GROUP,dBipDca.rawfields.assets);//3%
    INTEGER    liabilities      := MAX(GROUP,dBipDca.rawfields.liabilities);//3%
    STRING    bus_desc          := dBipDca.rawfields.bus_desc;//99%
    STRING    comp_type         := dBipDca.rawfields.company_type;//23%
    STRING    update_date       := MAX(GROUP,dBipDca.rawfields.update_date);//99%
  END;

  LOCAL dDcaTable := DISTRIBUTE(TABLE(dBipDca,rDcaLayout, InUltId, InSeleId, MERGE), HASH32(InUltId));
  
  LOCAL rOut := RECORD
    RECORDOF(dIn);
    STRING #EXPAND(appendPrefix + 'EnterpriseNumber');
    STRING #EXPAND(appendPrefix + 'BusinessDescription');
    STRING #EXPAND(appendPrefix + 'CompanyType');
    INTEGER #EXPAND(appendPrefix + 'NumberOfEmployees');
    STRING #EXPAND(appendPrefix + 'SalesOrRevenue');
    INTEGER #EXPAND(appendPrefix + 'Sales');
    INTEGER #EXPAND(appendPrefix + 'Earnings');
    INTEGER #EXPAND(appendPrefix + 'NetWorth');
    INTEGER #EXPAND(appendPrefix + 'Assets');
    INTEGER #EXPAND(appendPrefix + 'Liabilities');
    STRING #EXPAND(appendPrefix + 'UpdateDate');
  END;
  
  LOCAL dOut := JOIN(dDistributed,dDcaTable,
    LEFT.InUltId = RIGHT.InUltId
    AND LEFT.InSeleId = RIGHT.InSeleId,
    TRANSFORM(rOut,
      SELF := LEFT,
      SELF.#EXPAND(appendPrefix + 'EnterpriseNumber')   := RIGHT.enterprise_num,
      SELF.#EXPAND(appendPrefix + 'BusinessDescription'):= RIGHT.bus_desc,
      SELF.#EXPAND(appendPrefix + 'CompanyType')        := RIGHT.comp_type,
      SELF.#EXPAND(appendPrefix + 'NumberOfEmployees')  := (INTEGER)RIGHT.num_employees,
      SELF.#EXPAND(appendPrefix + 'SalesOrRevenue')     := ut.cleanSpacesAndUpper(RIGHT.sales_or_revenue),
      SELF.#EXPAND(appendPrefix + 'Sales')              := (INTEGER)RIGHT.sales,
      SELF.#EXPAND(appendPrefix + 'Earnings')           := (INTEGER)RIGHT.earnings,
      SELF.#EXPAND(appendPrefix + 'NetWorth')           := (INTEGER)RIGHT.net_worth,
      SELF.#EXPAND(appendPrefix + 'Assets')             := (INTEGER)RIGHT.assets,
      SELF.#EXPAND(appendPrefix + 'Liabilities')        := (INTEGER)RIGHT.liabilities,
      SELF.#EXPAND(appendPrefix + 'UpdateDate')         := REGEXREPLACE('[^[:print:]]',RIGHT.update_date,'')),
    LEFT OUTER,
    LIMIT(0),KEEP(1), LOCAL)
    + PROJECT(dIn((UNSIGNED)InUltId = 0), TRANSFORM(rOut,
        SELF := LEFT, SELF := []));
        
  RETURN dOut;
ENDMACRO;