 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_process_date = '',Input_dbkoln = '',Input_pinss4 = '',Input_dvnlic = '',Input_dvccls = '',Input_dvctyp = '',Input_pifdon = '',Input_pichcl = '',Input_picecl = '',Input_piqwgt = '',Input_pinhft = '',Input_pinhin = '',Input_picsex = '',Input_dvddoi = '',Input_dvc2pl = '',Input_dvdexp = '',Input_drnagy = '',Input_dvfocd = '',Input_dvfopd = '',Input_dvnapp = '',Input_dvcatt = '',Input_dvdnov = '',Input_dvcded = '',Input_dvcgrs = '',Input_dvfdup = '',Input_dvcgen = '',Input_dvflsd = '',Input_dvqdup = '',Input_dvfohr = '',Input_dbkmtk = '',Input_dvfrcs = '',Input_dvnwbi = '',Input_sycpgm = '',Input_sytda1 = '',Input_sycuid = '',Input_dvffrd = '',Input_dvctsa = '',Input_dvdtsa = '',Input_dvdtex = '',Input_dvcsce = '',Input_dvdmce = '',Input_filler = '',Input_pimnam = '',Input_pigstr = '',Input_pigcty = '',Input_pigsta = '',Input_pigzip = '',Input_pincnt = '',Input_pidd01 = '',Input_piddod = '',Input_pidaup = '',Input_crlf = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_cleaning_score = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_state = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_ace_fips_st = '',Input_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',OutFile) := MACRO
  IMPORT SALT35,Scrubs_DL_OH;
  #uniquename(of)
  %of% := RECORD
    SALT35.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
 
+    #IF( #TEXT(Input_dbkoln)='' )
      '' 
    #ELSE
        IF( le.Input_dbkoln = (TYPEOF(le.Input_dbkoln))'','',':dbkoln')
    #END
 
+    #IF( #TEXT(Input_pinss4)='' )
      '' 
    #ELSE
        IF( le.Input_pinss4 = (TYPEOF(le.Input_pinss4))'','',':pinss4')
    #END
 
+    #IF( #TEXT(Input_dvnlic)='' )
      '' 
    #ELSE
        IF( le.Input_dvnlic = (TYPEOF(le.Input_dvnlic))'','',':dvnlic')
    #END
 
+    #IF( #TEXT(Input_dvccls)='' )
      '' 
    #ELSE
        IF( le.Input_dvccls = (TYPEOF(le.Input_dvccls))'','',':dvccls')
    #END
 
+    #IF( #TEXT(Input_dvctyp)='' )
      '' 
    #ELSE
        IF( le.Input_dvctyp = (TYPEOF(le.Input_dvctyp))'','',':dvctyp')
    #END
 
+    #IF( #TEXT(Input_pifdon)='' )
      '' 
    #ELSE
        IF( le.Input_pifdon = (TYPEOF(le.Input_pifdon))'','',':pifdon')
    #END
 
+    #IF( #TEXT(Input_pichcl)='' )
      '' 
    #ELSE
        IF( le.Input_pichcl = (TYPEOF(le.Input_pichcl))'','',':pichcl')
    #END
 
+    #IF( #TEXT(Input_picecl)='' )
      '' 
    #ELSE
        IF( le.Input_picecl = (TYPEOF(le.Input_picecl))'','',':picecl')
    #END
 
+    #IF( #TEXT(Input_piqwgt)='' )
      '' 
    #ELSE
        IF( le.Input_piqwgt = (TYPEOF(le.Input_piqwgt))'','',':piqwgt')
    #END
 
+    #IF( #TEXT(Input_pinhft)='' )
      '' 
    #ELSE
        IF( le.Input_pinhft = (TYPEOF(le.Input_pinhft))'','',':pinhft')
    #END
 
+    #IF( #TEXT(Input_pinhin)='' )
      '' 
    #ELSE
        IF( le.Input_pinhin = (TYPEOF(le.Input_pinhin))'','',':pinhin')
    #END
 
+    #IF( #TEXT(Input_picsex)='' )
      '' 
    #ELSE
        IF( le.Input_picsex = (TYPEOF(le.Input_picsex))'','',':picsex')
    #END
 
+    #IF( #TEXT(Input_dvddoi)='' )
      '' 
    #ELSE
        IF( le.Input_dvddoi = (TYPEOF(le.Input_dvddoi))'','',':dvddoi')
    #END
 
+    #IF( #TEXT(Input_dvc2pl)='' )
      '' 
    #ELSE
        IF( le.Input_dvc2pl = (TYPEOF(le.Input_dvc2pl))'','',':dvc2pl')
    #END
 
