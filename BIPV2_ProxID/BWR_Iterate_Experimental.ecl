#workunit('name','BIPV2_ProxID.BWR_Iterate - Internal Linking - SALT V2.5 ALPHA 1');
IMPORT BIPV2_ProxID,SALT24,bipv2_tools,BIPV2_Files,BIPV2,tools;
#option('spanMultipleCpp' ,1)
lbegin      := true;
lih         := if(lbegin = true   ,BIPV2_ProxID.In_DOT_Base    ,BIPV2_ProxID.files().base.built );
lversion    := '20121124';
loffset     := 0;
lIsTesting  := false;  //true = don't build final set of keys, false = build final set of keys
names       :=    BIPV2_ProxID.filenames(lversion + '_' + (string)(loffset + 1)).dall_filenames
                + BIPV2_ProxID.keynames (lversion + '_' + (string)(loffset + 1)).dall_filenames
                ;
prevcombo   := lversion + '_' + (string)loffset;
iter        := BIPV2_ProxID._Proc_Iterate_Experimental(pIsTesting := lIsTesting).Loop20(ih := lih ,pversion := lversion ,offset := loffset);
sequential(
   nothor(Tools.fun_ClearfilesFromSupers(project(names, transform(Tools.Layout_Names,self.name := left.logicalname)), false)) //clear supers if needed
  ,if(loffset = 0 ,sequential(output(choosen(lih,100)),BIPV2_ProxID.promote('0').new2built),BIPV2_ProxID.Promote(prevcombo).new2built)  //setup first iteration
  ,BIPV2_ProxID.output_test_cases(iter)
  ,BIPV2_ProxID.Promote().built2qa
);
