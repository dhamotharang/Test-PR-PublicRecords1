IMPORT ut,SALT35;
EXPORT hygiene(dataset(layout_In_OH) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT35.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_dbkoln_pcnt := AVE(GROUP,IF(h.dbkoln = (TYPEOF(h.dbkoln))'',0,100));
    maxlength_dbkoln := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dbkoln)));
    avelength_dbkoln := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dbkoln)),h.dbkoln<>(typeof(h.dbkoln))'');
    populated_pinss4_pcnt := AVE(GROUP,IF(h.pinss4 = (TYPEOF(h.pinss4))'',0,100));
    maxlength_pinss4 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.pinss4)));
    avelength_pinss4 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.pinss4)),h.pinss4<>(typeof(h.pinss4))'');
    populated_dvnlic_pcnt := AVE(GROUP,IF(h.dvnlic = (TYPEOF(h.dvnlic))'',0,100));
    maxlength_dvnlic := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvnlic)));
    avelength_dvnlic := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvnlic)),h.dvnlic<>(typeof(h.dvnlic))'');
    populated_dvccls_pcnt := AVE(GROUP,IF(h.dvccls = (TYPEOF(h.dvccls))'',0,100));
    maxlength_dvccls := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvccls)));
    avelength_dvccls := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvccls)),h.dvccls<>(typeof(h.dvccls))'');
    populated_dvctyp_pcnt := AVE(GROUP,IF(h.dvctyp = (TYPEOF(h.dvctyp))'',0,100));
    maxlength_dvctyp := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvctyp)));
    avelength_dvctyp := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvctyp)),h.dvctyp<>(typeof(h.dvctyp))'');
    populated_pifdon_pcnt := AVE(GROUP,IF(h.pifdon = (TYPEOF(h.pifdon))'',0,100));
    maxlength_pifdon := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.pifdon)));
    avelength_pifdon := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.pifdon)),h.pifdon<>(typeof(h.pifdon))'');
    populated_pichcl_pcnt := AVE(GROUP,IF(h.pichcl = (TYPEOF(h.pichcl))'',0,100));
    maxlength_pichcl := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.pichcl)));
    avelength_pichcl := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.pichcl)),h.pichcl<>(typeof(h.pichcl))'');
    populated_picecl_pcnt := AVE(GROUP,IF(h.picecl = (TYPEOF(h.picecl))'',0,100));
    maxlength_picecl := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.picecl)));
    avelength_picecl := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.picecl)),h.picecl<>(typeof(h.picecl))'');
    populated_piqwgt_pcnt := AVE(GROUP,IF(h.piqwgt = (TYPEOF(h.piqwgt))'',0,100));
    maxlength_piqwgt := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.piqwgt)));
    avelength_piqwgt := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.piqwgt)),h.piqwgt<>(typeof(h.piqwgt))'');
    populated_pinhft_pcnt := AVE(GROUP,IF(h.pinhft = (TYPEOF(h.pinhft))'',0,100));
    maxlength_pinhft := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.pinhft)));
    avelength_pinhft := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.pinhft)),h.pinhft<>(typeof(h.pinhft))'');
    populated_pinhin_pcnt := AVE(GROUP,IF(h.pinhin = (TYPEOF(h.pinhin))'',0,100));
    maxlength_pinhin := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.pinhin)));
    avelength_pinhin := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.pinhin)),h.pinhin<>(typeof(h.pinhin))'');
    populated_picsex_pcnt := AVE(GROUP,IF(h.picsex = (TYPEOF(h.picsex))'',0,100));
    maxlength_picsex := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.picsex)));
    avelength_picsex := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.picsex)),h.picsex<>(typeof(h.picsex))'');
    populated_dvddoi_pcnt := AVE(GROUP,IF(h.dvddoi = (TYPEOF(h.dvddoi))'',0,100));
    maxlength_dvddoi := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvddoi)));
    avelength_dvddoi := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvddoi)),h.dvddoi<>(typeof(h.dvddoi))'');
    populated_dvc2pl_pcnt := AVE(GROUP,IF(h.dvc2pl = (TYPEOF(h.dvc2pl))'',0,100));
    maxlength_dvc2pl := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvc2pl)));
    avelength_dvc2pl := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvc2pl)),h.dvc2pl<>(typeof(h.dvc2pl))'');
    populated_dvdexp_pcnt := AVE(GROUP,IF(h.dvdexp = (TYPEOF(h.dvdexp))'',0,100));
    maxlength_dvdexp := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvdexp)));
    avelength_dvdexp := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvdexp)),h.dvdexp<>(typeof(h.dvdexp))'');
    populated_drnagy_pcnt := AVE(GROUP,IF(h.drnagy = (TYPEOF(h.drnagy))'',0,100));
    maxlength_drnagy := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.drnagy)));
    avelength_drnagy := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.drnagy)),h.drnagy<>(typeof(h.drnagy))'');
    populated_dvfocd_pcnt := AVE(GROUP,IF(h.dvfocd = (TYPEOF(h.dvfocd))'',0,100));
    maxlength_dvfocd := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvfocd)));
    avelength_dvfocd := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvfocd)),h.dvfocd<>(typeof(h.dvfocd))'');
    populated_dvfopd_pcnt := AVE(GROUP,IF(h.dvfopd = (TYPEOF(h.dvfopd))'',0,100));
    maxlength_dvfopd := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvfopd)));
    avelength_dvfopd := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvfopd)),h.dvfopd<>(typeof(h.dvfopd))'');
    populated_dvnapp_pcnt := AVE(GROUP,IF(h.dvnapp = (TYPEOF(h.dvnapp))'',0,100));
    maxlength_dvnapp := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvnapp)));
    avelength_dvnapp := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvnapp)),h.dvnapp<>(typeof(h.dvnapp))'');
    populated_dvcatt_pcnt := AVE(GROUP,IF(h.dvcatt = (TYPEOF(h.dvcatt))'',0,100));
    maxlength_dvcatt := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvcatt)));
    avelength_dvcatt := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvcatt)),h.dvcatt<>(typeof(h.dvcatt))'');
    populated_dvdnov_pcnt := AVE(GROUP,IF(h.dvdnov = (TYPEOF(h.dvdnov))'',0,100));
    maxlength_dvdnov := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvdnov)));
    avelength_dvdnov := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvdnov)),h.dvdnov<>(typeof(h.dvdnov))'');
    populated_dvcded_pcnt := AVE(GROUP,IF(h.dvcded = (TYPEOF(h.dvcded))'',0,100));
    maxlength_dvcded := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvcded)));
    avelength_dvcded := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvcded)),h.dvcded<>(typeof(h.dvcded))'');
    populated_dvcgrs_pcnt := AVE(GROUP,IF(h.dvcgrs = (TYPEOF(h.dvcgrs))'',0,100));
    maxlength_dvcgrs := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvcgrs)));
    avelength_dvcgrs := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvcgrs)),h.dvcgrs<>(typeof(h.dvcgrs))'');
    populated_dvfdup_pcnt := AVE(GROUP,IF(h.dvfdup = (TYPEOF(h.dvfdup))'',0,100));
    maxlength_dvfdup := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvfdup)));
    avelength_dvfdup := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvfdup)),h.dvfdup<>(typeof(h.dvfdup))'');
    populated_dvcgen_pcnt := AVE(GROUP,IF(h.dvcgen = (TYPEOF(h.dvcgen))'',0,100));
    maxlength_dvcgen := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvcgen)));
    avelength_dvcgen := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvcgen)),h.dvcgen<>(typeof(h.dvcgen))'');
    populated_dvflsd_pcnt := AVE(GROUP,IF(h.dvflsd = (TYPEOF(h.dvflsd))'',0,100));
    maxlength_dvflsd := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvflsd)));
    avelength_dvflsd := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvflsd)),h.dvflsd<>(typeof(h.dvflsd))'');
    populated_dvqdup_pcnt := AVE(GROUP,IF(h.dvqdup = (TYPEOF(h.dvqdup))'',0,100));
    maxlength_dvqdup := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvqdup)));
    avelength_dvqdup := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvqdup)),h.dvqdup<>(typeof(h.dvqdup))'');
    populated_dvfohr_pcnt := AVE(GROUP,IF(h.dvfohr = (TYPEOF(h.dvfohr))'',0,100));
    maxlength_dvfohr := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvfohr)));
    avelength_dvfohr := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvfohr)),h.dvfohr<>(typeof(h.dvfohr))'');
    populated_dbkmtk_pcnt := AVE(GROUP,IF(h.dbkmtk = (TYPEOF(h.dbkmtk))'',0,100));
    maxlength_dbkmtk := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dbkmtk)));
    avelength_dbkmtk := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dbkmtk)),h.dbkmtk<>(typeof(h.dbkmtk))'');
    populated_dvfrcs_pcnt := AVE(GROUP,IF(h.dvfrcs = (TYPEOF(h.dvfrcs))'',0,100));
    maxlength_dvfrcs := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvfrcs)));
    avelength_dvfrcs := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvfrcs)),h.dvfrcs<>(typeof(h.dvfrcs))'');
    populated_dvnwbi_pcnt := AVE(GROUP,IF(h.dvnwbi = (TYPEOF(h.dvnwbi))'',0,100));
    maxlength_dvnwbi := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvnwbi)));
    avelength_dvnwbi := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvnwbi)),h.dvnwbi<>(typeof(h.dvnwbi))'');
    populated_sycpgm_pcnt := AVE(GROUP,IF(h.sycpgm = (TYPEOF(h.sycpgm))'',0,100));
    maxlength_sycpgm := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.sycpgm)));
    avelength_sycpgm := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.sycpgm)),h.sycpgm<>(typeof(h.sycpgm))'');
    populated_sytda1_pcnt := AVE(GROUP,IF(h.sytda1 = (TYPEOF(h.sytda1))'',0,100));
    maxlength_sytda1 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.sytda1)));
    avelength_sytda1 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.sytda1)),h.sytda1<>(typeof(h.sytda1))'');
    populated_sycuid_pcnt := AVE(GROUP,IF(h.sycuid = (TYPEOF(h.sycuid))'',0,100));
    maxlength_sycuid := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.sycuid)));
    avelength_sycuid := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.sycuid)),h.sycuid<>(typeof(h.sycuid))'');
    populated_dvffrd_pcnt := AVE(GROUP,IF(h.dvffrd = (TYPEOF(h.dvffrd))'',0,100));
    maxlength_dvffrd := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvffrd)));
    avelength_dvffrd := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvffrd)),h.dvffrd<>(typeof(h.dvffrd))'');
    populated_dvctsa_pcnt := AVE(GROUP,IF(h.dvctsa = (TYPEOF(h.dvctsa))'',0,100));
    maxlength_dvctsa := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvctsa)));
    avelength_dvctsa := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvctsa)),h.dvctsa<>(typeof(h.dvctsa))'');
    populated_dvdtsa_pcnt := AVE(GROUP,IF(h.dvdtsa = (TYPEOF(h.dvdtsa))'',0,100));
    maxlength_dvdtsa := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvdtsa)));
    avelength_dvdtsa := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvdtsa)),h.dvdtsa<>(typeof(h.dvdtsa))'');
    populated_dvdtex_pcnt := AVE(GROUP,IF(h.dvdtex = (TYPEOF(h.dvdtex))'',0,100));
    maxlength_dvdtex := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvdtex)));
    avelength_dvdtex := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvdtex)),h.dvdtex<>(typeof(h.dvdtex))'');
    populated_dvcsce_pcnt := AVE(GROUP,IF(h.dvcsce = (TYPEOF(h.dvcsce))'',0,100));
    maxlength_dvcsce := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvcsce)));
    avelength_dvcsce := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvcsce)),h.dvcsce<>(typeof(h.dvcsce))'');
    populated_dvdmce_pcnt := AVE(GROUP,IF(h.dvdmce = (TYPEOF(h.dvdmce))'',0,100));
    maxlength_dvdmce := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvdmce)));
    avelength_dvdmce := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dvdmce)),h.dvdmce<>(typeof(h.dvdmce))'');
    populated_filler_pcnt := AVE(GROUP,IF(h.filler = (TYPEOF(h.filler))'',0,100));
    maxlength_filler := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.filler)));
    avelength_filler := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.filler)),h.filler<>(typeof(h.filler))'');
    populated_pimnam_pcnt := AVE(GROUP,IF(h.pimnam = (TYPEOF(h.pimnam))'',0,100));
    maxlength_pimnam := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.pimnam)));
    avelength_pimnam := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.pimnam)),h.pimnam<>(typeof(h.pimnam))'');
    populated_pigstr_pcnt := AVE(GROUP,IF(h.pigstr = (TYPEOF(h.pigstr))'',0,100));
    maxlength_pigstr := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.pigstr)));
    avelength_pigstr := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.pigstr)),h.pigstr<>(typeof(h.pigstr))'');
    populated_pigcty_pcnt := AVE(GROUP,IF(h.pigcty = (TYPEOF(h.pigcty))'',0,100));
    maxlength_pigcty := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.pigcty)));
    avelength_pigcty := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.pigcty)),h.pigcty<>(typeof(h.pigcty))'');
    populated_pigsta_pcnt := AVE(GROUP,IF(h.pigsta = (TYPEOF(h.pigsta))'',0,100));
    maxlength_pigsta := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.pigsta)));
    avelength_pigsta := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.pigsta)),h.pigsta<>(typeof(h.pigsta))'');
    populated_pigzip_pcnt := AVE(GROUP,IF(h.pigzip = (TYPEOF(h.pigzip))'',0,100));
    maxlength_pigzip := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.pigzip)));
    avelength_pigzip := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.pigzip)),h.pigzip<>(typeof(h.pigzip))'');
    populated_pincnt_pcnt := AVE(GROUP,IF(h.pincnt = (TYPEOF(h.pincnt))'',0,100));
    maxlength_pincnt := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.pincnt)));
    avelength_pincnt := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.pincnt)),h.pincnt<>(typeof(h.pincnt))'');
    populated_pidd01_pcnt := AVE(GROUP,IF(h.pidd01 = (TYPEOF(h.pidd01))'',0,100));
    maxlength_pidd01 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.pidd01)));
    avelength_pidd01 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.pidd01)),h.pidd01<>(typeof(h.pidd01))'');
    populated_piddod_pcnt := AVE(GROUP,IF(h.piddod = (TYPEOF(h.piddod))'',0,100));
    maxlength_piddod := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.piddod)));
    avelength_piddod := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.piddod)),h.piddod<>(typeof(h.piddod))'');
    populated_pidaup_pcnt := AVE(GROUP,IF(h.pidaup = (TYPEOF(h.pidaup))'',0,100));
    maxlength_pidaup := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.pidaup)));
    avelength_pidaup := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.pidaup)),h.pidaup<>(typeof(h.pidaup))'');
    populated_crlf_pcnt := AVE(GROUP,IF(h.crlf = (TYPEOF(h.crlf))'',0,100));
    maxlength_crlf := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.crlf)));
    avelength_crlf := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.crlf)),h.crlf<>(typeof(h.crlf))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_cleaning_score_pcnt := AVE(GROUP,IF(h.cleaning_score = (TYPEOF(h.cleaning_score))'',0,100));
    maxlength_cleaning_score := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.cleaning_score)));
    avelength_cleaning_score := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.cleaning_score)),h.cleaning_score<>(typeof(h.cleaning_score))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dbpc_pcnt := AVE(GROUP,IF(h.dbpc = (TYPEOF(h.dbpc))'',0,100));
    maxlength_dbpc := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dbpc)));
    avelength_dbpc := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dbpc)),h.dbpc<>(typeof(h.dbpc))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_ace_fips_st_pcnt := AVE(GROUP,IF(h.ace_fips_st = (TYPEOF(h.ace_fips_st))'',0,100));
    maxlength_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.ace_fips_st)));
    avelength_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.ace_fips_st)),h.ace_fips_st<>(typeof(h.ace_fips_st))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_dbkoln_pcnt *   0.00 / 100 + T.Populated_pinss4_pcnt *   0.00 / 100 + T.Populated_dvnlic_pcnt *   0.00 / 100 + T.Populated_dvccls_pcnt *   0.00 / 100 + T.Populated_dvctyp_pcnt *   0.00 / 100 + T.Populated_pifdon_pcnt *   0.00 / 100 + T.Populated_pichcl_pcnt *   0.00 / 100 + T.Populated_picecl_pcnt *   0.00 / 100 + T.Populated_piqwgt_pcnt *   0.00 / 100 + T.Populated_pinhft_pcnt *   0.00 / 100 + T.Populated_pinhin_pcnt *   0.00 / 100 + T.Populated_picsex_pcnt *   0.00 / 100 + T.Populated_dvddoi_pcnt *   0.00 / 100 + T.Populated_dvc2pl_pcnt *   0.00 / 100 + T.Populated_dvdexp_pcnt *   0.00 / 100 + T.Populated_drnagy_pcnt *   0.00 / 100 + T.Populated_dvfocd_pcnt *   0.00 / 100 + T.Populated_dvfopd_pcnt *   0.00 / 100 + T.Populated_dvnapp_pcnt *   0.00 / 100 + T.Populated_dvcatt_pcnt *   0.00 / 100 + T.Populated_dvdnov_pcnt *   0.00 / 100 + T.Populated_dvcded_pcnt *   0.00 / 100 + T.Populated_dvcgrs_pcnt *   0.00 / 100 + T.Populated_dvfdup_pcnt *   0.00 / 100 + T.Populated_dvcgen_pcnt *   0.00 / 100 + T.Populated_dvflsd_pcnt *   0.00 / 100 + T.Populated_dvqdup_pcnt *   0.00 / 100 + T.Populated_dvfohr_pcnt *   0.00 / 100 + T.Populated_dbkmtk_pcnt *   0.00 / 100 + T.Populated_dvfrcs_pcnt *   0.00 / 100 + T.Populated_dvnwbi_pcnt *   0.00 / 100 + T.Populated_sycpgm_pcnt *   0.00 / 100 + T.Populated_sytda1_pcnt *   0.00 / 100 + T.Populated_sycuid_pcnt *   0.00 / 100 + T.Populated_dvffrd_pcnt *   0.00 / 100 + T.Populated_dvctsa_pcnt *   0.00 / 100 + T.Populated_dvdtsa_pcnt *   0.00 / 100 + T.Populated_dvdtex_pcnt *   0.00 / 100 + T.Populated_dvcsce_pcnt *   0.00 / 100 + T.Populated_dvdmce_pcnt *   0.00 / 100 + T.Populated_filler_pcnt *   0.00 / 100 + T.Populated_pimnam_pcnt *   0.00 / 100 + T.Populated_pigstr_pcnt *   0.00 / 100 + T.Populated_pigcty_pcnt *   0.00 / 100 + T.Populated_pigsta_pcnt *   0.00 / 100 + T.Populated_pigzip_pcnt *   0.00 / 100 + T.Populated_pincnt_pcnt *   0.00 / 100 + T.Populated_pidd01_pcnt *   0.00 / 100 + T.Populated_piddod_pcnt *   0.00 / 100 + T.Populated_pidaup_pcnt *   0.00 / 100 + T.Populated_crlf_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_cleaning_score_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT35.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'process_date','dbkoln','pinss4','dvnlic','dvccls','dvctyp','pifdon','pichcl','picecl','piqwgt','pinhft','pinhin','picsex','dvddoi','dvc2pl','dvdexp','drnagy','dvfocd','dvfopd','dvnapp','dvcatt','dvdnov','dvcded','dvcgrs','dvfdup','dvcgen','dvflsd','dvqdup','dvfohr','dbkmtk','dvfrcs','dvnwbi','sycpgm','sytda1','sycuid','dvffrd','dvctsa','dvdtsa','dvdtex','dvcsce','dvdmce','filler','pimnam','pigstr','pigcty','pigsta','pigzip','pincnt','pidd01','piddod','pidaup','crlf','title','fname','mname','lname','name_suffix','cleaning_score','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','state','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat');
  SELF.populated_pcnt := CHOOSE(C,le.populated_process_date_pcnt,le.populated_dbkoln_pcnt,le.populated_pinss4_pcnt,le.populated_dvnlic_pcnt,le.populated_dvccls_pcnt,le.populated_dvctyp_pcnt,le.populated_pifdon_pcnt,le.populated_pichcl_pcnt,le.populated_picecl_pcnt,le.populated_piqwgt_pcnt,le.populated_pinhft_pcnt,le.populated_pinhin_pcnt,le.populated_picsex_pcnt,le.populated_dvddoi_pcnt,le.populated_dvc2pl_pcnt,le.populated_dvdexp_pcnt,le.populated_drnagy_pcnt,le.populated_dvfocd_pcnt,le.populated_dvfopd_pcnt,le.populated_dvnapp_pcnt,le.populated_dvcatt_pcnt,le.populated_dvdnov_pcnt,le.populated_dvcded_pcnt,le.populated_dvcgrs_pcnt,le.populated_dvfdup_pcnt,le.populated_dvcgen_pcnt,le.populated_dvflsd_pcnt,le.populated_dvqdup_pcnt,le.populated_dvfohr_pcnt,le.populated_dbkmtk_pcnt,le.populated_dvfrcs_pcnt,le.populated_dvnwbi_pcnt,le.populated_sycpgm_pcnt,le.populated_sytda1_pcnt,le.populated_sycuid_pcnt,le.populated_dvffrd_pcnt,le.populated_dvctsa_pcnt,le.populated_dvdtsa_pcnt,le.populated_dvdtex_pcnt,le.populated_dvcsce_pcnt,le.populated_dvdmce_pcnt,le.populated_filler_pcnt,le.populated_pimnam_pcnt,le.populated_pigstr_pcnt,le.populated_pigcty_pcnt,le.populated_pigsta_pcnt,le.populated_pigzip_pcnt,le.populated_pincnt_pcnt,le.populated_pidd01_pcnt,le.populated_piddod_pcnt,le.populated_pidaup_pcnt,le.populated_crlf_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_cleaning_score_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_state_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_ace_fips_st_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_process_date,le.maxlength_dbkoln,le.maxlength_pinss4,le.maxlength_dvnlic,le.maxlength_dvccls,le.maxlength_dvctyp,le.maxlength_pifdon,le.maxlength_pichcl,le.maxlength_picecl,le.maxlength_piqwgt,le.maxlength_pinhft,le.maxlength_pinhin,le.maxlength_picsex,le.maxlength_dvddoi,le.maxlength_dvc2pl,le.maxlength_dvdexp,le.maxlength_drnagy,le.maxlength_dvfocd,le.maxlength_dvfopd,le.maxlength_dvnapp,le.maxlength_dvcatt,le.maxlength_dvdnov,le.maxlength_dvcded,le.maxlength_dvcgrs,le.maxlength_dvfdup,le.maxlength_dvcgen,le.maxlength_dvflsd,le.maxlength_dvqdup,le.maxlength_dvfohr,le.maxlength_dbkmtk,le.maxlength_dvfrcs,le.maxlength_dvnwbi,le.maxlength_sycpgm,le.maxlength_sytda1,le.maxlength_sycuid,le.maxlength_dvffrd,le.maxlength_dvctsa,le.maxlength_dvdtsa,le.maxlength_dvdtex,le.maxlength_dvcsce,le.maxlength_dvdmce,le.maxlength_filler,le.maxlength_pimnam,le.maxlength_pigstr,le.maxlength_pigcty,le.maxlength_pigsta,le.maxlength_pigzip,le.maxlength_pincnt,le.maxlength_pidd01,le.maxlength_piddod,le.maxlength_pidaup,le.maxlength_crlf,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_cleaning_score,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_state,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_ace_fips_st,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat);
  SELF.avelength := CHOOSE(C,le.avelength_process_date,le.avelength_dbkoln,le.avelength_pinss4,le.avelength_dvnlic,le.avelength_dvccls,le.avelength_dvctyp,le.avelength_pifdon,le.avelength_pichcl,le.avelength_picecl,le.avelength_piqwgt,le.avelength_pinhft,le.avelength_pinhin,le.avelength_picsex,le.avelength_dvddoi,le.avelength_dvc2pl,le.avelength_dvdexp,le.avelength_drnagy,le.avelength_dvfocd,le.avelength_dvfopd,le.avelength_dvnapp,le.avelength_dvcatt,le.avelength_dvdnov,le.avelength_dvcded,le.avelength_dvcgrs,le.avelength_dvfdup,le.avelength_dvcgen,le.avelength_dvflsd,le.avelength_dvqdup,le.avelength_dvfohr,le.avelength_dbkmtk,le.avelength_dvfrcs,le.avelength_dvnwbi,le.avelength_sycpgm,le.avelength_sytda1,le.avelength_sycuid,le.avelength_dvffrd,le.avelength_dvctsa,le.avelength_dvdtsa,le.avelength_dvdtex,le.avelength_dvcsce,le.avelength_dvdmce,le.avelength_filler,le.avelength_pimnam,le.avelength_pigstr,le.avelength_pigcty,le.avelength_pigsta,le.avelength_pigzip,le.avelength_pincnt,le.avelength_pidd01,le.avelength_piddod,le.avelength_pidaup,le.avelength_crlf,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_cleaning_score,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_state,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_ace_fips_st,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat);
