import header,PRTE2_Header,std;

isProd:=true:stored('production');

#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
f := header.File_HHID;
#ELSE
f := header.File_HHID;
#END;
fg := GROUP(SORT(DISTRIBUTE(f, HASH(did)), did, LOCAL), did);
fgd := DEDUP(SORT(fg, -last_current), did, KEEP(3));

layout_hhid_version := RECORD
    f;
    UNSIGNED1 ver := 1;
END;

layout_hhid_version AppendVersion(fgd l) := TRANSFORM
    SELF := l;
END;

layout_hhid_version AddVersion(layout_hhid_version l, layout_hhid_version r) := TRANSFORM
    SELF.ver := l.ver + 1;
    SELF := r;
END;

fgv := GROUP(
    ITERATE(PROJECT(fgd, AppendVersion(LEFT)), AddVersion(LEFT, RIGHT)));

#IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);
export File_HHID_Current := fgv;
#ELSE
rf:='HHID_Current';
tf:='HHID_Current_headerbuilding';
bv1:=output(fgv,,rf,compressed,update,overwrite,expire(7));
bv2:=output(fgv,,tf,compressed,update,overwrite,expire(7));
v1 := when(dataset(rf,{fgv},thor),if(nothor(~std.file.fileexists(rf)),bv1),before);
v2 := when(dataset(tf,{fgv},thor),if(nothor(~std.file.fileexists(tf)),bv2),before);

export File_HHID_Current:=if(isProd,v1,v2);
#END
