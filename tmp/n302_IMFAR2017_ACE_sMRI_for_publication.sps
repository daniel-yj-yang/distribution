* Encoding: UTF-8.
OUTPUT CLOSE *.
DATASET CLOSE ALL.

GET FILE='/Users/Daniel/MyDropbox/My-Manuscripts/with-Myself/ACE_girls_language/02-August-2016/processed_data/SPSS/n302.sav'.

COMPUTE male=0.
DO IF (Sex='M').
    COMPUTE male=1.
END IF.

****************************************************************************************************************************************************************************************.
*Diagnosis coding for FreeSurfer.
NUMERIC ASD_Diagnosis (F1.0).
COMPUTE ASD_Diagnosis=-1.
DO IF (Dx = 'ASD').
    COMPUTE ASD_Diagnosis=1.
END IF.
DO IF (Dx = 'CON').
    COMPUTE ASD_Diagnosis=0.
END IF.


NUMERIC Gender_Male (F1.0).
COMPUTE Gender_Male=-1.
DO IF (Sex = 'F').
    COMPUTE Gender_Male=0.
END IF.
DO IF (Sex = 'M').
    COMPUTE Gender_Male=1.
END IF.
****************************************************************************************************************************************************************************************.

****************************************************************************************************************************************************************************************.
*Group coding for FSL/FEAT.
NUMERIC F_ASD(F1.0).
NUMERIC M_ASD(F1.0).
NUMERIC F_CON(F1.0).
NUMERIC M_CON(F1.0).
NUMERIC F_SIB(F1.0).
NUMERIC M_SIB(F1.0).
COMPUTE F_ASD=0.
COMPUTE M_ASD=0.
COMPUTE F_CON=0.
COMPUTE M_CON=0.
COMPUTE F_SIB=0.
COMPUTE M_SIB=0.
DO IF (Sex = 'F') and (Dx = 'ASD').
    COMPUTE F_ASD=1.
END IF.
DO IF (Sex = 'M') and (Dx = 'ASD').
    COMPUTE M_ASD=1.
END IF.
DO IF (Sex = 'F') and (Dx = 'CON').
    COMPUTE F_CON=1.
END IF.
DO IF (Sex = 'M') and (Dx = 'CON').
    COMPUTE M_CON=1.
END IF.
DO IF (Sex = 'F') and (Dx = 'SIB').
    COMPUTE F_SIB=1.
END IF.
DO IF (Sex = 'M') and (Dx = 'SIB').
    COMPUTE M_SIB=1.
END IF.
****************************************************************************************************************************************************************************************.

****************************************************************************************************************************************************************************************.
*Site coding for FSL/FEAT.
NUMERIC Site1(F1.0).
NUMERIC Site2(F1.0).
NUMERIC Site3(F1.0).
NUMERIC Site4(F1.0).
COMPUTE Site1=0.
COMPUTE Site2=0.
COMPUTE Site3=0.
COMPUTE Site4=0.
DO IF (FiveSites = 'HAR').
    COMPUTE Site1=1.
END IF.
DO IF (FiveSites = 'SCR-Prisma').
    COMPUTE Site2=1.
END IF.
DO IF (FiveSites = 'SCR-TimTrio').
    COMPUTE Site3=1.
END IF.
DO IF (FiveSites = 'UCL').
    COMPUTE Site4=1.
END IF.
DO IF (FiveSites = 'YAL').
    COMPUTE Site1=-1.
    COMPUTE Site2=-1.
    COMPUTE Site3=-1.
    COMPUTE Site4=-1.
END IF.
****************************************************************************************************************************************************************************************.

SELECT IF not (Status = 'EXCLUDE').

DO IF (Dx = 'ASD').
   DO IF not SYSMIS(ADOS_CSS).
      SELECT IF (ADOS_CSS > 3).
   END IF.
   DO IF not SYSMIS(ADOS_Mod4_CSS).
      SELECT IF (ADOS_Mod4_CSS > 3).
      COMPUTE Meets_ADOS_current = 'yes'.
   END IF.
   DO IF (ADOS_Module = '4').
       COMPUTE ADOS_CSS = ADOS_Mod4_CSS.
    END IF. 
