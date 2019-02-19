IMPORT SALT311,STD;
EXPORT Infutor_Motorcycle_hygiene(dataset(Infutor_Motorcycle_layout_VehicleV2) h) := MODULE

//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := IF(Glob, (TYPEOF(h.state_origin))'', MAX(GROUP,h.state_origin));
    NumberOfRecords := COUNT(GROUP);
    populated_iid_cnt := COUNT(GROUP,h.iid <> (TYPEOF(h.iid))'');
    populated_iid_pcnt := AVE(GROUP,IF(h.iid = (TYPEOF(h.iid))'',0,100));
    maxlength_iid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.iid)));
    avelength_iid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.iid)),h.iid<>(typeof(h.iid))'');
    populated_pid_cnt := COUNT(GROUP,h.pid <> (TYPEOF(h.pid))'');
    populated_pid_pcnt := AVE(GROUP,IF(h.pid = (TYPEOF(h.pid))'',0,100));
    maxlength_pid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pid)));
    avelength_pid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pid)),h.pid<>(typeof(h.pid))'');
    populated_vin_cnt := COUNT(GROUP,h.vin <> (TYPEOF(h.vin))'');
    populated_vin_pcnt := AVE(GROUP,IF(h.vin = (TYPEOF(h.vin))'',0,100));
    maxlength_vin := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vin)));
    avelength_vin := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vin)),h.vin<>(typeof(h.vin))'');
    populated_make_cnt := COUNT(GROUP,h.make <> (TYPEOF(h.make))'');
    populated_make_pcnt := AVE(GROUP,IF(h.make = (TYPEOF(h.make))'',0,100));
    maxlength_make := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.make)));
    avelength_make := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.make)),h.make<>(typeof(h.make))'');
    populated_model_cnt := COUNT(GROUP,h.model <> (TYPEOF(h.model))'');
    populated_model_pcnt := AVE(GROUP,IF(h.model = (TYPEOF(h.model))'',0,100));
    maxlength_model := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.model)));
    avelength_model := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.model)),h.model<>(typeof(h.model))'');
    populated_year_cnt := COUNT(GROUP,h.year <> (TYPEOF(h.year))'');
    populated_year_pcnt := AVE(GROUP,IF(h.year = (TYPEOF(h.year))'',0,100));
    maxlength_year := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.year)));
    avelength_year := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.year)),h.year<>(typeof(h.year))'');
    populated_class_code_cnt := COUNT(GROUP,h.class_code <> (TYPEOF(h.class_code))'');
    populated_class_code_pcnt := AVE(GROUP,IF(h.class_code = (TYPEOF(h.class_code))'',0,100));
    maxlength_class_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.class_code)));
    avelength_class_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.class_code)),h.class_code<>(typeof(h.class_code))'');
    populated_fuel_type_code_cnt := COUNT(GROUP,h.fuel_type_code <> (TYPEOF(h.fuel_type_code))'');
    populated_fuel_type_code_pcnt := AVE(GROUP,IF(h.fuel_type_code = (TYPEOF(h.fuel_type_code))'',0,100));
    maxlength_fuel_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fuel_type_code)));
    avelength_fuel_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fuel_type_code)),h.fuel_type_code<>(typeof(h.fuel_type_code))'');
    populated_mfg_code_cnt := COUNT(GROUP,h.mfg_code <> (TYPEOF(h.mfg_code))'');
    populated_mfg_code_pcnt := AVE(GROUP,IF(h.mfg_code = (TYPEOF(h.mfg_code))'',0,100));
    maxlength_mfg_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfg_code)));
    avelength_mfg_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfg_code)),h.mfg_code<>(typeof(h.mfg_code))'');
    populated_style_code_cnt := COUNT(GROUP,h.style_code <> (TYPEOF(h.style_code))'');
    populated_style_code_pcnt := AVE(GROUP,IF(h.style_code = (TYPEOF(h.style_code))'',0,100));
    maxlength_style_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.style_code)));
    avelength_style_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.style_code)),h.style_code<>(typeof(h.style_code))'');
    populated_mileagecd_cnt := COUNT(GROUP,h.mileagecd <> (TYPEOF(h.mileagecd))'');
    populated_mileagecd_pcnt := AVE(GROUP,IF(h.mileagecd = (TYPEOF(h.mileagecd))'',0,100));
    maxlength_mileagecd := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mileagecd)));
    avelength_mileagecd := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mileagecd)),h.mileagecd<>(typeof(h.mileagecd))'');
    populated_nbr_vehicles_cnt := COUNT(GROUP,h.nbr_vehicles <> (TYPEOF(h.nbr_vehicles))'');
    populated_nbr_vehicles_pcnt := AVE(GROUP,IF(h.nbr_vehicles = (TYPEOF(h.nbr_vehicles))'',0,100));
    maxlength_nbr_vehicles := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nbr_vehicles)));
    avelength_nbr_vehicles := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nbr_vehicles)),h.nbr_vehicles<>(typeof(h.nbr_vehicles))'');
    populated_idate_cnt := COUNT(GROUP,h.idate <> (TYPEOF(h.idate))'');
    populated_idate_pcnt := AVE(GROUP,IF(h.idate = (TYPEOF(h.idate))'',0,100));
    maxlength_idate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.idate)));
    avelength_idate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.idate)),h.idate<>(typeof(h.idate))'');
    populated_odate_cnt := COUNT(GROUP,h.odate <> (TYPEOF(h.odate))'');
    populated_odate_pcnt := AVE(GROUP,IF(h.odate = (TYPEOF(h.odate))'',0,100));
    maxlength_odate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.odate)));
    avelength_odate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.odate)),h.odate<>(typeof(h.odate))'');
    populated_fname_cnt := COUNT(GROUP,h.fname <> (TYPEOF(h.fname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mi_cnt := COUNT(GROUP,h.mi <> (TYPEOF(h.mi))'');
    populated_mi_pcnt := AVE(GROUP,IF(h.mi = (TYPEOF(h.mi))'',0,100));
    maxlength_mi := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mi)));
    avelength_mi := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mi)),h.mi<>(typeof(h.mi))'');
    populated_lname_cnt := COUNT(GROUP,h.lname <> (TYPEOF(h.lname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_suffix_cnt := COUNT(GROUP,h.suffix <> (TYPEOF(h.suffix))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_gender_cnt := COUNT(GROUP,h.gender <> (TYPEOF(h.gender))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_house_cnt := COUNT(GROUP,h.house <> (TYPEOF(h.house))'');
    populated_house_pcnt := AVE(GROUP,IF(h.house = (TYPEOF(h.house))'',0,100));
    maxlength_house := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.house)));
    avelength_house := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.house)),h.house<>(typeof(h.house))'');
    populated_predir_cnt := COUNT(GROUP,h.predir <> (TYPEOF(h.predir))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_street_cnt := COUNT(GROUP,h.street <> (TYPEOF(h.street))'');
    populated_street_pcnt := AVE(GROUP,IF(h.street = (TYPEOF(h.street))'',0,100));
    maxlength_street := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.street)));
    avelength_street := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.street)),h.street<>(typeof(h.street))'');
    populated_strtype_cnt := COUNT(GROUP,h.strtype <> (TYPEOF(h.strtype))'');
    populated_strtype_pcnt := AVE(GROUP,IF(h.strtype = (TYPEOF(h.strtype))'',0,100));
    maxlength_strtype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.strtype)));
    avelength_strtype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.strtype)),h.strtype<>(typeof(h.strtype))'');
    populated_postdir_cnt := COUNT(GROUP,h.postdir <> (TYPEOF(h.postdir))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_apttype_cnt := COUNT(GROUP,h.apttype <> (TYPEOF(h.apttype))'');
    populated_apttype_pcnt := AVE(GROUP,IF(h.apttype = (TYPEOF(h.apttype))'',0,100));
    maxlength_apttype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.apttype)));
    avelength_apttype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.apttype)),h.apttype<>(typeof(h.apttype))'');
    populated_aptnbr_cnt := COUNT(GROUP,h.aptnbr <> (TYPEOF(h.aptnbr))'');
    populated_aptnbr_pcnt := AVE(GROUP,IF(h.aptnbr = (TYPEOF(h.aptnbr))'',0,100));
    maxlength_aptnbr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.aptnbr)));
    avelength_aptnbr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.aptnbr)),h.aptnbr<>(typeof(h.aptnbr))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_z4_cnt := COUNT(GROUP,h.z4 <> (TYPEOF(h.z4))'');
    populated_z4_pcnt := AVE(GROUP,IF(h.z4 = (TYPEOF(h.z4))'',0,100));
    maxlength_z4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.z4)));
    avelength_z4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.z4)),h.z4<>(typeof(h.z4))'');
    populated_dpc_cnt := COUNT(GROUP,h.dpc <> (TYPEOF(h.dpc))'');
    populated_dpc_pcnt := AVE(GROUP,IF(h.dpc = (TYPEOF(h.dpc))'',0,100));
    maxlength_dpc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dpc)));
    avelength_dpc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dpc)),h.dpc<>(typeof(h.dpc))'');
    populated_crte_cnt := COUNT(GROUP,h.crte <> (TYPEOF(h.crte))'');
    populated_crte_pcnt := AVE(GROUP,IF(h.crte = (TYPEOF(h.crte))'',0,100));
    maxlength_crte := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.crte)));
    avelength_crte := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.crte)),h.crte<>(typeof(h.crte))'');
    populated_cnty_cnt := COUNT(GROUP,h.cnty <> (TYPEOF(h.cnty))'');
    populated_cnty_pcnt := AVE(GROUP,IF(h.cnty = (TYPEOF(h.cnty))'',0,100));
    maxlength_cnty := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnty)));
    avelength_cnty := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cnty)),h.cnty<>(typeof(h.cnty))'');
    populated_z4type_cnt := COUNT(GROUP,h.z4type <> (TYPEOF(h.z4type))'');
    populated_z4type_pcnt := AVE(GROUP,IF(h.z4type = (TYPEOF(h.z4type))'',0,100));
    maxlength_z4type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.z4type)));
    avelength_z4type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.z4type)),h.z4type<>(typeof(h.z4type))'');
    populated_dpv_cnt := COUNT(GROUP,h.dpv <> (TYPEOF(h.dpv))'');
    populated_dpv_pcnt := AVE(GROUP,IF(h.dpv = (TYPEOF(h.dpv))'',0,100));
    maxlength_dpv := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dpv)));
    avelength_dpv := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dpv)),h.dpv<>(typeof(h.dpv))'');
    populated_vacant_cnt := COUNT(GROUP,h.vacant <> (TYPEOF(h.vacant))'');
    populated_vacant_pcnt := AVE(GROUP,IF(h.vacant = (TYPEOF(h.vacant))'',0,100));
    maxlength_vacant := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vacant)));
    avelength_vacant := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vacant)),h.vacant<>(typeof(h.vacant))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_dnc_cnt := COUNT(GROUP,h.dnc <> (TYPEOF(h.dnc))'');
    populated_dnc_pcnt := AVE(GROUP,IF(h.dnc = (TYPEOF(h.dnc))'',0,100));
    maxlength_dnc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dnc)));
    avelength_dnc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dnc)),h.dnc<>(typeof(h.dnc))'');
    populated_internal1_cnt := COUNT(GROUP,h.internal1 <> (TYPEOF(h.internal1))'');
    populated_internal1_pcnt := AVE(GROUP,IF(h.internal1 = (TYPEOF(h.internal1))'',0,100));
    maxlength_internal1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.internal1)));
    avelength_internal1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.internal1)),h.internal1<>(typeof(h.internal1))'');
    populated_internal2_cnt := COUNT(GROUP,h.internal2 <> (TYPEOF(h.internal2))'');
    populated_internal2_pcnt := AVE(GROUP,IF(h.internal2 = (TYPEOF(h.internal2))'',0,100));
    maxlength_internal2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.internal2)));
    avelength_internal2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.internal2)),h.internal2<>(typeof(h.internal2))'');
    populated_internal3_cnt := COUNT(GROUP,h.internal3 <> (TYPEOF(h.internal3))'');
    populated_internal3_pcnt := AVE(GROUP,IF(h.internal3 = (TYPEOF(h.internal3))'',0,100));
    maxlength_internal3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.internal3)));
    avelength_internal3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.internal3)),h.internal3<>(typeof(h.internal3))'');
    populated_county_cnt := COUNT(GROUP,h.county <> (TYPEOF(h.county))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_msa_cnt := COUNT(GROUP,h.msa <> (TYPEOF(h.msa))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_cbsa_cnt := COUNT(GROUP,h.cbsa <> (TYPEOF(h.cbsa))'');
    populated_cbsa_pcnt := AVE(GROUP,IF(h.cbsa = (TYPEOF(h.cbsa))'',0,100));
    maxlength_cbsa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cbsa)));
    avelength_cbsa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cbsa)),h.cbsa<>(typeof(h.cbsa))'');
    populated_ehi_cnt := COUNT(GROUP,h.ehi <> (TYPEOF(h.ehi))'');
    populated_ehi_pcnt := AVE(GROUP,IF(h.ehi = (TYPEOF(h.ehi))'',0,100));
    maxlength_ehi := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ehi)));
    avelength_ehi := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ehi)),h.ehi<>(typeof(h.ehi))'');
    populated_child_cnt := COUNT(GROUP,h.child <> (TYPEOF(h.child))'');
    populated_child_pcnt := AVE(GROUP,IF(h.child = (TYPEOF(h.child))'',0,100));
    maxlength_child := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.child)));
    avelength_child := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.child)),h.child<>(typeof(h.child))'');
    populated_homeowner_cnt := COUNT(GROUP,h.homeowner <> (TYPEOF(h.homeowner))'');
    populated_homeowner_pcnt := AVE(GROUP,IF(h.homeowner = (TYPEOF(h.homeowner))'',0,100));
    maxlength_homeowner := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.homeowner)));
    avelength_homeowner := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.homeowner)),h.homeowner<>(typeof(h.homeowner))'');
    populated_pctw_cnt := COUNT(GROUP,h.pctw <> (TYPEOF(h.pctw))'');
    populated_pctw_pcnt := AVE(GROUP,IF(h.pctw = (TYPEOF(h.pctw))'',0,100));
    maxlength_pctw := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pctw)));
    avelength_pctw := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pctw)),h.pctw<>(typeof(h.pctw))'');
    populated_pctb_cnt := COUNT(GROUP,h.pctb <> (TYPEOF(h.pctb))'');
    populated_pctb_pcnt := AVE(GROUP,IF(h.pctb = (TYPEOF(h.pctb))'',0,100));
    maxlength_pctb := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pctb)));
    avelength_pctb := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pctb)),h.pctb<>(typeof(h.pctb))'');
    populated_pcta_cnt := COUNT(GROUP,h.pcta <> (TYPEOF(h.pcta))'');
    populated_pcta_pcnt := AVE(GROUP,IF(h.pcta = (TYPEOF(h.pcta))'',0,100));
    maxlength_pcta := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pcta)));
    avelength_pcta := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pcta)),h.pcta<>(typeof(h.pcta))'');
    populated_pcth_cnt := COUNT(GROUP,h.pcth <> (TYPEOF(h.pcth))'');
    populated_pcth_pcnt := AVE(GROUP,IF(h.pcth = (TYPEOF(h.pcth))'',0,100));
    maxlength_pcth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pcth)));
    avelength_pcth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pcth)),h.pcth<>(typeof(h.pcth))'');
    populated_pctspe_cnt := COUNT(GROUP,h.pctspe <> (TYPEOF(h.pctspe))'');
    populated_pctspe_pcnt := AVE(GROUP,IF(h.pctspe = (TYPEOF(h.pctspe))'',0,100));
    maxlength_pctspe := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pctspe)));
    avelength_pctspe := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pctspe)),h.pctspe<>(typeof(h.pctspe))'');
    populated_pctsps_cnt := COUNT(GROUP,h.pctsps <> (TYPEOF(h.pctsps))'');
    populated_pctsps_pcnt := AVE(GROUP,IF(h.pctsps = (TYPEOF(h.pctsps))'',0,100));
    maxlength_pctsps := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pctsps)));
    avelength_pctsps := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pctsps)),h.pctsps<>(typeof(h.pctsps))'');
    populated_pctspa_cnt := COUNT(GROUP,h.pctspa <> (TYPEOF(h.pctspa))'');
    populated_pctspa_pcnt := AVE(GROUP,IF(h.pctspa = (TYPEOF(h.pctspa))'',0,100));
    maxlength_pctspa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pctspa)));
    avelength_pctspa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pctspa)),h.pctspa<>(typeof(h.pctspa))'');
    populated_mhv_cnt := COUNT(GROUP,h.mhv <> (TYPEOF(h.mhv))'');
    populated_mhv_pcnt := AVE(GROUP,IF(h.mhv = (TYPEOF(h.mhv))'',0,100));
    maxlength_mhv := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mhv)));
    avelength_mhv := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mhv)),h.mhv<>(typeof(h.mhv))'');
    populated_mor_cnt := COUNT(GROUP,h.mor <> (TYPEOF(h.mor))'');
    populated_mor_pcnt := AVE(GROUP,IF(h.mor = (TYPEOF(h.mor))'',0,100));
    maxlength_mor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mor)));
    avelength_mor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mor)),h.mor<>(typeof(h.mor))'');
    populated_pctoccw_cnt := COUNT(GROUP,h.pctoccw <> (TYPEOF(h.pctoccw))'');
    populated_pctoccw_pcnt := AVE(GROUP,IF(h.pctoccw = (TYPEOF(h.pctoccw))'',0,100));
    maxlength_pctoccw := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pctoccw)));
    avelength_pctoccw := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pctoccw)),h.pctoccw<>(typeof(h.pctoccw))'');
    populated_pctoccb_cnt := COUNT(GROUP,h.pctoccb <> (TYPEOF(h.pctoccb))'');
    populated_pctoccb_pcnt := AVE(GROUP,IF(h.pctoccb = (TYPEOF(h.pctoccb))'',0,100));
    maxlength_pctoccb := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pctoccb)));
    avelength_pctoccb := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pctoccb)),h.pctoccb<>(typeof(h.pctoccb))'');
    populated_pctocco_cnt := COUNT(GROUP,h.pctocco <> (TYPEOF(h.pctocco))'');
    populated_pctocco_pcnt := AVE(GROUP,IF(h.pctocco = (TYPEOF(h.pctocco))'',0,100));
    maxlength_pctocco := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pctocco)));
    avelength_pctocco := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pctocco)),h.pctocco<>(typeof(h.pctocco))'');
    populated_lor_cnt := COUNT(GROUP,h.lor <> (TYPEOF(h.lor))'');
    populated_lor_pcnt := AVE(GROUP,IF(h.lor = (TYPEOF(h.lor))'',0,100));
    maxlength_lor := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lor)));
    avelength_lor := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lor)),h.lor<>(typeof(h.lor))'');
    populated_sfdu_cnt := COUNT(GROUP,h.sfdu <> (TYPEOF(h.sfdu))'');
    populated_sfdu_pcnt := AVE(GROUP,IF(h.sfdu = (TYPEOF(h.sfdu))'',0,100));
    maxlength_sfdu := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sfdu)));
    avelength_sfdu := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sfdu)),h.sfdu<>(typeof(h.sfdu))'');
    populated_mfdu_cnt := COUNT(GROUP,h.mfdu <> (TYPEOF(h.mfdu))'');
    populated_mfdu_pcnt := AVE(GROUP,IF(h.mfdu = (TYPEOF(h.mfdu))'',0,100));
    maxlength_mfdu := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfdu)));
    avelength_mfdu := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mfdu)),h.mfdu<>(typeof(h.mfdu))'');
    populated_processdate_cnt := COUNT(GROUP,h.processdate <> (TYPEOF(h.processdate))'');
    populated_processdate_pcnt := AVE(GROUP,IF(h.processdate = (TYPEOF(h.processdate))'',0,100));
    maxlength_processdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.processdate)));
    avelength_processdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.processdate)),h.processdate<>(typeof(h.processdate))'');
    populated_source_code_cnt := COUNT(GROUP,h.source_code <> (TYPEOF(h.source_code))'');
    populated_source_code_pcnt := AVE(GROUP,IF(h.source_code = (TYPEOF(h.source_code))'',0,100));
    maxlength_source_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_code)));
    avelength_source_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_code)),h.source_code<>(typeof(h.source_code))'');
    populated_state_origin_cnt := COUNT(GROUP,h.state_origin <> (TYPEOF(h.state_origin))'');
    populated_state_origin_pcnt := AVE(GROUP,IF(h.state_origin = (TYPEOF(h.state_origin))'',0,100));
    maxlength_state_origin := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_origin)));
    avelength_state_origin := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_origin)),h.state_origin<>(typeof(h.state_origin))'');
    populated_append_ownernametypeind_cnt := COUNT(GROUP,h.append_ownernametypeind <> (TYPEOF(h.append_ownernametypeind))'');
    populated_append_ownernametypeind_pcnt := AVE(GROUP,IF(h.append_ownernametypeind = (TYPEOF(h.append_ownernametypeind))'',0,100));
    maxlength_append_ownernametypeind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_ownernametypeind)));
    avelength_append_ownernametypeind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_ownernametypeind)),h.append_ownernametypeind<>(typeof(h.append_ownernametypeind))'');
    populated_fullname_cnt := COUNT(GROUP,h.fullname <> (TYPEOF(h.fullname))'');
    populated_fullname_pcnt := AVE(GROUP,IF(h.fullname = (TYPEOF(h.fullname))'',0,100));
    maxlength_fullname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fullname)));
    avelength_fullname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fullname)),h.fullname<>(typeof(h.fullname))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,state_origin,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_iid_pcnt *   0.00 / 100 + T.Populated_pid_pcnt *   0.00 / 100 + T.Populated_vin_pcnt *   0.00 / 100 + T.Populated_make_pcnt *   0.00 / 100 + T.Populated_model_pcnt *   0.00 / 100 + T.Populated_year_pcnt *   0.00 / 100 + T.Populated_class_code_pcnt *   0.00 / 100 + T.Populated_fuel_type_code_pcnt *   0.00 / 100 + T.Populated_mfg_code_pcnt *   0.00 / 100 + T.Populated_style_code_pcnt *   0.00 / 100 + T.Populated_mileagecd_pcnt *   0.00 / 100 + T.Populated_nbr_vehicles_pcnt *   0.00 / 100 + T.Populated_idate_pcnt *   0.00 / 100 + T.Populated_odate_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mi_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_house_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_street_pcnt *   0.00 / 100 + T.Populated_strtype_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_apttype_pcnt *   0.00 / 100 + T.Populated_aptnbr_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_z4_pcnt *   0.00 / 100 + T.Populated_dpc_pcnt *   0.00 / 100 + T.Populated_crte_pcnt *   0.00 / 100 + T.Populated_cnty_pcnt *   0.00 / 100 + T.Populated_z4type_pcnt *   0.00 / 100 + T.Populated_dpv_pcnt *   0.00 / 100 + T.Populated_vacant_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_dnc_pcnt *   0.00 / 100 + T.Populated_internal1_pcnt *   0.00 / 100 + T.Populated_internal2_pcnt *   0.00 / 100 + T.Populated_internal3_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_cbsa_pcnt *   0.00 / 100 + T.Populated_ehi_pcnt *   0.00 / 100 + T.Populated_child_pcnt *   0.00 / 100 + T.Populated_homeowner_pcnt *   0.00 / 100 + T.Populated_pctw_pcnt *   0.00 / 100 + T.Populated_pctb_pcnt *   0.00 / 100 + T.Populated_pcta_pcnt *   0.00 / 100 + T.Populated_pcth_pcnt *   0.00 / 100 + T.Populated_pctspe_pcnt *   0.00 / 100 + T.Populated_pctsps_pcnt *   0.00 / 100 + T.Populated_pctspa_pcnt *   0.00 / 100 + T.Populated_mhv_pcnt *   0.00 / 100 + T.Populated_mor_pcnt *   0.00 / 100 + T.Populated_pctoccw_pcnt *   0.00 / 100 + T.Populated_pctoccb_pcnt *   0.00 / 100 + T.Populated_pctocco_pcnt *   0.00 / 100 + T.Populated_lor_pcnt *   0.00 / 100 + T.Populated_sfdu_pcnt *   0.00 / 100 + T.Populated_mfdu_pcnt *   0.00 / 100 + T.Populated_processdate_pcnt *   0.00 / 100 + T.Populated_source_code_pcnt *   0.00 / 100 + T.Populated_state_origin_pcnt *   0.00 / 100 + T.Populated_append_ownernametypeind_pcnt *   0.00 / 100 + T.Populated_fullname_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;