+    #IF( #TEXT(Input_dvdexp)='' )
      '' 
    #ELSE
        IF( le.Input_dvdexp = (TYPEOF(le.Input_dvdexp))'','',':dvdexp')
    #END
 
+    #IF( #TEXT(Input_drnagy)='' )
      '' 
    #ELSE
        IF( le.Input_drnagy = (TYPEOF(le.Input_drnagy))'','',':drnagy')
    #END
 
+    #IF( #TEXT(Input_dvfocd)='' )
      '' 
    #ELSE
        IF( le.Input_dvfocd = (TYPEOF(le.Input_dvfocd))'','',':dvfocd')
    #END
 
+    #IF( #TEXT(Input_dvfopd)='' )
      '' 
    #ELSE
        IF( le.Input_dvfopd = (TYPEOF(le.Input_dvfopd))'','',':dvfopd')
    #END
 
+    #IF( #TEXT(Input_dvnapp)='' )
      '' 
    #ELSE
        IF( le.Input_dvnapp = (TYPEOF(le.Input_dvnapp))'','',':dvnapp')
    #END
 
+    #IF( #TEXT(Input_dvcatt)='' )
      '' 
    #ELSE
        IF( le.Input_dvcatt = (TYPEOF(le.Input_dvcatt))'','',':dvcatt')
    #END
 
+    #IF( #TEXT(Input_dvdnov)='' )
      '' 
    #ELSE
        IF( le.Input_dvdnov = (TYPEOF(le.Input_dvdnov))'','',':dvdnov')
    #END
 
+    #IF( #TEXT(Input_dvcded)='' )
      '' 
    #ELSE
        IF( le.Input_dvcded = (TYPEOF(le.Input_dvcded))'','',':dvcded')
    #END
 
+    #IF( #TEXT(Input_dvcgrs)='' )
      '' 
    #ELSE
        IF( le.Input_dvcgrs = (TYPEOF(le.Input_dvcgrs))'','',':dvcgrs')
    #END
 
+    #IF( #TEXT(Input_dvfdup)='' )
      '' 
    #ELSE
        IF( le.Input_dvfdup = (TYPEOF(le.Input_dvfdup))'','',':dvfdup')
    #END
 
+    #IF( #TEXT(Input_dvcgen)='' )
      '' 
    #ELSE
        IF( le.Input_dvcgen = (TYPEOF(le.Input_dvcgen))'','',':dvcgen')
    #END
 
+    #IF( #TEXT(Input_dvflsd)='' )
      '' 
    #ELSE
        IF( le.Input_dvflsd = (TYPEOF(le.Input_dvflsd))'','',':dvflsd')
    #END
 
+    #IF( #TEXT(Input_dvqdup)='' )
      '' 
    #ELSE
        IF( le.Input_dvqdup = (TYPEOF(le.Input_dvqdup))'','',':dvqdup')
    #END
 
+    #IF( #TEXT(Input_dvfohr)='' )
      '' 
    #ELSE
        IF( le.Input_dvfohr = (TYPEOF(le.Input_dvfohr))'','',':dvfohr')
    #END
 
+    #IF( #TEXT(Input_dbkmtk)='' )
      '' 
    #ELSE
        IF( le.Input_dbkmtk = (TYPEOF(le.Input_dbkmtk))'','',':dbkmtk')
    #END
 
+    #IF( #TEXT(Input_dvfrcs)='' )
      '' 
    #ELSE
        IF( le.Input_dvfrcs = (TYPEOF(le.Input_dvfrcs))'','',':dvfrcs')
    #END
 
+    #IF( #TEXT(Input_dvnwbi)='' )
      '' 
    #ELSE
        IF( le.Input_dvnwbi = (TYPEOF(le.Input_dvnwbi))'','',':dvnwbi')
    #END
 
+    #IF( #TEXT(Input_sycpgm)='' )
      '' 
    #ELSE
        IF( le.Input_sycpgm = (TYPEOF(le.Input_sycpgm))'','',':sycpgm')
    #END
 
+    #IF( #TEXT(Input_sytda1)='' )
      '' 
    #ELSE
        IF( le.Input_sytda1 = (TYPEOF(le.Input_sytda1))'','',':sytda1')
    #END
 
+    #IF( #TEXT(Input_sycuid)='' )
      '' 
    #ELSE
        IF( le.Input_sycuid = (TYPEOF(le.Input_sycuid))'','',':sycuid')
    #END
 
