#workunit('name', 'Provider Header Cluster Analysis');
import HealthCareProvider;
input_file         := HealthCareProvider.Files.Person_Salt_Output_DS;
// input_file := dataset ('~thor::base::healthcareprovider::person::salt::output::w20131126-045524',healthcareprovider.Layout_HealthProvider.HealthCareProvider_Header,thor);

d_infile := DISTRIBUTE(input_file, HASH32(LNPID));

T := TABLE (D_Infile,{lnpid,cluster_count := count(group)},lnpid,merge);

Bigest_Clusters := SORT (T,-Cluster_Count);

output (count(t),named('ClusterCount'));
output (Bigest_Clusters,named('LargeClusters'));

currentHdrRs2 := DISTRIBUTE(d_infile, HASH32(LNPID));
currentHdrRs  := currentHdrRs2;

//
// SRC Info
//
srcInfo_layout := RECORD
    currentHdrRs.src;
    currentHdrRs.vendor_id;
    unsigned cnt := 0;
END;

srcInfoRs1 := currentHdrRs;
srcInfoRs2 := TABLE(srcInfoRs1,
  {
      LNPID,
      src,
      vendor_id,
      unsigned cnt := COUNT(GROUP)
  }, LNPID, src, vendor_id);
srcInfoRs3 := DISTRIBUTE(srcInfoRs2, HASH32(LNPID));
srcInfoRs4 := SORT(srcInfoRs3, LNPID, -cnt, src, vendor_id, LOCAL);
srcInfoRs  := srcInfoRs4;   // Distributed and sorted rhs to DENORMALIZE
// OUTPUT(srcInfoRs, NAMED('srcInfoRs'));

//
// SRCTYPE Info
//
srctypeInfo_layout := RECORD
    currentHdrRs.src;
    unsigned cnt := 0;
END;

srctypeInfoRs1 := srcInfoRs;
srctypeInfoRs2 := TABLE(srctypeInfoRs1,
  {
      LNPID,
      src,
      unsigned cnt := COUNT(GROUP)
  }, LNPID, src);
srctypeInfoRs3 := DISTRIBUTE(srctypeInfoRs2, HASH32(LNPID));
srctypeInfoRs4 := SORT(srctypeInfoRs3, LNPID, -cnt, src, LOCAL);
srctypeInfoRs  := srctypeInfoRs4;   // Distributed and sorted rhs to DENORMALIZE
// OUTPUT(srctypeInfoRs, NAMED('srctypeInfoRs'));

//
// NAME Info
//
nameInfo_layout := RECORD
    // currentHdrRs.title;
    currentHdrRs.fname;
    currentHdrRs.mname;
    currentHdrRs.lname;
    currentHdrRs.sname;
    currentHdrRs.cname;
    unsigned cnt := 0;
END;

nameInfoRs1 := currentHdrRs;
nameInfoRs2 := TABLE(nameInfoRs1,
  {
      LNPID,
      fname,
      mname,
      lname,
      sname,
      cname,
      unsigned cnt := COUNT(GROUP)
  }, LNPID, fname, mname, lname, sname, cname);
nameInfoRs3 := DISTRIBUTE(nameInfoRs2, HASH32(LNPID));
nameInfoRs4 := SORT(nameInfoRs3, LNPID, -cnt, fname, mname, lname, sname, cname, LOCAL);
nameInfoRs  := nameInfoRs4;   // Distributed and sorted rhs to DENORMALIZE
// OUTPUT(nameInfoRs, NAMED('nameInfoRs'));

//
// ADDR Info
//
addrInfo_layout := RECORD
    currentHdrRs.prim_range;
    currentHdrRs.predir;
    currentHdrRs.prim_name;
    currentHdrRs.addr_suffix;
    currentHdrRs.postdir;
    currentHdrRs.unit_desig;
    currentHdrRs.sec_range;
    currentHdrRs.p_city_name;
    currentHdrRs.v_city_name;
    currentHdrRs.st;
    currentHdrRs.zip;
    currentHdrRs.zip4;
    unsigned cnt := 0;
END;
addrInfoRs1 := currentHdrRs;
addrInfoRs2 := TABLE(addrInfoRs1,
  {
      LNPID,
      prim_range,  predir,     prim_name,    addr_suffix,  postdir,
      unit_desig,  sec_range,  p_city_name,  v_city_name,  st,
      zip,         zip4,
      unsigned cnt := COUNT(GROUP)
  },
  LNPID,
  prim_range,  predir,     prim_name,    addr_suffix,  postdir,
  unit_desig,  sec_range,  p_city_name,  v_city_name,  st,
  zip,         zip4);
addrInfoRs3 := DISTRIBUTE(addrInfoRs2, HASH32(LNPID));
addrInfoRs4 := SORT(addrInfoRs3,
  LNPID, -cnt,
  prim_range,  predir,     prim_name,    addr_suffix,  postdir,
  unit_desig,  sec_range,  p_city_name,  v_city_name,  st,
  zip,         zip4,
  LOCAL);
addrInfoRs  := addrInfoRs4;   // Distributed and sorted rhs to DENORMALIZE
// OUTPUT(addrInfoRs, NAMED('addrInfoRs'));

//
// DEA Info
//
deaInfo_layout := RECORD
    currentHdrRs.dea_number;
    unsigned cnt := 0;
END;
deaInfoRs1 := currentHdrRs(dea_number != '');
deaInfoRs2 := TABLE(deaInfoRs1,
  {
      LNPID,
      dea_number,
      unsigned cnt := COUNT(GROUP)
  },
  LNPID, dea_number);
deaInfoRs3 := DISTRIBUTE(deaInfoRs2, HASH32(LNPID));
deaInfoRs4 := SORT(deaInfoRs3,
  LNPID, -cnt, dea_number,
  LOCAL);
deaInfoRs  := deaInfoRs4;   // Distributed and sorted rhs to DENORMALIZE
// OUTPUT(deaInfoRs, NAMED('deaInfoRs'));

//
// NPI Info
//
npiInfo_layout := RECORD
    currentHdrRs.npi_number;
    unsigned cnt := 0;
END;
npiInfoRs1 := currentHdrRs(npi_number != '');
npiInfoRs2 := TABLE(npiInfoRs1,
  {
      LNPID,
      npi_number,
      unsigned cnt := COUNT(GROUP)
  },
  LNPID, npi_number);
npiInfoRs3 := DISTRIBUTE(npiInfoRs2, HASH32(LNPID));
npiInfoRs4 := SORT(npiInfoRs3,
  LNPID, -cnt, npi_number,
  LOCAL);
npiInfoRs  := npiInfoRs4;   // Distributed and sorted rhs to DENORMALIZE
// OUTPUT(npiInfoRs, NAMED('npiInfoRs'));

//
// LIC Info
//
licInfo_layout := RECORD
    currentHdrRs.lic_state;
    currentHdrRs.c_lic_nbr;
    unsigned cnt := 0;
END;
licInfoRs1 := currentHdrRs(lic_nbr != '');
licInfoRs2 := TABLE(licInfoRs1,
  {
      LNPID,
      lic_state,
      c_lic_nbr,
      unsigned cnt := COUNT(GROUP)
  },
  LNPID, lic_state, c_lic_nbr);
