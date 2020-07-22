IMPORT SALT311,STD;
EXPORT Config := MODULE,VIRTUAL
EXPORT CorrelateSampleSize := 3698224; // Size of sample used in hygiene.corelations (reduced due to large field count)
EXPORT ByPassCleave := FALSE; // If set to true Cleave process will not run in the next internal linking iteration.
EXPORT PersistExpire := 30; // PERSIST file expiration time in days.
EXPORT AttrValueType := SALT311.AttrValueType;
EXPORT KeysBitmapType := UNSIGNED4;
EXPORT KeysBitmapOffset := 16;
EXPORT MaxChildren := 100; // Maximum children allowed for a MULTIPLE(,LIST)
alg := ENUM(UNSIGNED1, Standard=0, NoTrailingHalfEdit);
EXPORT WithinEditN(SALT311.StrType l,UNSIGNED1 ll, SALT311.StrType r,UNSIGNED1 rl,UNSIGNED1 d, UNSIGNED1 edit_threshold=0,UNSIGNED1 mode=alg.Standard, BOOLEAN edFunction(SALT311.StrType l,UNSIGNED1 ll, SALT311.StrType r,UNSIGNED1 rl,UNSIGNED1 d,UNSIGNED1 mode) = SALT311.fn_EditDistance) := 
        SALT311.WithinEditNew(l, ll, r, rl, d, edit_threshold, mode, edFunction);
EXPORT JoinLimit := 10000;
// Configuration of individual fields
 
EXPORT STRING PayloadKeyName := '~'+'key::Equifax_Business_Data::seleid::meow';
h := DATASET([],Layouts.Base);
d := DATASET([],RECORDOF(h));
 
EXPORT PayloadKey := INDEX(d,{seleid},{d},PayloadKeyName,OPT);
EXPORT DateModified(STRING name) := (UNSIGNED4)(STD.Str.FindReplace(STD.File.GetLogicalFileAttribute('~' + name,'modified'),'-','')[1..8]);
EXPORT MaxMergeFiles := 100;
 
EXPORT STRING ValueKeyName := '~'+'key::Equifax_Business_Data::seleid::Words';
word_values := DATASET([],{SALT311.Str30Type word,UNSIGNED cnt,UNSIGNED t_cnt,UNSIGNED4 id, REAL field_specificity});
 
EXPORT ValueKey := INDEX(word_values,{word},{word_values},ValueKeyName,OPT);
END;