EXPORT SourceCounts := Summary('SummaryBySource',FALSE);
  R := RECORD
    STRING state_origin1;
    STRING state_origin2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.state_origin1 := le.Source;
    SELF.state_origin2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_iid_pcnt*ri.Populated_iid_pcnt *   0.00 / 10000 + le.Populated_pid_pcnt*ri.Populated_pid_pcnt *   0.00 / 10000 + le.Populated_vin_pcnt*ri.Populated_vin_pcnt *   0.00 / 10000 + le.Populated_make_pcnt*ri.Populated_make_pcnt *   0.00 / 10000 + le.Populated_model_pcnt*ri.Populated_model_pcnt *   0.00 / 10000 + le.Populated_year_pcnt*ri.Populated_year_pcnt *   0.00 / 10000 + le.Populated_class_code_pcnt*ri.Populated_class_code_pcnt *   0.00 / 10000 + le.Populated_fuel_type_code_pcnt*ri.Populated_fuel_type_code_pcnt *   0.00 / 10000 + le.Populated_mfg_code_pcnt*ri.Populated_mfg_code_pcnt *   0.00 / 10000 + le.Populated_style_code_pcnt*ri.Populated_style_code_pcnt *   0.00 / 10000 + le.Populated_mileagecd_pcnt*ri.Populated_mileagecd_pcnt *   0.00 / 10000 + le.Populated_nbr_vehicles_pcnt*ri.Populated_nbr_vehicles_pcnt *   0.00 / 10000 + le.Populated_idate_pcnt*ri.Populated_idate_pcnt *   0.00 / 10000 + le.Populated_odate_pcnt*ri.Populated_odate_pcnt *   0.00 / 10000 + le.Populated_fname_pcnt*ri.Populated_fname_pcnt *   0.00 / 10000 + le.Populated_mi_pcnt*ri.Populated_mi_pcnt *   0.00 / 10000 + le.Populated_lname_pcnt*ri.Populated_lname_pcnt *   0.00 / 10000 + le.Populated_suffix_pcnt*ri.Populated_suffix_pcnt *   0.00 / 10000 + le.Populated_gender_pcnt*ri.Populated_gender_pcnt *   0.00 / 10000 + le.Populated_house_pcnt*ri.Populated_house_pcnt *   0.00 / 10000 + le.Populated_predir_pcnt*ri.Populated_predir_pcnt *   0.00 / 10000 + le.Populated_street_pcnt*ri.Populated_street_pcnt *   0.00 / 10000 + le.Populated_strtype_pcnt*ri.Populated_strtype_pcnt *   0.00 / 10000 + le.Populated_postdir_pcnt*ri.Populated_postdir_pcnt *   0.00 / 10000 + le.Populated_apttype_pcnt*ri.Populated_apttype_pcnt *   0.00 / 10000 + le.Populated_aptnbr_pcnt*ri.Populated_aptnbr_pcnt *   0.00 / 10000 + le.Populated_city_pcnt*ri.Populated_city_pcnt *   0.00 / 10000 + le.Populated_state_pcnt*ri.Populated_state_pcnt *   0.00 / 10000 + le.Populated_zip_pcnt*ri.Populated_zip_pcnt *   0.00 / 10000 + le.Populated_z4_pcnt*ri.Populated_z4_pcnt *   0.00 / 10000 + le.Populated_dpc_pcnt*ri.Populated_dpc_pcnt *   0.00 / 10000 + le.Populated_crte_pcnt*ri.Populated_crte_pcnt *   0.00 / 10000 + le.Populated_cnty_pcnt*ri.Populated_cnty_pcnt *   0.00 / 10000 + le.Populated_z4type_pcnt*ri.Populated_z4type_pcnt *   0.00 / 10000 + le.Populated_dpv_pcnt*ri.Populated_dpv_pcnt *   0.00 / 10000 + le.Populated_vacant_pcnt*ri.Populated_vacant_pcnt *   0.00 / 10000 + le.Populated_phone_pcnt*ri.Populated_phone_pcnt *   0.00 / 10000 + le.Populated_dnc_pcnt*ri.Populated_dnc_pcnt *   0.00 / 10000 + le.Populated_internal1_pcnt*ri.Populated_internal1_pcnt *   0.00 / 10000 + le.Populated_internal2_pcnt*ri.Populated_internal2_pcnt *   0.00 / 10000 + le.Populated_internal3_pcnt*ri.Populated_internal3_pcnt *   0.00 / 10000 + le.Populated_county_pcnt*ri.Populated_county_pcnt *   0.00 / 10000 + le.Populated_msa_pcnt*ri.Populated_msa_pcnt *   0.00 / 10000 + le.Populated_cbsa_pcnt*ri.Populated_cbsa_pcnt *   0.00 / 10000 + le.Populated_ehi_pcnt*ri.Populated_ehi_pcnt *   0.00 / 10000 + le.Populated_child_pcnt*ri.Populated_child_pcnt *   0.00 / 10000 + le.Populated_homeowner_pcnt*ri.Populated_homeowner_pcnt *   0.00 / 10000 + le.Populated_pctw_pcnt*ri.Populated_pctw_pcnt *   0.00 / 10000 + le.Populated_pctb_pcnt*ri.Populated_pctb_pcnt *   0.00 / 10000 + le.Populated_pcta_pcnt*ri.Populated_pcta_pcnt *   0.00 / 10000 + le.Populated_pcth_pcnt*ri.Populated_pcth_pcnt *   0.00 / 10000 + le.Populated_pctspe_pcnt*ri.Populated_pctspe_pcnt *   0.00 / 10000 + le.Populated_pctsps_pcnt*ri.Populated_pctsps_pcnt *   0.00 / 10000 + le.Populated_pctspa_pcnt*ri.Populated_pctspa_pcnt *   0.00 / 10000 + le.Populated_mhv_pcnt*ri.Populated_mhv_pcnt *   0.00 / 10000 + le.Populated_mor_pcnt*ri.Populated_mor_pcnt *   0.00 / 10000 + le.Populated_pctoccw_pcnt*ri.Populated_pctoccw_pcnt *   0.00 / 10000 + le.Populated_pctoccb_pcnt*ri.Populated_pctoccb_pcnt *   0.00 / 10000 + le.Populated_pctocco_pcnt*ri.Populated_pctocco_pcnt *   0.00 / 10000 + le.Populated_lor_pcnt*ri.Populated_lor_pcnt *   0.00 / 10000 + le.Populated_sfdu_pcnt*ri.Populated_sfdu_pcnt *   0.00 / 10000 + le.Populated_mfdu_pcnt*ri.Populated_mfdu_pcnt *   0.00 / 10000 + le.Populated_processdate_pcnt*ri.Populated_processdate_pcnt *   0.00 / 10000 + le.Populated_source_code_pcnt*ri.Populated_source_code_pcnt *   0.00 / 10000 + le.Populated_state_origin_pcnt*ri.Populated_state_origin_pcnt *   0.00 / 10000 + le.Populated_append_ownernametypeind_pcnt*ri.Populated_append_ownernametypeind_pcnt *   0.00 / 10000 + le.Populated_fullname_pcnt*ri.Populated_fullname_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'iid','pid','vin','make','model','year','class_code','fuel_type_code','mfg_code','style_code','mileagecd','nbr_vehicles','idate','odate','fname','mi','lname','suffix','gender','house','predir','street','strtype','postdir','apttype','aptnbr','city','state','zip','z4','dpc','crte','cnty','z4type','dpv','vacant','phone','dnc','internal1','internal2','internal3','county','msa','cbsa','ehi','child','homeowner','pctw','pctb','pcta','pcth','pctspe','pctsps','pctspa','mhv','mor','pctoccw','pctoccb','pctocco','lor','sfdu','mfdu','processdate','source_code','state_origin','append_ownernametypeind','fullname');
  SELF.populated_pcnt := CHOOSE(C,le.populated_iid_pcnt,le.populated_pid_pcnt,le.populated_vin_pcnt,le.populated_make_pcnt,le.populated_model_pcnt,le.populated_year_pcnt,le.populated_class_code_pcnt,le.populated_fuel_type_code_pcnt,le.populated_mfg_code_pcnt,le.populated_style_code_pcnt,le.populated_mileagecd_pcnt,le.populated_nbr_vehicles_pcnt,le.populated_idate_pcnt,le.populated_odate_pcnt,le.populated_fname_pcnt,le.populated_mi_pcnt,le.populated_lname_pcnt,le.populated_suffix_pcnt,le.populated_gender_pcnt,le.populated_house_pcnt,le.populated_predir_pcnt,le.populated_street_pcnt,le.populated_strtype_pcnt,le.populated_postdir_pcnt,le.populated_apttype_pcnt,le.populated_aptnbr_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zip_pcnt,le.populated_z4_pcnt,le.populated_dpc_pcnt,le.populated_crte_pcnt,le.populated_cnty_pcnt,le.populated_z4type_pcnt,le.populated_dpv_pcnt,le.populated_vacant_pcnt,le.populated_phone_pcnt,le.populated_dnc_pcnt,le.populated_internal1_pcnt,le.populated_internal2_pcnt,le.populated_internal3_pcnt,le.populated_county_pcnt,le.populated_msa_pcnt,le.populated_cbsa_pcnt,le.populated_ehi_pcnt,le.populated_child_pcnt,le.populated_homeowner_pcnt,le.populated_pctw_pcnt,le.populated_pctb_pcnt,le.populated_pcta_pcnt,le.populated_pcth_pcnt,le.populated_pctspe_pcnt,le.populated_pctsps_pcnt,le.populated_pctspa_pcnt,le.populated_mhv_pcnt,le.populated_mor_pcnt,le.populated_pctoccw_pcnt,le.populated_pctoccb_pcnt,le.populated_pctocco_pcnt,le.populated_lor_pcnt,le.populated_sfdu_pcnt,le.populated_mfdu_pcnt,le.populated_processdate_pcnt,le.populated_source_code_pcnt,le.populated_state_origin_pcnt,le.populated_append_ownernametypeind_pcnt,le.populated_fullname_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_iid,le.maxlength_pid,le.maxlength_vin,le.maxlength_make,le.maxlength_model,le.maxlength_year,le.maxlength_class_code,le.maxlength_fuel_type_code,le.maxlength_mfg_code,le.maxlength_style_code,le.maxlength_mileagecd,le.maxlength_nbr_vehicles,le.maxlength_idate,le.maxlength_odate,le.maxlength_fname,le.maxlength_mi,le.maxlength_lname,le.maxlength_suffix,le.maxlength_gender,le.maxlength_house,le.maxlength_predir,le.maxlength_street,le.maxlength_strtype,le.maxlength_postdir,le.maxlength_apttype,le.maxlength_aptnbr,le.maxlength_city,le.maxlength_state,le.maxlength_zip,le.maxlength_z4,le.maxlength_dpc,le.maxlength_crte,le.maxlength_cnty,le.maxlength_z4type,le.maxlength_dpv,le.maxlength_vacant,le.maxlength_phone,le.maxlength_dnc,le.maxlength_internal1,le.maxlength_internal2,le.maxlength_internal3,le.maxlength_county,le.maxlength_msa,le.maxlength_cbsa,le.maxlength_ehi,le.maxlength_child,le.maxlength_homeowner,le.maxlength_pctw,le.maxlength_pctb,le.maxlength_pcta,le.maxlength_pcth,le.maxlength_pctspe,le.maxlength_pctsps,le.maxlength_pctspa,le.maxlength_mhv,le.maxlength_mor,le.maxlength_pctoccw,le.maxlength_pctoccb,le.maxlength_pctocco,le.maxlength_lor,le.maxlength_sfdu,le.maxlength_mfdu,le.maxlength_processdate,le.maxlength_source_code,le.maxlength_state_origin,le.maxlength_append_ownernametypeind,le.maxlength_fullname);
  SELF.avelength := CHOOSE(C,le.avelength_iid,le.avelength_pid,le.avelength_vin,le.avelength_make,le.avelength_model,le.avelength_year,le.avelength_class_code,le.avelength_fuel_type_code,le.avelength_mfg_code,le.avelength_style_code,le.avelength_mileagecd,le.avelength_nbr_vehicles,le.avelength_idate,le.avelength_odate,le.avelength_fname,le.avelength_mi,le.avelength_lname,le.avelength_suffix,le.avelength_gender,le.avelength_house,le.avelength_predir,le.avelength_street,le.avelength_strtype,le.avelength_postdir,le.avelength_apttype,le.avelength_aptnbr,le.avelength_city,le.avelength_state,le.avelength_zip,le.avelength_z4,le.avelength_dpc,le.avelength_crte,le.avelength_cnty,le.avelength_z4type,le.avelength_dpv,le.avelength_vacant,le.avelength_phone,le.avelength_dnc,le.avelength_internal1,le.avelength_internal2,le.avelength_internal3,le.avelength_county,le.avelength_msa,le.avelength_cbsa,le.avelength_ehi,le.avelength_child,le.avelength_homeowner,le.avelength_pctw,le.avelength_pctb,le.avelength_pcta,le.avelength_pcth,le.avelength_pctspe,le.avelength_pctsps,le.avelength_pctspa,le.avelength_mhv,le.avelength_mor,le.avelength_pctoccw,le.avelength_pctoccb,le.avelength_pctocco,le.avelength_lor,le.avelength_sfdu,le.avelength_mfdu,le.avelength_processdate,le.avelength_source_code,le.avelength_state_origin,le.avelength_append_ownernametypeind,le.avelength_fullname);