licInfoRs3 := DISTRIBUTE(licInfoRs2, HASH32(LNPID));
licInfoRs4 := SORT(licInfoRs3,
  LNPID, -cnt, lic_state, c_lic_nbr,
  LOCAL);
licInfoRs  := licInfoRs4;   // Distributed and sorted rhs to DENORMALIZE
// OUTPUT(licInfoRs, NAMED('licInfoRs'));

//
// UPIN Info
//
upinInfo_layout := RECORD
    currentHdrRs.upin;
    unsigned cnt := 0;
END;
upinInfoRs1 := currentHdrRs(upin != '');
upinInfoRs2 := TABLE(upinInfoRs1,
  {
      LNPID,
      upin,
      unsigned cnt := COUNT(GROUP)
  },
  LNPID, upin);
upinInfoRs3 := DISTRIBUTE(upinInfoRs2, HASH32(LNPID));
upinInfoRs4 := SORT(upinInfoRs3,
  LNPID, -cnt, upin,
  LOCAL);
upinInfoRs  := upinInfoRs4;   // Distributed and sorted rhs to DENORMALIZE
// OUTPUT(upinInfoRs, NAMED('upinInfoRs'));

//
// TAXID Info
//
taxidInfo_layout := RECORD
    currentHdrRs.tax_id;
    unsigned cnt := 0;
END;
taxidInfoRs1 := currentHdrRs(tax_id != 0);
taxidInfoRs2 := TABLE(taxidInfoRs1,
  {
      LNPID,
      tax_id,
      unsigned cnt := COUNT(GROUP)
  },
  LNPID, tax_id);
taxidInfoRs3 := DISTRIBUTE(taxidInfoRs2, HASH32(LNPID));
taxidInfoRs4 := SORT(taxidInfoRs3,
  LNPID, -cnt, tax_id,
  LOCAL);
taxidInfoRs  := taxidInfoRs4;   // Distributed and sorted rhs to DENORMALIZE
// OUTPUT(taxidInfoRs, NAMED('taxidInfoRs'));

//
// DOB Info
//
dobInfo_layout := RECORD
    currentHdrRs.dob;
    unsigned cnt := 0;
END;
dobInfoRs1 := currentHdrRs(dob != 0);
dobInfoRs2 := TABLE(dobInfoRs1,
  {
      LNPID,
      dob,
      unsigned cnt := COUNT(GROUP)
  },
  LNPID, dob);
dobInfoRs3 := DISTRIBUTE(dobInfoRs2, HASH32(LNPID));
dobInfoRs4 := SORT(dobInfoRs3,
  LNPID, -cnt, dob,
  LOCAL);
dobInfoRs  := dobInfoRs4;   // Distributed and sorted rhs to DENORMALIZE
// OUTPUT(dobInfoRs, NAMED('dobInfoRs'));

//
// Derived_Gender Info
//

genderInfo_layout := RECORD
    currentHdrRs.derived_gender;
    unsigned cnt := 0;
END;
genderInfoRs1 := currentHdrRs(derived_gender <> '');
genderInfoRs2 := TABLE(genderInfoRs1,
  {
      LNPID,
      derived_gender,
      unsigned cnt := COUNT(GROUP)
  },
  LNPID, derived_gender);
genderInfoRs3 := DISTRIBUTE(genderInfoRs2, HASH32(LNPID));
genderInfoRs4 := SORT(genderInfoRs3,
  LNPID, -cnt, derived_gender,
  LOCAL);
genderInfoRs  := genderInfoRs4;   // Distributed and sorted rhs to DENORMALIZE
// OUTPUT(genderInfoRs, NAMED('genderInfoRs'));

//
// SSN Info
//

ssnInfo_layout := RECORD
    currentHdrRs.ssn;
    unsigned cnt := 0;
END;
ssnInfoRs1 := currentHdrRs(ssn <> '');
ssnInfoRs2 := TABLE(ssnInfoRs1,
  {
      LNPID,
      ssn,
      unsigned cnt := COUNT(GROUP)
  },
  LNPID, ssn);
ssnInfoRs3 := DISTRIBUTE(ssnInfoRs2, HASH32(LNPID));
ssnInfoRs4 := SORT(ssnInfoRs3,
  LNPID, -cnt, ssn,
  LOCAL);
ssnInfoRs  := ssnInfoRs4;   // Distributed and sorted rhs to DENORMALIZE
// OUTPUT(ssnInfoRs, NAMED('ssnInfoRs'));

//
// DID Info
//

didInfo_layout := RECORD
    currentHdrRs.did;
    unsigned cnt := 0;
END;
didInfoRs1 := currentHdrRs(did > 0);
didInfoRs2 := TABLE(didInfoRs1,
  {
      LNPID,
      did,
      unsigned cnt := COUNT(GROUP)
  },
  LNPID, did);
didInfoRs3 := DISTRIBUTE(didInfoRs2, HASH32(LNPID));
didInfoRs4 := SORT(didInfoRs3,
  LNPID, -cnt, did,
  LOCAL);
didInfoRs  := didInfoRs4;   // Distributed and sorted rhs to DENORMALIZE
// OUTPUT(ssnInfoRs, NAMED('ssnInfoRs'));

//
// Taxonomy Info
//

taxonomyInfo_layout := RECORD
    currentHdrRs.taxonomy;
    unsigned cnt := 0;
END;
taxonomyInfoRs1 := currentHdrRs(taxonomy <> '');
taxonomyInfoRs2 := TABLE(taxonomyInfoRs1,
  {
      LNPID,
      taxonomy,
      unsigned cnt := COUNT(GROUP)
  },
  LNPID, taxonomy);
taxonomyInfoRs3 := DISTRIBUTE(taxonomyInfoRs2, HASH32(LNPID));
taxonomyInfoRs4 := SORT(taxonomyInfoRs3,
  LNPID, -cnt, taxonomy,
  LOCAL);
taxonomyInfoRs  := taxonomyInfoRs4;   // Distributed and sorted rhs to DENORMALIZE

//
// Paste if all of the above datasets together into the following structure.
// One row per LNPID.
//
SRCINFO_MAX     := 10;
NAMEINFO_MAX    := 30;
ADDRINFO_MAX    := 75;
DEAINFO_MAX     := 10;
NPIINFO_MAX     := 10;
LICINFO_MAX     := 20;
UPININFO_MAX    := 10;
TAXIDINFO_MAX   := 15;
SRCTYPEINFO_MAX := 10;
DOBINFO_MAX     := 20;
GENDERINFO_MAX  := 3;
SSNINFO_MAX  		:= 5;
DIDINFO_MAX  		:= 5;
Taxonomy_MAX  	:= 25;
Vendor_ID_MAX  	:= 75;

