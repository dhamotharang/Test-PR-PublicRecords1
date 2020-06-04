// EXPORT In_Exemptions_Base := PROJECT($.Files.Exemptions.Input_PR
//                                     +$.Files.Exemptions.Input_HC
//                                     +$.Files.Exemptions.Input_Ins,
//                                     TRANSFORM($.Layout_Exemptions_Base,SELF:=LEFT,SELF:=[]));
EXPORT In_Exemptions_Base := $.Files.Exemptions.Basefile;