END;
EXPORT invSummary := NORMALIZE(summary0, 67, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.state_origin;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.iid),TRIM((SALT311.StrType)le.pid),TRIM((SALT311.StrType)le.vin),TRIM((SALT311.StrType)le.make),TRIM((SALT311.StrType)le.model),TRIM((SALT311.StrType)le.year),TRIM((SALT311.StrType)le.class_code),TRIM((SALT311.StrType)le.fuel_type_code),TRIM((SALT311.StrType)le.mfg_code),TRIM((SALT311.StrType)le.style_code),TRIM((SALT311.StrType)le.mileagecd),TRIM((SALT311.StrType)le.nbr_vehicles),TRIM((SALT311.StrType)le.idate),TRIM((SALT311.StrType)le.odate),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mi),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.house),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.street),TRIM((SALT311.StrType)le.strtype),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.apttype),TRIM((SALT311.StrType)le.aptnbr),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.z4),TRIM((SALT311.StrType)le.dpc),TRIM((SALT311.StrType)le.crte),TRIM((SALT311.StrType)le.cnty),TRIM((SALT311.StrType)le.z4type),TRIM((SALT311.StrType)le.dpv),TRIM((SALT311.StrType)le.vacant),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.dnc),TRIM((SALT311.StrType)le.internal1),TRIM((SALT311.StrType)le.internal2),TRIM((SALT311.StrType)le.internal3),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.cbsa),TRIM((SALT311.StrType)le.ehi),TRIM((SALT311.StrType)le.child),TRIM((SALT311.StrType)le.homeowner),TRIM((SALT311.StrType)le.pctw),TRIM((SALT311.StrType)le.pctb),TRIM((SALT311.StrType)le.pcta),TRIM((SALT311.StrType)le.pcth),TRIM((SALT311.StrType)le.pctspe),TRIM((SALT311.StrType)le.pctsps),TRIM((SALT311.StrType)le.pctspa),TRIM((SALT311.StrType)le.mhv),TRIM((SALT311.StrType)le.mor),TRIM((SALT311.StrType)le.pctoccw),TRIM((SALT311.StrType)le.pctoccb),TRIM((SALT311.StrType)le.pctocco),TRIM((SALT311.StrType)le.lor),TRIM((SALT311.StrType)le.sfdu),TRIM((SALT311.StrType)le.mfdu),TRIM((SALT311.StrType)le.processdate),TRIM((SALT311.StrType)le.source_code),TRIM((SALT311.StrType)le.state_origin),TRIM((SALT311.StrType)le.append_ownernametypeind),TRIM((SALT311.StrType)le.fullname)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,67,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 67);
  SELF.FldNo2 := 1 + (C % 67);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.iid),TRIM((SALT311.StrType)le.pid),TRIM((SALT311.StrType)le.vin),TRIM((SALT311.StrType)le.make),TRIM((SALT311.StrType)le.model),TRIM((SALT311.StrType)le.year),TRIM((SALT311.StrType)le.class_code),TRIM((SALT311.StrType)le.fuel_type_code),TRIM((SALT311.StrType)le.mfg_code),TRIM((SALT311.StrType)le.style_code),TRIM((SALT311.StrType)le.mileagecd),TRIM((SALT311.StrType)le.nbr_vehicles),TRIM((SALT311.StrType)le.idate),TRIM((SALT311.StrType)le.odate),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mi),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.house),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.street),TRIM((SALT311.StrType)le.strtype),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.apttype),TRIM((SALT311.StrType)le.aptnbr),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.z4),TRIM((SALT311.StrType)le.dpc),TRIM((SALT311.StrType)le.crte),TRIM((SALT311.StrType)le.cnty),TRIM((SALT311.StrType)le.z4type),TRIM((SALT311.StrType)le.dpv),TRIM((SALT311.StrType)le.vacant),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.dnc),TRIM((SALT311.StrType)le.internal1),TRIM((SALT311.StrType)le.internal2),TRIM((SALT311.StrType)le.internal3),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.cbsa),TRIM((SALT311.StrType)le.ehi),TRIM((SALT311.StrType)le.child),TRIM((SALT311.StrType)le.homeowner),TRIM((SALT311.StrType)le.pctw),TRIM((SALT311.StrType)le.pctb),TRIM((SALT311.StrType)le.pcta),TRIM((SALT311.StrType)le.pcth),TRIM((SALT311.StrType)le.pctspe),TRIM((SALT311.StrType)le.pctsps),TRIM((SALT311.StrType)le.pctspa),TRIM((SALT311.StrType)le.mhv),TRIM((SALT311.StrType)le.mor),TRIM((SALT311.StrType)le.pctoccw),TRIM((SALT311.StrType)le.pctoccb),TRIM((SALT311.StrType)le.pctocco),TRIM((SALT311.StrType)le.lor),TRIM((SALT311.StrType)le.sfdu),TRIM((SALT311.StrType)le.mfdu),TRIM((SALT311.StrType)le.processdate),TRIM((SALT311.StrType)le.source_code),TRIM((SALT311.StrType)le.state_origin),TRIM((SALT311.StrType)le.append_ownernametypeind),TRIM((SALT311.StrType)le.fullname)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.iid),TRIM((SALT311.StrType)le.pid),TRIM((SALT311.StrType)le.vin),TRIM((SALT311.StrType)le.make),TRIM((SALT311.StrType)le.model),TRIM((SALT311.StrType)le.year),TRIM((SALT311.StrType)le.class_code),TRIM((SALT311.StrType)le.fuel_type_code),TRIM((SALT311.StrType)le.mfg_code),TRIM((SALT311.StrType)le.style_code),TRIM((SALT311.StrType)le.mileagecd),TRIM((SALT311.StrType)le.nbr_vehicles),TRIM((SALT311.StrType)le.idate),TRIM((SALT311.StrType)le.odate),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mi),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.house),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.street),TRIM((SALT311.StrType)le.strtype),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.apttype),TRIM((SALT311.StrType)le.aptnbr),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.z4),TRIM((SALT311.StrType)le.dpc),TRIM((SALT311.StrType)le.crte),TRIM((SALT311.StrType)le.cnty),TRIM((SALT311.StrType)le.z4type),TRIM((SALT311.StrType)le.dpv),TRIM((SALT311.StrType)le.vacant),TRIM((SALT311.StrType)le.phone),TRIM((SALT311.StrType)le.dnc),TRIM((SALT311.StrType)le.internal1),TRIM((SALT311.StrType)le.internal2),TRIM((SALT311.StrType)le.internal3),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.cbsa),TRIM((SALT311.StrType)le.ehi),TRIM((SALT311.StrType)le.child),TRIM((SALT311.StrType)le.homeowner),TRIM((SALT311.StrType)le.pctw),TRIM((SALT311.StrType)le.pctb),TRIM((SALT311.StrType)le.pcta),TRIM((SALT311.StrType)le.pcth),TRIM((SALT311.StrType)le.pctspe),TRIM((SALT311.StrType)le.pctsps),TRIM((SALT311.StrType)le.pctspa),TRIM((SALT311.StrType)le.mhv),TRIM((SALT311.StrType)le.mor),TRIM((SALT311.StrType)le.pctoccw),TRIM((SALT311.StrType)le.pctoccb),TRIM((SALT311.StrType)le.pctocco),TRIM((SALT311.StrType)le.lor),TRIM((SALT311.StrType)le.sfdu),TRIM((SALT311.StrType)le.mfdu),TRIM((SALT311.StrType)le.processdate),TRIM((SALT311.StrType)le.source_code),TRIM((SALT311.StrType)le.state_origin),TRIM((SALT311.StrType)le.append_ownernametypeind),TRIM((SALT311.StrType)le.fullname)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),67*67,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'iid'}
      ,{2,'pid'}
      ,{3,'vin'}
      ,{4,'make'}
      ,{5,'model'}
      ,{6,'year'}
      ,{7,'class_code'}
      ,{8,'fuel_type_code'}
      ,{9,'mfg_code'}
      ,{10,'style_code'}
      ,{11,'mileagecd'}
      ,{12,'nbr_vehicles'}
      ,{13,'idate'}
      ,{14,'odate'}
      ,{15,'fname'}
      ,{16,'mi'}
      ,{17,'lname'}
      ,{18,'suffix'}
      ,{19,'gender'}
      ,{20,'house'}
      ,{21,'predir'}
      ,{22,'street'}
      ,{23,'strtype'}
      ,{24,'postdir'}
      ,{25,'apttype'}
      ,{26,'aptnbr'}
      ,{27,'city'}
      ,{28,'state'}
      ,{29,'zip'}
      ,{30,'z4'}
      ,{31,'dpc'}
      ,{32,'crte'}
      ,{33,'cnty'}
      ,{34,'z4type'}
      ,{35,'dpv'}
      ,{36,'vacant'}
      ,{37,'phone'}
      ,{38,'dnc'}
      ,{39,'internal1'}
      ,{40,'internal2'}
      ,{41,'internal3'}
      ,{42,'county'}
      ,{43,'msa'}
      ,{44,'cbsa'}
      ,{45,'ehi'}
      ,{46,'child'}
      ,{47,'homeowner'}
      ,{48,'pctw'}
      ,{49,'pctb'}
      ,{50,'pcta'}
      ,{51,'pcth'}
      ,{52,'pctspe'}
      ,{53,'pctsps'}
      ,{54,'pctspa'}
      ,{55,'mhv'}
      ,{56,'mor'}
      ,{57,'pctoccw'}
      ,{58,'pctoccb'}
      ,{59,'pctocco'}
      ,{60,'lor'}
      ,{61,'sfdu'}
      ,{62,'mfdu'}
      ,{63,'processdate'}
      ,{64,'source_code'}
      ,{65,'state_origin'}
      ,{66,'append_ownernametypeind'}
      ,{67,'fullname'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);

EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);

EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);


ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.state_origin) state_origin; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Infutor_Motorcycle_Fields.InValid_iid((SALT311.StrType)le.iid),
    Infutor_Motorcycle_Fields.InValid_pid((SALT311.StrType)le.pid),
    Infutor_Motorcycle_Fields.InValid_vin((SALT311.StrType)le.vin),
    Infutor_Motorcycle_Fields.InValid_make((SALT311.StrType)le.make),
    Infutor_Motorcycle_Fields.InValid_model((SALT311.StrType)le.model),
    Infutor_Motorcycle_Fields.InValid_year((SALT311.StrType)le.year),
    Infutor_Motorcycle_Fields.InValid_class_code((SALT311.StrType)le.class_code),
    Infutor_Motorcycle_Fields.InValid_fuel_type_code((SALT311.StrType)le.fuel_type_code),
    Infutor_Motorcycle_Fields.InValid_mfg_code((SALT311.StrType)le.mfg_code),
    Infutor_Motorcycle_Fields.InValid_style_code((SALT311.StrType)le.style_code),
    Infutor_Motorcycle_Fields.InValid_mileagecd((SALT311.StrType)le.mileagecd),
    Infutor_Motorcycle_Fields.InValid_nbr_vehicles((SALT311.StrType)le.nbr_vehicles),
    Infutor_Motorcycle_Fields.InValid_idate((SALT311.StrType)le.idate),
    Infutor_Motorcycle_Fields.InValid_odate((SALT311.StrType)le.odate),
    Infutor_Motorcycle_Fields.InValid_fname((SALT311.StrType)le.fname),
    Infutor_Motorcycle_Fields.InValid_mi((SALT311.StrType)le.mi),
    Infutor_Motorcycle_Fields.InValid_lname((SALT311.StrType)le.lname),
    Infutor_Motorcycle_Fields.InValid_suffix((SALT311.StrType)le.suffix),
    Infutor_Motorcycle_Fields.InValid_gender((SALT311.StrType)le.gender),
    Infutor_Motorcycle_Fields.InValid_house((SALT311.StrType)le.house),
    Infutor_Motorcycle_Fields.InValid_predir((SALT311.StrType)le.predir),
    Infutor_Motorcycle_Fields.InValid_street((SALT311.StrType)le.street),
    Infutor_Motorcycle_Fields.InValid_strtype((SALT311.StrType)le.strtype),
    Infutor_Motorcycle_Fields.InValid_postdir((SALT311.StrType)le.postdir),
    Infutor_Motorcycle_Fields.InValid_apttype((SALT311.StrType)le.apttype),
    Infutor_Motorcycle_Fields.InValid_aptnbr((SALT311.StrType)le.aptnbr),
    Infutor_Motorcycle_Fields.InValid_city((SALT311.StrType)le.city),
    Infutor_Motorcycle_Fields.InValid_state((SALT311.StrType)le.state),
    Infutor_Motorcycle_Fields.InValid_zip((SALT311.StrType)le.zip),
    Infutor_Motorcycle_Fields.InValid_z4((SALT311.StrType)le.z4),
    Infutor_Motorcycle_Fields.InValid_dpc((SALT311.StrType)le.dpc),
    Infutor_Motorcycle_Fields.InValid_crte((SALT311.StrType)le.crte),
    Infutor_Motorcycle_Fields.InValid_cnty((SALT311.StrType)le.cnty),
    Infutor_Motorcycle_Fields.InValid_z4type((SALT311.StrType)le.z4type),
    Infutor_Motorcycle_Fields.InValid_dpv((SALT311.StrType)le.dpv),
    Infutor_Motorcycle_Fields.InValid_vacant((SALT311.StrType)le.vacant),
    Infutor_Motorcycle_Fields.InValid_phone((SALT311.StrType)le.phone),
    Infutor_Motorcycle_Fields.InValid_dnc((SALT311.StrType)le.dnc),
    Infutor_Motorcycle_Fields.InValid_internal1((SALT311.StrType)le.internal1),
    Infutor_Motorcycle_Fields.InValid_internal2((SALT311.StrType)le.internal2),
    Infutor_Motorcycle_Fields.InValid_internal3((SALT311.StrType)le.internal3),
    Infutor_Motorcycle_Fields.InValid_county((SALT311.StrType)le.county),
    Infutor_Motorcycle_Fields.InValid_msa((SALT311.StrType)le.msa),
    Infutor_Motorcycle_Fields.InValid_cbsa((SALT311.StrType)le.cbsa),
    Infutor_Motorcycle_Fields.InValid_ehi((SALT311.StrType)le.ehi),
    Infutor_Motorcycle_Fields.InValid_child((SALT311.StrType)le.child),
    Infutor_Motorcycle_Fields.InValid_homeowner((SALT311.StrType)le.homeowner),
    Infutor_Motorcycle_Fields.InValid_pctw((SALT311.StrType)le.pctw),
    Infutor_Motorcycle_Fields.InValid_pctb((SALT311.StrType)le.pctb),
    Infutor_Motorcycle_Fields.InValid_pcta((SALT311.StrType)le.pcta),
    Infutor_Motorcycle_Fields.InValid_pcth((SALT311.StrType)le.pcth),
    Infutor_Motorcycle_Fields.InValid_pctspe((SALT311.StrType)le.pctspe),
    Infutor_Motorcycle_Fields.InValid_pctsps((SALT311.StrType)le.pctsps),
    Infutor_Motorcycle_Fields.InValid_pctspa((SALT311.StrType)le.pctspa),
    Infutor_Motorcycle_Fields.InValid_mhv((SALT311.StrType)le.mhv),
    Infutor_Motorcycle_Fields.InValid_mor((SALT311.StrType)le.mor),
    Infutor_Motorcycle_Fields.InValid_pctoccw((SALT311.StrType)le.pctoccw),
    Infutor_Motorcycle_Fields.InValid_pctoccb((SALT311.StrType)le.pctoccb),
    Infutor_Motorcycle_Fields.InValid_pctocco((SALT311.StrType)le.pctocco),
    Infutor_Motorcycle_Fields.InValid_lor((SALT311.StrType)le.lor),
    Infutor_Motorcycle_Fields.InValid_sfdu((SALT311.StrType)le.sfdu),
    Infutor_Motorcycle_Fields.InValid_mfdu((SALT311.StrType)le.mfdu),
    Infutor_Motorcycle_Fields.InValid_processdate((SALT311.StrType)le.processdate),
    Infutor_Motorcycle_Fields.InValid_source_code((SALT311.StrType)le.source_code),
    Infutor_Motorcycle_Fields.InValid_state_origin((SALT311.StrType)le.state_origin),
    Infutor_Motorcycle_Fields.InValid_append_ownernametypeind((SALT311.StrType)le.append_ownernametypeind),
    Infutor_Motorcycle_Fields.InValid_fullname((SALT311.StrType)le.fullname),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.state_origin := le.state_origin;