+    #IF( #TEXT(Input_dvffrd)='' )
      '' 
    #ELSE
        IF( le.Input_dvffrd = (TYPEOF(le.Input_dvffrd))'','',':dvffrd')
    #END
 
+    #IF( #TEXT(Input_dvctsa)='' )
      '' 
    #ELSE
        IF( le.Input_dvctsa = (TYPEOF(le.Input_dvctsa))'','',':dvctsa')
    #END
 
+    #IF( #TEXT(Input_dvdtsa)='' )
      '' 
    #ELSE
        IF( le.Input_dvdtsa = (TYPEOF(le.Input_dvdtsa))'','',':dvdtsa')
    #END
 
+    #IF( #TEXT(Input_dvdtex)='' )
      '' 
    #ELSE
        IF( le.Input_dvdtex = (TYPEOF(le.Input_dvdtex))'','',':dvdtex')
    #END
 
+    #IF( #TEXT(Input_dvcsce)='' )
      '' 
    #ELSE
        IF( le.Input_dvcsce = (TYPEOF(le.Input_dvcsce))'','',':dvcsce')
    #END
 
+    #IF( #TEXT(Input_dvdmce)='' )
      '' 
    #ELSE
        IF( le.Input_dvdmce = (TYPEOF(le.Input_dvdmce))'','',':dvdmce')
    #END
 
+    #IF( #TEXT(Input_filler)='' )
      '' 
    #ELSE
        IF( le.Input_filler = (TYPEOF(le.Input_filler))'','',':filler')
    #END
 
+    #IF( #TEXT(Input_pimnam)='' )
      '' 
    #ELSE
        IF( le.Input_pimnam = (TYPEOF(le.Input_pimnam))'','',':pimnam')
    #END
 
+    #IF( #TEXT(Input_pigstr)='' )
      '' 
    #ELSE
        IF( le.Input_pigstr = (TYPEOF(le.Input_pigstr))'','',':pigstr')
    #END
 
+    #IF( #TEXT(Input_pigcty)='' )
      '' 
    #ELSE
        IF( le.Input_pigcty = (TYPEOF(le.Input_pigcty))'','',':pigcty')
    #END
 
+    #IF( #TEXT(Input_pigsta)='' )
      '' 
    #ELSE
        IF( le.Input_pigsta = (TYPEOF(le.Input_pigsta))'','',':pigsta')
    #END
 
+    #IF( #TEXT(Input_pigzip)='' )
      '' 
    #ELSE
        IF( le.Input_pigzip = (TYPEOF(le.Input_pigzip))'','',':pigzip')
    #END
 
+    #IF( #TEXT(Input_pincnt)='' )
      '' 
    #ELSE
        IF( le.Input_pincnt = (TYPEOF(le.Input_pincnt))'','',':pincnt')
    #END
 
+    #IF( #TEXT(Input_pidd01)='' )
      '' 
    #ELSE
        IF( le.Input_pidd01 = (TYPEOF(le.Input_pidd01))'','',':pidd01')
    #END
 
+    #IF( #TEXT(Input_piddod)='' )
      '' 
    #ELSE
        IF( le.Input_piddod = (TYPEOF(le.Input_piddod))'','',':piddod')
    #END
 
+    #IF( #TEXT(Input_pidaup)='' )
      '' 
    #ELSE
        IF( le.Input_pidaup = (TYPEOF(le.Input_pidaup))'','',':pidaup')
    #END
 
+    #IF( #TEXT(Input_crlf)='' )
      '' 
    #ELSE
        IF( le.Input_crlf = (TYPEOF(le.Input_crlf))'','',':crlf')
    #END
 
+    #IF( #TEXT(Input_title)='' )
      '' 
    #ELSE
        IF( le.Input_title = (TYPEOF(le.Input_title))'','',':title')
    #END
 
+    #IF( #TEXT(Input_fname)='' )
      '' 
    #ELSE
        IF( le.Input_fname = (TYPEOF(le.Input_fname))'','',':fname')
    #END
 
+    #IF( #TEXT(Input_mname)='' )
      '' 
    #ELSE
        IF( le.Input_mname = (TYPEOF(le.Input_mname))'','',':mname')
    #END
 
+    #IF( #TEXT(Input_lname)='' )
      '' 
    #ELSE
        IF( le.Input_lname = (TYPEOF(le.Input_lname))'','',':lname')
    #END
 
+    #IF( #TEXT(Input_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_name_suffix = (TYPEOF(le.Input_name_suffix))'','',':name_suffix')
    #END
 
