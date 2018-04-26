* Encoding: UTF-8.
OUTPUT CLOSE *.
DATASET CLOSE ALL.

GET FILE='/Users/Daniel/MyDropbox/My-Manuscripts/with-Myself/Virtual_Reality_as_intervention/Dropbox/Behavioral Data Analysis/10.13.16_UTD_Yale Participants_Adult Social Cognition Database.sav'.

SELECT IF NOT (IDnumber = 'KR0143' or IDnumber = 'NE0088' or IDnumber = 'NM0141' or IDnumber = '').
EXECUTE.

****************************************************************************************************************************************************************************************.
*Site coding for FSL/FEAT.
NUMERIC Site_coding(F1.0).
DO IF (SITE = 'UTD').
    COMPUTE Site_coding=1.
END IF.
DO IF (SITE = 'Yale').
    COMPUTE Site_coding=-1.
END IF.
****************************************************************************************************************************************************************************************.

*subjects clean-up.
SELECT IF NOT (IDnumber = 'HM8110.02'). /*low IQ.
*SELECT IF NOT (IDnumber = 'IU0145'). /*High pre rel head motion (mean and SD), but ACS SP decreased.
*SELECT IF NOT (IDnumber = 'JD10749.01').
EXECUTE.

*ACS SP.
RENAME VARIABLES (SocialPerc_scale = ACS_SP_scale_pre).
RENAME VARIABLES (SocialPerc_T_T2 = ACS_SP_scale_post).
COMPUTE ACS_SP_scale_post_minus_pre=(ACS_SP_scale_post-ACS_SP_scale_pre).
COMPUTE ACS_SP_scale_post_plus_pre=(ACS_SP_scale_post+ACS_SP_scale_pre).

RENAME VARIABLES (AffectName_scale= AffectName_scale_pre).
RENAME VARIABLES (AffectName_scale_T2 = AffectName_scale_post).
COMPUTE AffectName_scale_post_minus_pre=(AffectName_scale_post-AffectName_scale_pre).

RENAME VARIABLES (SP_Prosody_scale = Prosody_scale_pre).
RENAME VARIABLES (SP_Prosody_scale_T2 = Prosody_scale_post).
COMPUTE Prosody_scale_post_minus_pre=(Prosody_scale_post-Prosody_scale_pre).

RENAME VARIABLES (SP_Pairs_scale = Pairs_scale_pre).
RENAME VARIABLES (SP_Pairs_scale_T2 = Pairs_scale_post).
COMPUTE Pairs_scale_post_minus_pre=(Pairs_scale_post-Pairs_scale_pre).

*Triangles.
COMPUTE Tri_accuracy_pre=SUM(Tri_R1_acc, Tri_GD1_acc, Tri_ToM1_acc, Tri_R2_acc, Tri_GD2_acc, Tri_ToM2_acc).
COMPUTE Tri_attribution_pre=SUM(Tri_R1_att, Tri_GD1_att, Tri_ToM1_att, Tri_R2_att, Tri_GD2_att, Tri_ToM2_att).
COMPUTE Triangles_total_pre=Tri_accuracy_pre+Tri_attribution_pre.

COMPUTE Tri_accuracy_post=SUM(Tri_R1_acc_T2, Tri_GD1_acc_T2, Tri_ToM1_acc_T2, Tri_R2_acc_T2, Tri_GD2_acc_T2, Tri_ToM2_acc_T2).
COMPUTE Tri_attribution_post=SUM(Tri_R1_att_T2, Tri_GD1_att_T2, Tri_ToM1_att_T2, Tri_R2_att_T2, Tri_GD2_att_T2, Tri_ToM2_att_T2).
COMPUTE Triangles_total_post=Tri_accuracy_post+Tri_attribution_post.

COMPUTE Triangles_total_post_minus_pre=(Triangles_total_post-Triangles_total_pre).

*RENAME VARIABLES (Tri_acc.att_total = Triangles_total_pre).
*RENAME VARIABLES (Tri_Total2 = Triangles_total_post).
*COMPUTE Triangles_total_post_minus_pre=(Triangles_total_post-Triangles_total_pre).

*RENAME VARIABLES (Tri_Acc_T1 = Tri_accuracy_pre).
*RENAME VARIABLES (Tri_Acc_T2 = Tri_accuracy_post).
COMPUTE Tri_accuracy_post_minus_pre=(Tri_accuracy_post-Tri_accuracy_pre).

*COMPUTE Tri_attribution_pre=(Triangles_total_pre-Tri_accuracy_pre).
*COMPUTE Tri_attribution_post=(Triangles_total_post-Tri_accuracy_post).
COMPUTE Tri_attribution_post_minus_pre=(Tri_attribution_post-Tri_attribution_pre).

*RENAME VARIABLES (Tri_Intentionality = Tri_intentionality_pre).
*RENAME VARIABLES (Tri_intent_T2 = Tri_intentionality_post).
*COMPUTE Tri_intentionality_post_minus_pre=(Tri_intentionality_post-Tri_intentionality_pre).

COMPUTE PSC_nonaggr_BIO_gt_SCR_post_minus_pre=(PSC_nonaggr_BIO_gt_SCR_post-PSC_nonaggr_BIO_gt_SCR_pre).

*SELECT IF Gender=1.

*Centering.
DESCRIPTIVES VARIABLES=
    Triangles_total_post_minus_pre
    ACS_SP_scale_post_minus_pre
    Site_coding
    FSIQ
    Age_PreScan
    Gender
    ACS_SP_scale_pre
    ACS_SP_scale_post
    ACS_SP_scale_post_plus_pre
    SRS2_Self_Total_Raw
    Triangles_total_pre
  /SAVE
  /STATISTICS=MEAN STDDEV MIN MAX.

FORMATS
    ACS_SP_scale_post_minus_pre (F11.0)
    ACS_SP_scale_post_plus_pre (F11.0)
    ZTriangles_total_post_minus_pre (F11.8)
    ZACS_SP_scale_post_minus_pre (F11.8)
    PSC_nonaggr_BIO_gt_SCR_post_minus_pre (F11.8)
    ZACS_SP_scale_pre (F11.8)
    ZACS_SP_scale_post (F11.8)
    ZACS_SP_scale_post_plus_pre (F11.8)
    ZSRS2_Self_Total_Raw (F11.8)
    ZTriangles_total_pre (F11.8).
EXECUTE.

RENAME VARIABLES (ZSite_coding = Site_coding_centered).
FORMATS Site_coding_centered (F11.8).

RENAME VARIABLES (ZFSIQ = FSIQ_centered).
FORMATS FSIQ_centered (F11.8).

RENAME VARIABLES (ZAge_PreScan = Age_centered).
FORMATS Age_centered (F11.8).

RENAME VARIABLES (ZGender = Sex_centered).
FORMATS Sex_centered (F11.8).

EXECUTE.

RENAME VARIABLES (ADOS_C_SI_Total = ADOS_SA_Domain).
RENAME VARIABLES (ADOS_Stereo_Beh_Total = ADOS_RRB_Domain).
RENAME VARIABLES (ADOS_total_SA_and_RRB = ADOS_Total).

*Save as Excel for FSL.
SAVE TRANSLATE OUTFILE='/Users/Daniel/tmp/vr_overall.xlsx'
  /TYPE=XLS
  /VERSION=12
  /MAP
  /FIELDNAMES VALUE=NAMES
  /CELLS=VALUES
  /EXCELOPTIONS SHEET='Sheet1'
  /REPLACE
  /KEEP=
    Biopoint_pre_vs_post_SOC_gt_CON_activation_aggr_dir
    Biopoint_pre_vs_post_SOC_gt_CON_fc_rpSTS_aggr_dir
    ones
    Site_coding_centered
    FSIQ_centered
    Age_centered
    Sex_centered
    ZSRS2_Self_Total_Raw
    ZACS_SP_scale_post_minus_pre
    ZTriangles_total_post_minus_pre
    ZACS_SP_scale_pre
    ZTriangles_total_pre.

**************************************.
*Internal analysis.

SAVE OUTFILE= '/Users/Daniel/tmp/vr_overall.zsav'
    /KEEP
    Biopoint_pre_vs_post_SOC_gt_CON_activation_aggr_dir
    SiteID
    Site_coding
    Age_PreScan
    Gender
    FSIQ
    Edinburg_Handedness_Inventory
    ADOS_module
    ADOS_SA_Domain
    ADOS_RRB_Domain
    ADOS_Total
    ACS_SP_scale_pre
    ACS_SP_scale_post
    ACS_SP_scale_post_minus_pre
    ACS_SP_scale_post_plus_pre
    AffectName_scale_pre
    AffectName_scale_post
    AffectName_scale_post_minus_pre
    Prosody_scale_pre
    Prosody_scale_post
    Prosody_scale_post_minus_pre
    Pairs_scale_pre
    Pairs_scale_post
    Pairs_scale_post_minus_pre
    Triangles_total_pre
    Triangles_total_post
    Triangles_total_post_minus_pre
    Tri_accuracy_pre
    Tri_accuracy_post
    Tri_accuracy_post_minus_pre
    Tri_attribution_pre
    Tri_attribution_post
    Tri_attribution_post_minus_pre
    headmotion_pre_abs_mean
    headmotion_pre_abs_SD
    headmotion_pre_rel_mean
    headmotion_pre_rel_SD
    headmotion_post_rel_mean
    headmotion_post_rel_SD
    PSC_nonaggr_BIO_gt_SCR_pre
    PSC_nonaggr_BIO_gt_SCR_post
    PSC_nonaggr_BIO_gt_SCR_post_minus_pre
    PSC_aggr_BIO_gt_SCR_neural_predictor_ACS_SP_Z1.645
    PSC_aggr_BIO_gt_SCR_neural_predictor_ACS_SP_Z2.33
    SRS2_Self_AWR_Raw
    SRS2_Self_Cog_Raw
    SRS2_Self_Com_Raw
    SRS2_Self_Mot_Raw
    SRS2_Self_RRB_Raw
    SRS2_Self_Total_Raw
    PSC_post_vs_pre_in_right_pSTS_295_voxels
    PSC_post_vs_pre_in_left_IFG_669_voxels.

GET FILE='/Users/Daniel/tmp/vr_overall.zsav'.
DATASET NAME VR.
DATASET ACTIVATE VR.

RENAME VARIABLES (Edinburg_Handedness_Inventory = Handedness).

EXAMINE VARIABLES=ACS_SP_scale_post_minus_pre
  /PLOT NONE
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

*Nonparametric Tests: Related Samples. 
NPTESTS 
  /RELATED TEST(ACS_SP_scale_pre ACS_SP_scale_post) 
  /MISSING SCOPE=ANALYSIS USERMISSING=EXCLUDE
  /CRITERIA ALPHA=0.05  CILEVEL=95.

T-TEST PAIRS=ACS_SP_scale_pre      Triangles_total_pre WITH 
                         ACS_SP_scale_post     Triangles_total_post (PAIRED)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

T-TEST PAIRS=Triangles_total_pre      Tri_accuracy_pre      Tri_attribution_pre              ACS_SP_scale_pre        AffectName_scale_pre        Prosody_scale_pre        Pairs_scale_pre       WITH 
                         Triangles_total_post     Tri_accuracy_post     Tri_attribution_post            ACS_SP_scale_post      AffectName_scale_post      Prosody_scale_post       Pairs_scale_post (PAIRED)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.


GLM Triangles_total_post_minus_pre Tri_accuracy_post_minus_pre ACS_SP_scale_post_minus_pre PSC_nonaggr_BIO_gt_SCR_post_minus_pre 
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /EMMEANS=TABLES(OVERALL) 
  /CRITERIA=ALPHA(.05)
  /DESIGN=.

CORRELATIONS
  /VARIABLES=PSC_aggr_BIO_gt_SCR_neural_predictor_ACS_SP_Z1.645
                       PSC_aggr_BIO_gt_SCR_neural_predictor_ACS_SP_Z2.33
                       SRS2_Self_Total_Raw
                       Age_PreScan
                       FSIQ
                       Triangles_total_pre
                       ACS_SP_scale_pre
                        Site_coding
                       ACS_SP_scale_post_minus_pre
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

*It is driven by IU0145.
CORRELATIONS
  /VARIABLES=headmotion_pre_rel_mean
                        headmotion_pre_rel_SD
                        headmotion_post_rel_mean
                        headmotion_post_rel_SD
                       ACS_SP_scale_post_minus_pre
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

GRAPH
  /SCATTERPLOT(BIVAR)=PSC_aggr_BIO_gt_SCR_neural_predictor_ACS_SP_Z1.645 WITH ACS_SP_scale_post_minus_pre
  /MISSING=LISTWISE.

GRAPH
  /SCATTERPLOT(BIVAR)=PSC_aggr_BIO_gt_SCR_neural_predictor_ACS_SP_Z2.33 WITH ACS_SP_scale_post_minus_pre
  /MISSING=LISTWISE.

CORRELATIONS
  /VARIABLES=Age_prescan FSIQ PSC_aggr_BIO_gt_SCR_neural_predictor_ACS_SP_Z1.645 PSC_aggr_BIO_gt_SCR_neural_predictor_ACS_SP_Z2.33
    ACS_SP_scale_pre ACS_SP_scale_post AffectName_scale_pre 
    AffectName_scale_post Prosody_scale_pre Prosody_scale_post Pairs_scale_pre Pairs_scale_post 
    Triangles_total_pre Triangles_total_post Tri_accuracy_pre Tri_accuracy_post Tri_attribution_pre 
    Tri_attribution_post PSC_nonaggr_BIO_gt_SCR_pre PSC_nonaggr_BIO_gt_SCR_post 
    PSC_nonaggr_BIO_gt_SCR_post_minus_pre
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.





