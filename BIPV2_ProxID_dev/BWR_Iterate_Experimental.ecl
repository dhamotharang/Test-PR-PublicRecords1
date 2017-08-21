#workunit('name','BIPV2_ProxID_dev.BWR_Iterate - Internal Linking - SALT V2.5 ALPHA 1');
IMPORT BIPV2_ProxID_dev,SALT24,bipv2_tools,BIPV2_Files,BIPV2,tools;
#option('spanMultipleCpp' ,1)
lbegin      := true;
lih         := if(lbegin = true   ,BIPV2_ProxID_dev.In_DOT_Base    ,BIPV2_ProxID_dev.files().base.built );
lversion    := '20121124';
loffset     := 0;
lIsTesting  := false;  //true = don't build final set of keys, false = build final set of keys
names       :=    BIPV2_ProxID_dev.filenames(lversion + '_' + (string)(loffset + 1)).dall_filenames
                + BIPV2_ProxID_dev.keynames (lversion + '_' + (string)(loffset + 1)).dall_filenames
                ;
prevcombo   := lversion + '_' + (string)loffset;
iter        := BIPV2_ProxID_dev._Proc_Iterate_Experimental(pIsTesting := lIsTesting).Loop20(ih := lih ,pversion := lversion ,offset := loffset);
sequential(
   nothor(Tools.fun_ClearfilesFromSupers(project(names, transform(Tools.Layout_Names,self.name := left.logicalname)), false)) //clear supers if needed
  ,if(loffset = 0 ,sequential(output(choosen(lih,100)),BIPV2_ProxID_dev.promote('0').new2built),BIPV2_ProxID_dev.Promote(prevcombo).new2built)  //setup first iteration
  ,BIPV2_ProxID_dev.output_test_cases(iter)
  ,BIPV2_ProxID_dev.Promote().built2qa
);
