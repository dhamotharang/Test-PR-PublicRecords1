iteration := '1';
pversion  := '20121116';
names     :=    BIPV2_ProxID.filenames(pversion + '_' + iteration).dall_filenames
              + BIPV2_ProxID.keynames(pversion + '_' + iteration).dall_filenames
              ;
nothor(Tools.fun_ClearfilesFromSupers(project(names, transform(Tools.Layout_Names,self.name := left.logicalname)), false)) //clear supers if needed