finalHdrInfo_layout := RECORD
    currentHdrRs.LNPID;
    unsigned hdr_cnt := 0;
    
    unsigned srctype_cnt := 0;
    DATASET(srctypeInfo_layout) srctype_info{MAXCOUNT(SRCTYPEINFO_MAX)};
    
    unsigned src_cnt := 0;
    DATASET(srcInfo_layout) src_info{MAXCOUNT(SRCINFO_MAX)};
    
    unsigned npi_cnt := 0;
    DATASET(npiInfo_layout) npi_info{MAXCOUNT(NPIINFO_MAX)};
    
    unsigned dea_cnt := 0;
    DATASET(deaInfo_layout) dea_info{MAXCOUNT(DEAINFO_MAX)};
    
    unsigned lic_cnt := 0;
    DATASET(licInfo_layout) lic_info{MAXCOUNT(LICINFO_MAX)};
    
    unsigned upin_cnt := 0;
    DATASET(upinInfo_layout) upin_info{MAXCOUNT(UPININFO_MAX)};
    
    unsigned taxid_cnt := 0;
    DATASET(taxidInfo_layout) taxid_info{MAXCOUNT(TAXIDINFO_MAX)};
    
    unsigned dob_cnt := 0;
    DATASET(dobInfo_layout) dob_info{MAXCOUNT(DOBINFO_MAX)};
    
    unsigned name_cnt := 0;
    DATASET(nameInfo_layout) name_info{MAXCOUNT(NAMEINFO_MAX)};
    
    unsigned addr_cnt := 0;
    DATASET(addrInfo_layout) addr_info{MAXCOUNT(ADDRINFO_MAX)};

    unsigned gender_cnt := 0;
    DATASET(genderInfo_layout) gender_info{MAXCOUNT(genderINFO_MAX)};

    unsigned ssn_cnt := 0;
    DATASET(ssnInfo_layout) ssn_info{MAXCOUNT(ssnINFO_MAX)};

    unsigned did_cnt := 0;
    DATASET(didInfo_layout) did_info{MAXCOUNT(didINFO_MAX)};

    unsigned taxonomy_cnt := 0;
    DATASET(taxonomyInfo_layout) taxonomy_info {MAXCOUNT(Taxonomy_MAX)};
END;

//
// Create the initial lhs dataset for DENORMALIZE
//
finalHdrInfoRs1 := TABLE(currentHdrRs,
  {
      LNPID,
      unsigned hdr_cnt := COUNT(GROUP)
  }, LNPID);
finalHdrInfoRs2 := PROJECT(finalHdrInfoRs1,
  TRANSFORM(finalHdrInfo_layout,
    SELF := LEFT,
    SELF := []));
finalHdrInfoRs3 := DISTRIBUTE(finalHdrInfoRs2, HASH32(LNPID));


finalHdrInfoRs4 := DENORMALIZE(finalHdrInfoRs3, srcInfoRs,    // SRC Info
    LEFT.LNPID = RIGHT.LNPID,
    TRANSFORM(RECORDOF(LEFT),
      SELF.src_cnt := COUNTER,
      SELF.src_info := IF(
        COUNTER > SRCINFO_MAX,
        LEFT.src_info,
        LEFT.src_info + DATASET([{RIGHT.src, RIGHT.vendor_id, RIGHT.cnt}], RECORDOF(LEFT.src_info))),
      SELF := LEFT),
    LOCAL);
finalHdrInfoRs5 := DENORMALIZE(finalHdrInfoRs4, nameInfoRs,    // NAME Info
    LEFT.LNPID = RIGHT.LNPID,
    TRANSFORM(RECORDOF(LEFT),
      SELF.name_cnt := COUNTER,
      SELF.name_info := IF(
        COUNTER > NAMEINFO_MAX,
        LEFT.name_info,
        LEFT.name_info + DATASET([{RIGHT.fname, RIGHT.mname, RIGHT.lname, RIGHT.sname, RIGHT.cname, RIGHT.cnt}], RECORDOF(LEFT.name_info))),
      SELF := LEFT),
    LOCAL);
finalHdrInfoRs6 := DENORMALIZE(finalHdrInfoRs5, addrInfoRs,    // ADDR Info
    LEFT.LNPID = RIGHT.LNPID,
    TRANSFORM(RECORDOF(LEFT),
      SELF.addr_cnt := COUNTER,
      SELF.addr_info := IF(
        COUNTER > ADDRINFO_MAX,
        LEFT.addr_info,
        LEFT.addr_info + DATASET(
          [{
            RIGHT.prim_range, RIGHT.predir,     RIGHT.prim_name, RIGHT.addr_suffix,
            RIGHT.postdir,    RIGHT.unit_desig, RIGHT.sec_range, RIGHT.p_city_name, RIGHT.v_city_name,
            RIGHT.st,         RIGHT.zip,        RIGHT.zip4,
            RIGHT.cnt}], RECORDOF(LEFT.addr_info))),
      SELF := LEFT),
    LOCAL);
finalHdrInfoRs7 := DENORMALIZE(finalHdrInfoRs6, deaInfoRs,    // DEA Info
    LEFT.LNPID = RIGHT.LNPID,
    TRANSFORM(RECORDOF(LEFT),
      SELF.dea_cnt := COUNTER,
      SELF.dea_info := IF(
        COUNTER > DEAINFO_MAX,
        LEFT.dea_info,
        LEFT.dea_info + DATASET(
          [{RIGHT.dea_number, RIGHT.cnt}], RECORDOF(LEFT.dea_info))),
      SELF := LEFT),
    LOCAL);
finalHdrInfoRs8 := DENORMALIZE(finalHdrInfoRs7, npiInfoRs,    // NPI Info
    LEFT.LNPID = RIGHT.LNPID,
    TRANSFORM(RECORDOF(LEFT),
      SELF.npi_cnt := COUNTER,
      SELF.npi_info := IF(
        COUNTER > NPIINFO_MAX,
        LEFT.npi_info,
        LEFT.npi_info + DATASET(
          [{RIGHT.npi_number, RIGHT.cnt}], RECORDOF(LEFT.npi_info))),
      SELF := LEFT),
    LOCAL);
finalHdrInfoRs9 := DENORMALIZE(finalHdrInfoRs8, licInfoRs,    // LIC Info
    LEFT.LNPID = RIGHT.LNPID,
    TRANSFORM(RECORDOF(LEFT),
      SELF.lic_cnt := COUNTER,
      SELF.lic_info := IF(
        COUNTER > LICINFO_MAX,
        LEFT.lic_info,
        LEFT.lic_info + DATASET(
          [{RIGHT.lic_state, RIGHT.c_lic_nbr, RIGHT.cnt}], RECORDOF(LEFT.lic_info))),
      SELF := LEFT),
    LOCAL);
finalHdrInfoRs10 := DENORMALIZE(finalHdrInfoRs9, upinInfoRs,    // UPIN Info
    LEFT.LNPID = RIGHT.LNPID,
    TRANSFORM(RECORDOF(LEFT),
      SELF.upin_cnt := COUNTER,
      SELF.upin_info := IF(
        COUNTER > UPININFO_MAX,
        LEFT.upin_info,
        LEFT.upin_info + DATASET(
          [{RIGHT.upin, RIGHT.cnt}], RECORDOF(LEFT.upin_info))),
      SELF := LEFT),
    LOCAL);
finalHdrInfoRs11 := DENORMALIZE(finalHdrInfoRs10, taxidInfoRs,    // TAXID Info
    LEFT.LNPID = RIGHT.LNPID,
    TRANSFORM(RECORDOF(LEFT),
      SELF.taxid_cnt := COUNTER,
      SELF.taxid_info := IF(
        COUNTER > TAXIDINFO_MAX,
        LEFT.taxid_info,
        LEFT.taxid_info + DATASET(
          [{RIGHT.tax_id, RIGHT.cnt}], RECORDOF(LEFT.taxid_info))),
      SELF := LEFT),
    LOCAL);