END;
Errors := NORMALIZE(h,67,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.state_origin;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,state_origin,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.state_origin;
  FieldNme := Infutor_Motorcycle_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','invalid_make','invalid_model','invalid_year','Unknown','invalid_fuel_type_code','Unknown','invalid_alphanumeric','invalid_alpha','invalid_number','invalid_date','invalid_date','invalid_name','invalid_name','invalid_name','invalid_name','invalid_gender','invalid_address','invalid_predir','invalid_address','invalid_address','invalid_predir','invalid_address','invalid_address','invalid_address','invalid_state','invalid_number','invalid_number','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_number','Unknown','invalid_vin','Unknown','Unknown','invalid_address','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Infutor_Motorcycle_Fields.InValidMessage_iid(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_pid(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_vin(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_make(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_model(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_year(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_class_code(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_fuel_type_code(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_mfg_code(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_style_code(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_mileagecd(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_nbr_vehicles(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_idate(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_odate(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_fname(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_mi(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_lname(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_gender(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_house(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_predir(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_street(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_strtype(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_apttype(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_aptnbr(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_city(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_state(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_zip(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_z4(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_dpc(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_crte(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_cnty(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_z4type(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_dpv(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_vacant(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_phone(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_dnc(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_internal1(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_internal2(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_internal3(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_county(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_msa(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_cbsa(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_ehi(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_child(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_homeowner(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_pctw(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_pctb(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_pcta(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_pcth(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_pctspe(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_pctsps(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_pctspa(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_mhv(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_mor(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_pctoccw(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_pctoccb(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_pctocco(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_lor(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_sfdu(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_mfdu(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_processdate(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_source_code(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_state_origin(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_append_ownernametypeind(TotalErrors.ErrorNum),Infutor_Motorcycle_Fields.InValidMessage_fullname(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.state_origin=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doSummaryPerSrc = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
  fieldPopulationPerSource := Summary('', FALSE);

  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_VehicleV2, Infutor_Motorcycle_Fields, 'RECORDOF(fieldPopulationOverall)', TRUE);

  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationPerSource_Standard := IF(doSummaryPerSrc, NORMALIZE(fieldPopulationPerSource, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'src', 'src')));

  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', TRUE, 'all'));
  fieldPopulationPerSource_TotalRecs_Standard := IF(doSummaryPerSrc, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationPerSource, myTimeStamp, 'src', TRUE, 'src'));

  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));

  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & fieldPopulationPerSource_Standard & fieldPopulationPerSource_TotalRecs_Standard & allProfiles_Standard;
END;
END;