END IF.

DO IF (Dx = 'CON').
   DO IF not SYSMIS(SRS2_total_t).
      SELECT IF (SRS2_total_t <= 59). /* 59T and below -- within normal limits.
   END IF.
END IF.

DO IF (Dx = 'SIB').
   DO IF not SYSMIS(SRS2_total_t).
      SELECT IF (SRS2_total_t < 76). /* 76T or higher: severe range.
   END IF.
END IF.

DO IF (Dx = 'SIB').
    DO IF not (Meets_ADI_R_current = '.').
        SELECT IF (Meets_ADI_R_current = 'no').
    END IF.
    DO IF not (Meets_ADOS_current = '.').
        SELECT IF (Meets_ADOS_current = 'no').
    END IF.
END IF.

*SELECT IF (Dx = 'ASD') or (Dx = 'CON').

SELECT IF not SYSMIS(IQGCA).
SELECT IF not SYSMIS(VerbalIQ).
SELECT IF (IQGCA >= 75).
SELECT IF (VerbalIQ >=70).

*Excluding motion outlier.
*SELECT IF (headmotion_abs <= 2).
*SELECT IF (headmotion_rel <= 0.44).

*Family withdrew.
SELECT IF not (Site_ID = 'YAL21603').

*Coverage issue.
*SELECT IF not (Site_ID = 'HAR34503').
*SELECT IF not (Site_ID = 'HAR38903').
*SELECT IF not (Site_ID = 'HAR34703').
*SELECT IF not (Site_ID = 'YAL12204').
*SELECT IF not (Site_ID = 'YAL11203').

*High IQ M ASD participant in SCR. *remove to make IQ comparable across sites.
*SELECT IF not (Site_ID = 'SCR76203').

*match on ADIR_RRB, ADOS_CSS, and sample size between F ASD and M ASD.
*SELECT IF not (Site_ID = 'UCL51503'). /*ADIR_RRB = 12, ADOS CSS = 6, M ASD, rel head motion = .3570590.
*SELECT IF not (Site_ID = 'UCL50803'). /*ADIR_RRB = 10, ADOS CSS = 9, M ASD, rel head motion = .0640080.
*SELECT IF not (Site_ID = 'YAL22704'). /*ADIR RRB = 9, ADOS CSS = 10, M ASD, rel head motion = .1319460.
*SELECT IF not (Site_ID = 'SCR70003'). /*ADIR_RRB = 11, ADOS CSS = 7, M ASD, rel head motion = .0846576.
*SELECT IF not (Site_ID = 'UCL51803'). /*ADIR_RRB = 10, ADOS CSS = 8, M ASD, rel head motion = .0933276. 

*FreeSurfer v6.0.0 exited with ERRORS.
SELECT IF not (Site_ID = 'SCR71103').
SELECT IF not (Site_ID = 'YAL10803').
SELECT IF not (Site_ID = 'YAL12703').
SELECT IF not (Site_ID = 'YAL12804').

EXECUTE.

*COMPUTE sMRI_hm = sMRI_headmotion / 100000.
*SELECT IF (sMRI_hm > 150).

SORT CASES BY Dx(A) Sex(A) FiveSites(A).

SAVE OUTFILE= '/tmp/overall.zsav'.

****************************************************************************************************************************************************************************************.
*For IMFAR 2017 submission.
GET FILE='/tmp/overall.zsav'.
DATASET NAME IMFAR2017.
DATASET ACTIVATE IMFAR2017.

SELECT IF (Dx = 'ASD') or (Dx = 'CON').
SELECT IF not ( (Sebiha_sMRI_head_motion = 1) AND (Daniel_sMRI_head_motion = 1) ).
EXECUTE.



DESCRIPTIVES VARIABLES=age_of_scan_accurate SPM12_ICV IQGCA
  /SAVE
  /STATISTICS=MEAN STDDEV MIN MAX.

RENAME VARIABLES (Zage_of_scan_accurate = ZAge).
RENAME VARIABLES (Site_ID = fsid).
COMPUTE ZAge2 = ZAge * ZAge.
FORMATS ZAge (F12.9) ZAge2 (F12.9) ZSPM12_ICV (F12.9) ZIQGCA (F12.9).
EXECUTE.


*Save as Excel for FSL.
SAVE TRANSLATE OUTFILE='/Users/Daniel/tmp/ACE_IMFAR2017_sMRI.xlsx'
  /TYPE=XLS
  /VERSION=12
  /MAP
  /FIELDNAMES VALUE=NAMES
  /CELLS=VALUES
  /EXCELOPTIONS SHEET='Sheet1'
  /REPLACE
  /KEEP=
    fsid
    Dx
    Sex
    ZAge
    ZAge2
    ZSPM12_ICV.
EXECUTE.
SAVE OUTFILE='/Users/Daniel/tmp/ACE_IMFAR2017_sMRI_both_male_and_female.sav'.



*Save as tab-delimited text for FreeSurfer script.
DATASET CLOSE ALL.
EXECUTE.
GET FILE='/Users/Daniel/tmp/ACE_IMFAR2017_sMRI_both_male_and_female.sav'.
DATASET NAME all_data.
DATASET ACTIVATE all_data.
STRING text1 (A5).
STRING text2 (A4).
COMPUTE text1="Input".
COMPUTE text2="Main".
EXECUTE.
NUMERIC Dx_x_age (F12.9).
COMPUTE Dx_x_age=ASD_Diagnosis*ZAge.
SORT CASES BY Sex(A).
SELECT IF Sex='M'.
SAVE TRANSLATE OUTFILE='/Users/Daniel/tmp/ACE_IMFAR2017_sMRI_male.txt'
  /TYPE=TAB
  /MAP
  /REPLACE
  /FIELDNAMES
  /CELLS=VALUES
  /KEEP text1 fsid text2 Dx age_of_scan_accurate ASD_Diagnosis ZAge Dx_x_age Site1 Site2 Site3 Site4 ZIQGCA ZSPM12_ICV.
EXECUTE.


*Save as tab-delimited text for FreeSurfer script.
DATASET CLOSE ALL.
EXECUTE.
GET FILE='/Users/Daniel/tmp/ACE_IMFAR2017_sMRI_both_male_and_female.sav'.
DATASET NAME all_data.
DATASET ACTIVATE all_data.
STRING text1 (A5).
STRING text2 (A4).
COMPUTE text1="Input".
COMPUTE text2="Main".
EXECUTE.
NUMERIC Dx_x_age (F12.9).
COMPUTE Dx_x_age=ASD_Diagnosis*ZAge.
SORT CASES BY Sex(A).
SELECT IF Sex='F'.
SAVE TRANSLATE OUTFILE='/Users/Daniel/tmp/ACE_IMFAR2017_sMRI_female.txt'
  /TYPE=TAB
  /MAP
  /REPLACE
  /FIELDNAMES
  /CELLS=VALUES
  /KEEP text1 fsid text2 ASD_Diagnosis ZAge Dx_x_age Site1 Site2 Site3 Site4 ZIQGCA ZSPM12_ICV.
EXECUTE.



*Save as tab-delimited text for FreeSurfer script.
DATASET CLOSE ALL.
EXECUTE.
GET FILE='/Users/Daniel/tmp/ACE_IMFAR2017_sMRI_both_male_and_female.sav'.
DATASET NAME all_data.
DATASET ACTIVATE all_data.
STRING text1 (A5).
STRING text2 (A4).
COMPUTE text1="Input".
COMPUTE text2="Main".
EXECUTE.
NUMERIC Male_x_age (F12.9).
COMPUTE Male_x_age=Gender_Male*ZAge.
SORT CASES BY Sex(A).
SELECT IF Dx='CON'.
SAVE TRANSLATE OUTFILE='/Users/Daniel/tmp/ACE_IMFAR2017_sMRI_TD.txt'
  /TYPE=TAB
  /MAP
  /REPLACE
  /FIELDNAMES
  /CELLS=VALUES
  /KEEP text1 fsid text2 Gender_Male age_of_scan_accurate ZAge Male_x_age Site1 Site2 Site3 Site4 ZIQGCA ZSPM12_ICV.
EXECUTE.


DATASET CLOSE ALL.
EXECUTE.
GET FILE='/Users/Daniel/tmp/ACE_IMFAR2017_sMRI_both_male_and_female.sav'.
DATASET NAME all_data.
DATASET ACTIVATE all_data.
STRING text1 (A5).
STRING text2 (A4).
COMPUTE text1="Input".
COMPUTE text2="Main".
EXECUTE.
*y (cortical thickness) = (1) intercept + (2) Dx + (3) Gender + (4) Age + (5) Dx*Gender + (6) Dx*Age + (7) Gender*Age + (8) Dx*Gender*Age + (9) Age^2 + (10) Dx*Age^2 + (11) Gender*Age^2 + (12) Dx*Gender*Age^2 + (13) error term.
* (5) Dx*Gender.
NUMERIC DX_x_Gender (F12.9).
COMPUTE DX_x_Gender=ASD_Diagnosis*Gender_Male.
* (6) Dx*Age.
NUMERIC DX_x_Age (F12.9).
COMPUTE DX_x_Age=ASD_Diagnosis*ZAge.
* (7) Gender*Age.
NUMERIC Gender_x_Age (F12.9).
COMPUTE Gender_x_Age=Gender_Male*ZAge.
* (8) Dx*Gender*Age.
NUMERIC Dx_x_Gender_x_Age (F12.9).
COMPUTE Dx_x_Gender_x_Age=ASD_Diagnosis*Gender_Male*ZAge.
* (9) Age^2.
NUMERIC ZAge2 (F12.9).
COMPUTE Age2=ZAge*ZAge.
* (10) Dx*Age^2.
NUMERIC DX_x_Age2 (F12.9).
COMPUTE DX_x_Age2=ASD_Diagnosis*Age2.
* (11) Gender*Age^2.
NUMERIC Gender_x_Age2 (F12.9).
COMPUTE Gender_x_Age2=Gender_Male*Age2.
* (12) Dx*Gender*Age^2.
NUMERIC Dx_x_Gender_x_Age2 (F12.9).
COMPUTE Dx_x_Gender_x_Age2=ASD_Diagnosis*Gender_Male*Age2.
*y (cortical thickness) = (1) intercept + (2) Dx + (3) Gender + (4) Age + (5) Dx*Gender + (6) Dx*Age + (7) Gender*Age + (8) Dx*Gender*Age + (9) Age^2 + (10) Dx*Age^2 + (11) Gender*Age^2 + (12) Dx*Gender*Age^2 + (13) error term.
SORT CASES BY Sex(A).
SAVE TRANSLATE OUTFILE='/Users/Daniel/tmp/ACE_IMFAR2017_sMRI_all_participants_TD_and_ASD.txt'
  /TYPE=TAB
  /MAP
  /REPLACE
  /FIELDNAMES
  /CELLS=VALUES
  /KEEP text1 fsid text2 
ASD_Diagnosis Gender_Male ZAge 
Dx_x_Gender DX_x_Age Gender_x_Age Dx_x_Gender_x_Age
Age2 Dx_x_Age2 Gender_x_Age2 Dx_x_Gender_x_Age2
Site1 Site2 Site3 Site4 ZIQGCA ZSPM12_ICV.
EXECUTE.

SAVE TRANSLATE OUTFILE='/Users/Daniel/tmp/ACE_IMFAR2017_sMRI_all_participants_TD_and_ASD_without_Age2.txt'
  /TYPE=TAB
  /MAP
  /REPLACE
  /FIELDNAMES
  /CELLS=VALUES
  /KEEP text1 fsid text2 
ASD_Diagnosis Gender_Male ZAge 
Dx_x_Gender DX_x_Age Gender_x_Age Dx_x_Gender_x_Age
Site1 Site2 Site3 Site4 ZIQGCA ZSPM12_ICV.
EXECUTE.


DATASET ACTIVATE all_data.
CROSSTABS
  /TABLES=Dx BY Sex
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT
  /COUNT ROUND CELL.