finalHdrInfoRs12 := DENORMALIZE(finalHdrInfoRs11, srctypeInfoRs,    // SRCTYPE Info
    LEFT.LNPID = RIGHT.LNPID,
    TRANSFORM(RECORDOF(LEFT),
      SELF.srctype_cnt := COUNTER,
      SELF.srctype_info := IF(
        COUNTER > SRCTYPEINFO_MAX,
        LEFT.srctype_info,
        LEFT.srctype_info + DATASET(
          [{RIGHT.src, RIGHT.cnt}], RECORDOF(LEFT.srctype_info))),
      SELF := LEFT),
    LOCAL);
finalHdrInfoRs13 := DENORMALIZE(finalHdrInfoRs12, dobInfoRs,    // DOB Info
    LEFT.LNPID = RIGHT.LNPID,
    TRANSFORM(RECORDOF(LEFT),
      SELF.dob_cnt := COUNTER,
      SELF.dob_info := IF(
        COUNTER > DOBINFO_MAX,
        LEFT.dob_info,
        LEFT.dob_info + DATASET(
          [{RIGHT.dob, RIGHT.cnt}], RECORDOF(LEFT.dob_info))),
      SELF := LEFT),
    LOCAL);

finalHdrInfoRs14 := DENORMALIZE(finalHdrInfoRs13, genderInfoRs,    // gender Info
    LEFT.LNPID = RIGHT.LNPID,
    TRANSFORM(RECORDOF(LEFT),
      SELF.gender_cnt := COUNTER,
      SELF.gender_info := IF(
        COUNTER > genderINFO_MAX,
        LEFT.gender_info,
        LEFT.gender_info + DATASET(
          [{RIGHT.derived_gender, RIGHT.cnt}], RECORDOF(LEFT.gender_info))),
      SELF := LEFT),
    LOCAL);

finalHdrInfoRs15 := DENORMALIZE(finalHdrInfoRs14, ssnInfoRs,    // ssn Info
    LEFT.LNPID = RIGHT.LNPID,
    TRANSFORM(RECORDOF(LEFT),
      SELF.ssn_cnt := COUNTER,
      SELF.ssn_info := IF(
        COUNTER > ssnINFO_MAX,
        LEFT.ssn_info,
        LEFT.ssn_info + DATASET(
          [{RIGHT.ssn, RIGHT.cnt}], RECORDOF(LEFT.ssn_info))),
      SELF := LEFT),
    LOCAL);

finalHdrInfoRs16 := DENORMALIZE(finalHdrInfoRs15, taxonomyInfoRs,    // taxonomy Info
    LEFT.LNPID = RIGHT.LNPID,
    TRANSFORM(RECORDOF(LEFT),
      SELF.taxonomy_cnt := COUNTER,
      SELF.taxonomy_info := IF(
        COUNTER > Taxonomy_MAX,
        LEFT.taxonomy_info,
        LEFT.taxonomy_info + DATASET(
          [{RIGHT.taxonomy, RIGHT.cnt}], RECORDOF(LEFT.taxonomy_info))),
      SELF := LEFT),
    LOCAL);

finalHdrInfoRs17 := DENORMALIZE(finalHdrInfoRs15, didInfoRs,    // did Info
    LEFT.LNPID = RIGHT.LNPID,
    TRANSFORM(RECORDOF(LEFT),
      SELF.did_cnt := COUNTER,
      SELF.did_info := IF(
        COUNTER > DIDINFO_MAX,
        LEFT.did_info,
        LEFT.did_info + DATASET(
          [{RIGHT.did, RIGHT.cnt}], RECORDOF(LEFT.did_info))),
      SELF := LEFT),
    LOCAL);

finalHdrInfoRs  := distribute (finalHdrInfoRs17,hash32(LNPID));

OUTPUT(finalHdrInfoRs, NAMED('SampleHeaderClusters'));

//
// Display distributions for the various components of the above.
//
hdrCntDistRs1 := TABLE(finalHdrInfoRs,
  {
      hdr_cnt;
      unsigned cnt := COUNT(GROUP);
  }, hdr_cnt,local);
hdrCntDistRs2 := SORT(hdrCntDistRs1, hdr_cnt,local);
hdrCntDistRs  := hdrCntDistRs2;
// OUTPUT(hdrCntDistRs, NAMED('hdrCntDistRs'));

srctypeCntDistRs1 := TABLE(finalHdrInfoRs,
  {
      srctype_cnt;
      unsigned cnt := COUNT(GROUP);
      unsigned hdr_cnt := SUM(GROUP, hdr_cnt);
  }, srctype_cnt,local);
srctypeCntDistRs2 := SORT(srctypeCntDistRs1, srctype_cnt,local);
srctypeCntDistRs  := srctypeCntDistRs2;
// OUTPUT(srctypeCntDistRs, NAMED('srctypeCntDistRs'));

srcCntDistRs1 := TABLE(finalHdrInfoRs,
  {
      src_cnt;
      unsigned cnt := COUNT(GROUP);
      unsigned hdr_cnt := SUM(GROUP, hdr_cnt);
  }, src_cnt,local);
srcCntDistRs2 := SORT(srcCntDistRs1, src_cnt,local);
srcCntDistRs  := srcCntDistRs2;
// OUTPUT(srcCntDistRs, NAMED('srcCntDistRs'));


npiCntDistRs1 := TABLE(finalHdrInfoRs,
  {
      npi_cnt;
      unsigned cnt := COUNT(GROUP);
      unsigned hdr_cnt := SUM(GROUP, hdr_cnt);
  }, npi_cnt,local);
npiCntDistRs2 := SORT(npiCntDistRs1, npi_cnt,local);
npiCntDistRs  := npiCntDistRs2;
// OUTPUT(npiCntDistRs, NAMED('npiCntDistRs'));


deaCntDistRs1 := TABLE(finalHdrInfoRs,
  {
      dea_cnt;
      unsigned cnt := COUNT(GROUP);
      unsigned hdr_cnt := SUM(GROUP, hdr_cnt);
  }, dea_cnt,local);
deaCntDistRs2 := SORT(deaCntDistRs1, dea_cnt,local);
deaCntDistRs  := deaCntDistRs2;
// OUTPUT(deaCntDistRs, NAMED('deaCntDistRs'));


licCntDistRs1 := TABLE(finalHdrInfoRs,
  {
      lic_cnt;
      unsigned cnt := COUNT(GROUP);
      unsigned hdr_cnt := SUM(GROUP, hdr_cnt);
  }, lic_cnt,local);
licCntDistRs2 := SORT(licCntDistRs1, lic_cnt,local);
licCntDistRs  := licCntDistRs2;
// OUTPUT(licCntDistRs, NAMED('licCntDistRs'));


upinCntDistRs1 := TABLE(finalHdrInfoRs,
  {
      upin_cnt;
      unsigned cnt := COUNT(GROUP);
      unsigned hdr_cnt := SUM(GROUP, hdr_cnt);
  }, upin_cnt,local);
upinCntDistRs2 := SORT(upinCntDistRs1, upin_cnt,local);
upinCntDistRs  := upinCntDistRs2;
// OUTPUT(upinCntDistRs, NAMED('upinCntDistRs'));


taxidCntDistRs1 := TABLE(finalHdrInfoRs,
  {
      taxid_cnt;
      unsigned cnt := COUNT(GROUP);
      unsigned hdr_cnt := SUM(GROUP, hdr_cnt);
  }, taxid_cnt,local);
