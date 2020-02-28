export MAC_Build_all(filedate = '', pUseProd = false) := functionmacro
    import crim_offense_cat;
    bld_base := crim_offense_cat.build_base(filedate, pUseProd);
    bld_key:= crim_offense_cat.build_key(filedate, pUseProd);
    fullseq := sequential(bld_base, bld_key) :success(crim_offense_cat.send_email(filedate).build_success),failure(crim_offense_cat.send_email(filedate).build_failure);
    return fullseq;
endmacro;