END;
EXPORT invSummary := NORMALIZE(summary0, 85, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT35.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT35.StrType)le.process_date),TRIM((SALT35.StrType)le.dbkoln),TRIM((SALT35.StrType)le.pinss4),TRIM((SALT35.StrType)le.dvnlic),TRIM((SALT35.StrType)le.dvccls),TRIM((SALT35.StrType)le.dvctyp),TRIM((SALT35.StrType)le.pifdon),TRIM((SALT35.StrType)le.pichcl),TRIM((SALT35.StrType)le.picecl),TRIM((SALT35.StrType)le.piqwgt),TRIM((SALT35.StrType)le.pinhft),TRIM((SALT35.StrType)le.pinhin),TRIM((SALT35.StrType)le.picsex),TRIM((SALT35.StrType)le.dvddoi),TRIM((SALT35.StrType)le.dvc2pl),TRIM((SALT35.StrType)le.dvdexp),TRIM((SALT35.StrType)le.drnagy),TRIM((SALT35.StrType)le.dvfocd),TRIM((SALT35.StrType)le.dvfopd),TRIM((SALT35.StrType)le.dvnapp),TRIM((SALT35.StrType)le.dvcatt),TRIM((SALT35.StrType)le.dvdnov),TRIM((SALT35.StrType)le.dvcded),TRIM((SALT35.StrType)le.dvcgrs),TRIM((SALT35.StrType)le.dvfdup),TRIM((SALT35.StrType)le.dvcgen),TRIM((SALT35.StrType)le.dvflsd),TRIM((SALT35.StrType)le.dvqdup),TRIM((SALT35.StrType)le.dvfohr),TRIM((SALT35.StrType)le.dbkmtk),TRIM((SALT35.StrType)le.dvfrcs),TRIM((SALT35.StrType)le.dvnwbi),TRIM((SALT35.StrType)le.sycpgm),TRIM((SALT35.StrType)le.sytda1),TRIM((SALT35.StrType)le.sycuid),TRIM((SALT35.StrType)le.dvffrd),TRIM((SALT35.StrType)le.dvctsa),TRIM((SALT35.StrType)le.dvdtsa),TRIM((SALT35.StrType)le.dvdtex),TRIM((SALT35.StrType)le.dvcsce),TRIM((SALT35.StrType)le.dvdmce),TRIM((SALT35.StrType)le.filler),TRIM((SALT35.StrType)le.pimnam),TRIM((SALT35.StrType)le.pigstr),TRIM((SALT35.StrType)le.pigcty),TRIM((SALT35.StrType)le.pigsta),TRIM((SALT35.StrType)le.pigzip),TRIM((SALT35.StrType)le.pincnt),TRIM((SALT35.StrType)le.pidd01),TRIM((SALT35.StrType)le.piddod),TRIM((SALT35.StrType)le.pidaup),TRIM((SALT35.StrType)le.crlf),TRIM((SALT35.StrType)le.title),TRIM((SALT35.StrType)le.fname),TRIM((SALT35.StrType)le.mname),TRIM((SALT35.StrType)le.lname),TRIM((SALT35.StrType)le.name_suffix),TRIM((SALT35.StrType)le.cleaning_score),TRIM((SALT35.StrType)le.prim_range),TRIM((SALT35.StrType)le.predir),TRIM((SALT35.StrType)le.prim_name),TRIM((SALT35.StrType)le.suffix),TRIM((SALT35.StrType)le.postdir),TRIM((SALT35.StrType)le.unit_desig),TRIM((SALT35.StrType)le.sec_range),TRIM((SALT35.StrType)le.p_city_name),TRIM((SALT35.StrType)le.v_city_name),TRIM((SALT35.StrType)le.state),TRIM((SALT35.StrType)le.zip),TRIM((SALT35.StrType)le.zip4),TRIM((SALT35.StrType)le.cart),TRIM((SALT35.StrType)le.cr_sort_sz),TRIM((SALT35.StrType)le.lot),TRIM((SALT35.StrType)le.lot_order),TRIM((SALT35.StrType)le.dbpc),TRIM((SALT35.StrType)le.chk_digit),TRIM((SALT35.StrType)le.rec_type),TRIM((SALT35.StrType)le.ace_fips_st),TRIM((SALT35.StrType)le.county),TRIM((SALT35.StrType)le.geo_lat),TRIM((SALT35.StrType)le.geo_long),TRIM((SALT35.StrType)le.msa),TRIM((SALT35.StrType)le.geo_blk),TRIM((SALT35.StrType)le.geo_match),TRIM((SALT35.StrType)le.err_stat)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,85,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT35.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 85);
  SELF.FldNo2 := 1 + (C % 85);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT35.StrType)le.process_date),TRIM((SALT35.StrType)le.dbkoln),TRIM((SALT35.StrType)le.pinss4),TRIM((SALT35.StrType)le.dvnlic),TRIM((SALT35.StrType)le.dvccls),TRIM((SALT35.StrType)le.dvctyp),TRIM((SALT35.StrType)le.pifdon),TRIM((SALT35.StrType)le.pichcl),TRIM((SALT35.StrType)le.picecl),TRIM((SALT35.StrType)le.piqwgt),TRIM((SALT35.StrType)le.pinhft),TRIM((SALT35.StrType)le.pinhin),TRIM((SALT35.StrType)le.picsex),TRIM((SALT35.StrType)le.dvddoi),TRIM((SALT35.StrType)le.dvc2pl),TRIM((SALT35.StrType)le.dvdexp),TRIM((SALT35.StrType)le.drnagy),TRIM((SALT35.StrType)le.dvfocd),TRIM((SALT35.StrType)le.dvfopd),TRIM((SALT35.StrType)le.dvnapp),TRIM((SALT35.StrType)le.dvcatt),TRIM((SALT35.StrType)le.dvdnov),TRIM((SALT35.StrType)le.dvcded),TRIM((SALT35.StrType)le.dvcgrs),TRIM((SALT35.StrType)le.dvfdup),TRIM((SALT35.StrType)le.dvcgen),TRIM((SALT35.StrType)le.dvflsd),TRIM((SALT35.StrType)le.dvqdup),TRIM((SALT35.StrType)le.dvfohr),TRIM((SALT35.StrType)le.dbkmtk),TRIM((SALT35.StrType)le.dvfrcs),TRIM((SALT35.StrType)le.dvnwbi),TRIM((SALT35.StrType)le.sycpgm),TRIM((SALT35.StrType)le.sytda1),TRIM((SALT35.StrType)le.sycuid),TRIM((SALT35.StrType)le.dvffrd),TRIM((SALT35.StrType)le.dvctsa),TRIM((SALT35.StrType)le.dvdtsa),TRIM((SALT35.StrType)le.dvdtex),TRIM((SALT35.StrType)le.dvcsce),TRIM((SALT35.StrType)le.dvdmce),TRIM((SALT35.StrType)le.filler),TRIM((SALT35.StrType)le.pimnam),TRIM((SALT35.StrType)le.pigstr),TRIM((SALT35.StrType)le.pigcty),TRIM((SALT35.StrType)le.pigsta),TRIM((SALT35.StrType)le.pigzip),TRIM((SALT35.StrType)le.pincnt),TRIM((SALT35.StrType)le.pidd01),TRIM((SALT35.StrType)le.piddod),TRIM((SALT35.StrType)le.pidaup),TRIM((SALT35.StrType)le.crlf),TRIM((SALT35.StrType)le.title),TRIM((SALT35.StrType)le.fname),TRIM((SALT35.StrType)le.mname),TRIM((SALT35.StrType)le.lname),TRIM((SALT35.StrType)le.name_suffix),TRIM((SALT35.StrType)le.cleaning_score),TRIM((SALT35.StrType)le.prim_range),TRIM((SALT35.StrType)le.predir),TRIM((SALT35.StrType)le.prim_name),TRIM((SALT35.StrType)le.suffix),TRIM((SALT35.StrType)le.postdir),TRIM((SALT35.StrType)le.unit_desig),TRIM((SALT35.StrType)le.sec_range),TRIM((SALT35.StrType)le.p_city_name),TRIM((SALT35.StrType)le.v_city_name),TRIM((SALT35.StrType)le.state),TRIM((SALT35.StrType)le.zip),TRIM((SALT35.StrType)le.zip4),TRIM((SALT35.StrType)le.cart),TRIM((SALT35.StrType)le.cr_sort_sz),TRIM((SALT35.StrType)le.lot),TRIM((SALT35.StrType)le.lot_order),TRIM((SALT35.StrType)le.dbpc),TRIM((SALT35.StrType)le.chk_digit),TRIM((SALT35.StrType)le.rec_type),TRIM((SALT35.StrType)le.ace_fips_st),TRIM((SALT35.StrType)le.county),TRIM((SALT35.StrType)le.geo_lat),TRIM((SALT35.StrType)le.geo_long),TRIM((SALT35.StrType)le.msa),TRIM((SALT35.StrType)le.geo_blk),TRIM((SALT35.StrType)le.geo_match),TRIM((SALT35.StrType)le.err_stat)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT35.StrType)le.process_date),TRIM((SALT35.StrType)le.dbkoln),TRIM((SALT35.StrType)le.pinss4),TRIM((SALT35.StrType)le.dvnlic),TRIM((SALT35.StrType)le.dvccls),TRIM((SALT35.StrType)le.dvctyp),TRIM((SALT35.StrType)le.pifdon),TRIM((SALT35.StrType)le.pichcl),TRIM((SALT35.StrType)le.picecl),TRIM((SALT35.StrType)le.piqwgt),TRIM((SALT35.StrType)le.pinhft),TRIM((SALT35.StrType)le.pinhin),TRIM((SALT35.StrType)le.picsex),TRIM((SALT35.StrType)le.dvddoi),TRIM((SALT35.StrType)le.dvc2pl),TRIM((SALT35.StrType)le.dvdexp),TRIM((SALT35.StrType)le.drnagy),TRIM((SALT35.StrType)le.dvfocd),TRIM((SALT35.StrType)le.dvfopd),TRIM((SALT35.StrType)le.dvnapp),TRIM((SALT35.StrType)le.dvcatt),TRIM((SALT35.StrType)le.dvdnov),TRIM((SALT35.StrType)le.dvcded),TRIM((SALT35.StrType)le.dvcgrs),TRIM((SALT35.StrType)le.dvfdup),TRIM((SALT35.StrType)le.dvcgen),TRIM((SALT35.StrType)le.dvflsd),TRIM((SALT35.StrType)le.dvqdup),TRIM((SALT35.StrType)le.dvfohr),TRIM((SALT35.StrType)le.dbkmtk),TRIM((SALT35.StrType)le.dvfrcs),TRIM((SALT35.StrType)le.dvnwbi),TRIM((SALT35.StrType)le.sycpgm),TRIM((SALT35.StrType)le.sytda1),TRIM((SALT35.StrType)le.sycuid),TRIM((SALT35.StrType)le.dvffrd),TRIM((SALT35.StrType)le.dvctsa),TRIM((SALT35.StrType)le.dvdtsa),TRIM((SALT35.StrType)le.dvdtex),TRIM((SALT35.StrType)le.dvcsce),TRIM((SALT35.StrType)le.dvdmce),TRIM((SALT35.StrType)le.filler),TRIM((SALT35.StrType)le.pimnam),TRIM((SALT35.StrType)le.pigstr),TRIM((SALT35.StrType)le.pigcty),TRIM((SALT35.StrType)le.pigsta),TRIM((SALT35.StrType)le.pigzip),TRIM((SALT35.StrType)le.pincnt),TRIM((SALT35.StrType)le.pidd01),TRIM((SALT35.StrType)le.piddod),TRIM((SALT35.StrType)le.pidaup),TRIM((SALT35.StrType)le.crlf),TRIM((SALT35.StrType)le.title),TRIM((SALT35.StrType)le.fname),TRIM((SALT35.StrType)le.mname),TRIM((SALT35.StrType)le.lname),TRIM((SALT35.StrType)le.name_suffix),TRIM((SALT35.StrType)le.cleaning_score),TRIM((SALT35.StrType)le.prim_range),TRIM((SALT35.StrType)le.predir),TRIM((SALT35.StrType)le.prim_name),TRIM((SALT35.StrType)le.suffix),TRIM((SALT35.StrType)le.postdir),TRIM((SALT35.StrType)le.unit_desig),TRIM((SALT35.StrType)le.sec_range),TRIM((SALT35.StrType)le.p_city_name),TRIM((SALT35.StrType)le.v_city_name),TRIM((SALT35.StrType)le.state),TRIM((SALT35.StrType)le.zip),TRIM((SALT35.StrType)le.zip4),TRIM((SALT35.StrType)le.cart),TRIM((SALT35.StrType)le.cr_sort_sz),TRIM((SALT35.StrType)le.lot),TRIM((SALT35.StrType)le.lot_order),TRIM((SALT35.StrType)le.dbpc),TRIM((SALT35.StrType)le.chk_digit),TRIM((SALT35.StrType)le.rec_type),TRIM((SALT35.StrType)le.ace_fips_st),TRIM((SALT35.StrType)le.county),TRIM((SALT35.StrType)le.geo_lat),TRIM((SALT35.StrType)le.geo_long),TRIM((SALT35.StrType)le.msa),TRIM((SALT35.StrType)le.geo_blk),TRIM((SALT35.StrType)le.geo_match),TRIM((SALT35.StrType)le.err_stat)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),85*85,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'process_date'}
      ,{2,'dbkoln'}
      ,{3,'pinss4'}
      ,{4,'dvnlic'}
      ,{5,'dvccls'}
      ,{6,'dvctyp'}
      ,{7,'pifdon'}
      ,{8,'pichcl'}
      ,{9,'picecl'}
      ,{10,'piqwgt'}
      ,{11,'pinhft'}
      ,{12,'pinhin'}
      ,{13,'picsex'}
      ,{14,'dvddoi'}
      ,{15,'dvc2pl'}
      ,{16,'dvdexp'}
      ,{17,'drnagy'}
      ,{18,'dvfocd'}
      ,{19,'dvfopd'}
      ,{20,'dvnapp'}
      ,{21,'dvcatt'}
      ,{22,'dvdnov'}
      ,{23,'dvcded'}
      ,{24,'dvcgrs'}
      ,{25,'dvfdup'}
      ,{26,'dvcgen'}
      ,{27,'dvflsd'}
      ,{28,'dvqdup'}
      ,{29,'dvfohr'}
      ,{30,'dbkmtk'}
      ,{31,'dvfrcs'}
      ,{32,'dvnwbi'}
      ,{33,'sycpgm'}
      ,{34,'sytda1'}
      ,{35,'sycuid'}
      ,{36,'dvffrd'}
      ,{37,'dvctsa'}
      ,{38,'dvdtsa'}
      ,{39,'dvdtex'}
      ,{40,'dvcsce'}
      ,{41,'dvdmce'}
      ,{42,'filler'}
      ,{43,'pimnam'}
      ,{44,'pigstr'}
      ,{45,'pigcty'}
      ,{46,'pigsta'}
      ,{47,'pigzip'}
      ,{48,'pincnt'}
      ,{49,'pidd01'}
      ,{50,'piddod'}
      ,{51,'pidaup'}
      ,{52,'crlf'}
      ,{53,'title'}
      ,{54,'fname'}
      ,{55,'mname'}
      ,{56,'lname'}
      ,{57,'name_suffix'}
      ,{58,'cleaning_score'}
      ,{59,'prim_range'}
      ,{60,'predir'}
      ,{61,'prim_name'}
      ,{62,'suffix'}
      ,{63,'postdir'}
      ,{64,'unit_desig'}
      ,{65,'sec_range'}
      ,{66,'p_city_name'}
      ,{67,'v_city_name'}
      ,{68,'state'}
      ,{69,'zip'}
      ,{70,'zip4'}
      ,{71,'cart'}
      ,{72,'cr_sort_sz'}
      ,{73,'lot'}
      ,{74,'lot_order'}
      ,{75,'dbpc'}
      ,{76,'chk_digit'}
      ,{77,'rec_type'}
      ,{78,'ace_fips_st'}
      ,{79,'county'}
      ,{80,'geo_lat'}
      ,{81,'geo_long'}
      ,{82,'msa'}
      ,{83,'geo_blk'}
      ,{84,'geo_match'}
      ,{85,'err_stat'}],SALT35.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT35.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT35.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT35.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_process_date((SALT35.StrType)le.process_date),
    Fields.InValid_dbkoln((SALT35.StrType)le.dbkoln),
    Fields.InValid_pinss4((SALT35.StrType)le.pinss4),
    Fields.InValid_dvnlic((SALT35.StrType)le.dvnlic),
    Fields.InValid_dvccls((SALT35.StrType)le.dvccls),
    Fields.InValid_dvctyp((SALT35.StrType)le.dvctyp),
    Fields.InValid_pifdon((SALT35.StrType)le.pifdon),
    Fields.InValid_pichcl((SALT35.StrType)le.pichcl),
    Fields.InValid_picecl((SALT35.StrType)le.picecl),
    Fields.InValid_piqwgt((SALT35.StrType)le.piqwgt),
    Fields.InValid_pinhft((SALT35.StrType)le.pinhft,(SALT35.StrType)le.pinhin),
    Fields.InValid_pinhin((SALT35.StrType)le.pinhin),
    Fields.InValid_picsex((SALT35.StrType)le.picsex),
    Fields.InValid_dvddoi((SALT35.StrType)le.dvddoi),
    Fields.InValid_dvc2pl((SALT35.StrType)le.dvc2pl),
    Fields.InValid_dvdexp((SALT35.StrType)le.dvdexp),
    Fields.InValid_drnagy((SALT35.StrType)le.drnagy),
    Fields.InValid_dvfocd((SALT35.StrType)le.dvfocd),
    Fields.InValid_dvfopd((SALT35.StrType)le.dvfopd),
    Fields.InValid_dvnapp((SALT35.StrType)le.dvnapp),
    Fields.InValid_dvcatt((SALT35.StrType)le.dvcatt),
    Fields.InValid_dvdnov((SALT35.StrType)le.dvdnov),
    Fields.InValid_dvcded((SALT35.StrType)le.dvcded),
    Fields.InValid_dvcgrs((SALT35.StrType)le.dvcgrs),
    Fields.InValid_dvfdup((SALT35.StrType)le.dvfdup),
    Fields.InValid_dvcgen((SALT35.StrType)le.dvcgen),
    Fields.InValid_dvflsd((SALT35.StrType)le.dvflsd),
    Fields.InValid_dvqdup((SALT35.StrType)le.dvqdup),
    Fields.InValid_dvfohr((SALT35.StrType)le.dvfohr),
    Fields.InValid_dbkmtk((SALT35.StrType)le.dbkmtk),
    Fields.InValid_dvfrcs((SALT35.StrType)le.dvfrcs),
    Fields.InValid_dvnwbi((SALT35.StrType)le.dvnwbi),
    Fields.InValid_sycpgm((SALT35.StrType)le.sycpgm),
    Fields.InValid_sytda1((SALT35.StrType)le.sytda1),
    Fields.InValid_sycuid((SALT35.StrType)le.sycuid),
    Fields.InValid_dvffrd((SALT35.StrType)le.dvffrd),
    Fields.InValid_dvctsa((SALT35.StrType)le.dvctsa),
    Fields.InValid_dvdtsa((SALT35.StrType)le.dvdtsa),
    Fields.InValid_dvdtex((SALT35.StrType)le.dvdtex),
    Fields.InValid_dvcsce((SALT35.StrType)le.dvcsce),
    Fields.InValid_dvdmce((SALT35.StrType)le.dvdmce),
    Fields.InValid_filler((SALT35.StrType)le.filler),
    Fields.InValid_pimnam((SALT35.StrType)le.pimnam),
    Fields.InValid_pigstr((SALT35.StrType)le.pigstr),
    Fields.InValid_pigcty((SALT35.StrType)le.pigcty),
    Fields.InValid_pigsta((SALT35.StrType)le.pigsta),
    Fields.InValid_pigzip((SALT35.StrType)le.pigzip),
    Fields.InValid_pincnt((SALT35.StrType)le.pincnt),
    Fields.InValid_pidd01((SALT35.StrType)le.pidd01),
    Fields.InValid_piddod((SALT35.StrType)le.piddod),
    Fields.InValid_pidaup((SALT35.StrType)le.pidaup),
    Fields.InValid_crlf((SALT35.StrType)le.crlf),
    Fields.InValid_title((SALT35.StrType)le.title),
    Fields.InValid_fname((SALT35.StrType)le.fname),
    Fields.InValid_mname((SALT35.StrType)le.mname),
    Fields.InValid_lname((SALT35.StrType)le.lname,(SALT35.StrType)le.fname,(SALT35.StrType)le.mname),
    Fields.InValid_name_suffix((SALT35.StrType)le.name_suffix),
    Fields.InValid_cleaning_score((SALT35.StrType)le.cleaning_score),
    Fields.InValid_prim_range((SALT35.StrType)le.prim_range),
    Fields.InValid_predir((SALT35.StrType)le.predir),
    Fields.InValid_prim_name((SALT35.StrType)le.prim_name),
    Fields.InValid_suffix((SALT35.StrType)le.suffix),
    Fields.InValid_postdir((SALT35.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT35.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT35.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT35.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT35.StrType)le.v_city_name),
    Fields.InValid_state((SALT35.StrType)le.state),
    Fields.InValid_zip((SALT35.StrType)le.zip),
    Fields.InValid_zip4((SALT35.StrType)le.zip4),
    Fields.InValid_cart((SALT35.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT35.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT35.StrType)le.lot),
    Fields.InValid_lot_order((SALT35.StrType)le.lot_order),
    Fields.InValid_dbpc((SALT35.StrType)le.dbpc),
    Fields.InValid_chk_digit((SALT35.StrType)le.chk_digit),
    Fields.InValid_rec_type((SALT35.StrType)le.rec_type),
    Fields.InValid_ace_fips_st((SALT35.StrType)le.ace_fips_st),
    Fields.InValid_county((SALT35.StrType)le.county),
    Fields.InValid_geo_lat((SALT35.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT35.StrType)le.geo_long),
    Fields.InValid_msa((SALT35.StrType)le.msa),
    Fields.InValid_geo_blk((SALT35.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT35.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT35.StrType)le.err_stat),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,85,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_8pastdate','invalid_dbkoln','invalid_pinss4','invalid_dvnlic','invalid_dvccls','invalid_dvctyp','invalid_pifdon','invalid_pichcl','invalid_picecl','invalid_piqwgt','invalid_height','invalid_numeric','invalid_picsex','invalid_8pastdate','invalid_boolean_yn_empty','invalid_8generaldate','invalid_drnagy','invalid_dvfocd','invalid_boolean_yn_empty','invalid_dvnlic','invalid_dvcatt','invalid_08generaldate','invalid_dvcded','invalid_alpha_num','invalid_boolean_yn_empty','invalid_dvcgen','invalid_boolean_yn_empty','invalid_dvqdup','invalid_boolean_yn_empty','invalid_dbkmtk','invalid_boolean_yn_empty','invalid_dvnwbi','invalid_sycpgm','invalid_sytda1','invalid_alpha_num','invalid_boolean_yn_empty','invalid_dvctsa','Unknown','Unknown','invalid_dvcsce','invalid_dvdmce','Unknown','Unknown','Unknown','invalid_alpha_num_specials','invalid_pigsta','invalid_pigzip','invalid_alpha_num_specials','invalid_8pastdate','invalid_08pastdate','invalid_08pastdate','Unknown','Unknown','Unknown','Unknown','invalid_name','Unknown','invalid_numeric','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_dbkoln(TotalErrors.ErrorNum),Fields.InValidMessage_pinss4(TotalErrors.ErrorNum),Fields.InValidMessage_dvnlic(TotalErrors.ErrorNum),Fields.InValidMessage_dvccls(TotalErrors.ErrorNum),Fields.InValidMessage_dvctyp(TotalErrors.ErrorNum),Fields.InValidMessage_pifdon(TotalErrors.ErrorNum),Fields.InValidMessage_pichcl(TotalErrors.ErrorNum),Fields.InValidMessage_picecl(TotalErrors.ErrorNum),Fields.InValidMessage_piqwgt(TotalErrors.ErrorNum),Fields.InValidMessage_pinhft(TotalErrors.ErrorNum),Fields.InValidMessage_pinhin(TotalErrors.ErrorNum),Fields.InValidMessage_picsex(TotalErrors.ErrorNum),Fields.InValidMessage_dvddoi(TotalErrors.ErrorNum),Fields.InValidMessage_dvc2pl(TotalErrors.ErrorNum),Fields.InValidMessage_dvdexp(TotalErrors.ErrorNum),Fields.InValidMessage_drnagy(TotalErrors.ErrorNum),Fields.InValidMessage_dvfocd(TotalErrors.ErrorNum),Fields.InValidMessage_dvfopd(TotalErrors.ErrorNum),Fields.InValidMessage_dvnapp(TotalErrors.ErrorNum),Fields.InValidMessage_dvcatt(TotalErrors.ErrorNum),Fields.InValidMessage_dvdnov(TotalErrors.ErrorNum),Fields.InValidMessage_dvcded(TotalErrors.ErrorNum),Fields.InValidMessage_dvcgrs(TotalErrors.ErrorNum),Fields.InValidMessage_dvfdup(TotalErrors.ErrorNum),Fields.InValidMessage_dvcgen(TotalErrors.ErrorNum),Fields.InValidMessage_dvflsd(TotalErrors.ErrorNum),Fields.InValidMessage_dvqdup(TotalErrors.ErrorNum),Fields.InValidMessage_dvfohr(TotalErrors.ErrorNum),Fields.InValidMessage_dbkmtk(TotalErrors.ErrorNum),Fields.InValidMessage_dvfrcs(TotalErrors.ErrorNum),Fields.InValidMessage_dvnwbi(TotalErrors.ErrorNum),Fields.InValidMessage_sycpgm(TotalErrors.ErrorNum),Fields.InValidMessage_sytda1(TotalErrors.ErrorNum),Fields.InValidMessage_sycuid(TotalErrors.ErrorNum),Fields.InValidMessage_dvffrd(TotalErrors.ErrorNum),Fields.InValidMessage_dvctsa(TotalErrors.ErrorNum),Fields.InValidMessage_dvdtsa(TotalErrors.ErrorNum),Fields.InValidMessage_dvdtex(TotalErrors.ErrorNum),Fields.InValidMessage_dvcsce(TotalErrors.ErrorNum),Fields.InValidMessage_dvdmce(TotalErrors.ErrorNum),Fields.InValidMessage_filler(TotalErrors.ErrorNum),Fields.InValidMessage_pimnam(TotalErrors.ErrorNum),Fields.InValidMessage_pigstr(TotalErrors.ErrorNum),Fields.InValidMessage_pigcty(TotalErrors.ErrorNum),Fields.InValidMessage_pigsta(TotalErrors.ErrorNum),Fields.InValidMessage_pigzip(TotalErrors.ErrorNum),Fields.InValidMessage_pincnt(TotalErrors.ErrorNum),Fields.InValidMessage_pidd01(TotalErrors.ErrorNum),Fields.InValidMessage_piddod(TotalErrors.ErrorNum),Fields.InValidMessage_pidaup(TotalErrors.ErrorNum),Fields.InValidMessage_crlf(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_cleaning_score(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_ace_fips_st(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