taxidCntDistRs2 := SORT(taxidCntDistRs1, taxid_cnt,local);
taxidCntDistRs  := taxidCntDistRs2;
// OUTPUT(taxidCntDistRs, NAMED('taxidCntDistRs'));


dobCntDistRs1 := TABLE(finalHdrInfoRs,
  {
      dob_cnt;
      unsigned cnt := COUNT(GROUP);
      unsigned hdr_cnt := SUM(GROUP, hdr_cnt);
  }, dob_cnt,local);
dobCntDistRs2 := SORT(dobCntDistRs1, dob_cnt,local);
dobCntDistRs  := dobCntDistRs2;
// OUTPUT(dobCntDistRs, NAMED('dobCntDistRs'));


nameCntDistRs1 := TABLE(finalHdrInfoRs,
  {
      name_cnt;
      unsigned cnt := COUNT(GROUP);
      unsigned hdr_cnt := SUM(GROUP, hdr_cnt);
  }, name_cnt,local);
nameCntDistRs2 := SORT(nameCntDistRs1, name_cnt,local);
nameCntDistRs  := nameCntDistRs2;
// OUTPUT(nameCntDistRs, NAMED('nameCntDistRs'));


addrCntDistRs1 := TABLE(finalHdrInfoRs,
  {
      addr_cnt;
      unsigned cnt := COUNT(GROUP);
      unsigned hdr_cnt := SUM(GROUP, hdr_cnt);
  }, addr_cnt,local);
addrCntDistRs2 := SORT(addrCntDistRs1, addr_cnt,local);
addrCntDistRs  := addrCntDistRs2;
// OUTPUT(addrCntDistRs, NAMED('addrCntDistRs'));

genderCntDistRs1 := TABLE(finalHdrInfoRs,
  {
      gender_cnt;
      unsigned cnt := COUNT(GROUP);
      unsigned hdr_cnt := SUM(GROUP, hdr_cnt);
  }, gender_cnt,local);
genderCntDistRs2 := SORT(genderCntDistRs1, gender_cnt,local);
genderCntDistRs  := genderCntDistRs2;
// OUTPUT(genderCntDistRs, NAMED('genderCntDistRs'));

SSNCntDistRs1 := TABLE(finalHdrInfoRs,
  {
      ssn_cnt;
      unsigned cnt := COUNT(GROUP);
      unsigned hdr_cnt := SUM(GROUP, hdr_cnt);
  }, ssn_cnt,local);
ssnCntDistRs2 := SORT(SSNCntDistRs1, ssn_cnt,local);
ssnCntDistRs  := ssnCntDistRs2;
// OUTPUT(ssnCntDistRs, NAMED('ssnCntDistRs'));

TaxonomyCntDistRs1 := TABLE(finalHdrInfoRs,
  {
      taxonomy_cnt;
      unsigned cnt := COUNT(GROUP);
      unsigned hdr_cnt := SUM(GROUP, hdr_cnt);
  }, taxonomy_cnt,local);
taxonomyCntDistRs2 := SORT(taxonomyCntDistRs1, taxonomy_cnt,local);
taxonomyCntDistRs  := taxonomyCntDistRs2;
// OUTPUT(taxonomyCntDistRs, NAMED('taxonomyCntDistRs'));

//
// Spot Check Records that have more than the usual numbers of the various ID values.
//
spotChkByNameRs1 := finalHdrInfoRs;
spotChkByNameRs2 := spotChkByNameRs1(name_cnt >= 5);
spotChkByNameRs3 := ENTH(sort(spotChkByNameRs2,-name_cnt,skew(1)), 100);
spotChkByNameRs  := spotChkByNameRs3;
OUTPUT(COUNT(spotChkByNameRs2), NAMED('Clusters_WithMoreThan_4_Names'));
OUTPUT(spotChkByNameRs, NAMED('Sample_Name_Clusters'));


spotChkByNpiDeaLicTaxRs1 := finalHdrInfoRs;
spotChkByNpiDeaLicTaxRs2 := spotChkByNpiDeaLicTaxRs1(npi_cnt >= 2, dea_cnt >= 2, lic_cnt >= 2, taxid_cnt >= 2);
spotChkByNpiDeaLicTaxRs3 := ENTH(sort(spotChkByNpiDeaLicTaxRs2,-npi_cnt, -lic_cnt, -dea_cnt, -taxid_cnt,skew(1)), 100);
spotChkByNpiDeaLicTaxRs  := spotChkByNpiDeaLicTaxRs3;
OUTPUT(COUNT(spotChkByNpiDeaLicTaxRs2), NAMED('NpiDeaLicTax_Variation_Clusters_Count'));
OUTPUT(spotChkByNpiDeaLicTaxRs2, NAMED('Sample_NpiDeaLicTax_Clusters'));


spotChkByNpiRs1 := finalHdrInfoRs;
spotChkByNpiRs2 := spotChkByNpiRs1(npi_cnt >= 2);
spotChkByNpiRs3 := ENTH(sort(spotChkByNpiRs2,-npi_cnt,skew(1)), 100);
spotChkByNpiRs  := spotChkByNpiRs3;
OUTPUT(COUNT(spotChkByNpiRs2), NAMED('Clusters_WithMoreThan_1_NPI'));
OUTPUT(spotChkByNpiRs, NAMED('Sample_NPI_Clusters'));


spotChkByDeaRs1 := finalHdrInfoRs;
spotChkByDeaRs2 := spotChkByDeaRs1(dea_cnt >= 3);
spotChkByDeaRs3 := ENTH(sort(spotChkByDeaRs2,-dea_cnt,skew(1)), 100);
spotChkByDeaRs  := spotChkByDeaRs3;
OUTPUT(COUNT(spotChkByDeaRs2), NAMED('Clusters_WithMoreThan_2_DEA'));
OUTPUT(spotChkByDeaRs, NAMED('Sample_DEA_Clusters'));


spotChkByLicRs1 := finalHdrInfoRs;
spotChkByLicRs2 := spotChkByLicRs1(lic_cnt >= 10);
spotChkByLicRs3 := ENTH(sort(spotChkByLicRs2,-lic_cnt,skew(1)), 100);
spotChkByLicRs  := spotChkByLicRs3;
OUTPUT(COUNT(spotChkByLicRs2), NAMED('Clusters_WithMoreThan_9_LICNbr'));
OUTPUT(spotChkByLicRs, NAMED('Sample_LIC_Clusters'));


spotChkByTaxidRs1 := finalHdrInfoRs;
spotChkByTaxidRs2 := spotChkByTaxidRs1(taxid_cnt >= 3);
spotChkByTaxidRs3 := ENTH(sort(spotChkByTaxidRs2,-taxid_cnt,skew(1)), 100);
spotChkByTaxidRs  := spotChkByTaxidRs3;
OUTPUT(COUNT(spotChkByTaxidRs2), NAMED('Clusters_WithMoreThan_2_TaxID'));
OUTPUT(spotChkByTaxidRs, NAMED('Sample_TaxID_Clusters'));