+    #IF( #TEXT(Input_cleaning_score)='' )
      '' 
    #ELSE
        IF( le.Input_cleaning_score = (TYPEOF(le.Input_cleaning_score))'','',':cleaning_score')
    #END
 
+    #IF( #TEXT(Input_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_prim_range = (TYPEOF(le.Input_prim_range))'','',':prim_range')
    #END
 
+    #IF( #TEXT(Input_predir)='' )
      '' 
    #ELSE
        IF( le.Input_predir = (TYPEOF(le.Input_predir))'','',':predir')
    #END
 
+    #IF( #TEXT(Input_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_prim_name = (TYPEOF(le.Input_prim_name))'','',':prim_name')
    #END
 
+    #IF( #TEXT(Input_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_suffix = (TYPEOF(le.Input_suffix))'','',':suffix')
    #END
 
+    #IF( #TEXT(Input_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_postdir = (TYPEOF(le.Input_postdir))'','',':postdir')
    #END
 
+    #IF( #TEXT(Input_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_unit_desig = (TYPEOF(le.Input_unit_desig))'','',':unit_desig')
    #END
 
+    #IF( #TEXT(Input_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_sec_range = (TYPEOF(le.Input_sec_range))'','',':sec_range')
    #END
 
+    #IF( #TEXT(Input_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_p_city_name = (TYPEOF(le.Input_p_city_name))'','',':p_city_name')
    #END
 
+    #IF( #TEXT(Input_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_v_city_name = (TYPEOF(le.Input_v_city_name))'','',':v_city_name')
    #END
 
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
 
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END
 
+    #IF( #TEXT(Input_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_zip4 = (TYPEOF(le.Input_zip4))'','',':zip4')
    #END
 
+    #IF( #TEXT(Input_cart)='' )
      '' 
    #ELSE
        IF( le.Input_cart = (TYPEOF(le.Input_cart))'','',':cart')
    #END
 
+    #IF( #TEXT(Input_cr_sort_sz)='' )
      '' 
    #ELSE
        IF( le.Input_cr_sort_sz = (TYPEOF(le.Input_cr_sort_sz))'','',':cr_sort_sz')
    #END
 
+    #IF( #TEXT(Input_lot)='' )
      '' 
    #ELSE
        IF( le.Input_lot = (TYPEOF(le.Input_lot))'','',':lot')
    #END
 
+    #IF( #TEXT(Input_lot_order)='' )
      '' 
    #ELSE
        IF( le.Input_lot_order = (TYPEOF(le.Input_lot_order))'','',':lot_order')
    #END
 
+    #IF( #TEXT(Input_dbpc)='' )
      '' 
    #ELSE
        IF( le.Input_dbpc = (TYPEOF(le.Input_dbpc))'','',':dbpc')
    #END
 
+    #IF( #TEXT(Input_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_chk_digit = (TYPEOF(le.Input_chk_digit))'','',':chk_digit')
    #END
 
+    #IF( #TEXT(Input_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_rec_type = (TYPEOF(le.Input_rec_type))'','',':rec_type')
    #END
 
+    #IF( #TEXT(Input_ace_fips_st)='' )
      '' 
    #ELSE
        IF( le.Input_ace_fips_st = (TYPEOF(le.Input_ace_fips_st))'','',':ace_fips_st')
    #END
 
+    #IF( #TEXT(Input_county)='' )
      '' 
    #ELSE
        IF( le.Input_county = (TYPEOF(le.Input_county))'','',':county')
    #END
 
+    #IF( #TEXT(Input_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_geo_lat = (TYPEOF(le.Input_geo_lat))'','',':geo_lat')
    #END
 
+    #IF( #TEXT(Input_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_geo_long = (TYPEOF(le.Input_geo_long))'','',':geo_long')
    #END
 
+    #IF( #TEXT(Input_msa)='' )
      '' 
    #ELSE
        IF( le.Input_msa = (TYPEOF(le.Input_msa))'','',':msa')
    #END
 
+    #IF( #TEXT(Input_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_geo_blk = (TYPEOF(le.Input_geo_blk))'','',':geo_blk')
    #END
 
+    #IF( #TEXT(Input_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_geo_match = (TYPEOF(le.Input_geo_match))'','',':geo_match')
    #END
 
+    #IF( #TEXT(Input_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_err_stat = (TYPEOF(le.Input_err_stat))'','',':err_stat')
    #END
;
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%, fields, FEW ), 1000, -cnt );
ENDMACRO;
