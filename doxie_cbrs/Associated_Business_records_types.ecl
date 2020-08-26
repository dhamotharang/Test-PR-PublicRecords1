abd := doxie_cbrs.Associated_Business_bdids(TRUE); //KEEP ALL to find best info, LIMIT before OUTPUT

assoc_rec := doxie_cbrs.layout_Association_type;

prep_rec := RECORD
  UNSIGNED6 bdid;
  BOOLEAN isInOAA;
  doxie_cbrs.layout_relative_booleans;
  // dataset(assoc_rec) association_children;
END;

translate_type(abd d) :=
  DATASET([
    {IF(d.corp_charter_number,'Corporate Charter Number','')},
    {IF(d.business_registration,'Business Registration','')},
    {IF(d.bankruptcy_filing,'Bankruptcy Filing','')},
    {IF(d.edgar_cik,'Edgar Cik','')},
    {IF(d.duns_number OR d.duns_tree,'DUNS Number','')},
    {IF(d.abi_number OR d.abi_hierarchy,'American Business Identifier','')},
    {IF(d.dca_company_number,'Directory of Corporate Affiliations Number','')},
    {IF(d.dca_hierarchy,'Directory of Corporate Affiliations Hierarchy','')},
    {IF(d.name,'Name','')},
    {IF(d.name_address,'Name Address','')},
    {IF(d.name_phone,'Name Phone','')},
    {IF(d.gong_group,'Phone Listing Group','')},
    {IF(d.ucc_filing,'UCC Filing','')},
    {IF(d.fein_m,'FEIN','')},
    {IF(d.phone_m,'Phone Number','')},
    {IF(d.addr,'Address','')},
    {IF(d.mail_addr,'Mailing Address','')},
    {IF(d.rel_group,'Relative Group','')}
        ], assoc_rec)(assoc_type <> '');

prep_rec tra(abd l) := TRANSFORM
  // self.association_children := translate_type(l);
  SELF.isInOAA := doxie_cbrs.is_InOAA(l);
  SELF := l;
END;

slim := PROJECT(abd, tra(LEFT));

EXPORT Associated_Business_records_types := slim;