spotChkByDobRs1 := finalHdrInfoRs;
spotChkByDobRs2 := spotChkByDobRs1(dob_cnt >= 3);
spotChkByDobRs3 := ENTH(sort(spotChkByDobRs2,-dob_cnt,skew(1)), 100);
spotChkByDobRs  := spotChkByDobRs3;
OUTPUT(COUNT(spotChkByDobRs2), NAMED('Clusters_WithMoreThan_2_DOB'));
OUTPUT(spotChkByDobRs, NAMED('Sample_DOB_Clusters'));

spotChkByGenderRs1 := finalHdrInfoRs;
spotChkByGenderRs2 := spotChkByGenderRs1(gender_cnt >= 2);
spotChkByGenderRs3 := ENTH(sort(spotChkByGenderRs2,-gender_cnt,skew(1)), 100);
spotChkByGenderRs  := spotChkByGenderRs3;
OUTPUT(COUNT(spotChkByGenderRs2), NAMED('Clusters_WithMoreThan_1_Gender'));
OUTPUT(spotChkByGenderRs, NAMED('Sample_Gender_Clusters'));

spotChkBySSNRs1 := finalHdrInfoRs;
spotChkBySSNRs2 := spotChkBySSNRs1(ssn_cnt > 1);
spotChkBySSNRs3 := ENTH(sort(spotChkBySSNRs2,-ssn_cnt,skew(1)), 200);
spotChkBySSNRs  := spotChkBySSNRs3;
OUTPUT(COUNT(spotChkBySSNRs2), NAMED('Clusters_WithMoreThan_1_SSN'));
OUTPUT(spotChkBySSNRs, NAMED('Sample_SSN_Clusters'),all);

spotChkBytaxonomyRs1 := finalHdrInfoRs;
spotChkByTaxonomyRs2 := spotChkByTaxonomyRs1(Taxonomy_cnt >= 2);
spotChkByTaxonomyRs3 := ENTH(sort(spotChkByTaxonomyRs2,-taxonomy_cnt,skew(1)), 100);
spotChkByTaxonomyRs  := spotChkByTaxonomyRs3;
OUTPUT(COUNT(spotChkByTaxonomyRs2), NAMED('Clusters_WithMoreThan_1_Taxonomy'));
OUTPUT(spotChkByTaxonomyRs, NAMED('Sample_Taxonomy_Clusters'));

spotChkByUPINRs1 := finalHdrInfoRs;
spotChkByUPINRs2 := spotChkByUPINRs1(UPIN_cnt > 1);
spotChkByUPINRs3 := ENTH(sort(spotChkByUPINRs2,-upin_cnt,skew(1)), 200);
spotChkByUPINRs  := spotChkByUPINRs3;
OUTPUT(COUNT(spotChkByUPINRs2), NAMED('Clusters_WithMoreThan_1_UPIN'));
OUTPUT(spotChkByUPINRs, NAMED('Sample_UPIN_Clusters'),all);

spotChkByDIDRs1 := finalHdrInfoRs;
spotChkByDIDRs2 := spotChkByDIDRs1(DID_cnt > 1);
spotChkByDIDRs3 := ENTH(sort(spotChkByDIDRs2,-did_cnt,skew(1)), 100);
spotChkByDIDRs  := spotChkByDIDRs3;
OUTPUT(COUNT(spotChkByDIDRs2), NAMED('Clusters_WithMoreThan_1_DID'));
OUTPUT(spotChkByDIDRs, NAMED('Sample_DID_Clusters'));

d := record
	unsigned8	lnpid;
	unsigned4	dob;
end;

s_dob_ds := dedup(sort (project (d_infile (dob > 0),d),lnpid,dob,local),lnpid,dob,local);

g_dob_ds := group (s_dob_ds,lnpid,local);

rx := record
	unsigned8 lnpid;
	unsigned4 dob1;
	unsigned4	dob2;
	unsigned4	age;
end;

rx dorollup (d l, dataset (d) allrows) := transform
	self.lnpid := l.lnpid;
	dob1	:=	allrows[1].dob;
	dob2	:=	allrows[count(allrows)].dob;
	self.dob1	:=	dob1;
	self.dob2	:=	dob2;
	self.age	:=	dob2 - dob1;
end;

r_dob_ds := rollup (g_dob_ds,group,doRollUp (left,rows(left)));

dob_js := JOIN (d_infile,r_dob_ds(age > 130000),LEFT.LNPID = RIGHT.LNPID,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),lookup,local);

output (r_dob_ds (age > 130000),named('SampleClusterwithDOB_GT_13_years'));
output (count (r_dob_ds (age > 130000)),named('ClusterCountwithDOB_GT_13_years'));
output (dedup(sort(dob_js,lnpid,dob,local),lnpid,dob,local) ,named('ClusterswithDOB_GT_13_years'));

d_file := d_infile;

R := RECORD
	unsigned8 LNPID;
	string2		SRC;
	unsigned6	DotID; //ingenix
	unsigned6 EmpID; //ams
	unsigned6 POWID; //nppes
	unsigned6 ProxID; //dea
	unsigned6 SELEID;   //prof
	unsigned6 OrgID; //enclarity
	unsigned6 UltID; //all cluster count
	unsigned6 rid;
	string40  vendor_id;
END;

test_ds := project (d_file,TRANSFORM(r, self.dotid := 0; 
self.EmpID := 0; 
self.POWID := 0; 
self.ProxID := 0; 
self.SELEID := 0; 
self.OrgID := 0; 
self.UltID := 0; 
self := left;));

g_hdr := group (sort(test_ds,lnpid,local),lnpid,local);

r getFlag (r l, dataset (r) z) := transform
	self.dotid 	:= COUNT(z(src = 'IP'));
	self.EmpID 	:= COUNT(z(src = 'SJ'));
	self.POWID 	:= COUNT(z(src = 'NP'));
	self.ProxID := COUNT(z(src = 'DA'));
	self.SELEID := COUNT(z(src = 'PL'));
	self.OrgID 	:= COUNT(z(src = '64'));
	self.UltID 	:= COUNT(Z);
	self 				:= l;
	self				:= [];
end;

X := rollup (g_hdr,group,getFlag(left,rows(left)));

// output(count (x(dotid  > 0 and dotid = ultid)),named('Ingenix_Only_Clusters_count'));
output(count (x(empid  > 0 and empid = ultid)),named('AMS_Only_Clusters_count'));
output(count (x(orgid  > 0 and orgid = ultid)),named('Enclarity_Only_Clusters_count'));
output(count (x(powid  > 0 and powid = ultid)),named('NPPES_Only_Clusters_count'));
output(count (x(proxid > 0 and proxid = ultid)),named('DEA_Only_Clusters_count'));
output(count (x(seleid > 0 and seleid = ultid)),named('ProfLic_Only_Clusters_count'));

