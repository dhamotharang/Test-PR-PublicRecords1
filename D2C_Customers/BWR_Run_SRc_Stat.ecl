import dx_Vendor_Src,Phonesplus_v2, header, mdr, UCCV2, liensv2;

vendors := dedup(table(dx_Vendor_Src.Key_Vendor_Src(TRUE), {source_code, display_name}), record, all);
GetVendorSrc(string code) := vendors(source_code = code)[1].display_name;

MAC_SRC_STAT(infile, src_fld, filename, isMdrSrc) := MACRO
  
   #uniquename(ts)
   #if(isMdrSrc = true)
   %ts% := sort(table(infile(src_fld <> ''), {src_fld, desc := mdr.sourcetools.translatesource(src_fld), cnt := count(group)}, src_fld, few, merge), -cnt);
   #else
   %ts% := sort(table(infile(src_fld <> ''), {src_fld, desc := GetVendorSrc(src_fld), cnt := count(group)}, src_fld), -cnt);
   #end;

   output(%ts%, all, named(filename));

ENDMACRO;

//----------- CONSUMER FILE---------------//
consumers := dataset('~persist::d2c::full::infutor_hdr', header.Layout_Header, thor);
MAC_SRC_STAT(consumers, src, 'Consumers_by_src', true);

//----------- CRIMINAL_RECORDS---------------//
crims := d2c_customers.files.CrimsDS(1);
MAC_SRC_STAT(crims, vendor, 'Criminals_by_src', true);

//----------- DEEDS_RECORDS---------------//
deeds := d2c_customers.files.DeedsDS(1);
MAC_SRC_STAT(deeds, ln_fares_id[1..2], 'Deeds_by_src', true);

//----------- TAX_RECORDS---------------//
tax := d2c_customers.files.TaxDS(1);
MAC_SRC_STAT(tax, ln_fares_id[1..2], 'Tax_by_src', true);

//----------- PROFESSIONAL_LICENSES---------------//
pl := d2c_customers.files.PLDS(1);
MAC_SRC_STAT(pl, vendor, 'PL_by_src', false);

//----------- SEX_OFFENDERS---------------//
so := d2c_customers.files.SODS(1);
MAC_SRC_STAT(so, source_file, 'SO_by_src', false);

//----------- STUDENTS---------------//
asl := d2c_customers.files.ASLDS(1);
MAC_SRC_STAT(asl, source, 'Students_by_src', true);

//----------- VOTER_REGISTRATION---------------//
voters := d2c_customers.files.VotersDS(1);
MAC_SRC_STAT(voters, source, 'Voters_by_src', true);

//----------- CONCEALED_WEAPONS---------------//
weapons := d2c_customers.files.CCWDS(1);
// MAC_SRC_STAT(weapons, source_state, 'Weapons_by_src');

//----------- PHONES---------------//
phones := d2c_customers.files.PHONESDS(1);
MAC_SRC_STAT(phones, vendor, 'Phones_by_src', true);

//----------- HUNTING_FISHING_PERMITS---------------//
Hunting := d2c_customers.files.HuntingDS(1);
MAC_SRC_STAT(Hunting, source_code, 'Hunting_by_src', true);

//----------- PEOPLE_AT_WORK---------------//
paw := d2c_customers.files.PawDS(1);
MAC_SRC_STAT(paw, source, 'People_at_work_by_src', true);

//----------- EMAIL_ADDRESSES---------------//
email := d2c_customers.files.emailsDS(1);
MAC_SRC_STAT(email, email_src, 'Email_by_src', true);

//----------- NATIONAL_UCC---------------//
ucc  := UCCV2.File_UCC_Main_Base(D2C_Customers.SRC_Allowed.Check(14, filing_jurisdiction));
MAC_SRC_STAT(ucc, filing_jurisdiction, 'UCC_by_src', true);

//----------- Bankruptcy---------------//
bk  := UCCV2.File_UCC_Main_Base(D2C_Customers.SRC_Allowed.Check(14, filing_jurisdiction));
MAC_SRC_STAT(bk, filing_jurisdiction, 'Bankruptcy_by_src', true);

//----------- Liens---------------//
li  := dataset('~thor_data400::base::liens::main', liensv2.Layout_liens_main_module.layout_liens_main, thor)(D2C_Customers.SRC_Allowed.Check(13, filing_state));
MAC_SRC_STAT(li, filing_state, 'Liens_by_src', true);