I1 := JOIN (d_infile,distribute(x(empid  > 0 and empid = ultid),hash32(lnpid)),LEFT.LNPID = RIGHT.LNPID,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),HINT(Parallel_Match),ATMOST(LEFT.LNPID = RIGHT.LNPID,10000),HASH,local);
I2 := JOIN (d_infile,distribute(x(orgid  > 0 and orgid = ultid),hash32(lnpid)),LEFT.LNPID = RIGHT.LNPID,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),HINT(Parallel_Match),ATMOST(LEFT.LNPID = RIGHT.LNPID,10000),HASH,local);
I3 := JOIN (d_infile,distribute(x(powid  > 0 and powid = ultid),hash32(lnpid)),LEFT.LNPID = RIGHT.LNPID,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),HINT(Parallel_Match),ATMOST(LEFT.LNPID = RIGHT.LNPID,10000),HASH,local);
I4 := JOIN (d_infile,distribute(x(proxid > 0 and proxid = ultid),hash32(lnpid)),LEFT.LNPID = RIGHT.LNPID,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),HINT(Parallel_Match),ATMOST(LEFT.LNPID = RIGHT.LNPID,10000),HASH,local);
I5 := JOIN (d_infile,distribute(x(seleid > 0 and seleid = ultid),hash32(lnpid)),LEFT.LNPID = RIGHT.LNPID,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),HINT(Parallel_Match),ATMOST(LEFT.LNPID = RIGHT.LNPID,10000),HASH,local);

SI1 := DEDUP(SORT (I1,LNPID,VENDOR_ID,LOCAL),LNPID,VENDOR_ID,LOCAL);
SI2 := DEDUP(SORT (I2,LNPID,VENDOR_ID,LOCAL),LNPID,VENDOR_ID,LOCAL);
SI3 := DEDUP(SORT (I3,LNPID,VENDOR_ID,LOCAL),LNPID,VENDOR_ID,LOCAL);
SI4 := DEDUP(SORT (I4,LNPID,VENDOR_ID,LOCAL),LNPID,VENDOR_ID,LOCAL);
SI5 := DEDUP(SORT (I5,LNPID,VENDOR_ID,LOCAL),LNPID,VENDOR_ID,LOCAL);

T1 := TABLE (SI1,{vendor_id,  cnt := count(group)},vendor_id,few);
T2 := TABLE (SI2,{vendor_id,  cnt := count(group)},vendor_id,few);
T3 := TABLE (SI3,{vendor_id,  cnt := count(group)},vendor_id,few);
T4 := TABLE (SI4,{vendor_id,  cnt := count(group)},vendor_id,few);
T5 := TABLE (SI5,{vendor_id,  cnt := count(group)},vendor_id,few);

V_Infile := DISTRIBUTE (input_file,HASH32(VENDOR_ID));
D_T1 := DISTRIBUTE (T1 (CNT > 1),HASH32(VENDOR_ID));
D_T2 := DISTRIBUTE (T2 (CNT > 1),HASH32(VENDOR_ID));
D_T3 := DISTRIBUTE (T3 (CNT > 1),HASH32(VENDOR_ID));
D_T4 := DISTRIBUTE (T4 (CNT > 1),HASH32(VENDOR_ID));
D_T5 := DISTRIBUTE (T5 (CNT > 1),HASH32(VENDOR_ID));

I6  := JOIN (V_Infile,D_T1,LEFT.vendor_id = RIGHT.vendor_id,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),HINT(Parallel_Match),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID,10000),HASH,local);
I7  := JOIN (V_Infile,D_T2,LEFT.vendor_id = RIGHT.vendor_id,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),HINT(Parallel_Match),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID,10000),HASH,local);
I8  := JOIN (V_Infile,D_T3,LEFT.vendor_id = RIGHT.vendor_id,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),HINT(Parallel_Match),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID,10000),HASH,local);
I9  := JOIN (V_Infile,D_T4,LEFT.vendor_id = RIGHT.vendor_id,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),HINT(Parallel_Match),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID,10000),HASH,local);
I10 := JOIN (V_Infile,D_T5,LEFT.vendor_id = RIGHT.vendor_id,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),HINT(Parallel_Match),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID,10000),HASH,local);

/*Source Vendor id count with more than 1 LNPID */
output (DEDUP(SORT(I6,VENDOR_ID,LNPID,LOCAL),VENDOR_ID,LNPID,LOCAL),named('AMS_ID_UnderLink_Clusters'));
output (DEDUP(SORT(I7,VENDOR_ID,LNPID,LOCAL),VENDOR_ID,LNPID,LOCAL),named('Enclarity_ID_UnderLink_Clusters'));
output (DEDUP(SORT(I8,VENDOR_ID,LNPID,LOCAL),VENDOR_ID,LNPID,LOCAL),named('NPPES_ID_UnderLink_Clusters'));
output (DEDUP(SORT(I9,VENDOR_ID,LNPID,LOCAL),VENDOR_ID,LNPID,LOCAL),named('DEA_ID_UnderLink_Clusters'));
output (DEDUP(SORT(I10,VENDOR_ID,LNPID,LOCAL),VENDOR_ID,LNPID,LOCAL),named('ProfLic_ID_UnderLink_Clusters'));

/*Vendor Only Non Singleton Clusters*/
output(count (x(empid > 1 AND ULTID = empid)),named('AMS_NonSingleton_Count'));
output(count (x(powid > 1 AND ULTID = powid)),named('NPPES_NonSingleton_Count'));
output(count (x(proxid > 1 AND ULTID = proxid)),named('DEA_NonSingleton_Count'));
output(count (x(seleid > 1 AND ULTID = seleid)),named('ProfLic_NonSingleton_Count'));
output(count (x(orgid > 1 AND ULTID = orgid)),named('Enclarity_NonSingleton_Count'));

A1 := JOIN (V_Infile,distribute(x(empid  > 1 and empid = ultid and vendor_id <> ''),hash32(vendor_id)),LEFT.VENDOR_ID = RIGHT.VENDOR_ID,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),HINT(Parallel_Match),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID,10000),HASH,local);
A2 := JOIN (V_Infile,distribute(x(powid  > 1 and powid = ultid and vendor_id <> ''),hash32(vendor_id)),LEFT.VENDOR_ID = RIGHT.VENDOR_ID,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),HINT(Parallel_Match),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID,10000),HASH,local);
A3 := JOIN (V_Infile,distribute(x(proxid  > 1 and proxid = ultid and vendor_id <> ''),hash32(vendor_id)),LEFT.VENDOR_ID = RIGHT.VENDOR_ID,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),HINT(Parallel_Match),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID,10000),HASH,local);
A4 := JOIN (V_Infile,distribute(x(seleid > 1 and seleid = ultid and vendor_id <> ''),hash32(vendor_id)),LEFT.VENDOR_ID = RIGHT.VENDOR_ID,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),HINT(Parallel_Match),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID,10000),HASH,local);
A5 := JOIN (V_Infile,distribute(x(orgid > 1 and orgid = ultid and vendor_id <> ''),hash32(vendor_id)),LEFT.VENDOR_ID = RIGHT.VENDOR_ID,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),HINT(Parallel_Match),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID,10000),HASH,local);

/* Vendor Only Non Singleton Cluster samples*/

output(ENTH(sort(A1,VENDOR_ID,lnpid,local),200),named('AMS_Only_Cluster'));
output(ENTH(sort(A2,VENDOR_ID,lnpid,local),200),named('NPPES_Only_Cluster'));
output(ENTH(sort(A3,VENDOR_ID,lnpid,local),200),named('DEA_Only_Cluster'));
output(ENTH(sort(A4,VENDOR_ID,lnpid,local),200),named('ProfLic_Only_Cluster'));
output(ENTH(sort(A5,VENDOR_ID,lnpid,local),200),named('Enclarity_Only_Cluster'));

// output(count (x(dotid = 1 AND ULTID = DOTID)),named('Ingenix_Singleton_Cluster_Count'));
output(count (x(empid = 1 AND ULTID = empid)),named('AMS_Singleton_Count'));
output(count (x(powid = 1 AND ULTID = powid)),named('NPPES_Singleton_Count'));
output(count (x(proxid = 1 AND ULTID = proxid)),named('DEA_Singleton_Count'));
output(count (x(seleid = 1 AND ULTID = seleid)),named('ProfLic_Singleton_Count'));
output(count (x(orgid = 1 AND ULTID = orgid)),named('Enclarity_Singleton_Count'));

B1 := JOIN (v_infile,distribute(x(empid  = 1 and empid = ultid),hash32(vendor_id)),LEFT.vendor_id = RIGHT.vendor_id,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),HINT(Parallel_Match),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID,10000),HASH,local);
B2 := JOIN (v_infile,distribute(x(powid  = 1 and powid = ultid),hash32(vendor_id)),LEFT.vendor_id = RIGHT.vendor_id,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),HINT(Parallel_Match),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID,10000),HASH,local);
B3 := JOIN (v_infile,distribute(x(proxid  = 1 and proxid = ultid),hash32(vendor_id)),LEFT.vendor_id = RIGHT.vendor_id,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),HINT(Parallel_Match),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID,10000),HASH,local);
B4 := JOIN (v_infile,distribute(x(seleid = 1 and seleid = ultid),hash32(vendor_id)),LEFT.vendor_id = RIGHT.vendor_id,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),HINT(Parallel_Match),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID,10000),HASH,local);
B5 := JOIN (v_infile,distribute(x(orgid = 1 and orgid = ultid),hash32(vendor_id)),LEFT.vendor_id = RIGHT.vendor_id,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),HINT(Parallel_Match),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID,10000),HASH,local);

TB1 := TABLE (B1,{VENDOR_ID, CNT := COUNT(GROUP)},VENDOR_ID,MERGE);
TB2 := TABLE (B2,{VENDOR_ID, CNT := COUNT(GROUP)},VENDOR_ID,MERGE);
TB3 := TABLE (B3,{VENDOR_ID, CNT := COUNT(GROUP)},VENDOR_ID,MERGE);
TB4 := TABLE (B4,{VENDOR_ID, CNT := COUNT(GROUP)},VENDOR_ID,MERGE);
TB5 := TABLE (B5,{VENDOR_ID, CNT := COUNT(GROUP)},VENDOR_ID,MERGE);

JTB1 := JOIN (v_infile,distribute(TB1(CNT = 1),hash32(vendor_id)),LEFT.VENDOR_ID=RIGHT.VENDOR_ID,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),HINT(Parallel_Match),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID,10000),HASH,local);
JTB2 := JOIN (v_infile,distribute(TB2(CNT = 1),hash32(vendor_id)),LEFT.VENDOR_ID=RIGHT.VENDOR_ID,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),HINT(Parallel_Match),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID,10000),HASH,local);
JTB3 := JOIN (v_infile,distribute(TB3(CNT = 1),hash32(vendor_id)),LEFT.VENDOR_ID=RIGHT.VENDOR_ID,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),HINT(Parallel_Match),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID,10000),HASH,local);
JTB4 := JOIN (v_infile,distribute(TB4(CNT = 1),hash32(vendor_id)),LEFT.VENDOR_ID=RIGHT.VENDOR_ID,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),HINT(Parallel_Match),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID,10000),HASH,local);
JTB5 := JOIN (v_infile,distribute(TB5(CNT = 1),hash32(vendor_id)),LEFT.VENDOR_ID=RIGHT.VENDOR_ID,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),HINT(Parallel_Match),ATMOST(LEFT.VENDOR_ID = RIGHT.VENDOR_ID,10000),HASH,local);

// output(x(dotid = 1 AND ULTID = DOTID),named('Ingenix_Singleton_Cluster'));
output(ENTH(sort(JTB1,VENDOR_ID,local),200),named('AMS_Singleton_Cluster'));
output(ENTH(sort(JTB2,VENDOR_ID,local),200),named('NPPES_Singleton_Cluster'));
output(ENTH(sort(JTB3,VENDOR_ID,local),200),named('DEA_Singleton_Cluster'));
output(ENTH(sort(JTB4,VENDOR_ID,local),200),named('ProfLic_Singleton_Cluster'));
output(ENTH(sort(JTB5,VENDOR_ID,local),200),named('Enclarity_Singleton_Cluster'));

Enclarity_Data := DEDUP(SORT(d_infile (SRC = '64'),LNPID,VENDOR_ID,LOCAL),LNPID,VENDOR_ID,LOCAL);

TE1 := TABLE (Enclarity_Data,{LNPID, CNT := COUNT(GROUP)},LNPID,MERGE);
OUTPUT (COUNT(TE1(CNT = 1)),NAMED('UniqueEnclarityGroupKey'));
OUTPUT (COUNT(TE1(CNT > 1)),NAMED('MultipleEnclarityGroupKey'));
Enclarity_js := JOIN (d_infile,TE1(cnt > 1),LEFT.LNPID = RIGHT.LNPID,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),lookup,local);
d_enclarity_ds := dedup(sort (Enclarity_js(SRC = 	'64'),lnpid,vendor_id,local),lnpid,vendor_id,local);
OUTPUT (d_enclarity_ds,NAMED('Sample_Multiple_Enclarity_GroupKey'));
OUTPUT (d_enclarity_ds,,'~thor::test::enclarity',overwrite,compressed);

NPPES_Data := DEDUP(SORT(d_infile (SRC = 'NP'),LNPID,VENDOR_ID,LOCAL),LNPID,VENDOR_ID,LOCAL);
TN1 := TABLE (NPPES_Data,{LNPID,CNT := COUNT(GROUP)},LNPID,MERGE);
OUTPUT (COUNT(TN1(CNT = 1)),NAMED('UniqueNPPES_NPI_Number'));
OUTPUT (COUNT(TN1(CNT > 1)),NAMED('MultipleNPPES_NPI_Number'));
NPPES_js := JOIN (d_infile,TN1(cnt > 1),LEFT.LNPID = RIGHT.LNPID,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),lookup,local);
d_nppes_ds := dedup(sort (NPPES_js(SRC = 'NP'),lnpid,vendor_id,local),lnpid,vendor_id,local);
OUTPUT (d_nppes_ds,NAMED('Sample_Multiple_NPPES_NPI'));

DEA_Data := DEDUP(SORT(d_infile (SRC = 'DA'),LNPID,VENDOR_ID,LOCAL),LNPID,VENDOR_ID,LOCAL);

TD1 := TABLE (DEA_Data,{LNPID,CNT := COUNT(GROUP)},LNPID,MERGE);
OUTPUT (COUNT(TD1(CNT = 1)),NAMED('Unique_Dea_Number'));
OUTPUT (COUNT(TD1(CNT > 1)),NAMED('Multiple_DEA_Number'));
DEA_js := JOIN (d_infile,TD1(cnt > 1),LEFT.LNPID = RIGHT.LNPID,TRANSFORM(HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header, SELF := LEFT;),lookup,local);
d_dea_js := dedup(sort (dea_js(SRC = 'DA'),lnpid,vendor_id,local),lnpid,vendor_id,local);
OUTPUT (d_dea_js,NAMED('Sample_Clusters_With_Multiple_DEA_Number'));